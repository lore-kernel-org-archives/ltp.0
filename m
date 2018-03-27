From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 15:44:15 -0400
Subject: [LTP] [RFC PATCH v2 3/4] ima/ima_boot_aggregate: Increase
 MAX_EVENT_SIZE to 8k
In-Reply-To: <20180314155731.5943-4-pvorel@suse.cz>
References: <20180314155731.5943-1-pvorel@suse.cz>
 <20180314155731.5943-4-pvorel@suse.cz>
Message-ID: <1522179855.3541.191.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

[Cc'ing George Wilson]

On Wed, 2018-03-14 at 16:57 +0100, Petr Vorel wrote:
> This is needed as according IMA developers there are BIOS events larger
> than 4k [1]. Actual size for TPM 1.2 is undefined, TPM 2.0 specifies:
> "For software parsing the event log, the parser can choose an arbitrary
> maximum size, but this specification recommends a maximum value for the
> TCG_PCR_EVENT2.eventSize field of 1MB." [2].
>=20
> So hope 8k is enough.

Is there a way of making this value system dependent? =C2=A0On my=20
laptop this is fine, but for PowerVM w/TPM 1.2 I've been told this is
too small.

> [1] http://lists.linux.it/pipermail/ltp/2018-January/006970.html
> [2] http://lists.linux.it/pipermail/ltp/2018-January/007002.html
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Acked-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

> ---
>  testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggrega=
te.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> index f7ae77cb1..c52cea4c9 100644
> --- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> +++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> @@ -30,7 +30,7 @@ char *TCID =3D "ima_boot_aggregate";
>  #if HAVE_LIBCRYPTO
>  #include <openssl/sha.h>
>=20
> -#define MAX_EVENT_SIZE 500
> +#define MAX_EVENT_SIZE 8192
>  #define EVENT_HEADER_SIZE 32
>  #define MAX_EVENT_DATA_SIZE (MAX_EVENT_SIZE - EVENT_HEADER_SIZE)
>  #define NUM_PCRS 8		/*  PCR registers 0-7 in boot aggregate */

