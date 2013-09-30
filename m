Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rameshyr@linux.vnet.ibm.com>) id 1VQd4k-0005Br-4R
	for ltp-list@lists.sourceforge.net; Mon, 30 Sep 2013 12:59:46 +0000
Received: from e28smtp03.in.ibm.com ([122.248.162.3])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VQd4i-0002Ti-Ea
	for ltp-list@lists.sourceforge.net; Mon, 30 Sep 2013 12:59:46 +0000
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <rameshyr@linux.vnet.ibm.com>;
	Mon, 30 Sep 2013 18:29:36 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6877D125805D
	for <ltp-list@lists.sourceforge.net>;
	Mon, 30 Sep 2013 18:29:50 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r8UD1wLi9896128
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Sep 2013 18:31:58 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	r8UCxVBS006419
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Sep 2013 18:29:31 +0530
Message-ID: <524975B2.3020707@linux.vnet.ibm.com>
Date: Mon, 30 Sep 2013 18:29:30 +0530
From: Ramesh <rameshyr@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <52491AD8.7080706@linux.vnet.ibm.com>
	<1221340559.257649.1380524638301.JavaMail.root@redhat.com>
In-Reply-To: <1221340559.257649.1380524638301.JavaMail.root@redhat.com>
Subject: Re: [LTP] clock_settime03 test fails on kernel-2.6.32
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
To: Jan Stancek <jstancek@redhat.com>, ltp-list@lists.sourceforge.net

On 09/30/2013 12:33 PM, Jan Stancek wrote:
>
>
>
> ----- Original Message -----
>> From: "Ramesh" <rameshyr@linux.vnet.ibm.com>
>> To: ltp-list@lists.sourceforge.net
>> Sent: Monday, 30 September, 2013 8:31:52 AM
>> Subject: [LTP] clock_settime03 test fails on kernel-2.6.32
>>
>> Hi All,
>>
>> I am facing some issues with clock_settim03 test of timers group.
>> clock_settime03 evaluates
>> the error condition of clock_settime systemcall. On my machine, TEST8 &
>> TEST9 are failing as
>> the expeted error is not equal to the actual error.
>>
>> After analysis, I found that the TEST8 & TEST9 are trying to
>> set CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID respectively.
>> But from the man pages, it says that
>> "According to POSIX.1-2001, the CLOCK_PROCESS_CPUTIME_ID and
>> CLOCK_THREAD_CPUTIME_ID
>>    clocks should be settable using  clock_settime(). How-ever, the clocks
>> currently are not settable".
>>
>> Also, in the below code snippet of
>> ltp/testcases/kernel/timers/clock_settime/clock_settime03.c
>> the if statement looks nothing for my kernel-2.6.32. So, the value of
>> testcases[7] and testcases[8]
>> will get assigned to EFAULT but actually both of them should get set to
>> EINVAL as the support is not
>> available on kernel-2.6.32.
>>
>> -----------
>>
>>           /* PROCESS_CPUTIME_ID & THREAD_CPUTIME_ID are not supported on
>>            * kernel versions lower than 2.6.12 and changed back in 2.6.38
>>            */
>>           if ((tst_kvercmp(2, 6, 12)) < 0 || (tst_kvercmp(2, 6, 38)) >= 0) {
>>                   testcases[7] = EINVAL;
>>                   testcases[8] = EINVAL;
>>           } else {
>>                   testcases[7] = EFAULT;
>>                   testcases[8] = EFAULT;
>>           }
>>
>> ------------
>>
>> I would like to know from which version onwards the
>> CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID
>> clocks can be set using clock_settime() so that I can generate a valid
>> patch for this testcase.
> Hi,
>
> what LTP version are you running?
I am using may-2013 version of LTP.
Thanks for pointing to the fix, its available in Sep-2013 build.

Regards,
Ramesh
> Can you check if it has following commit:
> https://github.com/linux-test-project/ltp/commit/a2d159595a761da1626b3f489dfe9cf2c351b774
>
> Regards,
> Jan
>
>>
>>
>> Regards,
>> Ramesh
>>
>>
>> ------------------------------------------------------------------------------
>> October Webinars: Code for Performance
>> Free Intel webinars can help you accelerate application performance.
>> Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from
>> the latest Intel processors and coprocessors. See abstracts and register >
>> http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
