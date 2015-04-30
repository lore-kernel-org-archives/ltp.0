Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YniUY-0002wC-44
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 07:02:38 +0000
Date: Thu, 30 Apr 2015 09:02:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150430070207.GB479@rei.suse.de>
References: <1429839868-2011-1-git-send-email-cuibixuan@huawei.com>
	<20150427142307.GC10567@rei.suse.de> <55418B02.3080104@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55418B02.3080104@huawei.com>
Subject: Re: [LTP] [PATCH v3] mv/mv_tests.sh: Add test02 to test 'mv -b'
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: ltp-list@lists.sourceforge.net, zhanyongming@huawei.com, zhuyanpeng@huawei.com

Hi!
> >>  # Function:		main
> >>  #
> >> @@ -258,6 +333,15 @@ then
> >>  	TFAILCNT=$(($TFAILCNT+1))
> >>  fi
> >>  
> >> +rm -fr $LTPTMP/tst_mv.*
> > 
> > We have tst_tmpdir() and tst_rmdir() to simplify this.
> > 
> The case does not use test.sh library and can't call tst_tmpdir() there.
> The mv_test.sh was written long before.Maybe I should modity it by using
> test.sh library, what do you think?

Yes please. We usually fix testcases before we add new functionality.

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
