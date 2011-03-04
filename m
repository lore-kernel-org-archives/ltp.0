Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <cristian@regolo.cc>) id 1PvQVu-0003TR-Vx
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 08:37:30 +0000
Received: from aiolia.regolo.cc ([178.79.135.37])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PvQVu-0002gD-2T
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 08:37:30 +0000
Received: from regolo (85-18-251-172.ip.fastwebnet.it [85.18.251.172])
	by aiolia.regolo.cc (Postfix) with ESMTPSA id 4197264
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Mar 2011 09:37:24 +0100 (CET)
Date: Fri, 4 Mar 2011 09:37:11 +0100
From: Cristian Greco <cristian@regolo.cc>
Message-ID: <20110304093711.7c022f74@regolo>
In-Reply-To: <4D6FD518.1040503@redhat.com>
References: <4D6FD1D5.30209@redhat.com>
	<4D6FD518.1040503@redhat.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH v2] syscalls: getdents0[234]: add tst_exit()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5852321611762380941=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5852321611762380941==
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/suH9UEteLXnc6Oti8GoImqM";
	protocol="application/pgp-signature"

--Sig_/suH9UEteLXnc6Oti8GoImqM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 04 Mar 2011 01:51:20 +0800
Caspar Zhang <czhang@redhat.com> wrote:

> Similar to getdents0[34] and getdents0[234]_64, so I updated the patch
> to v2.
>=20
> These tests contain x86 asm so that they wouldn't be run on x86_64
> machine, but run into a simple main() functions instead. However all of
> them are missing tst_exit() which could result in a exit_code=3D10
> failure.
>=20
> Signed-off-by: Caspar Zhang <czhang@redhat.com>
> ---
>  testcases/kernel/syscalls/getdents/getdents02.c |    4 ++--
>  testcases/kernel/syscalls/getdents/getdents03.c |    4 ++--
>  testcases/kernel/syscalls/getdents/getdents04.c |    4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/testcases/kernel/syscalls/getdents/getdents02.c
> b/testcases/kernel/syscalls/getdents/getdents02.c
> index 4daae05..2503712 100644
> --- a/testcases/kernel/syscalls/getdents/getdents02.c
> +++ b/testcases/kernel/syscalls/getdents/getdents02.c
> @@ -74,7 +74,7 @@ int main()
>  {
>  	tst_resm(TINFO, "This test includes x86 asm and will not work on "
>  		 "this machine");

Hi Caspar,

wouldn't it be better to call tst_resm() with TCONF instead of TINFO,
for the sake of consistency?

Thanks,
--
Cristian Greco
GPG key ID: 0xCF4D32E4

--Sig_/suH9UEteLXnc6Oti8GoImqM
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJNcKS3AAoJEID329zPTTLkiasQAITHEdbliuYW4y94AAnhI+OB
3oXIUEDfNFD4AGxw3mtscs5G5G/jF8QopIGj30mfshS5csBqMkOgyoyXgqVnHwk7
l3cHhNzr+Klga1kriQTOXe6k/qGa0dg4SGoDUFSoKncMuulot8lpE1h5MMHFCZwY
4anM8NEXV+7ss/YG0DXfVfeXozwHEhyZI0uTLOJoBeo3gQxRVBXaBFtyIlD3DAgW
7PDyxdsJeoA2+iBvhbvVhHdgt+g8O+17J09orYSZtHBf6nCr1wNxrU4fuC6P6QAE
nnhBJj5rA5/nv8eY4rGjRNpF/EZvbTNIfrq79KSIf7DuMmX2Lmhvn+ZcgScN4/86
u5riYmuR4/WbYo4pIYdL78Ljo/Z5/dAOAFfRR2Sen1d3svcVmXgqCZiUwlaYkRoV
aX9VjRliPmAz/Oe3hzLbCRj/RN3aVduPiEPEVPR46qN4Ha0MZ/GqCj/3ItR1WXAH
TiiZsIelRimEc9jLA/u/poERXrg3DvbAljBAGZlh98CD/lDK6BErZ0CHOPipv+ZL
Hjy647QGwWPeBdFPWx/NSqOM+c4Y/nCzSaPUKAdkpL18yYW7hcZ+sr5yChghHIUj
sbmjr8GHiNODKIdcxAyWhOBfyUF5l0W4Qjo0MPbbt9nL1Net2NtduvkK3wFT8vda
dH/LLOsUfFZyf7MZUmKU
=6qlC
-----END PGP SIGNATURE-----

--Sig_/suH9UEteLXnc6Oti8GoImqM--


--===============5852321611762380941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
--===============5852321611762380941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5852321611762380941==--

