Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZExHq-0002sd-T1
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2015 10:18:06 +0000
Date: Tue, 14 Jul 2015 12:16:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150714101634.GF3729@rei.suse.de>
References: <CANKSX+HUUC3aT+Pt-o=oqC1XismF-ErK8Ws79SAxKCOWE1g96w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANKSX+HUUC3aT+Pt-o=oqC1XismF-ErK8Ws79SAxKCOWE1g96w@mail.gmail.com>
Subject: Re: [LTP] Reg IO sched tests
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
To: "$rik@nth " <srikanth007m@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Is there any testsuite available to test IO Schedulers extensively? Any
> pointers would really helpful.

There are some IO stress testcases testcases/io and testcases/fs these
are mostly executed from runtest/ltp-aio* runtest files.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
