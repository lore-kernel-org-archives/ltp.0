Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UV20A-0002oe-1b
	for ltp-list@lists.sourceforge.net; Wed, 24 Apr 2013 15:52:58 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UV209-00020e-1Q
	for ltp-list@lists.sourceforge.net; Wed, 24 Apr 2013 15:52:58 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 24 Apr 2013 11:52:45 -0400
References: <8a4fb5929c599b2dec955086713069c20f95c466.1366704928.git.jstancek@redhat.com>
	<201304231213.33013.vapier@gentoo.org>
	<1865305189.2143033.1366786432951.JavaMail.root@redhat.com>
In-Reply-To: <1865305189.2143033.1366786432951.JavaMail.root@redhat.com>
MIME-Version: 1.0
Message-Id: <201304241152.47110.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] syscalls/cma: add runtime check to setup()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0606296820633123017=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

--===============0606296820633123017==
Content-Type: multipart/signed; boundary="nextPart1464552.WFekEN2WUc";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1464552.WFekEN2WUc
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 24 April 2013 02:53:52 Jan Stancek wrote:
> From: "Mike Frysinger" <vapier@gentoo.org>
> > On Tuesday 23 April 2013 04:17:15 Jan Stancek wrote:
> > > __NR_process_vm_readv / __NR_process_vm_writev defined doesn't
> > > guarantee, that kernel supports these syscalls. Add check to setup(),
> > > which uses ltp_syscall(). If syscall isn't supported it will
> > > end the testcase with TCONF.
> >=20
> > delete all the "#else" branches since you're now using
> > linux_syscall_numbers.h
>=20
> Without that check in parent, you can end up in situation where some child
> aborts first and then parent reports failure. By doing it early in setup()
> you can avoid allocating resources that won't go away when process later
> terminates with TCONF.

by including linux_syscall_numbers.h, you've guaranteed that=20
__NR_process_vm_readv will always be defined, thus the code under "#ifndef=
=20
__NR_process_vm_readv" will never be run, thus you should delete it.
=2Dmike

--nextPart1464552.WFekEN2WUc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRd//PAAoJEEFjO5/oN/WBYJ0QANtV4x4PPsj7HHroT4sdgWQV
ZXJieEy4nrG96MlEBN9mqNa9NtKsIoXTYwKHNqa3hfExQT57tV3LSd2uQsYUFaSl
Y/xaHDyD8ysFtuv0snol1vuhlrS1HXKesveKvJ1lzgADRzw8Wae3UwsWO9wyNG0C
YzS2h6DNQfRUM1hwFgLsz9oDi+vdw20xI/WrKd1NAR16/g85C7NjQDo7uazmHDCb
HqxdDSnNv+6+dSfDUWMVj/EHEO53w5oZ3Y2ImTPUy+zOJCZtEoZO8sng1xt+QUQ5
deFMIZ3Qn9UWepmPS+kOzxVWp5qAVuR/b4Xq0KG/7v/SDOek/rZoSg9XZ6xrCg0E
bF74VbqigevyeqPaRYflIggqIbX+l2AehjRNqNm3BA4E20PxrwyffpI2dVvdUq+z
tMRAwt+06x/G2p4VT4cMuKFdhC7Yyp29CW0A/pVfVdfVJeVLOkdNfDO6sPH/1QFk
5LrnVDBXa3Bk9qdlIdMVQL1q8vytHjxuquWT+vC5nCmknSBbHSjemI9N09si/iTp
p8RO4B25K8oe3d1q9UuyRPBlprqigt0TBphe7hgI1AJr9LrJQCKGzWqDLFLUZV0Q
WiL3RfMSu704KuX3sBX7D1ZpliQRIIMFt3c4zRE4JQVOLovbiC40OTSR0t3V9qOY
wr9S0+aM0f/U2C6OKKsn
=m+FQ
-----END PGP SIGNATURE-----

--nextPart1464552.WFekEN2WUc--


--===============0606296820633123017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
--===============0606296820633123017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0606296820633123017==--

