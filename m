Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <cristian@regolo.cc>) id 1Pfur6-0005i5-PX
	for ltp-list@lists.sourceforge.net; Thu, 20 Jan 2011 13:47:16 +0000
Received: from aiolia.regolo.cc ([178.79.135.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pfur5-0003vl-Eh
	for ltp-list@lists.sourceforge.net; Thu, 20 Jan 2011 13:47:16 +0000
Date: Thu, 20 Jan 2011 14:30:28 +0100
From: Cristian Greco <cristian@regolo.cc>
Message-ID: <20110120143028.4df7ab81@regolo>
Mime-Version: 1.0
Subject: [LTP] [PATCH] Add tst_require_root to acct01 testcase.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7075708080425413448=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Cristian Greco <cristian@regolo.cc>

--===============7075708080425413448==
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/jZfS+9D33mtUW5/oRekcIEu";
	protocol="application/pgp-signature"

--Sig_/jZfS+9D33mtUW5/oRekcIEu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

[ please keep CC as I'm not currently subscribed to the list ]

please find attached a small fix to check for root privileges in
acct(2) testcase (syscalls/acct/acct01.c).

Signed-off-by: Cristian Greco <cristian@regolo.cc>
---
 testcases/kernel/syscalls/acct/acct01.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct01.c
b/testcases/kernel/syscalls/acct/acct01.c index 221a30a..dae5598 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -67,6 +67,8 @@ char *argv[];
=20
 /*--------------------------------------------------------------*/
=20
+	tst_require_root(NULL);
+
 	/* turn off acct, so we are in a known state
 	 */
 	if (acct(NULL) =3D=3D -1) {
@@ -171,4 +173,4 @@ char *argv[];
 	tst_exit();		/* THIS CALL DOES NOT RETURN -
EXITS!!
*/ /*--------------------------------------------------------------*/
tst_exit(); -}
\ No newline at end of file
+}
--=20
1.7.2.3

Thanks,
--
Cristian Greco
GPG key ID: 0xCF4D32E4

--Sig_/jZfS+9D33mtUW5/oRekcIEu
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCAAGBQJNODj0AAoJEID329zPTTLkmX8QAI9wsxB+ETCyIqCZOJmfLNU2
nWq5lbFjXQbDHnlPJEmDJV8ScF4BDbM5z/jDmeItlwTecSkLulJ6JIC5dnw7JuoJ
7iFAMrOE4FzxfxIMn98KA3v6fmMT1D8cfoiFCXfRkY8+FTj4aDckbNcnz5fnYwVn
GELZNZY32/SBRHVpUVmRXQVq2tJj5inrj5QLMevmZJZDIklx+VuxshLa7J+r+bam
hSt988P7i0mjDUSqHJM5w5VFr3Xw5UYWidN2jGTwnpDzKLovKQO7zBa5z1zWOYom
kubohJG6EjUr7i0IAN+le7Way1z5diN5IFdnulaLmMaJvXq4yXILYkBcNDpcEPNE
P+ekHvfFJ4Rg5tprsmhq0TmewtXFPilZJmK+/rGG/zgXNIGGqCzNlBNGR4Fi5WfY
RdF8cJAx14NqjJAdtKZ7dMgxGJROLNS19zAnfc52d0TJUh2ggwEO3OCiJLIT4Ncs
/2cqbcaKohE6Or5fHpdwZkmoTMs+l2VjJAGr1AzbEIZCnG9arkc3uy+LpKXqSFyc
iTJ2T8+vkf/78gIWgdJiwudQiDWOu9yDyjOPtwWmKOpDI1mZDtQYCkAW4ih90XVm
Cjdks701kQnj6iZ5ikB8I8pxhoZcjlvcKouq/CJ0HyCnRFzRqG9wVzFrI88skmQP
V3aMBbblwAOHKD2RIyIN
=HDI7
-----END PGP SIGNATURE-----

--Sig_/jZfS+9D33mtUW5/oRekcIEu--


--===============7075708080425413448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
--===============7075708080425413448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7075708080425413448==--

