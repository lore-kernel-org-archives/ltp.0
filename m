Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sumitbd@linsyssoft.com>) id 1OZeaC-00075L-Al
	for ltp-list@lists.sourceforge.net; Fri, 16 Jul 2010 06:39:40 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OZeaB-0006BA-BI
	for ltp-list@lists.sourceforge.net; Fri, 16 Jul 2010 06:39:40 +0000
Received: by pvg13 with SMTP id 13so768732pvg.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Jul 2010 23:39:33 -0700 (PDT)
From: sumitbd@linsyssoft.com
Date: Fri, 16 Jul 2010 11:42:08 +0530
Message-ID: <1279260728.4313.1.camel@sumit>
Mime-Version: 1.0
Subject: [LTP] [PATCH 1/2] mc_opts: network/multicast/mc_opts/mc_opts script
 - bug fixing
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

Test case "mc_opts" fails as it is not able to install "opts" and
"opts_e" files at desired location. This is because the path of these
files mentioned in the "mc_opts" script is incorrect. Following patch
fixes the above problem.

Signed-off-by:  Sumit Dhoot <sumitbd@linsyssoft.com>

Index: ltp-full-20100630/testcases/network/multicast/mc_opts/mc_opts
===================================================================
--- ltp-full-20100630.orig/testcases/network/multicast/mc_opts/mc_opts
+++ ltp-full-20100630/testcases/network/multicast/mc_opts/mc_opts
@@ -57,7 +57,7 @@ setup()
   mkdir -p $TCtmp
   for i in $EXECUTABLES
   do
-    install -m 0755 "$LTPROOT/$i" "$TCtmp/."
+    install -m 0755 "$LTPROOT/testcases/bin/$i" "$TCtmp/."
   done
} 


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
