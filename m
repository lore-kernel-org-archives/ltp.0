From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Dec 2016 11:43:56 +0100
Subject: [LTP] [PATCH 4/5] SAFE_MACROS: Add SAFE_PRCTL()
In-Reply-To: <58526DC1.7070208@cn.fujitsu.com>
References: <1480507955-12652-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1480507955-12652-4-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20161205144005.GG22344@rei.lan> <58526DC1.7070208@cn.fujitsu.com>
Message-ID: <20161215104356.GB29787@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I see the prctl()'s arguments is variable in prctl.h, just like the fcntl() and ioctl(),
> so I think maybe I can do it just as fcntl() and ioctl() did?

Ah, missed that. That would work for this case.

-- 
Cyril Hrubis
chrubis@suse.cz
