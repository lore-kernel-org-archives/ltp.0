Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WSULM-0000yy-P8
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 16:36:52 +0000
Date: Tue, 25 Mar 2014 17:36:28 +0100
From: chrubis@suse.cz
Message-ID: <20140325163627.GC10754@rei>
References: <1394070844-20617-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1394070844-20617-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3] mprotect/mprotect04.c: add PROT_NONE,
 PROT_EXEC flag test
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +static void sighandler(int sig)
> +{
> +	if (sig == SIGSEGV) {
> +		sigsegv_caught = 1;
> +		siglongjmp(env, 1);
> +	} else {
> +		tst_brkm(TBROK, cleanup, "received an unexpected signal: %d",
> +				 sig);
> +	}
> +}

I've changed the code a bit to avoid the tst_brkm() in signal handler
and pushed the code (full diff below). Thanks.

diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
index 17ee73d..4ca7c02 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect04.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
@@ -54,7 +54,7 @@ static void (*testfunc[])(void) = { testfunc_protnone, testfunc_protexec };
 char *TCID = "mprotect04";
 int TST_TOTAL = ARRAY_SIZE(testfunc);
 
-static volatile int sigsegv_caught;
+static volatile int sig_caught;
 static sigjmp_buf env;
 
 int main(int ac, char **av)
@@ -82,13 +82,8 @@ int main(int ac, char **av)
 
 static void sighandler(int sig)
 {
-	if (sig == SIGSEGV) {
-		sigsegv_caught = 1;
-		siglongjmp(env, 1);
-	} else {
-		tst_brkm(TBROK, cleanup, "received an unexpected signal: %d",
-				 sig);
-	}
+	sig_caught = sig;
+	siglongjmp(env, 1);
 }
 
 static void setup(void)
@@ -103,7 +98,7 @@ static void testfunc_protnone(void)
 	char *addr;
 	int page_sz;
 
-	sigsegv_caught = 0;
+	sig_caught = 0;
 
 	page_sz = getpagesize();
 
@@ -119,10 +114,18 @@ static void testfunc_protnone(void)
 		if (sigsetjmp(env, 1) == 0)
 			addr[0] = 1;
 
-		if (sigsegv_caught)
+		switch (sig_caught) {
+		case SIGSEGV:
 			tst_resm(TPASS, "test PROT_NONE for mprotect success");
-		else
+		break;
+		case 0:
 			tst_resm(TFAIL, "test PROT_NONE for mprotect failed");
+		break;
+		default:
+			tst_brkm(TBROK, cleanup,
+			         "received an unexpected signal: %d",
+			         sig_caught);
+		}
 	}
 
 	SAFE_MUNMAP(cleanup, addr, page_sz);
@@ -138,7 +141,7 @@ static void testfunc_protexec(void)
 	int page_sz;
 	int (*func)(void);
 
-	sigsegv_caught = 0;
+	sig_caught = 0;
 
 	page_sz = getpagesize();
 
@@ -156,10 +159,18 @@ static void testfunc_protexec(void)
 		if (sigsetjmp(env, 1) == 0)
 			(*func)();
 
-		if (sigsegv_caught)
+		switch (sig_caught) {
+		case SIGSEGV:
 			tst_resm(TFAIL, "test PROT_EXEC for mprotect failed");
-		else
+		break;
+		case 0:
 			tst_resm(TPASS, "test PROT_EXEC for mprotect success");
+		break;
+		default:
+			tst_brkm(TBROK, cleanup,
+			         "received an unexpected signal: %d",
+			         sig_caught);
+		}
 	}
 
 	SAFE_MUNMAP(cleanup, func, page_sz);

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
