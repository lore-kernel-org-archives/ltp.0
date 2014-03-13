Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WO6Bm-0006LI-Pk
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 14:00:50 +0000
Date: Thu, 13 Mar 2014 15:00:31 +0100
From: chrubis@suse.cz
Message-ID: <20140313140030.GA2503@rei.suse.cz>
References: <1392030999-4431-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1392030999-4431-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1392030999-4431-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 2/2] fs/ext4-new-features: add
 ext4-new-features tests to default
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
> +
> +	tst_require_root
> +
> +	EXT4_SUPPORT1=`grep -w ext4 /proc/filesystems | cut -f2`
> +	EXT4_SUPPORT2=`grep -w ext4 /proc/modules | cut -f1`

Hmm, that would not work when ext4 is compiled in kernel. I have ext4 in
/proc/filesystems/ but not in /proc/modules/

Othewise it looks good. And sorry for the late review.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
