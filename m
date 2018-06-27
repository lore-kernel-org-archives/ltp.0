From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jun 2018 15:59:03 +0200
Subject: [LTP] [PATCH] syscalls/shmctl05: new test for IPC file
 use-after-free bug
In-Reply-To: <20180627061815.GA9171@sol.localdomain>
References: <20180513012325.877-1-ebiggers3@gmail.com>
 <20180518132536.GB32299@rei> <20180626113547.GG24288@rei>
 <20180627061815.GA9171@sol.localdomain>
Message-ID: <20180627135903.GB32300@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looks like if we drop the callibration from the test and use the fuzzy
sync library only as a spinlocks to synchronize the IPC_RMID against the
remap_file_pages the bug gets triggered very reliably for me.

-- 
Cyril Hrubis
chrubis@suse.cz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: shmctl05.c
Type: text/x-c
Size: 3232 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180627/76f1d22c/attachment.bin>
