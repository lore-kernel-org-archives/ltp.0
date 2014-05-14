Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WkZLO-0003ye-2J
	for ltp-list@lists.sourceforge.net; Wed, 14 May 2014 13:35:38 +0000
Date: Wed, 14 May 2014 15:35:28 +0200
From: chrubis@suse.cz
Message-ID: <20140514133528.GB21158@rei>
References: <1396526450-22885-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1399542652-5795-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<20140514131551.GA21158@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140514131551.GA21158@rei>
Subject: Re: [LTP] [PATCH v5 1/2] lib/tst_path_has_mnt_flags.c: create a
 function tst_path_has_mnt_flags()
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
> I've removed this if () because otherwise this code will ignore
> tmpfs (which is common for /tmp) and nfs mounts (that starts with ip
> address).
> 
> Frankly I have no idea why I added this check to the code in the first
> place (and I will fix the similar code in open posix testsuite too).

And I've remebered, that because there are two records for root fs / in
/proc/mounts and the one that starts with /dev/xyz device has correct
mount flags.

I will change the code to ignore only records with 'rootfs' mnt_fsname.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
