Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QgGqd-0004bd-GJ
	for ltp-list@lists.sourceforge.net; Mon, 11 Jul 2011 13:48:31 +0000
Date: Mon, 11 Jul 2011 15:49:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110711134951.GB26246@saboteur.suse.cz>
References: <4DEE3388.5010307@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4DEE3388.5010307@redhat.com>
Subject: Re: [LTP] [PATCH v2] cgroups/cpuacct_setup: fix task_kill() search
 for process
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
> 
> 1. "i* in "grep cpuacct_taski*" seems pointless as
> its target is cpuacct_task01
> 
> 2. using cut fails when ps indents the output as following:
>   99 cpuacct_task01
>  112 cpuacct_task01
> 1111 cpuacct_task01
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

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
