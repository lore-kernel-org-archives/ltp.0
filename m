From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Apr 2018 16:39:50 +0200
Subject: [LTP] [PATCH 2/5] syscalls/mkdir01,
 03: Cleanup && Convert to new API
In-Reply-To: <1521804892-5783-2-git-send-email-xuyang.jy@cn.fujitsu.com>
References: <1521804892-5783-1-git-send-email-xuyang.jy@cn.fujitsu.com>
 <1521804892-5783-2-git-send-email-xuyang.jy@cn.fujitsu.com>
Message-ID: <20180417143950.GC30600@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The mkdir03 was rewritten meanwhile by Sandeep Patil, sorry for not
reviewing your patch sooner. I've pushed the part of this patch that
removes mkdir01 since the case is covered by the mkdir03 already,
thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
