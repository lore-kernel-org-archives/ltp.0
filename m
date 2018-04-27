From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Fri, 27 Apr 2018 11:39:38 +0200
Subject: [LTP] [RFC PATCH 8/9] testcases: test.sh: Check if "getconf" is
 available
In-Reply-To: <20180423101753.GD24481@rei>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
 <20180423094639.14612-9-mylene.josserand@bootlin.com>
 <20180423101753.GD24481@rei>
Message-ID: <20180427113938.6cea92ab@dell-desktop.home>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hello,

On Mon, 23 Apr 2018 12:17:53 +0200
Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > In case TST_NEEDS_CHECKPOINTS is set to 1, the "getconf"
> > binary is used. This binary may not be installed in the system
> > and it will return a FAIL. Instead, add a check on this binary
> > to return "TCONF" in that case.
> >=20
> > Signed-off-by: Myl??ne Josserand <mylene.josserand@bootlin.com>
> > ---
> >  testcases/lib/test.sh | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
> > index bce9893a9..b27dbf4ab 100644
> > --- a/testcases/lib/test.sh
> > +++ b/testcases/lib/test.sh
> > @@ -421,6 +421,8 @@ fi
> >  if [ "$TST_NEEDS_CHECKPOINTS" =3D "1" ]; then
> >  	LTP_IPC_PATH=3D"/dev/shm/ltp_${TCID}_$$"
> > =20
> > +	tst_check_cmds "getconf"
> > +
> >  	LTP_IPC_SIZE=3D$(getconf PAGESIZE)
> >  	if [ $? -ne 0 ]; then
> >  		tst_brkm TBROK "getconf PAGESIZE failed" =20
>=20
> This would be better fixed by creating a binary helper in testcases/lib/
> same as we did for example for sub-second sleep with tst_sleep.c. We can
> create tst_pagesize.c that would just print the result of getpagesize().
>=20

Okay, thank you for the hint. I will have a look.

Best regards,

--=20
Myl=C3=A8ne Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
