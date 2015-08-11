Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZP50X-0005Fe-2H
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 08:34:05 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZP50U-0006fo-UD
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 08:34:05 +0000
Date: Tue, 11 Aug 2015 10:33:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150811083334.GB12940@rei.suse.de>
References: <1438923308-5194-1-git-send-email-sunyuan3@huawei.com>
	<10491102.7385545.1439280346874.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10491102.7385545.1439280346874.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH V2] container: new testcase pidns32
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Hi,
> 
> I'm still not entirely convinced about this test.

So am I. What about checking that we can do at least MAXNEST levels?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
