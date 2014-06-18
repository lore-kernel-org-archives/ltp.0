Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WxIFt-0003eJ-D1
	for ltp-list@lists.sourceforge.net; Wed, 18 Jun 2014 15:58:33 +0000
Date: Wed, 18 Jun 2014 17:58:19 +0200
From: chrubis@suse.cz
Message-ID: <20140618155819.GC4466@rei>
References: <1402624697.2098.8.camel@G08JYZSD130126>
	<1183733259.23953127.1402660578711.JavaMail.zimbra@redhat.com>
	<1402972112.2294.26.camel@G08JYZSD130126>
	<20140617111120.GA31854@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140617111120.GA31854@rei>
Subject: Re: [LTP] [PATCH 1/3] syscalls: fix returning TCONF without device
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> I was thinking of adding a function that would either get the LTP_DEV
> env variable or create a loop0 device if LTP_DEV is not set and will
> format it with LTP_DEV_FS_TYPE or a default passed value and it's
> counter part that does the cleanup.

I've pushed the function implementation + documentation in
test-writing-guidelines. Have a look if you are interested.

It turned out to be a bit more challenging than I expected because the
loop ioctls() and are poorly documented...

The next step would rewriting all testcases that gets the device as
parameters to use the new interface. I will have a look at these
tomorrow.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
