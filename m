Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RQh00-0002Bx-8r
	for ltp-list@lists.sourceforge.net; Wed, 16 Nov 2011 15:02:04 +0000
Date: Wed, 16 Nov 2011 16:08:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111116150841.GA1675@saboteur.suse.cz>
References: <1315992503-14385-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<4EB0E46D.6070108@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EB0E46D.6070108@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] pthread_create:remove the pointless testcase
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Hi Cyril:
> 
> Any comments for this?

Acked and commited (And you should change coverage rather than
assertions next time. I've fixed that this time.)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
