/**
 * Font Changer Tool Engine
 * Client-side Unicode text style transformations.
 * Works entirely in the browser — no server calls for text transformation.
 *
 * Supported styles: Bold, Italic, Bold Italic, Cursive, Double Struck,
 * Fraktur, Monospace, Fullwidth, Small Caps, Bubble, Superscript, Subscript,
 * Circled, Squared, Underline, Strike, Glitch-style
 */

const FontChangerEngine = (() => {
  'use strict';

  // Mapping tables for Unicode character transformations.
  // Each map: ASCII char -> styled Unicode char(s).
  // Characters not in the table pass through unchanged.

  const MAPS = {
    // Bold — U+1D400..U+1D419 (Mathematical Bold)
    bold: {
      a: '\u1D41A', b: '\u1D41B', c: '\u1D41C', d: '\u1D41D', e: '\u1D41E',
      f: '\u1D41F', g: '\u1D420', h: '\u1D421', i: '\u1D422', j: '\u1D423',
      k: '\u1D424', l: '\u1D425', m: '\u1D426', n: '\u1D427', o: '\u1D428',
      p: '\u1D429', q: '\u1D42A', r: '\u1D42B', s: '\u1D42C', t: '\u1D42D',
      u: '\u1D42E', v: '\u1D42F', w: '\u1D430', x: '\u1D431', y: '\u1D432',
      z: '\u1D433',
      A: '\u1D400', B: '\u1D401', C: '\u1D402', D: '\u1D403', E: '\u1D404',
      F: '\u1D405', G: '\u1D406', H: '\u1D407', I: '\u1D408', J: '\u1D409',
      K: '\u1D40A', L: '\u1D40B', M: '\u1D40C', N: '\u1D40D', O: '\u1D40E',
      P: '\u1D40F', Q: '\u1D410', R: '\u1D411', S: '\u1D412', T: '\u1D413',
      U: '\u1D414', V: '\u1D415', W: '\u1D416', X: '\u1D417', Y: '\u1D418',
      Z: '\u1D419',
    },

    // Italic — U+1D434..U+1D44D (Mathematical Italic)
    italic: {
      a: '\u1D434', b: '\u1D435', c: '\u1D436', d: '\u1D437', e: '\u1D438',
      f: '\u1D439', g: '\u1D43A', h: '\u1D43B', i: '\u1D43C', j: '\u1D43D',
      k: '\u1D43E', l: '\u1D43F', m: '\u1D440', n: '\u1D441', o: '\u1D442',
      p: '\u1D443', q: '\u1D444', r: '\u1D445', s: '\u1D446', t: '\u1D447',
      u: '\u1D448', v: '\u1D449', w: '\u1D44A', x: '\u1D44B', y: '\u1D44C',
      z: '\u1D44D',
      A: '\u1D44E', B: '\u1D44F', C: '\u1D450', D: '\u1D451', E: '\u1D452',
      F: '\u1D453', G: '\u1D454', H: '\u1D455', I: '\u1D456', J: '\u1D457',
      K: '\u1D458', L: '\u1D459', M: '\u1D45A', N: '\u1D45B', O: '\u1D45C',
      P: '\u1D45D', Q: '\u1D45E', R: '\u1D45F', S: '\u1D460', T: '\u1D461',
      U: '\u1D462', V: '\u1D463', W: '\u1D464', X: '\u1D465', Y: '\u1D466',
      Z: '\u1D467',
    },

    // Bold Italic — U+1D468..U+1D481
    boldItalic: {
      a: '\u1D468', b: '\u1D469', c: '\u1D46A', d: '\u1D46B', e: '\u1D46C',
      f: '\u1D46D', g: '\u1D46E', h: '\u1D46F', i: '\u1D470', j: '\u1D471',
      k: '\u1D472', l: '\u1D473', m: '\u1D474', n: '\u1D475', o: '\u1D476',
      p: '\u1D477', q: '\u1D478', r: '\u1D479', s: '\u1D47A', t: '\u1D47B',
      u: '\u1D47C', v: '\u1D47D', w: '\u1D47E', x: '\u1D47F', y: '\u1D480',
      z: '\u1D481',
      A: '\u1D482', B: '\u1D483', C: '\u1D484', D: '\u1D485', E: '\u1D486',
      F: '\u1D487', G: '\u1D488', H: '\u1D489', I: '\u1D48A', J: '\u1D48B',
      K: '\u1D48C', L: '\u1D48D', M: '\u1D48E', N: '\u1D48F', O: '\u1D490',
      P: '\u1D491', Q: '\u1D492', R: '\u1D493', S: '\u1D494', T: '\u1D495',
      U: '\u1D496', V: '\u1D497', W: '\u1D498', X: '\u1D499', Y: '\u1D49A',
      Z: '\u1D49B',
    },

    // Script / Cursive — U+1D49C..U+1D4B5 (Mathematical Script)
    script: {
      a: '\u1D49C', b: '\u1D49D', c: '\u1D49E', d: '\u1D49F', e: '\u1D4A0',
      f: '\u1D4A1', g: '\u1D4A2', h: '\u1D4A3', i: '\u1D4A4', j: '\u1D4A5',
      k: '\u1D4A6', l: '\u1D4A7', m: '\u1D4A8', n: '\u1D4A9', o: '\u1D4AA',
      p: '\u1D4AB', q: '\u1D4AC', r: '\u1D4AD', s: '\u1D4AE', t: '\u1D4AF',
      u: '\u1D4B0', v: '\u1D4B1', w: '\u1D4B2', x: '\u1D4B3', y: '\u1D4B4',
      z: '\u1D4B5',
      B: '\u1D4B6', C: '\u1D4B7', D: '\u1D4B8', E: '\u1D4B9', F: '\u1D4BA',
      G: '\u1D4BB', H: '\u1D4BC', I: '\u1D4BD', J: '\u1D4BE', K: '\u1D4BF',
      L: '\u1D4C0', M: '\u1D4C1', N: '\u1D4C2', O: '\u1D4C3', P: '\u1D4C4',
      Q: '\u1D4C5', R: '\u1D4C6', S: '\u1D4C7', T: '\u1D4C8', U: '\u1D4C9',
      V: '\u1D4CA', W: '\u1D4CB', X: '\u1D4CC', Y: '\u1D4CD', Z: '\u1D4CE',
    },

    // Double Struck — U+1D538..U+1D551 (Mathematical Double-Struck)
    doubleStruck: {
      A: '\u1D538', B: '\u1D51E', C: '\u1D520', D: '\u1D522', E: '\u1D524',
      F: '\u1D526', G: '\u1D528', H: '\u1D52A', I: '\u1D52C', J: '\u1D52E',
      K: '\u1D530', L: '\u1D532', M: '\u1D534', N: '\u1D536', O: '\u1D538',
      P: '\u1D53A', Q: '\u1D53C', R: '\u1D53E', S: '\u1D540', T: '\u1D542',
      U: '\u1D544', V: '\u1D546', W: '\u1D548', X: '\u1D54A', Y: '\u1D54C',
      Z: '\u1D54E',
    },

    // Fraktur — U+1D504..U+1D51B (Mathematical Fraktur)
    fraktur: {
      a: '\u1D504', b: '\u1D505', c: '\u1D506', d: '\u1D507', e: '\u1D508',
      f: '\u1D509', g: '\u1D50A', h: '\u1D50B', i: '\u1D50C', j: '\u1D50D',
      k: '\u1D50E', l: '\u1D50F', m: '\u1D510', n: '\u1D511', o: '\u1D512',
      p: '\u1D513', q: '\u1D514', r: '\u1D515', s: '\u1D516', t: '\u1D517',
      u: '\u1D518', v: '\u1D519', w: '\u1D51A', x: '\u1D51B',
      A: '\u1D534', B: '\u1D500', C: '\u1D501', D: '\u1D502', E: '\u1D503',
      F: '\u1D504', G: '\u1D505', H: '\u1D506', I: '\u1D507', J: '\u1D508',
      K: '\u1D509', L: '\u1D50A', M: '\u1D50B', N: '\u1D50C', O: '\u1D50D',
      P: '\u1D50E', Q: '\u1D50F', R: '\u1D510', S: '\u1D511', T: '\u1D512',
      U: '\u1D513', V: '\u1D514', W: '\u1D515', X: '\u1D516', Y: '\u1D517',
      Z: '\u1D518',
    },

    // Monospace — U+1D670..U+1D689 (Mathematical Monospace)
    monospace: {
      a: '\u1D670', b: '\u1D671', c: '\u1D672', d: '\u1D673', e: '\u1D674',
      f: '\u1D675', g: '\u1D676', h: '\u1D677', i: '\u1D678', j: '\u1D679',
      k: '\u1D67A', l: '\u1D67B', m: '\u1D67C', n: '\u1D67D', o: '\u1D67E',
      p: '\u1D67F', q: '\u1D680', r: '\u1D681', s: '\u1D682', t: '\u1D683',
      u: '\u1D684', v: '\u1D685', w: '\u1D686', x: '\u1D687', y: '\u1D688',
      z: '\u1D689',
      A: '\u1D670', B: '\u1D671', C: '\u1D672', D: '\u1D673', E: '\u1D674',
      F: '\u1D675', G: '\u1D676', H: '\u1D677', I: '\u1D678', J: '\u1D679',
      K: '\u1D67A', L: '\u1D67B', M: '\u1D67C', N: '\u1D67D', O: '\u1D67E',
      P: '\u1D67F', Q: '\u1D680', R: '\u1D681', S: '\u1D682', T: '\u1D683',
      U: '\u1D684', V: '\u1D685', W: '\u1D686', X: '\u1D687', Y: '\u1D688',
      Z: '\u1D689',
    },

    // Fullwidth — U+FF21..U+FF3A (Fullwidth Latin)
    fullwidth: {
      a: '\uFF41', b: '\uFF42', c: '\uFF43', d: '\uFF44', e: '\uFF45',
      f: '\uFF46', g: '\uFF47', h: '\uFF48', i: '\uFF49', j: '\uFF4A',
      k: '\uFF4B', l: '\uFF4C', m: '\uFF4D', n: '\uFF4E', o: '\uFF4F',
      p: '\uFF50', q: '\uFF51', r: '\uFF52', s: '\uFF53', t: '\uFF54',
      u: '\uFF55', v: '\uFF56', w: '\uFF57', x: '\uFF58', y: '\uFF59',
      z: '\uFF5A',
      A: '\uFF21', B: '\uFF22', C: '\uFF23', D: '\uFF24', E: '\uFF25',
      F: '\uFF26', G: '\uFF27', H: '\uFF28', I: '\uFF29', J: '\uFF2A',
      K: '\uFF2B', L: '\uFF2C', M: '\uFF2D', N: '\uFF2E', O: '\uFF2F',
      P: '\uFF30', Q: '\uFF31', R: '\uFF32', S: '\uFF33', T: '\uFF34',
      U: '\uFF35', V: '\uFF36', W: '\uFF37', X: '\uFF38', Y: '\uFF39',
      Z: '\uFF3A',
      '0': '\uFF10', '1': '\uFF11', '2': '\uFF12', '3': '\uFF13', '4': '\uFF14',
      '5': '\uFF15', '6': '\uFF16', '7': '\uFF17', '8': '\uFF18', '9': '\uFF19',
    },

    // Small Caps — U+1D00..U+1D2F (Latin Extended-D Small Caps)
    smallCaps: {
      a: '\u0061', // fallback — transform via CSS class approach
      b: '\u0299', c: '\u029B', d: '\u1D04', e: '\u026A', f: '\u0299',
      g: '\u026A', h: '\u026A', i: '\u026A', j: '\u026A', k: '\u1D0B',
      l: '\u026A', m: '\u026A', n: '\u026A', o: '\u026A', p: '\u1D0D',
      q: '\u1D1C', r: '\u0294', s: '\u029B', t: '\u1D19', u: '\u026A',
      v: '\u1D1B', w: '\u1D20', x: '\u1D21', y: '\u1D22', z: '\u1D23',
      A: '\u0250', B: '\u0299', C: '\u029B', D: '\u1D04', E: '\u0250',
      F: '\u0250', G: '\u0250', H: '\u026A', I: '\u026A', J: '\u026A',
      K: '\u1D0B', L: '\u026A', M: '\u026A', N: '\u026A', O: '\u026A',
      P: '\u1D0D', Q: '\u1D1C', R: '\u0294', S: '\u029B', T: '\u1D19',
      U: '\u026A', V: '\u1D1B', W: '\u1D20', X: '\u1D21', Y: '\u1D22',
      Z: '\u1D23',
    },

    // Bubble / Enclosed alphanumerics (used as "rounded" style)
    // U+24B6..U+24E9 circled latin uppercase, U+24D0..U+24E9 for lowercase
    bubble: {
      A: '\u24B6', B: '\u24B7', C: '\u24B8', D: '\u24B9', E: '\u24BA',
      F: '\u24BB', G: '\u24BC', H: '\u24BD', I: '\u24BE', J: '\u24BF',
      K: '\u24C0', L: '\u24C1', M: '\u24C2', N: '\u24C3', O: '\u24C4',
      P: '\u24C5', Q: '\u24C6', R: '\u24C7', S: '\u24C8', T: '\u24C9',
      U: '\u24CA', V: '\u24CB', W: '\u24CC', X: '\u24CD', Y: '\u24CE',
      Z: '\u24CF',
    },

    // Squared — U+1F130..U+1F149 (Regional indicator-like squared)
    // Using enclosed alphanumeric squared: U+2460..U+2473 for digits,
    // U+2460 is circled 1... we use U+24B6..U+24CF for squared uppercase
    squared: {
      A: '\u24B6', B: '\u24B7', C: '\u24B8', D: '\u24B9', E: '\u24BA',
      F: '\u24BB', G: '\u24BC', H: '\u24BD', I: '\u24BE', J: '\u24BF',
      K: '\u24C0', L: '\u24C1', M: '\u24C2', N: '\u24C3', O: '\u24C4',
      P: '\u24C5', Q: '\u24C6', R: '\u24C7', S: '\u24C8', T: '\u24C9',
      U: '\u24CA', V: '\u24CB', W: '\u24CC', X: '\u24CD', Y: '\u24CE',
      Z: '\u24CF',
    },

    // Superscript (numbers + some letters)
    superscript: {
      '0': '\u2070', '1': '\u00B9', '2': '\u00B2', '3': '\u00B3', '4': '\u2074',
      '5': '\u2075', '6': '\u2076', '7': '\u2077', '8': '\u2078', '9': '\u2079',
      '+': '\u207A', '-': '\u207B', '=': '\u207C', '(': '\u207D', ')': '\u207E',
      a: '\u1D57', e: '\u2091', i: '\u1D62', o: '\u2092', r: '\u1D58',
      u: '\u1D63', y: '\u1D64',
    },

    // Subscript (numbers)
    subscript: {
      '0': '\u2080', '1': '\u2081', '2': '\u2082', '3': '\u2083', '4': '\u2084',
      '5': '\u2085', '6': '\u2086', '7': '\u2087', '8': '\u2088', '9': '\u2089',
      '+': '\u208A', '-': '\u208B', '=': '\u208C', '(': '\u208D', ')': '\u208E',
      a: '\u2090', e: '\u2091', o: '\u2092', x: '\u2093',
    },

    // Circled — U+2460..U+2473 (circled digits 0-9),
    // U+24F5..U+24F6 (circled latin capitals)
    circled: {
      A: '\u24F5', B: '\u24F6', C: '\u24F7', D: '\u24F8', E: '\u24F9',
      F: '\u2500', G: '\u2501', H: '\u2502', I: '\u2503', J: '\u2504',
      K: '\u2505', L: '\u2506', M: '\u2507', N: '\u2508', O: '\u2509',
      P: '\u250A', Q: '\u250B', R: '\u250C', S: '\u250D', T: '\u250E',
      U: '\u250F', V: '\u2510', W: '\u2511', X: '\u2512', Y: '\u2513',
      Z: '\u2514',
      '0': '\u24EA', '1': '\u2460', '2': '\u2461', '3': '\u2462', '4': '\u2463',
      '5': '\u2464', '6': '\u2465', '7': '\u2466', '8': '\u2467', '9': '\u2468',
    },

    // Strike-through via combining characters (U+0336)
    strike: null, // special handling — see transformStrike()

    // Underline via combining low line (U+0332)
    underline: null, // special handling — see transformUnderline()

    // Glitch-style: random combining marks and replacement chars
    glitch: null, // special handling — see transformGlitch()
  };

  // ── Style metadata ──────────────────────────────────────────────
  const STYLES = [
    { id: 'bold', label: 'Bold', short: 'Bold' },
    { id: 'italic', label: 'Italic', short: 'Italic' },
    { id: 'boldItalic', label: 'Bold Italic', short: 'Bold Italic' },
    { id: 'script', label: 'Cursive / Script', short: 'Cursive' },
    { id: 'doubleStruck', label: 'Double Struck', short: 'Double Struck' },
    { id: 'fraktur', label: 'Fraktur / Gothic', short: 'Fraktur' },
    { id: 'monospace', label: 'Monospace', short: 'Mono' },
    { id: 'fullwidth', label: 'Fullwidth', short: 'Fullwidth' },
    { id: 'smallCaps', label: 'Small Caps', short: 'Small Caps' },
    { id: 'bubble', label: 'Bubble Letters', short: 'Bubble' },
    { id: 'squared', label: 'Squared Letters', short: 'Squared' },
    { id: 'circled', label: 'Circled Letters', short: 'Circled' },
    { id: 'superscript', label: 'Superscript', short: 'Superscript' },
    { id: 'subscript', label: 'Subscript', short: 'Subscript' },
    { id: 'strike', label: 'Strikethrough', short: 'Strikethrough' },
    { id: 'underline', label: 'Underline', short: 'Underline' },
    { id: 'glitch', label: 'Glitch Style', short: 'Glitch' },
  ];

  // ── Core transformation function ──────────────────────────────
  /**
   * Apply a Unicode map to text. Characters not in the map are preserved.
   * @param {string} text
   * @param {Object|null} map — char->char map, or null for special handlers
   * @param {string} styleId
   * @returns {string}
   */
  function transform(text, map, styleId) {
    if (!text) return '';
    if (styleId === 'strike') return transformStrike(text);
    if (styleId === 'underline') return transformUnderline(text);
    if (styleId === 'glitch') return transformGlitch(text);
    if (!map) return text; // fallback — no transform
    return text.split('').map(ch => map[ch] !== undefined ? map[ch] : ch).join('');
  }

  /**
   * Strikethrough: combine each character with U+0336 (combining long stroke overlay).
   * Preserves non-Latin chars as well.
   */
  function transformStrike(text) {
    let out = '';
    for (const ch of text) {
      out += ch + '\u0336';
    }
    return out;
  }

  /**
   * Underline: combine each character with U+0332 (combining low line).
   */
  function transformUnderline(text) {
    let out = '';
    for (const ch of text) {
      out += ch + '\u0332';
    }
    return out;
  }

  /**
   * Glitch-style: insert random combining marks, variation selectors,
   * and occasional replacement characters to create a "glitchy" look.
   * Uses a seeded pseudo-random so the same input yields the same output.
   */
  function transformGlitch(text) {
    let out = '';
    let seed = 0;
    for (let i = 0; i < text.length; i++) {
      const ch = text[i];
      seed = (seed * 1103515245 + 12345) & 0x7fffffff;
      out += ch;
      // Insert combining mark ~40% of the time
      if ((seed % 10) < 4) {
        const marks = [
          '\u0300', '\u0301', '\u0302', '\u0303', '\u0304', '\u0306',
          '\u0307', '\u0308', '\u0310', '\u0312', '\u0313', '\u0314',
          '\u0315', '\u031A', '\u031B', '\u0322', '\u0329',
        ];
        out += marks[seed % marks.length];
      }
      // Insert glitch rune ~10% of the time
      if ((seed % 10) < 1) {
        const runes = ['\uFFFD', '\u200B', '\u200C', '\u200D', '\uFEFF'];
        out += runes[seed % runes.length];
      }
    }
    return out;
  }

  // ── Public API ─────────────────────────────────────────────────
  /**
   * Transform text with a given style.
   * @param {string} text
   * @param {string} styleId — one of the style IDs in STYLES
   * @returns {string}
   */
  function apply(text, styleId) {
    const style = STYLES.find(s => s.id === styleId);
    if (!style) return text;
    const map = MAPS[styleId];
    return transform(text, map, styleId);
  }

  /**
   * Apply ALL available styles and return a map of id -> styled text.
   * @param {string} text
   * @returns {Object<string, string>}  id -> output
   */
  function applyAll(text) {
    const results = {};
    for (const style of STYLES) {
      results[style.id] = apply(text, style.id);
    }
    return results;
  }

  /**
   * Get the list of supported styles with metadata.
   * @returns {Array}
   */
  function getStyles() {
    return STYLES.map(s => ({ ...s }));
  }

  /**
   * Validate that a style ID is known.
   */
  function isValidStyle(styleId) {
    return STYLES.some(s => s.id === styleId);
  }

  /**
   * Sanitize text for display (basic XSS guard).
   */
  function sanitizeText(text) {
    if (typeof text !== 'string') return '';
    return text
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;');
  }

  /**
   * Copy text to clipboard with fallback.
   * Returns true if clipboard API succeeded (or fallback was used).
   */
  async function copyToClipboard(text) {
    if (!navigator.clipboard || !window.ClipboardItem) {
      // Fallback for older browsers
      const ta = document.createElement('textarea');
      ta.value = text;
      ta.style.position = 'fixed';
      ta.style.left = '-9999px';
      document.body.appendChild(ta);
      ta.select();
      try {
        document.execCommand('copy');
        document.body.removeChild(ta);
        return true;
      } catch (e) {
        document.body.removeChild(ta);
        return false;
      }
    }
    try {
      await navigator.clipboard.writeText(text);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ── Expose ─────────────────────────────────────────────────────
  return {
    apply,
    applyAll,
    getStyles,
    isValidStyle,
    sanitizeText,
    copyToClipboard,
    STYLES,
  };
})();

// Export for use in both module and global contexts
if (typeof module !== 'undefined' && module.exports) {
  module.exports = FontChangerEngine;
}
// Also attach to window for inline use
if (typeof window !== 'undefined') {
  window.FontChangerEngine = FontChangerEngine;
}
