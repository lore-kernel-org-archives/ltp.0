Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SPYGu-0002bX-8Z
	for ltp-list@lists.sourceforge.net; Wed, 02 May 2012 12:03:04 +0000
Date: Wed, 2 May 2012 14:01:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120502120112.GA366@saboteur.suse.cz>
References: <B7E6FC224F02D64480BFC86AA60E9566267B9332@SZXEML511-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <B7E6FC224F02D64480BFC86AA60E9566267B9332@SZXEML511-MBS.china.huawei.com>
Subject: Re: [LTP] Why LTP expect to get EFAULT error on sigtimedwait01 case
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
To: "Maxiansheng (Max)" <max.maxiansheng@huawei.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> We are testing several embedded Linux. When we use LTP to test these Linux, we find that the testcase sigtimedwait01 always failed with Segment Fault.
> 
> As the testcase failed on x86_64, i586 and arm, we found that maybe glibc doesn??t deal with the bad address
> 
> The testcase C program file is : testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo.c
> 
> The result is :
> sigtimedwait01    6  TPASS  :  Test passed
> sigtimedwait01    0  TINFO  :  0x80493c0, 10
> sigtimedwait01    7  TBROK  :  unexpected signal 11 received (pid = 4057).
> sigtimedwait01    8  TBROK  :  Remaining cases broken
> 
> it always fail after line 334, because of Segment Fault
> 332 void test_bad_address2(swi_func sigwaitinfo, int signo)
> 333 {
> 334         TEST(sigwaitinfo((void*)1, NULL, NULL);
> 335         REPORT_SUCCESS(-1, EFAULT);
> 336 }
> 
> We can see that, here, we do
> 
> Sigtimedwait((void*)1, NULL, NULL));
> 
> And the parameter (void *)1 is a bad address.
> 
> This test can make things easier.
> 
> #include <stdio.h>
> #include <signal.h>
> 
> int main()
> {
>         int ret;
>         ret = sigtimedwait((void*)1, NULL, NULL);
>         printf("test end\n");
>         return 0;
> }
> 
> Why LTP expect to get the EFAULT error?

Hmm, that is dumbious test indeed, as the EFAULT isn't specified in
manual page as possible errno. Moreover if you look into the
corresponding glibc source (sysdeps/unix/sysv/linux/sigtimedwait.c) the
first parameter is dereferenced before the actual syscall is done.

Digging in glibc git log the checks for SIGCANCEL and SIGSETXID were
added around year 2003. I suspect that the test was working fine
beforehand.

My conclusion is that the test for bad address is wrong and should be
removed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
