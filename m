From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Nov 2020 07:37:00 +0100
Subject: [LTP] [PATCH 1/4] syscalls/sync01: Remove it
In-Reply-To: <5FA8BE07.4040201@cn.fujitsu.com>
References: <1603691317-22811-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <5FA21AA9.9020208@cn.fujitsu.com> <20201106123604.GA30097@yuki.lan>
 <0bc685ce-1983-b900-787f-3d89e75ca48d@163.com>
 <20201106164742.GA6449@rei.lan>
 <f99d3484-f86d-dd8a-e64e-7d9d94533de4@163.com>
 <20201107165518.GB10159@pevik> <5FA8BE07.4040201@cn.fujitsu.com>
Message-ID: <20201109063700.GA146434@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Sorry, I didn't describe the doubt clearly.
> For example:
> 1) open(2) will return -1 if an error occur.
>     Is it necessary to check invalid return value(except -1) if an error
> occur?
> 2) mmap(2) will return MAP_FAILED if an error occurs.
>     Is it necessary to check invalid value(except MAP_FAILED) if an error
> occur?
> Martin's patches have added a check for invalid return value in many safe
> macros but a lot of syscall tests(e.g. after doingTEST()) don't add the
> check for now.
> I am not sure if we need to add the check for all syscall tests. :-)
> BTW: In my opinion, it is hardly to get invalid return value so the check
> seems unnecessary and redundance.
Agree it's hard to get these errors. That's why I would bother just in the
library (in these safe_*() functions).

Kind regards,
Petr Vorel

> Best Regards,
> Xiao Yang
