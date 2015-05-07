Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YqLEg-00075K-EH
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 12:49:06 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id ED70DACC2
	for <ltp-list@lists.sourceforge.net>;
	Thu,  7 May 2015 12:48:57 +0000 (UTC)
Date: Thu, 7 May 2015 14:48:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150507124831.GA28637@rei.suse.de>
References: <20150504063425.GA9995@localhost.localdomain>
	<20150504115324.GB7674@rei.suse.de>
	<20150506135504.GC2752@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150506135504.GC2752@localhost.localdomain>
Subject: Re: [LTP] [PATCH] performing test on loop device if noatime or
 relatime specified
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
To: ltp-list@lists.sourceforge.net

Hi!
> Thanks. I have revised the patch according to your suggestions.

Pushed with following modifications, thanks.

* The device preparation must be done only once in setup()
  otherwise the testcase fails with -i 2

* The testcase was previously working fine when executed as
  non-root user, I've made some changes so that this continues
  to work as well

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
