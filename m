Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99A4C433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 09:32:14 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C1360F25
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 09:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95C1360F25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sk2.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06C173C298B
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 11:32:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A5043C232F
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 08:14:20 +0200 (CEST)
Received: from 3.mo2.mail-out.ovh.net (3.mo2.mail-out.ovh.net [46.105.58.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2D5351400E4D
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 08:14:19 +0200 (CEST)
Received: from player731.ha.ovh.net (unknown [10.110.103.41])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 968A92188A4
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 08:14:18 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
 (Authenticated sender: steve@sk2.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 8B93821A2036F;
 Tue,  7 Sep 2021 06:14:11 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0055491dc6b-1c52-4a03-9c95-cf5072f85d4e,
 3BE1ACDBE7A9C53D6FB7E95B31E2C4A7EDB942B8) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date: Tue, 7 Sep 2021 08:14:03 +0200
From: Stephen Kitt <steve@sk2.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20210907081403.4f4aa916@heffalump.sk2.org>
In-Reply-To: <20210903110920.28178-1-pvorel@suse.cz>
References: <20210903110920.28178-1-pvorel@suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Ovh-Tracer-Id: 232498334417716870
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudefgedguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhephfeuhedtheekudehffehjeelhefhfeejfeffgeduudejgeetgeeffeegueeukefhnecuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgpdhsthgrtghkvgigtghhrghnghgvrdgtohhmnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlthhpsehlihhsthhsrdhlihhnuhigrdhith
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 07 Sep 2021 11:31:53 +0200
Subject: Re: [LTP] [PATCH 1/1] tst_test.sh: Use command -v instead of type
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Adam Katz <khopesh@apache.org>, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0865126813=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210907061403.29NAZED6qUv7jUvE2EWjB53Utp-Y5xnuwAeDeafHNTg@z>

--===============0865126813==
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/FJBpvylPZikvGvDl3PQp80i"; protocol="application/pgp-signature"

--Sig_/FJBpvylPZikvGvDl3PQp80i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri,  3 Sep 2021 13:09:20 +0200, Petr Vorel <pvorel@suse.cz> wrote:
> to avoid checkbashisms warnings.
>=20
> `type' is part of POSIX, but as part of the X/Open Systems Interfaces
> option (XSI) [1]. As Stephen Kitt noted [2] quoting man checkbashisms(1):
>=20
>     Note that the definition of a bashism in this context roughly
>     equates to "a shell feature that is not required to be supported
>     by POSIX"; this means that some issues flagged may be permitted
>     under optional sections of POSIX, such as XSI or User Portability.
>=20
> =3D> `type' is flagged because it is an optional feature. =20
>=20
> `command -v' is POSIX (no XSI extension) [3] and we already started to
> using it instead of which (e7302676f, f6cac3660).
>=20
> [1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/type.html
> [2] https://unix.stackexchange.com/a/667293
> [3] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.ht=
ml
>=20
> Cc: Stephen Kitt <steve@sk2.org>
> Suggested-by: Adam Katz <khopesh@apache.org>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Stephen Kitt <steve@sk2.org>

Thanks!

--Sig_/FJBpvylPZikvGvDl3PQp80i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmE3AysACgkQgNMC9Yht
g5zAjw//ex+JoJ29QkMSzDTRIE1Im/YCjEJbNHta0uNbiqF8IYzWB7qzayRoJO/t
2nolFpVzmWFyi0+aEo8t23NxipklYPsV3OrKY+gP8vY1uXHGwRnzEStQFrlTy+Ua
y7mqlnZjVF/ExHAwCcV1fgRNLysNSI6zltVISp90a2fA71JF/fzQ8y4IDxTcfUz5
lxYvqEu/AvldPjJWH4uvsi+teADjcMwA6gOFSsT6+9TCeZaY4CUFGlbtgNEX/S82
854VgX20p8mnBzY9YrovjbNek+o/y8VCE88thLIeCrq8w3gr5t607EhiN1dFp0EB
iC2JGh9THc/2UZ3VFSLOjuUk0y/O2ozrr3UqUILd4tAInHtj9NytfBT/K7Ra2eTZ
BtJoCG5JshFvyzRsjHSh+Rt03ZIIsjIUiqx3E6YCkfX/RXA0r2clnAa7icyaDHYl
HrbpMbRqgqC9AkqaDqcQSWmN/KhdwnhAH9oCO5PIBgxba/vMHyEmFU30GX5kFhAD
0aCCCNt0eNu6X6DTbeIzEaN5JoWlA6lIF6o6ZBDXrurdZz5LjPJLLejPFsMG993l
oyGcEEbEHgNjfCFvQ4hKGTTDLzbs8ZsMJJ4DYe9zLB8KEYr+yrO5JzSFdnKHM+k+
3TkDwIQBynRTxNNi3BjNXLcTibL++Cm1VevOzNj4o8yeyEjH9Mg=
=du2f
-----END PGP SIGNATURE-----

--Sig_/FJBpvylPZikvGvDl3PQp80i--

--===============0865126813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0865126813==--
