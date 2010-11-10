Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PG0It-0002wO-65
	for ltp-list@lists.sourceforge.net; Wed, 10 Nov 2010 02:20:51 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PG0Is-0004SU-8w
	for ltp-list@lists.sourceforge.net; Wed, 10 Nov 2010 02:20:51 +0000
Received: by wwi17 with SMTP id 17so201121wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 09 Nov 2010 18:20:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1121756706.2182361289355390359.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <1446953781.2182231289355295508.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1121756706.2182361289355390359.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Tue, 9 Nov 2010 18:20:44 -0800
Message-ID: <AANLkTimgODD+NZ+axvkO_beifVis7s3GoNs2HeUn6zmp@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v3] functional testing for Kernel Samepage Merging
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: caiqian@redhat.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Tue, Nov 9, 2010 at 6:16 PM,  <caiqian@redhat.com> wrote:
>
>> > > + =A0 =A0 =A0 tst_resm(TINFO, "child %d verifies memory content.",
>> proc);
>> > > + =A0 =A0 =A0 for (j =3D start; j < end; j++)
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D start2; i < end2; i++)
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (memory[proc][j][i]=
 !=3D value)
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_re=
sm(TFAIL,
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 "child %d has %c at
>> > %d,%d,%d.",
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 proc, memory[proc][j][i],
>> > proc,
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 j, i);
>> >
>> > memcmp'ing a fixed buffer should be considerably faster verifying
>> > values byte by byte.
>> OK. Thanks.
> After further looking for this, it turned out memcmp did not offer the fl=
exibility that when the verification failed like which byte caused the fail=
ure and its actual value to help with debugging.

    Well... ok. How about doing the memcmp, and if things fail narrow
it down from there? Comparing things byte-by-byte is a long and
lengthy task :/...
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a =

Billion" shares his insights and actions to help propel your =

business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
