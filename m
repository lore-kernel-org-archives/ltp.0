From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 3 Jan 2017 04:14:48 -0500 (EST)
Subject: [LTP] On the performance of lcov...
In-Reply-To: <02d71729-2501-cabf-fed0-6f4cc716f565@giref.ulaval.ca>
References: <11e74d02-aec3-04c2-a001-39966d8d3430@giref.ulaval.ca>
 <650748346.6300043.1482001595688.JavaMail.zimbra@redhat.com>
 <a72c1e6a-f963-9eed-ad70-43f1879c43f3@giref.ulaval.ca>
 <02d71729-2501-cabf-fed0-6f4cc716f565@giref.ulaval.ca>
Message-ID: <2053906238.432129.1483434888054.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Eric Chamberland" <Eric.Chamberland@giref.ulaval.ca>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 19 December, 2016 8:07:40 PM
> Subject: Re: [LTP] On the performance of lcov...
> 
> Hi,
> 
> As suggested, I introduced:
> cat ~/.lcovrc
> geninfo_gcov_all_blocks=0
> 
> Now the timings for each steps (see 1st mail) are:
> 
> Now    ; Before
> ================
> 600s   ; 660s
> 1269s  ; 2113s
> 2815s  ; 3112s
> 2305s  ; 2227s
> 1401s  ; 1391s
> ================
> total:
> 8390s ; 9503s
> 
> So there is a good gain in the 2nd step, but overall, no big changes...
> 
> I am using
> gcov -v
> gcov (SUSE Linux) 4.8.1 20130909 [gcc-4_8-branch revision 202388]
> 
> lcov -v
> lcov: LCOV version 1.12
> 
> Are there any other hints or is it "normal" to have these timings?

Hi,

I'd try to drop lcov_branch_coverage=1 from command line. Or if you need
coverage only for part of kernel tree, add also "-k" parameter.

I ran following on randomly picked RHEL7.3 x86 host and these are my numbers:

Intel(R) Xeon(R) CPU E5-2470 v2 @ 2.40GHz

# cat /etc/redhat-release 
Red Hat Enterprise Linux Server release 7.3 (Maipo)

# rpm -qa lcov
lcov-1.13-1.noarch

# uname -r
3.10.0-512.el7.gcov.x86_64

# rpm -qa gcc
gcc-4.8.5-11.el7.x86_64

# grep block /etc/lcovrc 
# Use gcov's --all-blocks option if non-zero
geninfo_gcov_all_blocks = 0

# time lcov -i -c --output-file initial.cov

real    4m11.983s
user    3m38.892s
sys     0m3.400s

# time lcov -c --output-file second.cov

real    4m14.554s
user    3m51.681s
sys     0m22.913s

# time lcov -a initial.cov -a second.cov -o total.cov
Summary coverage rate:
  lines......: 7.2% (189840 of 2654202 lines)
  functions..: 9.1% (18434 of 203509 functions)
  branches...: no data found

real    0m25.222s
user    0m24.528s
sys     0m0.696s

# time genhtml -o /var/www/html/test/ total.cov

real    7m25.938s
user    4m58.467s
sys     2m30.020s

> Am I posting to the right list to discuss about lcov performance?

lcov is maintained separately (mostly by its author) [1], so I'd try to CC
ltp-coverage@lists.sourceforge.net and Peter Oberparleiter.

[1] http://ltp.sourceforge.net/coverage/lcov.php

Regards,
Jan
