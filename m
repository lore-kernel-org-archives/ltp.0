Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC55C433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 04:46:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD68B3CA940
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 06:46:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6533E3CA4A0
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 06:46:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9B9001A00CD0
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 06:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657773961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VnQL1mw2ZQ9Ni/vGZGAamOnPA8zGFjeknWgi9kWpe4A=;
 b=bQN/8pRQjKbsnMu+k5BFvZeyIT3wbTFHp6KWuFIFsjGP19aCSbGD0uK+bqXxaUsuz6anJz
 kk1jMfoHlhhxbmMq6gKDzIEMx7/CATIIehPd5D907bWMrsAklarpwo2Dztmx6378SIgjvo
 xgznmGdufpDRtQVCAZvWv8ZN3+J/Svg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-V3u39FnyNHCmdOAztZIS2Q-1; Thu, 14 Jul 2022 00:46:00 -0400
X-MC-Unique: V3u39FnyNHCmdOAztZIS2Q-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-31c9d560435so5860337b3.21
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 21:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VnQL1mw2ZQ9Ni/vGZGAamOnPA8zGFjeknWgi9kWpe4A=;
 b=Ijk6nYQH3BUVUthDznbyqtKXDefmOsH+luza9N7QTonr/Dme5zkrtDOUUPZ3oLP83C
 julKtVt2OGae2cVSawfZ2ldbXHQAywJmtmhgJhNNwdvZlgItlbBGhbUtxjgOxQi3272K
 kkiPsj5rOcszvQw4IxVxFAZ4zd0dEmRQgEPrXfK0eaZMNFTo/MNaIeL5FCgcVIrrwUCM
 j+M1Pg4FNjeDM89tSNjXW4h1yKaFpnt7rZZU/r2tBSNBydavcl7kSwB81vggfbV/558A
 qsZcDSXxiaIEG3q68LEjvnAajoWuX0cYlwZx8l4YDdwPoz8wjPa9UmSyICLNAv58MUvo
 gQug==
X-Gm-Message-State: AJIora8U4A38TkAEZOnV85iG7ngP/pCL8kJ4Jx8yRhAKl9lOmyOwDUl9
 ZgE8xNQZSCk3YyqHOdMA1s6OyYaf1bgHoyfrBpKaO7e/CRBC8gqt+5IeWBB6hbiWM+ormOmC0IH
 K1yIXJGACnEKhLyUs/a5YPdXkqGg=
X-Received: by 2002:a25:ac0f:0:b0:66e:308d:9eef with SMTP id
 w15-20020a25ac0f000000b0066e308d9eefmr6788236ybi.591.1657773959454; 
 Wed, 13 Jul 2022 21:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uzjTfaS1p8QhqLzvFawRKJmmAOhJs/S30E5rHZ/8Pj489/+tdju+OjpW9rNkS5Bn/9dWlVhqEFcyTfFNgE7xw=
X-Received: by 2002:a25:ac0f:0:b0:66e:308d:9eef with SMTP id
 w15-20020a25ac0f000000b0066e308d9eefmr6788223ybi.591.1657773959172; Wed, 13
 Jul 2022 21:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220712124617.23139-1-rpalethorpe@suse.com>
In-Reply-To: <20220712124617.23139-1-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 14 Jul 2022 12:45:48 +0800
Message-ID: <CAEemH2e=-8rt+N=VdiA27xO=-Z5zE4RPu+MCf2NDCuOTq6xcAw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] read_all: Add worker timeout
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1317547295=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1317547295==
Content-Type: multipart/alternative; boundary="000000000000f470f905e3bc9319"

--000000000000f470f905e3bc9319
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

On Tue, Jul 12, 2022 at 8:46 PM Richard Palethorpe <rpalethorpe@suse.com>
wrote:

> Kill and restart workers that take too long to read a file. The
> default being one second. A custom time can be set with the new -t
> option.
>
> This is to prevent a worker from blocking forever in a read. Currently
> when this happens the whole test times out and any remaining files in
> the worker's queue are not tested.
>
> As a side effect we can now also set the timeout very low to cause
> partial reads.
>

To restart workers which are blocked from reading files is a practical way.
My only concern is that restarted-worker is also slower reading on some
specific files so it will still be timed out again. Then the rest will fall
into
restart cycles. Here I'd suggest loosening the worker_timeout to 3000 ms
to accommodate systems of different IO speeds.

Though each worker at most takes 3secs, the max time would not
be overdue 45s (3 sec * max_works), unless tested sequentially
in the worst case. So bumping up max_runtime maybe also helpful.

Anyway, I'd be happy to apply your patch first to see how things going.
Reviewed-by: Li Wang <liwang@redhat.com>

--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -64,7 +64,7 @@ struct queue {
 struct worker {
        pid_t pid;
        struct queue *q;
-       int last_seen;
+       unsigned long long last_seen;
 };

 enum dent_action {
@@ -86,7 +86,7 @@ static long max_workers = 15;
 static struct worker *workers;
 static char *drop_privs;
 static char *str_worker_timeout;
-static int worker_timeout = 1000;
+static int worker_timeout = 3000;

 static char *blacklist[] = {
        NULL, /* reserved for -e parameter */
@@ -552,5 +552,6 @@ static struct tst_test test = {
        .cleanup = cleanup,
        .test_all = run,
        .forks_child = 1,
+       .max_runtime = 60,
 };


-- 
Regards,
Li Wang

--000000000000f470f905e3bc9319
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Richard,</div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Tue, Jul 12, 2022 at 8:46 PM Richard Pale=
thorpe &lt;<a href=3D"mailto:rpalethorpe@suse.com" target=3D"_blank">rpalet=
horpe@suse.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Kill and restart workers that take too long to read a file. T=
he<br>
default being one second. A custom time can be set with the new -t<br>
option.<br>
<br>
This is to prevent a worker from blocking forever in a read. Currently<br>
when this happens the whole test times out and any remaining files in<br>
the worker&#39;s queue are not tested.<br>
<br>
As a side effect we can now also set the timeout very low to cause<br>
partial reads.<br></blockquote><div><br></div><div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">To restart workers which are blocked from re=
ading files is a practical way.</div><div class=3D"gmail_default" style=3D"=
font-size:small">My only concern is that restarted-worker is also slower re=
ading on some</div><div class=3D"gmail_default" style=3D"font-size:small">s=
pecific files so it will still be timed=C2=A0out again. Then the rest will =
fall into=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:small"=
>restart cycles. Here I&#39;d suggest loosening the worker_timeout to 3000 =
ms</div><div class=3D"gmail_default" style=3D"font-size:small">to accommoda=
te systems of different IO speeds.</div><div class=3D"gmail_default" style=
=3D"font-size:small"><br></div></div><div><div class=3D"gmail_default" styl=
e=3D"font-size:small">Though=C2=A0each worker at most takes 3secs, the max =
time would not</div><div class=3D"gmail_default" style=3D"font-size:small">=
be overdue 45s (3 sec * max_works), unless tested sequentially</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">in the worst case. So bumpi=
ng up max_runtime maybe also helpful.</div><br></div><div><div class=3D"gma=
il_default" style=3D"font-size:small">Anyway, I&#39;d be happy to apply you=
r patch first to see how things going.</div><div class=3D"gmail_default" st=
yle=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@r=
edhat.com" target=3D"_blank">liwang@redhat.com</a>&gt;</div><br></div><div>=
<div class=3D"gmail_default" style=3D"font-size:small">--- a/testcases/kern=
el/fs/read_all/read_all.c<br>+++ b/testcases/kernel/fs/read_all/read_all.c<=
br>@@ -64,7 +64,7 @@ struct queue {<br>=C2=A0struct worker {<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 pid_t pid;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct queue *q=
;<br>- =C2=A0 =C2=A0 =C2=A0 int last_seen;<br>+ =C2=A0 =C2=A0 =C2=A0 unsign=
ed long long last_seen;<br>=C2=A0};<br>=C2=A0<br>=C2=A0enum dent_action {<b=
r>@@ -86,7 +86,7 @@ static long max_workers =3D 15;<br>=C2=A0static struct =
worker *workers;<br>=C2=A0static char *drop_privs;<br>=C2=A0static char *st=
r_worker_timeout;<br>-static int worker_timeout =3D 1000;<br>+static int wo=
rker_timeout =3D 3000;<br>=C2=A0<br>=C2=A0static char *blacklist[] =3D {<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, /* reserved for -e parameter */<br>@@ -5=
52,5 +552,6 @@ static struct tst_test test =3D {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .cleanup =3D cleanup,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_all =3D r=
un,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .forks_child =3D 1,<br>+ =C2=A0 =C2=A0 =
=C2=A0 .max_runtime =3D 60,<br>=C2=A0};<br></div><div class=3D"gmail_defaul=
t" style=3D"font-size:small"></div></div><div><br></div></div><div><br></di=
v>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li W=
ang<br></div></div></div></div>

--000000000000f470f905e3bc9319--


--===============1317547295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1317547295==--

