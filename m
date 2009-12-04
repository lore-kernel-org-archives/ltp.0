Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NGdVi-0008Lr-5t
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 19:08:10 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NGdVb-0004pI-Qu
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 19:08:10 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 4 Dec 2009 14:13:11 -0500
References: <4b1944a0.8713f30a.3b2f.4a0fSMTPIN_ADDED@mx.google.com>
In-Reply-To: <4b1944a0.8713f30a.3b2f.4a0fSMTPIN_ADDED@mx.google.com>
MIME-Version: 1.0
Message-Id: <200912041413.11781.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Support for parallel compilation
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4583627422820581188=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Jiri Palecek <jpalecek@web.de>

--===============4583627422820581188==
Content-Type: multipart/signed; boundary="nextPart3267154.vGoqh3aQCO";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3267154.vGoqh3aQCO
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Friday 04 December 2009 12:04:06 Jiri Palecek wrote:
> -.PHONY: $(RECURSIVE_TARGETS) $(addprefix trunk-,$(RECURSIVE_TARGETS))
> +.PHONY: $(RECURSIVE_TARGETS) $(addprefix trunk-,$(RECURSIVE_TARGETS))
>  $(foreach tgt,$(RECURSIVE_TARGETS),$(addprefix
>  trunk-subdir-$(tgt)--,$(SUBDIRS)))

these foreach look like an overly complicated form of $(patsubst):
	$(patsubst %,moo_%,$(DIRS))
-mike

--nextPart3267154.vGoqh3aQCO
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLGV9HAAoJEEFjO5/oN/WBXAYP/i5jX+hywwIdpmtW8O/HFYU2
mt6DGK/Pm+bGPyJ1w5jCEmVtZ/hKpZobYwooM/bsK7qIbJRGEE34s4s2i6o2qzfR
WUbIv1fXrkQ71K2mcHyBrBh5c38WZsunofQBQOPLNuD0sCZH+oHlyEUdF+nde1Z8
qFw/ILylmXmyKeJ6Ro2JGloyXHsckYJPfH1ByRna0rlnMBexEWXc1wQqSrKRJ13y
ZTohU/NapyIpM4jnBfowSPxVUGw1Mff4WG71ZWU76bgCRWdrylXyy6mUhjjienhL
WBgP4vWPoEiRSB+iVzpW/q8I9jJMqKL2BgKEA/Rg8ySlhJAa20+TpMiBiod3j+2m
AlVXuYt3/Yv8KVY7/N73WNNGWjGnINBHmEjIPHLk2XQz6pFbRPUWGKJVqvVAEiZ4
YARPcvY7v8CoqDKpesE0nkQx34ME5mEluTtVghYnBiBThqG3UA27x5poZkxMOPaG
f8WCcPii0IFArh9+y58e6y2HurCxbQEf+UnEit1wxdVaWHn+vN42pgRoWgngQx5c
f+b942Z0P2L/fZo9wjvYVXMc/I/eff5mOAABOWQKStPuxssEYW9LTSSqSKQZVPvy
lMgOYHIZilEF5LEXcMyEujGPEZeok0LPaB9P0v6VYo8COSrzV2H0+SheW9pQbB+g
fZjKxsGbV/ADP2M/GFJU
=6hr4
-----END PGP SIGNATURE-----

--nextPart3267154.vGoqh3aQCO--


--===============4583627422820581188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
--===============4583627422820581188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4583627422820581188==--

