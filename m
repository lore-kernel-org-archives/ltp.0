Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34424C433EF
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 18:43:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E57033CA19C
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 20:43:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B69C3C97E3
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 20:42:57 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E1F9A601179
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 20:42:56 +0200 (CEST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5426C40274
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 18:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1657132972;
 bh=efZ7K4c0cgcdqlk/ipzYS9BgF0mkGiivePmGESrC8AM=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=vCCmAOc4IsluhEpan2be40ihiEmnQf2q7X8Yv9jpJC2OCvDj8GVSygnFTwMpwcwr4
 jBqJpQBTzCDhqkPnXTGO/titnhmVIbJKvlUKbfqpANWAl1UVt6B8WLG6mjux88AjEL
 FY+ZX6BDW0k8uUxa1iPAvc9ILougu/aQyTOpFRcn01XKagHruz/ZOiHRpfSC+OhNca
 Hehra5kh/ImuYWgquFIH7KKBuXRln8bT9HgEDV4QA+pHY4Bh9B+xAUVBJQMGHnczAn
 gXGf9kaAy/u+DhunnEPdSnu0TmOQAXyOw+fSoX1ChKpOf7KJ+rKUq0/fvI183A4NfE
 SonUktoo44sTA==
Received: by mail-ej1-f69.google.com with SMTP id
 qa41-20020a17090786a900b00722f313a60eso4065335ejc.13
 for <ltp@lists.linux.it>; Wed, 06 Jul 2022 11:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=efZ7K4c0cgcdqlk/ipzYS9BgF0mkGiivePmGESrC8AM=;
 b=Vn5wZ7DJztN3B3o3DpgGKdrk1h/yMvX7sBbztUJBYMBoxTKI25wwwW5I+FGgFH97Ai
 9TII40WIo6F6lrFjaE5AMPtuZmLkoVHGQ1Kc82sWAp1sd+/w6GUdl5KeQUe2Of+MH0WE
 OTBezoU2RUdDz5cAnqF46SUGfCr0g7JLm2cBOwh/impgcTEF2Uu9PX3+JRuSmbODFocY
 DIUlIO92DaYzq4SmL7y1DZruInBah3/6qjQDvO3djB3ZkPp8JMUshf8jAY99sLmMyPWb
 MdzxBaucnXv0jZxkuZJiVCnhqmaZJK5nKEWJ6UZbZ/FXjl8Jr3KUuOitmFnqYYpJKck1
 5Hvg==
X-Gm-Message-State: AJIora8knE8O2IO5tT3RPAXW6b9wJvaTR1ZQ6Uqb4WwCZf1Esg7WvRan
 DrD/1d9juHge2eCElYdWmA6DYIFcBxQlRYPcOuFnLGtnfj89EenBehnsVrqeTzbt4IeuMWF5qHu
 9TmMpPgkm9lQcisStzSyZ7C3jINAPApWaYaUQJfau8Luq
X-Received: by 2002:a17:907:3f92:b0:72a:b80c:ef3 with SMTP id
 hr18-20020a1709073f9200b0072ab80c0ef3mr20712883ejc.264.1657132971940; 
 Wed, 06 Jul 2022 11:42:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1stvlcbGZgLZG1LPw6GLc4vtQIipBIueCDOS/71em62jlQQZEnBCZsmYcix73e48PK2JIF5HertY1o6EHGrqDs=
X-Received: by 2002:a17:907:3f92:b0:72a:b80c:ef3 with SMTP id
 hr18-20020a1709073f9200b0072ab80c0ef3mr20712869ejc.264.1657132971711; Wed, 06
 Jul 2022 11:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220701213749.3744031-1-edliaw@google.com>
 <CAEemH2cQBinVjFP27NkRQJpEVCvfA08=gxdb5tk1nDRo0eN_nA@mail.gmail.com>
In-Reply-To: <CAEemH2cQBinVjFP27NkRQJpEVCvfA08=gxdb5tk1nDRo0eN_nA@mail.gmail.com>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Wed, 6 Jul 2022 11:42:15 -0700
Message-ID: <CADS1e3eAZ13nKP4Yq2MX0Xz5dOFR3ZuzF+HVJF7CsptSUgmbkQ@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] controllers.memcg_regression: add trap to
 clean up directories
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0764149396=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0764149396==
Content-Type: multipart/alternative; boundary="00000000000020041205e32756c8"

--00000000000020041205e32756c8
Content-Type: text/plain; charset="UTF-8"

Hey,

On Tue, Jul 5, 2022 at 11:00 PM Li Wang <liwang@redhat.com> wrote:

> Hi Edward,
>
> Thanks for your patch and I believe it makes sense.
> But the whole memcg test has been re-written by Luke's patchset which is
> still reviewing.
> https://lists.linux.it/pipermail/ltp/2022-April/028777.html
>
> @Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> Luke, I guess V3 should be the final version (if you take the time to do
> rebase/modification) and we'll happy to help merge those patches next:).
>
>
Let me finally get around to putting up the (hopefully) final revision so
that people don't start doing things I already did :)


>
>
> On Sat, Jul 2, 2022 at 5:38 AM Edward Liaw via ltp <ltp@lists.linux.it>
> wrote:
>
>> The memcg_regression test creates a memcg/ directory that can be left
>> behind if the test exits unexpectedly.  Use a trap to clean up the
>> directories on exit.
>>
>> Signed-off-by: Edward Liaw <edliaw@google.com>
>> ---
>>  .../memcg/regression/memcg_regression_test.sh | 20 +++++++++++--------
>>  .../memcg/regression/memcg_test_4.sh          | 11 ++++++----
>>  2 files changed, 19 insertions(+), 12 deletions(-)
>>
>> diff --git
>> a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
>> b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
>> index c91a4069e..2467ae0e6 100755
>> ---
>> a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
>> +++
>> b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
>> @@ -54,6 +54,15 @@ nr_null=0
>>  nr_warning=0
>>  nr_lockdep=0
>>
>> +clean_up()
>> +{
>> +       # remove the cgroup
>> +       rmdir memcg/0 2> /dev/null
>> +       # unmount cgroup if still mounted
>> +       umount memcg/
>> +       rmdir memcg/
>> +}
>> +
>>  # check_kernel_bug - check if some kind of kernel bug happened
>>  check_kernel_bug()
>>  {
>> @@ -102,12 +111,12 @@ check_kernel_bug()
>>
>>  #---------------------------------------------------------------------------
>>  test_1()
>>  {
>> -       mkdir memcg/0/
>> +       mkdir memcg/0
>>         echo 0 > memcg/0/memory.limit_in_bytes
>>
>>         ./memcg_test_1
>>
>> -       rmdir memcg/0/
>> +       rmdir memcg/0
>>
>>         check_kernel_bug
>>         if [ $? -eq 1 ]; then
>> @@ -211,14 +220,12 @@ test_4()
>>         killall -9 memcg_test_4 2> /dev/null
>>         killall -9 memcg_test_4.sh 2> /dev/null
>>
>> -       # if test_4.sh gets killed, it won't clean cgroup it created
>> -       rmdir memcg/0 2> /dev/null
>> -
>>         swapon -a
>>  }
>>
>>  # main
>>  failed=0
>> +trap clean_up EXIT
>>  mkdir memcg/
>>
>>  for cur in $(seq 1 $TST_TOTAL); do
>> @@ -236,7 +243,4 @@ for cur in $(seq 1 $TST_TOTAL); do
>>         umount memcg/
>>  done
>>
>> -rmdir memcg/
>> -
>>  exit $failed
>> -
>> diff --git
>> a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
>> b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
>> index 620031366..d002601f1 100755
>> --- a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
>> +++ b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
>> @@ -22,6 +22,13 @@
>>  ##
>>       ##
>>
>>  ################################################################################
>>
>> +clean_up()
>> +{
>> +       # remove the cgroup when exiting
>> +       rmdir memcg/0
>> +}
>> +
>> +trap clean_up EXIT
>>  # attach current task to memcg/0/
>>  mkdir memcg/0
>>  echo $$ > memcg/0/tasks
>> @@ -42,7 +49,3 @@ swapoff -a
>>  sleep 1
>>  echo $pid > memcg/tasks 2> /dev/null
>>  echo $$ > memcg/tasks 2> /dev/null
>> -
>> -# now remove the cgroup
>> -rmdir memcg/0
>> -
>> --
>> 2.37.0.rc0.161.g10f37bed90-goog
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>>
>>
>
> --
> Regards,
> Li Wang
>

- Luke

--00000000000020041205e32756c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hey,<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Jul 5, 2022 at 11:00 PM Li Wang &lt;<=
a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div =
dir=3D"ltr"><div style=3D"font-size:small">Hi Edward,</div><div style=3D"fo=
nt-size:small"><br></div><div style=3D"font-size:small">Thanks for your pat=
ch and I believe it makes sense.</div><div style=3D"font-size:small">But th=
e whole memcg test has been re-written by Luke&#39;s patchset which is stil=
l reviewing.</div><div style=3D"font-size:small"><a href=3D"https://lists.l=
inux.it/pipermail/ltp/2022-April/028777.html" target=3D"_blank">https://lis=
ts.linux.it/pipermail/ltp/2022-April/028777.html<br></a></div><div style=3D=
"font-size:small"><br></div><div style=3D"font-size:small"><a class=3D"gmai=
l_plusreply" id=3D"gmail-m_-3967992612121128723plusReplyChip-0" href=3D"mai=
lto:luke.nowakowskikrijger@canonical.com" target=3D"_blank">@Luke Nowakowsk=
i-Krijger</a>=C2=A0=C2=A0</div><div style=3D"font-size:small">Luke, I guess=
 V3 should be the final version (if you take the time to do</div><div style=
=3D"font-size:small">rebase/modification) and we&#39;ll happy to help merge=
 those patches next:).</div><div style=3D"font-size:small"><br></div></div>=
</div></blockquote><div><br></div><div>Let me finally get around to putting=
 up the (hopefully) final revision so that people don&#39;t start doing thi=
ngs I already did :) <br></div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"font=
-size:small"></div><div style=3D"font-size:small"><br></div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jul 2, =
2022 at 5:38 AM Edward Liaw via ltp &lt;<a href=3D"mailto:ltp@lists.linux.i=
t" target=3D"_blank">ltp@lists.linux.it</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">The memcg_regression test creates a =
memcg/ directory that can be left<br>
behind if the test exits unexpectedly.=C2=A0 Use a trap to clean up the<br>
directories on exit.<br>
<br>
Signed-off-by: Edward Liaw &lt;<a href=3D"mailto:edliaw@google.com" target=
=3D"_blank">edliaw@google.com</a>&gt;<br>
---<br>
=C2=A0.../memcg/regression/memcg_regression_test.sh | 20 +++++++++++-------=
-<br>
=C2=A0.../memcg/regression/memcg_test_4.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 11 ++++++----<br>
=C2=A02 files changed, 19 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regression=
_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_t=
est.sh<br>
index c91a4069e..2467ae0e6 100755<br>
--- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.s=
h<br>
+++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.s=
h<br>
@@ -54,6 +54,15 @@ nr_null=3D0<br>
=C2=A0nr_warning=3D0<br>
=C2=A0nr_lockdep=3D0<br>
<br>
+clean_up()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# remove the cgroup<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rmdir memcg/0 2&gt; /dev/null<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# unmount cgroup if still mounted<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0umount memcg/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rmdir memcg/<br>
+}<br>
+<br>
=C2=A0# check_kernel_bug - check if some kind of kernel bug happened<br>
=C2=A0check_kernel_bug()<br>
=C2=A0{<br>
@@ -102,12 +111,12 @@ check_kernel_bug()<br>
=C2=A0#--------------------------------------------------------------------=
-------<br>
=C2=A0test_1()<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0mkdir memcg/0/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mkdir memcg/0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo 0 &gt; memcg/0/memory.limit_in_bytes<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ./memcg_test_1<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rmdir memcg/0/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rmdir memcg/0<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 check_kernel_bug<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ $? -eq 1 ]; then<br>
@@ -211,14 +220,12 @@ test_4()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 killall -9 memcg_test_4 2&gt; /dev/null<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 killall -9 memcg_test_4.sh 2&gt; /dev/null<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0# if test_4.sh gets killed, it won&#39;t clean =
cgroup it created<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rmdir memcg/0 2&gt; /dev/null<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 swapon -a<br>
=C2=A0}<br>
<br>
=C2=A0# main<br>
=C2=A0failed=3D0<br>
+trap clean_up EXIT<br>
=C2=A0mkdir memcg/<br>
<br>
=C2=A0for cur in $(seq 1 $TST_TOTAL); do<br>
@@ -236,7 +243,4 @@ for cur in $(seq 1 $TST_TOTAL); do<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 umount memcg/<br>
=C2=A0done<br>
<br>
-rmdir memcg/<br>
-<br>
=C2=A0exit $failed<br>
-<br>
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh =
b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh<br>
index 620031366..d002601f1 100755<br>
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh<br>
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh<br>
@@ -22,6 +22,13 @@<br>
=C2=A0##=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
=C2=A0#####################################################################=
###########<br>
<br>
+clean_up()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# remove the cgroup when exiting<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rmdir memcg/0<br>
+}<br>
+<br>
+trap clean_up EXIT<br>
=C2=A0# attach current task to memcg/0/<br>
=C2=A0mkdir memcg/0<br>
=C2=A0echo $$ &gt; memcg/0/tasks<br>
@@ -42,7 +49,3 @@ swapoff -a<br>
=C2=A0sleep 1<br>
=C2=A0echo $pid &gt; memcg/tasks 2&gt; /dev/null<br>
=C2=A0echo $$ &gt; memcg/tasks 2&gt; /dev/null<br>
-<br>
-# now remove the cgroup<br>
-rmdir memcg/0<br>
-<br>
-- <br>
2.37.0.rc0.161.g10f37bed90-goog<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div></blockquote><div><br></div><div>- Luke <br></div></div></div>

--00000000000020041205e32756c8--

--===============0764149396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0764149396==--
