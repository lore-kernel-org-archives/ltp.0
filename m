Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <max.maxiansheng@huawei.com>) id 1SNfJ4-0002Av-FL
	for ltp-list@lists.sourceforge.net; Fri, 27 Apr 2012 07:09:30 +0000
Received: from [58.251.152.67] (helo=szxga04-in.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SNfJ0-0005CF-FC
	for ltp-list@lists.sourceforge.net; Fri, 27 Apr 2012 07:09:30 +0000
Received: from huawei.com (szxga04-in [172.24.2.12])
	by szxga04-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14
	(built Aug
	8 2006)) with ESMTP id <0M3400AE0LL0IV@szxga04-in.huawei.com> for
	ltp-list@lists.sourceforge.net; Fri, 27 Apr 2012 14:48:36 +0800 (CST)
Received: from szxrg02-dlp.huawei.com ([172.24.2.119])
	by szxga04-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14
	(built Aug
	8 2006)) with ESMTP id <0M3400LFOLL04A@szxga04-in.huawei.com> for
	ltp-list@lists.sourceforge.net; Fri, 27 Apr 2012 14:48:36 +0800 (CST)
Date: Fri, 27 Apr 2012 06:48:29 +0000
From: "Maxiansheng (Max)" <max.maxiansheng@huawei.com>
Message-id: <B7E6FC224F02D64480BFC86AA60E9566267B9332@SZXEML511-MBS.china.huawei.com>
MIME-version: 1.0
Content-language: zh-CN
Subject: [LTP] Why LTP expect to get EFAULT error on sigtimedwait01 case
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0671954769993333012=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>


--===============0671954769993333012==
Content-type: multipart/alternative;
	boundary="Boundary_(ID_U4c/ramAPxxQkAerlvk0zQ)"
Content-language: zh-CN


--Boundary_(ID_U4c/ramAPxxQkAerlvk0zQ)
Content-type: text/plain; charset=gb2312
Content-transfer-encoding: base64

SGkgYWxsOg0KDQpXZSBhcmUgdGVzdGluZyBzZXZlcmFsIGVtYmVkZGVkIExpbnV4LiBXaGVuIHdl
IHVzZSBMVFAgdG8gdGVzdCB0aGVzZSBMaW51eCwgd2UgZmluZCB0aGF0IHRoZSB0ZXN0Y2FzZSBz
aWd0aW1lZHdhaXQwMSBhbHdheXMgZmFpbGVkIHdpdGggU2VnbWVudCBGYXVsdC4NCg0KQXMgdGhl
IHRlc3RjYXNlIGZhaWxlZCBvbiB4ODZfNjQsIGk1ODYgYW5kIGFybSwgd2UgZm91bmQgdGhhdCBt
YXliZSBnbGliYyBkb2VzbqGvdCBkZWFsIHdpdGggdGhlIGJhZCBhZGRyZXNzDQoNClRoZSB0ZXN0
Y2FzZSBDIHByb2dyYW0gZmlsZSBpcyA6IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2lnd2Fp
dGluZm8vc2lnd2FpdGluZm8uYw0KDQpUaGUgcmVzdWx0IGlzIDoNCnNpZ3RpbWVkd2FpdDAxICAg
IDYgIFRQQVNTICA6ICBUZXN0IHBhc3NlZA0Kc2lndGltZWR3YWl0MDEgICAgMCAgVElORk8gIDog
IDB4ODA0OTNjMCwgMTANCnNpZ3RpbWVkd2FpdDAxICAgIDcgIFRCUk9LICA6ICB1bmV4cGVjdGVk
IHNpZ25hbCAxMSByZWNlaXZlZCAocGlkID0gNDA1NykuDQpzaWd0aW1lZHdhaXQwMSAgICA4ICBU
QlJPSyAgOiAgUmVtYWluaW5nIGNhc2VzIGJyb2tlbg0KDQppdCBhbHdheXMgZmFpbCBhZnRlciBs
aW5lIDMzNCwgYmVjYXVzZSBvZiBTZWdtZW50IEZhdWx0DQozMzIgdm9pZCB0ZXN0X2JhZF9hZGRy
ZXNzMihzd2lfZnVuYyBzaWd3YWl0aW5mbywgaW50IHNpZ25vKQ0KMzMzIHsNCjMzNCAgICAgICAg
IFRFU1Qoc2lnd2FpdGluZm8oKHZvaWQqKTEsIE5VTEwsIE5VTEwpOw0KMzM1ICAgICAgICAgUkVQ
T1JUX1NVQ0NFU1MoLTEsIEVGQVVMVCk7DQozMzYgfQ0KDQpXZSBjYW4gc2VlIHRoYXQsIGhlcmUs
IHdlIGRvDQoNClNpZ3RpbWVkd2FpdCgodm9pZCopMSwgTlVMTCwgTlVMTCkpOw0KDQpBbmQgdGhl
IHBhcmFtZXRlciAodm9pZCAqKTEgaXMgYSBiYWQgYWRkcmVzcy4NCg0KVGhpcyB0ZXN0IGNhbiBt
YWtlIHRoaW5ncyBlYXNpZXIuDQoNCiNpbmNsdWRlIDxzdGRpby5oPg0KI2luY2x1ZGUgPHNpZ25h
bC5oPg0KDQppbnQgbWFpbigpDQp7DQogICAgICAgIGludCByZXQ7DQogICAgICAgIHJldCA9IHNp
Z3RpbWVkd2FpdCgodm9pZCopMSwgTlVMTCwgTlVMTCk7DQogICAgICAgIHByaW50ZigidGVzdCBl
bmRcbiIpOw0KICAgICAgICByZXR1cm4gMDsNCn0NCg0KV2h5IExUUCBleHBlY3QgdG8gZ2V0IHRo
ZSBFRkFVTFQgZXJyb3I/DQo=

--Boundary_(ID_U4c/ramAPxxQkAerlvk0zQ)
Content-type: text/html; charset=gb2312
Content-transfer-encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"GENERATOR" content=3D"MSHTML 8.00.7600.16930">
<style id=3D"owaParaStyle">P {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
</style>
</head>
<body fPStyle=3D"1" ocsi=3D"0">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">
<p>Hi all:</p>
<p>We are testing several embedded Linux. When we use LTP to test these Lin=
ux, we find that the testcase sigtimedwait01 always failed with Segment Fau=
lt.</p>
<p>As the testcase failed on x86_64,&nbsp;i586 and arm, we found that maybe=
 glibc doesn=A1=AFt deal with the bad address</p>
<p>The testcase C program file is : testcases/kernel/syscalls/sigwaitinfo/s=
igwaitinfo.c</p>
<p>The result is :<br>
sigtimedwait01&nbsp;&nbsp;&nbsp; 6&nbsp; TPASS&nbsp; :&nbsp; Test passed<br=
>
sigtimedwait01&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; 0x80493c0, 10<=
br>
sigtimedwait01&nbsp;&nbsp;&nbsp; 7&nbsp; TBROK&nbsp; :&nbsp; unexpected sig=
nal 11 received (pid =3D 4057).<br>
sigtimedwait01&nbsp;&nbsp;&nbsp; 8&nbsp; TBROK&nbsp; :&nbsp; Remaining case=
s broken</p>
<p>it always fail after line 334, because of Segment Fault<br>
332 void test_bad_address2(swi_func sigwaitinfo, int signo)<br>
333 {<br>
334&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TEST(sigwaitinfo((void*=
)1, NULL, NULL);<br>
335&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REPORT_SUCCESS(-1, EFAU=
LT);<br>
336 }</p>
<p>We can see that, here, we do </p>
<p>Sigtimedwait((void*)1, NULL, NULL));</p>
<p>And the parameter (void *)1 is a bad address.</p>
<p>This test can make things easier.</p>
<p>#include &lt;stdio.h&gt;<br>
#include &lt;signal.h&gt;</p>
<p>int main()<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D sigtimedwait((void*)1, N=
ULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;test end\n&quot;);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
}</p>
<p>Why LTP expect to get the EFAULT error?</p>
</div>
</body>
</html>

--Boundary_(ID_U4c/ramAPxxQkAerlvk0zQ)--


--===============0671954769993333012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============0671954769993333012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0671954769993333012==--

