From: Oliver Sang <oliver.sang@intel.com>
Date: Fri, 29 Jan 2021 16:05:58 +0800
Subject: [LTP] [binfmt_elf] d97e11e25d: ltp.DS000.fail
In-Reply-To: <CAMuHMdUFsRSCDJeML+0i17ig6oFr+-cz660xyhkhkfg2UtPTzQ@mail.gmail.com>
References: <20210106075112.1593084-1-geert@linux-m68k.org>
 <20210126055112.GA19582@xsang-OptiPlex-9020>
 <CAMuHMdUFsRSCDJeML+0i17ig6oFr+-cz660xyhkhkfg2UtPTzQ@mail.gmail.com>
Message-ID: <20210129080557.GB13077@xsang-OptiPlex-9020>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jan 26, 2021 at 09:03:26AM +0100, Geert Uytterhoeven wrote:
> Hi Oliver,
> 
> On Tue, Jan 26, 2021 at 6:35 AM kernel test robot <oliver.sang@intel.com> wrote:
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: d97e11e25dd226c44257284f95494bb06d1ebf5a ("[PATCH v2] binfmt_elf: Fix fill_prstatus() call in fill_note_info()")
> > url: https://github.com/0day-ci/linux/commits/Geert-Uytterhoeven/binfmt_elf-Fix-fill_prstatus-call-in-fill_note_info/20210106-155236
> > base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
> 
> My patch (which you applied on top of v5.11-rc2) is a build fix for
> a commit that is not part of v5.11-rc2.  Hence the test run is invalid.

sorry for false report. we've fixed the problem. Thanks

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
