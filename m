From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 26 Apr 2018 12:18:24 -0400
Subject: [LTP] [RFC PATCH v3 00/10] Rewrite tests into new API + fixes
In-Reply-To: <20180419195503.7194-1-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
Message-ID: <1524759504.3647.12.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Thu, 2018-04-19 at 21:54 +0200, Petr Vorel wrote:
> Hi,
>=20
> changes v2->v3:
> * Fixed some of errors caused by test order.
>=20
> * ima_boot_aggregate
>   - max event size is now 1MB according to spec
>=20
> * ima_mmap
>   - reduce sleep + log it
>   - rewritten into new API
>=20
> * ima_measurements.sh
>   - don't require iversion for kernel >=3D 4.16
>   - avoid using tmpfs

This is working nicely!

>=20
> * ima_policy.sh
>   - improved detection of policy writability
>   - merge test2 and test3
>=20
> * ima_violations.sh
>   - avoid using tmpfs
>   - improved grepping logs (no sleep is needed)
>=20
> * ima_tpm.sh
>   - Improve error messages
>=20
> TODO:
> * fix problems with violations tests (see patch 02/10).
> * detect whether policy must be signed (currently tests assume the
> policy does not need to be signed):
> https://lists.linux.it/pipermail/ltp/2018-April/007702.html
> http://lists.linux.it/pipermail/ltp/2018-January/006970.html


test: cmdline=3D"ima_policy.sh"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
ima_policy 1 TINFO: verify that invalid policy isn't loaded
ima_policy 1 TPASS: didn't load invalid policy
ima_policy 2 TINFO: verify that policy file is not opened concurrently
and able to loaded multiple times
ima_policy 2 TFAIL: problem with loading policy (policy should be able
to load multiple times)

For now, could we change "problem with loading policy (policy should
be able to load multiple times)" to say, "problem loading or extending
policy (may require policy to be signed)"?

I'm also seeing,=C2=A0

test: ima_tpm
<<<test_output>>>
ima_tpm 1 TINFO: verify boot aggregate
ima_tpm 1 TPASS: bios aggregate matches IMA boot aggregate
ima_tpm 2 TINFO: verify PCR values
ima_tpm 2 TINFO: evmctl version: evmctl 1.0
ima_tpm 2 TINFO: new PCRS path, evmctl >=3D 1.1 required
ima_tpm 2 TINFO: verify PCR (Process Control Register)
ima_tpm 2 TFAIL: failed to get PCR-10
ima_tpm 2 TPASS: aggregate PCR value matches real PCR value

It's unclear how the script could fail to get PCR-10, but pass the
following test.

Mimi

