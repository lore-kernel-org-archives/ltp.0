Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MO7lD-0001Iu-Di
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 10:18:51 +0000
Received: from an-out-0708.google.com ([209.85.132.249])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MO7l5-0002nz-1Y
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 10:18:51 +0000
Received: by an-out-0708.google.com with SMTP id c38so1889046ana.37
	for <ltp-list@lists.sourceforge.net>;
	Tue, 07 Jul 2009 03:18:42 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 7 Jul 2009 03:12:08 -0700
Message-ID: <364299f40907070312w7250ccf6rf87ff97761521f49@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Compile failure with rt_sigaction on amd64
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>

    Oops... looks like someone forgot __amd64__ / __ia64__:

gcc -g -O2 -I../../include -g -Wall -I../../../../include -Wall -O2 -W
   rt_sigaction01.c  -L../../../../lib -lltp -o rt_sigaction01
rt_sigaction01.c: In function 'set_handler':
rt_sigaction01.c:147: error: 'SIGSETSIZE' undeclared (first use in
this function)
rt_sigaction01.c:147: error: (Each undeclared identifier is reported only once
rt_sigaction01.c:147: error: for each function it appears in.)
make[4]: *** [rt_sigaction01] Error 1
make[4]: Leaving directory
`/scratch/ltp-vanilla/ltp/testcases/kernel/syscalls/rt_sigaction'
make[3]: *** [all] Error 2
make[3]: Leaving directory `/scratch/ltp-vanilla/ltp/testcases/kernel/syscalls'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/scratch/ltp-vanilla/ltp/testcases/kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/scratch/ltp-vanilla/ltp/testcases'
make: *** [all] Error 2
gcooper@orangebox /scratch/ltp-vanilla/ltp $ uname -a
Linux orangebox 2.6.29-gentoo-r5 #2 SMP PREEMPT Sun Jun 14 01:11:32
PDT 2009 x86_64 Intel(R) Core(TM)2 Quad CPU Q9400 @ 2.66GHz
GenuineIntel GNU/Linux
gcooper@orangebox /scratch/ltp-vanilla/ltp $ grep -B 1 -A 1 SIGSETSIZE
/scratch/ltp-vanilla/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
#if defined __mips__
#define SIGSETSIZE 16
#endif
--
#if defined __arm__ || __i386__ || __powerpc__
#define SIGSETSIZE 8
#endif
--
                sigaddset(&sa.sa_mask, sig_to_mask);
                TEST(syscall(__NR_rt_sigaction,sig, &sa,
&oldaction,SIGSETSIZE));
        if (TEST_RETURN == 0) {

#endif

I tried using sizeof(sigaction_t), but unfortunately the results for
the testcase(s) on my system were always EINVAL. This issue wasn't
present a few days ago...

Any ideas?

Thanks,
-Garrett

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
