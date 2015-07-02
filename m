Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZAcu1-0003LQ-RM
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 11:43:37 +0000
Date: Thu, 2 Jul 2015 13:42:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150702114215.GA16269@rei.suse.de>
References: <1431958682-15683-1-git-send-email-chase.qi@linaro.org>
	<555A8744.5050300@cn.fujitsu.com>
	<1435829214.19361.4.camel@G08FNSTD140232.g08.fujitsu.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1435829214.19361.4.camel@G08FNSTD140232.g08.fujitsu.local>
Subject: Re: [LTP] [PATCH] cpuhotplug05.sh: Make test to support some old
 version of 'sar'
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>, naresh.kamboju@linaro.org, milosz.wasilewski@linaro.org

Hi!
> In commit 841c0eebc50068d6595b97b50ae0ee8e8f57c8ca:
> We changed "sar 1 0" to "sar 1", but it make the test not
> work well before 'sysstat-8.1.4(include sar)'.

The old syntax does not work with newer sar. So the correct fix here is
to do runtime check and change parameters accordingly.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
