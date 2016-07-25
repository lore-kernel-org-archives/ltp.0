From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Jul 2016 15:55:32 +0200
Subject: [LTP] [PATCH v2 1/3] syscalls/kcmp*: Convert to new API
In-Reply-To: <1469002874-18630-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160719135349.GE6409@rei.lan>
 <1469002874-18630-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160725135532.GC12533@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've simplified the kcmp01.c a bit and pushed, thanks.

(We can safely use SAFE_CLOSE() in child since it's cleanup is not
executed from test cleanup())

-- 
Cyril Hrubis
chrubis@suse.cz
