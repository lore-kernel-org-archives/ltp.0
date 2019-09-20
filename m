From: Li Wang <liwang@redhat.com>
Date: Fri, 20 Sep 2019 11:00:14 +0800
Subject: [LTP] [RFC PATCH] tst_taint: TCONF when kernel is alreay tainted
In-Reply-To: <20190919100205.GA26642@rei>
References: <20190918053519.26244-1-liwang@redhat.com>
 <20190919100205.GA26642@rei>
Message-ID: <CAEemH2eD5fcYYcK06Jyp-bxOwO-tzk1zdLyruu5U-VfyouTXaA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 19, 2019 at 6:02 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > As the tst_taint_init comments described, If the tainted-flags are
> already set
> > by the kernel, there is no reason to continue and TCONF is generated.
> But in
> > the function achieve, it uses TBROK.
> >
> >   cmdline="cve-2017-17053"
> >   tst_test.c:1096: INFO: Timeout per run is 0h 10m 00s
> >   tst_taint.c:88: BROK: Kernel is already tainted: 536871424
>
> There is a reason for generating TBROK, we do not want the test to be
> skipped silently in this case. If kernel is tainted something went wrong
> anyways and we are looking only for a specific flags.
>

That's true. The TBROK can highlight the tainted kernel as a good reminder
to the tester.

But in a real testing situation, LTP sometimes not being run in the first,
after we go here cve-2017-17053, the kernel very probably has already been
tainted and reported by other tests. So this new TBROK will drive tester to
double-check if something wrong as new.

Imagine that, if there are many test cases invoke a tainted checking(e.g.
TST_TAINT_W) in LTP, then all of them will be skipped and report TBORK on
such tainted-kernel, that seems not to be friendly to the tester to review
the result.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190920/7ebf5063/attachment.htm>
