Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D3EC433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 06:36:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A361D3C9257
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 07:36:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 816E13C8BD3
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 07:35:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CCB7E1A01555
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 07:35:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640154947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cDDElGylCJ1CUHUyfECIEDan3El/gL1loIMF76valyc=;
 b=XdapJlQB3DrkdtARxqunAlxV5Xl0duQ3m0i/DTvc6kLaUMbZnYgo+kcd+IjkdQI+pmxOeY
 1wGKxj25rzCzH/cvV31/zKVn1eaJiYJsdzcmFD4ITT8JWuhQ6Kkn29q/xGdybSvWhK2sfc
 83n3PwMwwcPcYbJQeJ26pBivS7P1Ilg=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-HpxC2PONPMyI2HioqpFE3A-1; Wed, 22 Dec 2021 01:35:43 -0500
X-MC-Unique: HpxC2PONPMyI2HioqpFE3A-1
Received: by mail-yb1-f200.google.com with SMTP id
 h5-20020a255f45000000b005ffd939127bso2331032ybm.10
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 22:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cDDElGylCJ1CUHUyfECIEDan3El/gL1loIMF76valyc=;
 b=kayYNJLWRJcV00rLt2i2JiNKpZWH5FBJBvymIxuwpcn8BDPOKxwFbrGVd3p2UQ4cWw
 upGrOaZVtx7tHNReIVaV9HVn0/N4vipKG9ZHzYhh5tsbblPMZxU1deQWRCXhd6BMAftH
 Z6x4iNGX4DQVgRvuGQ1HXHXPZ7JKnMCu5eVYfS/EYTPO67ZJaYazqcdBv8zJkx+JusqX
 eM9hurvvwWAX0RvX51ja9PLTbe5glcXf4h4sQV6+3nYS9gEgtEkU4S6j3ZZahYi5392D
 HPrm4C5ZHFEnzWoFavLPmSRcGZdE60RPPSOy2XC9DUy+soiiZryyj5MUBRebLLUzJStu
 9D0g==
X-Gm-Message-State: AOAM532pT3XYwAZejnuk09SBmeJ6unVaP3DiG7G4IyWlfO/Bre1WCRC9
 hPTLQfHmUqqbAEhF8ojaoRfto8jXpg4mNoiVyKJjDr5oTYlhTWdtEnKCktuczKJo0Q4ATCdX6Ii
 oSlHoNLaPzBbwJtaKDnsTPUbVctk=
X-Received: by 2002:a25:b13:: with SMTP id 19mr2582037ybl.71.1640154942869;
 Tue, 21 Dec 2021 22:35:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynTJgI03wxbmTMDCGjjSSWIcf1wPAvvIsU84fdUeTaM18dG6P9nVWcKQFsStbvjmZd2fnGiyI3y842sI6qwRc=
X-Received: by 2002:a25:b13:: with SMTP id 19mr2582023ybl.71.1640154942638;
 Tue, 21 Dec 2021 22:35:42 -0800 (PST)
MIME-Version: 1.0
References: <CAEemH2eZDBODpZwjcCq=M=wT0uiSUSM+iS88F7-OQP-pkYRn=A@mail.gmail.com>
 <YcHQr22KuWECB1aa@yuki>
In-Reply-To: <YcHQr22KuWECB1aa@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Dec 2021 14:35:27 +0800
Message-ID: <CAEemH2coubY_CX2Yi0EwdcdW4ru2jrdW9WPmCwpycCm2woPK5w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Question] Why test C API failed in github CI
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
Content-Type: multipart/mixed; boundary="===============0758083444=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0758083444==
Content-Type: multipart/alternative; boundary="000000000000bbae6705d3b65413"

--000000000000bbae6705d3b65413
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 21, 2021 at 9:02 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Firstly, I'm sorry to push the patchset about oom protection cursorily.
>
> No problem.
>
> > The GitHub CI complained about the following failures, I feel confused
> > when I add a bit of debug code in my private branch then. It gets passed
> > in access(score_path, R_OK|W_OK) but failed in closing the file and
> > give no EACCESS errno, that's wired.
> >
> > Did I miss anything?
> >
> > https://github.com/wangli5665/ltp/runs/4594473907?check_suite_focus=true
>
> It does fail the same for me locally when I run the test05 under an
> unpriviledged user. I guess that the error when we write negative number
> to the file actually manifests when we attempt to close the file because
> we use the FILE interface in safe_file_printf(). That way the actuall
> write is buffered and deffered until the fclose() call.
>

Sounds possible.


>
> So it looks like writing negative value to the file does return with
> error for an unprivileged user.
>
> I was looking at file_printf() as a potential solution, but that one
> does produce warnings. But it looks like we do not actually use the
> file_printf() function anywhere in the code so we may as well change it
> so that it just returns if the operation was successful or not and make
> it silent so that it does not produce any messages at all.
>

+1 It makes sense to keep silent when the operation is not successful.
That needs an explicit difference between safe_file_printf() I guess.

-- 
Regards,
Li Wang

--000000000000bbae6705d3b65413
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Dec 21, 2021 at 9:02 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; Firstly, I&#39;m sorry to push the patchset about oom protection curso=
rily.<br>
<br>
No problem.<br>
<br>
&gt; The GitHub CI complained about the following failures, I feel confused=
<br>
&gt; when I add a bit of debug code in my private branch then. It gets pass=
ed<br>
&gt; in access(score_path, R_OK|W_OK) but failed in closing the file and<br=
>
&gt; give no EACCESS errno, that&#39;s wired.<br>
&gt; <br>
&gt; Did I miss anything?<br>
&gt; <br>
&gt; <a href=3D"https://github.com/wangli5665/ltp/runs/4594473907?check_sui=
te_focus=3Dtrue" rel=3D"noreferrer" target=3D"_blank">https://github.com/wa=
ngli5665/ltp/runs/4594473907?check_suite_focus=3Dtrue</a><br>
<br>
It does fail the same for me locally when I run the test05 under an<br>
unpriviledged user. I guess that the error when we write negative number<br=
>
to the file actually manifests when we attempt to close the file because<br=
>
we use the FILE interface in safe_file_printf(). That way the actuall<br>
write is buffered and deffered until the fclose() call.<br></blockquote><di=
v><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">Sou=
nds possible.</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
So it looks like writing negative value to the file does return with<br>
error for an unprivileged user.<br>
<br>
I was looking at file_printf() as a potential solution, but that one<br>
does produce warnings. But it looks like we do not actually use the<br>
file_printf() function anywhere in the code so we may as well change it<br>
so that it just returns if the operation was successful or not and make<br>
it silent so that it does not produce any messages at all.<br></blockquote>=
<div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">=
+1 It makes sense to keep silent when the operation is not successful.</div=
></div><div class=3D"gmail_default" style=3D"font-size:small">That=C2=A0nee=
ds an explicit=C2=A0difference between safe_file_printf() I guess.</div></d=
iv><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div di=
r=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000bbae6705d3b65413--


--===============0758083444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0758083444==--

