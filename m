Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802C4C4321E
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 12:15:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F0753CC3F0
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 13:15:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B94B53CC3C4
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 13:15:18 +0100 (CET)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B53A11BFADBF
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 13:15:17 +0100 (CET)
Received: from gallifrey.ext.pengutronix.de
 ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mkl@pengutronix.de>)
 id 1p14we-0008Hv-0H; Fri, 02 Dec 2022 13:15:08 +0100
Received: from pengutronix.de (unknown
 [IPv6:2a03:f580:87bc:d400:63a6:d4c5:22e2:f72a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (Client did not present a certificate)
 (Authenticated sender: mkl-all@blackshift.org)
 by smtp.blackshift.org (Postfix) with ESMTPSA id 1C95A13156D;
 Fri,  2 Dec 2022 12:15:04 +0000 (UTC)
Date: Fri, 2 Dec 2022 13:14:58 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Max Staudt <max@enpas.org>
Message-ID: <20221202121458.qeqjzewvdbnqhvnt@pengutronix.de>
References: <20221201073426.17328-1-jirislaby@kernel.org>
 <20221202035242.155d54f4.max@enpas.org>
MIME-Version: 1.0
In-Reply-To: <20221202035242.155d54f4.max@enpas.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] can: slcan: fix freed work crash
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
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Petr Vorel <petr.vorel@suse.com>,
 Eric Dumazet <edumazet@google.com>, ltp@lists.linux.it,
 linux-serial@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 dario.binacchi@amarulasolutions.com,
 "Jiri Slaby \(SUSE\)" <jirislaby@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Richard Palethorpe <richard.palethorpe@suse.com>
Content-Type: multipart/mixed; boundary="===============0105696188=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


--===============0105696188==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x4q6zeagiapw3mdj"
Content-Disposition: inline


--x4q6zeagiapw3mdj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.12.2022 03:52:42, Max Staudt wrote:
> (CC: ltp@lists.linux.it because Petr did so.)
>=20
> Hi Jiry,
>=20
> Thanks for finding this!
>=20
>=20
> Your patch looks correct to me, so please have a
>=20
>   Reviewed-by: Max Staudt <max@enpas.org>
>=20
> for both this patch to slcan, as well as an 1:1 patch to can327.

Max, can you create a patch for the can327 driver?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--x4q6zeagiapw3mdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmOJ7D8ACgkQrX5LkNig
013NnAf/Z62/13CIDQ7V894/ROU5ZGk6S6LRPGG/p7Q4oFGe7BxjDOn4Izk+wTGX
kisclotCPB1hsAfPi988cEjHEe2b6CXib1aZmtJOyGC8cuTgRvBimHElXGgDIUJe
NYsq2C+WZsGSQqHX6eSClICQZ0DrIsyidSrhZ3gsl0KKGxxLEV1oKhlYjLhM7Hx2
Ntd/uU3oFiOAIoRtDXORfGf1kleLK/XTvJMv1gg+NkTuYYh01HKXK7d42bthX1tP
X0a28lItgg4SyQMXm6tX3KJ8AMsbpMKHPhIjXSB/Fild1XdAvnhxnNuZYg4w1oPI
/Ib6xzyF13qn8t2HKAY0C8C3YfnTzw==
=EslA
-----END PGP SIGNATURE-----

--x4q6zeagiapw3mdj--

--===============0105696188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0105696188==--
