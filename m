Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Jacky.Malcles@bull.net>) id 1MK7TD-0000F1-2T
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2009 09:11:43 +0000
Received: from ecfrec.frec.bull.fr ([129.183.4.8])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MK7T7-00007Y-Da
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2009 09:11:43 +0000
Message-ID: <4A4490B2.4070803@bull.net>
Date: Fri, 26 Jun 2009 11:11:14 +0200
From: Jacky Malcles <Jacky.Malcles@bull.net>
MIME-Version: 1.0
Subject: [LTP] clock_nanosleep01 TestCase FAIL --> is it known?
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
Cc: maknayak@in.ibm.com

is it a testcase issue? (because case05 ends with OK).
report:
[root@xena3 clock_nanosleep]# ./clock_nanosleep01
clock_nanosleep01    0  INFO  :  (case00) START
clock_nanosleep01    0  INFO  :  check sleep time: (min:480) < 507 < 
(max:520) (msec)
clock_nanosleep01    0  INFO  :  remain time: 191 5658608
EXPECT: return value(ret)=0 errno=0 (Success), remain time check=OK
RESULT: return value(ret)=0 errno=0 (Success), remain time check=NG
clock_nanosleep01    0  INFO  :  (case00) END => NG
clock_nanosleep01    0  INFO  :  (case01) START
clock_nanosleep01    0  INFO  :  check sleep time: (min:480) < 509 < 
(max:520) (msec)
clock_nanosleep01    0  INFO  :  remain time: 191 5658608
EXPECT: return value(ret)=0 errno=0 (Success), remain time check=OK
RESULT: return value(ret)=0 errno=0 (Success), remain time check=NG
clock_nanosleep01    0  INFO  :  (case01) END => NG
clock_nanosleep01    0  INFO  :  (case02) START
clock_nanosleep01    0  INFO  :  remain time: 191 5658608
EXPECT: return value(ret)=22 errno=0 (Success), remain time check=OK
RESULT: return value(ret)=22 errno=0 (Success), remain time check=NG
clock_nanosleep01    0  INFO  :  (case02) END => NG
clock_nanosleep01    0  INFO  :  (case03) START
clock_nanosleep01    0  INFO  :  remain time: 191 5658608
EXPECT: return value(ret)=22 errno=0 (Success), remain time check=OK
RESULT: return value(ret)=22 errno=0 (Success), remain time check=NG
clock_nanosleep01    0  INFO  :  (case03) END => NG
clock_nanosleep01    0  INFO  :  (case04) START
clock_nanosleep01    0  INFO  :  remain time: 191 5658608
EXPECT: return value(ret)=95 errno=0 (Success), remain time check=OK
RESULT: return value(ret)=22 errno=0 (Success), remain time check=NG
clock_nanosleep01    0  INFO  :  (case04) END => NG
clock_nanosleep01    0  INFO  :  (case05) START
clock_nanosleep01    0  INFO  :  remain time: 9 490280000
EXPECT: return value(ret)=4 errno=0 (Success)
RESULT: return value(ret)=4 errno=0 (Success)
clock_nanosleep01    0  INFO  :  (case05) END => OK
clock_nanosleep01    1  FAIL  :  clock_nanosleep01 failed - errno = 0 : 
Success
clock_nanosleep01    0  INFO  :  NG
[root@xena3 clock_nanosleep]#
thanks,

-- 
 Jacky Malcles    	     B1-403   Email : Jacky.Malcles@bull.net
 Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
 Tel : 04.76.29.73.14


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
