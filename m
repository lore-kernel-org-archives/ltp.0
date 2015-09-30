From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Sep 2015 14:16:14 +0200
Subject: [LTP] [PATCH 1/2] testscripts: make redirects happen in correct
 order
In-Reply-To: <1443583556-20470-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1443583556-20470-1-git-send-email-weijg.fnst@cn.fujitsu.com>
Message-ID: <20150930121613.GA8132@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  if [ $PROC_NUM -gt 0 ];then
> -  genload --vm $PROC_NUM --vm-bytes 1073741824 2>&1 1>/dev/null &
> +  genload --vm $PROC_NUM --vm-bytes 1073741824 1>/dev/null 2>&1 &

Can we also change the redirect to canonical form (>/dev/null 2>&1)?

Otherwise it looks fine to me.

-- 
Cyril Hrubis
chrubis@suse.cz
