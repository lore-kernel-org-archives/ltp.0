From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Apr 2018 11:32:50 +0200
Subject: [LTP] [RFC PATCH v3 00/10] Rewrite tests into new API + fixes
In-Reply-To: <1524759504.3647.12.camel@linux.vnet.ibm.com>
References: <20180419195503.7194-1-pvorel@suse.cz>
 <1524759504.3647.12.camel@linux.vnet.ibm.com>
Message-ID: <20180427093250.h5myocnvwgrfij34@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi,

> > * ima_measurements.sh
> >   - don't require iversion for kernel >=3D 4.16
> >   - avoid using tmpfs

> This is working nicely!
:).


...
> test: cmdline=3D"ima_policy.sh"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> ima_policy 1 TINFO: verify that invalid policy isn't loaded
> ima_policy 1 TPASS: didn't load invalid policy
> ima_policy 2 TINFO: verify that policy file is not opened concurrently
> and able to loaded multiple times
> ima_policy 2 TFAIL: problem with loading policy (policy should be able
> to load multiple times)

> For now, could we change "problem with loading policy (policy should
> be able to load multiple times)" to say, "problem loading or extending
> policy (may require policy to be signed)"?
Sure, thanks!


> I'm also seeing,=C2=A0

> test: ima_tpm
> <<<test_output>>>
> ima_tpm 1 TINFO: verify boot aggregate
> ima_tpm 1 TPASS: bios aggregate matches IMA boot aggregate
> ima_tpm 2 TINFO: verify PCR values
> ima_tpm 2 TINFO: evmctl version: evmctl 1.0
> ima_tpm 2 TINFO: new PCRS path, evmctl >=3D 1.1 required
> ima_tpm 2 TINFO: verify PCR (Process Control Register)
> ima_tpm 2 TFAIL: failed to get PCR-10
> ima_tpm 2 TPASS: aggregate PCR value matches real PCR value

> It's unclear how the script could fail to get PCR-10, but pass the
> following test.
Thanks, fixed (wrong return).

> Mimi


Kind regards,
Petr
