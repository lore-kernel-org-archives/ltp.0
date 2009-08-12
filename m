Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MbJ2E-000699-0l
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 18:58:54 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MbJ27-0007RF-O0
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 18:58:53 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA1B7D.FC3F67C8"
Date: Wed, 12 Aug 2009 11:52:04 -0700
Message-ID: <8368651DACC1964480F951191B94A078010C5C68@svexch01.mvista.com>
In-Reply-To: <4A82DC0A.3050502@canonical.com>
References: <4A7AEE38.60101@canonical.com><364299f40908061022m926d148o661e1c8a2eb58a5@mail.gmail.com>
	<4A82DC0A.3050502@canonical.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: Re: [LTP] fix lib6 test building
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Paul Larson <paul.larson@canonical.com>, Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA1B7D.FC3F67C8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Paul,=20

The patch above applied to version 1.5 of the make file works fo me =
across multiple architectures. It turned out that RANLIB was not needed, =
as long as the appropriate AR was used. It had been hardcoded in 1.4. =
Let me know if that works.=20
=20

-----Original Message-----
From: Paul Larson [mailto:paul.larson@canonical.com]=20
Sent: Wednesday, August 12, 2009 8:13 AM
To: Garrett Cooper
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] fix lib6 test building

Garrett Cooper wrote:
> On Thu, Aug 6, 2009 at 7:52 AM, Paul Larson<paul.larson@canonical.com> =
wrote:
>> The lib6 tests seem to fail the first pass through building for me=20
>> because ranlib does not seem to get set correctly at any point.  This =

>> seems to fix it up for me.
>=20
> Fixed on HEAD moments ago:
>=20
> gcooper@orangebox /scratch/ltp-dev2/ltp $ cvs diff=20
> testcases/network/lib6/Makefile
> Index: testcases/network/lib6/Makefile=20
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/testcases/network/lib6/Makefile,v
> retrieving revision 1.6
> diff -r1.6 Makefile
> 25a26,27
>> RANLIB                ?=3D ranlib
The patch you checked in does not correct the build failure.

Thanks,
Paul Larson

-------------------------------------------------------------------------=
-----
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 =
30-Day trial. Simplify your report design, integration and deployment - =
and focus on what you do best, core application coding. Discover what's =
new with Crystal Reports now.  http://p.sf.net/sfu/bobj-july =
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CA1B7D.FC3F67C8
Content-Type: application/octet-stream;
	name="lib6-Makefile.patch"
Content-Transfer-Encoding: base64
Content-Description: lib6-Makefile.patch
Content-Disposition: attachment;
	filename="lib6-Makefile.patch"

LS0tIGx0cC1mdWxsLTIwMDkwNTMxL3Rlc3RjYXNlcy9uZXR3b3JrL2xpYjYvTWFrZWZpbGUJMjAw
OS0wMS0yMiAwMToyNjoxMC4wMDAwMDAwMDAgLTA4MDAKKysrIGx0cC90ZXN0Y2FzZXMvbmV0d29y
ay9saWI2L01ha2VmaWxlCTIwMDktMDctMjAgMTI6NDk6MDAuNDAzNTEyNzAwIC0wNzAwCkBAIC0z
OCw0ICszOCw0IEBACiAJcm0gLWYgJChUQVJHRVRTKSAqLmEgKi5vCiAKIHJ1bmNjLmE6IHJ1bmNj
Lm8KLQlhciBjciBydW5jYy5hIHJ1bmNjLm8KKwkkKEFSKSBjciBydW5jYy5hIHJ1bmNjLm8K

------_=_NextPart_001_01CA1B7D.FC3F67C8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
------_=_NextPart_001_01CA1B7D.FC3F67C8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CA1B7D.FC3F67C8--

