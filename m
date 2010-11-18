Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PIyfO-0000Cx-9i
	for ltp-list@lists.sourceforge.net; Thu, 18 Nov 2010 07:12:22 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PIyfN-0008Ea-9N
	for ltp-list@lists.sourceforge.net; Thu, 18 Nov 2010 07:12:22 +0000
Received: by wwb28 with SMTP id 28so2156145wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Nov 2010 23:12:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20101118014303.GA30825@us.ibm.com>
References: <AANLkTik8zF-X21KAUjYWeB2FhNVX61oc5ptMffXBnukJ@mail.gmail.com>
	<AANLkTink7COs0xpg5QRPxBajHRGfYfnghs2_xn1FBFLk@mail.gmail.com>
	<4CDAA3CA020000E80006AF93@novprvoes0310.provo.novell.com>
	<AANLkTimOfSA_9ixATpX32a_7ytz8zdYLjLr_PZiegcmf@mail.gmail.com>
	<1289458673.5622.19.camel@subratamodak.linux.ibm.com>
	<20101118014303.GA30825@us.ibm.com>
Date: Wed, 17 Nov 2010 23:12:14 -0800
Message-ID: <AANLkTin=Ko=g4DxUccD_WKDOqMO-JQ4=r48bih=puz-X@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [RFC] Remove testcases/pounder21
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
To: James Takahashi <takahash@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, "iranna.ankad" <iranna.ankad@in.ibm.com>

On Wed, Nov 17, 2010 at 5:43 PM, James Takahashi <takahash@us.ibm.com> wrot=
e:
>> > On Wed, Nov 10, 2010 at 12:53 PM, Murlin Wenzel <mwenzel@novell.com> w=
rote:
>> >
>> > Answering my own question:
>> > http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg09788.ht=
ml
>> > , I asked this earlier on this year and someone replied saying "don't
>> > remove it". If it's not removed and serves a particular purpose, maybe
>> > it should be moved to a different section of the tree to avoid
>> > confusion in the future (in particular if it's a framework and not
>> > actually a test / test suite).
>
> Yeah, that was me.
>
> I now understand that the LTP Makefile reorganization from earlier in
> the year attempts to recursively build everything that lives under
> 'testcases' due to the (reasonable) assumption that everything in
> 'testcases' is a subtest to be executed under LTP control.

    Well... it should be organized in such a way that testcases
logically should live in the right spot, tools in other spots, right?
FILTER_OUT_SUBDIRS is fine, but it's just annoying because things
weren't put in the correct spots to begin with. Other things haven't
been touched in ages. I'm trying to take care of these two items so
that the organization and relevance of LTP is better than it was
before.

> 'pounder', however, is not a subtest to be executed under LTP control.
> It is a separate test execution framework, and in fact, executes LTP's
> 'runltp' as a subtest within that framework. =A0This allows us to run
> other standalone tests, test suites, and/or benchmarks along side LTP.

    Which is why I suggested moving it into its own CVS module / git
repository / whatever. Logically this makes sense because:

a. Development is low traffic.
b. pounder executes LTP.
c. pounder isn't built with LTP.

    Thus, for anyone that needs to grab pounder they can check out the
module and build the sources / install the package / whatever, and no
one else needs to deal with the maintenance and upkeep of pounder when
all they want is LTP because they have their own test infrastructures
to deal with this stuff. My old group at Cisco never built and
integrated pounder into their test suite, and I would be skeptical of
how many folks outside of IBM use it.

> I agree that it would make sense to move pounder21 to some other place
> in the tree. =A0At first glance, 'utils' looks like a reasonable spot.
> Thoughts?

    Push comes to shove and enough IBM folks disagree, I guess... but
it seems like my argument makes more sense in the grand scheme of
things.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
