Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z1zzw-0004q5-OY
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2015 16:34:04 +0000
Date: Mon, 8 Jun 2015 18:33:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150608163300.GC16394@rei.suse.de>
References: <1433751383-32596-1-git-send-email-ramya@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1433751383-32596-1-git-send-email-ramya@linux.vnet.ibm.com>
Subject: Re: [LTP] [PATCH] Clean up issue
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
To: ramya@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> Description:
> when we run the script for the first time, all the test will run successfully and PASS .
> but on the same machine if we run the same script for the 2nd time we see TBROK .

The testcase should clean up after it's exit, so rather than hacking
around broken test cleanup we should fix the test to remove all temp
files it has created.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
