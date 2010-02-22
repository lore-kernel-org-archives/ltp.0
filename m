Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1NjT9J-0006aB-Qu
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 07:56:13 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NjT9I-0007Rc-0f
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 07:56:13 +0000
Message-ID: <4B823884.4000100@cn.fujitsu.com>
Date: Mon, 22 Feb 2010 15:55:48 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
References: <4B728073.3070209@cn.fujitsu.com>	
	<4B7B9EC2.1010004@linux.vnet.ibm.com>
	<364299f41002170914u3a0d0b02o936a81d1ee601ecc@mail.gmail.com>
In-Reply-To: <364299f41002170914u3a0d0b02o936a81d1ee601ecc@mail.gmail.com>
Subject: Re: [LTP] [PATCH] timers: support clockid of
	CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

at 2010-2-18 1:14, Garrett Cooper wrote:
> On Tue, Feb 16, 2010 at 11:46 PM, Rishikesh <risrajak@linux.vnet.ibm.com> wrote:
>> On 02/10/2010 03:16 PM, Shi Weihua wrote:
>>> mainline commit da15cfdae03351c689736f8d142618592e3cebc3
>>>   (subject: time: Introduce CLOCK_REALTIME_COARSE)
>>> added two clocks (CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE) in
>>> 2.6.32-rc1, but it has not been responded in ltp. then, the following
>>> error message occured.
>>> -----
>>> clock_gettime03    3  TFAIL  :  failed to produce expected error [expected errno = 22 (Invalid argument), TEST_RETURN = 0]: TEST_ERRNO=???(0): Success
>>> clock_gettime03    4  TFAIL  :  failed to produce expected error [expected errno = 22 (Invalid argument), TEST_RETURN = 0]: TEST_ERRNO=???(0): Success
>>> timer_create04    1  TFAIL  :  didn't fail as expected [expected errno = 22 (Invalid argument)]: TEST_ERRNO=???(95): Operation not supported
>>> timer_create04    2  TFAIL  :  didn't fail as expected [expected errno = 22 (Invalid argument)]: TEST_ERRNO=???(95): Operation not supported
>>> -----
>>>
>>> Following patch fixed this bug. and, passed on 2.6.32-rc1, 2.6.33-rc6, 2.6.23.1-42.fc8.
>>>
>>
>> Can anyone provide their review & Acked ?
>>
>> Thanks "Shi Weihua" for patch.
> 
> 1. Please provide before and after (once the items were fixed) output.

before:
------
clock_gettime03    1  TPASS  :  got expected failure: TEST_ERRNO=EFAULT(14): Bad address
clock_gettime03    2  TPASS  :  got expected failure: TEST_ERRNO=EFAULT(14): Bad address
clock_gettime03    3  TFAIL  :  failed to produce expected error [expected errno = 22 (Invalid argument), TEST_RETURN = 0]: TEST_ERRNO=???(0): Success
clock_gettime03    4  TFAIL  :  failed to produce expected error [expected errno = 22 (Invalid argument), TEST_RETURN = 0]: TEST_ERRNO=???(0): Success
clock_gettime03    5  TPASS  :  got expected failure: TEST_ERRNO=EFAULT(14): Bad address
clock_gettime03    6  TPASS  :  got expected failure: TEST_ERRNO=EFAULT(14): Bad address
<snip>
timer_create04    1  TFAIL  :  didn't fail as expected [expected errno = 22 (Invalid argument)]: TEST_ERRNO=???(95): Operation not supported
timer_create04    2  TFAIL  :  didn't fail as expected [expected errno = 22 (Invalid argument)]: TEST_ERRNO=???(95): Operation not supported
timer_create04    3  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad address
timer_create04    4  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad address
timer_create04    5  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad address
timer_create04    6  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad address
------

after ( patch merged )
------
clock_gettime03    1  TPASS  :  got expected failure: TEST_ERRNO=EFAULT(14): Bad address
clock_gettime03    2  TPASS  :  got expected failure: TEST_ERRNO=EFAULT(14): Bad address
clock_gettime03    3  TPASS  :  got expected failure: TEST_ERRNO=EINVAL(22): Invalid argument
clock_gettime03    4  TPASS  :  got expected failure: TEST_ERRNO=EINVAL(22): Invalid argument
clock_gettime03    5  TPASS  :  got expected failure: TEST_ERRNO=EFAULT(14): Bad address
clock_gettime03    6  TPASS  :  got expected failure: TEST_ERRNO=EFAULT(14): Bad address
<snip>
timer_create04    1  TPASS  :  failed as expected: TEST_ERRNO=EINVAL(22): Invalid argument
timer_create04    2  TPASS  :  failed as expected: TEST_ERRNO=EINVAL(22): Invalid argument
timer_create04    3  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad address
timer_create04    4  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad address
timer_create04    5  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad address
timer_create04    6  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad address
------

> 2. *sigh* These constants should be autoconf conditionalized --
> otherwise when Linux devs decide to change their minds about the
> values of the constants or the values are different on different
> architectures you'll run into red-herring errors. The test should be
> resistant to this behavior, but currently isn't. This would also
> prevent `ENOSYS'-like errors from showing up on kernels < 2.6.32-rc1.

i checked the frequency of adding clock in include/linux/time.h.
  2005-04-16	CLOCK_REALTIME/CLOCK_MONOTONIC/CLOCK_PROCESS_CPUTIME_ID/CLOCK_THREAD_CPUTIME_ID
                (when git initialized) 
  2008-08-21	CLOCK_MONOTONIC_RAW added
  2009-08-21	CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE added
  (from http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=include/linux/time.h;h=6e026e45a179e2c66b347eb3834501a13be7ee2e;hb=aea187c46f7d03ce985e55eb1398d0776a15b928)
so, the frequency is slow, i think.
And, should to accept my patch at first. ;-)

> 
> Thanks,
> -Garrett
> 
> 

-- 
Shi Weihua

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
