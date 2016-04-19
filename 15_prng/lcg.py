#!/usr/bin/env python3

import matplotlib as mpl
import matplotlib.pyplot as plt
import math

#['agg.path.chunksize', 'animation.avconv_args', 'animation.avconv_path', 'animation.bitrate', 'animation.codec', 'animation.convert_args', 'animation.convert_path', 'animation.ffmpeg_args', 'animation.ffmpeg_path', 'animation.frame_format', 'animation.mencoder_args', 'animation.mencoder_path', 'animation.writer', 'axes.axisbelow', 'axes.color_cycle', 'axes.edgecolor', 'axes.facecolor', 'axes.formatter.limits', 'axes.formatter.use_locale', 'axes.formatter.use_mathtext', 'axes.formatter.useoffset', 'axes.grid', 'axes.grid.which', 'axes.hold', 'axes.labelcolor', 'axes.labelsize', 'axes.labelweight', 'axes.linewidth', 'axes.titlesize', 'axes.titleweight', 'axes.unicode_minus', 'axes.xmargin', 'axes.ymargin', 'axes3d.grid', 'backend', 'backend.qt4', 'backend.qt5', 'backend_fallback', 'contour.negative_linestyle', 'datapath', 'docstring.hardcopy', 'examples.directory', 'figure.autolayout', 'figure.dpi', 'figure.edgecolor', 'figure.facecolor', 'figure.figsize', 'figure.frameon', 'figure.max_open_warning', 'figure.subplot.bottom', 'figure.subplot.hspace', 'figure.subplot.left', 'figure.subplot.right', 'figure.subplot.top', 'figure.subplot.wspace', 'font.cursive', 'font.family', 'font.fantasy', 'font.monospace', 'font.sans-serif', 'font.serif', 'font.size', 'font.stretch', 'font.style', 'font.variant', 'font.weight', 'grid.alpha', 'grid.color', 'grid.linestyle', 'grid.linewidth', 'image.aspect', 'image.cmap', 'image.interpolation', 'image.lut', 'image.origin', 'image.resample', 'interactive', 'keymap.all_axes', 'keymap.back', 'keymap.forward', 'keymap.fullscreen', 'keymap.grid', 'keymap.home', 'keymap.pan', 'keymap.quit', 'keymap.save', 'keymap.xscale', 'keymap.yscale', 'keymap.zoom', 'legend.borderaxespad', 'legend.borderpad', 'legend.columnspacing', 'legend.fancybox', 'legend.fontsize', 'legend.framealpha', 'legend.frameon', 'legend.handleheight', 'legend.handlelength', 'legend.handletextpad', 'legend.isaxes', 'legend.labelspacing', 'legend.loc', 'legend.markerscale', 'legend.numpoints', 'legend.scatterpoints', 'legend.shadow', 'lines.antialiased', 'lines.color', 'lines.dash_capstyle', 'lines.dash_joinstyle', 'lines.linestyle', 'lines.linewidth', 'lines.marker', 'lines.markeredgewidth', 'lines.markersize', 'lines.solid_capstyle', 'lines.solid_joinstyle', 'mathtext.bf', 'mathtext.cal', 'mathtext.default', 'mathtext.fallback_to_cm', 'mathtext.fontset', 'mathtext.it', 'mathtext.rm', 'mathtext.sf', 'mathtext.tt', 'nbagg.transparent', 'patch.antialiased', 'patch.edgecolor', 'patch.facecolor', 'patch.linewidth', 'path.effects', 'path.simplify', 'path.simplify_threshold', 'path.sketch', 'path.snap', 'pdf.compression', 'pdf.fonttype', 'pdf.inheritcolor', 'pdf.use14corefonts', 'pgf.debug', 'pgf.preamble', 'pgf.rcfonts', 'pgf.texsystem', 'plugins.directory', 'polaraxes.grid', 'ps.distiller.res', 'ps.fonttype', 'ps.papersize', 'ps.useafm', 'ps.usedistiller', 'savefig.bbox', 'savefig.directory', 'savefig.dpi', 'savefig.edgecolor', 'savefig.facecolor', 'savefig.format', 'savefig.frameon', 'savefig.jpeg_quality', 'savefig.orientation', 'savefig.pad_inches', 'savefig.transparent', 'svg.fonttype', 'svg.image_inline', 'svg.image_noscale', 'text.antialiased', 'text.color', 'text.dvipnghack', 'text.hinting', 'text.hinting_factor', 'text.latex.preamble', 'text.latex.preview', 'text.latex.unicode', 'text.usetex', 'timezone', 'tk.window_focus', 'toolbar', 'verbose.fileo', 'verbose.level', 'webagg.open_in_browser', 'webagg.port', 'webagg.port_retries', 'xtick.color', 'xtick.direction', 'xtick.labelsize', 'xtick.major.pad', 'xtick.major.size', 'xtick.major.width', 'xtick.minor.pad', 'xtick.minor.size', 'xtick.minor.width', 'ytick.color', 'ytick.direction', 'ytick.labelsize', 'ytick.major.pad', 'ytick.major.size', 'ytick.major.width', 'ytick.minor.pad', 'ytick.minor.size', 'ytick.minor.width']


#\colorlet{color1}{black}
color1 = 'k'
#\colorlet{color2}{green!50!black!50}
color2 = (0,.5,0)
#\colorlet{color3}{blue!50!black!50}
color3 = (0,0,.5)
#\colorlet{color4}{red!50!black!50}
color4 = (.5,0,0)
mpl.rcParams['axes.color_cycle'] = ("#00587c", color3, color4)

class LCG:
    def __init__(self, a, c, m, seed):
        self.a = a
        self.c = c
        self.m = m
        self.x = seed
    
    def __call__(self):
        self.x = (self.a * self.x + self.c) % self.m
        return self.x

def test_lcg(lcg, k):
    n = k*lcg.m
    title = "$a={}\, c={}\, m={}\, X_0={}\, n={}$".format(lcg.a, lcg.c, lcg.m, lcg.x, n)
    data = [lcg() for i in range(0, n)]
    m = max(hist(data).values())
    plt.hist(data, lcg.m, histtype='stepfilled')
    plt.ylim(ymax=m*1.1)
    plt.title(title)
    plt.xlabel("$X_i$")
    plt.ylabel("Liczba wystąpień")
    plt.savefig("lcg_{}_{}_{}_hist.pdf".format(lcg.a, lcg.c, lcg.m))
    plt.close()
    plt.scatter(data[:-1], data[1:])
    plt.title(title)
    plt.xlabel("$X_i$")
    plt.ylabel("$X_{i+1}$")
    plt.savefig("lcg_{}_{}_{}_scatter.pdf".format(lcg.a, lcg.c, lcg.m))
    plt.close()
    return data

def hist(data):
    result = {}
    for val in data:
        if val not in result:
            result[val] = 0
        result[val] += 1
    return result

def cut(data):
    k = 200000
    n = 17
    data1 = [v%n for v in data[0:k*n]]
    h = hist(data1)
    m = max(h.values())
    plt.hist(data1, n, histtype='stepfilled')
    plt.ylim(ymax=m*1.1)
    plt.title("mod {0}, ${1}\cdot {0}={2}$ wartości, min={3}, max={4}".format(n, k, k*n, min(h.values()), max(h.values())))
    plt.xlabel("$X_i$")
    plt.ylabel("Liczba wystąpień")
    plt.savefig("lcg_mod_{}_hist.pdf".format(n))
    plt.close()

    l = 32
    data2 = [v&0b11111 for v in data if (v&0b11111)<n][0:k*n]
    assert len(data2) == k*n, "Za krótkie data!"
    h = hist(data2)
    m = max(h.values())
    plt.hist(data2, n, histtype='stepfilled')
    plt.ylim(ymax=m*1.1)
    plt.title("mod {0} ucięte, ${1}\cdot {3}={2}$ wartości, min={4}, max={5}".format(l, k, k*n, n, min(h.values()), max(h.values())))
    plt.xlabel("$X_i$")
    plt.ylabel("Liczba wystąpień")
    plt.savefig("lcg_mod_{}_hist.pdf".format(l))
    plt.close()



def main():
    data = test_lcg(LCG(1229, 1, 2048, 1), 5)
    print(data[1:20])
#parametry z Javy, modulus jest o jeden wiekszy niz w kodzie Java, bo tam jest maska
    java_lcg = LCG(0x5DEECE66D, 0xB, (1 << 48), 1)
#to przesuniecie o 16 to dlatego, ze tamten generator tez tak robi
    data = [java_lcg()>>16 for i in range(0, 10000000)]
    cut(data)

    data = test_lcg(LCG(65538, 2, math.factorial(7), 1), 5)
    print(data[1:20])
    print(hist(data))


if __name__ == '__main__':
    main()
