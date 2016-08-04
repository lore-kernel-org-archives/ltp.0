From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Aug 2016 18:50:29 +0200
Subject: [LTP] [PATCH 1/2] syscalls/access04: reconstruct and convert to
 new API
In-Reply-To: <1469698729-5860-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1469698729-5860-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160804165028.GD3367@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Once we remote the directory the accessfile is in this is just the same
as access01.c.

Looks like the whole point of the test was to put the file into a
directory and pass the path to the syscall.

What about we remote this test and add a few more cases with a file in
subdirectory to the access01 test instead?

-- 
Cyril Hrubis
chrubis@suse.cz
