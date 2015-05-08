Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1Yqrnq-0005NE-EL
	for ltp-list@lists.sourceforge.net; Fri, 08 May 2015 23:35:34 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yqrnp-0001Mh-F2
	for ltp-list@lists.sourceforge.net; Fri, 08 May 2015 23:35:34 +0000
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Fri, 8 May 2015 17:35:27 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
	(b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 1D5771FF001E
	for <ltp-list@lists.sourceforge.net>;
	Fri,  8 May 2015 17:26:37 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id t48NZQ5u33292362
	for <ltp-list@lists.sourceforge.net>; Fri, 8 May 2015 16:35:26 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP
	id t48NZQ5W018077
	for <ltp-list@lists.sourceforge.net>; Fri, 8 May 2015 17:35:26 -0600
Received: from localhost.localdomain ([9.76.183.128])
	by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	t48NZPuL018057
	for <ltp-list@lists.sourceforge.net>; Fri, 8 May 2015 17:35:26 -0600
Date: Fri, 8 May 2015 09:41:28 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20150508014128.GD2752@localhost.localdomain>
References: <20150504063425.GA9995@localhost.localdomain>
	<20150504115324.GB7674@rei.suse.de>
	<20150506135504.GC2752@localhost.localdomain>
	<20150507124831.GA28637@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150507124831.GA28637@rei.suse.de>
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

On Thu, May 07, 2015 at 02:48:31PM +0200, Cyril Hrubis wrote:
> Hi!
> > Thanks. I have revised the patch according to your suggestions.
> 
> Pushed with following modifications, thanks.
> 
> * The device preparation must be done only once in setup()
>   otherwise the testcase fails with -i 2
> 
> * The testcase was previously working fine when executed as
>   non-root user, I've made some changes so that this continues
>   to work as well
> 
Thanks!


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
