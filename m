Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WSOES-0002Mg-LJ
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 10:05:20 +0000
Date: Tue, 25 Mar 2014 11:04:54 +0100
From: chrubis@suse.cz
Message-ID: <20140325100454.GA24632@rei>
References: <87r46seayt.fsf@redhat.com>
 <533143E9.5050104@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <533143E9.5050104@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3] syscalls/fork: add new case fork14
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> > +static void cleanup(void)
> > +{
> > +	TEST_CLEANUP;
> > +}
> > +
> > +static int fork_test(void)
> > +{
> > +	int i, ret = 0;
> > +	void *addr;
> > +
> > +	for (i = 0; i < EXTENT; i++) {
> > +		addr = mmap(NULL, 1 * GB, PROT_READ | PROT_WRITE,
> > +			MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> 
> I have some question here.
> In you v2 patch, you added some code to determine the fail of mmap():
> 
> > addr = mmap(NULL, (size_t) 1 * GB, PROT_READ | PROT_WRITE,
> > +			MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> > +		if (addr == MAP_FAILED)
> > +			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
> 
> But in v3 patch, you deleted it. I think this maybe not right in some conditions.
>
> If in this for loop, mmap() fails for 10000 times(Indeed, I don't know whether it would occur),
> then we won't get a memory map, whose vm_area_struct is 16TB size, so the overflow won't occur.
> 
> So I think TCONF should be return in case mmap() failes. At least, we can ensure we have
> a vm_area_struct sized 16TB.

The problem is that with memory overcommit turned off the mmap will
start to fail as soon as all machine memory is used up. While ignoring
the return value is not best solution it is the easiest one. Returning
TCONF may be a bit better but that would complicate the test, see below.

> According to the Siddhesh Poyarekar's mail, he attached a more clearer test program.
> #include <unistd.h>
> #include <sys/mman.h>
> #include <errno.h>
> 
> #define GIG 1024 * 1024 * 1024L
> #define EXTENT 16393
> 
> int main(void)
> {
>         int i, r;
>         void *m;
>         char buf[1024];
>         int prev_failed = 0;
> 
>         for (i = 0; i < EXTENT; i++) {
>                 printf("i %d\n", i);
>                 m = mmap(NULL, (size_t) 1 * 1024 * 1024 * 1024L,
>                          PROT_READ | PROT_WRITE, MAP_PRIVATE |
>                          MAP_ANONYMOUS, 0, 0);
> 
>                 if (m == (void *)-1) {
>                         printf("MMAP Failed: %d\n", errno);
>                         return 1;
>                 }
> 
>                 r = fork();
> 
>                 if (r == 0) {
>                         return 0;
>                 } else if (r < 0) {
>                         prev_failed = 1;
>                         /* Fork failed as expected */
>                 } else if (r > 0 && prev_failed) {
>                         printf("Unexpected success at %d\n", i);
>                         wait(NULL);
>                         return 1;
>                 }
>         }
> 
>         return 0;
> }
> 
> I think this test program will be more appropriate. If the test failed before, then
> prev_failed is 1, and  if we continue to mmap,the vm_area_struct's size will
> continue to extend. If overflow does not occur, that is the bug is not exist, then
> fork will continue to fail. But if in some point, fork() success, then we can determine the
> overflow occurs now.

This program has two problems.

1. It will fail when memory overcommit is turned off
2. And it will fail if it's ported to LTP and the test was was
   started with -i 10 (because the mappings are not freed mmap will
   start to fail sooner or later)

If you want to make the test better you have to clear the mappings on
each test iteration (save the addr and unmap it later) and you may
change the code to exit with TCONF when mmap() failed before EXTENT was
reached.

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
