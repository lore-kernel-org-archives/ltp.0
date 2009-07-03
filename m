Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MMZgY-0004y8-K6
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 03:43:38 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MMZgT-0001sX-1T
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 03:43:38 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 2 Jul 2009 23:42:58 -0400
References: <364299f40907021746p3ce4bacdwbfc834ef7e4cfcfd@mail.gmail.com>
	<200907022245.43330.vapier@gentoo.org>
	<364299f40907022027n5f9ee24as262417392ed5bbf2@mail.gmail.com>
In-Reply-To: <364299f40907022027n5f9ee24as262417392ed5bbf2@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907022342.59078.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 8/10] config.mk not required for clean
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2934508830348258468=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============2934508830348258468==
Content-Type: multipart/signed; boundary="nextPart3833064.RltaEH9axG";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3833064.RltaEH9axG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 02 July 2009 23:27:52 Garrett Cooper wrote:
> On Thu, Jul 2, 2009 at 7:45 PM, Mike Frysinger wrote:
> > how about we aim for avoiding the include completely regardless of
> > target. really config.mk is setting up the environment and recursive
> > makes should be inheriting those.  so if our toplevel .mk exported
> > something like: LTP_CONFIG_INCLUDED = yes
> >
> > then all the fragments in the sub-makefiles should look like:
> > ifneq ($(LTP_CONFIG_INCLUDED),yes)
> > include $(topdir)/config.mk
> > endif
> >
> > then you could have the clean target lie by doing:
> > $(MAKE) -C testcases LTP_CONFIG_INCLUDED=yes clean
> >
> > which would address all of your concerns ?
>
> Yes. That's sort of the concern that I was going for with my previous
> spin, but then it turned into a gob of Makefile.inc files that were
> being added unnecessarily to the SCM. Considering that the include
> file is only needed for files that include config.mk (which are a
> small handful -- 10 to be exact), I figured that adding the necessary
> logic to the top would be wise.

today it is 10, but ideally this is the format we'll be moving to
-mike

--nextPart3833064.RltaEH9axG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKTX5DAAoJEEFjO5/oN/WBfDUQAJmNpaCxf4eXqM+tr5y0LULN
YQqW6tbtVhMd86Qo3RzGIQ8wRi1k3W6Nvir6pLUJqX0/3oSwXwHL5VIdiHScbegD
Mjsfzi9IafJk5lgK/rFvJbTgavgXYqipsEJ5qbrnnUNKb/sA984YeQr6igMoCMTZ
DDQI7iiiMZgZqrLPox5mZ27H0aANloYss28dRy1fdSUfymkdkspcC8Cg99lKYJuE
EjdgWGI1ikCL7hVtWwacHPjvbzh1EUYb3x7TfLHGcGKK9SqvrTdQbU8UeIgEJH0Q
3Id0vIfC9Ct88b9PpRqDEntLU39HRIXhyg+SJTJ9ZqzABsV2z01N2fgFmsH5m6Gr
O+Wb7Y4zjMNwIpo8LkkwgNxBe/DVhECHH7yh87tccATBasvbSrhGscpdMr0RJ6Aj
+sYIr2QpVzqOkPjQhoEb6dazT74oSIau+89hdt2ovp/U4yYsvlZ5Gb++fR99zzHd
fLsg5abF7e3/SIYesNYNToNjhK25IQ13Qe2GQHJegRO7eOWFWTbfnGDQHPa6Zoyd
jrFeaGqlAdqlZ40nSrnZsVARE3zTfAyKXu0HcNWia074lGhjACudVKxlm4sMsEBr
0mEiVpe7TX92bVosp1F3t5Str6fJ4cSLiTaAeOlGtnvhMm5TJnoErnavieSeaGWe
r7shf8WWXK+NIm9QREL9
=RIzS
-----END PGP SIGNATURE-----

--nextPart3833064.RltaEH9axG--


--===============2934508830348258468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============2934508830348258468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2934508830348258468==--

