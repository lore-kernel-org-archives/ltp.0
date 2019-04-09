From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 9 Apr 2019 18:23:25 +0300
Subject: [LTP] [PATCH] syscalls/fcntl33.c: fix test for fuse fs again
In-Reply-To: <20190409135331.GA11308@rei.lan>
References: <1554811321-19337-1-git-send-email-alexey.kodanev@oracle.com>
 <20190409135331.GA11308@rei.lan>
Message-ID: <d5bfd1ff-1bfb-8247-cae8-994c70cdb1d2@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,
On 09.04.2019 16:53, Cyril Hrubis wrote:
> Hi!
>> The previous fix commit 7703cb3e10ea ("syscall/fcntl33.c: fix test on FUSE
>> fs") moved open() (can sleep on fuse fs) before fork()/do_child(). But the
>> fix was removed by commit e5c990c5c55b ("Convert fcntl33 to newlib").
>>
>> In this patch, instead of moving open(), use LTP checkpoints: wake the
>> child only after setting the lease in a parent process.
> 
> Looks good to me, acked.

Thanks for review!

Applied.
