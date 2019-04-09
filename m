From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Apr 2019 15:53:31 +0200
Subject: [LTP] [PATCH] syscalls/fcntl33.c: fix test for fuse fs again
In-Reply-To: <1554811321-19337-1-git-send-email-alexey.kodanev@oracle.com>
References: <1554811321-19337-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20190409135331.GA11308@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The previous fix commit 7703cb3e10ea ("syscall/fcntl33.c: fix test on FUSE
> fs") moved open() (can sleep on fuse fs) before fork()/do_child(). But the
> fix was removed by commit e5c990c5c55b ("Convert fcntl33 to newlib").
> 
> In this patch, instead of moving open(), use LTP checkpoints: wake the
> child only after setting the lease in a parent process.

Looks good to me, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
