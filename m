Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZMxQL-0006fY-FE
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2015 12:03:57 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZMxQK-0002Ul-Hk
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2015 12:03:57 +0000
Date: Wed, 5 Aug 2015 14:03:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150805120331.GA30530@rei.suse.de>
References: <1436348543-6759-1-git-send-email-liuchangsheng@inspur.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436348543-6759-1-git-send-email-liuchangsheng@inspur.com>
Subject: Re: [LTP] [PATCH] netns,
 when test ipv6 the parent and child can not ping each other
 successfully
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
To: Changsheng Liu <liuchangsheng@inspur.com>
Cc: ltp-list@lists.sourceforge.net, wunan@inspur.com

Hi!
> @@ -89,7 +89,7 @@ status=0
>          tst_brkm TBROK "timeout reached!"
>      fi
>      ping6 -I $vnet0 -qc 2 $childIPv6 >/dev/null 2>&1
> -
> +    sleep 1
>      if [ $? = 0 ] ; then
>         tst_resm TINFO "IPv6: Pinging child from parent: PASS"
>         status=0

This is obviously wrong. Because the $? in the if will correspond to the
return value from the sleep 1 and not from the ping.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
