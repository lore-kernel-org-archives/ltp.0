Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WuknN-0006mY-BG
	for ltp-list@lists.sourceforge.net; Wed, 11 Jun 2014 15:50:37 +0000
Date: Wed, 11 Jun 2014 17:50:26 +0200
From: chrubis@suse.cz
Message-ID: <20140611155026.GA15614@rei.suse.cz>
References: <1401875007-27025-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401875007-27025-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] truncate/truncate03.c: cleanup
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Merge truncate03, truncate04 into truncate03 test.
> Delete some useless comments.
> Use some SAFE_* macros.
> Move the test body from main() to truncate_verify().

Pushed with minor changes, thanks.

> +static char High_address_node[64];

I've removed this array, because it is not uses for anything.

> +char Longpathname[PATH_MAX + 2];

I've changed this identifier not to be in MixedCase.

> +	SAFE_TOUCH(cleanup, TEST_FILE1, FILE_MODE, NULL);
> +	SAFE_CHMOD(cleanup, TEST_FILE1, NEW_MODE);

And these two were replaced by single:

SAFE_TOUCH(cleanup, TEST_FILE1, NEW_MODE, NULL);

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
