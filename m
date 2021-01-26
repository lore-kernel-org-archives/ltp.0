From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jan 2021 15:17:46 +0100
Subject: [LTP] [PATCH 2/5] syscalls/ipc: semctl03: Convert to new API
 and cleanup
In-Reply-To: <1609918063-15810-2-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1609918063-15810-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <1609918063-15810-2-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <YBAkitx3hXSyN3dh@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a few changes, thanks.

* Reformatted the description comment for docparser

* Got rid of the IBM XLC compiler hack

* Return value from tst_get_bad_addr() is used for EFAULT instead of -1

* Removed needs_root = 1 as the test does not need root at all

-- 
Cyril Hrubis
chrubis@suse.cz
