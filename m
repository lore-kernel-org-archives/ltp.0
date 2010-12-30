Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PYHug-0004nx-8V
	for ltp-list@lists.sourceforge.net; Thu, 30 Dec 2010 12:47:26 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 010078738D
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Dec 2010 13:47:19 +0100 (CET)
Date: Thu, 30 Dec 2010 14:02:50 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101230130250.GA19954@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
Subject: [LTP] [PATCH] remove tst_brkloop references
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


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Lately tst_brkloop and tst_brkloopm was removed but they were still used
in ltpapicmd.c and thuss this file doesn't compile. Attached patch
removes them.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

--liOOAslEiF7prFVr
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="remove_brkloop_references.patch"

diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index 78284a9..9c66ba3 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -236,25 +236,6 @@ int main( int argc,
         tst_res(trestype, file_name, arg_fmt);
     }
     else
-    if (strcmp((char *)cmd_name, "tst_brkloop") == 0)
-    {
-        if (argc < 5)
-        {
-            fprintf(stderr, "Usage: %s TTYPE FNAME FUNC STRING\n"
-            "\tTTYPE  - Test Result Type; one of TFAIL, TBROK, TCONF, "
-            "and TRETR.\n"
-            "\tFNAME  - Print contents of this file after the message\n"
-            "\tFUNC   - Cleanup function (ignored), but MUST be provided\n"
-            "\tSTRING - Message explaining the test result\n", cmd_name);
-            exit (-1);
-        }
-        trestype = ident_ttype(argv++[0]);
-        file_name = argv++[0];
-        argv++;
-        strcpy(arg_fmt, *argv);
-        tst_brkloop(trestype, file_name, cleanup, arg_fmt);
-    }
-    else
     if (strcmp((char *)cmd_name, "tst_brkm") == 0)
     {
         if (argc < 4)
@@ -287,23 +268,6 @@ int main( int argc,
         tst_resm(trestype, arg_fmt);
     }
     else
-    if (strcmp((char *)cmd_name, "tst_brkloopm") == 0)
-    {
-        if (argc < 4)
-        {
-            fprintf(stderr, "Usage: %s TTYPE FUNC STRING\n"
-            "\tTTYPE  - Test Result Type; one of TFAIL, TBROK, TCONF, "
-            "and TRETR.\n"
-            "\tFUNC   - Cleanup function (ignored), but MUST be provided\n"
-            "\tSTRING - Message explaining the test result\n", cmd_name);
-            exit (-1);
-        }
-        trestype = ident_ttype(argv++[0]);
-        argv++;
-        strcpy(arg_fmt, *argv);
-        tst_brkloopm(trestype, cleanup, arg_fmt);
-    }
-    else
     if (strcmp((char *)cmd_name, "tst_exit") == 0)
         tst_exit();
     else

--liOOAslEiF7prFVr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--liOOAslEiF7prFVr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--liOOAslEiF7prFVr--

