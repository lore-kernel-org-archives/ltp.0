Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O9X1X-0003x4-UF
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 05:19:55 +0000
Received: from mail-iw0-f175.google.com ([209.85.223.175])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O9X1X-0005Y9-3X
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 05:19:55 +0000
MIME-Version: 1.0
In-Reply-To: <20100504223315.GA16615@us.ibm.com>
References: <1272997208.5342.7.camel@subratamodak.linux.ibm.com>
	<20100504192248.GA3696@us.ibm.com>
	<y2l364299f41005041402uce37fd2axc6f1fc7f7df70497@mail.gmail.com>
	<20100504223315.GA16615@us.ibm.com>
Date: Tue, 4 May 2010 22:19:49 -0700
Message-ID: <j2u364299f41005042219vfa5c5aa7ld5673a7eba8b6c64@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix FILECAPS test hanging for more than 12 hours
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Tue, May 4, 2010 at 3:33 PM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Quoting Garrett Cooper (yanegomi@gmail.com):
>> On Tue, May 4, 2010 at 12:22 PM, Serge E. Hallyn <serue@us.ibm.com> wrot=
e:
>> > Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
>> >> Serge, please add a Sign-off.
>> >
>> > It's there in the patch in your attachment...
>>
>> Serge,
>> =A0 =A0 Please address the items in the previous review and we'll get it=
 committed.
>> Thanks,
>> -Garrett
>
> Ah, I see. =A0You only broke the testcase to get my attention so you
> could get me to use more appropriate ltp helpers. =A0Sneaky! =A0And since
> I learned some things in the process, great. =A0Hopefully I'll get them
> right when I submit the next set.

??? You're getting the glory, not me (and FWIW I haven't committed to
LTP in about a month)...

> From 2077a47e9cd2f85a8e54695c71396a1a8397d3d6 Mon Sep 17 00:00:00 2001
> From: Serge E. Hallyn <serue@us.ibm.com>
> Date: Wed, 28 Apr 2010 11:26:58 -0500
> Subject: [PATCH 1/1] make filecaps tests succeed
>
> Most of these are belated cleanup after the move to using /opt/ltp.
> But come on, replacing 'return' with tst_exit(), are you just trying
> to mess with my head?

Yeah, I admit that was stupid :(... I want trying to preserve the exit
code in the event that the call would fail *sigh*. It doesn't matter
that much now I suppose.

[...]

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p =3D index(buf, '.')+1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p=3D=3D(char *)1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "got a bad =
message from print_caps\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p=3D=3D(char *)1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TFAIL, tst_exit, "=
got a bad message from print_caps\n");

    This is a really incorrect way to do things. I think that the
assumption made was that index(3) would return 0 ('\0') if it fails to
find '.'. That's incorrect and would cause a segfault on some systems
(does on FreeBSD at least... don't see why it would pass on Linux):

$ ~/test_null_inc
Segmentation fault: 11 (core dumped)
[garrcoop@bioshock ~]$ cat ~/test_null_inc.c
#include <stdio.h>
int
main(void)
{
	printf("%s\n", (NULL + 1));
	return 0;
}

    Could you please change this to check and see whether or not index
returns NULL instead of accessing memory like that?
    Other than that, patch looks good.

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
