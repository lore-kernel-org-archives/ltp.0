Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YuFrs-0007tO-Vf
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2015 07:53:44 +0000
Date: Mon, 18 May 2015 09:53:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150518075301.GB2044@rei>
References: <56cb7d597d907a2e7168d912f3abf4fafce2fea1.1431615152.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56cb7d597d907a2e7168d912f3abf4fafce2fea1.1431615152.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] sigtimedwait: use gtod instead of time
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
> Quoting https://lkml.org/lkml/2015/2/19/384
>   "The idea that time() would be ok as being HZ granular, and its
>   been this way since 2.6.23.  Thus you have a < HZ sized window
>   where gettimeofday() will return the next second before time()
>   gets updated by the tick."

Looks good.

Using clock_gettime() with monotonic clock would be even better but for
that we would have to create an abstract time measuring interface that
falls back to gettimeofday() if timers could not be used...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
