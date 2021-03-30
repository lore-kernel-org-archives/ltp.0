From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 30 Mar 2021 10:30:16 +0200
Subject: [LTP] [PATCH 2/2] pec: Fix multiple event test
In-Reply-To: <20210315092844.991073-2-lkml@jv-coder.de>
References: <20210315092844.991073-1-lkml@jv-coder.de>
 <20210315092844.991073-2-lkml@jv-coder.de>
Message-ID: <YGLhmNUg/JMrWjqt@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

I was not able to run this test without failures (using your original test, just
adding missing SAFE_EXECV(), see logs below.

Can you please review my fixes to first commit [1]
and after I merge it send v2 of this patch?

Thanks for working on this!

Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2021-March/021771.html

cn_pec 1 TINFO: timeout per run is 0h 5m 0s
cn_pec 1 TINFO: Test process events connector
cn_pec 1 TINFO: Testing fork event (nevents=10)
cn_pec 1 TPASS: All events detected
cn_pec 2 TINFO: Testing exec event (nevents=10)
cn_pec 2 TPASS: All events detected
cn_pec 3 TINFO: Testing exit event (nevents=10)
cn_pec 3 TFAIL: Event was not detected by the event listener: exit pid: 20816 exit_code: 0
none err: 0
exit pid: 20813 exit_code: 0 exit_signal: 17
fork parent: 20737, child: 20814
exit pid: 20814 exit_code: 0 exit_signal: 17
fork parent: 20737, child: 20815
exec pid: 20815
fork parent: 20815, child: 20816
exit pid: 20816 exit_code: 0 exit_signal: 17
fork parent: 20815, child: 20817
exit pid: 20817 exit_code: 0 exit_signal: 17
fork parent: 20815, child: 20818
exit pid: 20818 exit_code: 0 exit_signal: 17
fork parent: 20815, child: 20819
exit pid: 20819 exit_code: 0 exit_signal: 17
fork parent: 20815, child: 20820
exit pid: 20820 exit_code: 0 exit_signal: 17
fork parent: 20815, child: 20821
exit pid: 20821 exit_code: 0 exit_signal: 17
fork parent: 20815, child: 20822
exit pid: 20822 exit_code: 0 exit_signal: 17
fork parent: 20815, child: 20823
exit pid: 20823 exit_code: 0 exit_signal: 17
fork parent: 20815, child: 20824
exit pid: 20824 exit_code: 0 exit_signal: 17
fork parent: 20815, child: 20825
exit pid: 20825 exit_code: 0 exit_signal: 17
exit pid: 20815 exit_code: 0 exit_signal: 17
cn_pec 4 TINFO: Testing uid event (nevents=10)
cn_pec 4 TFAIL: Event was not detected by the event listener: uid pid: 20844 euid: 65534
none err: 0
exit pid: 17409 exit_code: 0 exit_signal: 17
exit pid: 20842 exit_code: 0 exit_signal: 17
fork parent: 20737, child: 20843
exit pid: 20843 exit_code: 0 exit_signal: 17
fork parent: 20737, child: 20844
exec pid: 20844
uid pid: 20844 euid: 65534 ruid: 65534
exit pid: 20844 exit_code: 0 exit_signal: 17
cn_pec 5 TINFO: Testing gid event (nevents=10)
cn_pec 5 TFAIL: Event was not detected by the event listener: gid pid: 20863 egid: 65533
none err: 0
exit pid: 20861 exit_code: 0 exit_signal: 17
fork parent: 20737, child: 20862
exit pid: 20862 exit_code: 0 exit_signal: 17
fork parent: 20737, child: 20863
exec pid: 20863
gid pid: 20863 egid: 65533 rgid: 65533
exit pid: 20863 exit_code: 0 exit_signal: 17
cn_pec 6 TINFO: AppArmor enabled, this may affect test results
cn_pec 6 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
cn_pec 6 TINFO: loaded AppArmor profiles: none

Summary:
passed   2
failed   3
skipped  0
warnings 0


Kind regards,
Petr
