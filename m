Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MR7nu-0002jA-Un
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 16:58:02 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MR7no-0006T0-Ei
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 16:58:02 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 15 Jul 2009 12:57:54 -0400
References: <364299f40907112253s6edf39b2m5c6aa5aeb8ed2f5d@mail.gmail.com>
In-Reply-To: <364299f40907112253s6edf39b2m5c6aa5aeb8ed2f5d@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907151257.54936.vapier@gentoo.org>
Subject: Re: [LTP] Patches respin done;
	waiting for approval ACK before continuing...
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3499869088148803005=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3499869088148803005==
Content-Type: multipart/signed; boundary="nextPart113446771.TBLmRW55mC";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart113446771.TBLmRW55mC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 12 July 2009 01:53:55 Garrett Cooper wrote:
>     I have a lot of other modified Makefiles, but I'm waiting for an
> ACK from developers (most notably Matt and Mike) before continuing,
> and I'll need to do a final test run before commit. The patches will
> be large, but similar from here on out...

the current patch series is confusing at best due to the numbering in the=20
subject and random relationship noted in each patch.  i really havent a clu=
e=20
how they're fitting together, i'm just reviewing each by itself and assumin=
g=20
they fit together somehow.  after the next set of review, please do 1 threa=
d=20
with all the patches in it (no need to declare their order since they're go=
ing=20
in as a set):
=2D respin summary
	|- refactor....
	|- enhancements....
	`- autoconf.....
=2Dmike

--nextPart113446771.TBLmRW55mC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKXgqSAAoJEEFjO5/oN/WBOLoP/1Ik+yD5uYv+ydRnp7mlcmEs
uLS49p3ZW1eHuPunsXAM8zcKQkxWfbW7RKjz9U0NcjeBq7pdMeWAsI+TPlsJlv8v
l2J4TBFZER6CSM69ASsMHo5dg0rdB+AhmFwvgdBtcFpQt+lbBxdd15ytG+osS/rj
iWaIMjqv5kuFrRTXhoorg+TgtBAzUOrQd0JfG/CIkG3/xxJ2pFtWikRD/2q/W2+c
UNKYWxGWapynNHF96J6H7SgbMihVWvGHncIxC8rSHjUiXWBPUEQoW2Ki0GyDMCfL
+KQ/tLN1bfJkihwDZCFSh+NRm60DM9Gwhw5UppKi8qUss56dfv/wAgoNbMKR2F5y
RL81qS/iReeYvdNFcWQ0DXA/lyYJiryqaxgc2aJS0LaGeHnd2iZTL4meP+4VnSfM
MAkTQBVgSvHVuhqpB9ImxS7r6kcYF4HwxpRb0dd3pXpTHO274mWerWbQR290XW2Z
81pDkBOhFoLMXSeyYOsouG3DoSBugqNwZmRMnYM2gurJVIVITH63njJN+262YJno
IGFJItEoRAxD7RMxPYWx2tn2FZmcVaoqyCkuxXq6yVopxS9wYGcLO8Yx43FFYDHY
+u8NohVKpfQ1HFoL4eCffYiXNspfdDzcG0w/06pFLFs4VWayQCWGG2fMaU/Y0laN
cHb0RK6NTOWR3v6KTBmd
=buIh
-----END PGP SIGNATURE-----

--nextPart113446771.TBLmRW55mC--


--===============3499869088148803005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--===============3499869088148803005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3499869088148803005==--

