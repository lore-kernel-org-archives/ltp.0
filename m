From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Jun 2018 16:41:24 +0530
Subject: [LTP] LTP CVE cve-2017-17053 test failed on x86_64 device
In-Reply-To: <20180620072138.yrz76kmms3oviv7i@linux-d8ym>
References: <CA+G9fYsRgGsmi-tE8dU=pfSDDLg3bUuii_0KUPZ71jFLNre-5g@mail.gmail.com>
 <20180620072138.yrz76kmms3oviv7i@linux-d8ym>
Message-ID: <CA+G9fYtoML7G7f_sXB6hQJJAQOG94TsBXujmQgHxy-rKABaTtA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 20 June 2018 at 12:51, Michael Moese <mmoese@suse.de> wrote:
> Hi,
>
> On Wed, Jun 20, 2018 at 12:14:22PM +0530, Naresh Kamboju wrote:
>> Test FAIL case output,
>> tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
>> tst_taint.c:88: BROK: Kernel is already tainted: 512
> The kernel is already tainted. In this case, the test refuses to run,
> because it could not tell if the test is pass or fail.
>
> Could you please check if you could run the test directly after a
> reboot?

This single test ran immediately after the boot and bug reproduced.

tst_taint.c:88: BROK: Kernel is already tainted: 512
https://lkft.validation.linaro.org/scheduler/job/293222#L1204

Test command for 10 iterations and it failed for all 10 iterations.
+ ./runltp -s cve-2017-17053 -I 10

NOTE:
We still see kernel warning while booting the x86_64 machine.
DEBUG_LOCKS_WARN_ON(sem->owner != ((struct task_struct *)(1UL << 0)))

- Naresh

>
> Regards,
> Michael
> --
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
