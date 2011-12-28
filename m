Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rfrvl-0004G6-Ee
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 11:44:25 +0000
Date: Wed, 28 Dec 2011 12:54:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111228115439.GA18611@saboteur.suse.cz>
References: <4EEB065C.4060805@cn.fujitsu.com>
	<20111222151810.GA1494@saboteur.suse.cz>
	<4EF98B7B.3040005@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EF98B7B.3040005@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] memcg_function:fix the wrong of test_proc_kill
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

> >> -	$TEST_PATH/memcg_process $2 -s $3 &
> >> +	($TEST_PATH/memcg_process $2 -s $3 2>/tmp/errlog) &
> >>  	pid=$!
> >>  	sleep 1
> >>  	echo $pid > tasks
> >>  
> >>  	/bin/kill -s SIGUSR1 $pid 2> /dev/null
> >>  	sleep 1
> >> +
> >> +	if [ -s /tmp/errlog ]; then
> >> +		err_msg=`cat /tmp/errlog`
> >> +		rm -f /tmp/errlog
> >> +		result $FAIL "$err_msg"
> >> +		return
> >> +	fi
> >> +
> >> +	rm -f /tmp/errlog
> >> +
> > 
> > Looking into the memcg_process.c it returns return value 1 on failure,
> > catching it correctly is better option here.
> > 
> 
> I also think catching memcg_process's return value is better option,
> but I think this way is simple.
> 
> Can you tell me a simple way to catch return value of background process?
> Thanks.

See manual pages for jobs and wait.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
