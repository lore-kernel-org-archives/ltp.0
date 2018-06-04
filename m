From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 4 Jun 2018 17:22:21 +0200
Subject: [LTP] [RFC PATCH 6/9] testcases: wc: Add "unrecognized option"
 as TCONF
In-Reply-To: <20180529183256.7ae8254e@dell-desktop.home>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
 <20180423094639.14612-7-mylene.josserand@bootlin.com>
 <20180516100055.5mrh74e3o74gy3lo@dell5510>
 <20180529183256.7ae8254e@dell-desktop.home>
Message-ID: <20180604152221.skptxzgn4cdz7olq@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Myl=C3=A8ne,

> > I haven't found it in busybox sources neither in busybox git log.

> Just in case, this is what I get with my busybox (v1.24.1):

> # wc --max-line-length
> wc: unrecognized option '--max-line-length'
> BusyBox v1.24.1 (2018-02-10 17:35:25 CET) multi-call binary.

> Usage: wc [-clwL] [FILE]...

> I looked very quickly and it seems to be glibc with "getopt" function
> that prints this error:
> https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dposix/getopt.c#l309

Thanks for debugging. Indeed, it really uses getopts() from libc, thus
libc dependent - busybox with musl has it with comma:
wc: unrecognized option: max-line-length

But all libraries common libc libraries (glibc, musl, uclibc-ng) has string=
 "unrecognized
option" =3D> make sense to add the patch.

Acked-by: Petr Vorel <pvorel@suse.cz>


Kind regards,
Petr
