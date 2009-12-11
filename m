Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NIwTw-0002hH-5c
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 03:47:52 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-3.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NIwTp-0004D5-Jm
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 03:47:52 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000001ca77ef$78ed7f00$6ac87d00$@co.jp>
	<364299f40912082106x43632a8ble8bc334070510932@mail.gmail.com>
In-Reply-To: <364299f40912082106x43632a8ble8bc334070510932@mail.gmail.com>
Date: Fri, 11 Dec 2009 12:47:35 +0900
Message-ID: <000001ca7a14$ad632150$082963f0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
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
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

I tried to let RHEL4.8's failure reappear in the other OS.

I obtained CentOS4.8 and installed it in my machine.
CentOS4.8 has same version kernel as RHEL4.8(kernel 2.6.9-89.ELsmp).

I tried to "make" with "ltp-2009-12-08.tar.gz" version in CentOS4.8.
And I succeeded to let RHEL4.8's failure reappear:

------------
make[4]: Entering directory
`/home/mitani/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get
_mempolicy'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/mitani/LTP/ltp-2009-12-08/test
cases/kernel/include
-I/home/mitani/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_mempo
licy/../utils -I../../../../include -I../../../../include
-L../../../../lib  get_mempoli
cy01.c   -lltp -lnuma -o get_mempolicy01
In file included from get_mempolicy01.c:58:
/home/mitani/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_mempolicy/../u
tils/numaif.h:
88: error: redefinition of 'nodemask_set'
/usr/include/numa.h:45: error: previous definition of 'nodemask_set' was
here
make[4]: *** [get_mempolicy01] Error 1
make[4]: Leaving directory
`/home/mitani/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_
mempolicy'
make[3]: *** [all] Error 2
------------

I confirmed that this error message is the same one
that happened in RHEL4.8.

After that, I revised "${LTPROOT}/testcases/kernel/syscalls/utils/numaif.h"
file.
Then, "make" succeeded.

Does this information help you?


Regards--

-Tomonori Mitani


-----Original Message-----
From: Garrett Cooper [mailto:yanegomi@gmail.com] =

Sent: Wednesday, December 09, 2009 2:07 PM
To: Mitani
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] Build failure with ltp-2009-12-08 cvs

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
>
-I/home/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_mempolicy/../utils
> -I../../../../include -I../../../../include =A0 -L../../../../lib
> get_mempolicy01.c =A0 -lltp -lnuma -o get_mempolicy01
> In file included from get_mempolicy01.c:58:
>
/home/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_mempolicy/../utils/nu
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
