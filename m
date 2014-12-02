Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XvoCE-00078G-2T
	for ltp-list@lists.sourceforge.net; Tue, 02 Dec 2014 14:12:54 +0000
Date: Tue, 2 Dec 2014 15:12:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141202141241.GA18709@rei.suse.de>
References: <1415258674-17261-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1415609164-10297-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<20141111131618.GD29189@rei> <5462BC16.7090709@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5462BC16.7090709@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 1/2] containers: change check_iproute()
 behavior in netns/netns_helper.h
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
To: "gux.fnst" <gux.fnst@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> >> +	} else {
> >> +		if (cur_ipver < spe_ipver)
> >> +			ret = -1;
> >> +		else if (cur_ipver == spe_ipver)
> >> +			ret = 0;
> >> +		else
> >> +			ret = 1;
> >> +	}
> >
> > Again why bother with return value when all the testcases just needs to
> > know if ip is newer than some version?
> >
> 
> I do this in order to provide more choices for users, like tst_kvercmp. 
> Is it necessary? If it is not, I will send a new patch. Thanks!

Sorry, I've forgot to answer this one.

I would stick to the simpler version unless there is a need for the more
complex interface. Generally we should do things as simple as possible.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
