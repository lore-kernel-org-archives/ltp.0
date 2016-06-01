From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Jun 2016 13:26:01 +0200
Subject: [LTP] [PATCH] syscalls/epoll_create1: Cleanup && Convert to new
 API
In-Reply-To: <1464672435-8917-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1464672435-8917-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160601112601.GC19762@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

Added TERRNO to a few tst_brk() calls, removed needs_tmpdir since the
teset does not need it...

-- 
Cyril Hrubis
chrubis@suse.cz
