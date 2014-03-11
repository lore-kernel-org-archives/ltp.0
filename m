Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WNNGK-00054h-Bu
	for ltp-list@lists.sourceforge.net; Tue, 11 Mar 2014 14:02:32 +0000
Date: Tue, 11 Mar 2014 15:02:13 +0100
From: chrubis@suse.cz
Message-ID: <20140311140213.GA10778@rei>
References: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20140211151034.GA15043@rei.Home> <530C7004.3060102@oracle.com>
	<20140226134703.GA27609@rei> <530DF8C6.50600@oracle.com>
	<20140226150850.GB27609@rei> <5317454D.5010505@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5317454D.5010505@oracle.com>
Subject: Re: [LTP] rpc-tirpc-full-test-suite
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Hmm, I'm not 100% sure about libraries which I should link the test 
> binaries with.
> 
> The tirpc test binaries (tests_pack/rpc_suite/tirpc) must be linked with 
> -ltirpc. For them there are no options.
> 
> But for the rpc test cases (tests_pack/rpc_suite/rpc/)... If I 
> understood libtirpc correctly, libtirpc should provide the same 
> interfaces as "ordinary" libc does. Therefore these test cases may be 
> linked either with libc or with libtirpc. And both versions will work 
> the same way.

It looks like the glibc maintainers decided to get rid of the old RPC
implementation in glibc and that tirpc should be replacement for it. But
distributions had to reeanble it because tirpc wasn't completly ready to
be drop in replacement:

http://jaegerandi.blogspot.cz/2011/08/updating-glibc-to-214-with-some.html

I wonder what is the situation now, perhaps you should ask on glibc ML
(feel free to cc LTP ML as well).

> But here the problems come.
> 
> For example, this suite contains a testcase like this:
> #include <rpc/rpc.h>
> 
> int main(int argc, char **argv)
> {
>          int fd = 0;
>          SVCXPRT *svcr = NULL;
> 
>          svcr = svcfd_create(fd, 0, 0);
> 
>          printf("%p\n", svcr);
> 
>          svc_destroy(svcr);
> 
>          return 0;
> }
> 
> My host is Ubuntu 12.04 i386. If I build this binary with libc I get:
> stas@Alex-notebook:/tmp$ gcc test.c -o test
> stas@Alex-notebook:/tmp$ ./test
> 0x924c008
> 
> but if I try to get it linked with libtirpc I get:
> stas@Alex-notebook:/tmp$ gcc -I/usr/include/tirpc test.c -ltirpc -o test
> stas@Alex-notebook:/tmp$ ./test
> test: svc_fd_create: could not retrieve local addr
> (nil)
> Segmentation fault (core dumped)
>
> Can anybody explain why this happens? Maybe I have to do some extra 
> steps for libtirpc?

I guess that the segfault happens because you passed NULL to
svc_destroy() and it dereferenced the pointer.

And the failure in svcfd_create() is caused by the fact that the code
calls getsockname() on the fd which in this case is 0 (stdin). The
return value is -1 and errno likely ENOTSOCK. See src/svc_vc.c in
libtirpc sources (note that svcfd_create() is just a wrapper for
svc_fd_create()).

On the other hand the glibc counterpart does not seem to care what type
of file descriptor it gets.

Which explains what happened but I have no idea if you can pass
arbitrary file descriptor to these function or not.

> Ok, I would switch to use libc and wouldn't care about that, but some 
> test cases can't be linked with libc. For example - 
> rpc_regunreg_registerrpc. If I try to link it with libc I get:
> (.text+0xa1): undefined reference to `registerrpc'
> 
> I suppose that this problem is local to Ubuntu - I can build all the 
> test binaries except the ones which employ registerrpc function.
> BTW, I don't observe such behavior in RHEL6.
> 
> In general, I like the idea of build everything with -ltirpc. Because 
> RPC support in glibc is said to be ad-hoc, and it's disabled by default. 
> However, distribution vendors enable some triggers to get this support 
> back in their distributions.
> 
> If we build everything with -ltirpc, we will not care about this glibc 
> triggers and will test libtirpc (and if libtirpc is not available on the 
> host, the test suite will not be built).

I would like to know what glibc maintainers think about this.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
