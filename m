Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1V6dJX-0006Bt-7U
	for ltp-list@lists.sourceforge.net; Tue, 06 Aug 2013 09:12:23 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V6dJV-0007dq-8X
	for ltp-list@lists.sourceforge.net; Tue, 06 Aug 2013 09:12:23 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r769CEA5017744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Aug 2013 09:12:15 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r769CDMU027867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Aug 2013 09:12:14 GMT
Received: from abhmt111.oracle.com (abhmt111.oracle.com [141.146.116.63])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r769CDhW018093
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Aug 2013 09:12:13 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue,  6 Aug 2013 13:11:51 +0400
Message-Id: <1375780313-17327-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <51FFBCC1.3030101@oracle.com>
References: <51FFBCC1.3030101@oracle.com>
Subject: [LTP] [PATCH V3] tst_run_cmd: added support for stdout and stderr
	redirection
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, alexey.kodanev@oracle.com


Now there are two functions:
tst_run_cmd() - redirects cmd's stdout/stderr to file descriptors
tst_run_cmd_rdr_file() - a wrapper around tst_run_cmd(), redirects its output
to files.

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
