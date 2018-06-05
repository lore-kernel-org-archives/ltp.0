From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 05 Jun 2018 09:43:16 -0400
Subject: [LTP] [PATCH 1/1] ima/ima_measurements.sh: Improve digest and
 algorithm detection
In-Reply-To: <20180430173317.14310-1-pvorel@suse.cz>
References: <20180430173317.14310-1-pvorel@suse.cz>
Message-ID: <1528206196.3237.142.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Petr,

On Mon, 2018-04-30 at 19:33 +0200, Petr Vorel wrote:
> Previous detection didn't work for 'ima-sig' template descriptor in case
> where measurement line contained signature (worked for record without
> signature). Problem was caused by using index from the end of the
> record [1]:
> Sample ima-sig template measurements with/without the signature:
> line=3D"10 ee788468d1b416a394feb9f4e5650302d9cd5574 ima-sig sha256:866c25=
42efd5c7528591eb3bb2861a1994a655da47732ccf28f7f4b1ce42d564 /usr/lib64/libpa=
m.so.0.84.1"
>=20
> line=3D"10 d3afb4df5fe42485b99677f4b68a04692977b4bc ima-sig sha256:7b8550=
8c9181670fe169935310b8c95d7c2573f0318a70cecd12868569aab891 /etc/profile.d/l=
ess.sh 0302046e6c104601008bd533707b34a9e896d3d530a88e9af517fb7e8cf79e9e5506=
4a577fcbcdb81236ede6fec0638d357e4c2ed9b261320f8789378d1e58af8e1c6f40ebdf080=
759be2c633b27bc8aed85af0620fa27700c68fdf31d33b2f9e36432a1e7d7eb8dbf20b9474d=
332deb9697767ee13e13c116544a843b54fce842d24ea485bb41f6f7b1e9fa3faed0c591f52=
43cee008b9499e48064141662d3c4d002b07448ae54dc8d8674437143d73c4e34f5b416300b=
a890dc391eae9e5b1e89190790d0ea77d1dc57e07dae9ca003294a36fda09c31f8afa347701=
bfcf5aed0fda9cf7a37f734ba80fc10f2d60409f0beba532f3e5cc15ae995128e466b20fdad=
ef789e285519"
>=20
> Detection also fails when used non-standard order of template fields
> configured via ima_template_fmt kernel parameter.
>=20
> Don't assume sha1 as default algorithm for old IMA format ('ima'
> template descriptor) and determine it from digest length (these can be
> only md5 or sha1 [2]).
>=20
> Other minor changes
> * rename variables:
>   s/digest/algorithm/
>   s/hash/digest/
> * introduce cut dependency (ima-sig template with no signature use empty
>   space instead of it)
> * code cleanup
>=20
> [1] https://lists.linux.it/pipermail/ltp/2018-April/007930.html
> [2] https://www.kernel.org/doc/html/latest/security/IMA-templates.html#use
>=20

Sorry for the long delay. =C2=A0The patch looks good!

thanks,

Mimi

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Reported-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  .../integrity/ima/tests/ima_measurements.sh        | 108 +++++++++++++++=
+-----
>  1 file changed, 83 insertions(+), 25 deletions(-)
>=20
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measuremen=
ts.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> index 88eabd2a3..80fbf627a 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> @@ -19,7 +19,7 @@
>  #
>  # Verify that measurements are added to the measurement list based on po=
licy.
>=20
> -TST_NEEDS_CMDS=3D"awk"
> +TST_NEEDS_CMDS=3D"awk cut"
>  TST_SETUP=3D"setup"
>  TST_CNT=3D3
>  TST_NEEDS_DEVICE=3D1
> @@ -28,64 +28,122 @@ TST_NEEDS_DEVICE=3D1
>=20
>  setup()
>  {
> -	DEFAULT_DIGEST_OLD_FORMAT=3D"sha1"
>  	TEST_FILE=3D"$PWD/test.txt"
>=20
>  	POLICY=3D"$IMA_DIR/policy"
>  	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
>=20
>  	DIGEST_INDEX=3D
> -	grep -q "ima-ng" $ASCII_MEASUREMENTS && DIGEST_INDEX=3D1
> -	grep -q "ima-sig" $ASCII_MEASUREMENTS && DIGEST_INDEX=3D2
> +
> +	local template=3D"$(tail -1 $ASCII_MEASUREMENTS | cut -d' ' -f 3)"
> +	local i
> +
> +	# https://www.kernel.org/doc/html/latest/security/IMA-templates.html#use
> +	case "$template" in
> +	ima|ima-ng|ima-sig) DIGEST_INDEX=3D4 ;;
> +	*)
> +		# using ima_template_fmt kernel parameter
> +		local IFS=3D"|"
> +		i=3D4
> +		for word in $template; do
> +			if [ "$word" =3D 'd' -o "$word" =3D 'd-ng' ]; then
> +				DIGEST_INDEX=3D$i
> +				break
> +			fi
> +			i=3D$((i+1))
> +		done
> +	esac
> +
> +	[ -z "$DIGEST_INDEX" ] && tst_brk TCONF \
> +		"Cannot find digest index (template: '$template')"
>=20
>  	tst_res TINFO "IMA measurement tests assume tcb policy to be loaded (im=
a_policy=3Dtbc)"
>  }
>=20
>  # TODO: find support for rmd128 rmd256 rmd320 wp256 wp384 tgr128 tgr160
> -compute_hash()
> +compute_digest()
>  {
> -	local digest=3D"$1"
> +	local algorithm=3D"$1"
>  	local file=3D"$2"
> +	local digest
>=20
> -	hash=3D"$(${digest}sum $file 2>/dev/null | cut -f1 -d ' ')"
> -	[ -n "$hash" ] && { echo $hash; return; }
> +	digest=3D"$(${algorithm}sum $file 2>/dev/null | cut -f1 -d ' ')"
> +	if [ -n "$digest" ]; then
> +		echo "$digest"
> +		return 0
> +	fi
>=20
> -	hash=3D"$(openssl $digest $file 2>/dev/null | cut -f2 -d ' ')"
> -	[ -n "$hash" ] && { echo $hash; return; }
> +	digest=3D"$(openssl $algorithm $file 2>/dev/null | cut -f2 -d ' ')"
> +	if [ -n "$digest" ]; then
> +		echo "$digest"
> +		return 0
> +	fi
>=20
>  	# uncommon ciphers
> -	local arg=3D"$digest"
> -	case "$digest" in
> +	local arg=3D"$algorithm"
> +	case "$algorithm" in
>  	tgr192) arg=3D"tiger" ;;
>  	wp512) arg=3D"whirlpool" ;;
>  	esac
>=20
> -	hash=3D"$(rhash --$arg $file 2>/dev/null | cut -f1 -d ' ')"
> -	[ -n "$hash" ] && { echo $hash; return; }
> +	digest=3D"$(rdigest --$arg $file 2>/dev/null | cut -f1 -d ' ')"
> +	if [ -n "$digest" ]; then
> +		echo "$digest"
> +		return 0
> +	fi
> +	return 1
>  }
>=20
>  ima_check()
>  {
> -	local digest=3D"$DEFAULT_DIGEST_OLD_FORMAT"
> -	local hash expected_hash line
> +	local delimiter=3D':'
> +	local algorithm digest expected_digest line
>=20
>  	# need to read file to get updated $ASCII_MEASUREMENTS
>  	cat $TEST_FILE > /dev/null
>=20
>  	line=3D"$(grep $TEST_FILE $ASCII_MEASUREMENTS | tail -1)"
> -	[ -n "$line" ] || tst_res TFAIL "cannot find measurement for '$TEST_FIL=
E'"
> +	if [ -z "$line" ]; then
> +		tst_res TBROK "cannot find measurement record for '$TEST_FILE'"
> +		return
> +	fi
> +	tst_res TINFO "measurement record: '$line'"
>=20
> -	[ "$DIGEST_INDEX" ] && digest=3D"$(echo "$line" | awk '{print $(NF-'$DI=
GEST_INDEX')}' | cut -d ':' -f 1)"
> -	hash=3D"$(echo "$line" | awk '{print $(NF-1)}' | cut -d ':' -f 2)"
> +	digest=3D$(echo "$line" | cut -d' ' -f $DIGEST_INDEX)
> +	if [ -z "$digest" ]; then
> +		tst_res TBROK "cannot find digest (index: $DIGEST_INDEX)"
> +		return
> +	fi
> +
> +	if [ "${digest#*$delimiter}" !=3D "$digest" ]; then
> +		algorithm=3D$(echo "$digest" | cut -d $delimiter -f 1)
> +		digest=3D$(echo "$digest" | cut -d $delimiter -f 2)
> +	else
> +		case "${#digest}" in
> +		32) algorithm=3D"md5" ;;
> +		40) algorithm=3D"sha1" ;;
> +		*)
> +			tst_res TBROK "algorithm must be either md5 or sha1 (digest: '$digest=
')"
> +			return ;;
> +		esac
> +	fi
> +	if [ -z "$algorithm" ]; then
> +		tst_res TBROK "cannot find algorithm"
> +		return
> +	fi
> +	if [ -z "$digest" ]; then
> +		tst_res TBROK "cannot find digest"
> +		return
> +	fi
>=20
> -	tst_res TINFO "computing hash for $digest digest"
> -	expected_hash=3D"$(compute_hash $digest $TEST_FILE)" || \
> -		{ tst_res TCONF "cannot compute hash for '$digest' digest"; return; }
> +	tst_res TINFO "computing digest for $algorithm algorithm"
> +	expected_digest=3D"$(compute_digest $algorithm $TEST_FILE)" || \
> +		tst_brk TCONF "cannot compute digest for $algorithm algorithm"
>=20
> -	if [ "$hash" =3D "$expected_hash" ]; then
> -		tst_res TPASS "correct hash found"
> +	if [ "$digest" =3D "$expected_digest" ]; then
> +		tst_res TPASS "correct digest found"
>  	else
> -		tst_res TFAIL "hash not found"
> +		tst_res TFAIL "digest not found"
>  	fi
>  }
>=20

