Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lina.zhao@windriver.com>) id 1Oj5i8-0006uE-6m
	for ltp-list@lists.sourceforge.net; Wed, 11 Aug 2010 07:26:52 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Oj5i4-0007d9-S0
	for ltp-list@lists.sourceforge.net; Wed, 11 Aug 2010 07:26:52 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o7B7QfQs021271
	for <ltp-list@lists.sourceforge.net>;
	Wed, 11 Aug 2010 00:26:41 -0700 (PDT)
Message-ID: <4C6250A7.1060200@windriver.com>
Date: Wed, 11 Aug 2010 15:26:31 +0800
From: "lina.zhao" <lina.zhao@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [ltp]rt_sigprocmask01.c issue
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
To: ltp-list@lists.sourceforge.net

Hi,

In rt_sigprocmask01.c:

 TEST(syscall(__NR_rt_sigpending, &oset,
                    SIGSETSIZE));
                if (TEST_RETURN == -1) {
                    tst_brkm(TFAIL|TTERRNO, cleanup,
                        "rt_sigpending call failed");
                }
                TEST(sigismember(&oset, TEST_SIG));
                if (TEST_RETURN == 0) {
                    tst_brkm(TFAIL|TTERRNO,
                        cleanup,
                        "sigismember call failed");
                }
                /* call rt_sigprocmask() to unblock
                 * signal#TEST_SIG */
                TEST(syscall(__NR_rt_sigprocmask,
                    SIG_UNBLOCK, &set, &oset, 8));

the SIGSETSIZE is 16 for mips, so in sigprocmask, the last parameter 
should be SIGSETSIZE too, not 8.

Regards,

Lina Zhao


------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
