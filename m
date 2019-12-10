From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Dec 2019 16:38:25 +0100
Subject: [LTP] [PATCH 2/3] syscalls/llseek02: convert to new library
In-Reply-To: <1576012458-31108-2-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1576012458-31108-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <1576012458-31108-2-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <20191210153825.GC30547@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Same as the previous one plus I have changed the SAFE_CLOSE() in setup
to just close(), because the SAFE_CLOSE() resets the file descriptor to
-1.

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
