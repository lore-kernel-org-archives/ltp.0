Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XLuIp-0008HS-Gd
	for ltp-list@lists.sourceforge.net; Mon, 25 Aug 2014 13:27:19 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XLuIj-0002qj-K9
	for ltp-list@lists.sourceforge.net; Mon, 25 Aug 2014 13:27:19 +0000
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id s7PDR7B9013646
	for <ltp-list@lists.sourceforge.net>; Mon, 25 Aug 2014 09:27:07 -0400
Date: Mon, 25 Aug 2014 09:27:07 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1258655320.12473248.1408973227573.JavaMail.zimbra@redhat.com>
In-Reply-To: <1583769408.12443176.1408972372985.JavaMail.zimbra@redhat.com>
References: <f8ac54907cad048b8c762d0394f5e86c0ccaa5da.1408712259.git.jstancek@redhat.com>
	<20140825124837.GA13295@rei.suse.cz>
	<1583769408.12443176.1408972372985.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] sendmsg02: fix parameter passed to semctl(SETVAL)
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
To: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: chrubis@suse.cz
> Cc: ltp-list@lists.sourceforge.net
> Sent: Monday, 25 August, 2014 3:12:52 PM
> Subject: Re: [LTP] [PATCH] sendmsg02: fix parameter passed to semctl(SETVAL)
> 
> 
> 
> 
> 
> ----- Original Message -----
> > From: chrubis@suse.cz
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: ltp-list@lists.sourceforge.net
> > Sent: Monday, 25 August, 2014 2:48:38 PM
> > Subject: Re: [LTP] [PATCH] sendmsg02: fix parameter passed to
> > semctl(SETVAL)
> > 
> > Hi!
> > > The fourth has the type union semun.
> > 
> > The change looks good. I guess that this may have been failing on some
> > big endian machine where sizeof(void*) != sizeof(int), am I right?
> 
> You're right it was big endian machine, but with sizeof(void *) == 4 and
> sizeof(int) == 4.
> 
> Fourth parameter is expected to be passed by reference,
> so it was actually crashing on RHEL5.10 ppc:
> 
> void func()
> {
> 	union semun a;
> 	a.val = 0;
> 	semctl(123, 456, SETVAL, a);
> }
> 
> (gdb) disassemble func
> Dump of assembler code for function func:
> 0x1000047c <func+0>:	stwu    r1,-48(r1)
> 0x10000480 <func+4>:	mflr    r0
> 0x10000484 <func+8>:	stw     r31,44(r1)
> 0x10000488 <func+12>:	stw     r0,52(r1)
> 0x1000048c <func+16>:	mr      r31,r1
> 0x10000490 <func+20>:	li      r0,0
> 0x10000494 <func+24>:	stw     r0,8(r31)
> 0x10000498 <func+28>:	lwz     r0,8(r31)
> 0x1000049c <func+32>:	stw     r0,24(r31)
> 0x100004a0 <func+36>:	addi    r0,r31,24
> 0x100004a4 <func+40>:	li      r3,123
> 0x100004a8 <func+44>:	li      r4,456
> 0x100004ac <func+48>:	li      r5,16
> 0x100004b0 <func+52>:	mr      r6,r0
> 0x100004b4 <func+56>:	crclr   4*cr1+eq
> 0x100004b8 <func+60>:	bl      0x10000870 <semctl@plt>
> 0x100004bc <func+64>:	lwz     r11,0(r1)
> 0x100004c0 <func+68>:	lwz     r0,4(r11)
> 0x100004c4 <func+72>:	mtlr    r0
> 0x100004c8 <func+76>:	lwz     r31,-4(r11)
> 0x100004cc <func+80>:	mr      r1,r11
> 0x100004d0 <func+84>:	blr
> End of assembler dump.
> 
> (gdb) b *0x100004b8
> Breakpoint 1 at 0x100004b8: file a.c, line 18.
> 
> (gdb) r
> Starting program:
> /mnt/tests/scratch/jstancek2/ltp-full-20140820/testcases/kernel/syscalls/sendmsg/a.out
> 
> Breakpoint 1, 0x100004b8 in func () at a.c:18
> 18		semctl(123, 456, SETVAL, a);
> 
> (gdb) p &a
> $1 = (union semun *) 0xffacf488
> 
> (gdb) p/x $r6
> $2 = 0xffacf498

Patch pushed.

Regards,
Jan

> 
> ------------------------------------------------------------------------------
> Slashdot TV.
> Video for Nerds.  Stuff that matters.
> http://tv.slashdot.org/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
