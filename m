Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WcbEw-0001Dv-RE
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 14:00:02 +0000
Date: Tue, 22 Apr 2014 15:59:09 +0200
From: chrubis@suse.cz
Message-ID: <20140422135909.GE3951@rei>
References: <1397561602-18935-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397561602-18935-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] runltp: fix errors when using getenv(3) to
 get environment variable LTP_BIG_DEV or LTP_BIG_DEV_FS_TYPE
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
> Make runltp export LTP_BIG_DEV and LTP_BIG_DEV_FS_TYPE only when they have a non-zero
> value. We do this to make getenv("LTP_BIG_DEV") or getenv("LTP_BIG_DEV_FS_TYPE")
> return NULL, if user does not specify a big block device. Because users usually write
> such code:
> 	device = getenv("LTP_BIG_DEV");
> 	if (device == NULL) {
> 		tst_brkm(TCONF, NULL,
> 			 "you must specify a big blockdevice(>1.2G)");
> 	} else {
> 		tst_mkfs(NULL, device, "ext3", NULL);
> 	}

I've shortened the first line of the commit description a bit and
pushed the patch, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
