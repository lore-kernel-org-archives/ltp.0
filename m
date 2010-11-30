Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge.hallyn@canonical.com>) id 1PNQZ2-0006ID-Mu
	for ltp-list@lists.sourceforge.net; Tue, 30 Nov 2010 13:48:12 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PNQZ1-0005wM-Qw
	for ltp-list@lists.sourceforge.net; Tue, 30 Nov 2010 13:48:12 +0000
Date: Tue, 30 Nov 2010 07:48:03 -0600
From: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Message-ID: <20101130134802.GA2845@hallyn.com>
References: <AANLkTinw1Yc+QGtMuKH=xep4VGjusBdO2+mQeQhmM15K@mail.gmail.com>
	<20101129133724.GA4065@hallyn.com>
	<AANLkTimLXaH_mRJ7xxfj93RJt6wPEcheC3Mg6nONkSq4@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTimLXaH_mRJ7xxfj93RJt6wPEcheC3Mg6nONkSq4@mail.gmail.com>
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
Cc: ajay.khandelwal@st.com, ltp-list@lists.sourceforge.net

Quoting ARJIT SHARMA (joyarjit@gmail.com):
> broken_ip4-version01    0  TINFO  :  - Test duration is 3600 [sec]
> cut: option requires an argument -- 'f'
> Try `cut --help' for more information.

What distribution are you using?  Looks like the tests will need to
be tweaked to accomodate your version of cut.  Can you send us the
output of your 'cut --help'?  :)

-serge

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
