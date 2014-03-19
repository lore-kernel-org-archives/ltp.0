Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WQL7Z-0003Ag-1X
	for ltp-list@lists.sourceforge.net; Wed, 19 Mar 2014 18:21:45 +0000
Date: Wed, 19 Mar 2014 19:21:22 +0100
From: chrubis@suse.cz
Message-ID: <20140319182122.GD27687@rei.Home>
References: <530DBB2D.1090406@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <530DBB2D.1090406@oracle.com>
Subject: Re: [LTP] network tests: help script to run commands on remote host
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
Cc: Vasily Isaenko <vasily.isaenko@oracle.com>, ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> There are some network tests which need to run various commands on the 
> remote host. So is it a good idea to add a help script which does that 
> according to chosen network protocol: rsh or ssh?
> 
> If yes, we can have a script like tst_rhost_run (or tst_run_rcmd...) in 
> the ltp/tools, or somewhere else.
> 
> I did something similar in the submitted tcp_fastopen test, so the 
> script could be as follows:
> 
> if [ "$use_ssh" -eq 1 ]; then
> 	ssh -n -f $user_name@$RHOST "sh -c 'nohup $rcmd &'" > /dev/null 2>&1
> else
> 	rsh -n -l $user_name $RHOST "sh -c 'nohup $rcmd &'" > /dev/null 2>&1
> fi
> 
> if [ $? -ne 0 ]; then
> 	tst_brkm TBROK NULL "No route to host $RHOST"
> 	exit 2
> fi

Sounds good to me. The location for the file could be testcases/lib/.

One problem with the code above is that the error message can be
misleading, there is much more that could go wrong. One that comes to my
mind is when LTP is not installed on the remote machine.

And ideally we should use the new test.sh library. I would go for
exporting an TST_LIB_LOADED=1 variable in the test.sh and checking in
all sublibs that the variable exists to force the test to source the
test.sh first.

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
