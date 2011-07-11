Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QgGK4-0002ke-8s
	for ltp-list@lists.sourceforge.net; Mon, 11 Jul 2011 13:14:52 +0000
Date: Mon, 11 Jul 2011 15:16:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110711131611.GA26246@saboteur.suse.cz>
References: <bc82b67194b388102909bc38335c42bd661c3e55.1309361232.git.czhang@redhat.com>
	<1309369833-6204-1-git-send-email-czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1309369833-6204-1-git-send-email-czhang@redhat.com>
Subject: Re: [LTP] [PATCH v4] [syscalls] getrusage03: test ru_maxrss
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> getrusage03 - test ru_maxrss behaviors in struct rusage
> 
> This test program is backported from upstream commit:
> 1f10206cf8e945220f7220a809d8bfc15c21f9a5, which fills ru_maxrss
> value in struct rusage according to rss hiwater mark. To make sure
> this feature works correctly, a series of tests are executed in
> this program.
> 
> Signed-off-by: Caspar Zhang <czhang@redhat.com>

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
