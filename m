Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <joyarjit@gmail.com>) id 1PFhst-0002vT-F9
	for ltp-list@lists.sourceforge.net; Tue, 09 Nov 2010 06:40:47 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFhss-0005iO-JM
	for ltp-list@lists.sourceforge.net; Tue, 09 Nov 2010 06:40:47 +0000
Received: by wwb29 with SMTP id 29so1021192wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 08 Nov 2010 22:40:40 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 9 Nov 2010 12:10:40 +0530
Message-ID: <AANLkTi=XWVK8k0kB1XU8n70adHcbVvHsY-w3GCOzK8kN@mail.gmail.com>
From: ARJIT SHARMA <joyarjit@gmail.com>
Subject: [LTP] check_onlycap()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1263670857241437631=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>, hannuxx@gmail.com, ltp-list@lists.sourceforge.net
Cc: ajay.khandelwal@st.com

--===============1263670857241437631==
Content-Type: multipart/alternative; boundary=0016364c7b59f2969d04949904b1

--0016364c7b59f2969d04949904b1
Content-Type: text/plain; charset=ISO-8859-1

HI,

     Inside ltp/testcases/kernel/security/smack there is a shell named
smack_common.sh, inside this script there is a function "check_onlycap"
which is giving error as :---

The smack label reported for /smack/onlycap is "", not the expected ""
why there is such problem and how can i overcome this?

i made a little change in the code but still the error is same:--

i wrote
             if [ !z "$onlycap" ];

instead of
                 if [ -z "$onlycap" ];

inside check_onlycap() function.


Best Regards,
Arjit Sharma.

--0016364c7b59f2969d04949904b1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>HI,</div>
<div>=A0</div>
<div>=A0=A0=A0=A0 Inside ltp/testcases/kernel/security/smack there is a she=
ll named smack_common.sh, inside this script there is a function &quot;chec=
k_onlycap&quot;=A0 which is giving error as :---</div>
<div>=A0</div>
<div>The smack label reported for /smack/onlycap is &quot;&quot;, not the e=
xpected &quot;&quot;=A0<br clear=3D"all"></div>
<div>why there is such problem and how can i overcome this?</div>
<div>=A0</div>
<div>i made a little change in the code but still the error is same:--</div=
>
<div>=A0</div>
<div>i wrote=A0=A0=A0 </div>
<div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if [ !z &quot;$onlycap&quot; ]; <=
/div>
<div>=A0</div>
<div>instead of</div>
<div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if [ -z &quot;$onlyca=
p&quot; ]; </div>
<div>=A0</div>
<div>inside check_onlycap() function.</div>
<div><br>=A0</div>
<div>Best Regards,</div>
<div>Arjit Sharma.</div><br>

--0016364c7b59f2969d04949904b1--


--===============1263670857241437631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
--===============1263670857241437631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1263670857241437631==--

