Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1NHx9F-00009A-Ob
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 10:18:25 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NHx9A-0000lm-RX
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 10:18:25 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nB8AIEQH032393
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Dec 2009 05:18:14 -0500
Received: from mail04.corp.redhat.com (zmail04.collab.prod.int.phx2.redhat.com
	[10.5.5.44])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id nB8AIEYu022147
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Dec 2009 05:18:14 -0500
Date: Tue, 8 Dec 2009 05:18:14 -0500 (EST)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1248829539.2041260267494377.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2094231667.2021260267473745.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_70_670116801.1260267494376"
Subject: [LTP] [PATCH]fix make install problem for ltp-full-20091130
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

------=_Part_70_670116801.1260267494376
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello, After I executed make all; make install, I want to 
execute runltp but it always fails. The error message is:

FATAL: Test suite not installed correctly
INFO: as root user type 'make ; make install'

I searched in Makefile and found the following code:

$(INSTALL_TARGETS) include-install lib-install:
	$(MAKE) -C "$(subst -install,,$@)" \
		-f "$(abs_top_srcdir)/$(subst -install,,$@)/Makefile" all

I think the last word maybe "install".

I modified it to install and ltp ran well. the patch could be 
found in the attachment.

Thanks,
Caspar
------=_Part_70_670116801.1260267494376
Content-Type: application/octet-stream; name=make-install-err.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=make-install-err.patch

--- ltp-full-20091130/Makefile.orig	2009-12-08 03:55:12.000000000 -0500
+++ ltp-full-20091130/Makefile	2009-12-08 03:55:22.000000000 -0500
@@ -144,7 +144,7 @@
 # the install target.
 $(INSTALL_TARGETS) include-install lib-install:
 	$(MAKE) -C "$(subst -install,,$@)" \
-		-f "$(abs_top_srcdir)/$(subst -install,,$@)/Makefile" all
+		-f "$(abs_top_srcdir)/$(subst -install,,$@)/Makefile" install 
 
 # Just in case configure hasn't been run yet, let's not overambitiously remove
 # the $(INSTALL_DIR).

------=_Part_70_670116801.1260267494376
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev

------=_Part_70_670116801.1260267494376
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_70_670116801.1260267494376--

