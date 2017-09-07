From: Steve Muckle <smuckle.linux@gmail.com>
Date: Thu, 7 Sep 2017 10:42:10 -0700
Subject: [LTP] [PATCH] syscalls/kcmp03: work around bug in C library
In-Reply-To: <20170906100923.GA23287@rei.lan>
References: <20170905204029.66280-1-smuckle.linux@gmail.com>
 <20170906100923.GA23287@rei.lan>
Message-ID: <c378bb66-f40e-42e2-1586-1b5c445a33dc@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09/06/2017 03:09 AM, Cyril Hrubis wrote:
> Hi!
>> Some versions of glibc and bionic report the same PID for parent
>> and child when clone() is called with CLONE_VM but not
>> CLONE_THREAD.
> 
> Is that the result of the infamous pid caching?

In bionic yes, I can't say for sure in glibc but I'd assume so. I
haven't tested a glibc version that had pid caching removed.

> Can we fix that by using the raw getpid() syscall in the test
> library? If so I guess that using raw syscall in the test library may
> be a safer bet.
Probably. I'll try it.

thanks,
Steve
