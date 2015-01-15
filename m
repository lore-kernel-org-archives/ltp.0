Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YBh7k-00018s-BY
	for ltp-list@lists.sourceforge.net; Thu, 15 Jan 2015 09:53:56 +0000
Date: Thu, 15 Jan 2015 10:53:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150115095301.GA12643@rei>
References: <54B4E154.2070801@oracle.com>
	<1421146475-8597-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1421146475-8597-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V2 2/2] tbio: fixes
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +			if ((st.st_mode & S_IFBLK) && (st.st_rdev == devt)) {
> +				valid_node_created = 1;
> +				break;
>  			}
>  		}
> +
> +		sleep(1);

I would be inclined to check at least ten times in second. I.e.
usleep(100000); here and do the for loop 50 times instead.

Each second we spend doing nothing is second not spend doing actual
testing.

> +	}
> +
> +	if (!valid_node_created) {

Maybe we should issue TINFO message here that device wasn't created by
udev and we have fallen back to manual creation.

> +		if (unlink(DEVICE_NAME) && (errno != ENOENT))
> +			tst_brkm(TBROK | TERRNO, cleanup, "unlink() failed");
> +		if (mknod(DEVICE_NAME, S_IFBLK | S_IRUSR | S_IWUSR |
> +			  S_IRGRP | S_IWGRP, devt))
> +			tst_brkm(TBROK | TERRNO, cleanup, "mknod() failed");
>  	}

Otherwise this looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
