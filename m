Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uh124-0005qh-KY
	for ltp-list@lists.sourceforge.net; Mon, 27 May 2013 17:16:28 +0000
Date: Mon, 27 May 2013 19:17:40 +0200
From: chrubis@suse.cz
Message-ID: <20130527171740.GB866@rei>
References: <f9e681d1d404dd60c51ddcc12d4aefe7bb633f93.1369297122.git.jstancek@redhat.com>
	<08bd7d0a39261aa522898a80ea56bc494d6c985e.1369673996.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <08bd7d0a39261aa522898a80ea56bc494d6c985e.1369673996.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v4 2/2] waitid02: split code into separate
	testcases
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
> Previous code in main was:
> - using sleep for synchronization
>   The sleep make take longer if run in overcommitted
>   z/VM environment with considerably high steal time, which
>   causes testcase to hang.
> - missing wait for last child
> 
> This patch splits code from main() into separate testcases,
> each with its own setup/cleanup and expected outcome.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

You should have just commited this one. The change is cosmetic and the
previous version was available for reviews (on the list) long enough.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
