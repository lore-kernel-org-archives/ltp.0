Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XeLVO-0003WB-0Y
	for ltp-list@lists.sourceforge.net; Wed, 15 Oct 2014 10:08:30 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XeLVN-0007Nb-69
	for ltp-list@lists.sourceforge.net; Wed, 15 Oct 2014 10:08:29 +0000
Message-ID: <543E4809.4000709@oracle.com>
Date: Wed, 15 Oct 2014 14:10:17 +0400
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1412769465-16030-1-git-send-email-alexey.kodanev@oracle.com>
	<20141009132453.GI24933@Leo.nay.redhat.com>
In-Reply-To: <20141009132453.GI24933@Leo.nay.redhat.com>
Subject: Re: [LTP] [PATCH 1/3] network/test_net: add support for -6 option
 (IPv6 tests)
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi,
On 10/09/2014 05:24 PM, Hangbin Liu wrote:
> Ah, find your patch here :)
>
> Just as you said, net_cmdlib.sh source cmdlib.sh, so how about do it like
> test.sh, add a global variable $CMD_LIB_LOADED in cmdlib.sh and add
>
> [ -z "$CMD_LIB_LOADED" ] && . cmdlib.sh
>
> in test_net.sh ?

No, we shouldn't use obsolete 'cmdlib.sh' and new 'test.sh' together.

> For function read_opts(), I greped ltp and only found tests under tcp_cmds use
> it. So I think it's OK to change all net_cmdlib.sh directly. But as your wish,
> you can send it separately, not a big deal.

It's preferably to additionally replace outdated interface with the new 
one when tests need some fixes. Inevitably, the tests become fixed and 
easy to support in the future, confirm with the latest suite standards 
(e.g. test output, return exit codes).
That's why when I said that patches should be sent separately I also 
meant the replacement of cmdlib.sh as well. Otherwise I don't see any 
reason to replace just read_opts with identical one from another file.

Thanks,
Alexey


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
