Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WowhN-0007QO-LI
	for ltp-list@lists.sourceforge.net; Mon, 26 May 2014 15:20:25 +0000
Date: Mon, 26 May 2014 17:20:09 +0200
From: chrubis@suse.cz
Message-ID: <20140526152009.GA7298@rei.Home>
References: <1397800512.2119.5.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397800512.2119.5.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] controllers/cpuacct: add cpuacct tests to default
 and somecleanup
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
> +. cmdlib.sh

What is the cmdlib.sh needed here for?

> +# umount cpuacct if it has been mounted.
> +umount_cpuacct_mounted()
> +{
> +	dir=`cat /proc/mounts | grep cpuacct | awk '{print $2}'`
> +	if [ -n "$dir" ]; then
> +		umount "$dir" 2> /dev/null
> +	fi
> +}

...

The rest looks like pretty straightforward cleanup and therefore OK.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
The best possible search technologies are now affordable for all companies.
Download your FREE open source Enterprise Search Engine today!
Our experts will assist you in its installation for $59/mo, no commitment.
Test it for FREE on our Cloud platform anytime!
http://pubads.g.doubleclick.net/gampad/clk?id=145328191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
