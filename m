From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 27 Apr 2016 16:29:44 +0300
Subject: [LTP] [PATCH] lib/rmobj.c: fix warning on FUSE fs
In-Reply-To: <20160427121559.GB17331@rei.lan>
References: <1461754274-9903-1-git-send-email-alexey.kodanev@oracle.com>
 <20160427121559.GB17331@rei.lan>
Message-ID: <5720BEC8.9040405@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 04/27/2016 03:15 PM, Cyril Hrubis wrote:
> Hi!
>> This warning can appear on FUSE fs in cleanup():
>> TWARN  :  tst_tmpdir.c:219: tst_rmdir: rmobj(...) failed: unlink(
>> .../.fuse_hidden#####) failed; errno=2: No such file or directory
> Isn't this the same problem as the NFS one? I.e. unlinked but still open
> files?

No, checked syscalls/* tests, they all are closing fds before tst_rmdir().

It happens only if test does unlink(fd), then close(fd). If we change a test
so it calls close(fd) first, then unlink(fd), then ".fuse_hidden" never 
being
created to store data about unlinked but still open file, and we won't have
this warning too. It's just another way to workaround it in the tests.

>
> But in this case it looks like the file was still there shortly after
> the fd has been closed, right? I wonder if that is a bug or not. I would
> expect that the file is no longer in the directory listing once the
> close() has returned from kernel.

Hmm, may be it is a bug, for a short period of time after close() we can
still have this temporary file listed. OK, I will check it with our 
developers.

Thanks,
Alexey

