From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 17 May 2019 07:19:34 -0400
Subject: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
In-Reply-To: <20190517065116.GA8170@dell5510>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <20190517065116.GA8170@dell5510>
Message-ID: <1558091974.4507.60.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Fri, 2019-05-17 at 08:51 +0200, Petr Vorel wrote:

> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b=
/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > index 0ffc3c02247d..ebe4b4c360e4 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > @@ -88,6 +88,14 @@ test2()
> >  	tst_res TINFO "verify PCR values"
> >  	tst_check_cmds evmctl
>=20
> > +	local tpm_description=3D"/sys/class/tpm/tpm0/device/description"
> > +	if [ -f "$tpm_description" ]; then
> > +		if grep -q "^\TPM 2.0" $tpm_description; then

> I guess the backslash in "^\TPM 2.0" is a typo.
> If yes, no need to repost, I'll fix it when applying your patch.
> + I'd prefer join 2 ifs into single one, but that's just matter of prefer=
ence,
> not important.

Thank you for fixing it. =C2=A0I'd just like to hear from others first, if
this is correct way to differentiate between TPM 1.2 and TPM 2.0.

Mimi


> > +			tst_res TCONF "TPM 2.0 enabled, but not supported"
> > +			return 0
> > +		fi
> > +	fi
> > +
> >  	tst_res TINFO "evmctl version: $(evmctl --version)"
>=20
> >  	local pcrs_path=3D"/sys/class/tpm/tpm0/device/pcrs"
>=20

