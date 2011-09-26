Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huruomu@gmail.com>) id 1R87YK-0001Yi-RD
	for ltp-list@lists.sourceforge.net; Mon, 26 Sep 2011 09:32:44 +0000
Received: from mail-qy0-f182.google.com ([209.85.216.182])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1R87YK-0004gv-9K
	for ltp-list@lists.sourceforge.net; Mon, 26 Sep 2011 09:32:44 +0000
Received: by qyk4 with SMTP id 4so6493664qyk.13
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Sep 2011 02:32:38 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 26 Sep 2011 17:32:38 +0800
Message-ID: <CANoG8sVO2gf6xOS6=Hebireanodoff77PYWS=scnYTNoRpKrzA@mail.gmail.com>
From: Romu <huruomu@gmail.com>
Subject: [LTP] sysctl03 fails while all tests in it passes
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

sysctl03 in ltp-20110915 fails on 2.6.39 kernel, however, all tests in
it passed:

<<<test_start>>>
tag=sysctl03 stime=1317032092
cmdline="sysctl03"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
sysctl03    0  TWARN  :  this test's results are based on potentially
undocumented behavior in the kernel. read the NOTE in the source file
for more details
sysctl03    1  TPASS  :  Got expected error: TEST_ERRNO=EACCES(13):
Permission denied
sysctl03    2  TPASS  :  Got expected error: TEST_ERRNO=EACCES(13):
Permission denied
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=4 corefile=no
cutime=0 cstime=0
<<<test_end>>>

Any idea?

Thanks,
Romu

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
