Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D4EC433F5
	for <ltp@archiver.kernel.org>; Sat, 12 Feb 2022 03:04:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D3503C9F51
	for <ltp@archiver.kernel.org>; Sat, 12 Feb 2022 04:04:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A02E3C1041
 for <ltp@lists.linux.it>; Sat, 12 Feb 2022 04:04:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1E50114016F8
 for <ltp@lists.linux.it>; Sat, 12 Feb 2022 04:04:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644635047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZlnjKJ6uBseo/bjNivT4IsG8O5TVIBMSbRmKpRld9/I=;
 b=OXzMFVQ0GWHHo72QDWRnjH9H0Uhyd7PBd1fqqS1BLYZ36RvI3B7udRXPiaueeyN5unlLC+
 yyEct8X+lFiolMy5I9gDd4vB1ifrAKWS2HaMJbJfnWGQWE7s67K/oDTWq5wNb1T92/e1M8
 sfvfRvz0xBPy2CqScQYR6K5AUpOOx3I=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-bF2qkLKjMT6ZvCewxXkzEw-1; Fri, 11 Feb 2022 22:04:05 -0500
X-MC-Unique: bF2qkLKjMT6ZvCewxXkzEw-1
Received: by mail-yb1-f197.google.com with SMTP id
 q11-20020a252a0b000000b0061e240c8fb3so19245546ybq.22
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 19:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZlnjKJ6uBseo/bjNivT4IsG8O5TVIBMSbRmKpRld9/I=;
 b=KoDjYgGt8laUmOm9tDgwIrPk4/2VHC/JVz5Q4WQmbZ0aNTnZtvCcswVDqO8mMpGusV
 unbOKEu8zP79mddGXroBTfFgEK1UZR7N13khr1W97SDn9Wjlu0UkIcodpK86xhRYm8ZH
 vvz1K4V5eKI0+hWvznT8EYF7dlzO07t1CU6NiDMnxEW27mGDPiwRoOOT3OvHq82yI6Gj
 JjE/h+r8o98fx8edbV/B39ADbYIuL7KAAcLjht+Gyi++0iaUMWTLMGKIltqgsNRFY3z6
 QqrRDlZLZHbKNLcRtaCgfPeHQ+LAvQofEEbiH7/u7Ye42jPA5gRoZMgMwnt+ImuBO76m
 7bsg==
X-Gm-Message-State: AOAM532CXfINZbJ5qSIWRzItdEUOqCVB+42IiWIf4syrRBQTdg070OnN
 txJNLMbQpuISeMnl7vT+jqZKKH9xM5V6wKqbPn6LR5ey3LQdPBL0/rEc5d9zuaF2kNAAKeAstbG
 KS9nXumRyTUqwpla4UPZcELdAZAE=
X-Received: by 2002:a81:3552:: with SMTP id c79mr5074108ywa.300.1644635045202; 
 Fri, 11 Feb 2022 19:04:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvVsycwyk9eLTbkjv9A1BVYeqT5HqKw5y95GMTSqogkWIqZ2r5gcPFB8+R4q9hUsQ3NjxHVq22qlcpjZwydlY=
X-Received: by 2002:a81:3552:: with SMTP id c79mr5074090ywa.300.1644635044932; 
 Fri, 11 Feb 2022 19:04:04 -0800 (PST)
MIME-Version: 1.0
References: <20220211114401.24663-1-mdoucha@suse.cz> <YgZcu4frLBaKVXL2@yuki>
 <2e218131-be2b-d6c8-51f7-f12b9091e859@suse.cz>
In-Reply-To: <2e218131-be2b-d6c8-51f7-f12b9091e859@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Sat, 12 Feb 2022 11:03:51 +0800
Message-ID: <CAEemH2fqy3_t=-dbqE9Bx3VH6sZbNvM_bMon4zMukOh+rmw42Q@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Terminate leftover subprocesses when main test
 process crashes
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
Content-Type: multipart/mixed; boundary="===============1897205693=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1897205693==
Content-Type: multipart/alternative; boundary="000000000000a38a3d05d7c96f77"

--000000000000a38a3d05d7c96f77
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 11, 2022 at 9:30 PM Martin Doucha <mdoucha@suse.cz> wrote:

> On 11. 02. 22 13:55, Cyril Hrubis wrote:
> > Hi!
> >> --- a/lib/tst_test.c
> >> +++ b/lib/tst_test.c
> >> @@ -1495,6 +1495,9 @@ static int fork_testrun(void)
> >>              return TFAIL;
> >>      }
> >>
> >> +    if (tst_test->forks_child)
> >> +            kill(-test_pid, SIGKILL);
> >> +
> >
> > Maybe we can even print a message here if the kill() returns with 0,
> > which would mean that there were any leftover child processes killed.
>
> Feel free to add a message during merge.
>

I added that and applied. Thanks~


-- 
Regards,
Li Wang

--000000000000a38a3d05d7c96f77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Feb 11, 2022 at 9:30 PM Martin Doucha &lt;<=
a href=3D"mailto:mdoucha@suse.cz">mdoucha@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On 11. 02. 22 13:55, Cyril=
 Hrubis wrote:<br>
&gt; Hi!<br>
&gt;&gt; --- a/lib/tst_test.c<br>
&gt;&gt; +++ b/lib/tst_test.c<br>
&gt;&gt; @@ -1495,6 +1495,9 @@ static int fork_testrun(void)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TFAIL;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;=C2=A0 <br>
&gt;&gt; +=C2=A0 =C2=A0 if (tst_test-&gt;forks_child)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kill(-test_pid, SIGKILL=
);<br>
&gt;&gt; +<br>
&gt; <br>
&gt; Maybe we can even print a message here if the kill() returns with 0,<b=
r>
&gt; which would mean that there were any leftover child processes killed.<=
br>
<br>
Feel free to add a message during merge.<br></blockquote><div><br></div><di=
v><div class=3D"gmail_default" style=3D"font-size:small">I added that and a=
pplied. Thanks~</div><br></div><div>=C2=A0</div></div>-- <br><div dir=3D"lt=
r" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>L=
i Wang<br></div></div></div></div>

--000000000000a38a3d05d7c96f77--


--===============1897205693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1897205693==--

