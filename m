Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PK0h1-0003o2-UA
	for ltp-list@lists.sourceforge.net; Sun, 21 Nov 2010 03:34:19 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PK0h0-0007qF-VE
	for ltp-list@lists.sourceforge.net; Sun, 21 Nov 2010 03:34:19 +0000
Received: by wyb34 with SMTP id 34so1300688wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 20 Nov 2010 19:34:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4CE0E14D.6010306@st.com>
References: <4CA09D4D.6050708@st.com> <4CA34070.9070505@st.com>
	<20100930133120.GA4070@hannu-debian.research.nokia.com>
	<4CA469A0.5090700@st.com> <20101001040609.GA2090@hannu-ubuntu>
	<4CA9D0EB.5090309@st.com>
	<20101004190552.GA997@debian-master.elisa-laajakaista.fi>
	<4CD92F6B.9040508@st.com>
	<1289462230.5622.40.camel@subratamodak.linux.ibm.com>
	<4CDBA487.7080507@st.com>
	<AANLkTi=Y-z0WFb6Nkr6zr650urxoQOPo3ohw+e+YZueJ@mail.gmail.com>
	<4CE0E14D.6010306@st.com>
Date: Sat, 20 Nov 2010 19:34:11 -0800
Message-ID: <AANLkTi=B8pSuAH3EjJK47wN9P_Y2Z1F88Wzqn0Y7aJ9f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] ltp_clone alignment issues.
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
To: Carmelo AMOROSO <carmelo.amoroso@st.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Sun, Nov 14, 2010 at 11:29 PM, Carmelo AMOROSO
<carmelo.amoroso@st.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 11/11/2010 10:59 AM, Garrett Cooper wrote:
>> On Thu, Nov 11, 2010 at 12:08 AM, Carmelo AMOROSO
>> <carmelo.amoroso@st.com> wrote:
>> =A0> -----BEGIN PGP SIGNED MESSAGE-----
>> =A0> Hash: SHA1
>> =A0>
>> =A0> On 11/11/2010 8:57 AM, Subrata Modak wrote:
>> =A0>> On Tue, 2010-11-09 at 12:24 +0100, Carmelo AMOROSO wrote:
>> =A0>> On 10/4/2010 9:05 PM, Hannu Heikkinen wrote:
>> =A0>>> On 04/10/10 15:04 +0200, Carmelo AMOROSO wrote:
>> =A0>>> -clip-
>> =A0>>> >
>> =A0>>> > Hannu,
>> =A0>>> > I don't think that it is a good to force the alignment; we coul=
d need to
>> =A0>>> > write a test case that calls LTP_clone with an unaligned stack =
just to
>> =A0>>> > test the behavior of the clone implementation.
>> =A0>>> >
>> =A0>>> > Likely, it should be useful to add a check inside the C lib clo=
ne
>> =A0>>> > implementation (arch specific) to protect against unaligned sta=
ck, but
>> =A0>>> > this is a different matter.
>> =A0>>> >
>> =A0>>> > I would just leave the LTP_clone passing the argument to the cl=
one as
>> =A0>>> > they came from the caller.
>> =A0>>> >
>> =A0>>> > Regards,
>> =A0>>> > Carmelo
>> =A0>>> >
>> =A0>>
>> =A0>>> Hi Carmelo,
>> =A0>>
>> =A0>>> you've got point, yes. I was just so worried about the fact that =
in ARM
>> =A0>>> architectures that previous eg clone02 failed due to alignment er=
rors.
>> =A0>>> But your fix of course fixed that issue, and it gives as a possib=
lity
>> =A0>>> to make test case against alignment issues, quite right.
>> =A0>>
>> =A0>>> br,
>> =A0>>> Hannu
>> =A0>>
>> =A0>>
>> =A0>> Folks,
>> =A0>> any change to get this included for the next release ?
>> =A0>>
>> =A0>>> Did we miss any patch here ?
>> =A0>>
>> =A0>
>> =A0> I think so: this one
>> =A0>
>> http://sourceforge.net/mailarchive/forum.php?thread_name=3D4CA09D4D.6050=
708%40st.com&forum_name=3Dltp-list
>> <http://sourceforge.net/mailarchive/forum.php?thread_name=3D4CA09D4D.605=
0708%40st.com&forum_name=3Dltp-list>
>>
>> Is the above patch endian agnostic?
>>
>
> Yes, definitely. The patch just removed an wrong manipulation of the
> stack arguments for all the archs.

    I'm going to test it in just a bit, but please let me know if you
run into any issues.
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
