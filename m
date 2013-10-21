Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VYHhz-0005jD-FZ
	for ltp-list@lists.sourceforge.net; Mon, 21 Oct 2013 15:47:55 +0000
Date: Mon, 21 Oct 2013 17:47:40 +0200
From: chrubis@suse.cz
Message-ID: <20131021154739.GB2385@rei>
References: <1382089184-21140-1-git-send-email-alexey.kodanev@oracle.com>
	<1382089184-21140-2-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1382089184-21140-2-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 2/2] device-drivers: tbio: fixes
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
> -static int tbio_open(struct inode *inode, struct file *filep)
> +static int tbio_open(struct block_device *blk, fmode_t mode)
>  {
> -	if (!Device.bdev) {
> -		Device.bdev = inode->i_bdev;
> -		//atomic_inc((atomic_t)&Device.bdev->bd_part_count);
> -	}
> -
>  	return 0;
>  }
>  
> -static int tbio_release(struct inode *inode, struct file *filep)
> +static int tbio_release(struct gendisk *gd, fmode_t mode)

This function is declared as void since db2a144bedd58b3dcf19950c2f476c58c9f39d18

I guess that we should fix this by adding ifdefs for kernel versions
around the function declaration and around the return.

The rest of the code looks good to me.

Apart from that I'm wondering if it would be a good idea to add read()
and write() tests to the userspace program as well. Something as writing
to the device, issuing fsync() and checking that the request made it to
the block device driver once we have returned from it... But that can be
done in subsequent patches.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
