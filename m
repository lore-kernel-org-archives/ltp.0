Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WNgkw-0007z7-D7
	for ltp-list@lists.sourceforge.net; Wed, 12 Mar 2014 10:51:26 +0000
Date: Wed, 12 Mar 2014 11:51:08 +0100
From: chrubis@suse.cz
Message-ID: <20140312105108.GB13689@rei.Home>
References: <1391607438-529-1-git-send-email-alexey.kodanev@oracle.com>
	<20140311165448.GA11407@rei> <20140311165644.GB11407@rei>
	<532028A6.5030106@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <532028A6.5030106@oracle.com>
Subject: Re: [LTP] [PATCH] device-drivers/rcu: add wrapper script for
 rcutorture test
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >>> +	rmmod rcutorture > /dev/null 2>&1
> >>> +	if [ $? -ne 0 ]; then
> >>> +		tst_brkm TBROK NULL "failed to unload module"
> >>> +		exit 2
> >>> +	fi
> >>> +
> >>> +	# check module status in dmesg
> >>> +	result_str=`dmesg | tail -n 1`
> >> This is quite fragile, if anything has added a line into dmesg while the
> >> test was running it will fail. Better approach would be to save the
> >> dmesg output into a file and grep it for the rcutorture resutl.
> > And the best possible solution would be to add a more convinient
> > interface to the module itself, but that would need to be comunicated
> > with kernel upstream.
> Messages quite informative and could be parsed easily. Do you mean 
> adding sysfs parameters to control the module?

Yes. I would rather see the test writing into a sysfs file and be
blocked in the write till the test is finished which is more robust than
the sleep it does currently.

So for the time being I would go with the test as it is and try to
start a discussion about making the module more friendly to automated
testing on LKML. Does that sound reasonably?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
