Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RgcIw-0003lw-Vi
	for ltp-list@lists.sourceforge.net; Fri, 30 Dec 2011 13:15:26 +0000
Date: Fri, 30 Dec 2011 14:25:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111230132552.GB26420@saboteur.suse.cz>
References: <4EEB065C.4060805@cn.fujitsu.com>
	<20111222151810.GA1494@saboteur.suse.cz>
	<4EF98B7B.3040005@cn.fujitsu.com>
	<20111228115439.GA18611@saboteur.suse.cz>
	<4EFBCE29.9070000@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EFBCE29.9070000@cn.fujitsu.com>
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

Hi!
> Cyril Hrubis said the following on 2011-12-28 19:54:
> >> Can you tell me a simple way to catch return value of background process?
> >> Thanks.
> > 
> > See manual pages for jobs and wait.
> > 
> 
> Thanks for your suggest.
> I know wait, but I think wait is not better than catching error message.
> 
> If you think wait is better, the following patch use wait.

Yes, I think this way is better than looking for error logs.

Also note that running the sleep 2; kill ... in background is not
necessary as shell is required to save return status from background
command if it's pid was saved by $!.

Generally sequence of

command&
pid=$!
kill $pid
wait $pid

Should work as expected.

>  	sleep 1
>  	echo $pid > tasks
>  
> -	/bin/kill -s SIGUSR1 $pid 2> /dev/null
> -	sleep 1
> +	{
> +		sleep 2
> +		/bin/kill -s SIGUSR1 $pid 2> /dev/null
> +	}&
> +
> +	wait $pid
> +	if [ $? -eq 1 ]; then
> +		result $FAIL "process $pid is killed by error"
> +		return
> +	fi
> +
>  	ps -p $pid > /dev/null 2> /dev/null
>  	if [ $? -ne 0 ]; then
>  		result $PASS "process $pid is killed"

Hmm I see the problem here, if the test wouldn't exit by the 
getting the SIGUSR1 the wait will run forever. So the fail based
solution may actually be better here, alghough I still think it's a
little fragile.

And I recall saying that earlier, the way the memcg_process is
controlled by a signal is fundamentally flaved. The correct way
for this would be creating a unix socket (or use whatever interface to
interprocess communication). Then you can comunicate with the
memcg_process running in background and gets it's status that way.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
