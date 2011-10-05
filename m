Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RBQvD-0005vS-Mm
	for ltp-list@lists.sourceforge.net; Wed, 05 Oct 2011 12:50:03 +0000
Date: Wed, 5 Oct 2011 14:52:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111005125258.GB26968@saboteur.suse.cz>
References: <CAHJT+nqA2mti+vZ5F16Rdu0EvJtuZMBYTmuOaVa_X9LxXwC4sA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHJT+nqA2mti+vZ5F16Rdu0EvJtuZMBYTmuOaVa_X9LxXwC4sA@mail.gmail.com>
Subject: Re: [LTP] About the test tools for Mac OS X
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
To: "flost.Dexiong Li" <flost.d.li@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Is there any plan for migrating the LTP project to some Unix system like Mac
> OS X?

Well, there is Open Posix Testsuite which was developed both on Linux
and BSD (and test that is broken on POSIX compilant system is considered
buggy). The rest of LTP is more or less linux centric, some parts may
work, some would need a little effort and some are testing linux
specific parts and thuss are unportable.

Being you, I would start with the Open Posix Testsuite.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
