Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lingyun.xie@bj.cs2c.com.cn>) id 1UxBov-0006gY-CB
	for ltp-list@lists.sourceforge.net; Thu, 11 Jul 2013 08:01:45 +0000
Received: from smtpwcom.263xmail.com ([63.217.87.10])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UxBoo-0002dD-FQ
	for ltp-list@lists.sourceforge.net; Thu, 11 Jul 2013 08:01:45 +0000
Received: from mail-pd0-f172.google.com (localhost [127.0.0.1])
	by smtpwcom.263xmail.com (Postfix) with ESMTP id 6042253E
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Jul 2013 16:01:21 +0800 (CST)
Received: by mail-pd0-f172.google.com with SMTP id z10so7212009pdj.31
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Jul 2013 01:01:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALGiYOGnBrGcM5nLE4EZaGvYv02oYnNC2QZm1CH4uVwFrFMMyw@mail.gmail.com>
References: <1373454200-8630-1-git-send-email-lingyun.xie@bj.cs2c.com.cn>
	<1373454200-8630-2-git-send-email-lingyun.xie@bj.cs2c.com.cn>
	<51DD9A44.4090409@casparzhang.com>
	<CALGiYOGnBrGcM5nLE4EZaGvYv02oYnNC2QZm1CH4uVwFrFMMyw@mail.gmail.com>
From: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
Date: Thu, 11 Jul 2013 16:00:45 +0800
Message-ID: <CALGiYOFmr61vz8JzZxV1YMGPQtbYGt5qwiMMQX+xk5BSGx22Rw@mail.gmail.com>
Content-Type: multipart/mixed; boundary=047d7b15a2d1153f2204e137cda7
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

--047d7b15a2d1153f2204e137cda7
Content-Type: multipart/alternative; boundary=047d7b15a2d1153f1d04e137cda5

--047d7b15a2d1153f1d04e137cda5
Content-Type: text/plain; charset=ISO-8859-1

This patch follows the previous clean up patch. Only change some
indentations.

Without any other changes of version 3.



Thanks,
Lingyun Xie


2013/7/11 Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>

> The following is the result of the patch
>
> <<<test_output>>>
> incrementing stop
> xinetd01    0  TINFO  :  Test #1: restart xinetd with telnet disabled.
> xinetd01    0  TINFO  :  Test #1: new xinetd.conf installed with telnet
> disabled.
> xinetd01    0  TINFO  :  Test #1: xinetd re-started successfully with
> telnet disabled.
> xinetd01    0  TINFO  :  Test #1: restart xinetd with telnet enabled.
> xinetd01    0  TINFO  :  Test #1: new xinetd.conf installed with telnet
> enabled.
> xinetd01    0  TINFO  :  Test #1: xinetd re-started successfully with
> telnet enabled.
> xinetd01    1  TPASS  :  Test #1: xinetd reads the config file and starts
> or stops IPv6 services.
> xinetd01    1  TPASS  :  Test #1: xinetd reads the config file and starts
> or stops services.
> xinetd01    0  TINFO  :  CLEAN: removing
> /tmp/ltp-pMqQ0DlsKd/tst_xinetd.24156
>
>
> Thanks,
> Lingyun Xie
>
>
> 2013/7/11 Caspar Zhang <caspar@casparzhang.com>
>
>> On 07/10/2013 07:03 PM, Xie Lingyun wrote:
>>
>>> If IPv6 is enabled, telnet ::1 will be tested. Otherwise, IPv4 only.
>>> The IPv6 test will be executed first and give a separate result.
>>>
>>> Signed-off-by: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
>>> ---
>>>   testcases/network/xinetd/**xinetd_tests.sh | 81
>>> +++++++++++++++++++++++++++++-**--
>>>   1 file changed, 75 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/testcases/network/xinetd/**xinetd_tests.sh
>>> b/testcases/network/xinetd/**xinetd_tests.sh
>>> index ea89658..143ea76 100755
>>> --- a/testcases/network/xinetd/**xinetd_tests.sh
>>> +++ b/testcases/network/xinetd/**xinetd_tests.sh
>>> @@ -84,11 +84,22 @@ init()
>>>            return $RC
>>>       fi
>>>
>>> +    # sometimes the default telnet may be /usr/kerberos/bin/telnet
>>> +    TELNET_COMM='/usr/bin/telnet'
>>> +
>>>       # check if commands tst_*, xinetd, awk exists.
>>>       chk_ifexists INIT tst_resm   || return $RC
>>>       chk_ifexists INIT xinetd     || return $RC
>>>       chk_ifexists INIT diff       || return $RC
>>> -    chk_ifexists INIT telnet     || return $RC
>>> +    chk_ifexists INIT ip         || return $RC
>>> +    chk_ifexists INIT $TELNET_COMM || return $RC
>>> +
>>> +    IPV6_ENABLED=0
>>> +    ip a | grep inet6 > /dev/null 2>&1
>>> +    if [ $? -eq 0 ]
>>> +    then
>>> +        IPV6_ENABLED=1
>>> +    fi
>>>
>>>       # Create custom xinetd.conf file.
>>>       # tst_xinetd.conf.1 config file has telnet service disabled.
>>> @@ -128,7 +139,7 @@ EOF
>>>
>>>       # Create expected file with telnet disabled.
>>>       cat > $LTPTMP/tst_xinetd.exp.1 <<-EOF || RC=$?
>>> -telnet: Unable to connect to remote host: Connection refused
>>> +telnet: connect to address 127.0.0.1: Connection refused
>>>   EOF
>>>
>>>       if [ $RC -ne 0 ]
>>> @@ -138,10 +149,23 @@ EOF
>>>           return $RC
>>>       fi
>>>
>>> +    if [ $IPV6_ENABLED -eq 1 ]
>>> +    then
>>> +        cat > $LTPTMP/tst_xinetd.exp.1.ipv6 <<-EOF || RC=$?
>>> +telnet: connect to address ::1: Connection refused
>>> +EOF
>>> +
>>> +        if [ $RC -ne 0 ]
>>> +        then
>>> +            tst_brkm TBROK NULL \
>>> +                "INIT: unable to create expected file
>>> $LTPTMP/tst_xinetd.exp.1"
>>> +        fi
>>> +    fi
>>> +
>>>       # Create expected file with telnet enabled.
>>>       cat > $LTPTMP/tst_xinetd.exp.2 <<-EOF || RC=$?
>>>   Trying 127.0.0.1...
>>> -Connected to localhost (127.0.0.1).
>>> +Connected to 127.0.0.1.
>>>   Escape character is '^]'.
>>>   Connection closed by foreign host.
>>>   EOF
>>> @@ -149,10 +173,26 @@ EOF
>>>       if [ $RC -ne 0 ]
>>>       then
>>>           tst_brkm TBROK  NULL \
>>> -            "INIT: unable to create expected file
>>> $LTPTMP/tst_xinetd.exp.1"
>>> +            "INIT: unable to create expected file
>>> $LTPTMP/tst_xinetd.exp.2"
>>>           return $RC
>>>       fi
>>>
>>> +    if [ $IPV6_ENABLED -eq 1 ]
>>> +    then
>>> +        cat > $LTPTMP/tst_xinetd.exp.2.ipv6 <<-EOF || RC=$?
>>> +Trying ::1...
>>> +Connected to ::1.
>>> +Escape character is '^]'.
>>> +Connection closed by foreign host.
>>> +EOF
>>> +
>>> +        if [ $RC -ne 0 ]
>>> +        then
>>> +            tst_brkm TBROK NULL \
>>> +                "INIT: unable to create expected file
>>> $LTPTMP/tst_xinetd.exp.2.ipv6"
>>> +        fi
>>> +    fi
>>> +
>>>       return $RC
>>>   }
>>>
>>> @@ -263,7 +303,20 @@ test01()
>>>
>>>       # Not checking for exit code from telnet command because telnet is
>>>       # not terminated by the test gracefully.
>>> -    echo " " | telnet localhost 2>$LTPTMP/tst_xinetd.out 1>/dev/null
>>> +    if [ $IPV6_ENABLED -eq 1 ]
>>> +    then
>>> +        echo " " | $TELNET_COMM ::1 2>$LTPTMP/tst_xinetd.out.ipv6
>>> 1>/dev/null
>>> +        diff -iwB $LTPTMP/tst_xinetd.out.ipv6
>>>  $LTPTMP/tst_xinetd.exp.1.ipv6 \
>>> +            > $LTPTMP/tst_xinetd.err.ipv6 2>&1 || RC=$?
>>> +        if [ $RC -ne 0 ]
>>> +        then
>>> +            tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \
>>> +                "Test #1: with telnet diabled expected out differs
>>> RC=$RC. Details:"
>>> +            return $RC
>>> +        fi
>>> +    fi
>>> +
>>> +    echo " " | $TELNET_COMM 127.0.0.1 2>$LTPTMP/tst_xinetd.out
>>> 1>/dev/null
>>>       diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.1 \
>>>           > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
>>>       if [ $RC -ne 0 ]
>>> @@ -312,7 +365,23 @@ test01()
>>>
>>>       # Not checking for exit code from telnet command because telnet is
>>>       # not terminated by the test gracefully.
>>> -    echo " " | telnet localhost > $LTPTMP/tst_xinetd.out 2>&1
>>> +    if [ $IPV6_ENABLED -eq 1 ]
>>> +    then
>>> +        echo " " | $TELNET_COMM ::1 >$LTPTMP/tst_xinetd.out.ipv6 2>&1
>>> +        diff -iwB $LTPTMP/tst_xinetd.out.ipv6
>>>  $LTPTMP/tst_xinetd.exp.2.ipv6 \
>>> +            > $LTPTMP/tst_xinetd.err.ipv6 2>&1 || RC=$?
>>> +        if [ $RC -ne 0 ]
>>> +        then
>>> +            tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \
>>> +                "Test #1: with telnet diabled expected out differs
>>> RC=$RC. Details:"
>>> +            return $RC
>>> +        else
>>> +            tst_resm TPASS \
>>> +            "Test #1: xinetd reads the config file and starts or stops
>>> IPv6 services."
>>> +        fi
>>> +    fi
>>> +
>>> +    echo " " | $TELNET_COMM 127.0.0.1 > $LTPTMP/tst_xinetd.out 2>&1
>>>
>>>       diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.2 \
>>>           > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
>>>
>>>
>> Patch looks good to me.
>>
>> Could you also give a running result based on your patch? Thanks.
>>
>> Leo, please help with review if you have some time :-)
>>
>> Thanks,
>> Caspar
>>
>>
>>
>

--047d7b15a2d1153f1d04e137cda5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:simsun,s=
erif;color:rgb(0,0,0)"><div class=3D"gmail_default">This patch follows the =
previous clean up patch. Only change some indentations.</div><div class=3D"=
gmail_default">

<br></div><div class=3D"gmail_default">Without any other changes of version=
 3.</div></div></div><div class=3D"gmail_extra"><br clear=3D"all"><div><div=
 dir=3D"ltr"><br><div><br></div><div>Thanks,<br>Lingyun Xie</div></div></di=
v>
<br><br><div class=3D"gmail_quote">2013/7/11 Xie Lingyun <span dir=3D"ltr">=
&lt;<a href=3D"mailto:lingyun.xie@bj.cs2c.com.cn" target=3D"_blank">lingyun=
.xie@bj.cs2c.com.cn</a>&gt;</span><br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_default" st=
yle=3D"font-family:simsun,serif">The following is the result of the patch</=
div><div class=3D"gmail_default" style=3D"font-family:simsun,serif">
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


Lingyun Xie</div></div></div><div><div class=3D"h5">
<br><br><div class=3D"gmail_quote">2013/7/11 Caspar Zhang <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:caspar@casparzhang.com" target=3D"_blank">caspar@cas=
parzhang.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204=
,204);border-left-style:solid;padding-left:1ex">


<div><div>On 07/10/2013 07:03 PM, Xie Lingyun wrote:<br>
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
</blockquote></div><br></div></div></div></div>
</blockquote></div><br></div>

--047d7b15a2d1153f1d04e137cda5--

--047d7b15a2d1153f2204e137cda7
Content-Type: application/octet-stream; 
	name="0002-xinetd-xinetd_tests.sh-add-IPv6-test-for-xinetd.patch"
Content-Disposition: attachment; 
	filename="0002-xinetd-xinetd_tests.sh-add-IPv6-test-for-xinetd.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hizo2lpg0

RnJvbSBiODBjMTQxZTJkY2MzN2U0NDcwZmNjYjA0Y2E3MGU0NzgyZTk4YTZlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBYaWUgTGluZ3l1biA8bGluZ3l1bi54aWVAYmouY3MyYy5jb20u
Y24+CkRhdGU6IFRodSwgMTEgSnVsIDIwMTMgMTU6MTQ6MTggKzA4MDAKU3ViamVjdDogW1BBVENI
IDIvMiB2NF0geGluZXRkL3hpbmV0ZF90ZXN0cy5zaDogYWRkIElQdjYgdGVzdCBmb3IgeGluZXRk
CgpJZiBJUHY2IGlzIGVuYWJsZWQsIHRlbG5ldCA6OjEgd2lsbCBiZSB0ZXN0ZWQuIE90aGVyd2lz
ZSwgSVB2NCBvbmx5LgpUaGUgSVB2NiB0ZXN0IHdpbGwgYmUgZXhlY3V0ZWQgZmlyc3QgYW5kIGdp
dmUgYSBzZXBhcmF0ZSByZXN1bHQuCgpTaWduZWQtb2ZmLWJ5OiBYaWUgTGluZ3l1biA8bGluZ3l1
bi54aWVAYmouY3MyYy5jb20uY24+Ci0tLQogdGVzdGNhc2VzL25ldHdvcmsveGluZXRkL3hpbmV0
ZF90ZXN0cy5zaCB8IDgxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgNzUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMvbmV0d29yay94aW5ldGQveGluZXRkX3Rlc3RzLnNoIGIvdGVzdGNhc2VzL25ldHdv
cmsveGluZXRkL3hpbmV0ZF90ZXN0cy5zaAppbmRleCBkODk4YWYwLi5hNjA3ZDMyIDEwMDc1NQot
LS0gYS90ZXN0Y2FzZXMvbmV0d29yay94aW5ldGQveGluZXRkX3Rlc3RzLnNoCisrKyBiL3Rlc3Rj
YXNlcy9uZXR3b3JrL3hpbmV0ZC94aW5ldGRfdGVzdHMuc2gKQEAgLTg0LDExICs4NCwyMiBAQCBp
bml0KCkKICAgICAgICAgIHJldHVybiAkUkMKICAgICBmaQogCisgICAgIyBzb21ldGltZXMgdGhl
IGRlZmF1bHQgdGVsbmV0IG1heSBiZSAvdXNyL2tlcmJlcm9zL2Jpbi90ZWxuZXQKKyAgICBURUxO
RVRfQ09NTT0nL3Vzci9iaW4vdGVsbmV0JworCiAgICAgIyBjaGVjayBpZiBjb21tYW5kcyB0c3Rf
KiwgeGluZXRkLCBhd2sgZXhpc3RzLgogICAgIGNoa19pZmV4aXN0cyBJTklUIHRzdF9yZXNtICAg
fHwgcmV0dXJuICRSQwogICAgIGNoa19pZmV4aXN0cyBJTklUIHhpbmV0ZCAgICAgfHwgcmV0dXJu
ICRSQwogICAgIGNoa19pZmV4aXN0cyBJTklUIGRpZmYgICAgICAgfHwgcmV0dXJuICRSQwotICAg
IGNoa19pZmV4aXN0cyBJTklUIHRlbG5ldCAgICAgfHwgcmV0dXJuICRSQworICAgIGNoa19pZmV4
aXN0cyBJTklUIGlwICAgICAgICAgfHwgcmV0dXJuICRSQworICAgIGNoa19pZmV4aXN0cyBJTklU
ICRURUxORVRfQ09NTSB8fCByZXR1cm4gJFJDCisKKyAgICBJUFY2X0VOQUJMRUQ9MAorICAgIGlw
IGEgfCBncmVwIGluZXQ2ID4gL2Rldi9udWxsIDI+JjEKKyAgICBpZiBbICQ/IC1lcSAwIF0KKyAg
ICB0aGVuCisgICAgICAgIElQVjZfRU5BQkxFRD0xCisgICAgZmkKIAogICAgICMgQ3JlYXRlIGN1
c3RvbSB4aW5ldGQuY29uZiBmaWxlLgogICAgICMgdHN0X3hpbmV0ZC5jb25mLjEgY29uZmlnIGZp
bGUgaGFzIHRlbG5ldCBzZXJ2aWNlIGRpc2FibGVkLgpAQCAtMTI4LDcgKzEzOSw3IEBAIEVPRgog
CiAgICAgIyBDcmVhdGUgZXhwZWN0ZWQgZmlsZSB3aXRoIHRlbG5ldCBkaXNhYmxlZC4KICAgICBj
YXQgPiAkTFRQVE1QL3RzdF94aW5ldGQuZXhwLjEgPDwtRU9GIHx8IFJDPSQ/Ci10ZWxuZXQ6IFVu
YWJsZSB0byBjb25uZWN0IHRvIHJlbW90ZSBob3N0OiBDb25uZWN0aW9uIHJlZnVzZWQKK3RlbG5l
dDogY29ubmVjdCB0byBhZGRyZXNzIDEyNy4wLjAuMTogQ29ubmVjdGlvbiByZWZ1c2VkCiBFT0YK
IAogICAgIGlmIFsgJFJDIC1uZSAwIF0KQEAgLTEzOCwxMCArMTQ5LDIzIEBAIEVPRgogICAgICAg
ICByZXR1cm4gJFJDCiAgICAgZmkKIAorICAgIGlmIFsgJElQVjZfRU5BQkxFRCAtZXEgMSBdCisg
ICAgdGhlbgorICAgICAgICBjYXQgPiAkTFRQVE1QL3RzdF94aW5ldGQuZXhwLjEuaXB2NiA8PC1F
T0YgfHwgUkM9JD8KK3RlbG5ldDogY29ubmVjdCB0byBhZGRyZXNzIDo6MTogQ29ubmVjdGlvbiBy
ZWZ1c2VkCitFT0YKKworICAgICAgICBpZiBbICRSQyAtbmUgMCBdCisgICAgICAgIHRoZW4KKyAg
ICAgICAgICAgIHRzdF9icmttIFRCUk9LIE5VTEwgXAorICAgICAgICAgICAgICAgICJJTklUOiB1
bmFibGUgdG8gY3JlYXRlIGV4cGVjdGVkIGZpbGUgJExUUFRNUC90c3RfeGluZXRkLmV4cC4xIgor
ICAgICAgICBmaQorICAgIGZpCisKICAgICAjIENyZWF0ZSBleHBlY3RlZCBmaWxlIHdpdGggdGVs
bmV0IGVuYWJsZWQuCiAgICAgY2F0ID4gJExUUFRNUC90c3RfeGluZXRkLmV4cC4yIDw8LUVPRiB8
fCBSQz0kPwogVHJ5aW5nIDEyNy4wLjAuMS4uLgotQ29ubmVjdGVkIHRvIGxvY2FsaG9zdCAoMTI3
LjAuMC4xKS4KK0Nvbm5lY3RlZCB0byAxMjcuMC4wLjEuCiBFc2NhcGUgY2hhcmFjdGVyIGlzICde
XScuCiBDb25uZWN0aW9uIGNsb3NlZCBieSBmb3JlaWduIGhvc3QuCiBFT0YKQEAgLTE0OSwxMCAr
MTczLDI2IEBAIEVPRgogICAgIGlmIFsgJFJDIC1uZSAwIF0KICAgICB0aGVuCiAgICAgICAgIHRz
dF9icmttIFRCUk9LICBOVUxMIFwKLSAgICAgICAgICAgICJJTklUOiB1bmFibGUgdG8gY3JlYXRl
IGV4cGVjdGVkIGZpbGUgJExUUFRNUC90c3RfeGluZXRkLmV4cC4xIgorICAgICAgICAgICAgIklO
SVQ6IHVuYWJsZSB0byBjcmVhdGUgZXhwZWN0ZWQgZmlsZSAkTFRQVE1QL3RzdF94aW5ldGQuZXhw
LjIiCiAgICAgICAgIHJldHVybiAkUkMKICAgICBmaQogCisgICAgaWYgWyAkSVBWNl9FTkFCTEVE
IC1lcSAxIF0KKyAgICB0aGVuCisgICAgICAgIGNhdCA+ICRMVFBUTVAvdHN0X3hpbmV0ZC5leHAu
Mi5pcHY2IDw8LUVPRiB8fCBSQz0kPworVHJ5aW5nIDo6MS4uLgorQ29ubmVjdGVkIHRvIDo6MS4K
K0VzY2FwZSBjaGFyYWN0ZXIgaXMgJ15dJy4KK0Nvbm5lY3Rpb24gY2xvc2VkIGJ5IGZvcmVpZ24g
aG9zdC4KK0VPRgorCisgICAgICAgIGlmIFsgJFJDIC1uZSAwIF0KKyAgICAgICAgdGhlbgorICAg
ICAgICAgICAgdHN0X2Jya20gVEJST0sgTlVMTCBcCisgICAgICAgICAgICAgICAgIklOSVQ6IHVu
YWJsZSB0byBjcmVhdGUgZXhwZWN0ZWQgZmlsZSAkTFRQVE1QL3RzdF94aW5ldGQuZXhwLjIuaXB2
NiIKKyAgICAgICAgZmkKKyAgICBmaQorCiAgICAgcmV0dXJuICRSQwogfQogCkBAIC0yNjMsNyAr
MzAzLDIwIEBAIHRlc3QwMSgpCiAKICAgICAjIE5vdCBjaGVja2luZyBmb3IgZXhpdCBjb2RlIGZy
b20gdGVsbmV0IGNvbW1hbmQgYmVjYXVzZSB0ZWxuZXQgaXMKICAgICAjIG5vdCB0ZXJtaW5hdGVk
IGJ5IHRoZSB0ZXN0IGdyYWNlZnVsbHkuCi0gICAgZWNobyAiBCIgfCB0ZWxuZXQgbG9jYWxob3N0
IDI+JExUUFRNUC90c3RfeGluZXRkLm91dCAxPi9kZXYvbnVsbAorICAgIGlmIFsgJElQVjZfRU5B
QkxFRCAtZXEgMSBdCisgICAgdGhlbgorICAgICAgICBlY2hvICIEIiB8ICRURUxORVRfQ09NTSA6
OjEgMj4kTFRQVE1QL3RzdF94aW5ldGQub3V0LmlwdjYgMT4vZGV2L251bGwKKyAgICAgICAgZGlm
ZiAtaXdCICRMVFBUTVAvdHN0X3hpbmV0ZC5vdXQuaXB2NiAgJExUUFRNUC90c3RfeGluZXRkLmV4
cC4xLmlwdjYgXAorICAgICAgICAgICAgPiAkTFRQVE1QL3RzdF94aW5ldGQuZXJyLmlwdjYgMj4m
MSB8fCBSQz0kPworICAgICAgICBpZiBbICRSQyAtbmUgMCBdCisgICAgICAgIHRoZW4KKyAgICAg
ICAgICAgIHRzdF9yZXMgVEZBSUwgJExUUFRNUC90c3RfeGluZXRkLmVyci5pcHY2IFwKKyAgICAg
ICAgICAgICAgICAiVGVzdCAjMTogd2l0aCB0ZWxuZXQgZGlhYmxlZCBleHBlY3RlZCBvdXQgZGlm
ZmVycyBSQz0kUkMuIERldGFpbHM6IgorICAgICAgICAgICAgcmV0dXJuICRSQworICAgICAgICBm
aQorICAgIGZpCisKKyAgICBlY2hvICIEIiB8ICRURUxORVRfQ09NTSAxMjcuMC4wLjEgMj4kTFRQ
VE1QL3RzdF94aW5ldGQub3V0IDE+L2Rldi9udWxsCiAgICAgZGlmZiAtaXdCICRMVFBUTVAvdHN0
X3hpbmV0ZC5vdXQgICRMVFBUTVAvdHN0X3hpbmV0ZC5leHAuMSBcCiAgICAgICAgID4gJExUUFRN
UC90c3RfeGluZXRkLmVyciAyPiYxIHx8IFJDPSQ/CiAgICAgaWYgWyAkUkMgLW5lIDAgXQpAQCAt
MzEyLDcgKzM2NSwyMyBAQCB0ZXN0MDEoKQogCiAgICAgIyBOb3QgY2hlY2tpbmcgZm9yIGV4aXQg
Y29kZSBmcm9tIHRlbG5ldCBjb21tYW5kIGJlY2F1c2UgdGVsbmV0IGlzCiAgICAgIyBub3QgdGVy
bWluYXRlZCBieSB0aGUgdGVzdCBncmFjZWZ1bGx5LgotICAgIGVjaG8gIgQiIHwgdGVsbmV0IGxv
Y2FsaG9zdCA+ICRMVFBUTVAvdHN0X3hpbmV0ZC5vdXQgMj4mMQorICAgIGlmIFsgJElQVjZfRU5B
QkxFRCAtZXEgMSBdCisgICAgdGhlbgorICAgICAgICBlY2hvICIEIiB8ICRURUxORVRfQ09NTSA6
OjEgPiRMVFBUTVAvdHN0X3hpbmV0ZC5vdXQuaXB2NiAyPiYxCisgICAgICAgIGRpZmYgLWl3QiAk
TFRQVE1QL3RzdF94aW5ldGQub3V0LmlwdjYgICRMVFBUTVAvdHN0X3hpbmV0ZC5leHAuMi5pcHY2
IFwKKyAgICAgICAgICAgID4gJExUUFRNUC90c3RfeGluZXRkLmVyci5pcHY2IDI+JjEgfHwgUkM9
JD8KKyAgICAgICAgaWYgWyAkUkMgLW5lIDAgXQorICAgICAgICB0aGVuCisgICAgICAgICAgICB0
c3RfcmVzIFRGQUlMICRMVFBUTVAvdHN0X3hpbmV0ZC5lcnIuaXB2NiBcCisgICAgICAgICAgICAg
ICAgIlRlc3QgIzE6IHdpdGggdGVsbmV0IGRpYWJsZWQgZXhwZWN0ZWQgb3V0IGRpZmZlcnMgUkM9
JFJDLiBEZXRhaWxzOiIKKyAgICAgICAgICAgIHJldHVybiAkUkMKKyAgICAgICAgZWxzZQorICAg
ICAgICAgICAgdHN0X3Jlc20gVFBBU1MgXAorICAgICAgICAgICAgIlRlc3QgIzE6IHhpbmV0ZCBy
ZWFkcyB0aGUgY29uZmlnIGZpbGUgYW5kIHN0YXJ0cyBvciBzdG9wcyBJUHY2IHNlcnZpY2VzLiIK
KyAgICAgICAgZmkKKyAgICBmaQorCisgICAgZWNobyAiBCIgfCAkVEVMTkVUX0NPTU0gMTI3LjAu
MC4xID4gJExUUFRNUC90c3RfeGluZXRkLm91dCAyPiYxCiAKICAgICBkaWZmIC1pd0IgJExUUFRN
UC90c3RfeGluZXRkLm91dCAgJExUUFRNUC90c3RfeGluZXRkLmV4cC4yIFwKICAgICAgICAgPiAk
TFRQVE1QL3RzdF94aW5ldGQuZXJyIDI+JjEgfHwgUkM9JD8KLS0gCjEuOC4zLjEKCg==
--047d7b15a2d1153f2204e137cda7
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
--047d7b15a2d1153f2204e137cda7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--047d7b15a2d1153f2204e137cda7--

