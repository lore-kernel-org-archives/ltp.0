Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huruomu@gmail.com>) id 1RQyas-00034z-FB
	for ltp-list@lists.sourceforge.net; Thu, 17 Nov 2011 09:49:18 +0000
Received: from mail-pz0-f43.google.com ([209.85.210.43])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RQyar-0005m1-L4
	for ltp-list@lists.sourceforge.net; Thu, 17 Nov 2011 09:49:18 +0000
Received: by pzk34 with SMTP id 34so1877022pzk.2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 17 Nov 2011 01:49:11 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 17 Nov 2011 17:49:11 +0800
Message-ID: <CANoG8sVidgJ-=eRjbk7L-NSajQzMqQr24wFAYSW3FU8ChzL4ow@mail.gmail.com>
From: Romu <huruomu@gmail.com>
Subject: [LTP] Strange output of fork13 testcase
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

Please see the following fork13 test output:

<<<test_start>>>
tag=fork13 stime=1321633957
cmdline="fork13 -c 2 -i 1000000"
contacts=""
analysis=exit
<<<test_output>>>
fork13      1  TPASS  :  1000000 pids forked, all passed
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=242 termination_type=exited termination_id=0 corefile=no
cutime=397 cstime=11317
<<<test_end>>>
fork13      1  TBROK  :  unexpected signal 15 received (pid = 2046).
fork13      2  TBROK  :  Remaining cases broken
INFO: ltp-pan reported all tests PASS
LTP Version: LTP-20110915

       ###############################################################"

            Done executing testcases."
            LTP Version:  LTP-20110915
       ###############################################################"

There are both TPASS and TFAIL in output.

Any idea?

Thanks
Romu

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
