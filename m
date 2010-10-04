Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hannuxx@gmail.com>) id 1P2qMN-0000LS-GI
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 19:06:03 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P2qML-0003kG-5u
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 19:06:03 +0000
Received: by bwz2 with SMTP id 2so5461132bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 04 Oct 2010 12:05:55 -0700 (PDT)
Date: Mon, 4 Oct 2010 22:05:52 +0300
From: Hannu Heikkinen <hannuxx@iki.fi>
Message-ID: <20101004190552.GA997@debian-master.elisa-laajakaista.fi>
References: <4CA09D4D.6050708@st.com> <4CA34070.9070505@st.com>
	<20100930133120.GA4070@hannu-debian.research.nokia.com>
	<4CA469A0.5090700@st.com> <20101001040609.GA2090@hannu-ubuntu>
	<4CA9D0EB.5090309@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CA9D0EB.5090309@st.com>
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
To: Carmelo AMOROSO <carmelo.amoroso@st.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On 04/10/10 15:04 +0200, Carmelo AMOROSO wrote:
-clip-
> 
> Hannu,
> I don't think that it is a good to force the alignment; we could need to
> write a test case that calls LTP_clone with an unaligned stack just to
> test the behavior of the clone implementation.
> 
> Likely, it should be useful to add a check inside the C lib clone
> implementation (arch specific) to protect against unaligned stack, but
> this is a different matter.
> 
> I would just leave the LTP_clone passing the argument to the clone as
> they came from the caller.
> 
> Regards,
> Carmelo
> 

Hi Carmelo,

you've got point, yes. I was just so worried about the fact that in ARM
architectures that previous eg clone02 failed due to alignment errors.
But your fix of course fixed that issue, and it gives as a possiblity
to make test case against alignment issues, quite right. 

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
