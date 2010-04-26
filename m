Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1O6Vku-0006OF-05
	for ltp-list@lists.sourceforge.net; Mon, 26 Apr 2010 21:22:16 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 0EF2C93F19
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Apr 2010 23:22:08 +0200 (CEST)
Date: Mon, 26 Apr 2010 23:29:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100426212949.GA29981@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
Subject: [LTP] [PATCH] missing return in fs-bench
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


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Just another problem in fs-bench sources.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--EeQfGwPcQSOJBaQU
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="missing_return_in_fs-bench.patch"

Index: ltp-full-20100228/testcases/kernel/fs/fs-bench/create-files.c
===================================================================
--- ltp-full-20100228.orig/testcases/kernel/fs/fs-bench/create-files.c
+++ ltp-full-20100228/testcases/kernel/fs/fs-bench/create-files.c
@@ -71,6 +71,7 @@ int main(int ac,char *av[])
 end:
   fprintf(stderr,"\nTotal create files: %d\n",filecount);
   printf("Done\n");
+  return 0;
 }
 
 int showchar[]={124,47,45,92,124,47,45,92};

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--EeQfGwPcQSOJBaQU--

