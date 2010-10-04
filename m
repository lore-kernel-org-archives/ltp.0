Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hannuxx@gmail.com>) id 1P2qPm-0000bU-2w
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 19:09:34 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P2qPl-0001qo-1i
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 19:09:34 +0000
Received: by bwz2 with SMTP id 2so5466070bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 04 Oct 2010 12:09:27 -0700 (PDT)
Date: Mon, 4 Oct 2010 22:09:25 +0300
From: Hannu Heikkinen <hannuxx@iki.fi>
Message-ID: <20101004190925.GB997@debian-master.elisa-laajakaista.fi>
References: <4CA09D4D.6050708@st.com> <4CA34070.9070505@st.com>
	<20100930133120.GA4070@hannu-debian.research.nokia.com>
	<4CA469A0.5090700@st.com> <20101001040609.GA2090@hannu-ubuntu>
	<4CA9D0EB.5090309@st.com>
	<AANLkTim_Ay4yjdBfm8tzEiK_z4JzQyg6RRsR3E1tCH9h@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTim_Ay4yjdBfm8tzEiK_z4JzQyg6RRsR3E1tCH9h@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On 04/10/10 06:28 -0700, Garrett Cooper wrote:
> On Mon, Oct 4, 2010 at 6:04 AM, Carmelo AMOROSO <carmelo.amoroso@st.com> wrote:
-clip-
> >
> > Hannu,
> > I don't think that it is a good to force the alignment; we could need to
> > write a test case that calls LTP_clone with an unaligned stack just to
> > test the behavior of the clone implementation.
> >
> > Likely, it should be useful to add a check inside the C lib clone
> > implementation (arch specific) to protect against unaligned stack, but
> > this is a different matter.
> >
> > I would just leave the LTP_clone passing the argument to the clone as
> > they came from the caller.
> 
>     I believe this is already handled to some degree with the clone
> testcases. If not that should be added and I'll review patches which
> add this testing to LTP.
>     On a semi-unrelated note could you guys please test out the
> attached patch to make sure that there isn't a functional difference
> if you have access to ia64, s390, etc?
> Thanks,
> -Garrett

Hi,

Garret, I did git pull and applied your patch, gcc whined about missing
CHILD_STACK_SIZE... is it in your some other patch? IFor the time being I
added CHILD_STACK_SIZE into test.h, but is it what you wanted initially?

I can test clones for arm 32-bit (BeagleBoard/Cortex A8) and AMD64 (Debian 64-bit)
environments. Sadly I do not have SPARCs, nor s390... 

br,
Hannu

------------------------------------------------------------------------------
Virtualization is moving to the mainstream and overtaking non-virtualized
environment for deploying applications. Does it make network security 
easier or more difficult to achieve? Read this whitepaper to separate the 
two and get a better understanding.
http://p.sf.net/sfu/hp-phase2-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
