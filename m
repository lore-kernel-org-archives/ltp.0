Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <carmelo.amoroso@st.com>) id 1P0woY-0000CI-Td
	for ltp-list@lists.sourceforge.net; Wed, 29 Sep 2010 13:35:18 +0000
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113])
	by sog-mx-2.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P0woU-0000fG-Gn
	for ltp-list@lists.sourceforge.net; Wed, 29 Sep 2010 13:35:18 +0000
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.80.115])
	by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id CCFD211E
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Sep 2010 13:31:40 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas3.st.com [10.75.90.18])
	by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id 777AF526
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Sep 2010 13:34:56 +0000 (GMT)
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Wed, 29 Sep 2010 15:34:40 +0200
Message-ID: <4CA34070.9070505@st.com>
References: <4CA09D4D.6050708@st.com>
In-Reply-To: <4CA09D4D.6050708@st.com>
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 9/27/2010 3:34 PM, Carmelo AMOROSO wrote:
> Folks,
> I want to reopen an old discussion on ltp_clone and stack alignment
> issue (see
> http://sourceforge.net/mailarchive/message.php?msg_name=4B421480.1040400%40petalogix.com).
> Indeed recently a commit has partially fixed a problem on ARM
> (0056e395170eb8fc3ffbb22d7bd364fe47c2013e), but I think this should be
> extended to all archs that have stack that grows downwards.
> 
> Indeed, as Jiri replied in that old thread, the value passed to clone as
> child stack should be never accessed, because it is the topmost address
> of the memory allocated for the child process (it's the previous stack
> pointer).
> 
> So, in archs that do not like unaligned stack, using (stack - size - 1 )
> will cause the process to be killed by a SIGBUS, on other archs, we are
> just wasting one byte of the malloc-ed stack.
> 
> On my SH4 arch, the stack must be 4byte aligned (as in ARM).
> 
> Please, find attached a patch against master branch
> 
> Best regards,
> Carmelo

Hi,
any feedback on this ?

Cheers,
Carmelo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkyjQHAACgkQoRq/3BrK1s9mRQCfYVc9ePJRwf5hd6NRvjtjHsLO
sxYAoMj83bu0I4cvU+iEUpH4iXGuBJTD
=s2GZ
-----END PGP SIGNATURE-----

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
