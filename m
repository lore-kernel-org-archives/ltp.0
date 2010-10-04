Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P2s6L-0001Wn-Pp
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 20:57:37 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P2s6K-0007IT-Vu
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 20:57:37 +0000
Received: by iwn2 with SMTP id 2so9644706iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 04 Oct 2010 13:57:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20101004200037.GC997@debian-master.elisa-laajakaista.fi>
References: <4CA09D4D.6050708@st.com> <4CA34070.9070505@st.com>
	<20100930133120.GA4070@hannu-debian.research.nokia.com>
	<4CA469A0.5090700@st.com> <20101001040609.GA2090@hannu-ubuntu>
	<4CA9D0EB.5090309@st.com>
	<AANLkTim_Ay4yjdBfm8tzEiK_z4JzQyg6RRsR3E1tCH9h@mail.gmail.com>
	<20101004200037.GC997@debian-master.elisa-laajakaista.fi>
Date: Mon, 4 Oct 2010 13:57:31 -0700
Message-ID: <AANLkTinP=W6Tk0pzVQfSiH=8fMQKYC4yPF5ztXRGWDA3@mail.gmail.com>
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
To: Hannu Heikkinen <hannuxx@iki.fi>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Mon, Oct 4, 2010 at 1:00 PM, Hannu Heikkinen <hannuxx@iki.fi> wrote:
> On 04/10/10 06:28 -0700, Garrett Cooper wrote:
>>
>> =A0 =A0 I believe this is already handled to some degree with the clone
>> testcases. If not that should be added and I'll review patches which
>> add this testing to LTP.
>> =A0 =A0 On a semi-unrelated note could you guys please test out the
>> attached patch to make sure that there isn't a functional difference
>> if you have access to ia64, s390, etc?
>> Thanks,
>> -Garrett
>
> Hi,
>
> after that CHILD_STACK_SIZE (def for as it has been 16384) tests passed in
> AMD64 - Debian 64-bit and BeagleBoard 32-bit ARM (std linux-2.6 with
> omap3_defconfig).
>
> Test files are attached. I ran clones in /opt/ltp/testcases/bin straight.

    Good catch :). It's always fun making changes when your primary
box isn't linux anymore, dealing with VMs in a minor pain, and you
miss an important minor detail :/.
    The point of the proposed change was to remove all duplicate
macros from the LTP clone header because I noticed some were defined
twice, and over time bitrotted code tends to negatively affect tests
in the source base (in particular because someone changes one bit of
code and completely ignores/overlooks N-1 other copies of that exact
piece of duplicated code -- I've been known to do this by accident as
well)...
Thanks for testing!
-Garrett

---------------------------------------------------------------------------=
---
Virtualization is moving to the mainstream and overtaking non-virtualized
environment for deploying applications. Does it make network security =

easier or more difficult to achieve? Read this whitepaper to separate the =

two and get a better understanding.
http://p.sf.net/sfu/hp-phase2-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
