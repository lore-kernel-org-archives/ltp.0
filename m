Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z85uC-0006SA-Oo
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 12:05:20 +0000
Date: Thu, 25 Jun 2015 14:04:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150625120404.GB2734@rei.suse.de>
References: <1435248845-29155-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1435248845-29155-1-git-send-email-sunyuan3@huawei.com>
Subject: Re: [LTP] [PATCH] Need to install linux-libc-dev for getrandom
	cases.
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
To: Yuan Sun <sunyuan3@huawei.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
> ---
>  doc/mini-howto-building-ltp-from-git.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/mini-howto-building-ltp-from-git.txt b/doc/mini-howto-building-ltp-from-git.txt
> index 28825c2..7a1062e 100644
> --- a/doc/mini-howto-building-ltp-from-git.txt
> +++ b/doc/mini-howto-building-ltp-from-git.txt
> @@ -36,7 +36,7 @@ sudo apt-get install build-essential
>  sudo apt-get install autoconf automake autotools-dev m4
>  sudo apt-get install git
>  sudo apt-get install linux-headers-$(uname -r)
> -sudo apt-get install libaio-dev libattr1-dev libcap-dev
> +sudo apt-get install libaio-dev libattr1-dev libcap-dev linux-libc-dev

The linux-libc-dev is dependency of libc-dev which is dependency of
build-essential. So it should be installed in the first step here.

Maybe the explicit apt-get updated the package in your case that caused
more up to date headers (that include the getrandom flags) to be
installed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
