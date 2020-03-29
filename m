From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Sun, 29 Mar 2020 13:29:32 +0800
Subject: [LTP] [PATCH 0/6] C API: .needs_cmds and SAFE_RUN_CMD()
In-Reply-To: <20200328034253.GA2720439@x230>
References: <20200327213924.18816-1-pvorel@suse.cz>
 <4ff84a77-b858-6cae-a320-cfaed3646864@163.com>
 <20200328034253.GA2720439@x230>
Message-ID: <5E80323C.5070408@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/3/28 11:42, Petr Vorel wrote:
> Hi Xiao,
>
>> On 3/28/20 5:39 AM, Petr Vorel wrote:
>>> + There is a double check (first in
>>> .needs_cmds, then in SAFE_RUN_CMD()), maybe that's not needed.
>
>> Hi Petr,
>
>> Why do you need the duplicate .needs_cmds flag?(it introduces the double
>> check as you said)
>
>> Usually, all tests run commands by tst_run_cmd()/SAFE_RUN_CMD() and they can
>> report TCONF
>
>> by passing TST_RUN_CMD_CHECK_CMD so it is fair to be a part of
>> tst_run_cmd()/SAFE_RUN_CMD().
>
> Thanks for your review.
> I guess Cyril will prefer .needs_cmds, as it can be parsed - metadata project:
> https://people.kernel.org/metan/towards-parallel-kernel-test-runs
> https://github.com/metan-ucw/ltp/tree/master/docparse
Hi Petr?

Thank you for sharing these info.
Does Cyril want to get metadata from struct tst_test directly?

How about the rough design?
1) .needs_cmds only saves the required commands.(doesn't do any check)
2) pass the corresponding member of .needs_cmds to 
tst_run_cmd()/SAFE_RUN_CMD()(do check in these functions).
For example:
----------------------------------------------
# grep tst_needs_cmds include/tst_cmd.h
extern const char *const *tst_needs_cmds;

# grep -B1 tst_needs_cmds lib/tst_test.c

const char *const *tst_needs_cmds;
-- 
     if (tst_test->needs_cmds)
         tst_needs_cmds = tst_test->needs_cmds;

# grep -A2 'needs_cmds' testcases/kernel/syscalls/add_key/add_key05.c
     const char *const cmd_useradd[] = {tst_needs_cmds[0], username, NULL};
     int rc;

-- 
     const char *const cmd_userdel[] = {tst_needs_cmds[1], "-r", 
username, NULL};

     if (tst_run_cmd(cmd_userdel, NULL, NULL, 1))
-- 
     .needs_cmds = (const char *const []) {
         "useradd",
         "userdel",
----------------------------------------------
btw: is it possible for .needs_cmds to save the required commands with 
options?

Thanks,
Xiao Yang
>
> I put it there because some command might be run just under some condition (not
> always), thus not suitable for .needs_cmds, but still nice to have reliable
> check. But maybe I'm wrong.
>
> Kind regards,
> Petr
>



