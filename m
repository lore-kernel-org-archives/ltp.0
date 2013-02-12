Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1U5H2k-00009h-Rm
	for ltp-list@lists.sourceforge.net; Tue, 12 Feb 2013 14:41:10 +0000
Date: Tue, 12 Feb 2013 15:41:39 +0100
From: chrubis@suse.cz
Message-ID: <20130212144139.GA24255@rei>
References: <E351E450E8B9F54684A699D42DC5ADF224468DAC@MPBAGVEX02.corp.mphasis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E351E450E8B9F54684A699D42DC5ADF224468DAC@MPBAGVEX02.corp.mphasis.com>
Subject: Re: [LTP] LTP] [PATCH ]: network stress interfaces part of the LTP
 stress fails
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
To: Bhushan Kumar <Bhushan.Kumar@mphasis.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>      check_icmpv4_connectivity $lhost_ifname $rhost_ipv4addr
> 
> +    sleep 5
> 
>      if [ $? -ne 0 ]; then

This is wrong as you check the return value from the sleep command
rather than the return value form the check_icmpv4_connectivity.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
