Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <carmelo.amoroso@st.com>) id 1PHtXy-0003jy-TZ
	for ltp-list@lists.sourceforge.net; Mon, 15 Nov 2010 07:32:14 +0000
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115])
	by sog-mx-4.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PHtXu-0008ER-Gu
	for ltp-list@lists.sourceforge.net; Mon, 15 Nov 2010 07:32:14 +0000
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Mon, 15 Nov 2010 08:29:17 +0100
Message-ID: <4CE0E14D.6010306@st.com>
References: <4CA09D4D.6050708@st.com>	<4CA34070.9070505@st.com>
	<20100930133120.GA4070@hannu-debian.research.nokia.com>
	<4CA469A0.5090700@st.com>	<20101001040609.GA2090@hannu-ubuntu>
	<4CA9D0EB.5090309@st.com>
	<20101004190552.GA997@debian-master.elisa-laajakaista.fi>
	<4CD92F6B.9040508@st.com>
	<1289462230.5622.40.camel@subratamodak.linux.ibm.com>
	<4CDBA487.7080507@st.com>
	<AANLkTi=Y-z0WFb6Nkr6zr650urxoQOPo3ohw+e+YZueJ@mail.gmail.com>
In-Reply-To: <AANLkTi=Y-z0WFb6Nkr6zr650urxoQOPo3ohw+e+YZueJ@mail.gmail.com>
MIME-Version: 1.0
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/11/2010 10:59 AM, Garrett Cooper wrote:
> On Thu, Nov 11, 2010 at 12:08 AM, Carmelo AMOROSO
> <carmelo.amoroso@st.com> wrote:
>  > -----BEGIN PGP SIGNED MESSAGE-----
>  > Hash: SHA1
>  >
>  > On 11/11/2010 8:57 AM, Subrata Modak wrote:
>  >> On Tue, 2010-11-09 at 12:24 +0100, Carmelo AMOROSO wrote:
>  >> On 10/4/2010 9:05 PM, Hannu Heikkinen wrote:
>  >>> On 04/10/10 15:04 +0200, Carmelo AMOROSO wrote:
>  >>> -clip-
>  >>> >
>  >>> > Hannu,
>  >>> > I don't think that it is a good to force the alignment; we could need to
>  >>> > write a test case that calls LTP_clone with an unaligned stack just to
>  >>> > test the behavior of the clone implementation.
>  >>> >
>  >>> > Likely, it should be useful to add a check inside the C lib clone
>  >>> > implementation (arch specific) to protect against unaligned stack, but
>  >>> > this is a different matter.
>  >>> >
>  >>> > I would just leave the LTP_clone passing the argument to the clone as
>  >>> > they came from the caller.
>  >>> >
>  >>> > Regards,
>  >>> > Carmelo
>  >>> >
>  >>
>  >>> Hi Carmelo,
>  >>
>  >>> you've got point, yes. I was just so worried about the fact that in ARM
>  >>> architectures that previous eg clone02 failed due to alignment errors.
>  >>> But your fix of course fixed that issue, and it gives as a possiblity
>  >>> to make test case against alignment issues, quite right.
>  >>
>  >>> br,
>  >>> Hannu
>  >>
>  >>
>  >> Folks,
>  >> any change to get this included for the next release ?
>  >>
>  >>> Did we miss any patch here ?
>  >>
>  >
>  > I think so: this one
>  > 
> http://sourceforge.net/mailarchive/forum.php?thread_name=4CA09D4D.6050708%40st.com&forum_name=ltp-list 
> <http://sourceforge.net/mailarchive/forum.php?thread_name=4CA09D4D.6050708%40st.com&forum_name=ltp-list>
> 
> Is the above patch endian agnostic?
> 

Yes, definitely. The patch just removed an wrong manipulation of the
stack arguments for all the archs.

Carmelo

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkzg4UwACgkQoRq/3BrK1s+HEwCfWmFi6vBpxB6V1JQMEWyYy7z+
KbkAn3LcNtU+a/6RCfAOvr3Q/xFGrJrt
=dQgU
-----END PGP SIGNATURE-----

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
