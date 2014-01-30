Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W8u2V-0004QR-Qu
	for ltp-list@lists.sourceforge.net; Thu, 30 Jan 2014 16:00:27 +0000
Date: Thu, 30 Jan 2014 16:59:57 +0100
From: chrubis@suse.cz
Message-ID: <20140130155957.GB21467@rei>
References: <52A999C2.20604@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52A999C2.20604@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 1/2] runltp: add -z,
 -Z options and change device symbol in runtest files
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
> Add two options -z and -Z for runltp, to allow user specify big block
> device for some tests, such as fs_ext4(ext4 new features tests).
> 
> We abandon the old way of assigning specific device in runltp like that
> "sed -i 's|DEVICE|$DEVICE|'  ${TMP}/alltests". Now we use shell
> variables directly in runtest files.
> 
> runltp will export four shell variables to indicate devices.
>     LTP_SMALL_DEV: small block device(the original DEVICE).
>     LTP_BIG_DEV: big block device. if user doesn't specify it,
>                  LTP_BIG_DEV will be "d"
>     DEVICE_FS_TYPE: default ext2
>     BIG_DEVICE_FS_TYPE: default ext2
> 

Pushed with following changes:

* Renamed the LTP_SMALL_DEV to just LTP_DEV
  and LTP_SMALL_DEV_FS_TYPE to LTP_DEV_FS_TYPE

* The devices are initialized to empty string

* Fixed the commit message (the DEVICE_FS_TYPE
  and BIG_DEVICE_FS_TYPE were wrong anyway)

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
