From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Sep 2017 12:09:23 +0200
Subject: [LTP] [PATCH] syscalls/kcmp03: work around bug in C library
In-Reply-To: <20170905204029.66280-1-smuckle.linux@gmail.com>
References: <20170905204029.66280-1-smuckle.linux@gmail.com>
Message-ID: <20170906100923.GA23287@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Some versions of glibc and bionic report the same PID for parent and
> child when clone() is called with CLONE_VM but not CLONE_THREAD.

Is that the result of the infamous pid caching? Can we fix that by using
the raw getpid() syscall in the test library? If so I guess that using
raw syscall in the test library may be a safer bet.

-- 
Cyril Hrubis
chrubis@suse.cz
