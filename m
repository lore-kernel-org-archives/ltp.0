Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <manjeet.p@samsung.com>) id 1ZKoZv-0002Lp-Jk
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 14:12:59 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZKoZt-0003JD-M7
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 14:12:59 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NSB0190C0TEIH60@mailout4.samsung.com> for
	ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 23:12:50 +0900 (KST)
Date: Thu, 30 Jul 2015 14:12:50 +0000 (GMT)
From: Manjeet Pawar <manjeet.p@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <709268354.243831438265570214.JavaMail.weblogic@epmlwas09a>
Subject: [LTP]  [Query] Regarding netns testcases
Reply-To: manjeet.p@samsung.com
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
Cc: "ajeet.y@samsung.com" <ajeet.y@samsung.com>, Rohit Thapliyal <r.thapliyal@samsung.com>, "pankaj.m@samsung.com" <pankaj.m@samsung.com>

Hi,
I am facing crash while executing below netns testcases on ARM:

netns_crtchild   
netns_two_children_ns 
netns_crtchild_delchild 
netns_par_chld_ipv6  
netns_par_chld_ftp  
netns_netlink   

After analysis of crash , it is found that all are crashing due to a common cause.
-----------------------------------------------------------
Backtrace:
do_unshare_tests() --> crashes while call NULL function pointer
do_clone_unshare_test() -- > pass NULL fuction pointer
check_netns() -->  passes function ptr as NULL
setup()
main()
------------------------------------------------------------
Culprit function:- (netns_helper.h)
pid = do_clone_unshare_test(T_UNSHARE, CLONE_NEWNET | CLONE_NEWNS, NULL,
            NULL);

Third argument passing to this function is NULL, which is not appropriate here, since it is derefrence by do_unshare_tests().
Kindly check this issue.




------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
