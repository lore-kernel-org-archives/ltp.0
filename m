Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1ObwQQ-0007VT-42
	for ltp-list@lists.sourceforge.net; Thu, 22 Jul 2010 14:07:02 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 0AB3C867E2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 22 Jul 2010 16:06:52 +0200 (CEST)
Date: Thu, 22 Jul 2010 16:22:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100722142216.GA3593@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
Subject: [LTP] [PATCH] fix make install in ltp/testcacses/realtime/
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


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
When doing 'make install' in ltp/testcases/realtime/ the process stops
because the dummy makefile generated from empty Makefile.am is not
correct makefile (has unmakeable targets). This could be easily fixed by
adding m4 to FILTER_OUT_DIRS.

Patch attached.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--jRHKVT23PllUwdXP
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="realtime_makefile.patch"

Index: ltp-full-20100630/testcases/realtime/Makefile
===================================================================
--- ltp-full-20100630.orig/testcases/realtime/Makefile
+++ ltp-full-20100630/testcases/realtime/Makefile
@@ -38,7 +38,7 @@ include $(abs_srcdir)/config.mk
 endif
 
 LIBDIR			:= lib
-FILTER_OUT_DIRS		:= $(LIBDIR)
+FILTER_OUT_DIRS		:= $(LIBDIR) m4
 LIB			:= $(LIBDIR)/librealtime.a
 
 # START autotools junk

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
--jRHKVT23PllUwdXP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--jRHKVT23PllUwdXP--

