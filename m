From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Dec 2017 10:04:33 -0500 (EST)
Subject: [LTP] [PATCH V3] ltp: Add a zero latency constraint for the
 timer tests library
In-Reply-To: <ac23cc27-b5a8-f710-17c9-2f7ad55f2185@linaro.org>
References: <20170817135029.GA31322@rei>
 <1502982026-4113-1-git-send-email-daniel.lezcano@linaro.org>
 <20170818122533.GD22319@rei.lan>
 <1864131650.54048676.1513090088938.JavaMail.zimbra@redhat.com>
 <ac23cc27-b5a8-f710-17c9-2f7ad55f2185@linaro.org>
Message-ID: <1566390724.54053292.1513091073892.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it



----- Original Message -----
> On 12/12/2017 15:48, Jan Stancek wrote:
> > Hi,
> >=20
> > I'm running into similar problem on "Dell Precision 5820 tower", with
> > Intel(R) Xeon(R) W-2133 CPU @ 3.60GHz, but I can't find any /proc /sys
> > knob that would help.
> >=20
> > # uname -r
> > 4.14.5
> >=20
> > # cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> > performance
> > performance
> > performance
> > performance
> > performance
> > performance
> > performance
> > performance
> > performance
> > performance
> > performance
> > performance
> >=20
> > Any timer related tests are reliably failing on longer timeouts:
> > ---
> > tst_test.c:934: INFO: Timeout per run is 0h 05m 00s
> > tst_timer_test.c:356: INFO: CLOCK_MONOTONIC resolution 1ns
> > tst_timer_test.c:368: INFO: prctl(PR_GET_TIMERSLACK) =3D 50us
> > tst_timer_test.c:275: INFO: poll() sleeping for 1000us 500 iterations,
> > threshold 450.01us
> > tst_timer_test.c:318: INFO: min 1095us, max 1098us, median 1096us, trunc
> > mean 1095.99us (discarded 25)
> > tst_timer_test.c:333: PASS: Measured times are within thresholds
> > tst_timer_test.c:275: INFO: poll() sleeping for 2000us 500 iterations,
> > threshold 450.01us
> > tst_timer_test.c:318: INFO: min 2062us, max 2138us, median 2137us, trunc
> > mean 2135.98us (discarded 25)
> > tst_timer_test.c:333: PASS: Measured times are within thresholds
> > tst_timer_test.c:275: INFO: poll() sleeping for 5000us 300 iterations,
> > threshold 450.04us
> > tst_timer_test.c:318: INFO: min 5262us, max 5263us, median 5262us, trunc
> > mean 5262.20us (discarded 15)
> > tst_timer_test.c:333: PASS: Measured times are within thresholds
> > tst_timer_test.c:275: INFO: poll() sleeping for 10000us 100 iterations,
> > threshold 450.33us
> > tst_timer_test.c:318: INFO: min 10318us, max 10471us, median 10471us, t=
runc
> > mean 10469.07us (discarded 5)
> > tst_timer_test.c:321: FAIL: poll() slept for too long
>=20
> Are you running the tests with this zero latency patch included ?

Yes, I'm running ltp release 20170929, which has your patch.

...
[pid 18276] 09:59:21.379883 open("/dev/cpu_dma_latency", O_WRONLY) =3D 3
[pid 18276] 09:59:21.379906 write(3, "\0\0\0\0", 4) =3D 4
...

I tried it without that patch, and it started failing more with smaller
timeouts.

Regards,
Jan

>=20
>=20
> > SCHED_OTHER or SCHED_FIFO -> FAIL
> > intel_idle.max_cstate=3D0 processor.max_cstate=3D1 -> FAIL
> > echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo -> FAIL
> > idle=3Dhalt -> FAIL
> > idle=3Dpoll -> FAIL
> >=20
> > Only thing I found to help is to keep CPU slightly busy with
> >   taskset -c 1 sh -c "while [ True ]; do usleep 100; done"
> >=20
> > After that it started to PASS:
> >=20
> > # taskset -c 1 ./poll02
> > tst_test.c:934: INFO: Timeout per run is 0h 05m 00s
> > tst_timer_test.c:356: INFO: CLOCK_MONOTONIC resolution 1ns
> > tst_timer_test.c:368: INFO: prctl(PR_GET_TIMERSLACK) =3D 50us
> > tst_timer_test.c:275: INFO: poll() sleeping for 1000us 500 iterations,
> > threshold 450.01us
> > tst_timer_test.c:318: INFO: min 1004us, max 1325us, median 1072us, trunc
> > mean 1149.29us (discarded 25)
> > tst_timer_test.c:333: PASS: Measured times are within thresholds
> > tst_timer_test.c:275: INFO: poll() sleeping for 2000us 500 iterations,
> > threshold 450.01us
> > tst_timer_test.c:318: INFO: min 2007us, max 2326us, median 2075us, trunc
> > mean 2158.64us (discarded 25)
> > tst_timer_test.c:333: PASS: Measured times are within thresholds
> > tst_timer_test.c:275: INFO: poll() sleeping for 5000us 300 iterations,
> > threshold 450.04us
> > tst_timer_test.c:318: INFO: min 5006us, max 5345us, median 5074us, trunc
> > mean 5146.84us (discarded 15)
> > tst_timer_test.c:333: PASS: Measured times are within thresholds
> > tst_timer_test.c:275: INFO: poll() sleeping for 10000us 100 iterations,
> > threshold 450.33us
> > tst_timer_test.c:318: INFO: min 10004us, max 10364us, median 10075us, t=
runc
> > mean 10128.61us (discarded 5)
> > tst_timer_test.c:333: PASS: Measured times are within thresholds
> > tst_timer_test.c:275: INFO: poll() sleeping for 25000us 50 iterations,
> > threshold 451.29us
> > tst_timer_test.c:318: INFO: min 25006us, max 25359us, median 25072us, t=
runc
> > mean 25137.48us (discarded 2)
> > tst_timer_test.c:333: PASS: Measured times are within thresholds
> > tst_timer_test.c:275: INFO: poll() sleeping for 100000us 10 iterations,
> > threshold 537.00us
> > tst_timer_test.c:318: INFO: min 100010us, max 100372us, median 100125us,
> > trunc mean 100167.78us (discarded 1)
> > tst_timer_test.c:333: PASS: Measured times are within thresholds
> > tst_timer_test.c:275: INFO: poll() sleeping for 1000000us 2 iterations,
> > threshold 4400.00us
> > tst_timer_test.c:318: INFO: min 1000843us, max 1000920us, median 100084=
3us,
> > trunc mean 1000843.00us (discarded 1)
> > tst_timer_test.c:333: PASS: Measured times are within thresholds
> >=20
> > Summary:
> > passed   7
> > failed   0
> > skipped  0
> > warnings 0
> >=20
> > Any ideas?
> >=20
> > Regards,
> > Jan
> >=20
>=20
>=20
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20
>=20
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>=20
