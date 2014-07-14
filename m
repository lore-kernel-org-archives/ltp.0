Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1X6eac-0000Te-Ku
	for ltp-list@lists.sourceforge.net; Mon, 14 Jul 2014 11:38:38 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X6eab-0002rE-2P
	for ltp-list@lists.sourceforge.net; Mon, 14 Jul 2014 11:38:38 +0000
Date: Mon, 14 Jul 2014 07:38:30 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1027690389.9585314.1405337910298.JavaMail.zimbra@redhat.com>
In-Reply-To: <2021B186DC632746BD5A3CE32F12BD28E9EC1001@EU-MBX-03.mgc.mentorg.com>
References: <2021B186DC632746BD5A3CE32F12BD28E9EBFBC9@EU-MBX-03.mgc.mentorg.com>
	<360014330.8577649.1405090273068.JavaMail.zimbra@redhat.com>
	<2021B186DC632746BD5A3CE32F12BD28E9EC0EE0@EU-MBX-03.mgc.mentorg.com>
	<1009226398.9458190.1405324789944.JavaMail.zimbra@redhat.com>
	<2021B186DC632746BD5A3CE32F12BD28E9EC0F1A@EU-MBX-03.mgc.mentorg.com>
	<2021B186DC632746BD5A3CE32F12BD28E9EC1001@EU-MBX-03.mgc.mentorg.com>
MIME-Version: 1.0
Subject: Re: [LTP] Shell Scripting - Basics
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
To: Awais Belal <Awais_Belal@mentor.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Awais Belal" <Awais_Belal@mentor.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Monday, 14 July, 2014 12:03:19 PM
> Subject: RE: [LTP] Shell Scripting - Basics
> 
> Hi Jan,
> 
> Can you please confirm that this is a bug and if so, how can it be fixed.
> Also, why do we have these multiple test.sh files if the one in the 'lib'
> folder is the correct one?

I think it's a bug, I've sent a patch to rename those scripts in fs-bench dir.

Regards,
Jan

> 
> BR,
> Awais
> 
> ________________________________________
> From: Belal, Awais
> Sent: Monday, July 14, 2014 1:27 PM
> To: Jan Stancek
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] Shell Scripting - Basics
> 
> Hi Jan,
> 
> You've nailed it I think. I replaced the files and it worked.
> 
> Thanks a lot!
> 
> BR,
> Awais
> 
> ________________________________________
> From: Jan Stancek [jstancek@redhat.com]
> Sent: Monday, July 14, 2014 12:59 PM
> To: Belal, Awais
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] Shell Scripting - Basics
> 
> ----- Original Message -----
> > From: "Awais Belal" <Awais_Belal@mentor.com>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: ltp-list@lists.sourceforge.net
> > Sent: Monday, 14 July, 2014 9:41:20 AM
> > Subject: RE: [LTP] Shell Scripting - Basics
> >
> > Hi Jan,
> >
> > Thanks for taking the time out to bear my newbie-ness...
> >
> > I am running this on an mx6q platform.
> >
> > root@mx6q:~# ls -la /bin/sh
> > lrwxrwxrwx 1 root root 20 Jul 10 2014 /bin/sh -> /etc/alternatives/sh
> >
> > Then PATH setting is as follows:
> >
> > root@mx6q:~#
> > root@mx6q:~# cd /opt/ltp/
> > IDcheck.sh bin/ results/ runltplite.sh testcases/
> > Version runalltests.sh runtest/ testscripts/
> > abcd output/ runltp scenario_groups/ ver_linux
> > root@mx6q:~# cd /opt/ltp/
> > root@mx6q:/opt/ltp#
> > root@mx6q:/opt/ltp#
> > root@mx6q:/opt/ltp# echo $PATH
> > /usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
> > root@mx6q:/opt/ltp#
> > root@mx6q:/opt/ltp#
> > root@mx6q:/opt/ltp# export PATH=$PATH:/opt/ltp/testcases/bin/
> > root@mx6q:/opt/ltp#
> > root@mx6q:/opt/ltp# echo $PATH
> > /usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/ltp/testcases/bin/
> >
> > /opt/ltp/testcases/bin/ is where I have test.sh present. Now the testcase:
> >
> > root@mx6q:/opt/ltp/testcases/bin# cat foo.sh
> > #!/bin/sh
> > #
> > # This is a basic test for true shell buildin
> > #
> >
> > TCID=true01
> > TST_TOTAL=1
> > . test.sh
> >
> > false
> > ret=$?
> >
> > if [ $ret -eq 0 ]; then
> > tst_resm TPASS "true returned 0"
> > else
> > tst_resm TFAIL "true rturned $ret"
> > fi
> >
> > tst_exit
> > root@mx6q:/opt/ltp/testcases/bin#
> > root@mx6q:/opt/ltp/testcases/bin#
> > root@mx6q:/opt/ltp/testcases/bin#
> > root@mx6q:/opt/ltp/testcases/bin# ./foo.sh
> > ## Start Test
> > Thu Jan 1 00:10:59 UTC 1970
> > 659
> >
> > ## Create files
> > /opt/ltp/testcases/bin/test.sh: line 14: /home/root/fs-bench/cr: No such
> > file
> > or directory
> >
> > real 0m0.004s
> > user 0m0.000s
> > sys 0m0.000s
> >
> > ## tar all
> > tar: invalid option -- 'B'
> > BusyBox v1.21.1 (2014-07-10 15:06:02 PKT) multi-call binary.
> >
> > Usage: tar -[cxtzJjhmvO] [-X FILE] [-T FILE] [-f TARFILE] [-C DIR]
> > [FILE]...
> >
> >
> > ## Change owner
> > chown: ./00: No such file or directory
> >
> > real 0m0.010s
> > user 0m0.000s
> > sys 0m0.000s
> >
> > ## random access
> > /opt/ltp/testcases/bin/test.sh: line 26: /home/root/fs-bench/ra: No such
> > file
> > or directory
> >
> > real 0m0.002s
> > user 0m0.000s
> > sys 0m0.000s
> >
> > ## Change mode
> > chmod: ./00: No such file or directory
> >
> > real 0m0.009s
> > user 0m0.000s
> > sys 0m0.000s
> >
> > ## Random delete and create
> > /opt/ltp/testcases/bin/test.sh: line 34: /home/root/fs-bench/radc: No such
> > file or directory
> >
> > real 0m0.002s
> > user 0m0.000s
> > sys 0m0.000s
> >
> > ## Change mode again
> > chmod: ./00: No such file or directory
> >
> > real 0m0.008s
> > user 0m0.000s
> > sys 0m0.000s
> >
> > ## Remove all files and directories
> >
> > real 0m0.007s
> > user 0m0.000s
> > sys 0m0.000s
> >
> > ## Finish test
> > 659
> > Thu Jan 1 00:10:59 UTC 1970
> > TOTAL(seconds): 0
> >
> > Set variables TCID, TST_TOTAL, and TST_COUNT before each test:
> > export TCID=<test name>
> > export TST_TOTAL=<Total Number of Tests >
> > export TST_COUNT=<Test case number>
> >
> > ./foo.sh: line 17: 520 Aborted tst_resm TFAIL "true rturned $ret"
> >
> > Set variables TCID, TST_TOTAL, and TST_COUNT before each test:
> > export TCID=<test name>
> > export TST_TOTAL=<Total Number of Tests >
> > export TST_COUNT=<Test case number>
> >
> > ./foo.sh: line 19: 521 Aborted tst_exit
> > root@mx6q:/opt/ltp/testcases/bin#
> > root@mx6q:/opt/ltp/testcases/bin#
> > root@mx6q:/opt/ltp/testcases/bin# echo $?
> > 134
> > root@mx6q:/opt/ltp/testcases/bin#
> >
> > LTP versioning:
> > LTP Version: 20140115
> >
> > I'll be trying this out on a simple desktop now, just to confirm, in the
> > meantime please point out anything you see is out of place...
> 
> Hi,
> 
> the test.sh seems to be clashing with "testcases/kernel/fs/fs-bench/test.sh"
> during install part. (looks like bug in LTP)
> The one I'd expect to be there is "testcases/lib/test.sh".
> 
> Can you copy $LTP/testcases/lib/test.sh to /opt/ltp/testcases/bin
> and re-run your foo.sh script?
> (You'll need to overwrite existing test.sh in /opt/ltp/testcases/bin)
> 
> Regards,
> Jan
> 
> >
> > BR,
> > Awais
> >
> 
> 
> ------------------------------------------------------------------------------
> Want fast and easy access to all the code in your enterprise? Index and
> search up to 200,000 lines of code with a free copy of Black Duck&#174;
> Code Sight&#153; - the same software that powers the world's largest code
> search on Ohloh, the Black Duck Open Hub! Try it now.
> http://p.sf.net/sfu/bds
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck&#174;
Code Sight&#153; - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
