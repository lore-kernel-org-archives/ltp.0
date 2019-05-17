From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 May 2019 13:28:48 +0200
Subject: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
In-Reply-To: <1558091974.4507.60.camel@linux.ibm.com>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <20190517065116.GA8170@dell5510>
 <1558091974.4507.60.camel@linux.ibm.com>
Message-ID: <20190517112848.GA27606@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Mimi,

> On Fri, 2019-05-17 at 08:51 +0200, Petr Vorel wrote:

> > > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh=
 b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > > index 0ffc3c02247d..ebe4b4c360e4 100755
> > > --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > > @@ -88,6 +88,14 @@ test2()
> > >  	tst_res TINFO "verify PCR values"
> > >  	tst_check_cmds evmctl

> > > +	local tpm_description=3D"/sys/class/tpm/tpm0/device/description"
> > > +	if [ -f "$tpm_description" ]; then
> > > +		if grep -q "^\TPM 2.0" $tpm_description; then

> > I guess the backslash in "^\TPM 2.0" is a typo.
> > If yes, no need to repost, I'll fix it when applying your patch.
> > + I'd prefer join 2 ifs into single one, but that's just matter of pref=
erence,
> > not important.

> Thank you for fixing it. =C2=A0I'd just like to hear from others first, if
> this is correct way to differentiate between TPM 1.2 and TPM 2.0.
Oh, yes, let's wait for a feedback.

> Mimi

Kind regards,
Petr
