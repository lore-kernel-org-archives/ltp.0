Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1UwyBf-0000bR-4K
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 17:28:19 +0000
Received: from mail-pd0-f176.google.com ([209.85.192.176])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UwyBb-00032o-PV
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 17:28:19 +0000
Received: by mail-pd0-f176.google.com with SMTP id t12so6558160pdi.21
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Jul 2013 10:28:10 -0700 (PDT)
Message-ID: <51DD99C2.9030205@casparzhang.com>
Date: Thu, 11 Jul 2013 01:28:34 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1373454200-8630-1-git-send-email-lingyun.xie@bj.cs2c.com.cn>
In-Reply-To: <1373454200-8630-1-git-send-email-lingyun.xie@bj.cs2c.com.cn>
Subject: Re: [LTP] [PATCH 1/2 v3] xinetd/xinetd_tests.sh: cleanup tabs
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
To: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
Cc: ltp-list@lists.sourceforge.net

On 07/10/2013 07:03 PM, Xie Lingyun wrote:
> +defaults
> +{
> +instances      = 25
> +log_type       = FILE /var/log/servicelog
> +log_on_success = HOST PID
> +log_on_failure = HOST RECORD
> +disabled       = telnet
> +}

Generally looks good except here.

better give a 4-space indentation inside the braces.

Caspar

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
