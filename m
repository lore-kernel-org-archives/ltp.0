Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37530C433F5
	for <ltp@archiver.kernel.org>; Wed, 18 May 2022 07:48:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D7D63CAA96
	for <ltp@archiver.kernel.org>; Wed, 18 May 2022 09:48:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E4993C887F
 for <ltp@lists.linux.it>; Wed, 18 May 2022 09:47:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6C517600845
 for <ltp@lists.linux.it>; Wed, 18 May 2022 09:47:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652860073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M9IqrCJHzlZBOX2JqNEM/FGsKtBVn6ASMfErw15bk+A=;
 b=JsgR0DBaAM753Yye2gtLHhm7a9P2GZbnfF48eNlG8fiO7xxC0fB3Zwr4RJee+IA9DRSNJ4
 ete3YCXRPSNdX7Jj10eLGF45ZLvF45x4Pwiiqqy7jOOXTjt+XSJOzop9ZV9xPKrLjnn4WC
 lXv7+a4yOWAuL7WEa2t1vADHoSCmo2A=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-CkrCHLFdPTGaXML6IalMXQ-1; Wed, 18 May 2022 03:47:49 -0400
X-MC-Unique: CkrCHLFdPTGaXML6IalMXQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 a144-20020a25ca96000000b0064d6e10dd6aso1229885ybg.1
 for <ltp@lists.linux.it>; Wed, 18 May 2022 00:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M9IqrCJHzlZBOX2JqNEM/FGsKtBVn6ASMfErw15bk+A=;
 b=VQ992+dZuSBur6JES5cb4otXdS7CWG2C0WK0EvBjp1/ZvDop4wr1xOFL2uaohUL1yC
 cVZganTH6CSzGSyQFP/YW6OmlxFI3TTiV6cG6tm/0bbvG2UlG4769g9jpOAfSVtHjT6n
 N54Ogc11fmbVfiFasKbYmhuDrC+Nxm25S6bEUKuUEqxopCXvkT+h3spvPNQp9xjDKIDP
 Bsoqsefc4P9kcDEwWy3/fdFbfRBkiFRd2UTypDrQq9tNciSRFzwVW73+tyULZ9GRhCD1
 pJEgGfzpPTIgxkTQfxZlam5giuIf4gKW5FUBfqIGfHjbj67Ro9gENawom5140M3n/pXa
 nqMw==
X-Gm-Message-State: AOAM533F+LTVARiC+XK6g0DFRAyAriobWL6+91sUDfaDllaWCHCS9y+b
 vDzEPxHzUM47/YO/zEWq/c7Pjpkv0L6MASqwxgIu49OGSQyzO6I5W1qml7ByrsrnKkCdifgjbiv
 JDkMZcgmMMnZbMwu4mrTzFoyIgy4=
X-Received: by 2002:a81:5b56:0:b0:2ec:34e7:9b5c with SMTP id
 p83-20020a815b56000000b002ec34e79b5cmr30001773ywb.300.1652860069012; 
 Wed, 18 May 2022 00:47:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRS1vqlAqLDWLjHeaSJnYaRWywbRw466QzGWLWYNTnKSqUx8lpWOf67FZ7cqDboJFkbABLvXNCug7KVHAdAmg=
X-Received: by 2002:a81:5b56:0:b0:2ec:34e7:9b5c with SMTP id
 p83-20020a815b56000000b002ec34e79b5cmr30001763ywb.300.1652860068781; Wed, 18
 May 2022 00:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220512123816.24399-23-chrubis@suse.cz>
 <CAEemH2dAfUEjA877h0Lwy9Qw12YgQ6zgQbf1BJemyr7=xfj0Rg@mail.gmail.com>
 <Yn5NGPpfoddFYTs2@yuki>
 <CAEemH2fHsa+JECK5dW64-coQBwdGR3W9W+jKex8zRmKzfLX1=w@mail.gmail.com>
 <Yn5prUjpZEUjoxbL@yuki> <875ym5di8f.fsf@suse.de> <YoN/W4wbow2fyOut@yuki>
 <CAEemH2cazgjqj4C1nuqPcRCC0dZoxwi-yiJymRgJxr0woXXFWw@mail.gmail.com>
In-Reply-To: <CAEemH2cazgjqj4C1nuqPcRCC0dZoxwi-yiJymRgJxr0woXXFWw@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 18 May 2022 15:47:37 +0800
Message-ID: <CAEemH2dYwMczBhFj28yc9xDu0VBg50orjeQBK2s13-8BspK=WQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 22/29] fuzzy_sync: Convert to runtime
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============1079917977=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1079917977==
Content-Type: multipart/alternative; boundary="0000000000004373a205df4479f0"

--0000000000004373a205df4479f0
Content-Type: text/plain; charset="UTF-8"

Li Wang <liwang@redhat.com> wrote:


> Cyril Hrubis <chrubis@suse.cz> wrote:
>
>
>>
>> > Or each test case (defined by tcnt) could be given an equal share of the
>> > runtime?
>>
>> That would be solution as well. If everyone agrees on this I will go
>> with this version, it should be as easy as:
>>
>> diff --git a/lib/tst_test.c b/lib/tst_test.c
>> index dad8aad92..69d7799c3 100644
>> --- a/lib/tst_test.c
>> +++ b/lib/tst_test.c
>> @@ -1349,6 +1349,8 @@ static void run_tests(void)
>>
>>                 if (results_equal(&saved_results, results))
>>                         tst_brk(TBROK, "Test %i haven't reported
>> results!", i);
>> +
>> +               kill(getppid(), SIGUSR1);
>>
>
> I have to say NO here.
>
> This is only reset timeout for each test, the problem we're encountered
> is the max_runtime exhausting, we have to reset 'results->max_runtime'
> but not .timeout.
>

Okay, my perspective is shortsighted as well.

This solution is correct in the direction but overlooks the significant
global value 'tst_start_time'. If that value reflush within tcnt loop we
don't need to reset max_runtime again, actually the real work in my
previous patch is to invoke heartbeat() which touches tst_start_time.

So I would suggest using heartbeat() instead of only sending SIGUSR1
to lib_pid. Or, do simply revision like:

--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1349,6 +1349,10 @@ static void run_tests(void)

                if (results_equal(&saved_results, results))
                        tst_brk(TBROK, "Test %i haven't reported results!",
i);
+
+               if (tst_clock_gettime(CLOCK_MONOTONIC, &tst_start_time))
+                       tst_res(TWARN | TERRNO, "tst_clock_gettime()
failed");
+               kill(getppid(), SIGUSR1);
        }
 }


-- 
Regards,
Li Wang

--0000000000004373a205df4479f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">liwang=
@redhat.com</a>&gt; wrote:<br></div><div>=C2=A0<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div sty=
le=3D"font-size:small"></div></div><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz=
" target=3D"_blank">chrubis@suse.cz</a>&gt; wrote:<br></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"> <br>
&gt; Or each test case (defined by tcnt) could be given an equal share of t=
he<br>
&gt; runtime?<br>
<br>
That would be solution as well. If everyone agrees on this I will go<br>
with this version, it should be as easy as:<br>
<br>
diff --git a/lib/tst_test.c b/lib/tst_test.c<br>
index dad8aad92..69d7799c3 100644<br>
--- a/lib/tst_test.c<br>
+++ b/lib/tst_test.c<br>
@@ -1349,6 +1349,8 @@ static void run_tests(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (results_equal(&=
amp;saved_results, results))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tst_brk(TBROK, &quot;Test %i haven&#39;t reported results!&quot;=
, i);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kill(getppid(), SIG=
USR1);<br></blockquote><div><br></div><div><div style=3D"font-size:small">I=
 have to say NO here.</div><br></div><div><div style=3D"font-size:small">Th=
is is only reset timeout for each test, the problem we&#39;re encountered<b=
r></div><div style=3D"font-size:small">is the max_runtime exhausting, we ha=
ve to reset &#39;results-&gt;max_runtime&#39;</div><div style=3D"font-size:=
small">but not .timeout.</div></div></div></div></blockquote><div><br></div=
><div class=3D"gmail_default" style=3D"font-size:small">Okay, my perspectiv=
e is shortsighted as well.</div><div class=3D"gmail_default" style=3D"font-=
size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small=
">This solution is correct in the direction but overlooks the significant</=
div><div class=3D"gmail_default" style=3D"font-size:small">global value &#3=
9;tst_start_time&#39;. If that value reflush within tcnt loop we</div><div =
class=3D"gmail_default" style=3D"font-size:small">don&#39;t need to reset m=
ax_runtime again,=C2=A0actually=C2=A0the real work in my</div><div class=3D=
"gmail_default" style=3D"font-size:small">previous=C2=A0patch is to invoke=
=C2=A0heartbeat() which touches tst_start_time.</div><div class=3D"gmail_de=
fault" style=3D"font-size:small"><br></div><div class=3D"gmail_default" sty=
le=3D"font-size:small">So I would suggest using heartbeat() instead of only=
 sending SIGUSR1</div><div class=3D"gmail_default" style=3D"font-size:small=
">to lib_pid. Or, do simply revision like:</div><div class=3D"gmail_default=
" style=3D"font-size:small"><br></div></div><div class=3D"gmail_default" st=
yle=3D"font-size:small">--- a/lib/tst_test.c</div>+++ b/lib/tst_test.c<br>@=
@ -1349,6 +1349,10 @@ static void run_tests(void)<br>=C2=A0<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (results_equal(&amp;saved_=
results, results))<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_brk(TBROK, &quot;Test %i haven&#39;t re=
ported results!&quot;, i);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (tst_clock_gettime(CLOCK_MONOTONIC, &amp;tst_start_time))<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tst_res(TWARN | TERRNO, &quot;tst_clock_gettime() failed&quot;);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kill(getppid(), SIGUSR1);<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0}<div><br></div><div><br></div>--=
 <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regar=
ds,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000004373a205df4479f0--


--===============1079917977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1079917977==--

