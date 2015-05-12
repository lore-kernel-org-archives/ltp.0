Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ys6FV-0001BC-Cu
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 09:13:13 +0000
Date: Tue, 12 May 2015 11:12:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150512091235.GA3562@rei.suse.de>
References: <1430907502-30493-1-git-send-email-weijg.fnst@cn.fujitsu.com>
	<1430907502-30493-3-git-send-email-weijg.fnst@cn.fujitsu.com>
	<554B7127.7000606@oracle.com> <1431067342.1760.10.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1431067342.1760.10.camel@localhost>
Subject: Re: [LTP] [PATCH 3/3] kernel/mem/mmapstress: fix resource leak
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
To: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> There's no cleanup function for SAFE_CLOSE(). so,
> close() is the same as SAFE_CLOSE(NULL, fd).

FYI, there is a difference between plain close() and
SAFE_CLOSE(NULL, fd). The latter checks the return value
from close(). Have a look at lib/safe_macros.c.

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
