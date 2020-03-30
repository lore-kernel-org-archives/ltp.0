From: Li Wang <liwang@redhat.com>
Date: Mon, 30 Mar 2020 12:39:50 +0800
Subject: [LTP] [PATCH 0/6] C API: .needs_cmds and SAFE_RUN_CMD()
In-Reply-To: <5E80323C.5070408@cn.fujitsu.com>
References: <20200327213924.18816-1-pvorel@suse.cz>
 <4ff84a77-b858-6cae-a320-cfaed3646864@163.com>
 <20200328034253.GA2720439@x230> <5E80323C.5070408@cn.fujitsu.com>
Message-ID: <CAEemH2chnkojt0oc9OVodwKOj27_7aTj1nHnkk_DVoOxUP-H7A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

On Sun, Mar 29, 2020 at 1:36 PM Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> On 2020/3/28 11:42, Petr Vorel wrote:
> > Hi Xiao,
> >
> >> On 3/28/20 5:39 AM, Petr Vorel wrote:
> >>> + There is a double check (first in
> >>> .needs_cmds, then in SAFE_RUN_CMD()), maybe that's not needed.
> >
> >> Hi Petr,
> >
> >> Why do you need the duplicate .needs_cmds flag?(it introduces the double
> >> check as you said)
> >
> >> Usually, all tests run commands by tst_run_cmd()/SAFE_RUN_CMD() and
> they can
> >> report TCONF
> >
> >> by passing TST_RUN_CMD_CHECK_CMD so it is fair to be a part of
> >> tst_run_cmd()/SAFE_RUN_CMD().
> >
> > Thanks for your review.
> > I guess Cyril will prefer .needs_cmds, as it can be parsed - metadata
> project:
> > https://people.kernel.org/metan/towards-parallel-kernel-test-runs
> > https://github.com/metan-ucw/ltp/tree/master/docparse
> Hi Petr?
>
> Thank you for sharing these info.
> Does Cyril want to get metadata from struct tst_test directly?
>
> How about the rough design?
> 1) .needs_cmds only saves the required commands.(doesn't do any check)
> 2) pass the corresponding member of .needs_cmds to
> tst_run_cmd()/SAFE_RUN_CMD()(do check in these functions).
> For example:
> ----------------------------------------------
> # grep tst_needs_cmds include/tst_cmd.h
> extern const char *const *tst_needs_cmds;
>
> # grep -B1 tst_needs_cmds lib/tst_test.c
>
> const char *const *tst_needs_cmds;
> --
>      if (tst_test->needs_cmds)
>          tst_needs_cmds = tst_test->needs_cmds;
>
> # grep -A2 'needs_cmds' testcases/kernel/syscalls/add_key/add_key05.c
>      const char *const cmd_useradd[] = {tst_needs_cmds[0], username, NULL};
>      int rc;
>

I don't see any advantage of involving this struct in a test case, and it
also makes things more complicated.

IMO, the '.needs_cmds' should do check and guarantee all the
cmds exist. That's a hard requirement for the test. If a situation that the
commands are only part of the requirement(soft), we could avoid using
'.needs_cmds' in the test and just calling tst_run_cmd() without passing
TST_RUN_CMD_CHECK_CMD flag. This satisfies most situations we have, it is
safe enough and choosable for people.

Or maybe I'm wrong here too:).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200330/e959385c/attachment-0001.htm>
