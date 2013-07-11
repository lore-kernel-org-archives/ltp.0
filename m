Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lingyun.xie@bj.cs2c.com.cn>) id 1UxBYG-000133-Jv
	for ltp-list@lists.sourceforge.net; Thu, 11 Jul 2013 07:44:32 +0000
Received: from smtpwcom.263xmail.com ([63.217.87.10])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UxBY7-0004pV-1S
	for ltp-list@lists.sourceforge.net; Thu, 11 Jul 2013 07:44:32 +0000
Received: from mail-pb0-f41.google.com (localhost [127.0.0.1])
	by smtpwcom.263xmail.com (Postfix) with ESMTP id 7FFEE536
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Jul 2013 15:44:04 +0800 (CST)
Received: by mail-pb0-f41.google.com with SMTP id rp16so7664026pbb.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Jul 2013 00:44:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51DD9A44.4090409@casparzhang.com>
References: <1373454200-8630-1-git-send-email-lingyun.xie@bj.cs2c.com.cn>
	<1373454200-8630-2-git-send-email-lingyun.xie@bj.cs2c.com.cn>
	<51DD9A44.4090409@casparzhang.com>
From: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
Date: Thu, 11 Jul 2013 15:43:29 +0800
Message-ID: <CALGiYOGnBrGcM5nLE4EZaGvYv02oYnNC2QZm1CH4uVwFrFMMyw@mail.gmail.com>
Subject: Re: [LTP] [PATCH 2/2 v3] xinetd/xinetd_tests.sh: add IPv6 test for
	xinetd
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2073256485840014290=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

--===============2073256485840014290==
Content-Type: multipart/alternative; boundary=047d7b15b2d13cb0b704e1378fda

--047d7b15b2d13cb0b704e1378fda
Content-Type: text/plain; charset=ISO-8859-1

The following is the result of the patch

<<<test_output>>>
incrementing stop
xinetd01    0  TINFO  :  Test #1: restart xinetd with telnet disabled.
xinetd01    0  TINFO  :  Test #1: new xinetd.conf installed with telnet
disabled.
xinetd01    0  TINFO  :  Test #1: xinetd re-started successfully with
telnet disabled.
xinetd01    0  TINFO  :  Test #1: restart xinetd with telnet enabled.
xinetd01    0  TINFO  :  Test #1: new xinetd.conf installed with telnet
enabled.
xinetd01    0  TINFO  :  Test #1: xinetd re-started successfully with
telnet enabled.
xinetd01    1  TPASS  :  Test #1: xinetd reads the config file and starts
or stops IPv6 services.
xinetd01    1  TPASS  :  Test #1: xinetd reads the config file and starts
or stops services.
xinetd01    0  TINFO  :  CLEAN: removing
/tmp/ltp-pMqQ0DlsKd/tst_xinetd.24156


Thanks,
Lingyun Xie


2013/7/11 Caspar Zhang <caspar@casparzhang.com>

> On 07/10/2013 07:03 PM, Xie Lingyun wrote:
>
>> If IPv6 is enabled, telnet ::1 will be tested. Otherwise, IPv4 only.
>> The IPv6 test will be executed first and give a separate result.
>>
>> Signed-off-by: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
>> ---
>>   testcases/network/xinetd/**xinetd_tests.sh | 81
>> +++++++++++++++++++++++++++++-**--
>>   1 file changed, 75 insertions(+), 6 deletions(-)
>>
>> diff --git a/testcases/network/xinetd/**xinetd_tests.sh
>> b/testcases/network/xinetd/**xinetd_tests.sh
>> index ea89658..143ea76 100755
>> --- a/testcases/network/xinetd/**xinetd_tests.sh
>> +++ b/testcases/network/xinetd/**xinetd_tests.sh
>> @@ -84,11 +84,22 @@ init()
>>            return $RC
>>       fi
>>
>> +    # sometimes the default telnet may be /usr/kerberos/bin/telnet
>> +    TELNET_COMM='/usr/bin/telnet'
>> +
>>       # check if commands tst_*, xinetd, awk exists.
>>       chk_ifexists INIT tst_resm   || return $RC
>>       chk_ifexists INIT xinetd     || return $RC
>>       chk_ifexists INIT diff       || return $RC
>> -    chk_ifexists INIT telnet     || return $RC
>> +    chk_ifexists INIT ip         || return $RC
>> +    chk_ifexists INIT $TELNET_COMM || return $RC
>> +
>> +    IPV6_ENABLED=0
>> +    ip a | grep inet6 > /dev/null 2>&1
>> +    if [ $? -eq 0 ]
>> +    then
>> +        IPV6_ENABLED=1
>> +    fi
>>
>>       # Create custom xinetd.conf file.
>>       # tst_xinetd.conf.1 config file has telnet service disabled.
>> @@ -128,7 +139,7 @@ EOF
>>
>>       # Create expected file with telnet disabled.
>>       cat > $LTPTMP/tst_xinetd.exp.1 <<-EOF || RC=$?
>> -telnet: Unable to connect to remote host: Connection refused
>> +telnet: connect to address 127.0.0.1: Connection refused
>>   EOF
>>
>>       if [ $RC -ne 0 ]
>> @@ -138,10 +149,23 @@ EOF
>>           return $RC
>>       fi
>>
>> +    if [ $IPV6_ENABLED -eq 1 ]
>> +    then
>> +        cat > $LTPTMP/tst_xinetd.exp.1.ipv6 <<-EOF || RC=$?
>> +telnet: connect to address ::1: Connection refused
>> +EOF
>> +
>> +        if [ $RC -ne 0 ]
>> +        then
>> +            tst_brkm TBROK NULL \
>> +                "INIT: unable to create expected file
>> $LTPTMP/tst_xinetd.exp.1"
>> +        fi
>> +    fi
>> +
>>       # Create expected file with telnet enabled.
>>       cat > $LTPTMP/tst_xinetd.exp.2 <<-EOF || RC=$?
>>   Trying 127.0.0.1...
>> -Connected to localhost (127.0.0.1).
>> +Connected to 127.0.0.1.
>>   Escape character is '^]'.
>>   Connection closed by foreign host.
>>   EOF
>> @@ -149,10 +173,26 @@ EOF
>>       if [ $RC -ne 0 ]
>>       then
>>           tst_brkm TBROK  NULL \
>> -            "INIT: unable to create expected file
>> $LTPTMP/tst_xinetd.exp.1"
>> +            "INIT: unable to create expected file
>> $LTPTMP/tst_xinetd.exp.2"
>>           return $RC
>>       fi
>>
>> +    if [ $IPV6_ENABLED -eq 1 ]
>> +    then
>> +        cat > $LTPTMP/tst_xinetd.exp.2.ipv6 <<-EOF || RC=$?
>> +Trying ::1...
>> +Connected to ::1.
>> +Escape character is '^]'.
>> +Connection closed by foreign host.
>> +EOF
>> +
>> +        if [ $RC -ne 0 ]
>> +        then
>> +            tst_brkm TBROK NULL \
>> +                "INIT: unable to create expected file
>> $LTPTMP/tst_xinetd.exp.2.ipv6"
>> +        fi
>> +    fi
>> +
>>       return $RC
>>   }
>>
>> @@ -263,7 +303,20 @@ test01()
>>
>>       # Not checking for exit code from telnet command because telnet is
>>       # not terminated by the test gracefully.
>> -    echo " " | telnet localhost 2>$LTPTMP/tst_xinetd.out 1>/dev/null
>> +    if [ $IPV6_ENABLED -eq 1 ]
>> +    then
>> +        echo " " | $TELNET_COMM ::1 2>$LTPTMP/tst_xinetd.out.ipv6
>> 1>/dev/null
>> +        diff -iwB $LTPTMP/tst_xinetd.out.ipv6
>>  $LTPTMP/tst_xinetd.exp.1.ipv6 \
>> +            > $LTPTMP/tst_xinetd.err.ipv6 2>&1 || RC=$?
>> +        if [ $RC -ne 0 ]
>> +        then
>> +            tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \
>> +                "Test #1: with telnet diabled expected out differs
>> RC=$RC. Details:"
>> +            return $RC
>> +        fi
>> +    fi
>> +
>> +    echo " " | $TELNET_COMM 127.0.0.1 2>$LTPTMP/tst_xinetd.out
>> 1>/dev/null
>>       diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.1 \
>>           > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
>>       if [ $RC -ne 0 ]
>> @@ -312,7 +365,23 @@ test01()
>>
>>       # Not checking for exit code from telnet command because telnet is
>>       # not terminated by the test gracefully.
>> -    echo " " | telnet localhost > $LTPTMP/tst_xinetd.out 2>&1
>> +    if [ $IPV6_ENABLED -eq 1 ]
>> +    then
>> +        echo " " | $TELNET_COMM ::1 >$LTPTMP/tst_xinetd.out.ipv6 2>&1
>> +        diff -iwB $LTPTMP/tst_xinetd.out.ipv6
>>  $LTPTMP/tst_xinetd.exp.2.ipv6 \
>> +            > $LTPTMP/tst_xinetd.err.ipv6 2>&1 || RC=$?
>> +        if [ $RC -ne 0 ]
>> +        then
>> +            tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \
>> +                "Test #1: with telnet diabled expected out differs
>> RC=$RC. Details:"
>> +            return $RC
>> +        else
>> +            tst_resm TPASS \
>> +            "Test #1: xinetd reads the config file and starts or stops
>> IPv6 services."
>> +        fi
>> +    fi
>> +
>> +    echo " " | $TELNET_COMM 127.0.0.1 > $LTPTMP/tst_xinetd.out 2>&1
>>
>>       diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.2 \
>>           > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
>>
>>
> Patch looks good to me.
>
> Could you also give a running result based on your patch? Thanks.
>
> Leo, please help with review if you have some time :-)
>
> Thanks,
> Caspar
>
>
>

--047d7b15b2d13cb0b704e1378fda
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_default" st=
yle=3D"font-family:simsun,serif;color:rgb(0,0,0)">The following is the resu=
lt of the patch</div><div class=3D"gmail_default" style=3D"font-family:sims=
un,serif;color:rgb(0,0,0)">

<br></div><div class=3D"gmail_default"><div class=3D"gmail_default"><font c=
olor=3D"#000000" face=3D"simsun, serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;=
</font></div><div class=3D"gmail_default"><font color=3D"#000000" face=3D"s=
imsun, serif">incrementing stop</font></div>

<div class=3D"gmail_default"><font color=3D"#000000" face=3D"simsun, serif"=
>xinetd01 =A0 =A00 =A0TINFO =A0: =A0Test #1: restart xinetd with telnet dis=
abled.</font></div><div class=3D"gmail_default"><font color=3D"#000000" fac=
e=3D"simsun, serif">xinetd01 =A0 =A00 =A0TINFO =A0: =A0Test #1: new xinetd.=
conf installed with telnet disabled.</font></div>

<div class=3D"gmail_default"><font color=3D"#000000" face=3D"simsun, serif"=
>xinetd01 =A0 =A00 =A0TINFO =A0: =A0Test #1: xinetd re-started successfully=
 with telnet disabled.</font></div><div class=3D"gmail_default"><font color=
=3D"#000000" face=3D"simsun, serif">xinetd01 =A0 =A00 =A0TINFO =A0: =A0Test=
 #1: restart xinetd with telnet enabled.</font></div>

<div class=3D"gmail_default"><font color=3D"#000000" face=3D"simsun, serif"=
>xinetd01 =A0 =A00 =A0TINFO =A0: =A0Test #1: new xinetd.conf installed with=
 telnet enabled.</font></div><div class=3D"gmail_default"><font color=3D"#0=
00000" face=3D"simsun, serif">xinetd01 =A0 =A00 =A0TINFO =A0: =A0Test #1: x=
inetd re-started successfully with telnet enabled.</font></div>

<div class=3D"gmail_default"><font color=3D"#000000" face=3D"simsun, serif"=
>xinetd01 =A0 =A01 =A0TPASS =A0: =A0Test #1: xinetd reads the config file a=
nd starts or stops IPv6 services.</font></div><div class=3D"gmail_default">=
<font color=3D"#000000" face=3D"simsun, serif">xinetd01 =A0 =A01 =A0TPASS =
=A0: =A0Test #1: xinetd reads the config file and starts or stops services.=
</font></div>

<div class=3D"gmail_default"><font color=3D"#000000" face=3D"simsun, serif"=
>xinetd01 =A0 =A00 =A0TINFO =A0: =A0CLEAN: removing /tmp/ltp-pMqQ0DlsKd/tst=
_xinetd.24156</font></div></div><div><div dir=3D"ltr"><br><div><br></div><d=
iv>Thanks,<br>

Lingyun Xie</div></div></div>
<br><br><div class=3D"gmail_quote">2013/7/11 Caspar Zhang <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:caspar@casparzhang.com" target=3D"_blank">caspar@cas=
parzhang.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204=
,204);border-left-style:solid;padding-left:1ex">

<div class=3D""><div class=3D"h5">On 07/10/2013 07:03 PM, Xie Lingyun wrote=
:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
If IPv6 is enabled, telnet ::1 will be tested. Otherwise, IPv4 only.<br>
The IPv6 test will be executed first and give a separate result.<br>
<br>
Signed-off-by: Xie Lingyun &lt;<a href=3D"mailto:lingyun.xie@bj.cs2c.com.cn=
" target=3D"_blank">lingyun.xie@bj.cs2c.com.cn</a>&gt;<br>
---<br>
=A0 testcases/network/xinetd/<u></u>xinetd_tests.sh | 81 ++++++++++++++++++=
+++++++++++-<u></u>--<br>
=A0 1 file changed, 75 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/testcases/network/xinetd/<u></u>xinetd_tests.sh b/testcases/ne=
twork/xinetd/<u></u>xinetd_tests.sh<br>
index ea89658..143ea76 100755<br>
--- a/testcases/network/xinetd/<u></u>xinetd_tests.sh<br>
+++ b/testcases/network/xinetd/<u></u>xinetd_tests.sh<br>
@@ -84,11 +84,22 @@ init()<br>
=A0 =A0 =A0 =A0 =A0 =A0return $RC<br>
=A0 =A0 =A0 fi<br>
<br>
+ =A0 =A0# sometimes the default telnet may be /usr/kerberos/bin/telnet<br>
+ =A0 =A0TELNET_COMM=3D&#39;/usr/bin/telnet&#39;<br>
+<br>
=A0 =A0 =A0 # check if commands tst_*, xinetd, awk exists.<br>
=A0 =A0 =A0 chk_ifexists INIT tst_resm =A0 || return $RC<br>
=A0 =A0 =A0 chk_ifexists INIT xinetd =A0 =A0 || return $RC<br>
=A0 =A0 =A0 chk_ifexists INIT diff =A0 =A0 =A0 || return $RC<br>
- =A0 =A0chk_ifexists INIT telnet =A0 =A0 || return $RC<br>
+ =A0 =A0chk_ifexists INIT ip =A0 =A0 =A0 =A0 || return $RC<br>
+ =A0 =A0chk_ifexists INIT $TELNET_COMM || return $RC<br>
+<br>
+ =A0 =A0IPV6_ENABLED=3D0<br>
+ =A0 =A0ip a | grep inet6 &gt; /dev/null 2&gt;&amp;1<br>
+ =A0 =A0if [ $? -eq 0 ]<br>
+ =A0 =A0then<br>
+ =A0 =A0 =A0 =A0IPV6_ENABLED=3D1<br>
+ =A0 =A0fi<br>
<br>
=A0 =A0 =A0 # Create custom xinetd.conf file.<br>
=A0 =A0 =A0 # tst_xinetd.conf.1 config file has telnet service disabled.<br=
>
@@ -128,7 +139,7 @@ EOF<br>
<br>
=A0 =A0 =A0 # Create expected file with telnet disabled.<br>
=A0 =A0 =A0 cat &gt; $LTPTMP/tst_xinetd.exp.1 &lt;&lt;-EOF || RC=3D$?<br>
-telnet: Unable to connect to remote host: Connection refused<br>
+telnet: connect to address <a href=3D"http://127.0.0.1" target=3D"_blank">=
127.0.0.1</a>: Connection refused<br>
=A0 EOF<br>
<br>
=A0 =A0 =A0 if [ $RC -ne 0 ]<br>
@@ -138,10 +149,23 @@ EOF<br>
=A0 =A0 =A0 =A0 =A0 return $RC<br>
=A0 =A0 =A0 fi<br>
<br>
+ =A0 =A0if [ $IPV6_ENABLED -eq 1 ]<br>
+ =A0 =A0then<br>
+ =A0 =A0 =A0 =A0cat &gt; $LTPTMP/tst_xinetd.exp.1.ipv6 &lt;&lt;-EOF || RC=
=3D$?<br>
+telnet: connect to address ::1: Connection refused<br>
+EOF<br>
+<br>
+ =A0 =A0 =A0 =A0if [ $RC -ne 0 ]<br>
+ =A0 =A0 =A0 =A0then<br>
+ =A0 =A0 =A0 =A0 =A0 =A0tst_brkm TBROK NULL \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;INIT: unable to create expected file=
 $LTPTMP/tst_xinetd.exp.1&quot;<br>
+ =A0 =A0 =A0 =A0fi<br>
+ =A0 =A0fi<br>
+<br>
=A0 =A0 =A0 # Create expected file with telnet enabled.<br>
=A0 =A0 =A0 cat &gt; $LTPTMP/tst_xinetd.exp.2 &lt;&lt;-EOF || RC=3D$?<br>
=A0 Trying 127.0.0.1...<br>
-Connected to localhost (127.0.0.1).<br>
+Connected to 127.0.0.1.<br>
=A0 Escape character is &#39;^]&#39;.<br>
=A0 Connection closed by foreign host.<br>
=A0 EOF<br>
@@ -149,10 +173,26 @@ EOF<br>
=A0 =A0 =A0 if [ $RC -ne 0 ]<br>
=A0 =A0 =A0 then<br>
=A0 =A0 =A0 =A0 =A0 tst_brkm TBROK =A0NULL \<br>
- =A0 =A0 =A0 =A0 =A0 =A0&quot;INIT: unable to create expected file $LTPTMP=
/tst_xinetd.exp.1&quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0&quot;INIT: unable to create expected file $LTPTMP=
/tst_xinetd.exp.2&quot;<br>
=A0 =A0 =A0 =A0 =A0 return $RC<br>
=A0 =A0 =A0 fi<br>
<br>
+ =A0 =A0if [ $IPV6_ENABLED -eq 1 ]<br>
+ =A0 =A0then<br>
+ =A0 =A0 =A0 =A0cat &gt; $LTPTMP/tst_xinetd.exp.2.ipv6 &lt;&lt;-EOF || RC=
=3D$?<br>
+Trying ::1...<br>
+Connected to ::1.<br>
+Escape character is &#39;^]&#39;.<br>
+Connection closed by foreign host.<br>
+EOF<br>
+<br>
+ =A0 =A0 =A0 =A0if [ $RC -ne 0 ]<br>
+ =A0 =A0 =A0 =A0then<br>
+ =A0 =A0 =A0 =A0 =A0 =A0tst_brkm TBROK NULL \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;INIT: unable to create expected file=
 $LTPTMP/tst_xinetd.exp.2.ipv6&quot;<br>
+ =A0 =A0 =A0 =A0fi<br>
+ =A0 =A0fi<br>
+<br>
=A0 =A0 =A0 return $RC<br>
=A0 }<br>
<br>
@@ -263,7 +303,20 @@ test01()<br>
<br>
=A0 =A0 =A0 # Not checking for exit code from telnet command because telnet=
 is<br>
=A0 =A0 =A0 # not terminated by the test gracefully.<br>
- =A0 =A0echo &quot; &quot; | telnet localhost 2&gt;$LTPTMP/tst_xinetd.out =
1&gt;/dev/null<br>
+ =A0 =A0if [ $IPV6_ENABLED -eq 1 ]<br>
+ =A0 =A0then<br>
+ =A0 =A0 =A0 =A0echo &quot; &quot; | $TELNET_COMM ::1 2&gt;$LTPTMP/tst_xin=
etd.out.ipv6 1&gt;/dev/null<br>
+ =A0 =A0 =A0 =A0diff -iwB $LTPTMP/tst_xinetd.out.ipv6 =A0$LTPTMP/tst_xinet=
d.exp.1.ipv6 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0&gt; $LTPTMP/tst_xinetd.err.ipv6 2&gt;&amp;1 || RC=
=3D$?<br>
+ =A0 =A0 =A0 =A0if [ $RC -ne 0 ]<br>
+ =A0 =A0 =A0 =A0then<br>
+ =A0 =A0 =A0 =A0 =A0 =A0tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;Test #1: with telnet diabled expecte=
d out differs RC=3D$RC. Details:&quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0return $RC<br>
+ =A0 =A0 =A0 =A0fi<br>
+ =A0 =A0fi<br>
+<br>
+ =A0 =A0echo &quot; &quot; | $TELNET_COMM 127.0.0.1 2&gt;$LTPTMP/tst_xinet=
d.out 1&gt;/dev/null<br>
=A0 =A0 =A0 diff -iwB $LTPTMP/tst_xinetd.out =A0$LTPTMP/tst_xinetd.exp.1 \<=
br>
=A0 =A0 =A0 =A0 =A0 &gt; $LTPTMP/tst_xinetd.err 2&gt;&amp;1 || RC=3D$?<br>
=A0 =A0 =A0 if [ $RC -ne 0 ]<br>
@@ -312,7 +365,23 @@ test01()<br>
<br>
=A0 =A0 =A0 # Not checking for exit code from telnet command because telnet=
 is<br>
=A0 =A0 =A0 # not terminated by the test gracefully.<br>
- =A0 =A0echo &quot; &quot; | telnet localhost &gt; $LTPTMP/tst_xinetd.out =
2&gt;&amp;1<br>
+ =A0 =A0if [ $IPV6_ENABLED -eq 1 ]<br>
+ =A0 =A0then<br>
+ =A0 =A0 =A0 =A0echo &quot; &quot; | $TELNET_COMM ::1 &gt;$LTPTMP/tst_xine=
td.out.ipv6 2&gt;&amp;1<br>
+ =A0 =A0 =A0 =A0diff -iwB $LTPTMP/tst_xinetd.out.ipv6 =A0$LTPTMP/tst_xinet=
d.exp.2.ipv6 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0&gt; $LTPTMP/tst_xinetd.err.ipv6 2&gt;&amp;1 || RC=
=3D$?<br>
+ =A0 =A0 =A0 =A0if [ $RC -ne 0 ]<br>
+ =A0 =A0 =A0 =A0then<br>
+ =A0 =A0 =A0 =A0 =A0 =A0tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;Test #1: with telnet diabled expecte=
d out differs RC=3D$RC. Details:&quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0return $RC<br>
+ =A0 =A0 =A0 =A0else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0tst_resm TPASS \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0&quot;Test #1: xinetd reads the config file and st=
arts or stops IPv6 services.&quot;<br>
+ =A0 =A0 =A0 =A0fi<br>
+ =A0 =A0fi<br>
+<br>
+ =A0 =A0echo &quot; &quot; | $TELNET_COMM 127.0.0.1 &gt; $LTPTMP/tst_xinet=
d.out 2&gt;&amp;1<br>
<br>
=A0 =A0 =A0 diff -iwB $LTPTMP/tst_xinetd.out =A0$LTPTMP/tst_xinetd.exp.2 \<=
br>
=A0 =A0 =A0 =A0 =A0 &gt; $LTPTMP/tst_xinetd.err 2&gt;&amp;1 || RC=3D$?<br>
<br>
</blockquote>
<br></div></div>
Patch looks good to me.<br>
<br>
Could you also give a running result based on your patch? Thanks.<br>
<br>
Leo, please help with review if you have some time :-)<br>
<br>
Thanks,<br>
Caspar<br>
<br>
<br>
</blockquote></div><br></div></div>

--047d7b15b2d13cb0b704e1378fda--


--===============2073256485840014290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
--===============2073256485840014290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2073256485840014290==--

