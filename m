Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Om23S-0004dD-Ly
	for ltp-list@lists.sourceforge.net; Thu, 19 Aug 2010 10:09:02 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id AE70795A49
	for <ltp-list@lists.sourceforge.net>;
	Thu, 19 Aug 2010 12:08:51 +0200 (CEST)
Date: Thu, 19 Aug 2010 12:26:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100819102646.GA25990@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
Subject: [LTP] [PATCH] fix tst_unzip_file.zip permissions
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


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
When creating package, the buildsysem freaks out on file
tst_unzip_file.zip because it has world writeable permission, however
this is not necessary for the test itself to work. Patch attached.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--k+w/mQv8wyuph6w0
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="commands_unzip_makefile.patch"

Index: ltp-full-20100630/testcases/commands/unzip/Makefile
===================================================================
--- ltp-full-20100630.orig/testcases/commands/unzip/Makefile
+++ ltp-full-20100630/testcases/commands/unzip/Makefile
@@ -47,7 +47,7 @@ $(TESTCASES_DATA_DIR):
 
 $(ZIPFILE): | $(TESTCASES_DATA_DIR) $(DIR)
 	zip -r "$@" $(DIR)
-	chmod 00666 "$@"
+	chmod 00644 "$@"
 
 # This target should be auto-removed by Make
 $(DIR): $(abs_srcdir)/unzip_genfile.sh

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--k+w/mQv8wyuph6w0--

