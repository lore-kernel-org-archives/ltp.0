Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NSojk-0005Ci-Vv
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 09:33:00 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSojk-00068K-41
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 09:33:00 +0000
Received: by pwj11 with SMTP id 11so12929436pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 07 Jan 2010 01:32:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000301ca8f6e$bc72b8d0$35582a70$@co.jp>
References: <000301ca8f6e$bc72b8d0$35582a70$@co.jp>
Date: Thu, 7 Jan 2010 01:32:53 -0800
Message-ID: <364299f41001070132u26b9637bwa357b64e0c8cc365@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Build failure with 2010-01-07 cvs
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

On Wed, Jan 6, 2010 at 11:55 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> I tried to make with latest version (2010-01-07 cvs) in RHEL4.8
> (2.6.9-89.ELsmp).
> But it failed with following message:
> ------------
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/home/LTP/ltp-2010-01-07/testcases/kernel/include -g
> -I/home/LTP/ltp-2010-01-07/testcases/kernel/syscalls/get_mempolicy/../uti=
ls
> -DNUMA_VERSION1_COMPATIBILITY -I../../../../include -I../../../../include
> -L../../../../lib =A0get_mempolicy01.c =A0 -lltp -lnuma -o get_mempolicy01
> In file included from get_mempolicy01.c:78:
> /home/LTP/ltp-2010-01-07/testcases/kernel/syscalls/get_mempolicy/../utils=
/nu
> ma_helpers.h:81: error: redefinition of 'nodemask_set'
> /usr/include/numa.h:45: error: previous definition of 'nodemask_set' was
> here
> /home/LTP/ltp-2010-01-07/testcases/kernel/syscalls/get_mempolicy/../utils=
/nu
> ma_helpers.h:95: error: redefinition of 'nodemask_dump'
> /home/LTP/ltp-2010-01-07/testcases/kernel/syscalls/get_mempolicy/../utils=
/nu
> maif.h:85: error: previous definition of 'nodemask_dump' was here
> make[4]: *** [get_mempolicy01] Error 1
> ------------
>
> "numa_helpers.h" is as follows (comments are omitted):
> ------------
> #ifndef LTP_NUMA_HELPERS_H
> #define LTP_NUMA_HELPERS_H
>
> #include "config.h"
> #if HAVE_NUMA_H
> #include <numa.h>
>
> static inline void nodemask_set(nodemask_t *mask, int node)
>
> { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <----- L.81
> =A0 =A0 =A0 =A0mask->n[node / (8*sizeof(unsigned long))] |=3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1UL << (node % (8*sizeof(unsigned long)))=
);
> }
>
> static inline void nodemask_dump(const char *header, const nodemask_t *ma=
sk)
> { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <----- L.95
> =A0 =A0 =A0 =A0int i;
> =A0 =A0 =A0 =A0EPRINTF("%s", header);
> =A0 =A0 =A0 =A0for (i =3D 0; i < NUMA_NUM_NODES/(sizeof(unsigned long)*8)=
; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EPRINTF(" 0x%08lx", mask->n[i]);
> =A0 =A0 =A0 =A0EPRINTF("\n");
> }
>
> #else
>
> typedef struct nodemask_t { };
>
> static inline void nodemask_set(nodemask_t *mask, int node)
> {
> =A0 =A0 =A0 =A0return;
> }
>
> static inline void nodemask_dump(const char *header, const nodemask_t *ma=
sk)
> {
> =A0 =A0 =A0 =A0return;
> }
>
> #endif
>
> #endif
> ------------
>
> In my system, HAVE_NUMA_H is defined as 1.
>
> The function "nodemask_set" defined in "/usr/include/numa.h" is same
> as the one of "numa_helpers.h".
> And the function "nodemask_dump" defined in "${LTPROOT}/testcases/kernel
> /syscalls/utils/numa_helpers" is same as the one of "numa_helpers.h".
>
> Why are the same definitions necessary in "numa_helpers.h" on purpose?
>
>
> I'm glad if I get your help.

    Try now please.
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
