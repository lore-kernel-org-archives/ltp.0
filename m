Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1M9M1E-0005kv-Nj
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 16:30:20 +0000
Received: from mail-gx0-f170.google.com ([209.85.217.170])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M9M1E-0007XE-1u
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 16:30:20 +0000
MIME-Version: 1.0
Date: Wed, 27 May 2009 22:00:19 +0530
Message-ID: <f5a7b3810905270930p6811d70bx17f6b2b779332e1@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] patch for timer_create04 and clock_gettime03 issue.
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
To: rohit.170309@gmail.com
Cc: ltp-list@lists.sf.net

>> Hi,
>>
>> In reference to the issue with timer_create04 and clock_gettime03 for
>> the kernel version 2.6.29 which was reported in the link:
>> (http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.28). This
>> addition caused the above testcases to fail. Now, 5 clock ID's are
>> present in kernel ver 2.6.28 and later.
>>
>> Please check the same....
>>
>> Regards,
>> Rohit

>Thanks.

>Regards--
>Subrata

Thanks Rohit.
i have reported this issue two months back, since it was a pending issue.
Tested on 2.6.29 kernels working fine. test results log is at below this mail
Thanks for providing patch.


Best regards,
Naresh kamboju


-bash-3.2# ./timer_create04
timer_create04    1  PASS  :  timer_create(2) expected failure; Got
errno - EINVAL : Invalid parameter
timer_create04    2  PASS  :  timer_create(2) expected failure; Got
errno - EINVAL : Invalid parameter
timer_create04    3  PASS  :  timer_create(2) expected failure; Got
errno - EFAULT : Bad address
timer_create04    4  PASS  :  timer_create(2) expected failure; Got
errno - EFAULT : Bad address
timer_create04    5  PASS  :  timer_create(2) expected failure; Got
errno - EFAULT : Bad address
timer_create04    6  PASS  :  timer_create(2) expected failure; Got
errno - EFAULT : Bad address
-bash-3.2#

-bash-3.2# ./clock_gettime03
clock_gettime03    1  PASS  :  clock_gettime(2) expected failure; Got
errno - EFAULT : Bad address
clock_gettime03    2  PASS  :  clock_gettime(2) expected failure; Got
errno - EFAULT : Bad address
clock_gettime03    3  PASS  :  clock_gettime(2) expected failure; Got
errno - EINVAL : Invalid parameter
clock_gettime03    4  PASS  :  clock_gettime(2) expected failure; Got
errno - EINVAL : Invalid parameter
clock_gettime03    5  PASS  :  clock_gettime(2) expected failure; Got
errno - EFAULT : Bad address
clock_gettime03    6  PASS  :  clock_gettime(2) expected failure; Got
errno - EFAULT : Bad address
-bash-3.2#

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
