Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XSM0d-0005bM-PK
	for ltp-list@lists.sourceforge.net; Fri, 12 Sep 2014 08:15:11 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XSM0c-00067m-9j
	for ltp-list@lists.sourceforge.net; Fri, 12 Sep 2014 08:15:11 +0000
Date: Fri, 12 Sep 2014 04:15:01 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1324550878.22071909.1410509701094.JavaMail.zimbra@redhat.com>
In-Reply-To: <20140912072845.GA3585@localhost.localdomain>
References: <20140911022709.GA16027@localhost.localdomain>
	<5411B499.8020309@redhat.com>
	<20140912072845.GA3585@localhost.localdomain>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] ldd01: using 'ppc' to check powerpc arch
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
To: Han Pingtian <hanpt@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net




----- Original Message -----
> From: "Han Pingtian" <hanpt@linux.vnet.ibm.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 12 September, 2014 9:28:45 AM
> Subject: Re: [LTP] [PATCH] ldd01: using 'ppc' to check powerpc arch
> 
> On Thu, Sep 11, 2014 at 04:41:29PM +0200, Jan Stancek wrote:
> > Would you be willing to try attached patch, which moves the build
> > of .so and a.out into Makefile?
> I have tested your patch but ldd cannot find the lib files:
> 

That's only matter of setting correct LD_LIBRARY_PATH:

$ env LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH ./ldd01 
  ASSERTION 1  
	lddfile1.obj.so => ./lddfile1.obj.so (0x00007f06504db000)
	lddfile2.obj.so => ./lddfile2.obj.so (0x00007f06502d9000)
	lddfile3.obj.so => ./lddfile3.obj.so (0x00007f06500d8000)
	lddfile4.obj.so => ./lddfile4.obj.so (0x00007f064fed7000)
	lddfile5.obj.so => ./lddfile5.obj.so (0x00007f064fcd5000)
ASSERTION #1 PASS
 ASSERTION 2  
	lddfile1.obj.so => ./lddfile1.obj.so (0x00007ffe913e9000)
	lddfile2.obj.so => ./lddfile2.obj.so (0x00007ffe911e7000)
	lddfile3.obj.so => ./lddfile3.obj.so (0x00007ffe90fe6000)
	lddfile4.obj.so => ./lddfile4.obj.so (0x00007ffe90de5000)
	lddfile5.obj.so => ./lddfile5.obj.so (0x00007ffe90be3000)
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3.4) => /lib64/libc.so.6
	./lddfile1.obj.so:
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3.4) => /lib64/libc.so.6
	./lddfile2.obj.so:
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3.4) => /lib64/libc.so.6
	./lddfile3.obj.so:
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3.4) => /lib64/libc.so.6
	./lddfile4.obj.so:
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3.4) => /lib64/libc.so.6
	./lddfile5.obj.so:
		libc.so.6 (GLIBC_2.2.5) => /lib64/libc.so.6
		libc.so.6 (GLIBC_2.3.4) => /lib64/libc.so.6
		ld-linux-x86-64.so.2 (GLIBC_PRIVATE) => /lib64/ld-linux-x86-64.so.2
		ld-linux-x86-64.so.2 (GLIBC_2.3) => /lib64/ld-linux-x86-64.so.2
ASSERTION #2 PASS
TEST PASSES

> 
> > Or alternatively, can you describe
> > the ppc system where this is failing, so I could try to reproduce
> > it myself?
> This is a power 6 system, which running a beta version rhel5.11. Without
> my patch, it failed with those messages:

It also fails (with or without your patch) when built as 32-bit on RHEL7 ppc64:

# ./ldd01 
/usr/bin/ld: powerpc:common architecture of input file `/root/ltp/testcases/commands/ade/ldd/lddfile1.obj' is incompatible with powerpc:common64 output
/root/ltp/testcases/commands/ade/ldd/lddfile1.obj: In function `file1':
/root/ltp/testcases/commands/ade/ldd/lddfile1.c:3: undefined reference to `_GLOBAL_OFFSET_TABLE_'
/root/ltp/testcases/commands/ade/ldd/lddfile1.c:3: undefined reference to `_GLOBAL_OFFSET_TABLE_'
collect2: error: ld returned 1 exit status
/usr/bin/ld: powerpc:common architecture of input file `/root/ltp/testcases/commands/ade/ldd/lddfile2.obj' is incompatible with powerpc:common64 output
/root/ltp/testcases/commands/ade/ldd/lddfile2.obj: In function `file2':
/root/ltp/testcases/commands/ade/ldd/lddfile2.c:3: undefined reference to `_GLOBAL_OFFSET_TABLE_'
/root/ltp/testcases/commands/ade/ldd/lddfile2.c:3: undefined reference to `_GLOBAL_OFFSET_TABLE_'
collect2: error: ld returned 1 exit status
/usr/bin/ld: powerpc:common architecture of input file `/root/ltp/testcases/commands/ade/ldd/lddfile3.obj' is incompatible with powerpc:common64 output
/root/ltp/testcases/commands/ade/ldd/lddfile3.obj: In function `file3':
/root/ltp/testcases/commands/ade/ldd/lddfile3.c:3: undefined reference to `_GLOBAL_OFFSET_TABLE_'
/root/ltp/testcases/commands/ade/ldd/lddfile3.c:3: undefined reference to `_GLOBAL_OFFSET_TABLE_'
collect2: error: ld returned 1 exit status
/usr/bin/ld: powerpc:common architecture of input file `/root/ltp/testcases/commands/ade/ldd/lddfile4.obj' is incompatible with powerpc:common64 output
/root/ltp/testcases/commands/ade/ldd/lddfile4.obj: In function `file4':
/root/ltp/testcases/commands/ade/ldd/lddfile4.c:3: undefined reference to `_GLOBAL_OFFSET_TABLE_'
/root/ltp/testcases/commands/ade/ldd/lddfile4.c:3: undefined reference to `_GLOBAL_OFFSET_TABLE_'
collect2: error: ld returned 1 exit status
/usr/bin/ld: powerpc:common architecture of input file `/root/ltp/testcases/commands/ade/ldd/lddfile5.obj' is incompatible with powerpc:common64 output
/root/ltp/testcases/commands/ade/ldd/lddfile5.obj: In function `file5':
/root/ltp/testcases/commands/ade/ldd/lddfile5.c:3: undefined reference to `_GLOBAL_OFFSET_TABLE_'
/root/ltp/testcases/commands/ade/ldd/lddfile5.c:3: undefined reference to `_GLOBAL_OFFSET_TABLE_'
collect2: error: ld returned 1 exit status
gcc: error: /tmp/ldd01-26565/lddfile*.obj.so: No such file or directory
  ASSERTION 1  
ldd: /tmp/ldd01-26565/a.out: No such file or directory
ASSERTION #1 FAIL

which is why I'd prefer to avoid all that -m32/-m64 logic in ldd01.

Regards,
Jan

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
