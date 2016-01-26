From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jan 2016 17:38:23 +0100
Subject: [LTP] [PATCH] pwritev/pwritev02.c: add new testcase
In-Reply-To: <1451384431-29742-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1451384431-29742-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1451384431-29742-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160126163823.GB21691@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Both pushed, thanks.

BTW: both preadv() and pwritev() can also fail with errors specified for
     read() and write(), so we should, get EBADFD if fd is invalid or not
     open for reading/writing for read/write, etc.

-- 
Cyril Hrubis
chrubis@suse.cz
