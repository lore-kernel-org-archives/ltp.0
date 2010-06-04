Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1OKOky-0008Rl-Hu
	for ltp-list@lists.sourceforge.net; Fri, 04 Jun 2010 04:43:44 +0000
Received: from out14.sjc.mx.trendmicro.com ([216.99.131.51])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OKOkw-0007rM-H6
	for ltp-list@lists.sourceforge.net; Fri, 04 Jun 2010 04:43:44 +0000
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.22])
	by out14.sjc.mx.trendmicro.com (Postfix) with ESMTP id 25A7898041D
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Jun 2010 04:43:36 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 7FABE3DD01B
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Jun 2010 04:43:35 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 4 Jun 2010 13:43:34 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 4 Jun 2010 13:43:34 +0900
Message-ID: <000301cb03a0$7d449b50$77cdd1f0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] "mail" test failure
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

I ran "mail" test in RHEL system.
But "#2" test of "mail_test.sh" failed:

------------<log>
mail_tests::setup    0  TINFO  :  INIT: Removing all mails for mail_test and
root
mail_tests::mail01    0  TINFO  :  Test #1: mail root@localhost will send
mail to root
mail_tests::mail01    0  TINFO  :  Test #1: user on local machine.
mail_tests::mail01    1  TPASS  :  Test #1: Mail was sent to root & was
received
mail_tests::mail02    0  TINFO  :  Test #2: mail user@bad-domain will result
in failure
mail_tests::mail02    0  TINFO  :  Test #2: to deliver the mail. Mailer
daemon should
mail_tests::mail02    0  TINFO  :  Test #2: report this failure.
mail_tests::mail02    2  TFAIL  :  Test #2: No new mail for root. Reason:
No mail for root
mail_tests::mail03    0  TINFO  :  Test #3: mail non_existent_user@localhost
will fail
mail_tests::mail03    0  TINFO  :  Test #3: to deliver the mail. Mailer
daemon should
mail_tests::mail03    0  TINFO  :  Test #3: report this failure.
mail_tests::mail03    3  TPASS  :  Test #3: Mailer-Daemon reported delivery
failure
mail_tests::mail04    0  TINFO  :  Test #4: Test that mail -c user@domain
will
mail_tests::mail04    0  TINFO  :  Test #4: carbon copy user@domain
mail_tests::mail04    4  TPASS  :  Test #4: Mail was carbon copied to user
mail_test
mail_tests::mail05    0  TINFO  :  Test #5: Test that mail -b user@domain
will
mail_tests::mail05    0  TINFO  :  Test #5: blind carbon copy user@domain
mail_tests::mail05    5  TPASS  :  Test #5: Mail was carbon copied to user
mail_test
mail_tests::cleanup    0  TINFO  :  Test CLEAN: Removing temporary files
from /tmp
mail_tests::cleanup    0  TINFO  :  Test CLEAN: Removing temporary user
mail_test
------------

I use RHEL5.4 and RHEL4.8 system, and use x86, x86_64 and ia64
architectures.
"#2" test failed in all combinations.



"#2" and "#3" tests are failure tests.
"#2" sends mail to "root@thisdomaindoesnotexist" and 
"#3" sends mail to "non_existent_user@localhost".

"#3" test passed, but "#2" test failed.

After these tests, there is information of "#3" mail in
"/var/spool/mail/root".
But there is no information of "#2" mail.
Therefore "$LTPTMP/tst_mail.res" analysis isn't possible, and "#2" failed.



I simulate these tests by the method along "mail_tests.sh": 
------------<log of #3>
[root@RHEL4-8 ltp]# cat /var/spool/mail/root
cat: /var/spool/mail/root: No such file or directory
[root@RHEL4-8 ltp]# cat mail.txt
This is a test email.
[root@RHEL4-8 ltp]# mail -s "Test" non_existent_user@localhost < mail.txt >
mail.out 2>&1
[root@RHEL4-8 ltp]# echo $?
0
[root@RHEL4-8 ltp]# tail -n 10 /var/spool/mail/root
Date: Fri, 4 Jun 2010 12:42:37 +0900
From: root <root>
Message-Id: <201006040342.o543gbcQ006792@RHEL4-8.localdomain>
To: non_existent_user@RHEL4-8.localdomain
Subject: Test

This is a test email.

--o543gbcR006792.1275622958/RHEL4-8.localdomain--

[root@RHEL4-8 ltp]# echo "d" | mail -u root > mail.res 2>&1
[root@RHEL4-8 ltp]# echo $?
0
[root@RHEL4-8 ltp]# cat mail.res
Mail version 8.1 6/6/93.  Type ? for help.
"/var/mail/root": 1 message 1 new
>N  1 MAILER-DAEMON@RHEL4-  Fri Jun  4 12:42  68/2521  "Returned mail: see
tr"
[root@RHEL4-8 ltp]#
------------

------------<log of #2>
#
[root@RHEL4-8 ltp]# cat /var/spool/mail/root
cat: /var/spool/mail/root: No such file or directory
[root@RHEL4-8 ltp]# cat mail.txt
This is a test email.
[root@RHEL4-8 ltp]# mail -s "Test" root@thisdomaindoesnotexist < mail.txt >
mail.out 2>&1
[root@RHEL4-8 ltp]# echo $?
0
[root@RHEL4-8 ltp]# tail -n 10 /var/spool/mail/root
tail: cannot open `/var/spool/mail/root' for reading: No such file or
directory
[root@RHEL4-8 ltp]# echo "d" | mail -u root > mail.res 2>&1
[root@RHEL4-8 ltp]# echo $?
1
[root@RHEL4-8 ltp]# cat mail.res
No mail for root
[root@RHEL4-8 ltp]#
------------

In "#2" test, there isn't expected information.
Therefore RC1, RC2 and RC3 (resolt of "$LTPTMP/tst_mail.res" analysis)
are all 0, and "#2" failed.


In RHEL systems, the resolts are as above.
I want to revise this test to match RHEL systems.
I'm glad if I can know how about the results in other systems.


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
