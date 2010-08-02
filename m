Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Og1gM-0007ee-9O
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 20:32:22 +0000
Received: from mail-iw0-f174.google.com ([209.85.214.174])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Og1gL-0000WU-Kv
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 20:32:22 +0000
MIME-Version: 1.0
In-Reply-To: <4C56CAAF020000E800067098@sinclair.provo.novell.com>
References: <4C56CAAF020000E800067098@sinclair.provo.novell.com>
Date: Mon, 2 Aug 2010 13:32:16 -0700
Message-ID: <AANLkTi=3XNgjeGbrb=quAggkSoOuop3krk+LLauR5AdU@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Patch] Allow swapon03 test to pass with unknown
	max_swapfiles
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
To: Murlin Wenzel <mwenzel@novell.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Mon, Aug 2, 2010 at 12:39 PM, Murlin Wenzel <mwenzel@novell.com> wrote:
> This patch will allow swapon03 test case to pass even when max_swapfiles =
is not known. =A0Create maximum possible number of swapfiles during setup, =
then verify that attempting to create one more swapfile will return EPERM. =
=A0This is meant to change as little as possible of the existing code.
>
> Signed-off-by: Murlin Ray Wenzel mwenzel@novell.com

ACK.

This seems like a decent compromise because the point where this could
fail is after the first iteration and we already check for root, which
means that the first clause (CAP_SYS_ADMIN) of EPERM is caught:

EPERM
    The caller does not have the CAP_SYS_ADMIN capability or the
maximal number of swap files has been reached. (The maximum is
MAX_SWAPFILES-2(30) if CONFIG_MIGRATION is enabled, MAX_SWAPFILES (32)
otherwise. In Linux kernel versions prior to 2.4.10, the maximum was
always MAX_SWAPFILES, which was 8.

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
