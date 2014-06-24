Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WzQQX-0000R3-2j
	for ltp-list@lists.sourceforge.net; Tue, 24 Jun 2014 13:06:21 +0000
Date: Tue, 24 Jun 2014 15:06:04 +0200
From: chrubis@suse.cz
Message-ID: <20140624130604.GA7391@rei>
References: <1402624697.2098.8.camel@G08JYZSD130126>
	<1183733259.23953127.1402660578711.JavaMail.zimbra@redhat.com>
	<1402972112.2294.26.camel@G08JYZSD130126>
	<20140617111120.GA31854@rei> <20140618155819.GC4466@rei>
	<1403144011.10350.8.camel@G08JYZSD130126>
	<1403144473.10350.12.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1403144473.10350.12.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2 2/2] utime/utime06.c: add EPERM and EROFS errno
	testes
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> +	dev = tst_acquire_device(cleanup);
> +	if (!dev)
> +		tst_brkm(TCONF, cleanup, "Failed to acquire test device");
>  
> -	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
> +	tst_mkfs(cleanup, dev, "ext2", NULL);
> +
> +	SAFE_MKDIR(cleanup, MNT_POINT, 0644);
> +	if (mount(dev, MNT_POINT, "ext2", MS_RDONLY, NULL) < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "mount device:%s failed", dev);
> +	}
> +	mount_flag = 1;
> +
> +	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
>  }

I've changed this part to use the tst_dev_fs_type() function to
determine the filesystem type (that I've added for this purpose) and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
