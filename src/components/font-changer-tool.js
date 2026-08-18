/**
 * Font Changer Tool — Reusable UI component
 *
 * This is the ONE reusable Font Changer tool used by ALL SEO pages.
 * It uses FontChangerEngine for all text transformations.
 * The tool works entirely client-side after page load.
 */

(function () {
  'use strict';

  // ── Dependencies ──────────────────────────────────────────────
  // FontChangerEngine must be loaded before this script.
  // It's an IIFE attached to window.FontChangerEngine.
  const Engine = (typeof window !== 'undefined' && window.FontChangerEngine) || null;

  if (!Engine) {
    console.warn('[FontChangerTool] FontChangerEngine not loaded');
    return;
  }

  // ── DOM refs (set after DOMContentLoaded) ────────────────────
  let inputEl, outputContainer, copyAllBtn, clearBtn, copyButtons = [];
  let outputCountEl, statsEl;

  // ── State ─────────────────────────────────────────────────────
  let currentText = '';
  let debounceTimer = null;

  // ── Init ──────────────────────────────────────────────────────
  function init() {
    inputEl = document.getElementById('font-input');
    outputContainer = document.getElementById('font-outputs');
    copyAllBtn = document.getElementById('copy-all-btn');
    clearBtn = document.getElementById('clear-btn');
    outputCountEl = document.getElementById('output-count');
    statsEl = document.getElementById('stats');

    if (!inputEl || !outputContainer) return;

    copyButtons = outputContainer.querySelectorAll('.copy-btn');

    // Event listeners
    inputEl.addEventListener('input', onInput);
    copyAllBtn.addEventListener('click', onCopyAll);
    clearBtn.addEventListener('click', onClear);
    copyButtons.forEach(btn => {
      btn.addEventListener('click', onCopySingle);
    });

    // Initial generation
    generate();
  }

  // ── Input handler with debounce ──────────────────────────────
  function onInput() {
    currentText = inputEl.value;
    updateCharCount();

    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(generate, 150);
  }

  function updateCharCount() {
    const len = currentText.length;
    if (outputCountEl) {
      outputCountEl.textContent = len > 0 ? len : '0';
    }
  }

  // ── Generate all styles ───────────────────────────────────────
  function generate() {
    const text = currentText;
    if (!text) {
      // Show placeholder
      outputContainer.innerHTML = '' +
        '<div class="font-output-placeholder">' +
          'Type something above to see all font styles' +
        '</div>';
      if (statsEl) statsEl.textContent = '';
      updateCopyButtons([]);
      return;
    }

    const results = Engine.applyAll(text);
    const styles = Engine.getStyles();

    let html = '';
    for (const style of styles) {
      const styled = results[style.id] || text;
      const displayText = Engine.sanitizeText(styled.length > 120 ? styled.slice(0, 120) + '\u2026' : styled);
      html += '' +
        '<div class="font-output-item" data-style="' + style.id + '">' +
          '<div class="font-output-header">' +
            '<span class="font-output-label">' + Engine.sanitizeText(style.label) + '</span>' +
            '<button class="copy-btn" data-target="' + style.id + '" aria-label="Copy ' + Engine.sanitizeText(style.label) + ' text">' +
              '<svg class="copy-icon" viewBox="0 0 24 24" width="16" height="16" aria-hidden="true">' +
                '<path d="M16 1H4c-1.1 0-2 .9-2 2v14h2V3h12V1zm3 4H8c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h11c1.1 0 2-.9 2-2V7c0-1.1-.9-2-2-2zm0 16H8V7h11v14z" fill="currentColor"/>' +
              '</svg>' +
              '<span class="copy-btn-text">Copy</span>' +
            '</button>' +
          '</div>' +
          '<div class="font-output-text">' + displayText + '</div>' +
        '</div>';
    }

    outputContainer.innerHTML = html;

    // Re-bind copy buttons
    const newBtns = outputContainer.querySelectorAll('.copy-btn');
    newBtns.forEach(btn => {
      btn.addEventListener('click', onCopySingle);
    });
    copyButtons = newBtns;

    if (statsEl) {
      const generated = Object.keys(results).filter(k => results[k] !== text).length;
      statsEl.textContent = generated + ' styles generated';
    }
  }

  // ── Copy single ───────────────────────────────────────────────
  async function onCopySingle(e) {
    const btn = e.currentTarget;
    const styleId = btn.dataset.target;
    const result = Engine.apply(currentText, styleId);
    if (!result) return;

    const originalText = btn.querySelector('.copy-btn-text');
    const originalIcon = btn.querySelector('.copy-icon');

    // Visual feedback
    btn.disabled = true;
    btn.classList.add('copying');
    if (originalText) originalText.textContent = 'Copied!';
    if (originalIcon) {
      originalIcon.innerHTML = '<path d="M9 16.2L4.8 12l-1.4 1.4L9 19 21 7l-1.4-1.4L9 16.2z" fill="currentColor"/>';
    }

    const ok = await Engine.copyToClipboard(result);

    setTimeout(() => {
      btn.disabled = false;
      btn.classList.remove('copying');
      if (originalText) originalText.textContent = 'Copy';
      if (originalIcon) {
        originalIcon.innerHTML = '<path d="M16 1H4c-1.1 0-2 .9-2 2v14h2V3h12V1zm3 4H8c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h11c1.1 0 2-.9 2-2V7c0-1.1-.9-2-2-2zm0 16H8V7h11v14z" fill="currentColor"/>';
      }
    }, 1200);

    // Analytics event
    if (typeof window.dataLayer !== 'undefined') {
      window.dataLayer.push({
        event: 'font_copied',
        style: styleId,
        textLength: currentText.length,
      });
    }
  }

  // ── Copy all ───────────────────────────────────────────────────
  async function onCopyAll() {
    if (!currentText) return;

    // Build multiline output: style label + text for each style
    const results = Engine.applyAll(currentText);
    const styles = Engine.getStyles();
    const lines = [];
    for (const style of styles) {
      const styled = results[style.id] || style.label + ': ' + currentText;
      lines.push(styled);
    }
    const allText = lines.join('\n\n---\n\n');

    const originalText = copyAllBtn.querySelector('.copy-all-text');
    copyAllBtn.disabled = true;
    if (originalText) originalText.textContent = 'Copied All!';

    const ok = await Engine.copyToClipboard(allText);

    setTimeout(() => {
      copyAllBtn.disabled = false;
      if (originalText) originalText.textContent = 'Copy All';
    }, 1200);

    if (typeof window.dataLayer !== 'undefined') {
      window.dataLayer.push({
        event: 'copy_all',
        count: styles.length,
        textLength: currentText.length,
      });
    }
  }

  // ── Clear ─────────────────────────────────────────────────────
  function onClear() {
    if (inputEl) inputEl.value = '';
    currentText = '';
    updateCharCount();
    generate();
    inputEl.focus();
  }

  // ── Boot ──────────────────────────────────────────────────────
  if (typeof document !== 'undefined') {
    document.addEventListener('DOMContentLoaded', init);
  }
})();
