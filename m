Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RiB8S-0002QI-AT
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:39:04 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiB8R-000221-GH
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:39:04 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Jan 2012 15:39:10 -0500
References: <4F02DBF1.3090402@imgtec.com>
In-Reply-To: <4F02DBF1.3090402@imgtec.com>
MIME-Version: 1.0
Message-Id: <201201031539.11134.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 06/21] syscalls/unshare02: Replace ((int)NULL)
	with 0
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1858034523490985508=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Markos Chandras <Markos.Chandras@imgtec.com>

--===============1858034523490985508==
Content-Type: multipart/signed; boundary="nextPart4494896.BsrLIKfdmm";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4494896.BsrLIKfdmm
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tuesday 03 January 2012 05:44:01 Markos Chandras wrote:
> Hi, please review the attached patch

looks good
-mike

--nextPart4494896.BsrLIKfdmm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPA2dvAAoJEEFjO5/oN/WBWCEQAKkfx8I1KZ7KvF70m5h3MTtb
7kpMdObPHxXewcOBsu05CUXqi2T04QVwaWqnGcErD6NUfgS4tjaNT3Cvl7q2p84B
b5KwZBSRHAfYz2E+snXHjsQ7Dmih6hfjRLarbmx/JDOylFzmW3Rn4w8i8aguB6js
F57Qf8honjBBsXjvhhYKxacnL+EfidzVdcXqAwss/GcvpeYP3sSnWxaFuiyNuF8h
b7rbvyuvCzdhgZYsMsYmc+gWMi5dGUWEUdOtPVTQ9/368z+T7O8mz2//a1r4BX8A
ax7pLDUafLR1uoXmgRvKmaQ7YYaCtOa2hqpTfMNs8KsJAdaWpdmTmj5RJbjmw/VG
xmHX62mO3VEm+nOOuDw1CftBXZAxTmtM58pBpeFgsf9vyuRpX6jitIRCknL/+EXd
9hDNpSoqBbaPsgDYmGW0Gu7SvjqT1ubYLzC+vgBasOHv1TlGv9Z31lWnjMCrTYVv
t9tYp+0s1aBr+8ZTGURvIqGyix/vH/tRxNeC3k1jzvC373PXRmgmIUP/RUClZKI+
sH9gaXyWErGy9oakiDVAGFA7NeQkBoeLdZabQfZp6n2Nue5nBB8F6T/gqkB7ESZB
wGKsWtG0iE1FgzrmYWS6hMJq5owXtMKoKYAU/tgYYjjPym2AIXMeXcrmicIyC/Jw
x4co4AwJecTvx8+hdPSA
=oWHt
-----END PGP SIGNATURE-----

--nextPart4494896.BsrLIKfdmm--


--===============1858034523490985508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--===============1858034523490985508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1858034523490985508==--

