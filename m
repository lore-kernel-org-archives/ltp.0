Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2dCC-00039R-3K
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 10:25:20 +0000
Date: Wed, 10 Jun 2015 12:24:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150610102414.GC31366@rei.suse.de>
References: <1433923871-10933-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20150610100845.GA31366@rei.suse.de> <55780FC7.1090100@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55780FC7.1090100@oracle.com>
Subject: Re: [LTP] [PATCH] detach_device: Wait until the kernel frees the
 loop device
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
> Do you mean printing of TINFO/TWARN messages right in the cycle?
> 
> 		if (errno != EBUSY) {
> 			err = errno;
> 			tst_resm(TWARN,
> 				"ioctl(%s, LOOP_CLR_FD, 0) unexpectedly failed with: %s",
> 				dev, tst_strerrno(err));
> 		}
> 
> 
> But in the worst case, we may end up with 40 messages generated.
> 
> Or do you mean saving the last errno and printing it to the final tst_brkm?

Either one works for me.

Having 40 messages is better than none. Because you will see these only
if something went wrong.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
