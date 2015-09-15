Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZbnYQ-0001ph-NZ
	for ltp-list@lists.sourceforge.net; Tue, 15 Sep 2015 10:33:38 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZbnYP-0006C0-LR
	for ltp-list@lists.sourceforge.net; Tue, 15 Sep 2015 10:33:38 +0000
Date: Tue, 15 Sep 2015 12:32:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150915103246.GA7077@rei.suse.cz>
References: <20150609122628.GE29057@dhcp22.suse.cz>
	<20150902132506.GA6661@rei.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150902132506.GA6661@rei.suse.cz>
Subject: Re: [LTP] ltp: thp04.c test case
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
To: Michal Hocko <mhocko@suse.cz>
Cc: ltp-list@lists.sourceforge.net, Zhouping Liu <zliu@redhat.com>, Vlastimil Babka <vbabka@suse.cz>

Hi!
> There was no response for about three months. If nobody stands up and
> fixes the testcase I would go for dropping it since it does not work
> reliably as it is.

And the test has been removed in:

https://github.com/linux-test-project/ltp/commit/19cdd120b43aa6a6a4993b61e6ef675d1cdf04b4

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
