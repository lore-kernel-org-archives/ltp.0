Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Jacky.Malcles@bull.net>) id 1OvWJg-0000gs-Pl
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 14:17:00 +0000
Received: from ecfrec.frec.bull.fr ([129.183.4.8])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OvWJc-0001vs-8T
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 14:17:00 +0000
Message-ID: <4C8F8691.3050808@bull.net>
Date: Tue, 14 Sep 2010 16:28:33 +0200
From: "Jacky.Malcles" <Jacky.Malcles@bull.net>
MIME-Version: 1.0
Subject: [LTP] acltest01 Failed to find an available loopback device
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
To: Garrett Cooper <yanegomi@gmail.com>, ltp-list@lists.sourceforge.net

hi garret,

I get this when running acltest01:

tag=acl_test01 stime=1284123525
cmdline="export TCbin=$LTPROOT/testcases/bin;acl_test01"
contacts=""
analysis=exit
<<<test_output>>>
10240+0 records in
10240+0 records out
10485760 bytes (10 MB) copied, 0.037594 seconds, 279 MB/s
/opt/ltp/testcases/bin/acl_test01: line 128: loop_dev: command not found
acltest01    1  TCONF  :  [ losetup.1 ] Failed to find an available 
loopback device -- is the required support compiled in your kernel?
<<<execution_status>>>
...


So, if you agree, I suggest the following change,
thanks,
Jacky

--- acl_test01.original 2010-09-14 14:49:48.000000000 +0200
+++ acl_test01  2010-09-14 14:50:15.000000000 +0200
@@ -125,7 +125,7 @@ else

        # Avoid hardcoded loopback device values (-f tries to find the first
        # available loopback device name)!
-       if ! (LOOP_DEV=$(loop_dev -f) && [ "x$LOOP_DEV" = x ]); then
+       if ! (LOOP_DEV=$(losetup -f) && [ "x$LOOP_DEV" = x ]); then
                tst_resm TCONF "[ losetup.1 ] Failed to find an 
available loopback device -- is the required support compiled in your 
kernel?"
                exit 0
        fi


-- 
 Jacky Malcles    	     B1-403   Email : Jacky.Malcles@bull.net
 Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
 Tel : 04.76.29.73.14


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
