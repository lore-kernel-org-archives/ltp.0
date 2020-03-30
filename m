From: Li Wang <liwang@redhat.com>
Date: Mon, 30 Mar 2020 12:24:22 +0800
Subject: [LTP] [PATCH 0/6] C API: .needs_cmds and SAFE_RUN_CMD()
In-Reply-To: <20200328034253.GA2720439@x230>
References: <20200327213924.18816-1-pvorel@suse.cz>
 <4ff84a77-b858-6cae-a320-cfaed3646864@163.com>
 <20200328034253.GA2720439@x230>
Message-ID: <CAEemH2e5i_N5FGsY6KZnfAN4k7cfLZU=XJvsg_AP8n=bV2JdrQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Mar 28, 2020 at 11:43 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Xiao,
>
> > On 3/28/20 5:39 AM, Petr Vorel wrote:
> > > + There is a double check (first in
> > > .needs_cmds, then in SAFE_RUN_CMD()), maybe that's not needed.
>
> > Hi Petr,
>
> > Why do you need the duplicate .needs_cmds flag?(it introduces the double
> > check as you said)
>
> > Usually, all tests run commands by tst_run_cmd()/SAFE_RUN_CMD() and they
> can
> > report TCONF
>
> > by passing TST_RUN_CMD_CHECK_CMD so it is fair to be a part of
> > tst_run_cmd()/SAFE_RUN_CMD().
>
> Thanks for your review.
> I guess Cyril will prefer .needs_cmds, as it can be parsed - metadata
> project:
> https://people.kernel.org/metan/towards-parallel-kernel-test-runs
> https://github.com/metan-ucw/ltp/tree/master/docparse
>
> I put it there because some command might be run just under some condition
> (not
> always), thus not suitable for .needs_cmds, but still nice to have reliable
> check. But maybe I'm wrong.
>

+1 you're right, I believe that is safer and choosable for the test.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200330/e2d2298a/attachment.htm>
