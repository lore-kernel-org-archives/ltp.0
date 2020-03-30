From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Mar 2020 09:12:17 +0200
Subject: [LTP] [PATCH 0/6] C API: .needs_cmds and SAFE_RUN_CMD()
In-Reply-To: <5E81819B.5070303@cn.fujitsu.com>
References: <20200327213924.18816-1-pvorel@suse.cz>
 <4ff84a77-b858-6cae-a320-cfaed3646864@163.com>
 <20200328034253.GA2720439@x230> <5E80323C.5070408@cn.fujitsu.com>
 <CAEemH2chnkojt0oc9OVodwKOj27_7aTj1nHnkk_DVoOxUP-H7A@mail.gmail.com>
 <5E81819B.5070303@cn.fujitsu.com>
Message-ID: <20200330071217.GB4571@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> >     # grep -A2 'needs_cmds' testcases/kernel/syscalls/add_key/add_key05.c
> >     const char *const cmd_useradd[] = {tst_needs_cmds[0], username, NULL};
> >     int rc;

> > I don't see any advantage of involving this struct in a test case, and
> > it also makes things more complicated.
> Hi Li,

> In fact, I perfer to remove .need_cmd and use tst_run_cmd with/without
> TST_RUN_CMD_CHECK_CMD directly.
> But I am not sure if it is necessary to keep .need_cmd for metadata project.
> I think we can generate json about resouce by reading struct tst_test or
> other ways.

not sure if you mean removing .needs_cmds entirely or just for
copy_file_range02.c. or some other test. I rewritten the original patchset
because Cyril suggested .needs_cmds implementation:

	"Actually I would like to avoid exposing the function to the tests and
	force people to use the .needs_cmds instead in order to have a proper
	metadata." [1]


IMHO parsing struct members is easier to get metadata than searching for
various functions to be used, so I understand Cyril's intention. Cyril explains
this on his blog posts (I've noticed [2], but it's also in [3]: "this
arrangement also helps to export the test metadata into a machine parsable
format").

Kind regards,
Petr

> Thanks,
> Xiao Yang


> > IMO, the '.needs_cmds' should do check and guarantee all the cmds exist.
> > That's a hard requirement for the test. If a situation that the commands
> > are only part of the requirement(soft), we could avoid using
> > '.needs_cmds' in the test and just calling tst_run_cmd() without passing
> > TST_RUN_CMD_CHECK_CMD flag. This satisfies most situations we have, it
> > is safe enough and choosable for people.

> > Or maybe I'm wrong here too:).

> > --
> > Regards,
> > Li Wang


Kind regards,
Petr

[1] https://lists.linux.it/pipermail/ltp/2020-March/016233.html
[2] https://people.kernel.org/metan/towards-parallel-kernel-test-runs
[3] https://people.kernel.org/metan/the-ltp-test-driver-model
