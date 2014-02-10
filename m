Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1WCgTl-0008GC-4v
	for ltp-list@lists.sourceforge.net; Mon, 10 Feb 2014 02:20:13 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WCgTi-00030R-BL
	for ltp-list@lists.sourceforge.net; Mon, 10 Feb 2014 02:20:13 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1A2K2vW025603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Feb 2014 02:20:02 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s1A2K1J9029837
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Feb 2014 02:20:01 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1A2K1s6015657
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Feb 2014 02:20:01 GMT
Message-ID: <52F83739.4000106@oracle.com>
Date: Mon, 10 Feb 2014 10:19:37 +0800
From: Simon Xu <xu.simon@oracle.com>
MIME-Version: 1.0
References: <1387171228-505-1-git-send-email-xu.simon@oracle.com>
	<52BA3898.3050909@oracle.com> <52DDD0ED.6040702@oracle.com>
	<2085388669.1674106.1391081515715.JavaMail.root@redhat.com>
	<20140204132922.GA6597@rei>
In-Reply-To: <20140204132922.GA6597@rei>
Subject: Re: [LTP] [PATCH] sctp: Avoid using file descriptor 0 to
	get	ENOTSOCK
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
To: ltp-list@lists.sourceforge.net

Any extra steps needed before applying it in LTP?

Thanks
Simon

On 2014/2/4 21:29, chrubis@suse.cz wrote:
> Hi!
>> Given that this is identical to c43ead6daa0b9ae5763d6cf3d21357a789651417 from
>> https://github.com/borkmann/lksctp-tools :
>>
>> Acked-by: Jan Stancek <jstancek@redhat.com>
> I would be tempted to put the repeated code fragemnts into single place
> (header included by all of the testcases). But given that the patch is
> in upstream I'm OK with applying it in LTP as well.

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
