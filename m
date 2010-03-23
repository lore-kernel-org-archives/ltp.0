Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nu7AO-0007wn-2d
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 16:41:20 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nu7AN-00028Z-1N
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 16:41:20 +0000
Received: by pwj6 with SMTP id 6so124165pwj.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 23 Mar 2010 09:41:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100323092022.GD4384@linux.vnet.ibm.com>
References: <20100323092022.GD4384@linux.vnet.ibm.com>
Date: Tue, 23 Mar 2010 09:41:12 -0700
Message-ID: <364299f41003230941r243483en1c334493cf9ccfb3@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] ext4/e4defrag.c testcases compilation error
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
To: ltp-list@lists.sourceforge.net, Akira Fujita <a-fujita@rs.jp.nec.com>, Takashi Sato <t-sato@yk.jp.nec.com>

On Tue, Mar 23, 2010 at 2:20 AM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
>
> Hi,
>
> While building ext4 testcases i am getting following error, let me know if
> anyone aware about this with handy solution, else will work later today o=
n this.
>
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/root/ltp-dev-next/testcases/kernel/include -I../../../../../include
> -I../../../../../include =A0 -L../../../../../lib =A0e4defrag.c =A0 -lltp=
 -lm -o
> e4defrag
> e4defrag.c:165: error: expected specifier-qualifier-list before =91__u64=
=92
> e4defrag.c:179: error: expected specifier-qualifier-list before =91__u64=
=92
> e4defrag.c:185: error: expected specifier-qualifier-list before =91__s32=
=92
> e4defrag.c:194: error: expected specifier-qualifier-list before =91__u64=
=92
> e4defrag.c:206: error: expected specifier-qualifier-list before =91__u64=
=92
> e4defrag.c:224: error: expected =91=3D=92, =91,=92, =91;=92, =91asm=92 or=
 =91__attribute__=92 before
> =91__le16=92
> e4defrag.c:225: error: expected =91=3D=92, =91,=92, =91;=92, =91asm=92 or=
 =91__attribute__=92 before
> =91__le32=92
> e4defrag.c:226: error: expected =91=3D=92, =91,=92, =91;=92, =91asm=92 or=
 =91__attribute__=92 before
> =91__le64=92
> e4defrag.c:232: error: expected specifier-qualifier-list before =91__le32=
=92
> e4defrag.c:331: error: expected =91=3D=92, =91,=92, =91;=92, =91asm=92 or=
 =91__attribute__=92 before
> =91log_groups_per_flex=92
> e4defrag.c:332: error: expected =91=3D=92, =91,=92, =91;=92, =91asm=92 or=
 =91__attribute__=92 before
> =91blocks_per_group=92
> e4defrag.c:333: error: expected =91=3D=92, =91,=92, =91;=92, =91asm=92 or=
 =91__attribute__=92 before
> =91feature_incompat=92
> e4defrag.c:342: error: expected =91=3D=92, =91,=92, =91;=92, =91asm=92 or=
 =91__attribute__=92 before
> =91ext2fs_swab32=92

    __u64, et all are kernel datatypes; I've had a lot of fun trying
to integrate tests like these, so I'd definitely contact the
maintainers.
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
