From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Jun 2021 13:36:16 +0200
Subject: [LTP] [PATCH] typo: Add necessary spaces in the outputs
In-Reply-To: <730f190e-4baa-f854-2c5e-8c6b9d4267df@huawei.com>
References: <20210518064506.203781-1-xieziyao@huawei.com>
 <CAEemH2en6C3dUzspuVwNVmRiUeBQWK38bLPT7+ZwErVFQG+i-w@mail.gmail.com>
 <YKXtvaeckoJ2HJzJ@pevik>
 <730f190e-4baa-f854-2c5e-8c6b9d4267df@huawei.com>
Message-ID: <YMniMEyDjhCLcx8g@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ziyao,

> Hi!

> Ping. I checked it based on the latest code. Are there any changes that need
> to be added?
Well, as I note previously on some places it'd be better to join string, e.g.
testcases/kernel/syscalls/setsid/setsid01.c
testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
testcases/kernel/syscalls/sysinfo/sysinfo02.c

The reason is that string on single line is easier to grep.
That's why checkpatch.pl from kernel relaxed max line from 80 to 100
(good at least for string).

But I'm ok to merge it without.

Kind regards,
Petr

> Kind Regards,
> Ziyao
