Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WNPzC-00027s-7f
	for ltp-list@lists.sourceforge.net; Tue, 11 Mar 2014 16:57:02 +0000
Date: Tue, 11 Mar 2014 17:56:44 +0100
From: chrubis@suse.cz
Message-ID: <20140311165644.GB11407@rei>
References: <1391607438-529-1-git-send-email-alexey.kodanev@oracle.com>
	<20140311165448.GA11407@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140311165448.GA11407@rei>
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
> > +	rmmod rcutorture > /dev/null 2>&1
> > +	if [ $? -ne 0 ]; then
> > +		tst_brkm TBROK NULL "failed to unload module"
> > +		exit 2
> > +	fi
> > +
> > +	# check module status in dmesg
> > +	result_str=`dmesg | tail -n 1`
> 
> This is quite fragile, if anything has added a line into dmesg while the
> test was running it will fail. Better approach would be to save the
> dmesg output into a file and grep it for the rcutorture resutl.

And the best possible solution would be to add a more convinient
interface to the module itself, but that would need to be comunicated
with kernel upstream.

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
