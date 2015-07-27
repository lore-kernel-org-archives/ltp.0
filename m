Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xcf733520@sina.com>) id 1ZJc6m-0001Bn-NN
	for ltp-list@lists.sourceforge.net; Mon, 27 Jul 2015 06:41:56 +0000
Received: from mail7-217.sinamail.sina.com.cn ([202.108.7.217]
	helo=smtp545-124.mail.sina.com.cn)
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1ZJc6k-0003QK-Js
	for ltp-list@lists.sourceforge.net; Mon, 27 Jul 2015 06:41:56 +0000
Date: Mon, 27 Jul 2015 14:23:44 +0800
From: xcf733520 <xcf733520@sina.com>
Mime-Version: 1.0
Message-ID: <201507271423431749597@sina.com>
Subject: [LTP]  ltpstress script  is stopping for no reason
Reply-To: xcf733520 <xcf733520@sina.com>
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi All,

     During LTP stress test, I have a trouble that  ltpstress script  is stopping for no reasons.  I used  another Linux
OS to connect with test the Linux OS server  by the sshd  way .  My command  as below,
    ./ltpstress.sh -d /root/report/ltpstress_0720.sardata -p -l /root/report/ltpstresslog.0720 -m 4096 -t 502 &
I have set running 502 hours, but stopping affter running 144 hours  ssh connected always.  
 
Check  the dmesg,
 Jul 26 04:02:16 platform-test fmtmsg01: LTP:fmtmsg: LTP_TEST: LTP fmtmsg() test3 message, NOT an error TO FIX: This is correct output, no action needed  LTP:msg:003 
 Jul 26 04:02:16 platform-test xinetd[2182]: START: shell pid=17690 from=127.0.0.1
 Jul 26 04:02:16 platform-test rshd[17691]: root@platform-test.localdomain as root: cmd='/opt/ltp/testcases/bin/rpc_server'
 Jul 26 04:02:16 platform-test xinetd[2182]: EXIT: shell status=0 pid=17690 duration=0(sec)
 Jul 26 04:02:16 platform-test xinetd[2182]: START: shell pid=17716 from=127.0.0.1
 Jul 26 04:02:16 platform-test rshd[17719]: root@platform-test.localdomain as root: cmd='ps -ewf'
 Jul 26 04:02:16 platform-test xinetd[2182]: EXIT: shell status=0 pid=17716 duration=0(sec)
 Jul 26 04:02:16 platform-test xinetd[2182]: START: shell pid=17762 from=127.0.0.1
 Jul 26 04:02:16 platform-test rshd[17763]: root@platform-test.localdomain as root: cmd='kill -9 17712'
 Jul 26 04:02:16 platform-test xinetd[2182]: EXIT: shell status=0 pid=17762 duration=0(sec) 

Thanks,
--------------
Helu
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
