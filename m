Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpradeep@linux.vnet.ibm.com>) id 1OLwCd-0000TH-PV
	for ltp-list@lists.sourceforge.net; Tue, 08 Jun 2010 10:38:39 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OLwCb-0007oK-6A
	for ltp-list@lists.sourceforge.net; Tue, 08 Jun 2010 10:38:39 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id o58AcQ5I018653
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Jun 2010 20:38:26 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o58AcTNg1872032
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Jun 2010 20:38:29 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o58AcTwu002752
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Jun 2010 20:38:29 +1000
Received: from [9.124.158.96] (munipradeep-laptop.in.ibm.com [9.124.158.96])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o58AcS0W002732
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Jun 2010 20:38:28 +1000
From: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Content-Type: multipart/mixed; boundary="=-W1SedfthjySv2KP5nNkr"
Date: Tue, 08 Jun 2010 16:08:26 +0530
Message-ID: <1275993506.5822.37.camel@munipradeep-laptop>
Mime-Version: 1.0
Subject: [LTP]  Patch for echo testcase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--=-W1SedfthjySv2KP5nNkr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

echo test is failing with the below errors as we didn't initialized the
'addrlen' parameter of getsockname.

####################################
...
...
Creating socket .....
echoes      1  TBROK  :  getsockname call failed (pid=7086): Invalid
argument
echo: Invalid argument
...
...
####################################

So, attached the patch which initializes the 'addrlen' parameter.

Please correct if anything is wrong.

Thanks
Muni

--=-W1SedfthjySv2KP5nNkr
Content-Disposition: attachment; filename="echo.patch"
Content-Type: text/x-patch; name="echo.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

--- /ltp-full-20100430/testcases/network/tcp_cmds/echo/echoes.c	2010-06-09 01:20:39.000000000 -0400
+++ /ltp-full-20100430/testcases/network/tcp_cmds/echo/echoes_new.c	2010-06-09 01:20:29.000000000 -0400
@@ -253,6 +253,7 @@
 	}
 
 #ifdef DEBUG
+	addrlen = sizeof(struct sockaddr);
 	/* printf("addrlen=%d\n", addrlen); */
 	/* printf("ai->ai_addr=%s\n", inet_ntoa(ai->ai_addr)); */
 	if (getsockname(s, &address, &addrlen) == -1) {

--=-W1SedfthjySv2KP5nNkr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
--=-W1SedfthjySv2KP5nNkr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=-W1SedfthjySv2KP5nNkr--


