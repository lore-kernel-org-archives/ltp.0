From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jul 2016 13:57:14 +0200
Subject: [LTP] [PATCH 3/4] syscalls/socketpair01: convert to new API
In-Reply-To: <1466759093-15755-3-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1466759093-15755-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1466759093-15755-3-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160726115714.GB11679@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've did the same changes as for the socket01.c, i.e. expecting exact
errno based on kernel version and also fixed the socketpair() return
value handling. It returns 0 on success, so for instance the file
descriptors were not closed in the verify function at all.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
