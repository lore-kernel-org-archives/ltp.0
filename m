Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lingyun.xie@bj.cs2c.com.cn>) id 1Uuw9I-000728-7Q
	for ltp-list@lists.sourceforge.net; Fri, 05 Jul 2013 02:53:28 +0000
Received: from smtpwcom.263xmail.com ([63.217.87.10])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uuw98-0002S6-Cb
	for ltp-list@lists.sourceforge.net; Fri, 05 Jul 2013 02:53:28 +0000
Received: from mail-pb0-f53.google.com (localhost [127.0.0.1])
	by smtpwcom.263xmail.com (Postfix) with ESMTP id B0714553
	for <ltp-list@lists.sourceforge.net>;
	Fri,  5 Jul 2013 10:53:00 +0800 (CST)
Received: by mail-pb0-f53.google.com with SMTP id xb12so1699975pbc.26
	for <ltp-list@lists.sourceforge.net>;
	Thu, 04 Jul 2013 19:53:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51D62E5E.3050207@casparzhang.com>
References: <CALGiYOH4uhAoPgEQ+-p889GbjTazpXkyXabXs021xdmOTbYkoA@mail.gmail.com>
	<51D58003.1020500@casparzhang.com>
	<CAPwn2JRzDE2U_kcbEEJobW9zFsE+KRqme_6QFhp+6jB-D2ZU-A@mail.gmail.com>
	<51D62E5E.3050207@casparzhang.com>
From: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
Date: Fri, 5 Jul 2013 10:52:21 +0800
Message-ID: <CALGiYOHOBY+3ygqrNz7-DX_d5xCMhMww1H4iRco4NzBDr0-11w@mail.gmail.com>
Subject: Re: [LTP] [PATCH]xinetd/xinetd_tests.sh:disable the IPV6 localhost
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0922477384503974899=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

--===============0922477384503974899==
Content-Type: multipart/alternative; boundary=047d7b86f1360ce6ab04e0bacb91

--047d7b86f1360ce6ab04e0bacb91
Content-Type: text/plain; charset=ISO-8859-1

I think that change telnet service on/off is to test the different xinetd
config file. So only IPV4 test of telnet is enough.



Thanks,
Lingyun Xie


2013/7/5 Caspar Zhang <caspar@casparzhang.com>

> +list
>
> On 07/05/2013 10:20 AM, Hangbin Liu wrote:
>
>> I didn't run xinetd before, but It do have this issue.  when we call
>> getaddrinfo(3) to get host name's IP address. It will return multiple
>> answers, and prefer v6 to v4. So this patch make sence. But I
>> recommend we can add IPv6 test for xinetd, not just disable it.
>>
>> 2013/7/4 Caspar Zhang <caspar@casparzhang.com>:
>>
>>  Hangbin, have you executed such tests before, and/or met any ipv4/v6
>>> issue?
>>>
>>> Thanks,
>>> Caspar
>>>
>>>
>>>
>>> On 07/04/2013 09:30 PM, Xie Lingyun wrote:
>>>
>>>>
>>>> If IPV6 is enabled, telnet localhost becomes telnet ::1 and telnet
>>>> 127.0.0.1.
>>>> The first one makes the command output different from the expected
>>>> result.
>>>>
>>>>
>>>> Thanks,
>>>> Lingyun Xie
>>>>
>>>> 0001-xinetd-xinetd_tests.sh-**disable-the-IPV6-localhost.**patch
>>>>
>>>>
>>>>   From 75c79721c095cce27548e74260c1e4**2681e1a267 Mon Sep 17 00:00:00
>>>> 2001
>>>> From: mellonwand<mellonwand@gmail.**com <mellonwand@gmail.com>>
>>>> Date: Thu, 4 Jul 2013 16:42:42 +0800
>>>> Subject: [PATCH] xinetd/xinetd_tests.sh:disable the IPV6 localhost
>>>>
>>>> If IPV6 is enabled, telnet localhost becomes telnet ::1 and telnet
>>>> 127.0.0.1. The first one makes the command's output different from the
>>>> expected output.
>>>>
>>>> Signed-off-by: Xie Lingyun<lingyun.xie@bj.cs2c.**com.cn<lingyun.xie@bj.cs2c.com.cn>
>>>> >
>>>> ---
>>>>    testcases/network/xinetd/**xinetd_tests.sh | 5 +++--
>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/testcases/network/xinetd/**xinetd_tests.sh
>>>> b/testcases/network/xinetd/**xinetd_tests.sh
>>>> index 83eb8a7..d2c851d 100755
>>>> --- a/testcases/network/xinetd/**xinetd_tests.sh
>>>> +++ b/testcases/network/xinetd/**xinetd_tests.sh
>>>> @@ -128,6 +128,7 @@ init()
>>>>
>>>>        # Create expected file with telnet disabled.
>>>>        cat > $LTPTMP/tst_xinetd.exp.1 <<-EOF || RC=$?
>>>> +       telnet: connect to address 127.0.0.1: Connection refused
>>>>          telnet: Unable to connect to remote host: Connection refused
>>>>          EOF
>>>>
>>>> @@ -263,7 +264,7 @@ test01()
>>>>
>>>>          # Not checking for exit code from telnet command because
>>>> telnet is
>>>>          # not terminated by the test gracefully.
>>>> -       echo " " | telnet localhost 2>$LTPTMP/tst_xinetd.out 1>/dev/null
>>>> +       echo " " | telnet 127.0.0.1 2>$LTPTMP/tst_xinetd.out 1>/dev/null
>>>>          diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.1 \
>>>>                  > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
>>>>        if [ $RC -ne 0 ]
>>>> @@ -312,7 +313,7 @@ test01()
>>>>
>>>>          # Not checking for exit code from telnet command because
>>>> telnet is
>>>>          # not terminated by the test gracefully.
>>>> -       echo " " | telnet localhost > $LTPTMP/tst_xinetd.out 2>&1
>>>> +       echo " " | telnet 127.0.0.1 > $LTPTMP/tst_xinetd.out 2>&1
>>>>
>>>>          diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.2 \
>>>>                  > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
>>>> -- 1.8.3.1
>>>>
>>>>
>>>
>
>
>

--047d7b86f1360ce6ab04e0bacb91
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:simsun,s=
erif;color:#000000">I think that change telnet service on/off is to test th=
e different xinetd config file. So only IPV4 test of telnet is enough.</div=
></div>

<div class=3D"gmail_extra"><br clear=3D"all"><div><div dir=3D"ltr"><br><div=
><br></div><div>Thanks,<br>Lingyun Xie</div></div></div>
<br><br><div class=3D"gmail_quote">2013/7/5 Caspar Zhang <span dir=3D"ltr">=
&lt;<a href=3D"mailto:caspar@casparzhang.com" target=3D"_blank">caspar@casp=
arzhang.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

+list<br>
<br>
On 07/05/2013 10:20 AM, Hangbin Liu wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I didn&#39;t run xinetd before, but It do have this issue. =A0when we call<=
br>
getaddrinfo(3) to get host name&#39;s IP address. It will return multiple<b=
r>
answers, and prefer v6 to v4. So this patch make sence. But I<br>
recommend we can add IPv6 test for xinetd, not just disable it.<br>
<br>
2013/7/4 Caspar Zhang &lt;<a href=3D"mailto:caspar@casparzhang.com" target=
=3D"_blank">caspar@casparzhang.com</a>&gt;:<div><div class=3D"h5"><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hangbin, have you executed such tests before, and/or met any ipv4/v6 issue?=
<br>
<br>
Thanks,<br>
Caspar<br>
<br>
<br>
<br>
On 07/04/2013 09:30 PM, Xie Lingyun wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
If IPV6 is enabled, telnet localhost becomes telnet ::1 and telnet<br>
127.0.0.1.<br>
The first one makes the command output different from the expected result.<=
br>
<br>
<br>
Thanks,<br>
Lingyun Xie<br>
<br>
0001-xinetd-xinetd_tests.sh-<u></u>disable-the-IPV6-localhost.<u></u>patch<=
br>
<br>
<br>
=A0 From 75c79721c095cce27548e74260c1e4<u></u>2681e1a267 Mon Sep 17 00:00:0=
0 2001<br>
From: mellonwand&lt;<a href=3D"mailto:mellonwand@gmail.com" target=3D"_blan=
k">mellonwand@gmail.<u></u>com</a>&gt;<br>
Date: Thu, 4 Jul 2013 16:42:42 +0800<br>
Subject: [PATCH] xinetd/xinetd_tests.sh:disable the IPV6 localhost<br>
<br>
If IPV6 is enabled, telnet localhost becomes telnet ::1 and telnet<br>
127.0.0.1. The first one makes the command&#39;s output different from the<=
br>
expected output.<br>
<br>
Signed-off-by: Xie Lingyun&lt;<a href=3D"mailto:lingyun.xie@bj.cs2c.com.cn"=
 target=3D"_blank">lingyun.xie@bj.cs2c.<u></u>com.cn</a>&gt;<br>
---<br>
=A0 =A0testcases/network/xinetd/<u></u>xinetd_tests.sh | 5 +++--<br>
=A0 =A01 file changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/testcases/network/xinetd/<u></u>xinetd_tests.sh<br>
b/testcases/network/xinetd/<u></u>xinetd_tests.sh<br>
index 83eb8a7..d2c851d 100755<br>
--- a/testcases/network/xinetd/<u></u>xinetd_tests.sh<br>
+++ b/testcases/network/xinetd/<u></u>xinetd_tests.sh<br>
@@ -128,6 +128,7 @@ init()<br>
<br>
=A0 =A0 =A0 =A0# Create expected file with telnet disabled.<br>
=A0 =A0 =A0 =A0cat &gt; $LTPTMP/tst_xinetd.exp.1 &lt;&lt;-EOF || RC=3D$?<br=
>
+ =A0 =A0 =A0 telnet: connect to address <a href=3D"http://127.0.0.1" targe=
t=3D"_blank">127.0.0.1</a>: Connection refused<br>
=A0 =A0 =A0 =A0 =A0telnet: Unable to connect to remote host: Connection ref=
used<br>
=A0 =A0 =A0 =A0 =A0EOF<br>
<br>
@@ -263,7 +264,7 @@ test01()<br>
<br>
=A0 =A0 =A0 =A0 =A0# Not checking for exit code from telnet command because=
 telnet is<br>
=A0 =A0 =A0 =A0 =A0# not terminated by the test gracefully.<br>
- =A0 =A0 =A0 echo &quot; &quot; | telnet localhost 2&gt;$LTPTMP/tst_xinetd=
.out 1&gt;/dev/null<br>
+ =A0 =A0 =A0 echo &quot; &quot; | telnet 127.0.0.1 2&gt;$LTPTMP/tst_xinetd=
.out 1&gt;/dev/null<br>
=A0 =A0 =A0 =A0 =A0diff -iwB $LTPTMP/tst_xinetd.out =A0$LTPTMP/tst_xinetd.e=
xp.1 \<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gt; $LTPTMP/tst_xinetd.err 2&gt;&amp;1 =
|| RC=3D$?<br>
=A0 =A0 =A0 =A0if [ $RC -ne 0 ]<br>
@@ -312,7 +313,7 @@ test01()<br>
<br>
=A0 =A0 =A0 =A0 =A0# Not checking for exit code from telnet command because=
 telnet is<br>
=A0 =A0 =A0 =A0 =A0# not terminated by the test gracefully.<br>
- =A0 =A0 =A0 echo &quot; &quot; | telnet localhost &gt; $LTPTMP/tst_xinetd=
.out 2&gt;&amp;1<br>
+ =A0 =A0 =A0 echo &quot; &quot; | telnet 127.0.0.1 &gt; $LTPTMP/tst_xinetd=
.out 2&gt;&amp;1<br>
<br>
=A0 =A0 =A0 =A0 =A0diff -iwB $LTPTMP/tst_xinetd.out =A0$LTPTMP/tst_xinetd.e=
xp.2 \<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gt; $LTPTMP/tst_xinetd.err 2&gt;&amp;1 =
|| RC=3D$?<br>
-- 1.8.3.1<br>
<br>
</blockquote>
<br>
</blockquote></div></div></blockquote>
<br>
<br>
<br>
</blockquote></div><br></div>

--047d7b86f1360ce6ab04e0bacb91--


--===============0922477384503974899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============0922477384503974899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0922477384503974899==--

