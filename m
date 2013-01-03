Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bounces@nabble.com>) id 1Tqn8R-00016c-6e
	for ltp-list@lists.sourceforge.net; Thu, 03 Jan 2013 15:55:11 +0000
Received: from sam.nabble.com ([216.139.236.26])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Tqn8Q-0008HC-2F
	for ltp-list@lists.sourceforge.net; Thu, 03 Jan 2013 15:55:11 +0000
Received: from telerig.nabble.com ([192.168.236.162])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <bounces@nabble.com>) id 1Tqn8K-0002Aj-Hd
	for ltp-list@lists.sourceforge.net; Thu, 03 Jan 2013 07:55:04 -0800
Message-ID: <34855531.post@talk.nabble.com>
Date: Thu, 3 Jan 2013 07:55:04 -0800 (PST)
From: bhushan kumar <Bhushan.Kumar@mphasis.com>
MIME-Version: 1.0
Subject: [LTP] sendfile commands fails for LTP tcp network stress test
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
To: ltp-list@lists.sourceforge.net


Hi,
As i was  running network stress test for tcp_cmds
 then sendfile01  test script gets hangs.As after obseving output it seems
that it hangs during execution  of below mention statment.i.e 
=========
rsh -n -l root $IPADDR "$TCsrc/SF_Server $IPADDR $PORT $TCsrc"
==================

I shall be thankful for any suggetion or any hints. 

Thanks and Regards,
Bhushan kumar
-- 
View this message in context: http://old.nabble.com/sendfile-commands-fails-for-LTP-tcp-network-stress-test-tp34855531p34855531.html
Sent from the ltp-list mailing list archive at Nabble.com.


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
