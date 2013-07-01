Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UtcdJ-0008No-Qr
	for ltp-list@lists.sourceforge.net; Mon, 01 Jul 2013 11:51:01 +0000
Date: Mon, 1 Jul 2013 13:52:32 +0200
From: chrubis@suse.cz
Message-ID: <20130701115232.GA15035@rei.suse.cz>
References: <51D160D2.4070806@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51D160D2.4070806@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] mount/mount03.c: Test feature MS_NOATIME of
 mount(2)
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> +	case 6:
> +		/* Validate MS_NOATIME flag of mount call */
> +
> +		snprintf(file, PATH_MAX, "%satime", path_name);
> +		fd = open(file, O_CREAT | O_RDWR, S_IRWXU);
> +		if (fd == -1) {
> +			tst_resm(TWARN | TERRNO, "opening %s failed", file);
> +			return 1;
> +		}
> +
> +		if (write(fd, "TEST_MS_NOATIME", 15) != 15) {
> +			tst_resm(TWARN | TERRNO, "write %s failed", file);
> +			return 1;
> +		}
> +
> +		if (fstat(fd, &file_stat) == -1) {
> +			tst_resm(TWARN | TERRNO, "stat %s failed #1", file);
> +			return 1;
> +		}
> +
> +		atime = file_stat.st_atime;
> +

The time_t, if I'm not mistaken, has resolution in seconds, so you need
to sleep a second here before you call the read() bellow to be sure
timestamp is different at the time you try to read.


Moreover the whole testcase should better be cleaned up (it doesn't use
the tst_require_root() and does some strange/unnecessary things in the
temp dir).


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
