Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wpyws-00082c-Fd
	for ltp-list@lists.sourceforge.net; Thu, 29 May 2014 11:56:42 +0000
Date: Thu, 29 May 2014 13:56:25 +0200
From: chrubis@suse.cz
Message-ID: <20140529115625.GA10766@rei.Home>
References: <1398855439-11869-1-git-send-email-shuang.qiu@oracle.com>
	<5368C0B6.4000307@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5368C0B6.4000307@oracle.com>
Subject: Re: [LTP] [PATCH 2/2-updated] syscalls/fstatfs02: Using temporary
 file description to test the syscall
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > It does not make sense to use stdout as the file description to test the
> > system call fstatfs().We may get unexpected result(i.e.
> > errno=38:Function not implemented) if redirect stdout when running ltp.
> > Using ltp temporary file instead.
> >
> > Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
> 
> The problem is that with the 2.6.39 series of kernels ENOSYS is returned 
> where EFAULT is expected.
> 
> The reproducer:
> #include <error.h>
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/vfs.h>
> 
> int main(void)
> {
>    int fds[2];
> 
>    if (pipe(fds) < 0) {
>      perror("pipe() failed");
>      return 1;
>    }
> 
>    if (fstatfs(fds[1], (void *)-1) < 0) {
>      perror("fstatfs() failed");
>      return 1;
>    }
> 
>    return 0;
> }
> 
> With 2.6.18, 2.6.32, 3.8.13 this reproducer returns EFAULT,
> but with 2.6.39 - ENOSYS.
> 
> If we change '(void *)-1' to a vaild pointer, fstatfs() + 2.6.39 will 
> succeed.
> 
> So it's a bug in 2.6.39, which is fixed in modern kernels.

I've looked at fstatfs() and pipe() code in recent kernel.

The fstatfs() looks at dentry and if there is no statfs callback it
returns ENOSYS, otherwise it uses the callback to fill the buffer.

The pipe() mounts an "pipe:" kernel internal pseudo fs and uses
simple_statfs() for the statfs() callback. So statfs() works fine on
recent kernels. In 2.6.39 the pipefs_ops structure simply misses the
fstatfs() callback, it has been introduced in:

commit d70ef97baf048412c395bb5d65791d8fe133a52b
Author: Pavel Emelyanov <xemul@parallels.com>
Date:   Mon Oct 31 17:10:04 2011 -0700

    fs/pipe.c: add ->statfs callback for pipefs

I guess that we can add a test for fstatfs() on a pipe if kernel version
is newer than 3.2.

>  From one side, the above patch makes fstatfs02 pass by hiding an old 
> (and already fixed) kernel bug.
> 
> But from the other side, it also enlarges the test scope by allowing to 
> test different file systems.
> 
> So, personally, I would accept it.
> 
> Are there any thoughts about it?

I'm for fixing the testcase this way. If nothing else it makes it the
test actually test what it's expected to test.

Just cleanup the patch a bit before applying (use SAFE_OPEN(), etc).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
