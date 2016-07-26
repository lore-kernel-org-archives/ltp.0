From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jul 2016 14:09:23 +0200
Subject: [LTP] [PATCH 4/4] syscalls/socketpair02: reconstruct and
 convert to new API
In-Reply-To: <1466759093-15755-4-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1466759093-15755-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1466759093-15755-4-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160726120923.GC11679@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've made use of the lapi/fcntl.h and removed the fallback definitions
and also changed the tst_brk() for tst_res() in the verify function
(otherwise the test would exit which does not seem to be the expected
behavior here as it was followed by return) and made sure the fds are
closed when failure is reported.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
