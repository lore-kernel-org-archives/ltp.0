Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Raghavendra.Kakarla@inedasystems.com>)
	id 1aNbnB-0007OY-Op
	for ltp-list@lists.sourceforge.net; Mon, 25 Jan 2016 07:42:29 +0000
Received: from mail-ma1ind01on0087.outbound.protection.outlook.com
	([104.47.100.87] helo=IND01-MA1-obe.outbound.protection.outlook.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aNbn8-0007AZ-0P
	for ltp-list@lists.sourceforge.net; Mon, 25 Jan 2016 07:42:29 +0000
From: Raghavendra Kakarla <Raghavendra.Kakarla@inedasystems.com>
Date: Mon, 25 Jan 2016 07:26:58 +0000
Message-ID: <MA1PR01MB00563932790F3E6F261130F382C70@MA1PR01MB0056.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Some test cases are failed in LTP for Mips32 platform
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8855548780428875896=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============8855548780428875896==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MA1PR01MB00563932790F3E6F261130F382C70MA1PR01MB0056INDP_"

--_000_MA1PR01MB00563932790F3E6F261130F382C70MA1PR01MB0056INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi All,


I built the LTP for the yocto and ran it on the My board which has the Mips=
 interaptive CPU.


After running all tests 42 test are getting failed.


I have examine the each failed test case and noted down the issue.


Following test cases are failed:


1.bind02 - unable to open the socket to testuser
2.chmod06 - Device busy error.
3.getrusage03 - memory allocation failed
4.Readahead02 - Page cache on our system is too small to hold whole testfil=
e.
5.rt_sigaction01 - Gives the buss error.


Could you please help me to resolving this issues.


Thanks in Advance.


Regards,

Raghavendra K.

--_000_MA1PR01MB00563932790F3E6F261130F382C70MA1PR01MB0056INDP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi All,</p>
<p><br>
</p>
<p>I built the LTP for the yocto and ran it on the My board which has the M=
ips interaptive CPU.</p>
<p><br>
</p>
<p>After running all tests 42 test are getting failed.</p>
<p><br>
</p>
<p>I have examine the each failed test case and noted down the issue.</p>
<p><br>
</p>
<p>Following test cases are failed:</p>
<p><br>
</p>
<p>1.bind02 - unable to open the socket to testuser<br>
2.chmod06 - Device busy error.<br>
3.getrusage03 - memory allocation failed<br>
4.Readahead02 - Page cache on our system is too small to hold whole testfil=
e.<br>
5.rt_sigaction01 - Gives the buss error.</p>
<p><br>
</p>
<p>Could you please help me to resolving this issues.</p>
<p><br>
</p>
<p>Thanks in Advance.<br>
</p>
<p><br>
</p>
<p>Regards,</p>
<p>Raghavendra K.<br>
</p>
</div>
</body>
</html>

--_000_MA1PR01MB00563932790F3E6F261130F382C70MA1PR01MB0056INDP_--


--===============8855548780428875896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
--===============8855548780428875896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8855548780428875896==--

