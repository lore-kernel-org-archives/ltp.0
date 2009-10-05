Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mur2f-0003JU-E4
	for ltp-list@lists.sourceforge.net; Mon, 05 Oct 2009 17:08:09 +0000
Received: from mail-px0-f179.google.com ([209.85.216.179])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mur2e-0004HB-C1
	for ltp-list@lists.sourceforge.net; Mon, 05 Oct 2009 17:08:09 +0000
Received: by pxi9 with SMTP id 9so3154410pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 05 Oct 2009 10:08:01 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 5 Oct 2009 10:08:01 -0700
Message-ID: <364299f40910051008m75f86892n1e32b26dfb76b697@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Issue 1 - indefinite hang with cgroup_regression_test.sh
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
To: LTP list <ltp-list@lists.sourceforge.net>

Hi all,
    I'm just reporting issues as I go and will go back and fix things
from my end as far as missing installation files are concerned, but
these are bugs that will need to be fixed in the individual scripts
that I've noted.
Thanks,
-Garrett

<<<test_start>>>
tag=cgroup stime=1254736274
cmdline="       cgroup_regression_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
cgroup_regression_test    1  TPASS  :  no kernel bug was found
/scratch/ltp-install5/testcases/bin/cgroup_regression_test.sh: line
121:  2884 Terminated              ./fork_processes
cgroup_regression_test    2  TPASS  :  notify_on_release is inherited
cgroup_regression_test    3  TCONF  :  CONFIG_SCHED_DEBUG is not enabled
cgroup_regression_test    4  TCONF  :  CONFIG_LOCKDEP is not enabled
cgroup_regression_test    5  TPASS  :  no kernel bug was found
/scratch/ltp-install5/testcases/bin/cgroup_regression_test.sh: line
296: 12285 Terminated              sleep 100
/scratch/ltp-install5/testcases/bin/cgroup_regression_test.sh: line
316: ./test_6_1.sh: No such file or directory
/scratch/ltp-install5/testcases/bin/cgroup_regression_test.sh: line
325: 12304 Terminated              ./test_6_2
cgroup_regression_test    6  TPASS  :  no kernel bug was found
/scratch/ltp-install5/testcases/bin/cgroup_regression_test.sh: line
363: 13326 Terminated              sleep 100 < cgroup/0
/scratch/ltp-install5/testcases/bin/cgroup_regression_test.sh: line
384: 13345 Terminated              sleep 100 < cgroup/0
cgroup_regression_test    7  TPASS  :  no kernel bug was found

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
