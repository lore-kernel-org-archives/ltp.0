Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1MTthV-0007iG-Ch
	for ltp-list@lists.sourceforge.net; Thu, 23 Jul 2009 08:30:53 +0000
Received: from mail-pz0-f175.google.com ([209.85.222.175])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MTthL-0006cu-Fx
	for ltp-list@lists.sourceforge.net; Thu, 23 Jul 2009 08:30:52 +0000
MIME-Version: 1.0
Date: Thu, 23 Jul 2009 14:00:42 +0530
Message-ID: <d51f89b0907230130k158cbfbeo31f290cf207432b6@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Subject: [LTP] waitid02 testcase fails on 2.6.29 kernel
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
To: ltp-list <ltp-list@lists.sf.net>

Hi,

I am running waitid02.c
(ltp-full-20090630/testcases/kernel/syscalls/waitid/ ) test case on
2.6.29 kernel.
Test case gives following error:
"Error. is your system >2.6.9 ?";

 Anybody facing the same issue?

Code:

TEST(waitid(P_ALL,0,&infop,WNOHANG));
        if(TEST_RETURN == 0)
                tst_resm(TPASS,"Success !");
        else{
                printf("value of return is %d\n",TEST_RETURN);
                tst_resm(TFAIL,"Error. is your system >2.6.9 ?");
               errnochoose();
        }


Regards,
Rohit

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
