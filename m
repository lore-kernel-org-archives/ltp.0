Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WZymb-00086e-Df
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 08:31:57 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WZyma-0005bN-0k
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 08:31:57 +0000
From: Mats Liljegren <mats.liljegren@enea.com>
Date: Tue, 15 Apr 2014 10:31:15 +0200
Message-ID: <1397550675-25420-2-git-send-email-mats.liljegren@enea.com>
In-Reply-To: <1397550675-25420-1-git-send-email-mats.liljegren@enea.com>
References: <20140414174105.GA26543@rei>
	<1397550675-25420-1-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] utils/Makefile: Move ffsb configure to configure.ac
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
Cc: Fathi Boudra <fathi.boudra@linaro.org>

The configure call was done from make file without appropriate parameters,
which breaks cross-compiling. Include ffsb into configure.ac so that it is
included in the main configure call.

This fix is based on a patch by Fathi Boudra <fathi.boudra@linaro.org> for an
earlier version of LTP.

CC: Fathi Boudra <fathi.boudra@linaro.org>
Signed-off-by: Mats Liljegren <mats.liljegren@enea.com>
---
 configure.ac   |    2 ++
 utils/Makefile |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 4ea5868..9f397e7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -142,6 +142,8 @@ else
     AC_SUBST([WITH_REALTIME_TESTSUITE],["no"])
 fi
 
+AC_CONFIG_SUBDIRS([utils/ffsb-6.0-rc2])
+
 # END testsuites knobs
 LTP_CHECK_FORTIFY_SOURCE
 LTP_CHECK_CC_WARN_OLDSTYLE
diff --git a/utils/Makefile b/utils/Makefile
index 923bb2d..1508b35 100644
--- a/utils/Makefile
+++ b/utils/Makefile
@@ -30,7 +30,7 @@ FFSB			:= $(FFSBDIR)/ffsb
 
 $(FFSB): $(abs_srcdir)/$(FFSBDIR)
 	mkdir -p $(FFSBDIR)
-	cd $(FFSBDIR) && "$^/configure" && $(MAKE) top_srcdir="$^" all
+	cd $(FFSBDIR) && $(MAKE) top_srcdir="$^" all
 
 ffsb: $(FFSB)
 	cp $(FFSB) ffsb
-- 
1.7.10.4


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
