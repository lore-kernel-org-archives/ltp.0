Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1O6Un1-0003A7-B1
	for ltp-list@lists.sourceforge.net; Mon, 26 Apr 2010 20:20:23 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 509B994109
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Apr 2010 22:20:15 +0200 (CEST)
Date: Mon, 26 Apr 2010 22:27:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100426202756.GA25664@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
Subject: [LTP] [PATCH] add missing return into print_caps.c
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


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
The way there are #ifdef directives in print_caps.c there is no return in main()
when caps are supported. Attached patch fixes this.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--dDRMvlgZJXvWKvBx
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="missing_return_print_caps.patch"

Index: ltp-full-20100228/testcases/kernel/security/filecaps/print_caps.c
===================================================================
--- ltp-full-20100228.orig/testcases/kernel/security/filecaps/print_caps.c
+++ ltp-full-20100228/testcases/kernel/security/filecaps/print_caps.c
@@ -65,7 +65,6 @@ int main(int argc, char *argv[])
 	close(fd);
 
 	cap_free(cap);
-#else
-	return 0;
 #endif
+	return 0;
 }

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--dDRMvlgZJXvWKvBx--

