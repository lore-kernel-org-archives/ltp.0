Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Sj3tL-0007ol-1B
	for ltp-list@lists.sourceforge.net; Mon, 25 Jun 2012 07:39:23 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Sj3tF-000834-7N
	for ltp-list@lists.sourceforge.net; Mon, 25 Jun 2012 07:39:22 +0000
Received: by pbbrq2 with SMTP id rq2so5714778pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 25 Jun 2012 00:39:11 -0700 (PDT)
Message-ID: <4FE81583.5090406@casparzhang.com>
Date: Mon, 25 Jun 2012 15:38:43 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4F9B7CF5.8070600@linux.vnet.ibm.com>
In-Reply-To: <4F9B7CF5.8070600@linux.vnet.ibm.com>
Subject: Re: [LTP] [PATCH]page numbers should be decreased to 1 in vma01 test
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
To: hejianet <hejianet@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On 04/28/2012 01:15 PM, hejianet wrote:
> Hi all
> testcases/kernel/mem/vma/vma01.c is to test the result of
> find_mergeable_anon_vma()
> In my opinion, it is not correct in some architectures
> 1)some architectures(eg.ppcnf) use *bottomup* vma layout instead of
> *topdown*
> so vma01 test should be masked in those architectures.
> 
> 2)even in the *topdown* architectures, there is a potential issure.
> I will give an example to show why the pagesize should be decreased from
> 3 to 1
> a.out is an elf file compiled from vma01.c with minor revision.
>> -bash-4.1# strace -f ./a.out
>> execve("./a.out", ["./a.out"], [/* 22 vars */]) = 0
>> brk(0)                                  = 0x10012000
>> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0x47ffd000
>> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
> directory)
>> open("/etc/ld.so.cache", O_RDONLY)      = 3
>> fstat64(3, {st_mode=S_IFREG|0644, st_size=12875, ...}) = 0
>> mmap(NULL, 12875, PROT_READ, MAP_PRIVATE, 3, 0) = 0x47ff9000
>> close(3)                                = 0
>> open("/lib/libc.so.6", O_RDONLY)        = 3
>> read(3,
> "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\351\354\0\0\0004"...,
> 512) = 512
>> fstat64(3, {st_mode=S_IFREG|0755, st_size=2015420, ...}) = 0
>> mmap(0xfe2c000, 1848788, PROT_READ|PROT_EXEC,
> MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xfe2c000
>> mprotect(0xffd2000, 90112, PROT_NONE)   = 0
>> mmap(0xffe8000, 20480, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ac000) = 0xffe8000
>> mmap(0xffed000, 9684, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffed000
>> close(3)                                = 0
>> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0x47ff8000
>> mprotect(0xffe8000, 16384, PROT_READ)   = 0
>> mprotect(0x47ffe000, 4096, PROT_READ)   = 0
>> munmap(0x47ff9000, 12875)               = 0
>> mmap(NULL, 12288, PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0) = 0x47ffa000
>> clone(Process 698 attached
>> child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
> child_tidptr=0x47ff8068) = 698
>> [pid   697] waitpid(-1,  <unfinished ...>
>> [pid   698] mmap(0x47ffd000, 12288, PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, 0, 0) = 0x47ff5000
>> [pid   698] fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0),
> ...}) = 0
>> [pid   698] mmap(NULL, 4096, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x47ff9000
>> [pid   698] write(1, "parent: t = 0x47ffa000\n", 23parent: t = 0x47ffa000
>> ) = 23
> 
> the symptom is when /etc/ld.so.cache is small, we never get a 2 3*ps
> aligned pages.
> we got the layout like this:
> ...
> 3*ps by children
> 1*ps
> 1*ps
> 3*ps by parent
> ...
> summary: a) the mmap area for loading /etc/ld.so.cache is nearby the
> normal mmap()
>          b) if the /etc/ld.so.cache is small, when it is unmmaped, there
> is a small hole left for allocating later.
>          c) we couldn't make sure that the 3*ps will be alignedly
> allocated if /etc/ld.so.cache is so small
> 
> conclusion: we need decrease the page number from 3 to 1 in vma01 test

Hi, thanks for the patch and sorry for (very very) late response due to
busying other things in past months...

I tried another approach in my PATCH 2/2, it creates a big hole to make
sure 2 3*ps can map successfully. I tried on my systems and it did work.
Could you try my patch 1/2 and 2/2 to see if it can solve your problem?

IIRC, reducing to 1*ps is a solution for this too, yet I've tried to see
if it can reproduce the bug we meet before.

Thanks,
Caspar

> 
> 
> --- testcases/kernel/mem/vma/vma01.c.ori    2012-04-28
> 12:51:16.453125000 +0800
> +++ testcases/kernel/mem/vma/vma01.c    2012-04-28 12:53:35.375000000 +0800
> @@ -92,7 +92,7 @@ static void check_vma(void)
>      int status;
>      void *t, *u, *x, *y;
>  
> -    t = mmap(NULL, 3*ps, PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, 0, 0);
> +    t = mmap(NULL, 1*ps, PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, 0, 0);
>      if (t == MAP_FAILED)
>          tst_brkm(TBROK|TERRNO, cleanup, "mmap");
>      memset(t, 1, ps);
> @@ -102,7 +102,7 @@ static void check_vma(void)
>          tst_brkm(TBROK|TERRNO, cleanup, "fork");
>      case 0:
>          memset(t, 2, ps);
> -        u = mmap(t + 3*ps, 3*ps, PROT_WRITE,
> +        u = mmap(t + 1*ps, 1*ps, PROT_WRITE,
>                  MAP_ANONYMOUS|MAP_PRIVATE, 0, 0);
>          if (u == MAP_FAILED) {
>              perror("mmap failed.\n");
> @@ -113,11 +113,11 @@ static void check_vma(void)
>          memset(u, 2, ps);
>  
>          x = get_end_addr(u, MAPS_FILE);
> -        if (x == u + 6*ps)
> +        if (x == u + 2*ps)
>              exit(1);
> -        if (x == u + 3*ps) {
> +        if (x == u + 1*ps) {
>              y = get_end_addr(x, MAPS_FILE);
> -            if (y == x + 3*ps)
> +            if (y == x + 1*ps)
>                  exit(0);
>          }
>          exit(255);
> @@ -157,10 +157,10 @@ static void check_status(int status)
>  {
>      switch (status) {
>      case 0:
> -        tst_resm(TPASS, "two 3*ps VMAs found.");
> +        tst_resm(TPASS, "two 1*ps VMAs found.");
>          break;
>      case 1:
> -        tst_resm(TFAIL, "A single 6*ps VMA found.");
> +        tst_resm(TFAIL, "A single 2*ps VMA found.");
>          break;
>      default:
>          tst_brkm(TBROK, cleanup, "unexpected VMA found.");
> 
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
