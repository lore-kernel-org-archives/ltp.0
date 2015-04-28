Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Yn9Fw-0000iS-1i
	for ltp-list@lists.sourceforge.net; Tue, 28 Apr 2015 17:25:12 +0000
Date: Tue, 28 Apr 2015 19:24:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150428172442.GB25152@rei>
References: <1427787975-10668-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<551AB4B5.4020902@oracle.com> <551B4C2F.3040108@cn.fujitsu.com>
	<551B9B15.10302@oracle.com> <552CDCB0.90904@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <552CDCB0.90904@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/6] lib6/runcc.c: use TCONF instead of TBROK when
 no C compiler is present
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
To: "gux.fnst" <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > So, there is temp test directory... you could pass some cleanup function to tst_brkm().
> 
> Here we only remove the "filename" file, so I think it is not necessary to
> create a cleanup function for this operation.`

The point here is that this way the execution path would be clear. Just
now the function returns -1 which gets ignored in the end.

So exiting the code execution with TCONF here and changing the functions
to void would make it much easier to read.

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
