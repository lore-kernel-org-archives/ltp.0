Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sumitbd@linsyssoft.com>) id 1OXxZI-0003OA-Ok
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 14:31:44 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OXxZE-00071o-SM
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 14:31:44 +0000
Received: by pwi10 with SMTP id 10so1607382pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 11 Jul 2010 07:31:35 -0700 (PDT)
From: sumitbd@linsyssoft.com
Date: Sun, 11 Jul 2010 18:55:32 +0530
Message-ID: <1278854732.8660.34.camel@sumit>
Mime-Version: 1.0
Subject: [LTP] [PATCH 1/3] MAKEFILE: testcases/network/Makefile - bug fixing
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

Testcase "nfs02" fails as script does not able to find  following files
ascii.jmb
ascii.lg
ascii.med
ascii.sm
This is because ltp's testcases/network/Makefile doesn't installed
those. It is fixed with following patch.

Index: ltp-full-20100630/testcases/network/Makefile
===================================================================
--- ltp-full-20100630.orig/testcases/network/Makefile
+++ ltp-full-20100630/testcases/network/Makefile
@@ -31,6 +31,7 @@ CLEAN_TARGETS		+= $(DIR)
 INSTALL_DIR		:= testcases/bin
 
 INSTALL_TARGETS		:= $(addprefix $(DIR)/bin.,sm med lg jmb)
+INSTALL_TARGETS		+= $(addprefix $(DIR)/ascii.,sm med lg jmb)
 
 RM			+= -r
 

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
