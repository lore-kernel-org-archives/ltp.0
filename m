Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<jbeckenbach=ltp-list=lists.sourceforge.net=jmtqtyzj@lancope.com>)
	id 1X7qOe-0001dn-Kp
	for ltp-list@lists.sourceforge.net; Thu, 17 Jul 2014 18:27:12 +0000
Received: from smtp-out3.electric.net ([72.35.12.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X7qOc-0000mH-Pg
	for ltp-list@lists.sourceforge.net; Thu, 17 Jul 2014 18:27:12 +0000
Received: from 1X7qOW-0005JO-T7 by out3c.electric.net with emc1-ok (Exim
	4.80.1) (envelope-from <jbeckenbach@lancope.com>) id 1X7qOW-0005LC-US
	for ltp-list@lists.sourceforge.net; Thu, 17 Jul 2014 11:27:04 -0700
Received: from [209.182.184.2] (helo=LCHQEX03.lancope.local)
	by out3c.electric.net with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.80.1) (envelope-from <jbeckenbach@lancope.com>)
	id 1X7qOW-0005JO-T7
	for ltp-list@lists.sourceforge.net; Thu, 17 Jul 2014 11:27:04 -0700
From: Joseph Beckenbach <jbeckenbach@lancope.com>
Date: Thu, 17 Jul 2014 18:27:02 +0000
Message-ID: <4506ACC2AE90484D87F9A883BA36C21C2ADF0001@LCHQEX03.lancope.local>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] Apparent trouble with HEAD of LTP
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

Greetings, Cyril, all!

Merely adding libtool (2.4.2) onto the system still leaves me with the munged ./configure script.

To correct this issue I did:

1:  added back '-I m4' to include/mk/automake.mk

2:  `make distclean ; rm -f configure`

3:  restarted my work at the `make autotools` step

I see no odd output or bad warnings from compilations.
`make install` is also clean, and invoking `/path/to/runltp -h` gives help output as expected.

Thanks!

Joseph
Joseph Beckenbach, senior QA engineer : Automation
x97166
M 678-602-3192


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
