Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1PlOoh-0007UO-3s
	for ltp-list@lists.sourceforge.net; Fri, 04 Feb 2011 16:47:27 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 3D25A93717
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Feb 2011 17:47:19 +0100 (CET)
Date: Fri, 4 Feb 2011 18:05:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110204170556.GA30962@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
Subject: [LTP] [PATCH] style guide note about writing signal handlers
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


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Patch with note about writing signal handlers attached.

Garrett feel free to rewrite it to match the rest of the style guide.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

--/04w6evG8XlLl3ft
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="style_guide.patch"

diff --git a/doc/style-guide.txt b/doc/style-guide.txt
index a8b75a7..713df6c 100644
--- a/doc/style-guide.txt
+++ b/doc/style-guide.txt
@@ -172,6 +172,11 @@ if ((this_is_a_poorly_formed_really_long_variable = function_call()) == NULL &&
     Furthermore, linux/ headers get shuffled around a lot more than
     their sys/ counterparts it seems.
 
+15. Avoid doing tricky things in signal handlers. Calling most of the libc
+    functions from signal handler may lead to deadlocks or memory corruption.
+    If you really need to do anything more complicated that "should_run = 0;"
+    in your signal handler consult "man 7 singal" for async-signal-safe
+    functions.
 
 Porting Testcases
 ---------------------------

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The modern datacenter depends on network connectivity to access resources
and provide services. The best practices for maximizing a physical server's
connectivity to a physical network are well understood - see how these
rules translate into the virtual world? 
http://p.sf.net/sfu/oracle-sfdevnlfb
--/04w6evG8XlLl3ft
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--/04w6evG8XlLl3ft--

