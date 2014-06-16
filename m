Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WwYBr-0002BY-BL
	for ltp-list@lists.sourceforge.net; Mon, 16 Jun 2014 14:47:19 +0000
Date: Mon, 16 Jun 2014 16:47:06 +0200
From: chrubis@suse.cz
Message-ID: <20140616144706.GA23728@rei.suse.cz>
References: <1402299431-2045-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1402299431-2045-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1402299431-2045-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 2/2] linkat/linkat02.c: cleanup
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> -	while (1) {
> -		sprintf(lname, "%s%ld", BASENAME, ++link_max);
> -		TEST(link(TEST_EMLINK, lname));
> -		if (TEST_RETURN == -1) {
> -			switch (TEST_ERRNO) {
> -			case EMLINK:
> -				tst_resm(TINFO, "for %s the max links is %ld",
> -					 fstype, link_max);
> -				break;
> -			default:
> -				tst_brkm(TBROK | TTERRNO, cleanup,
> -					 "Unexpected error: ");
> -				break;
> -			}
> -			break;
> -		}
> -	}
> -}

You have removed the code that initializes lname which broke the test
because empty string was passed to the link() call. I've fixed it and
pushed, thanks.

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
