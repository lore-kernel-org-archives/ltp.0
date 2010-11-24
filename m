Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <carmelo.amoroso@st.com>) id 1PLAlq-0007xR-OT
	for ltp-list@lists.sourceforge.net; Wed, 24 Nov 2010 08:32:06 +0000
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129])
	by sog-mx-4.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PLAlp-0001Zq-2c
	for ltp-list@lists.sourceforge.net; Wed, 24 Nov 2010 08:32:06 +0000
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Wed, 24 Nov 2010 09:30:47 +0100
Message-ID: <4CECCD37.70900@st.com>
References: <4CA09D4D.6050708@st.com>	<4CA34070.9070505@st.com>
	<20100930133120.GA4070@hannu-debian.research.nokia.com>
	<4CA469A0.5090700@st.com>	<20101001040609.GA2090@hannu-ubuntu>
	<4CA9D0EB.5090309@st.com>
	<20101004190552.GA997@debian-master.elisa-laajakaista.fi>
	<4CD92F6B.9040508@st.com>
	<1289462230.5622.40.camel@subratamodak.linux.ibm.com>
	<4CDBA487.7080507@st.com>
	<AANLkTi=Y-z0WFb6Nkr6zr650urxoQOPo3ohw+e+YZueJ@mail.gmail.com>
	<4CE0E14D.6010306@st.com>
	<AANLkTi=B8pSuAH3EjJK47wN9P_Y2Z1F88Wzqn0Y7aJ9f@mail.gmail.com>
In-Reply-To: <AANLkTi=B8pSuAH3EjJK47wN9P_Y2Z1F88Wzqn0Y7aJ9f@mail.gmail.com>
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

On 11/21/2010 4:34 AM, Garrett Cooper wrote:
> On Sun, Nov 14, 2010 at 11:29 PM, Carmelo AMOROSO
> <carmelo.amoroso@st.com> wrote:
>  > -----BEGIN PGP SIGNED MESSAGE-----
>  > Hash: SHA1
>  >
>  > On 11/11/2010 10:59 AM, Garrett Cooper wrote:
>  >> On Thu, Nov 11, 2010 at 12:08 AM, Carmelo AMOROSO
>  >> <carmelo.amoroso@st.com> wrote:
>  >> > -----BEGIN PGP SIGNED MESSAGE-----
>  >> > Hash: SHA1
>  >> >
>  >> > On 11/11/2010 8:57 AM, Subrata Modak wrote:
>  >> >> On Tue, 2010-11-09 at 12:24 +0100, Carmelo AMOROSO wrote:
>  >> >> On 10/4/2010 9:05 PM, Hannu Heikkinen wrote:
>  >> >>> On 04/10/10 15:04 +0200, Carmelo AMOROSO wrote:
>  >> >>> -clip-
>  >> >>> >
>  >> >>> > Hannu,
>  >> >>> > I don't think that it is a good to force the alignment; we could need to
>  >> >>> > write a test case that calls LTP_clone with an unaligned stack just to
>  >> >>> > test the behavior of the clone implementation.
>  >> >>> >
>  >> >>> > Likely, it should be useful to add a check inside the C lib clone
>  >> >>> > implementation (arch specific) to protect against unaligned stack, but
>  >> >>> > this is a different matter.
>  >> >>> >
>  >> >>> > I would just leave the LTP_clone passing the argument to the clone as
>  >> >>> > they came from the caller.
>  >> >>> >
>  >> >>> > Regards,
>  >> >>> > Carmelo
>  >> >>> >
>  >> >>
>  >> >>> Hi Carmelo,
>  >> >>
>  >> >>> you've got point, yes. I was just so worried about the fact that in ARM
>  >> >>> architectures that previous eg clone02 failed due to alignment errors.
>  >> >>> But your fix of course fixed that issue, and it gives as a possiblity
>  >> >>> to make test case against alignment issues, quite right.
>  >> >>
>  >> >>> br,
>  >> >>> Hannu
>  >> >>
>  >> >>
>  >> >> Folks,
>  >> >> any change to get this included for the next release ?
>  >> >>
>  >> >>> Did we miss any patch here ?
>  >> >>
>  >> >
>  >> > I think so: this one
>  >> >
>  >> 
> http://sourceforge.net/mailarchive/forum.php?thread_name=4CA09D4D.6050708%40st.com&forum_name=ltp-list 
> <http://sourceforge.net/mailarchive/forum.php?thread_name=4CA09D4D.6050708%40st.com&forum_name=ltp-list>
>  >> 
> <http://sourceforge.net/mailarchive/forum.php?thread_name=4CA09D4D.6050708%40st.com&forum_name=ltp-list 
> <http://sourceforge.net/mailarchive/forum.php?thread_name=4CA09D4D.6050708%40st.com&forum_name=ltp-list>>
>  >>
>  >> Is the above patch endian agnostic?
>  >>
>  >
>  > Yes, definitely. The patch just removed an wrong manipulation of the
>  > stack arguments for all the archs.
> 
> I'm going to test it in just a bit, but please let me know if you
> run into any issues.

No issues.

Carmelo
> Thanks,
> -Garrett
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkzszTcACgkQoRq/3BrK1s97UQCeJEiAisHHlmqwNuaNGhXZuVAJ
ercAoL9ysW+cGly5vDI3c7cy7o2SGni1
=teZB
-----END PGP SIGNATURE-----

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
