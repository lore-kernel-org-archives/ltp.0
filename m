Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <huruomu@gmail.com>) id 1PQGjU-0005ux-Fv
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 09:54:44 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PQGjT-0002Vt-F6
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 09:54:44 +0000
Received: by wwi18 with SMTP id 18so889872wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Dec 2010 01:54:37 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 8 Dec 2010 17:54:37 +0800
Message-ID: <AANLkTi=Cm3vsEJSXoigxy+brBWy5r9OQJGyyJp+gDk4i@mail.gmail.com>
From: Romu <huruomu@gmail.com>
Subject: [LTP] Problem with su01 and PASSWD
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

Hi all,

I installed ltp 20100831 on RHEL5u6 beta using the following commands:

./configure
make all
make install

I learnt from thread
http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg09967.html
that PASSWD environment variable must be properly set to run su01, so
I ran the tests by the following commands:

cd /opt/ltp
PASSWD=myrootpasswd  ./runltp -p -o /tmp/runalltest.out -l /tmp/runalltest.log

su01 still failed for the first time:

<<<test_start>>>
tag=su01 stime=1291793988
cmdline="export TCbin=$LTPROOT/testcases/bin;su01"
contacts=""
analysis=exit
<<<test_output>>>
Machine type is: redhat-linux

userdel: user su_usr1 does not exist
Creating mailbox file: File exists
userdel: user su_usr2 does not exist
Creating mailbox file: File exists
YOU NEED TO SET ENVIROMENT VARIABLE PASSWD.
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=3 termination_type=exited termination_id=1 corefile=no
cutime=12 cstime=18
<<<test_end>>>

Test output file shows that subsequent su01 tests all passed.

However, I created mysu01 file under /opt/ltp/runtest dir with these lines:

su01 export TCbin=$LTPROOT/testcases/bin;su01
su01 export TCbin=$LTPROOT/testcases/bin;su01
su01 export TCbin=$LTPROOT/testcases/bin;su01
su01 export TCbin=$LTPROOT/testcases/bin;su01

And ran the following command:

PASSWD=myrootpasswd  ./runltp -o /tmp/su01.out -l /tmp/su01.log -p -f mysu01

All 4 tests passed.

Any idea?


Regards,
Simon

------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
