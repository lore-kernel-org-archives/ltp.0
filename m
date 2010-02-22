Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Njcqv-0000Ea-2u
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 18:17:53 +0000
Received: from mail-px0-f171.google.com ([209.85.216.171])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Njcqu-0004U4-5J
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 18:17:53 +0000
Received: by pxi1 with SMTP id 1so1653423pxi.23
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Feb 2010 10:17:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100222164921.GC2992@linux.vnet.ibm.com>
References: <4B823681.7010300@linux.vnet.ibm.com>
	<OF7B2672AC.4ABA3E07-ON652576D2.005673AB-652576D2.005717E8@in.ibm.com>
	<20100222164921.GC2992@linux.vnet.ibm.com>
Date: Mon, 22 Feb 2010 10:17:46 -0800
Message-ID: <364299f41002221017y4b49a212qd81ebc248d4b89d2@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [ANNOUNCEMENT]: Intermediate release for FEB'10
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
To: Iranna D Ankad <iranna.ankad@in.ibm.com>, LTP <ltp-list@lists.sourceforge.net>, Rishikesh K Rajak <risrajak@in.ibm.com>, Vishukumar S Shetty <svishuku@in.ibm.com>, Garrett Cooper <yanegomi@gmail.com>

On Mon, Feb 22, 2010 at 8:49 AM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> Hi Iranna,
>
>
> Thanks for reporting this build failure and helping, as it will
> really help to make ltp more stable.
>
> Here is the quick patch i am attaching which solves the problem.
>
> Signed-off By: Rishikesh K Rajak<risrajak@linux.vnet.ibm.com>
> Tested By: Rishikesh K Rajak<risrajak@linux.vnet.ibm.com>
> ---
> diff --git a/testcases/kernel/syscalls/mbind/mbind01.c
> b/testcases/kernel/syscalls/mbind/mbind01.c
> index 5d7eb69..847186a 100644
> --- a/testcases/kernel/syscalls/mbind/mbind01.c
> +++ b/testcases/kernel/syscalls/mbind/mbind01.c
> @@ -74,6 +74,7 @@ int =A0TST_TOTAL =3D 2; =A0 =A0 =A0 =A0 =A0 /* total nu=
mber of tests
> in this file. =A0 */
> =A0#include <unistd.h>
> =A0#include "include_j_h.h"
> =A0#include "numa_helpers.h"
> +#include <linux/mempolicy.h>
>
> =A0#if ! defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2

No. This patch shouldn't be committed because of namespace collisions
between numa and mempolicy (thank the developers for just copy-pasting
constants, macros, etc instead of properly requiring numa on the
target system in order for mempolicy to work...).

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
