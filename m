Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UsRLb-0007r7-LE
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 05:35:51 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UsRLa-0007pV-NP
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 05:35:51 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 28 Jun 2013 01:35:44 -0400
References: <1372345762-5425-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1372345762-5425-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Message-Id: <201306280135.45066.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v4] lib: tst_module: add library functions for
	kernel modules
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1048327308137966658=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>, vasily.isaenko@oracle.com

--===============1048327308137966658==
Content-Type: multipart/signed; boundary="nextPart2906857.sBenF25nM3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2906857.sBenF25nM3
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Thursday 27 June 2013 11:09:22 Alexey Kodanev wrote:
\> +void tst_module_load(void (cleanup_fn)(void),
> +	const char *mod_name, char *const argv[])
> +{
> +	char *mod_path = NULL;
> +	tst_module_exists(cleanup_fn, mod_name, &mod_path);
> +
> +	static int offset = 2; /* command name & module path */

why static ?  i would use const instead.
-mike

--nextPart2906857.sBenF25nM3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRzSCxAAoJEEFjO5/oN/WBjckQAJaJzhCX2hICdbfNLm2JTyWP
yBxRkqeACiYi19fto117f1612DNnO/JmSFR4ZRx0ezxUysCM7D7y8srKIXHD+KVb
DtvpxiKGuhY6nFEthlDUowBT8LIrklQy+NJ4lMAEavGYL/8hDMAsS/mDWsGFuS3+
92o+ENOZzzl9bcj8M+7vs2kkdoU5/AL3NCgMJcGWjSbcEL8him0SfcwJgcOUb1JN
L79sWh/YZJ3eEzO8CFIWASxKEahATme4QHd04R9AYTdAVc61ht39JsYs3I2b+vz/
ASTZlrZpMzrRYuZ8SbAqqgxdbagQE02GHOnmIjXq/2ar55GWeg94WP/sUyIdIoLu
BF7dgJrll+EpNchvGsnUr6ak6zHSTPDMj12OfdCyWLpdLsOIorZAW42ans0qI8+W
pND0p6EliHzv4Pdb5fynQF10VEwZdlLOt9pPiAr4/xy6QJkkvKbfFD2Dv8x7Thxc
4haUcOstji6nu2Msd3Wkp34TuGyAz4eia/UXLcNSQ71n184EImLu4nFw8IitTl8S
SeTn/fJlUhiWxb/vPt9PxmzxbQyfukPkjyMBF5ve4s2PWYMrXuEOXUXoOMxrC4QF
OjE/xx50aR06L6hWPeFLoHfB6r0we1X4g/H1/nJmYPaVsQiG6cxXkctaktExKMDQ
FntOppVrLPLiNyaSnCnO
=FJZf
-----END PGP SIGNATURE-----

--nextPart2906857.sBenF25nM3--


--===============1048327308137966658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============1048327308137966658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1048327308137966658==--

