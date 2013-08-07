Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V73Gv-0001tb-Eb
	for ltp-list@lists.sourceforge.net; Wed, 07 Aug 2013 12:55:25 +0000
Date: Wed, 7 Aug 2013 14:55:22 +0200
From: chrubis@suse.cz
Message-ID: <20130807125522.GC4761@rei>
References: <20130807102427.GA4389@rei>
	<1375874575-29198-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130807121028.GB4761@rei> <52023F30.9000401@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52023F30.9000401@oracle.com>
Subject: Re: [LTP] [PATCH] tst_run_cmd: const correctness
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, alexey.kodanev@oracle.com

Hi!
> > I'm trying to figure out how to fix it 'right' but it gets unnecessary
> > complicated. I guess that we can fix this patch by casting the array in
> > the lib before it gets to execvp().
> I think that casting mod_name to (char *) is easier than casting array 
> before it gets to execvp(). And it doesn't require
> any changes of tst_run_cmd interfaces (ie they accepts argv the same way 
> as execvp does)...
> 
> Maybe leave everything as is and just cast mod_name to (char *)?

That is easier for one testcase, but will require the cast in each
testcase that will use the interface. From this point of view cast in
the library is better. Not elegant solution though. :(

But in the end any of the solutions will work...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
