Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VC8f2-0006j2-W2
	for ltp-list@lists.sourceforge.net; Wed, 21 Aug 2013 13:41:21 +0000
Date: Wed, 21 Aug 2013 15:41:21 +0200
From: chrubis@suse.cz
Message-ID: <20130821134121.GA4729@rei>
References: <b02ceb0270268de40055e69232d12c3a3422f7f4.1376919310.git.jstancek@redhat.com>
	<20130821102436.GA3894@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130821102436.GA3894@rei>
Subject: Re: [LTP] [PATCH/RFC] aiodio: make read_sparse use same mode as
 writers
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> The README in the testcases directory says that the tests explicitly
> tests for consistency between buffered I/O and O_DIRECT.
> 
> I will consult some kernel guys if this was ever supported and we will
> either remove the tests or try to find a bug in the kernel.

I've looked at the test and what it does is:

1. create file and make sure it's empty
2. truncate it to defined size
3. parent starts writing zeroes to it with O_DIRECT
4. childs reads it and expect to get zeroes at any time

This should really work and I've been told by our filesystem guy that
this really looks like bug in the kernel (assuming that I haven't
overlooked something in the test source).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
