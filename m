Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PdyyM-0004LJ-Nv
	for ltp-list@lists.sourceforge.net; Sat, 15 Jan 2011 05:46:46 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PdyyL-0004ef-QZ
	for ltp-list@lists.sourceforge.net; Sat, 15 Jan 2011 05:46:46 +0000
Received: by wyb40 with SMTP id 40so3418310wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 14 Jan 2011 21:46:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=qFxgs4CPQ2EUwHin1LTgxw0V-RENPV9rRqraF@mail.gmail.com>
References: <AANLkTi=qFxgs4CPQ2EUwHin1LTgxw0V-RENPV9rRqraF@mail.gmail.com>
Date: Fri, 14 Jan 2011 21:46:39 -0800
Message-ID: <AANLkTi=NhvDY5+gCddvAWq1rkSKymv26DWdgwHpHgH5U@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Bug Fix] utimensat01 can't build
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
To: Vivi <violetleigh@gmail.com>
Cc: LTP mailing list <ltp-list@lists.sourceforge.net>

On Wed, Dec 29, 2010 at 1:35 AM, Vivi <violetleigh@gmail.com> wrote:
> LTP test case utimensat01.c can't build without file usctest.h.
>
> Bellow is the patch:
> --
> Index: testcases/kernel/syscalls/utimensat/utimensat01.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- testcases/kernel/syscalls/utimensat/utimensat01.c=A0=A0 (revision 161)
> +++ testcases/kernel/syscalls/utimensat/utimensat01.c=A0=A0 (revision 183)
> @@ -40,6 +40,7 @@
> =A0#include <string.h>
> =A0#include <sys/stat.h>
> =A0#include <test.h>
> +#include "usctest.h"
> =A0#include "linux_syscall_numbers.h"
>
> =A0char *TCID =3D "utimensat01";=A0=A0=A0 /* Test program identifier.=A0=
=A0=A0 */

Committed -- thanks.
-Garrett

---------------------------------------------------------------------------=
---
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand =

malware threats, the impact they can have on your business, and how you =

can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
