Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZPU6f-0000jv-Io
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2015 11:22:05 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZPU6d-0000Xy-5J
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2015 11:22:05 +0000
Date: Wed, 12 Aug 2015 13:21:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150812112135.GA32393@rei.suse.de>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
	<1436424468-11756-10-git-send-email-alexey.kodanev@oracle.com>
	<20150811181219.GB24227@rei.suse.de> <55CB2A43.8060808@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55CB2A43.8060808@oracle.com>
Subject: Re: [LTP] [PATCH 09/23] network/virt/vlan03: add new test-case
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> We can use tst_resm there and we would need to provide one more 
> parameter to determine was it PASS or FAIL (the expected result). It 
> will complicate virt_compare_netperf() a bit but still should be OK.

That sounds reasonable to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
