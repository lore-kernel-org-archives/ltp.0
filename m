Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge.hallyn@canonical.com>) id 1PN3vC-00036Q-EE
	for ltp-list@lists.sourceforge.net; Mon, 29 Nov 2010 13:37:34 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PN3vB-0006nW-AG
	for ltp-list@lists.sourceforge.net; Mon, 29 Nov 2010 13:37:34 +0000
Date: Mon, 29 Nov 2010 07:37:24 -0600
From: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Message-ID: <20101129133724.GA4065@hallyn.com>
References: <AANLkTinw1Yc+QGtMuKH=xep4VGjusBdO2+mQeQhmM15K@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTinw1Yc+QGtMuKH=xep4VGjusBdO2+mQeQhmM15K@mail.gmail.com>
Subject: Re: [LTP] networkstress tests
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
To: ARJIT SHARMA <joyarjit@gmail.com>
Cc: ajay.khandelwal@st.com, hannuxx@gmail.com, ltp-list@lists.sourceforge.net

Quoting ARJIT SHARMA (joyarjit@gmail.com):
>  Hi,
> 
>       I was trying to run network stress tests on my side, but none of them
> is passing.
> 
>       it is not able to find the harware address at remote host, altough the
> settings and configurations are as required and as mentioned in README and
> INSTALL files.
> 
>       So can u please tell me that whether these stress tests are meant to
> be run on embedded boards, do they always cause problems, if u have executed
> them?

Which tests exactly are failing?  (You say network stress tests, but cc:d
me implying you meant netns netsts)  Can you send us the relevant logs?

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
