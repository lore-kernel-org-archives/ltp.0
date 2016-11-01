From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 1 Nov 2016 16:52:59 +0100
Subject: [LTP] [PATCH v2] syscalls/quotactl02.c: Reconstruct && Convert
 to new API
In-Reply-To: <1477989185-14115-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20161031132536.GA32461@rei>
 <1477989185-14115-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20161101155258.GA14966@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've changed the cast to (caddr_t) to (void*), since caddr_t is BSD
specific type that should not be used in modern code at all, and pushed,
thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
