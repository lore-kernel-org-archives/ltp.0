Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vpuliyal@in.ibm.com>) id 1ZL5qR-00082n-Dm
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2015 08:39:11 +0000
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZL5qO-0001uf-RD
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2015 08:39:11 +0000
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <vpuliyal@in.ibm.com>;
	Fri, 31 Jul 2015 13:38:43 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id B2D511258068
	for <Ltp-list@lists.sourceforge.net>;
	Fri, 31 Jul 2015 13:41:45 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	t6V88W5c57016554
	for <Ltp-list@lists.sourceforge.net>; Fri, 31 Jul 2015 13:38:35 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	t6V88V3v013725
	for <Ltp-list@lists.sourceforge.net>; Fri, 31 Jul 2015 13:38:31 +0530
MIME-Version: 1.0
Message-ID: <OF65A761E0.9AA157C2-ON65257E93.002B0BBB-65257E93.002CB911@in.ibm.com>
From: Vijay K Puliyala <vpuliyal@in.ibm.com>
Date: Fri, 31 Jul 2015 13:38:29 +0530
Subject: Re: [LTP] : Test Cases for libnuma
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1547214949130251015=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: Ltp-list@lists.sourceforge.net

This is a multipart message in MIME format.
--===============1547214949130251015==
Content-Type: multipart/alternative;
	boundary="=_alternative 002CB91065257E93_="

This is a multipart message in MIME format.
--=_alternative 002CB91065257E93_=
Content-Type: text/plain; charset="US-ASCII"

Hi Subrata,

I have installed LTP on SUSE.  I want to run numa testcases.  I have done 
below steps to run numa.

_______________________________________________________________________

perf2877:/vijay/NUMA/ltp-full-20150420 # ./runltp -f numa
FATAL: LTP not installed correctly
INFO:  Follow directions in INSTALL!

______________________________________________________________________

perf2877:/vijay/NUMA/ltp-full-20150420 # /opt/ltp/runltp -f numa

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=move_pages11 stime=1438256071
cmdline="cd $LTPROOT/testcases/bin && chown root move_pages11 && chmod 
04755 move_pages11 && move_pages.sh 11"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
move_pages11    1  TCONF  :  move_pages_support.c:412: NUMA support not 
provided
move_pages11    2  TCONF  :  move_pages_support.c:412: Remaining cases not 
appropriate for configuration
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20150420

       ###############################################################

            Done executing testcases.
            LTP Version:  20150420
       ###############################################################


But if I run only  "/opt/ltp/runltp" with out any options or with out " -f 
numa " option  it is giving results.
____________________________________________________________________________
If I run numa01.sh I am getting below errors.
perf2877:/vijay/NUMA/ltp-full-20150420/testcases/kernel/numa # ./numa01.sh
./numa01.sh: line 66: tst_brkm: command not found
./numa01.sh: line 784: tst_resm: command not found
./numa01.sh: line 215: tst_resm: command not found
___________________________________________________________________


Please correct me if I have done any mistake. 

I have installed  below packages 

perf2877:/opt/ltp # rpm -q libnuma-devel
libnuma-devel-2.0.9-5.1.1
perf2877:/opt/ltp # rpm -q libnuma1
libnuma1-2.0.9-5.1.1
perf2877:/opt/ltp # rpm -q libnuma-devel
libnuma-devel-2.0.9-5.1.1
perf2877:/opt/ltp # rpm -q autoconf
autoconf-2.69-9.3
perf2877:/opt/ltp # rpm -q automake
automake-1.10.1-4.131.9.1
perf2877:/opt/ltp #

Also please add me in mailing list.


Thanks
Vijay Kumar

--=_alternative 002CB91065257E93_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi Subrata,</font>
<br>
<br><font size=2 face="sans-serif">I have installed LTP on SUSE. &nbsp;I
want to run numa testcases. &nbsp;I have done below steps to run numa.</font>
<br>
<br><font size=2 face="sans-serif">_______________________________________________________________________</font>
<br>
<br><font size=2 face="sans-serif">perf2877:/vijay/NUMA/ltp-full-20150420
# ./runltp -f numa</font>
<br><font size=2 face="sans-serif">FATAL: LTP not installed correctly</font>
<br><font size=2 face="sans-serif">INFO: &nbsp;Follow directions in INSTALL!</font>
<br>
<br><font size=2 face="sans-serif">______________________________________________________________________</font>
<br>
<br><font size=2 face="sans-serif">perf2877:/vijay/NUMA/ltp-full-20150420
# /opt/ltp/runltp -f numa</font>
<br>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=32
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=0 cstime=0</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_start&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">tag=move_pages11 stime=1438256071</font>
<br><font size=2 face="sans-serif">cmdline=&quot;cd $LTPROOT/testcases/bin
&amp;&amp; chown root move_pages11 &amp;&amp; chmod 04755 move_pages11
&amp;&amp; move_pages.sh 11&quot;</font>
<br><font size=2 face="sans-serif">contacts=&quot;&quot;</font>
<br><font size=2 face="sans-serif">analysis=exit</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">incrementing stop</font>
<br><font size=2 face="sans-serif">move_pages11 &nbsp; &nbsp;1 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412:<b> NUMA support not provided</b></font>
<br><font size=2 face="sans-serif">move_pages11 &nbsp; &nbsp;2 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: Remaining cases not appropriate
for configuration</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=32
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=0 cstime=0</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif"><b><i>INFO: ltp-pan reported some tests
FAIL</i></b></font>
<br><font size=2 face="sans-serif">LTP Version: 20150420</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp;###############################################################</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Done executing testcases.</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
LTP Version: &nbsp;20150420</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp;###############################################################</font>
<br>
<br>
<br><font size=2 face="sans-serif">But if I run only &nbsp;&quot;/opt/ltp/runltp&quot;
with out any options or with out &quot; -f numa &quot; option &nbsp;it
is giving results.</font>
<br><font size=2 face="sans-serif">____________________________________________________________________________</font>
<br><font size=2 face="sans-serif">If I run numa01.sh I am getting below
errors.</font>
<br><font size=2 face="sans-serif">perf2877:/vijay/NUMA/ltp-full-20150420/testcases/kernel/numa
# ./numa01.sh</font>
<br><font size=2 face="sans-serif">./numa01.sh: line 66: tst_brkm: command
not found</font>
<br><font size=2 face="sans-serif">./numa01.sh: line 784: tst_resm: command
not found</font>
<br><font size=2 face="sans-serif">./numa01.sh: line 215: tst_resm: command
not found</font>
<br><font size=2 face="sans-serif">___________________________________________________________________</font>
<br>
<br>
<br><font size=2 face="sans-serif">Please correct me if I have done any
mistake. </font>
<br>
<br><font size=2 face="sans-serif">I have installed &nbsp;below packages
&nbsp;</font>
<br>
<br><font size=2 face="sans-serif">perf2877:/opt/ltp # rpm -q libnuma-devel</font>
<br><font size=2 face="sans-serif">libnuma-devel-2.0.9-5.1.1</font>
<br><font size=2 face="sans-serif">perf2877:/opt/ltp # rpm -q libnuma1</font>
<br><font size=2 face="sans-serif">libnuma1-2.0.9-5.1.1</font>
<br><font size=2 face="sans-serif">perf2877:/opt/ltp # rpm -q libnuma-devel</font>
<br><font size=2 face="sans-serif">libnuma-devel-2.0.9-5.1.1</font>
<br><font size=2 face="sans-serif">perf2877:/opt/ltp # rpm -q autoconf</font>
<br><font size=2 face="sans-serif">autoconf-2.69-9.3</font>
<br><font size=2 face="sans-serif">perf2877:/opt/ltp # rpm -q automake</font>
<br><font size=2 face="sans-serif">automake-1.10.1-4.131.9.1</font>
<br><font size=2 face="sans-serif">perf2877:/opt/ltp #</font>
<br>
<br><font size=2 face="sans-serif">Also please add me in mailing list.</font>
<br>
<br>
<br><font size=2 face="sans-serif">Thanks</font>
<br><font size=2 face="sans-serif">Vijay Kumar</font>
<br>
--=_alternative 002CB91065257E93_=--



--===============1547214949130251015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============1547214949130251015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1547214949130251015==--


