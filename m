Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NuuMz-0007rN-C9
	for ltp-list@lists.sourceforge.net; Thu, 25 Mar 2010 21:13:37 +0000
Received: from mail-iw0-f195.google.com ([209.85.223.195])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NuuMx-0006Qq-Rd
	for ltp-list@lists.sourceforge.net; Thu, 25 Mar 2010 21:13:37 +0000
Received: by iwn33 with SMTP id 33so1361240iwn.23
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Mar 2010 14:13:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1269543366.6832.1.camel@subratamodak.linux.ibm.com>
References: <20100324133645.23583.48891.sendpatchset@subratamodak.linux.ibm.com>
	<364299f41003241048hecba971td1ed20876a398b59@mail.gmail.com>
	<1269543366.6832.1.camel@subratamodak.linux.ibm.com>
Date: Thu, 25 Mar 2010 14:13:30 -0700
Message-ID: <364299f41003251413x25751abcp12f0018f77b5279@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix fallocate() build issue for EXT4 Online
	Defragmentation Test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>, Miao Xie <miaox@cn.fujitsu.com>

On Thu, Mar 25, 2010 at 11:56 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> Miao,
>
> On Wed, 2010-03-24 at 10:48 -0700, Garrett Cooper wrote:
>> On Wed, Mar 24, 2010 at 6:36 AM, Subrata Modak
>> <subrata@linux.vnet.ibm.com> wrote:
>> > Earlier Subject: Re: [LTP] ext4/e4defrag.c testcases compilation error,
>> >
>> > Hi Garret/Miao,
>> >
>> > On PPC systems, fallocate() seems to be already defined at /usr/includ=
e/bits/fcntl.h,
>> > so building EXT4 test cases on PPC64 machines will create build proble=
ms even if the
>> > pre-requisite packages:
>> >
>> > e2fsprogs*
>> > e2fsprogs-libs*
>> > e2fsprogs-devel*
>> >
>> > are present. So, this patch adds an extra check. Please let me know yo=
ur thoughts.
>> >
>> > Errors bound to occur:
>> > [
>> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall =A0-I/root/subrata/=
ltp/ltp-dev/testcases/kernel/include -I../../../../../include -I../../../..=
/../include =A0 -L../../../../../lib =A0e4defrag.c =A0 -lltp -lm -o e4defrag
>> > e4defrag.c:388: error: conflicting types for =91fallocate=92
>> > /usr/include/bits/fcntl.h:240: note: previous declaration of =91falloc=
ate=92 was here
>> > make[1]: *** [e4defrag] Error 1
>> > ]
>> >
>> > Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
>> > ---
>> >
>> > --- ltp-dev/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/e=
4defrag.c 2010-03-15 19:32:12.000000000 +0530
>> > +++ ltp-dev.modified/testcases/kernel/fs/ext4-new-features/ext4-online=
-defrag/e4defrag.c =A0 =A0 =A0 =A02010-03-24 18:09:14.336793513 +0530
>> > @@ -383,10 +383,13 @@ int sync_file_range(int fd, loff_t offse
>> > =A0* @offset: =A0 =A0 =A0 =A0 =A0 =A0file offset.
>> > =A0* @len: =A0 =A0 =A0 =A0 =A0 =A0 =A0 file size.
>> > =A0*/
>> > +
>> > +#ifndef __NR_fallocate
>> > =A0int fallocate(int fd, int mode, loff_t offset, loff_t len)
>> > =A0{
>> > =A0 =A0 =A0 =A0return syscall(__NR_fallocate, fd, mode, offset, len);
>> > =A0}
>> > +#endif
>>
>> =A0 =A0 If it's not defined, you're definitely in trouble because that
>> will result in a compile error. An autoconf test should be added for
>> this syscall, and/or linux_syscall_numbers.h should be integrated into
>> this test. That may be a bit heavy handed because that will integrate
>> some libltp pieces into the tests, but that's up to Miao to decide.
>
> Did you get a chance to check this patch ?
>
> Regards--
> Subrata

    Nope, but my concern still stands unaddressed.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
