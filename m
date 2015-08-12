Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZPUQM-0003UC-OD
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2015 11:42:26 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZPUQK-0005ua-KO
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2015 11:42:26 +0000
Date: Wed, 12 Aug 2015 13:41:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150812114157.GB32393@rei.suse.de>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
	<1436424468-11756-17-git-send-email-alexey.kodanev@oracle.com>
	<20150811182127.GC24227@rei.suse.de> <55CB2DA3.1050706@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55CB2DA3.1050706@oracle.com>
Subject: Re: [LTP] [PATCH 16/23] network/virt: add macvtap01 test
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
> What I have in mind here is to perform add/delete test-case with 
> different parameters, in this case different modes. So the total steps 
> are the same but if option is supported, use it on some steps, otherwise 
> proceed without it. May be the message should be changed to something like:
> 
> tst_resm TINFO "'$m' mode not supported by iproute/kernel, use default"
                                                              ^
							      using


But when we do that the testing would be slower for no additional value
on systems that does not support these options. I guess I can live with
that, but I don't like it.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
