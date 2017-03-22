From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Mar 2017 17:47:54 +0100
Subject: [LTP] [PATCH] mtest05/mmstress: Fix failure on read-only system
In-Reply-To: <1489106886-4037-1-git-send-email-the_hoang0709@yahoo.com>
References: <1489106886-4037-1-git-send-email-the_hoang0709@yahoo.com>
Message-ID: <20170322164754.GD4960@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This was broken for when the test was passed the -t option since in that
case the alarm called exit(). Well the -t option was broken anyway,
since it did exit(0) regardless of the result of the test functions.

So I've cleaned up the test a bit so that SIGALRM only sets a flag that
causes the main loop to exit and also to call tst_exit() properly and
then added the tst_tmpdir() and tst_rmdir() calls.

-- 
Cyril Hrubis
chrubis@suse.cz
