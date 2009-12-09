Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NIErX-000415-GO
	for ltp-list@lists.sourceforge.net; Wed, 09 Dec 2009 05:13:19 +0000
Received: from mail-px0-f189.google.com ([209.85.216.189])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NIErR-0000h8-9Y
	for ltp-list@lists.sourceforge.net; Wed, 09 Dec 2009 05:13:19 +0000
Received: by pxi27 with SMTP id 27so1018807pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 08 Dec 2009 21:13:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001ca77ef$78ed7f00$6ac87d00$@co.jp>
References: <000001ca77ef$78ed7f00$6ac87d00$@co.jp>
Date: Tue, 8 Dec 2009 21:06:52 -0800
Message-ID: <364299f40912082106x43632a8ble8bc334070510932@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Build failure with ltp-2009-12-08 cvs
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

On Tue, Dec 8, 2009 at 2:16 AM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
>
> I tried to "make" with "ltp-2009-12-08.tar.gz" version
> in RHEL4.8 (kernel 2.6.9-89.ELsmp) and x86 architecture.
>
> But it failed by following message:
>
> ------------
> make[4]: Entering directory
> `/home/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_mempolicy'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/home/LTP/ltp-2009-12-08/testcases/kernel/include
> -I/home/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_mempolicy/../uti=
ls
> -I../../../../include -I../../../../include =A0 -L../../../../lib
> get_mempolicy01.c =A0 -lltp -lnuma -o get_mempolicy01
> In file included from get_mempolicy01.c:58:
> /home/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_mempolicy/../utils=
/nu
> maif.h:88: error: redefinition of 'nodemask_set'
> /usr/include/numa.h:45: error: previous definition of 'nodemask_set' was
> here
> make[4]: *** [get_mempolicy01] Error 1
> make[4]: Leaving directory
> `/home/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_mempolicy'
> make[3]: *** [all] Error 2
> ------------
>
> For reference, "make" succeeded in my following systems:
> =A0- RHEL5.4 (kernel 2.6.18-164.el5) and x86 architecture
> =A0- RHEL5.4 (kernel 2.6.18-164.el5) and x86_64 architecture
>
>
> "nodemask_set" is the structure whitch defined in following two header
> files:
> =A0(a) "${LTPROOT}/testcases/kernel/syscalls/utils/numaif.h"
> =A0(b) "/usr/include/numa.h"
>
> In "numaif.h" file, definition is as follows:

Mitani-san,
    This issue keeps on coming back to haunt us. Can you tell me what
the Fedora Core equivalent of RHEL 4.8 is so I can isolate and resolve
the issue?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
