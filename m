Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PGTwl-0002lM-61
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 09:59:59 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PGTwk-0006Bv-7z
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 09:59:59 +0000
Received: by wwe15 with SMTP id 15so935068wwe.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Nov 2010 01:59:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4CDBA487.7080507@st.com>
References: <4CA09D4D.6050708@st.com> <4CA34070.9070505@st.com>
	<20100930133120.GA4070@hannu-debian.research.nokia.com>
	<4CA469A0.5090700@st.com> <20101001040609.GA2090@hannu-ubuntu>
	<4CA9D0EB.5090309@st.com>
	<20101004190552.GA997@debian-master.elisa-laajakaista.fi>
	<4CD92F6B.9040508@st.com>
	<1289462230.5622.40.camel@subratamodak.linux.ibm.com>
	<4CDBA487.7080507@st.com>
Date: Thu, 11 Nov 2010 01:59:51 -0800
Message-ID: <AANLkTi=Y-z0WFb6Nkr6zr650urxoQOPo3ohw+e+YZueJ@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Carmelo AMOROSO <carmelo.amoroso@st.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Thu, Nov 11, 2010 at 12:08 AM, Carmelo AMOROSO
<carmelo.amoroso@st.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 11/11/2010 8:57 AM, Subrata Modak wrote:
>> On Tue, 2010-11-09 at 12:24 +0100, Carmelo AMOROSO wrote:
>> On 10/4/2010 9:05 PM, Hannu Heikkinen wrote:
>>> On 04/10/10 15:04 +0200, Carmelo AMOROSO wrote:
>>> -clip-
>>> >
>>> > Hannu,
>>> > I don't think that it is a good to force the alignment; we could need to
>>> > write a test case that calls LTP_clone with an unaligned stack just to
>>> > test the behavior of the clone implementation.
>>> >
>>> > Likely, it should be useful to add a check inside the C lib clone
>>> > implementation (arch specific) to protect against unaligned stack, but
>>> > this is a different matter.
>>> >
>>> > I would just leave the LTP_clone passing the argument to the clone as
>>> > they came from the caller.
>>> >
>>> > Regards,
>>> > Carmelo
>>> >
>>
>>> Hi Carmelo,
>>
>>> you've got point, yes. I was just so worried about the fact that in ARM
>>> architectures that previous eg clone02 failed due to alignment errors.
>>> But your fix of course fixed that issue, and it gives as a possiblity
>>> to make test case against alignment issues, quite right.
>>
>>> br,
>>> Hannu
>>
>>
>> Folks,
>> any change to get this included for the next release ?
>>
>>> Did we miss any patch here ?
>>
>
> I think so: this one
> http://sourceforge.net/mailarchive/forum.php?thread_name=4CA09D4D.6050708%40st.com&forum_name=ltp-list

Is the above patch endian agnostic?

------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
