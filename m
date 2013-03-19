Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Nagaraj.Arankal@mphasis.com>) id 1UHqnJ-0003tO-RC
	for ltp-list@lists.sourceforge.net; Tue, 19 Mar 2013 07:17:13 +0000
Received: from [216.39.69.20] (helo=usmail.mphasis.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1UHqnH-0001zr-G3
	for ltp-list@lists.sourceforge.net; Tue, 19 Mar 2013 07:17:13 +0000
From: Nagaraj Arankal <Nagaraj.Arankal@mphasis.com>
Date: Tue, 19 Mar 2013 07:04:07 +0000
Message-ID: <6E5884E2FD7B14478D60D8585D6CFDE16172A8B9@MPDAMBX01>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Please update LTP SCTP functional tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5079958743958048025=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============5079958743958048025==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_6E5884E2FD7B14478D60D8585D6CFDE16172A8B9MPDAMBX01_"

--_000_6E5884E2FD7B14478D60D8585D6CFDE16172A8B9MPDAMBX01_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

In the current version of LTP(ltp-full-20130109), I have seen couple of SCT=
P Functional tests failures.



1)test_assoc_abort.c
2)test_1_to_1_sockopt.c

After adding following patches, both the func_tests passes

1)For test_assoc_abort



The SCTP_COMM_LOST notification that was a result of an abort
now contains the additional parameter that includes the error
from the abort chunk.  Need to account for that when checking
the received notification.

--- a/src/func_tests/test_assoc_abort.c
+++ b/src/func_tests/test_assoc_abort.c
@@ -231,7 +231,7 @@ main(int argc, char *argv[])
                inmessage.msg_controllen =3D sizeof(incmsg);
                error =3D test_recvmsg(clt_sk[i], &inmessage, MSG_WAITALL);
                test_check_msg_notification(&inmessage, error,
-                                           sizeof(struct sctp_assoc_change=
),
+                                           sizeof(struct sctp_assoc_change=
)+4,
                                            SCTP_ASSOC_CHANGE, SCTP_COMM_LO=
ST);


2)For test_1_to_1_sockopt
test_1_to_1_sockopt: fix deprecated SO_RCVBUF/SO_SNDBUF testcase

Actually, it is not guaranteed, that the rcv/snd buffer size, we send
is really set by the kernel. For small values, the SOCK_MIN_SNDBUF and
SOCK_MIN_RCVBUF sizes in include/net/sock.h are used instead. This was
the sole reason why this test, whose implementation was in 2005, failed.
Just change it to something bigger is not critical, and we're good to go.


--- a/src/func_tests/test_1_to_1_sockopt.c
+++ b/src/func_tests/test_1_to_1_sockopt.c
@@ -301,7 +301,7 @@ main(void)
        /* Reducing the SO_RCVBUF value using setsockopt() */
        /*Minimum value is 128 and hence I am using it*/
        len =3D sizeof(int);
-       rcvbuf_val_set =3D 128;
+       rcvbuf_val_set =3D 2048;
        /* TEST16: Test case for setsockopt SO_RCVBUF */
        error =3D setsockopt(sk2, SOL_SOCKET, SO_RCVBUF, &rcvbuf_val_set, l=
en);
        if (error < 0)@@ -320,7 +320,7 @@ main(void)
                         "got value differs Set Value=3D%d Get Value=3D%d",
                         (2*rcvbuf_val_set), rcvbuf_val_get);
-       sndbuf_val_set=3D1024;
+       sndbuf_val_set =3D 2048;
        /* TEST17: Test case for setsockopt SO_SNDBUF */
        error =3D setsockopt(sk2, SOL_SOCKET, SO_SNDBUF, &sndbuf_val_set, l=
en);
        if (error < 0)



It would be nice if the upcoming LTP release could pick up the updated vers=
ions of the lksctp-tools-1.0.13 tests.



Thanks,
Nagaraj Arankal

________________________________

Information transmitted by this e-mail is proprietary to MphasiS, its assoc=
iated companies and/ or its customers and is intended for use only by the i=
ndividual or entity to which it is addressed, and may contain information t=
hat is privileged, confidential or exempt from disclosure under applicable =
law. If you are not the intended recipient or it appears that this mail has=
 been forwarded to you without proper authority, you are notified that any =
use or dissemination of this information in any manner is strictly prohibit=
ed. In such cases, please notify us immediately at mailmaster@mphasis.com a=
nd delete this mail from your records.

--_000_6E5884E2FD7B14478D60D8585D6CFDE16172A8B9MPDAMBX01_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle">
<!--
p
	{margin-top:0px;
	margin-bottom:0px}
-->
</style>
</head>
<body>
<div style=3D"direction:ltr; font-family:Tahoma; color:#000000; font-size:1=
0pt">
<div>
<p>Hi,</p>
<p>In the current version of LTP(ltp-full-20130109), I have seen couple of =
SCTP Functional tests failures.</p>
<p>&nbsp;</p>
<p>1)test_assoc_abort.c<br>
2)test_1_to_1_sockopt.c<br>
</p>
<p>After adding following patches, both the func_tests passes</p>
<p>1)For test_assoc_abort</p>
<p>&nbsp;</p>
<p>The SCTP_COMM_LOST notification that was a result of an abort<br>
now contains the additional parameter that includes the error<br>
from the abort chunk.&nbsp; Need to account for that when checking<br>
the received notification.<br>
<br>
--- a/src/func_tests/test_assoc_abort.c<br>
&#43;&#43;&#43; b/src/func_tests/test_assoc_abort.c<br>
@@ -231,7 &#43;231,7 @@ main(int argc, char *argv[])<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; inmessage.msg_controllen =3D sizeof(incmsg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; error =3D test_recvmsg(clt_sk[i], &amp;inmessage, MSG_WAITA=
LL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; test_check_msg_notification(&amp;inmessage, error,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct sctp_assoc_change),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct sctp_assoc_change)&#43;4,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCTP_ASSOC_CHANGE, SCTP_COMM_LOST);<br>
<br>
<br>
2)For test_1_to_1_sockopt<br>
test_1_to_1_sockopt: fix deprecated SO_RCVBUF/SO_SNDBUF testcase<br>
<br>
Actually, it is not guaranteed, that the rcv/snd buffer size, we send<br>
is really set by the kernel. For small values, the SOCK_MIN_SNDBUF and<br>
SOCK_MIN_RCVBUF sizes in include/net/sock.h are used instead. This was<br>
the sole reason why this test, whose implementation was in 2005, failed.<br=
>
Just change it to something bigger is not critical, and we're good to go.<b=
r>
<br>
<br>
--- a/src/func_tests/test_1_to_1_sockopt.c<br>
&#43;&#43;&#43; b/src/func_tests/test_1_to_1_sockopt.c<br>
@@ -301,7 &#43;301,7 @@ main(void)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reducing the SO_RCVBUF value =
using setsockopt() */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*Minimum value is 128 and hence=
 I am using it*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len =3D sizeof(int);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rcvbuf_val_set =3D 128;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rcvbuf_val_set =3D 2048;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TEST16: Test case for setsock=
opt SO_RCVBUF */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error =3D setsockopt(sk2, SOL_SO=
CKET, SO_RCVBUF, &amp;rcvbuf_val_set, len);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (error &lt; 0)@@ -320,7 &#43;=
320,7 @@ main(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;got value differs Set Value=3D%d Get Value=3D%d&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (2*rc=
vbuf_val_set), rcvbuf_val_get);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sndbuf_val_set=3D1024;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sndbuf_val_set =3D 2048;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TEST17: Test case for setsock=
opt SO_SNDBUF */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error =3D setsockopt(sk2, SOL_SO=
CKET, SO_SNDBUF, &amp;sndbuf_val_set, len);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (error &lt; 0)</p>
<p>&nbsp;</p>
<p>It would be nice if the upcoming LTP release could pick up the updated v=
ersions of the lksctp-tools-1.0.13 tests.</p>
<p>&nbsp;</p>
<p>Thanks,</p>
<div style=3D"font-family:Tahoma; font-size:13px">
<div><font size=3D"2" face=3D"Tahoma">
<p class=3D"MsoNormal"><span style=3D"font-family:'Trebuchet MS','sans-seri=
f'; color:#1f497d; font-size:10pt">Nagaraj Arankal</span></p>
</font></div>
</div>
</div>
</div>
<br>
<hr>
<font face=3D"Courier New" color=3D"Navy" size=3D"1"><br>
Information transmitted by this e-mail is proprietary to MphasiS, its assoc=
iated companies and/ or its customers and is intended for use only by the i=
ndividual or entity to which it is addressed, and may contain information t=
hat is privileged, confidential
 or exempt from disclosure under applicable law. If you are not the intende=
d recipient or it appears that this mail has been forwarded to you without =
proper authority, you are notified that any use or dissemination of this in=
formation in any manner is strictly
 prohibited. In such cases, please notify us immediately at mailmaster@mpha=
sis.com and delete this mail from your records.<br>
</font>
</body>
</html>

--_000_6E5884E2FD7B14478D60D8585D6CFDE16172A8B9MPDAMBX01_--


--===============5079958743958048025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
--===============5079958743958048025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5079958743958048025==--

