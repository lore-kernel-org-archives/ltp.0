Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NmV8C-0006qF-8K
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 16:39:36 +0000
Received: from mail-fx0-f214.google.com ([209.85.220.214])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NmV8A-0001AF-W9
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 16:39:36 +0000
Received: by fxm6 with SMTP id 6so514843fxm.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 02 Mar 2010 08:39:21 -0800 (PST)
References: <OF3DD1AE6A.65D45C56-ON652576DA.002F585D-652576DA.00384F54@in.ibm.com>
Message-Id: <BB670926-F9B2-4718-AD8B-B69985C39308@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <OF3DD1AE6A.65D45C56-ON652576DA.002F585D-652576DA.00384F54@in.ibm.com>
Mime-Version: 1.0 (iPhone Mail 7E18)
Date: Tue, 2 Mar 2010 08:39:11 -0800
Subject: Re: [LTP] LTP's filecaps test gives false positive results
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3937543443038213950=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Iranna D Ankad <iranna.ankad@in.ibm.com>
Cc: Rishikesh K Rajak <risrajak@in.ibm.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Serge E Hallyn <sergeh@us.ibm.com>


--===============3937543443038213950==
Content-Type: multipart/alternative;
	boundary=Apple-Mail-1--669538866
Content-Transfer-Encoding: 7bit


--Apple-Mail-1--669538866
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Mar 2, 2010, at 2:11 AM, Iranna D Ankad <iranna.ankad@in.ibm.com>  
wrote:

>
> Hello ..
> When I am trying to run LTP's filecaps test, it does not actually  
> run the test, but ltp-pan report test PASSED.
> This is happening in the latest LTP (ltp-full-20100228), including  
> couple of past LTP releases (ex. November, December releases)


> remove test cases which require the block device.
> You can specify it with option -b
> COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 12064     -n 12064  -p   
> -f /tmp/ltp-P00GfUUqLS/alltests -l /opt/ltp/results/ 
> LTP_RUN_ON-2010_Mar_02-04h_14m_57s.log  -C /opt/ltp/output/ 
> LTP_RUN_ON-2010_Mar_02-04h_14m_57s.failed
> LOG File: /opt/ltp/results/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.log
> FAILED COMMAND File: /opt/ltp/output/ 
> LTP_RUN_ON-2010_Mar_02-04h_14m_57s.failed
> Running tests.......
> <<<test_start>>>
> tag=Filecaps stime=1267521297
> cmdline="filecapstest.sh"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> Filecaps 0 CONF : System doesn't support execution of the test
> setcap not installed. Please install libcap-2.11 or newer from
> ftp://ftp.kernel.org/pub/linux/libs/security/linux-privs/libcap2
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=0 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>
> INFO: ltp-pan reported all tests PASS
> LTP Version: LTP-20100131

The _libraries and apps_ are installed, not the _headers_.

> LTP reports setcap is installed, but actually, my system has setcap  
> installed, along with all required libcap related rpms.
>
> mx3950:/opt/ltp # setc
> setcap      setconsole  setctsid
> mx3950:/opt/ltp #
>
> mx3950:/opt/ltp # rpm -qa | grep cap
> libcap1-1.10-6.10
> libcap2-2.11-2.15
> libcap-progs-2.11-2.15
> libpcap0-0.9.8-50.4.32
> libcap2-32bit-2.11-2.15
> libcap1-32bit-1.10-6.10
> mx3950:/opt/ltp #
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> ---------------------------------------------------------------------
>
>
> Here is the false positive log, which shows test PASSED, without  
> actually running the test.

The problem is that TCONF should return 0 (in this case the library's  
functionality isn't available on the running system, so the tests  
can't be run).

I don't see a problem with this 'error' -- the problem I see that  
needs to be rectified is the -devel packages need to be installed on  
the machine.

> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> --- 
> ---------------------------------------------------------------------
>
> mx3950:/opt/ltp # cat results/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.log
> Test Start Time: Tue Mar  2 04:14:57 2010
> -----------------------------------------
> Testcase                       Result     Exit Value
> --------                       ------     ----------
> Filecaps                       PASS       0
> -----------------------------------------------
> Total Tests: 1
> Total Failures: 0
> Kernel Version: 2.6.32.8-default
> Machine Architecture: x86_64
> Hostname: mx3950
>
> mx3950:/opt/ltp #

Thanks,
-Garrett
--Apple-Mail-1--669538866
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: 7bit

<html><body bgcolor="#FFFFFF"><div><span class="Apple-style-span" style="-webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); -webkit-composition-fill-color: rgba(175, 192, 227, 0.230469); -webkit-composition-frame-color: rgba(77, 128, 180, 0.230469); ">On Mar 2, 2010, at 2:11 AM, Iranna D Ankad &lt;<a href="mailto:iranna.ankad@in.ibm.com">iranna.ankad@in.ibm.com</a>&gt; wrote:</span></div><div><br></div><div></div><blockquote type="cite"><div>
<br><font size="2" face="sans-serif">Hello ..</font>
<br><font size="2" face="sans-serif">When I am trying to run LTP's filecaps
test, it does not actually run the test, but ltp-pan report test PASSED.</font>
<br><font size="2" face="sans-serif">This is happening in the latest LTP
(ltp-full-20100228), including couple of past LTP releases (ex. November,
December releases)</font>
<br></div></blockquote><div><br></div><br><blockquote type="cite"><div>
<font size="2" face="sans-serif">remove test cases which require the
block device.</font>
<br><font size="2" face="sans-serif">You can specify it with option -b</font>
<br><font size="2" face="sans-serif">COMMAND: &nbsp; &nbsp;/opt/ltp/bin/ltp-pan
&nbsp;-e -S &nbsp; -a 12064 &nbsp; &nbsp; -n 12064 &nbsp;-p &nbsp;-f /tmp/ltp-P00GfUUqLS/alltests
-l /opt/ltp/results/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.log &nbsp;-C /opt/ltp/output/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.failed</font>
<br><font size="2" face="sans-serif">LOG File: /opt/ltp/results/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.log</font>
<br><font size="2" face="sans-serif">FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.failed</font>
<br><font size="2" face="sans-serif">Running tests.......</font>
<br><font size="2" face="sans-serif">&lt;&lt;&lt;test_start&gt;&gt;&gt;</font>
<br><font size="2" face="sans-serif">tag=Filecaps stime=1267521297</font>
<br><font size="2" face="sans-serif">cmdline="filecapstest.sh"</font>
<br><font size="2" face="sans-serif">contacts=""</font>
<br><font size="2" face="sans-serif">analysis=exit</font>
<br><font size="2" face="sans-serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;</font>
<br><font size="2" face="sans-serif">incrementing stop</font>
<br><font size="2" color="red" face="sans-serif">Filecaps 0 CONF : System doesn't
support execution of the test</font>
<br><font size="2" color="red" face="sans-serif">setcap not installed. Please
install libcap-2.11 or newer from</font>
<br><font size="2" color="red" face="sans-serif"><a href="ftp://ftp.kernel.org/pub/linux/libs/security/linux-privs/libcap2">ftp://ftp.kernel.org/pub/linux/libs/security/linux-privs/libcap2</a></font>
<br><font size="2" face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size="2" face="sans-serif">initiation_status="ok"</font>
<br><font size="2" face="sans-serif">duration=0 termination_type=exited termination_id=0
corefile=no</font>
<br><font size="2" face="sans-serif">cutime=0 cstime=0</font>
<br><font size="2" face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size="2" face="sans-serif">INFO: ltp-pan reported all tests PASS</font>
<br><font size="2" face="sans-serif">LTP Version: LTP-20100131</font>
<font size="2" face="sans-serif">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;</font><span class="Apple-style-span" style="font-family: -webkit-sans-serif; font-size: 15px;"><br></span></div></blockquote><div><br></div><div>The _libraries and apps_ are installed, not the _headers_.</div><br><blockquote type="cite"><div>
<font size="2" face="sans-serif">LTP reports setcap is installed, but
actually, my system has setcap installed, along with all required libcap
related rpms.</font>
<br>
<br><font size="2" face="sans-serif">mx3950:/opt/ltp # setc</font>
<br><font size="2" face="sans-serif">setcap &nbsp; &nbsp; &nbsp;setconsole
&nbsp;setctsid &nbsp; &nbsp;</font>
<br><font size="2" face="sans-serif">mx3950:/opt/ltp #</font>
<br>
<br><font size="2" face="sans-serif">mx3950:/opt/ltp # rpm -qa | grep cap</font>
<br><font size="2" face="sans-serif">libcap1-1.10-6.10</font>
<br><font size="2" face="sans-serif">libcap2-2.11-2.15</font>
<br><font size="2" face="sans-serif">libcap-progs-2.11-2.15</font>
<br><font size="2" face="sans-serif">libpcap0-0.9.8-50.4.32</font>
<br><font size="2" face="sans-serif">libcap2-32bit-2.11-2.15</font>
<br><font size="2" face="sans-serif">libcap1-32bit-1.10-6.10</font>
<br><font size="2" face="sans-serif">mx3950:/opt/ltp # </font>
<br><font size="2" face="sans-serif">---------------------------------------------------------------------------------------------------------------------------------------------------</font>
<br>
<br>
<br><font size="2" face="sans-serif">Here is the false positive log, which
shows test PASSED, without actually running the test.</font><br></div></blockquote><div><br></div><div>The problem is that TCONF should return 0 (in this case the library's functionality isn't available on the running system, so the tests can't be run).</div><div><br></div><div>I don't see a problem with this 'error' -- the problem I see that needs to be rectified is the -devel packages need to be installed on the machine.</div><br><blockquote type="cite"><div><font size="2" face="sans-serif">---------------------------------------------------------------------------------------------------------------------------------------------------</font>
<br>
<br><font size="2" face="sans-serif">mx3950:/opt/ltp # cat results/LTP_RUN_ON-2010_Mar_02-04h_14m_57s.log
</font>
<br><font size="2" face="sans-serif">Test Start Time: Tue Mar &nbsp;2 04:14:57
2010</font>
<br><font size="2" face="sans-serif">-----------------------------------------</font>
<br><font size="2" face="sans-serif">Testcase &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Result &nbsp; &nbsp; Exit
Value</font>
<br><font size="2" face="sans-serif">-------- &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ------ &nbsp; &nbsp; ----------</font>
<br><font size="2" face="sans-serif">Filecaps &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PASS &nbsp; &nbsp; &nbsp;
0</font><br><font size="2" face="sans-serif">-----------------------------------------------</font>
<br><font size="2" face="sans-serif">Total Tests: 1</font>
<br><font size="2" face="sans-serif">Total Failures: 0</font>
<br><font size="2" face="sans-serif">Kernel Version: 2.6.32.8-default</font>
<br><font size="2" face="sans-serif">Machine Architecture: x86_64</font>
<br><font size="2" face="sans-serif">Hostname: mx3950</font>
<br>
<br><font size="2" face="sans-serif">mx3950:/opt/ltp #<span class="Apple-style-span" style="color: rgb(0, 0, 0); -webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); -webkit-composition-fill-color: rgba(175, 192, 227, 0.230469); -webkit-composition-frame-color: rgba(77, 128, 180, 0.230469); "></span></font></div></blockquote><div><span class="Apple-style-span" style="color: rgb(0, 35, 163);"><br></span></div><span class="Apple-style-span" style="color: rgb(0, 35, 163);">Thanks,</span><div><span class="Apple-style-span" style="color: rgb(0, 35, 163);">-Garrett</span></div></body></html>
--Apple-Mail-1--669538866--


--===============3937543443038213950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============3937543443038213950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3937543443038213950==--

