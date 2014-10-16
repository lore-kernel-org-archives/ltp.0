Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XejgQ-00039E-5d
	for ltp-list@lists.sourceforge.net; Thu, 16 Oct 2014 11:57:30 +0000
Date: Thu, 16 Oct 2014 13:57:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141016115708.GA20676@rei.suse.de>
References: <1409480940.6575.1.camel@G08JYZSD130126>
	<1411638835.24531.2.camel@G08JYZSD130126>
	<20140930122027.GB9190@rei.suse.cz>
	<1412659019.2433.14.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1412659019.2433.14.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [PATCH v2 1/4] multicast/mc_cmds: Some cleanup
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
> -   IFNAME=${IFNAME:-$(netstat -i -n | grep "^[b-z]\{2,4\}[0-9][^*]"|\
> -      awk '{print $1}')}
> +	IFNAME=${IFNAME:-$(netstat -i -n | sed '1,2 d' | awk '{print $1}')}


This line has been changed from grep to sed. Not that it's wrong but the
reason to do so should be noted in the commit log message.

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
