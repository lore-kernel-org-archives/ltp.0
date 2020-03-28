From: Xiao Yang <ice_yangxiao@163.com>
Date: Sat, 28 Mar 2020 10:41:19 +0800
Subject: [LTP] [PATCH 0/6] C API: .needs_cmds and SAFE_RUN_CMD()
In-Reply-To: <20200327213924.18816-1-pvorel@suse.cz>
References: <20200327213924.18816-1-pvorel@suse.cz>
Message-ID: <4ff84a77-b858-6cae-a320-cfaed3646864@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 3/28/20 5:39 AM, Petr Vorel wrote:
> + There is a double check (first in
> .needs_cmds, then in SAFE_RUN_CMD()), maybe that's not needed.

Hi Petr,

Why do you need the duplicate .needs_cmds flag?(it introduces the double 
check as you said)

Usually, all tests run commands by tst_run_cmd()/SAFE_RUN_CMD() and they 
can report TCONF

by passing TST_RUN_CMD_CHECK_CMD so it is fair to be a part of 
tst_run_cmd()/SAFE_RUN_CMD().

Thanks,

Xiao Yang


