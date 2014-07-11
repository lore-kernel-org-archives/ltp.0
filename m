Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1X5cAU-0004c6-Pk
	for ltp-list@lists.sourceforge.net; Fri, 11 Jul 2014 14:51:22 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X5cAS-0001X7-Si
	for ltp-list@lists.sourceforge.net; Fri, 11 Jul 2014 14:51:22 +0000
Date: Fri, 11 Jul 2014 10:51:13 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <360014330.8577649.1405090273068.JavaMail.zimbra@redhat.com>
In-Reply-To: <2021B186DC632746BD5A3CE32F12BD28E9EBFBC9@EU-MBX-03.mgc.mentorg.com>
References: <2021B186DC632746BD5A3CE32F12BD28E9EBFBC9@EU-MBX-03.mgc.mentorg.com>
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
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 11 July, 2014 2:00:36 PM
> Subject: [LTP] Shell Scripting - Basics
> 
> Hi Guys,
> 
> I have just started looking into LTP and how test automation can be achieved
> using the platform. While going through the very basics I am stuck on shell
> script writing for LTP. I was following
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#231-basic-shell-test-structure
> and the very first thing that I got hit by was:
> 
> Set variables TCID, TST_TOTAL, and TST_COUNT before each test:
> export TCID=<test name>
> export TST_TOTAL=<Total Number of Tests >
> export TST_COUNT=<Test case number>

Hi,

This output suggests that instead of tst_resm from test.sh,
it ran tst_resm from tools/apicmd.

and somehow this condition from ltpapicmd.c was true:
if (!strcmp(cmd_name, "tst_kvercmp") &&
    !strcmp(cmd_name, "tst_kvercmp2") &&
    !strcmp(cmd_name, "tst_get_unused_port")) {

That's the only place where I can see this message. I'm assuming you
are using latest git LTP.

Can you send your whole script and command how you run it?
What shell are you using? (ls -la /bin/sh)

If I try the example from 2.3.1 with 'false', it fails as expected:

$ cd /usr/src/ltp/testcases/lib

$ cat foo.sh
#!/bin/sh
#
# This is a basic test for true shell buildin
#

TCID=true01
TST_TOTAL=1
. test.sh

false
ret=$?

if [ $ret -eq 0 ]; then
        tst_resm TPASS "true returned 0"
else
        tst_resm TFAIL "true rturned $ret"
fi

tst_exit

$ PATH=.:$PATH sh ./foo.sh
true01 1 TFAIL : true rturned 1

$ echo $?
1

Regards,
Jan

> 
> so I exported the variables in the above mentioned shell script (is the
> current wiki wrong???), the test passed as it should and I thought I was
> done and I understand, but then when I tried to make the test fail by doing
> the following:
> 
> true ret = $?
> replaced with
> false ret = $?
> 
> the test still reports success :(
> 
> tst_exit says:
> "Exits the tests, note that this function has no parameters, the PASSES/FAILS
> reported by the tst_resm() interfaces were stored and are used for the exit
> value."
> 
> If I explicitly write an 'exit 1' at the end of the testcase, it fails but I
> believe that shouldn't be the case (using an explicit return shouldn't be
> needed if tst_exit is being used)... What am I missing? (a brain perhaps...
> :S)
> 
> BR,
> Awais
> 
> ------------------------------------------------------------------------------
> Open source business process management suite built on Java and Eclipse
> Turn processes into business applications with Bonita BPM Community Edition
> Quickly connect people, data, and systems into organized workflows
> Winner of BOSSIE, CODIE, OW2 and Gartner awards
> http://p.sf.net/sfu/Bonitasoft
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
