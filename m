Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XGou0-0008UU-S3
	for ltp-list@lists.sourceforge.net; Mon, 11 Aug 2014 12:40:40 +0000
Date: Mon, 11 Aug 2014 14:39:46 +0200
From: chrubis@suse.cz
Message-ID: <20140811123946.GA2022@rei.suse.cz>
References: <1403596982-21645-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140715095051.GA26664@rei>
	<1406079275.2313.6.camel@G08JYZSD130126>
	<1406698959.3928.6.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1406698959.3928.6.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2] fs/ext4-new-features: Fix
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
> * As Xiaoguang Wnag <wangxg.fnst@cn.fujitsu.com> said:
> "Now I think 'grep -q CONF' is not enough, if fallocate[1-3] prints TBROK..."
> Change these like:
> -		TMPDIR=mnt_point; fallocate0${i} | grep -q "CONF"
> +		TMPDIR=mnt_point; fallocate0${i} > /dev/null 2>&1
> +		ret=$?
> 		TMPDIR=$temp_tmpdir
> 
> -		if [ $? -ne $ret ]; then
> +		if [ $ret -ne 0 ]; then

Pushed, thanks (for noticing the silly mistake I did).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
