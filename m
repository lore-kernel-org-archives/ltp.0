Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UwVww-0008WR-9O
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 11:19:14 +0000
Date: Tue, 9 Jul 2013 13:20:48 +0200
From: chrubis@suse.cz
Message-ID: <20130709112048.GB30721@rei>
References: <DUB116-W436268875AA46AD93621D0F3790@phx.gbl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DUB116-W436268875AA46AD93621D0F3790@phx.gbl>
Subject: Re: [LTP] [PATCH] flock/flock03.c: When compiling with UCLINUX=1:
 undefined symbol `FILENAME`
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
To: Benoit M <juz4m@hotmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> flock/flock03.c: When compiling with UCLINUX=1: undefined symbol
> `FILENAME`. Did you mean `FILE_NAME`, as it is defined at the top of
> the file?

Looks like an obivous typo to me.

> (The patch also removes some trailing white-spaces in empty lines)
> --- testcases/kernel/syscalls/flock/flock03.c | 10 +++++----- 1 file changed, 5 insertions(+), 5 deletions(-)
> diff --git a/testcases/kernel/syscalls/flock/flock03.c b/testcases/kernel/syscalls/flock/flock03.cindex bacf4f6..a7a1cd9 100644--- a/testcases/kernel/syscalls/flock/flock03.c+++ b/testcases/kernel/syscalls/flock/flock03.c@@ -86,13 +86,13 @@ int main(int argc, char **argv)                                 "file, errno %d", errno);                 pid = FORK_OR_VFORK();-+                if (pid == -1)                        tst_brkm(TFAIL, cleanup, "fork() failed, errno %d",                                 errno);                if (pid == 0) { #ifdef UCLINUX-                       if (self_exec(argv[0], "ds", fd, FILENAME) < 0)+                       if (self_exec(argv[0], "ds", fd, FILE_NAME) < 0)                                tst_brkm(TFAIL, cleanup, "self_exec failed, "                                         "errno &d", errno); #else@@ -161,7 +161,7 @@ static void childfunc(int fd)        }         TEST(flock(fd2, LOCK_EX | LOCK_NB));-+        if (TEST_RETURN == -1) {   
              fprintf(stderr, "CHILD: Unable to lock file after "                        "unlocking: %s\n", strerror(TEST_ERRNO));@@ -169,10 +169,10 @@ static void childfunc(int fd)        } else {                fprintf(stderr, "CHILD: Locking after unlock passed\n");        }-+        close(fd);        close(fd2);-+        exit(0); } -- 1.8.3
> --Benoit Marcot 		 	   		  

Your mail client apparently mangled the patch.

Could you please resend it and add Signed-of-by line too?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
