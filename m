Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EAFC433F5
	for <ltp@archiver.kernel.org>; Sat, 11 Dec 2021 08:11:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CACE23C87C3
	for <ltp@archiver.kernel.org>; Sat, 11 Dec 2021 09:11:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB5243C229E
 for <ltp@lists.linux.it>; Sat, 11 Dec 2021 09:11:10 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AA29220112C
 for <ltp@lists.linux.it>; Sat, 11 Dec 2021 09:11:09 +0100 (CET)
Received: by mail-pj1-x102f.google.com with SMTP id
 nh10-20020a17090b364a00b001a69adad5ebso9387487pjb.2
 for <ltp@lists.linux.it>; Sat, 11 Dec 2021 00:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
 bh=5TYK5AnGE0cXf9BNzwHzyeVftMjaz+gDNcI+kQtXbu4=;
 b=S91uas3gyOW5MrtLSYzXDPoE+8V+i9FN8MqOOCmllqOewQtgyvf59bZv2cMJ7UF7a4
 n5SPMbHYBwdN414NMC22Mv+SqreAI/BNY1k9XNsCCgKPM1kO6aFAbTLIExnnTDKMbd38
 cFSc20da9R18+Rorz27flICsRvEYp+VEcV6PtCLfquNJKxKU4l70VUhTcd/IIwwrBrnO
 VIRvhij9s8237SAZjGuV7c4rAdJVXglNC9h2MSfnGfnY34RAuVcoXhoTKVPoEea1OKpc
 s1IbVuwnMLV4UHwNB0+xov3oHxXw6VC3GZ59ZTun6nmPjoowDy5EMZwYQfJ4phmjouhJ
 cn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:cc;
 bh=5TYK5AnGE0cXf9BNzwHzyeVftMjaz+gDNcI+kQtXbu4=;
 b=WDr7IGH2+E3+He228yNk/CVt423SL1Y6ntKC0BmXa2r9uZT46rsAd2w7FXmKQ2+p6C
 Zz+5p6GoV+2NfGArGLR4LMdKQHqD/JghuDw1TFfhrev/ygKF2pQbZETlolGqfXaI35Mf
 R3HiMoVw25N0Vaqy/RfgjQwMjl2xNLdhG/fOcKaL4rQphM1sp+a2ZI/h72aRoMdSpyU7
 IAnFwYRX0vP0mm8LXEhd+8AMgaRlkPGZeYrtSrUW5Vst1rpF5qvBhtuPBF24exrpt0r1
 D5WEsqUQzYQTDn9MLfIOGTCxkgqEN8GZ+PgsKiF+4iPnnQ1Yf8sOMuRydBCJzrwtug22
 qtGw==
X-Gm-Message-State: AOAM531tviqsC5sJtaaKABz0h2EG76sLHYwOelqaCmW9TF79tUuRNiMG
 AEUugYnrRdyTKl5LvnluUgyPad1f+OrP1sz+4Fs04189
X-Google-Smtp-Source: ABdhPJyl9LISEbNyXFf6qbNkwlVkgegFDJB/D42vkX1OI6m01vJhESeycWwM6RXC3LHISbqF535rNcw5g3w/j94Tx2g=
X-Received: by 2002:a17:90a:1b45:: with SMTP id
 q63mr30089731pjq.135.1639210267869; 
 Sat, 11 Dec 2021 00:11:07 -0800 (PST)
MIME-Version: 1.0
References: <20211127121609.26837-1-saginakash@gmail.com>
 <CAMkC073EZbyb_wux7-Kfv+eT+wL0bB421KpbkypMhkM33LHdvg@mail.gmail.com>
In-Reply-To: <CAMkC073EZbyb_wux7-Kfv+eT+wL0bB421KpbkypMhkM33LHdvg@mail.gmail.com>
From: Sagi Nakash <saginakash@gmail.com>
Date: Sat, 11 Dec 2021 10:10:56 +0200
Message-ID: <CAMkC071FPB41+PuzjMiyb1qsWHZMr_m4x1RpO5oymhMY5y_n5A@mail.gmail.com>
Cc: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] ltp-pan: Report failure if testcases failed
 to run
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
Content-Type: multipart/mixed; boundary="===============0239179155=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0239179155==
Content-Type: multipart/alternative; boundary="000000000000ba884705d2da61c8"

--000000000000ba884705d2da61c8
Content-Type: text/plain; charset="UTF-8"

Ping

On Fri, Dec 3, 2021, 18:41 Sagi Nakash <saginakash@gmail.com> wrote:

> Ping
>
> On Sat, Nov 27, 2021, 14:16 Sagi Nakash <saginakash@gmail.com> wrote:
>
>> In case a test fails to run in run_child() for some reason (signaled via
>> SIGTERM/SIGTOP, execve() failure, etc.), runltp still reports success:
>> "INFO: ltp-pan reported all tests PASS".
>>
>> Failed tests are reported via check_pids(), by checking their exit
>> status, yet it doesn't catch tests which weren't able to run at all.
>>
>> exit_stat holds the exit status code: 0 in case of success in all tests,
>> otherwise, the number of failed tests.
>>
>> Fix this by increasing exit_stat also when a test fails to run.
>>
>> Signed-off-by: Sagi Nakash <saginakash@gmail.com>
>> ---
>>  pan/ltp-pan.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
>> index 0bdb51477..eff9a867d 100644
>> --- a/pan/ltp-pan.c
>> +++ b/pan/ltp-pan.c
>> @@ -551,6 +551,8 @@ int main(int argc, char **argv)
>>                                 ++num_active;
>>                         if ((cpid != -1 || sequential) && starts > 0)
>>                                 --starts;
>> +                       if (cpid == -1 && track_exit_stats)
>> +                               exit_stat++;
>>
>>                         if (sequential)
>>                                 if (++c >= coll->cnt)
>> --
>> 2.25.1
>>
>>

--000000000000ba884705d2da61c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ping</div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Fri, Dec 3, 2021, 18:41 Sagi Nakash &lt;<a href=3D=
"mailto:saginakash@gmail.com">saginakash@gmail.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"auto">Ping</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Nov 27, 2021=
, 14:16 Sagi Nakash &lt;<a href=3D"mailto:saginakash@gmail.com" target=3D"_=
blank" rel=3D"noreferrer">saginakash@gmail.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">In case a test fails to run in run_child() for s=
ome reason (signaled via<br>
SIGTERM/SIGTOP, execve() failure, etc.), runltp still reports success:<br>
&quot;INFO: ltp-pan reported all tests PASS&quot;.<br>
<br>
Failed tests are reported via check_pids(), by checking their exit<br>
status, yet it doesn&#39;t catch tests which weren&#39;t able to run at all=
.<br>
<br>
exit_stat holds the exit status code: 0 in case of success in all tests,<br=
>
otherwise, the number of failed tests.<br>
<br>
Fix this by increasing exit_stat also when a test fails to run.<br>
<br>
Signed-off-by: Sagi Nakash &lt;<a href=3D"mailto:saginakash@gmail.com" rel=
=3D"noreferrer noreferrer" target=3D"_blank">saginakash@gmail.com</a>&gt;<b=
r>
---<br>
=C2=A0pan/ltp-pan.c | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c<br>
index 0bdb51477..eff9a867d 100644<br>
--- a/pan/ltp-pan.c<br>
+++ b/pan/ltp-pan.c<br>
@@ -551,6 +551,8 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++num_active;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if ((cpid !=3D -1 || sequential) &amp;&amp; starts &gt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --starts;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (cpid =3D=3D -1 &amp;&amp; track_exit_stats)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit_stat++;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (sequential)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (++c &gt;=3D coll-&gt;cnt)<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>
</blockquote></div>

--000000000000ba884705d2da61c8--

--===============0239179155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0239179155==--
