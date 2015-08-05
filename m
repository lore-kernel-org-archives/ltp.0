Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZN2WC-0005Yo-LU
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2015 17:30:20 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZN2WB-0004Ec-PO
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2015 17:30:20 +0000
Date: Wed, 5 Aug 2015 19:29:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150805172957.GB4216@rei.suse.de>
References: <55A680FC.2010807@oracle.com>
	<1437024647-2066-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<1437024647-2066-2-git-send-email-zenglg.jy@cn.fujitsu.com>
	<20150805171709.GA4216@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150805171709.GA4216@rei.suse.de>
Subject: Re: [LTP] [PATCH v5 02/11] lib6/runcc.c: Cleanup
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> First of all, I would like to ask everybody what they think about these
> testcases (testcases/network/lib6/). Quite a bit of the functionality
> there is validating that ipv6 devel headers and structures are present
> and can be compiled. This looks more like conform test suitable for
> glibc to me. Do we want to really keep these? Because they would need a
> bit more work to make them less ugly...

To be clear. I'm for dropping the ugly runcc.* interface and the
testcases that use it. That would be asapi_01.c, asapi_02.c, asapi_03,c,
half of asapi_05.c and asapi_07.c and fixing the rest of the testcases.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
