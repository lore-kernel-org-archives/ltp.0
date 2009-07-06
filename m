Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MNe6j-0002XE-D6
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 02:39:05 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNe6Z-0005hc-Vf
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 02:39:00 +0000
From: Jiri Palecek <jpalecek@web.de>
Date: Mon, 6 Jul 2009 03:37:44 +0200
References: <4A4490B2.4070803@bull.net>
In-Reply-To: <4A4490B2.4070803@bull.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200907060337.46824.jpalecek@web.de>
Subject: Re: [LTP] clock_nanosleep01 TestCase FAIL --> is it known?
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
To: Jacky Malcles <Jacky.Malcles@bull.net>
Cc: ltp-list@lists.sourceforge.net, maknayak@in.ibm.com

On Friday 26 June 2009 11:11:14 Jacky Malcles wrote:
> is it a testcase issue? (because case05 ends with OK).

Yes.

Regards
    Jiri Palecek

> report:
> [root@xena3 clock_nanosleep]# ./clock_nanosleep01
> clock_nanosleep01    0  INFO  :  (case00) START
> clock_nanosleep01    0  INFO  :  check sleep time: (min:480) < 507 < 
> (max:520) (msec)
> clock_nanosleep01    0  INFO  :  remain time: 191 5658608
> EXPECT: return value(ret)=0 errno=0 (Success), remain time check=OK
> RESULT: return value(ret)=0 errno=0 (Success), remain time check=NG
> clock_nanosleep01    0  INFO  :  (case00) END => NG
> clock_nanosleep01    0  INFO  :  (case01) START
> clock_nanosleep01    0  INFO  :  check sleep time: (min:480) < 509 < 
> (max:520) (msec)
> clock_nanosleep01    0  INFO  :  remain time: 191 5658608
> EXPECT: return value(ret)=0 errno=0 (Success), remain time check=OK
> RESULT: return value(ret)=0 errno=0 (Success), remain time check=NG
> clock_nanosleep01    0  INFO  :  (case01) END => NG
> clock_nanosleep01    0  INFO  :  (case02) START
> clock_nanosleep01    0  INFO  :  remain time: 191 5658608
> EXPECT: return value(ret)=22 errno=0 (Success), remain time check=OK
> RESULT: return value(ret)=22 errno=0 (Success), remain time check=NG
> clock_nanosleep01    0  INFO  :  (case02) END => NG
> clock_nanosleep01    0  INFO  :  (case03) START
> clock_nanosleep01    0  INFO  :  remain time: 191 5658608
> EXPECT: return value(ret)=22 errno=0 (Success), remain time check=OK
> RESULT: return value(ret)=22 errno=0 (Success), remain time check=NG
> clock_nanosleep01    0  INFO  :  (case03) END => NG
> clock_nanosleep01    0  INFO  :  (case04) START
> clock_nanosleep01    0  INFO  :  remain time: 191 5658608
> EXPECT: return value(ret)=95 errno=0 (Success), remain time check=OK
> RESULT: return value(ret)=22 errno=0 (Success), remain time check=NG
> clock_nanosleep01    0  INFO  :  (case04) END => NG
> clock_nanosleep01    0  INFO  :  (case05) START
> clock_nanosleep01    0  INFO  :  remain time: 9 490280000
> EXPECT: return value(ret)=4 errno=0 (Success)
> RESULT: return value(ret)=4 errno=0 (Success)
> clock_nanosleep01    0  INFO  :  (case05) END => OK
> clock_nanosleep01    1  FAIL  :  clock_nanosleep01 failed - errno = 0 : 
> Success
> clock_nanosleep01    0  INFO  :  NG
> [root@xena3 clock_nanosleep]#
> thanks,
> 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
