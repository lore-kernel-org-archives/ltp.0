From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 May 2017 13:43:49 +0200
Subject: [LTP] [PATCH] syscalls/fanotify07.c: Fix compilation without
 fanotify
In-Reply-To: <1495618195-4139-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1495618195-4139-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170524114349.GA13101@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Compilation failed becasue main function is defined in new API.
> We should use TST_TEST_TCONF instead of main function to skip
> this case in new API.

Good catch, pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
