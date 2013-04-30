Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UXEIX-0002YD-Ri
	for ltp-list@lists.sourceforge.net; Tue, 30 Apr 2013 17:25:01 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UXEIW-0000pd-In
	for ltp-list@lists.sourceforge.net; Tue, 30 Apr 2013 17:25:01 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 30 Apr 2013 13:24:49 -0400
References: <1367303231-7061-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1367303231-7061-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Message-Id: <201304301324.51174.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] New core test of hardlinks and symlinks
	restrictions added in Linux 3.6. Disabled by default in Linux 3.7.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0818070981103632117=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>, vasily.isaenko@oracle.com

--===============0818070981103632117==
Content-Type: multipart/signed; boundary="nextPart1962897.2T0BSnnUsS";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1962897.2T0BSnnUsS
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 30 April 2013 02:27:11 Alexey Kodanev wrote:
> +/* LTP includes */
> +#include <test.h>
> +#include <safe_macros.h>
> +#include <usctest.h>

use "" for LTP includes

> +struct cleanup_list* clean_list_head;

the * should be:
	struct cleanup_list *clean_list_head;

this style error comes up a lot in this patch.  please fix them all.

> +void cleanup_add( void (*cleanup_fun)(void) )

it should be:
void cleanup_add(void (*cleanup_fun)(void))

that said, this seems like overkill.  why not declare a few vars and have y=
our=20
cleanup func process things based on that ?  it avoids the ugliness of jump=
ing=20
around between random funcs.

> +	if(clean_list_head=3D=3DNULL) {

you need more spaces:
	if (clean_list_head =3D=3D NULL) {

this error comes up a lot.  please fix globally.

> +		clean_list_head =3D (struct cleanup_list*)SAFE_MALLOC(NULL,
> +					sizeof(struct cleanup_list));

SAFE_MALLOC returns void*.  there's no need to cast it.  please fix globall=
y.

> +	if(!first_call) return;

it should be:
	if (!first_call)
		return;

please fix globally.

> +	if(_root_cleanup) {
> +		SAFE_SETEGID(NULL,0);
> +		SAFE_SETEUID(NULL,0);

more spacing issues:
	if (_root_cleanup) {
		SAFE_SETEGID(NULL, 0);
		SAFE_SETEUID(NULL, 0);

i'm giving up now.  seems like every line in your patch is broken.  please=
=20
clean it all up and resubmit.
=2Dmike

--nextPart1962897.2T0BSnnUsS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRf/5iAAoJEEFjO5/oN/WBwnQQAJuo4xG0xkmSfqhhNzxQK4/q
P7IxjwVlQHycW8gxBZRWxRAldZJjnn2JR9XEZ4R1OW+d0VBu1Texk3hr6G1cPc0F
MHvZRl+FDjLh0CmwXnkoDJctuKmp8lMut2GbZQtePAi4A6YGDGmnPZUN26ytjnV1
ePbMGN/M+Fbope05mjcaRqbZ04qPWPfh9yPv8nmwVT2PweVBzw8uYvny4j1yWxfP
52esbc4r4LSgKWjhRUtE9iBPPtbT227Gn6wt5g595O+4TInief6rD4P/J80te0fr
NYqIzVTLl/ekipapKnIW71L61z1oSSyoONVn2wGQ89piP8iMZ9GetAK4esMFGAwO
qJpYypOFmkcE3X6kGJKRst2pfcjvPYTGclRfTkPz2119KdkKQSBxCpf1Rf1LLbuC
2j5jYOHUYoTzz/5cwOx75KSdtUAG9AUbLT8WFrayDgl0M626D8EpMml4TIqjUI+1
lgcuRwPtrZLDKRlYzY4WH9GDzT2IUKaXIbZJYueBWQ4LdmXC8fAjvFimIQfRJ6W6
Ttt26OUczZ4MWjPr7Cpqx7yQbQiVsAwdCpc/4kqY4emvO6NwlEZf6gL47yogfZS2
IUR0tyhO8DMepdjFqGEAksz2qxYzkrxpErbsqh7mLhAp2TBzZXnrllE+Ex4RxmQH
NQaMjkJvQFH/n0VAXCPI
=JJbA
-----END PGP SIGNATURE-----

--nextPart1962897.2T0BSnnUsS--


--===============0818070981103632117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
--===============0818070981103632117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0818070981103632117==--

