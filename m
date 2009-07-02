Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MMUTl-0007An-Fe
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 22:10:05 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MMUTj-0000Dj-3v
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 22:10:05 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 2 Jul 2009 18:09:16 -0400
References: <20090702084828.GC19135@count0.beaverton.ibm.com>
	<200907021435.48510.vapier@gentoo.org>
	<20090702203253.GI19135@count0.beaverton.ibm.com>
In-Reply-To: <20090702203253.GI19135@count0.beaverton.ibm.com>
MIME-Version: 1.0
Message-Id: <200907021809.18522.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 4/4] netns: Change interpretters from sh to bash
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4456583325297676127=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Poornima Nayak <poornima.nayak@in.ibm.com>, ltp-list@lists.sourceforge.net, Daniel Lezcano <daniel.lezcano@free.fr>, Veerendra C <vechandr@in.ibm.com>, Munipradeep <mbeeraka@in.ibm.com>

--===============4456583325297676127==
Content-Type: multipart/signed; boundary="nextPart1728554.AOp1zbvtIS";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1728554.AOp1zbvtIS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 02 July 2009 16:32:53 Matt Helsley wrote:
> On Thu, Jul 02, 2009 at 02:35:46PM -0400, Mike Frysinger wrote:
> > in general, converting sh to bash is a bad idea as it can cause issues
> > for us embedded peeps.
>
> I suppose that's because of the memory bash consumes. Is there anything
> else it does which is bad for embedded?

there is memory and disk usage concerns, but there are also systems that ca=
nt=20
run bash at all (e.g. systems without fork() -- all no-mmu Linux ports)
=2Dmike

--nextPart1728554.AOp1zbvtIS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKTTAOAAoJEEFjO5/oN/WBWrMQAMQrrV/YH0y0o0pNLmnJ4eXZ
+WGBvX519cb0SrMr/cB7uWrlGEEV8tcKx+HPgF9RfvUNyk4cf3cvgSr4FmzeF0HE
MlkDL00H2U3ixiBr3vmq8/yEYWqKOSU3xG6ZxIzF8hXQy4UdwQKlEWu3HHYu4nY4
LCpuArgUDnJva457TozJEJ15Vd1TgMDspZcHjnYOq+VFCiBtXokpBIuWoll7bdlw
xVDYhMvb+PH3eAH0g0ODqMJtqKd5HbZMyp7fKclqpNptoe6RdsV4HRoYJVI3zYO5
vYytno5fAMh3qb90vzzE6yJoU4g8XUd7wVtRFwxl1v9v/YVg5GNuR9Ef1gIbpVam
3ehVe7nb9TAt8pdZ5lkYAdpNYn64cjkcN8GqKu5opU4++lm5a1fb7H4xw1ColfxX
nRwr6D9gS6d6b+yUhF48u/3qikFmDtS3gXbDAfLc7hKVC5O9rM3Cgdw2BIDwQbh7
GkIVZ6HPJNSExHFtmOz8/i1l2C0ImtHqq/pwvCLKYSliKTAvtJ9PJY2nJB/LmF70
Ox+GoSz/K+rhQErbc9gpeUqrT7WsbcbjswqsF+SgNjN4Y8WxyudWjbKY2GCAE0GX
CJ8egAJCKpM1jTI0yXjHofLKQVQ8U3KZFAD2bkafP0DoPUzXoYob13gV2aIsX7KW
tFdNSi7R8QGp5UZrSTsw
=9yJy
-----END PGP SIGNATURE-----

--nextPart1728554.AOp1zbvtIS--


--===============4456583325297676127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============4456583325297676127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4456583325297676127==--

