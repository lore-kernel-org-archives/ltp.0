Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YDEdJ-0005yw-JW
	for ltp-list@lists.sourceforge.net; Mon, 19 Jan 2015 15:52:53 +0000
Date: Mon, 19 Jan 2015 16:51:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150119155156.GA30735@rei>
References: <1419327221-28508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<1419327221-28508-2-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1419327221-28508-2-git-send-email-zenglg.jy@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 02/12] smack_file_access.sh: Cleanup
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> -if [ ! -d "$Where" ]; then
> -	if [ -e "$Where" ]; then
> -		echo "Test directory \"$Where\" exists but is not a directory."
> -		exit 1
> -	fi
> -	mkdir -m 777 "$Where"
> -	if [ ! -d "$Where" ]; then
> -		echo "Test directory \"$Where\" can not be created."
> -		exit 1
> -	fi
> -fi
> +tst_tmpdir
> +TST_CLEANUP=cleanup
> +
> +chmod 777 $(pwd)

Hmm, we do chmod 777 for the TMPDIR in the C test library. I guess that
it will be better to move the chmod to test.sh and omit it here.

The rest of the patchset looks good to me.

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
