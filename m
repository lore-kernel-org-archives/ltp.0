Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z09eg-0006to-J6
	for ltp-list@lists.sourceforge.net; Wed, 03 Jun 2015 14:28:30 +0000
Date: Wed, 3 Jun 2015 16:27:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150603142728.GB5078@rei.suse.de>
References: <20150528104140.GB3192@rei.suse.de>
	<1433151743-30219-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<1433151743-30219-2-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1433151743-30219-2-git-send-email-zenglg.jy@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v4 2/2] commands/df: Added new testcase to test
 df(1) command.
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
Cc: ltp-list@lists.sourceforge.net, jy_zhangjin@cn.fujitsu.com

Hi!
> +sub()
> +{
> +	minuend=$(echo $1 | sed -r 's/([[:digit:]]{1,}).*/\1/')
> +	if echo $1 | grep -q -E "m|M"; then
> +		minuend=$((minuend*1024*1024))
> +		flag=m
> +	elif echo $1 | grep -q -E "k|K"; then
> +		minuend=$((minuend*1024))
> +		flag=k
> +	else
> +		flag=0
> +	fi
> +
> +	subtrahend=$(echo $2 | sed -r 's/([[:digit:]]{1,}).*/\1/')
> +	if echo $2 | grep -q -E "m|M"; then
> +		subtrahend=$((subtrahend*1024*1024))
> +	elif echo $2 | grep -q -E "k|K"; then
> +		subtrahend=$((subtrahend*1024))
> +	fi
> +
> +	rest=$((minuend - subtrahend))
> +	if [ $flag == m ]; then
> +		echo $((rest/1024/1024))
> +	elif [ $flag == k ]; then
> +		echo $((rest/1024))
> +	else
> +		echo $rest
> +	fi

I don't get why we multiply the numbers, substract them and then divide
them again. Can't we just substract them?


Also does this work for other filesystems than ext2? It may be a good
idea to run the test for a few more filesystems as well. We may add a
parameter which fs to use and add entries as:

df01 -f ext2
df01 -f ext3
...

to the runtest file.

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
