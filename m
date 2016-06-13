From: Jiri Jaburek <jjaburek@redhat.com>
Date: Mon, 13 Jun 2016 19:58:25 +0200
Subject: [LTP] [PATCH] syscalls/fcntl34: use struct flock64 on 32bit
In-Reply-To: <20160613142210.GA354@rei.lan>
References: <1465562609-11947-1-git-send-email-jjaburek@redhat.com>
 <20160613142210.GA354@rei.lan>
Message-ID: <575EF441.5020506@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/13/16 16:22, Cyril Hrubis wrote:
> Since both manual and glibc examples use struct flock with OFD locks in
> examples and if I compile glibc example for OFD locks[1] on 32bit system
> garbage is passed to kernel syscalls and the program hangs, so I would
> call this glibc/kernel bug.
> 
> I would expect glibc to convert the flock structure to 64 bit one
> silently in this case.

That might not be possible as such "silent" conversion could break
a lot of existing programs that rely on hardcoded 32bit struct flock
size.

However I double-tested it with systemtap and filed the bug anyway,
https://sourceware.org/bugzilla/show_bug.cgi?id=20251

Thanks for pointing out the glibc example.

> 
> [1] manual/examples/ofdlocks.c
>     https://sourceware.org/git/?p=glibc.git;a=blob;f=manual/examples/ofdlocks.c;h=ba4f0ef4d237e95b8f1e0f37b9c1befd4afda0d4;hb=HEAD
> 

