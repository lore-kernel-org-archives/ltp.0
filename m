Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QjwLH-00085c-1w
	for ltp-list@lists.sourceforge.net; Thu, 21 Jul 2011 16:43:19 +0000
Date: Thu, 21 Jul 2011 18:45:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110721164530.GA6809@saboteur.suse.cz>
References: <4E257897.1080707@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E257897.1080707@redhat.com>
Subject: Re: [LTP] [PATCH v2] cgroups/cgroup_regression_test: fix sporadic
 failures
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
> This patch fixes some failures caused by missing cleanup,
> leaving groups behind after some stress tests.
> Some stress tests failed to complete upon receiving SIGUSR1.
> 
> 1. dmesg can rotate and number of found bugs can actually go down
> clear the buffer before test to avoid this
> 
> 2. test_5: test should mount 2 subsystems, but mount command
> says "$subsys" instead of "$subsys2"
> 
> 3. test_6: test may leave groups behind, fix rmdir
> to match test_6_1.sh
> 
> 4. test_7_2: mounts whole cgroup not $subsys
> 
> 5. test_10: can leave cgroups umounted before cleanup
> make sure cgroups are mounted before doing cleanup
> 
> 6. test_*.sh scripts use trap in loop, which may cause bash
> to miss signal, see
> https://bugzilla.redhat.com/show_bug.cgi?id=695656
> move trap outside loop to avoid it

I know these are mostly trivial changes, but even that could you split
them into several patches (they are easier to review, revert if
needed...)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
5 Ways to Improve & Secure Unified Communications
Unified Communications promises greater efficiencies for business. UC can 
improve internal communications as well as offer faster, more efficient ways
to interact with customers and streamline customer service. Learn more!
http://www.accelacomm.com/jaw/sfnl/114/51426253/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
