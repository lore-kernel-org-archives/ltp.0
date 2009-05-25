Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <srinivass@in.ibm.com>) id 1M8U3r-0004pB-B0
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 06:53:27 +0000
Received: from e28smtp03.in.ibm.com ([59.145.155.3])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M8U3m-0000in-Ru
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 06:53:27 +0000
Message-ID: <OF0C37E154.CA4A0A35-ON652575C1.00256153-652575C1.0025D2AB@in.ibm.com>
From: Srinivasan Subramanian3 <srinivass@in.ibm.com>
Date: Mon, 25 May 2009 12:20:43 +0530
MIME-Version: 1.0
Subject: [LTP] LTP on System z: runltp segfaults on RHEL 4
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
To: ltp-list@lists.sf.net


Hello all,

When i ran the runltp script on a RHEL4.8 (64 bit machine) on System z, it
seg faulted..

Running tests.......
./runltp: line 166: 20024 Segmentation fault      ${LTPROOT}/pan/ltp-pan
$QUIET_MODE -e -S $INSTANCES $DURATION -a $$ -n $$ $PRETTY_PRT -f
${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20090430

uname -r
2.6.9-89.EL

cat /etc/issue
Red Hat Enterprise Linux AS release 4 (Nahant Update 8)

Thanks in advance &
---------------------------------
Best Regards,
Srinivasan S,
Linux on System z, LTC
srinivass@in.ibm.com
srinivass@linux.vnet.ibm.com
----------------------------------




------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
