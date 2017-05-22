From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 May 2017 14:04:00 +0200
Subject: [LTP] [PATCH v2] [RFC] pselect01: Tune thresholds
In-Reply-To: <1308561590.18511159.1495442352952.JavaMail.zimbra@redhat.com>
References: <20170512141658.26810-1-chrubis@suse.cz>
 <495691788.11461692.1494842630946.JavaMail.zimbra@redhat.com>
 <20170515123556.GA8280@rei.lan>
 <1832031935.11522951.1494853219630.JavaMail.zimbra@redhat.com>
 <20170515131329.GA12586@rei.suse.de>
 <1308561590.18511159.1495442352952.JavaMail.zimbra@redhat.com>
Message-ID: <20170522120400.GB11771@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm seeing this test failing a lot now on RHEL6/7 as some cases are
> now more strict. 
> 
> ppc KVM guest
> pselect01.c:131: FAIL: pselect() slept for too long 1006090us, expected 1000000us, threshold 2750
>
> slow x86 bare metal system
> pselect01.c:145: INFO: CLOCK_MONOTONIC resolution 1 ns
> pselect01.c:86: INFO: pselect() sleeping for 0 secs 1000000 nsec 500 iterations
> pselect01.c:118: INFO: Mean sleep time 1237.06 us, expected 1000 us, threshold 251.00
> pselect01.c:136: PASS: pselect() slept for 618532us, requested 500000us, treshold 125500
> pselect01.c:86: INFO: pselect() sleeping for 0 secs 2000000 nsec 500 iterations
> pselect01.c:118: INFO: Mean sleep time 2610.75 us, expected 2000 us, threshold 252.00
> pselect01.c:131: FAIL: pselect() slept for too long 1305373us, expected 1000000us, threshold 126000
> pselect01.c:86: INFO: pselect() sleeping for 0 secs 10000000 nsec 300 iterations
> pselect01.c:118: INFO: Mean sleep time 10590.66 us, expected 10000 us, threshold 260.00
> pselect01.c:131: FAIL: pselect() slept for too long 3177198us, expected 3000000us, threshold 78000

What kind of a system is that (hardware/kernel)?

Have you tried that measure.c program I've send you there as well?

Maybe we should just try to discard something as 5% of the outliners as
well. I.e. storing the measured times in an array, sort it and discard
some of the measurements.

> pselect01.c:86: INFO: pselect() sleeping for 0 secs 100000000 nsec 1 iterations
> pselect01.c:136: PASS: pselect() slept for 100670us, requested 100000us, treshold 1850
> pselect01.c:86: INFO: pselect() sleeping for 1 secs 0 nsec 1 iterations
> pselect01.c:136: PASS: pselect() slept for 1001063us, requested 1000000us, treshold 2750
> 
> x86 kvm guest
> pselect01.c:145: INFO: CLOCK_MONOTONIC resolution 1 ns
> pselect01.c:86: INFO: pselect() sleeping for 0 secs 1000000 nsec 500 iterations
> pselect01.c:118: INFO: Mean sleep time 1251.76 us, expected 1000 us, threshold 251.00
> pselect01.c:131: FAIL: pselect() slept for too long 625882us, expected 500000us, threshold 125500
> pselect01.c:86: INFO: pselect() sleeping for 0 secs 2000000 nsec 500 iterations
> pselect01.c:118: INFO: Mean sleep time 2256.17 us, expected 2000 us, threshold 252.00
> pselect01.c:131: FAIL: pselect() slept for too long 1128083us, expected 1000000us, threshold 126000
> pselect01.c:86: INFO: pselect() sleeping for 0 secs 10000000 nsec 300 iterations
> pselect01.c:118: INFO: Mean sleep time 10257.38 us, expected 10000 us, threshold 260.00
> pselect01.c:136: PASS: pselect() slept for 3077214us, requested 3000000us, treshold 78000
> pselect01.c:86: INFO: pselect() sleeping for 0 secs 100000000 nsec 1 iterations
> pselect01.c:136: PASS: pselect() slept for 100283us, requested 100000us, treshold 1850
> pselect01.c:86: INFO: pselect() sleeping for 1 secs 0 nsec 1 iterations
> pselect01.c:136: PASS: pselect() slept for 1001068us, requested 1000000us, treshold 2750

These are failing just by a small bit, does the test work fine there if
you increase the static part of the threshold by 50?

-- 
Cyril Hrubis
chrubis@suse.cz
