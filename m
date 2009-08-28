Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1Mh2gb-00028X-9d
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 14:44:17 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mh2gW-0004DO-7g
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 14:44:17 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 28 Aug 2009 10:44:03 -0400
References: <alpine.LRH.2.00.0908271703550.1134@vixen.sonytel.be>
	<200908280514.03971.vapier@gentoo.org>
	<1251454262.9081.16.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1251454262.9081.16.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-Id: <200908281044.04663.vapier@gentoo.org>
Subject: Re: [LTP]
 =?utf-8?q?=5BPATCH=5D_Annotate_tst=5F*=28=29_helpers_with?=
 =?utf-8?b?CV9fYXR0cmlidXRlX18gKChmb3JtYXQgKHByaW50ZiwgTSwgTikpKQ==?=
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5875475623115908895=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, ltp-list@lists.sourceforge.net

--===============5875475623115908895==
Content-Type: multipart/signed; boundary="nextPart1930829.ZkYqY2EmZg";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1930829.ZkYqY2EmZg
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 28 August 2009 06:11:02 Subrata Modak wrote:
> On Fri, 2009-08-28 at 05:14 -0400, Mike Frysinger wrote:
> > On Friday 28 August 2009 04:38:17 Subrata Modak wrote:
> > > Sorry. I need to revert this as it generates a huge set of warning for
> > > all the tests compiled. It should not only get fixed at test.h, but
> > > also in all tests that uses the tst_* family of functions, which
> > > obviously is too big to fix.
> >
> > nothing is too big.  the proposed patch is a great idea and anything
> > preventing it from being merged should be resolved so it can go back in.
>
> Great Mike. I am already seeing you doing some changes to the headers in
> CVS. Can you also push this patch once you are done with all the
> changes. Please notify me once all are done. I plan to checkout a fresh
> one for the upcoming release ;-)

ive fixed a good chunk of the warnings now, but there's still a good number=
=20
left.  maybe someone else feels like taking a crack at them, but i'm bored=
=20
now.  i'll leave it up to you to apply said patch now or wait a few days so=
 it=20
goes in after the next release.
=2Dmike

--nextPart1930829.ZkYqY2EmZg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKl+00AAoJEEFjO5/oN/WB3vUP/ilZ8Ip0k1cbGIc2HUBaTTZh
5qnGPStBZRmt+3HcX4hgWUxZ69pLbgIy70suIxN7idgkNX8HriDQg7hcDyKRr5U8
a8GeopTV+DnvGCZbuoGlWvuCK9j3wjobn+De0rF3GCT7pNE5G9qyJarxt7vPpX0Y
3nd99c4PYn+boYajDsjjldp8vOCppCWEFOaeMAsS/MYHC26HzfffSZZL/XHMUkB8
XfBzAm8AMEUZhUgGeBA8KgidEFHkga3YukorTi7hB7a+uGMY/WleueyyV3NCkkFa
QPDrY/a5oUoZINGvdSPoPHUnFx2z7r1ENAd/zqWcuGm5TBEe/cCyzwjzLVGofdAc
OBOn2xwZzId4pImKNCaISHvYf05jtAaKOY0um26gOotk1wj/14IHGvTwiv8if2ga
UYykTIEnuLIOJKvS19tO4ZDT1Dom4PHup6h4p6PRD36pTUHt2ZRHkEfc/k0F1BBK
ZZimleUivN+ZMLuMq/EtABYOeHPLDNgx/YNVmMbqd4LUfd9tdnJschLWVdNMGuAs
ar341o0KZhT4Q2ZOw5x8wDQbC32m97iVVeJ/bzHa++eAfFe3fhDcOCI8UXM1HQoz
rw7uPx3tVwX7hYWtJr0fWI1ynT+7dSbaeOqz86e1hx9ga94eyG8AKC3RZN7zUFS1
xO0MUC3SnTHQoOoIYkAp
=5oAg
-----END PGP SIGNATURE-----

--nextPart1930829.ZkYqY2EmZg--


--===============5875475623115908895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============5875475623115908895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5875475623115908895==--

