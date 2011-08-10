Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Qr9Hm-0005MY-NE
	for ltp-list@lists.sourceforge.net; Wed, 10 Aug 2011 13:57:30 +0000
Date: Wed, 10 Aug 2011 15:44:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110810134430.GC8687@saboteur.suse.cz>
References: <260174ADA4D63F4AA543B9C81F2DE71214C7EA@POCITMSEXMB02.LntUniverse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <260174ADA4D63F4AA543B9C81F2DE71214C7EA@POCITMSEXMB02.LntUniverse.com>
Subject: Re: [LTP] How to add new test case in LTP
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
To: G Rajender <G.Rajender@lnties.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> Thank you very much for your reply.
> 
> I need to add new test cases in LTP to test my kernel running on beagleboard (arm cortex-a8 based dev. Board)
> 
> Can you please suggest me  how to add new sample test case in LTP (initially for my testing only).

There are some howtos packed with ltp in doc directory especially how to
use buildsystem and test interface. Adding the test to testrun is a
matter of adding it into the runtest files (see files in runtest
directory).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
