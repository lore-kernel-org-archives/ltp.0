From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 9 Mar 2016 07:08:33 -0500 (EST)
Subject: [LTP] Question about perf_event_open/Cap_bounds/su01 test cases
In-Reply-To: <AF04265A3FC2B144B9892F621A394E13EA3DB009@tethys>
References: <AF04265A3FC2B144B9892F621A394E13EA3DB009@tethys>
Message-ID: <250374796.7297169.1457525313432.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Julio Cruz Barroso" <julio.cruz@smartmatic.com>
> To: ltp@lists.linux.it
> Sent: Wednesday, 9 March, 2016 11:40:59 AM
> Subject: [LTP] Question about perf_event_open/Cap_bounds/su01 test cases
> 
> Hi,
> 
> I’m trying to perform a testing based on LTP version 20150420 on a Linux
> 3.14.61 (using iMX6 SOC series).
> 
> Basically, I perform the same test in four (4) different SOC (Solo, DualLite,
> Dual and Quad) including different RAM (512, 512, 1024, 2048MB
> respectively). The same kernel (with different Device Tree) is used on the
> four boards.
> 
> The test is run as below:
> 
> ------------------
> hostname emad-machine ;
> cd /opt/ltp ;
> rm -r tmp ;
> mkdir tmp ;
> chmod 777 tmp ;
> rm -r results ;
> rm result.fulllog ;
> rm -r output ;
> ./runltp -p -l result.log -C result.fail -d /opt/ltp/tmp -g results.html -o
> result.fulllog
> ------------------
> 
> The results show around 66 test cases fail from a total of 1519. I focused on
> the fails trying to:
> 
> ------------------
> 1) Change the kernel configuration (rebuild) to include any missing option
> 2) Review the test cases code and try to figure out any false negative
> ------------------
> 
> After perform this analysis, 63 test cases were mark as false negatives, but
> 4 test cases have unknown conclusion, as show below:

Hi,

> 
> ------------------
> 1. perf_event_open01 failed with < TEST_ERRNO=EOPNOTSUPP(95): Operation not
> supported. >
>    a. I assume the test fail because the HW doesn’t support it. Could be
>    wrong? [more details, please refer to https://justpaste.it/s315]

Agreed, this looks like test should be fixed to handle EOPNOTSUPP too:
EOPNOTSUPP
  Returned if an event requiring a specific hardware feature is requested but there is no hardware support.  This includes requesting low-skid  events  if  not  sup‐
  ported, branch tracing if it is not available, sampling if no PMU interrupt is available, and branch stacks for software events.

> 2. perf_event_open02 cause < WARNING: CPU: 2 PID: 24 at
> kernel/events/core.c:764 perf_cpu_hrtimer_handler+0x1f0/0x20c() >. This
> warning pass multiples times until /dev/kmsg buffer overrun [more details,
> please refer to https://justpaste.it/s315]
>    a. This test fail because the 01 test already fail, or can I run both
>    independently?

They should be independent.

>    b. Any advice about the WARNING?

I'm assuming that is "WARN_ON(!irqs_disabled());", I'd guess a kernel bug.
Do you have a chance to try perf record/stat and see if that triggers it too.

> 3. Cap_bounds fail with “cap_bounds_r.c:55: prctl(PR_CAPBSET_READ, 37)
> returned -1”. The numerical value of the highest capability supported by the
> running kernel is 36 [cat /proc/sys/kernel/cap_last_cap,
> http://man7.org/linux/man-pages/man7/capabilities.7.html].
>    a. Can I assume this as a false negative?

Yes. On first look maybe we should change test to go only up to
min(CAP_LAST_CAP, /proc/sys/kernel/cap_last_cap).

> 4. su01 fail with < /bin/su -l root with correct password ( FAILED ) > [more
> details, please refer to https://justpaste.it/s329].
>    a. Could be an test issue?

Don't have much experience with this test, but it looks like
it relies on group 'wheel' or 'trusted' to be present, and
in your case it's not:
  usermod: group 'trusted' does not exist

> ------------------
> 
> The whole analysis can be refer on https://justpaste.it/s32h.

(Some of) those huge test failures should be TCONF in latest LTP,
I recall a patch added last year that introduced a check if hugepages
are supported.

Regards,
Jan

> 
> Appreciate any suggestion or feedback. I just started using LTP some days
> ago, please, forgive any huge mistake ☺
> 
> Thanks, Julio
> 
> 
> 
> 
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
> 
