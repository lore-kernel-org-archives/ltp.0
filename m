Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VRJrP-0004se-65
	for ltp-list@lists.sourceforge.net; Wed, 02 Oct 2013 10:40:51 +0000
Date: Wed, 2 Oct 2013 12:41:14 +0200
From: chrubis@suse.cz
Message-ID: <20131002104114.GA16429@rei>
References: <1380705830-7628-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1380705830-7628-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v5 2/2] device-drivers: block: fixes
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
> Fixed test-cases behavior: major number greater than 255 is valid,
> empty device name is valid.
> Added test-cases results and sysfs files.
> Added user-space program which checks each test-case result.
> Added command line parameter 'a': run all test-cases.

...

> +		if (major2 == 0)
> +			unregister_blkdev(major, BLK_DEV_NAME);
> +		else {
> +			pass = 0;
> +			prk_debug("1st call to register_blkdev() with major=%i "
> +				"failed with error %i\n", major, major2);
> +		}

Pushed with two more curly braces around this block, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
