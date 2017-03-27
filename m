From: Hoang Nguyen <the_hoang0709@yahoo.com>
Date: Mon, 27 Mar 2017 08:02:27 +0000 (UTC)
Subject: [LTP] [PATCH] mtest05/mmstress: Fix failure on read-only system
In-Reply-To: <20170322164754.GD4960@rei.lan>
References: <1489106886-4037-1-git-send-email-the_hoang0709@yahoo.com>
 <20170322164754.GD4960@rei.lan>
Message-ID: <1949039867.3801591.1490601747270@mail.yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
Thanks Cyril. I can see it passed on my board.
Thanks a lot for your help.
Best regards,
Hoang

Sent from Yahoo Mail on Android 
 
  On Wed, Mar 22, 2017 at 23:50, Cyril Hrubis<chrubis@suse.cz> wrote:   Hi!
This was broken for when the test was passed the -t option since in that
case the alarm called exit(). Well the -t option was broken anyway,
since it did exit(0) regardless of the result of the test functions.

So I've cleaned up the test a bit so that SIGALRM only sets a flag that
causes the main loop to exit and also to call tst_exit() properly and
then added the tst_tmpdir() and tst_rmdir() calls.

-- 
Cyril Hrubis
chrubis@suse.cz
  
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170327/2d059a84/attachment.html>
