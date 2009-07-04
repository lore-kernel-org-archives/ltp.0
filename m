Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MMzwJ-0005RS-DA
	for ltp-list@lists.sourceforge.net; Sat, 04 Jul 2009 07:45:39 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MMzw6-0006tm-Ir
	for ltp-list@lists.sourceforge.net; Sat, 04 Jul 2009 07:45:34 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 4 Jul 2009 03:45:19 -0400
References: <364299f40907040039y15f642b1ue8d92b1823a12821@mail.gmail.com>
In-Reply-To: <364299f40907040039y15f642b1ue8d92b1823a12821@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907040345.22922.vapier@gentoo.org>
Subject: Re: [LTP] subdir make with LTP
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6725777309731292675=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Nate Straz <nate-ltp@refried.org>

--===============6725777309731292675==
Content-Type: multipart/signed; boundary="nextPart3167989.iWBCpI47r8";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3167989.iWBCpI47r8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 04 July 2009 03:39:08 Garrett Cooper wrote:
> Hi Mike, Nate, and Subrata,
>     Although some people may be unhappy with this change, I was
> thinking of `breaking' subdirectory based make operations with LTP as
> this would overcomplicate the make system logic a great deal with a
> bunch of cookie cutter logic that will grow stale and become a pain to
> maintain.
>     Is this something that would be a desired feature moving forward
> or something we can official drop?
>     Subdir based Make would still function by specifying srcdir= on
> the command line, but doing a bare command like the following:
>
>     cd testcases/kernel/syscalls && make all
>
>     would fail.

that would annoy me greatly as this is my primary mode of ltp usage
-mike

--nextPart3167989.iWBCpI47r8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKTwiSAAoJEEFjO5/oN/WB6vAP/0IKccJmYs1ZpamVH/DM/Qpc
9cCV3A8Ziz1fK6cpr7hpwGPENfTfdjVL5HaOiUtwQ4l3s+czISu3esZ0xMw008Vc
v8U8IAG9SRmFGPqeuIHO4P6xeeI8WlPpvUDEpFDMpvi7mbrbAlRbbQIcfD+1YhHd
C6LtDRp3IzOfL7J3AEvPNvB3MTkIwlkYCawlHiAjTYgMTyNNFCIW65t61Ym9d3TP
k6SWMEiNj2fj3T6+++vTMnswxjpJrr5ymZjGJXe29ReDMtFn0+SxZPCb/QhxqVHe
glj+2LS6qmxxoy8YzD/H5yC7Qbb4b7FuLUFlbGupD7/e7hYhfyF0d1e3o8CoruGa
KccQus/oYgtZONqSpPtxA62VLUZdd+G4S34pTBqQ5Yur/kNZYs+cm5ZYMrv1ETUQ
BwjVuAqJtpqfjAajX7aPjcZY0w7B5SPcwN9Bzy2/IolOONljt2HyXZYmAjDgjep5
2FxqE5N+kUinHHIrqJQ5ReFwYGDyiRpUAONwvuBk0ceU4aUHEZa7dFsVoiIr2NWq
a/ZCvOsSbf8J1fz4JDli68rB510xKDzy8aFYmaspLkwTj22roy/qSkPmZFRTJi56
0vI9n5XIt9VQr0xGFklzEDqz5IbZpjfJM8Mky+eaW1HjjUvDy2NfShS3Sz4mznbY
KgFL+qCZIU91+IFLrAAb
=fvFC
-----END PGP SIGNATURE-----

--nextPart3167989.iWBCpI47r8--


--===============6725777309731292675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============6725777309731292675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6725777309731292675==--

