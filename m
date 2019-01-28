From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 28 Jan 2019 16:16:23 +0100
Subject: [LTP] [PATCH 2/2] readdir02: use invalid DIR stream descriptor
In-Reply-To: <20181220090811.21514-2-liwang@redhat.com>
References: <20181220090811.21514-1-liwang@redhat.com>
 <20181220090811.21514-2-liwang@redhat.com>
Message-ID: <20190128151622.GA10646@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Issue:
>   On ppc64le and aarch64, when testing in NFS mountpoint, test
>   process receives SIGSEGV when calling readdir on a DIR which
>   has just been closed by closedir().
> 
>   Unfortunately, ltp/readdir02.c handles SIGSEGV. This makes it
>   hits SIGSEGV again in its cleanup function. So readdir02 hangs
>   there hitting SEGV endlessly.
> 
> That's because a DIR * is NOT a file descriptor. It's memory
> allocated by opendir() that contains libc internal information
> about the directory. closedir(test_dir) frees any memory associated
> with the open directory pointer test_dir.
> 
> To then pass the freed dir pointer to readdir() is a use-after-free.
> It probably won't return EBADF, it will dereference freed memory
> and whatever happens after that is undefined.
> 
> In this patch, I simply modify the test to use an exist FILE *
> stream to simulate the invalid directory stream descriptor. Then
> it won't hit the use-after-free issue any more.

Actually I think that the best we can do here is to delete the testcase
because:

* Casting FILE* to DIR* is IMHO invoking even worse undefined behavior
  than the original test that called readdir() on closed DIR*

* We do cover the EBADF for getents() syscalls getents02 test


-- 
Cyril Hrubis
chrubis@suse.cz
