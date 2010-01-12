Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NUcTu-0002qe-Nv
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 08:52:06 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUcTs-0005Br-DM
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 08:52:06 +0000
Received: by pzk31 with SMTP id 31so918066pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jan 2010 00:51:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <001401ca9354$224c92a0$66e5b7e0$@co.jp>
References: <001401ca9354$224c92a0$66e5b7e0$@co.jp>
Date: Tue, 12 Jan 2010 00:51:58 -0800
Message-ID: <364299f41001120051w4ba5f884q87a19e7d38935a49@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Build failure with 2010-01-08 cvs
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Mon, Jan 11, 2010 at 10:54 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> I tried to make with 2010-01-08 version cvs in my RHEL5.4
> (2.6.18-164.el5) system.
> But it failed with following message:
>
> ------------
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/home/LTP/ltp-2010-01-08/testcases/kernel/include
> -I/home/LTP/ltp-2010-01-08/testcases/kernel/syscalls/move_pages/../utils
> -I../../../../include -I../../../../include =A0-c -o move_pages01.o
> move_pages01.c
> In file included from move_pages01.c:58:
> move_pages_support.h:22:20: error: numaif.h: No such file or directory
> make[4]: *** [move_pages01.o] Error 1
> ------------
>
> 2010-01-07 version cvs doesn't fail.
>
> Perhaps, this error is caused by revision of RHEL4.8's make error, I thin=
k.
> (URL:http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg09180.=
htm
> l)
> I'm sorry If I mistaked.
>
> In above revising, "${LTPROOT/testcases/kernel/syscalls/utils/numaif.h"
> is removed. But "move_pages01.c" uses this file indirectly.

    You're correct. It isn't needed anymore in that header, and has
since then been removed.

> Is the plan to delete a definition of "nodemask_dump" from "${LTPROOT/
> testcases/kernel/syscalls/get_mempolicy/../utils/numa_helpers.h" file
> no use?

    No, I renamed numaif.h and removed all of the duplicate entries
(nodemask_dump being one of them), because it was a custom API
provided by the crackerjack test suite and because numaif.h was an
almost direct copy of a fixed version of numaif.h (instead of being a
properly tailored set of feature tests as I later discovered).
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
