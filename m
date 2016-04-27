From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Apr 2016 14:15:59 +0200
Subject: [LTP] [PATCH] lib/rmobj.c: fix warning on FUSE fs
In-Reply-To: <1461754274-9903-1-git-send-email-alexey.kodanev@oracle.com>
References: <1461754274-9903-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160427121559.GB17331@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This warning can appear on FUSE fs in cleanup():
> TWARN  :  tst_tmpdir.c:219: tst_rmdir: rmobj(...) failed: unlink(
> .../.fuse_hidden#####) failed; errno=2: No such file or directory

Isn't this the same problem as the NFS one? I.e. unlinked but still open
files?

But in this case it looks like the file was still there shortly after
the fd has been closed, right? I wonder if that is a bug or not. I would
expect that the file is no longer in the directory listing once the
close() has returned from kernel.

-- 
Cyril Hrubis
chrubis@suse.cz
