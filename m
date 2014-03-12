Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WNgf6-0003EC-Gc
	for ltp-list@lists.sourceforge.net; Wed, 12 Mar 2014 10:45:24 +0000
Date: Wed, 12 Mar 2014 11:45:05 +0100
From: chrubis@suse.cz
Message-ID: <20140312104505.GA13689@rei.Home>
References: <1391607438-529-1-git-send-email-alexey.kodanev@oracle.com>
	<20140311165448.GA11407@rei> <532024B6.9080603@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <532024B6.9080603@oracle.com>
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
> >> +
> >> +	rmmod rcutorture > /dev/null 2>&1
> >> +	if [ $? -ne 0 ]; then
> >> +		tst_brkm TBROK NULL "failed to unload module"
> >> +		exit 2
> >> +	fi
> >> +
> >> +	# check module status in dmesg
> >> +	result_str=`dmesg | tail -n 1`
> > This is quite fragile, if anything has added a line into dmesg while the
> > test was running it will fail. Better approach would be to save the
> > dmesg output into a file and grep it for the rcutorture resutl.
> Why copy it to a file? I'm thinking about changing to this command, it 
> will return the last test result.
>
> result_str=`dmesg | sed -nE '$s/.*End of test: ([A-Z]+):.*/\1/p'`

I was just thinking how to make the race window as small as possible. In
order to do that I would save the output right after the test has
finished etc.

But it's quite unlikely that the whole kernel log buffer will be filled
with messages meanwhile.

> Don't need the last grep as well, will be as follows:
> if [ "$result_str" == "SUCCESS" ]; then
> ...
> >> +	echo "$result_str" | grep SUCCESS > /dev/null 2>&1
> >> +	if [ $? -eq 0 ]; then
> >> +		tst_resm TPASS "tc$TST_COUNT: completed"
> >> +	else
> >> +		tst_resm TFAIL "tc$TST_COUNT: failed, please check dmesg"
> >> +		RC=1
> > What about using the test.sh library I've send as a RFC into the mailing
> > list instead? Have you seen the code? It's modeled more closely to the C
> > interface and stores the exit value internally, manages the TST_COUNT,
> > etc...
> >
> > (http://sourceforge.net/p/ltp/mailman/message/31941597/)
> No, I missed the attachment :(

Sorry, I forgot to change the attachement to be inlined.

> Well done! I've tried it today with the rcutorture test,  have a few 
> questions:
> - tst_require_root returns with TBROK, I thought it should be TCONF 
> instead, shouldn't it?

Right, thanks for noticing.

> - LTP_TST_COUNT incremented on each call to tst_resm(), would it be 
> better to count only PASS/FAIL calls as it is in ltplib?

I've noticed this too a few days ago.

I will fix these problems and add push it into LTP git and update
test-writing-guidelines.

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
