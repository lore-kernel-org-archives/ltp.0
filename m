Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xek1A-0003vf-4q
	for ltp-list@lists.sourceforge.net; Thu, 16 Oct 2014 12:18:56 +0000
Date: Thu, 16 Oct 2014 14:18:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141016121834.GC20676@rei.suse.de>
References: <1409480940.6575.1.camel@G08JYZSD130126>
	<1411638835.24531.2.camel@G08JYZSD130126>
	<20140930122027.GB9190@rei.suse.cz>
	<1412659186.2433.18.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1412659186.2433.18.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [PATCH v2 3/4] multicast/mc_member: Some cleanup
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
> -EXECUTABLES=${EXECUTABLES:-"member"}
> -NUMLOOPS=${NUMLOOPS:-2}
> -INTERFACE=${INTERFACE:-$(mc_gethost `hostname`| grep address |awk '{ print $2 }')}
> +INTERFACE=${INTERFACE:-$(mc_gethost `hostname`|grep address|awk '{ print $2 }')}
>  GLIST=${GLIST:-$TCsrc/ManyGroups}
>  TooManyGLIST=${TooManyGLIST:-$TCsrc/TooManyGroups}

These two files should be ideally treated as datafiles.

> +	tst_resm TINFO "doing test."
> +
> +	COUNT=1
> +	while [ $COUNT -le 2 ]
> +	do
> +		# Run setsockopt test with bogus network
> +		get_address
> +		tst_resm TINFO "Running mc_member_e on $ADDRESS"
> +		member -j -g $GLIST -s 30 -i $ADDRESS >/dev/null 2>&1

And the member binary should have reasonably unique name (because all
binaries are installed into single directory). I woudl rename it to
something as mc_member_helper or similar.

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
