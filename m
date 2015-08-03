Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZMHLt-0001JH-6G
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2015 15:08:33 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZMHLs-000713-4Q
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2015 15:08:33 +0000
Date: Mon, 3 Aug 2015 17:08:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150803150809.GA7852@rei.suse.de>
References: <201507271423431749597@sina.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201507271423431749597@sina.com>
Subject: Re: [LTP] ltpstress script  is stopping for no reason
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
To: xcf733520 <xcf733520@sina.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
>      During LTP stress test, I have a trouble that  ltpstress script  is stopping for no reasons.  I used  another Linux
> OS to connect with test the Linux OS server  by the sshd  way .  My command  as below,
>     ./ltpstress.sh -d /root/report/ltpstress_0720.sardata -p -l /root/report/ltpstresslog.0720 -m 4096 -t 502 &
> I have set running 502 hours, but stopping affter running 144 hours  ssh connected always.  

No idea what happened. What was the output of the script on the command
line? Has it died silently or has it yielded "Testing done" message?

Have you checked the test output logfiles?

> Check  the dmesg,
>  Jul 26 04:02:16 platform-test fmtmsg01: LTP:fmtmsg: LTP_TEST: LTP fmtmsg() test3 message, NOT an error TO FIX: This is correct output, no action needed  LTP:msg:003 
>  Jul 26 04:02:16 platform-test xinetd[2182]: START: shell pid=17690 from=127.0.0.1
>  Jul 26 04:02:16 platform-test rshd[17691]: root@platform-test.localdomain as root: cmd='/opt/ltp/testcases/bin/rpc_server'
>  Jul 26 04:02:16 platform-test xinetd[2182]: EXIT: shell status=0 pid=17690 duration=0(sec)
>  Jul 26 04:02:16 platform-test xinetd[2182]: START: shell pid=17716 from=127.0.0.1
>  Jul 26 04:02:16 platform-test rshd[17719]: root@platform-test.localdomain as root: cmd='ps -ewf'
>  Jul 26 04:02:16 platform-test xinetd[2182]: EXIT: shell status=0 pid=17716 duration=0(sec)
>  Jul 26 04:02:16 platform-test xinetd[2182]: START: shell pid=17762 from=127.0.0.1
>  Jul 26 04:02:16 platform-test rshd[17763]: root@platform-test.localdomain as root: cmd='kill -9 17712'
>  Jul 26 04:02:16 platform-test xinetd[2182]: EXIT: shell status=0 pid=17762 duration=0(sec) 

This does not seem to be relevant, at least to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
