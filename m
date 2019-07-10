From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed, 10 Jul 2019 12:35:45 +0800
Subject: [LTP] [PATCH 2/3] zram/zram_lib.sh: fix variable name and
 algorithm retrieval
In-Reply-To: <20190709114412.GC5888@rei.lan>
References: <20190703102303.32166-1-po-hsu.lin@canonical.com>
 <20190703102303.32166-3-po-hsu.lin@canonical.com>
 <20190709114412.GC5888@rei.lan>
Message-ID: <CAMy_GT_o7WiWo1zt7VDDqg+zjMGocL9K5EoxSTq1YzBuY1ekfg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jul 9, 2019 at 7:44 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> >       tst_resm TINFO "test that we can set compression algorithm"
> >
> > -     local algs="$(cat /sys/block/zram0/comp_algorithm)"
> > -     tst_resm TINFO "supported algs: $algs"
> > +     local zram_algs="$(sed 's/[][]//g' /sys/block/zram0/comp_algorithm)"
>
> This has still the same name as the variable set in the zram01.sh.
>
> There are two options what to do here, either we remove zram_algs from
> the zram01.sh or set the algorithms to the ones defined in the zram01.sh
> test at the end of this function.
>

OK thanks,
I think maybe it's better to keep zram_algs in zram01.sh, make the
mapped zram property structure intact.
That's probably the original purpose for the local variable "algs".

I will re-send a version with variable name unified with the local
algs here, so we don't need to restore the zram_algs in the end of
this function.


> > +     tst_resm TINFO "supported algs: $zram_algs"
> >       local i=0
> >       for alg in $zram_algs; do
> >               local sys_path="/sys/block/zram${i}/comp_algorithm"
> > --
> > 2.17.1
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
>
> --
> Cyril Hrubis
> chrubis@suse.cz
