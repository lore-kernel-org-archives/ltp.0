From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Fri, 27 Apr 2018 11:38:30 +0200
Subject: [LTP] [RFC PATCH 7/9] testcases: df: Add "--printf" option as
 needed commands
In-Reply-To: <20180423132727.3ne2d2xvmj4lwinn@dell5510>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
 <20180423094639.14612-8-mylene.josserand@bootlin.com>
 <20180423102237.GF24481@rei>
 <20180423132727.3ne2d2xvmj4lwinn@dell5510>
Message-ID: <20180427113830.4c021080@dell-desktop.home>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi,

On Mon, 23 Apr 2018 15:27:27 +0200
Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>=20
> > > diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df=
01.sh
> > > index fbf1e2f2a..147620020 100755
> > > --- a/testcases/commands/df/df01.sh
> > > +++ b/testcases/commands/df/df01.sh
> > > @@ -26,6 +26,8 @@ TST_PARSE_ARGS=3Dparse_args
> > >  TST_NEEDS_ROOT=3D1
> > >  TST_NEEDS_TMPDIR=3D1
> > >  TST_NEEDS_DEVICE=3D1
> > > +TST_NEEDS_CMDS=3D"stat --printf=3D%f" =20
>=20
> > Does this work? Because when I do something as: =20
>=20
> > $ command -v stat --nonexistent-option
> > /usr/bin/stat
> > $ echo $?
> > 0 =20
>=20
> Checking whole output (not just binary file / script) presence in $PATH i=
s what
> tst_verify_cmd in my patch [1] does.
>=20
> [1] https://patchwork.ozlabs.org/patch/892779/
>=20
>=20
> Kind regards,
> Petr

Indeed, I saw your patch just after I sent my series :)

I will test your "tst_verify_cmd" but it seems to fit my needs. I will
keep you updated.

Best regards,

--=20
Myl=C3=A8ne Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
