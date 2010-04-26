Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1O6VpW-0006hT-6Z
	for ltp-list@lists.sourceforge.net; Mon, 26 Apr 2010 21:27:02 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 311D2867E2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Apr 2010 23:26:55 +0200 (CEST)
Date: Mon, 26 Apr 2010 23:34:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100426213436.GA30362@saboteur.suse.cz>
References: <20100426212949.GA29981@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20100426212949.GA29981@saboteur.suse.cz>
Subject: Re: [LTP] [PATCH] missing return in fs-bench
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


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> Just another problem in fs-bench sources.

Missed some in previous patch, now it should be all.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--2oS5YaxWCcQjTEyO
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="missing_return_in_fs-bench_II.patch"

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
Index: ltp-full-20100228/testcases/kernel/fs/fs-bench/random-del-create.c
===================================================================
--- ltp-full-20100228.orig/testcases/kernel/fs/fs-bench/random-del-create.c
+++ ltp-full-20100228/testcases/kernel/fs/fs-bench/random-del-create.c
@@ -111,6 +111,7 @@ int create_file(char *filename)
   cfilecount++;
   disk_space_pool -= randomsize;
   close(fd);
+  return 0;
 }
 
 #include <sys/stat.h>
@@ -131,4 +132,5 @@ int delete_file(char *filename)
     return(-1);
   }
   dfilecount++;
+  return 0;
 }

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--2oS5YaxWCcQjTEyO--

