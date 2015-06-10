Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z2a19-0004Eb-Rb
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:01:43 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z2a18-0005WH-2m
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 07:01:43 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPP02OPSVIDMMB0@mailout1.samsung.com> for
	ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 16:01:25 +0900 (KST)
Date: Wed, 10 Jun 2015 07:01:32 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <993022606.810141433919692343.JavaMail.weblogic@epmlwas05b>
Subject: [LTP] [Patch 0/8] remove explicit NULL check before free
Reply-To: maninder1.s@samsung.com
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

Following patch set remove explicit NULL check before free(*ptr), because in free If ptr is NULL, no operation is performed.
So no need of NULL check before free.

patches created with below coccinelle patch:-

@@
expression E;
@@
- if (E)
-       free(E);
+ free(E);

Thanks 
Maninder Singh
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
