Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sumitbd@linsyssoft.com>) id 1OXwwR-0007Fh-Kg
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 13:51:35 +0000
Received: from mail-px0-f175.google.com ([209.85.212.175])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OXwwP-0001Hc-El
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 13:51:35 +0000
Received: by pxi12 with SMTP id 12so622604pxi.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 11 Jul 2010 06:51:27 -0700 (PDT)
From: sumitbd@linsyssoft.com
Date: Sun, 11 Jul 2010 18:26:47 +0530
Message-ID: <1278853007.8660.7.camel@sumit>
Mime-Version: 1.0
Subject: [LTP]  [PATCH 0/3] nfstests: Bug Fixing
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

I am working on LTP-20100630. While doing networktest for nfs, I came
across to following bugs.
I have fixed these bugs  and created a patch which is I am sending in
subsequent mail.

[PATCH 1/3] MAKEFILE: testcases/network/Makefile - bug fixing
[PATCH 2/3] nfs02: testcases/network/nfs/nfs02/nfs02 script - bug fixing
[PATCH 3/3] runtest/nfs: TCbin path not exported for few tests
After applying above patches networktest for nfs completed successfully.

Thanks & Regards
Sumit Dhoot
System Administrator
Linsyssoft Technologies Pvt. Ltd.
sumitbd@linsyssoft.com


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
