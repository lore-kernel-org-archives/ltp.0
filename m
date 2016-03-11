From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 11 Mar 2016 10:35:19 -0500 (EST)
Subject: [LTP] Question about perf_event_open/Cap_bounds/su01 test cases
In-Reply-To: <AF04265A3FC2B144B9892F621A394E13EA3E2813@tethys>
References: <AF04265A3FC2B144B9892F621A394E13EA3DB009@tethys>
 <20160309140859.GD28171@rei.lan>
 <AF04265A3FC2B144B9892F621A394E13EA3E2813@tethys>
Message-ID: <1530717335.8635366.1457710519514.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Julio Cruz Barroso" <julio.cruz@smartmatic.com>
> To: "Cyril Hrubis" <chrubis@suse.cz>, "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Friday, 11 March, 2016 2:35:25 PM
> Subject: RE: [LTP] Question about perf_event_open/Cap_bounds/su01 test cases
> 
> Hi Jan, Cyril,
> 
> I will comment below separately.
> 
> I follow your suggestion to use the latest LTP (20160126) and after testing
> in the four platform, the results are better. In fact, the results show 373
> cases more and 537 with configuration error versus 192 in previous release.
> 
> -----------------
> Specifically, to Jan comments:
> 
> > I'm assuming that is "WARN_ON(!irqs_disabled());", I'd guess a kernel bug.
> > Do you have a chance to try perf record/stat and see if that triggers it
> > too.
> 
> Yes, you are right. Is "WARN_ON(!irqs_disabled());". By default, the system
> not contain 'perf' command but after installing it, I tried as below:
> 
> $ perf record -a -F 1000 sleep 5
> $ perf stat sleep 5
> $ perf report
> 
> Those commands not trigger the WARNING. I'm not a user of perf (yet) and I'm
> not sure is this is what you suggested to check. Please, can you confirm?

Yes, I was suggesting to try something like that.

> 
> BTW, in the latest 4.4, this function is not in 'core.c' anymore.
> 
> > Don't have much experience with this test, but it looks like it relies on
> > group 'wheel' or 'trusted' to be present, and in your case it's not:
> >  usermod: group 'trusted' does not exist
> 
> Yes, the user 'trusted' is not defined in '/etc/group'. I assume this is a
> false negative. Again, thanks to confirm also the others issues and take a
> look at the details results.
> 
> -----------------
> Specifically, to Cyril comments:
> 
> > The fanotify06 failure is likely kernel bug fixed in:
> 
> After to use the latest LTP, this error disappear. The test is marked as PASS
> with TCONF. But the others test cases: fanotify01, fanotify02 and fanotify04
> are marked as FAIL with the message "Fanotify is not configured in this
> kernel.". I don't understand why with this message, is still marked as fail?
> [please, refer details to https://justpaste.it/s5c3]. Thanks for looking at
> this issue and give the details of bug solution. Appreciated.
> 
> -----------------
> All,
> 
> Some new issues show up with the latest LTP (20160126) in the 3.14.61 kernel
> in iMX6 SOC (Solo, DualLite, Dual and Quad), as below:
> 
> - pwritev01_64. "TFAIL  :  pwritev01.c:114: Buffer wrong at 0 have 00
> expected 61". Fail in the four architectures. Any suggestion? [please, refer
> details to https://justpaste.it/s59m]

Is it only pwritev01_64 that fails? Is pwritev01 passing?
I don't see anything suspicious in testcase and it works fine on x86_64.
My first guess would be some alignment problem, because first 2 tests with
offset 0 PASSed. I'd try different values for "CHUNK", e.g. 512, 1024, 4096, 8192.
Also running testcase via strace could bring some additional data.

> - readahead02. Sometimes PASS and sometimes FAIL. When fail, show a TCONF and
> later TWARM. [https://justpaste.it/s4zk]

readahead doesn't seem to have any effect on your system.
max readahead size has been changed recently, but I think your kernel
is older: https://lkml.org/lkml/2015/8/24/344

> - ar. When is executed alone, the test PASS. But when is performed with the
> others, the results show FAIL. [PASS alone: https://justpaste.it/s50x
> FAIL with all: https://justpaste.it/s510]
> - file. The log show many things and one is "file09 9 TBROK :
> ltpapicmd.c:138: rpm command broke.". Not sure if this is really a FAIL
> [https://justpaste.it/s51w]

/opt/ltp/testcases/bin/file_test.sh: line 556: rpmbuild: command not found
test assumes that if you have "rpm", you have also "rpmbuild",
which doesn't seem to be true in your case

> - which01. Its seems Busybox not support many options used in this test.
> - cpuhotplug04. This test try to affect the first core and the system is
> running on it. That's is possible? [https://justpaste.it/s52s]

How many CPUs do you have? Can you run:
ls /sys/devices/system/cpu/*/online

> - getaddrinfo_01. Adding "127.0.0.1  machine" to '/etc/hosts' solved one
> issue but still present another: "getaddrinfo_01    2  TFAIL  :
> getaddrinfo_01.c:577: getaddrinfo IPv6 basic lookup ("emad") returns -2
> ("Name or service not known")"

Try adding same hostname also for "::1".

> 
> Two thing that catches my attention, has to do with: 1) the results in HTML
> and 2) the machine hang during the testing.
> 
> 1) results in HTML. The file "results.log" said (for example) 'cron_deny01'
> FAIL, but the file "results.html" show green color. This apply for others
> test cases also. This could be a known issue or I'm missing something?
> 2) machine hang. I saw this many times, but is the first time I take
> attention. The latest test case according with the file 'results.fulllog'
> show the  'dma_thread_diotest7' as failure. After that, the file is
> corrupted with 'NUL NUL...'. The second time show similar results. In
> different board occurred this issue. However, if the same test is performed
> alone (after reboot the machine) there is not hang and the results show
> FAIL. Any suggestion to affront this kind of problems (hang)?

Attach serial console, so you can get more data from kernel messages.
If it also crashes, then kdump would work too, but I'm not sure
your system supports it.

Other than that, maybe add sync to your runtest file after each test.
If you have suspicion about specific test, remove it from runtest file
and see if it still hangs.

> 
> Others general questions are:
> 
> - About setup of the test set. Once all the NAB (not a bug) are defined, can
> I omit those test cases from the test set?

Ideal would be to fix those tests, so they can run and terminate with TCONF.
If you can fix some, feel free to send a patch to this list.

Regards,
Jan

> - Reliability. For now, I run the test without stress (i.e. -m, -D options),
> but I would like to use those option once the 'hang' problem is solved. Any
> other suggestion to add 'confidence' to the results? Basically, to certify
> the system is OK.
> 
> For your reference, the test results (including the FAIL) are at
> https://justpaste.it/s5bf. The test was performed using the following
> configurations:
> 
> - iMX6 Solo; 1x ARM Cortex-A9, 512MB RAM (2x256MB)
> - iMX6 DualLite; 2x ARM Cortex-A9, 512MB RAM (2x256MB)
> - iMX6 Dual; 2x ARM Cortex-A9, 1G RAM (4x256MB)
> - iMX6 Quad; 4x ARM Cortex-A9, 2G RAM (4x512MB)
> 
> Thanks again for your feedback,
> 
> Julio
> 
