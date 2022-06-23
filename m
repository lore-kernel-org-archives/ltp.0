Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738C0C43334
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 08:34:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48AD23C94B4
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 10:34:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1CBA3C3129
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:34:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5AE621A006E5
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:34:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655973240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tSzGxnCOsJf6Kfjq6j0125EHdEuxvnYvaWXiQu9+U5k=;
 b=FmEuM94HCkMR38s9E/us5xszY3PqY0CHjjMAZG10qN7yeyo2XpS9Vpn/jGEQWmmVa0St0/
 /YuQVee0i2YvyiU93P3Onvj0wejkHEbHbPcd7Qy5ATC7NPqfTH+7BMwC4P7yB/RT4MeqGt
 bveBWhK4Vx210vY7HbrSKYdCaTYN4e0=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-EJDUJ9unMKmkWrwzx5sq-A-1; Thu, 23 Jun 2022 04:33:59 -0400
X-MC-Unique: EJDUJ9unMKmkWrwzx5sq-A-1
Received: by mail-yb1-f197.google.com with SMTP id
 v203-20020a2561d4000000b00669b199cc0cso674579ybb.15
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 01:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tSzGxnCOsJf6Kfjq6j0125EHdEuxvnYvaWXiQu9+U5k=;
 b=CxSriUxe3Y501wWifGbw8uEe9jg/Cgtyso41qD6ERQZm0hrlQBm39Un8jGTD+5vRh5
 0NX2/rYQQ3KxTl/vuWHBEqh67LMMXi1SukItPQLHHlJiZlEACjyne6vjsZiI7Wejnibo
 4qXwLW1f3evRT6rpz0I0veOex33AXPcRvZ+N5sxQL+a8sZ2BeLDP7/S5oUsJwadnMrot
 e7b9p0Ytq1NJHPdNt8etJn2jtfsCMRhNEK1SkwxOnQckloOt7p35BW87pqUN5gAPk8Lc
 KJls+uN9nwuhfLrPW8rk8WwCYYrhQcQ2nrcJGv3a9oQV3cHQL46zR+d8XYpvVm/3dU6E
 0puw==
X-Gm-Message-State: AJIora/rABwFUJv6hpUMi58lIENHGvONrPX19mFEQnyGq/8YazridxwE
 vmiGAj/JoHxZNi6sVhrvqU8XsPh78Q82wgUzFtHa9LDGD8m7UEXr+3TVrgAOKfQwPgz8oKrlel1
 kjpNqs5QfMxFYxFWq1qHJyzOoKBc=
X-Received: by 2002:a25:b44b:0:b0:669:10c4:ccde with SMTP id
 c11-20020a25b44b000000b0066910c4ccdemr8406991ybg.412.1655973238395; 
 Thu, 23 Jun 2022 01:33:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vz8fcveYrsZsd5fVJzg+SkHjLgxkYjRTZJsSH/xzS0XSc2CQZKePKFwBdVMAZHkXiupkvsB6bZ4Hk9jMDSHag=
X-Received: by 2002:a25:b44b:0:b0:669:10c4:ccde with SMTP id
 c11-20020a25b44b000000b0066910c4ccdemr8406978ybg.412.1655973238215; Thu, 23
 Jun 2022 01:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220620063456.528113-1-liwang@redhat.com>
 <CAASaF6xjARnhNAh7cU0pTE5vBfsA7wvvLAdosOmbrAEkHWY2-Q@mail.gmail.com>
In-Reply-To: <CAASaF6xjARnhNAh7cU0pTE5vBfsA7wvvLAdosOmbrAEkHWY2-Q@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 23 Jun 2022 16:33:47 +0800
Message-ID: <CAEemH2fq453u0tPNU+0xYtzN+Sutd9XpMgtgBFgm81WPtw4fgg@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] swapping01: make use of remaining runtime in
 test looping
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
Content-Type: multipart/mixed; boundary="===============0574968958=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0574968958==
Content-Type: multipart/alternative; boundary="0000000000009f2c4005e2195025"

--0000000000009f2c4005e2195025
Content-Type: text/plain; charset="UTF-8"

Jan Stancek <jstancek@redhat.com> wrote:


> > Co-developed-by: Cyril Hrubis <chrubis@suse.cz>
> > Signed-off-by: Li Wang <liwang@redhat.com>
>
> Acked-by: Jan Stancek <jstancek@redhat.com>
>

Thanks for reviewing Jan, but seems a bit late.
I was pushing it together with your two patches a moment ago:).

https://github.com/linux-test-project/ltp/commit/3eb312e1f947782d8a48ff652429e2f81ce2fbca


-- 
Regards,
Li Wang

--0000000000009f2c4005e2195025
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Jan Stancek &lt;<a href=3D"mailto:jstancek@redhat.com">jstanc=
ek@redhat.com</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Co-developed-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" t=
arget=3D"_blank">chrubis@suse.cz</a>&gt;<br>
&gt; Signed-off-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=
=3D"_blank">liwang@redhat.com</a>&gt;<br>
<br>
Acked-by: Jan Stancek &lt;<a href=3D"mailto:jstancek@redhat.com" target=3D"=
_blank">jstancek@redhat.com</a>&gt;<br></blockquote><div><br></div><div><di=
v class=3D"gmail_default" style=3D"font-size:small">Thanks for reviewing=C2=
=A0Jan, but seems a bit late.</div></div><div class=3D"gmail_default" style=
=3D"font-size:small">I was pushing it together with your two patches a mome=
nt ago:).</div><div class=3D"gmail_default" style=3D"font-size:small"><br><=
/div></div><div class=3D"gmail_default" style=3D"font-size:small"><a href=
=3D"https://github.com/linux-test-project/ltp/commit/3eb312e1f947782d8a48ff=
652429e2f81ce2fbca">https://github.com/linux-test-project/ltp/commit/3eb312=
e1f947782d8a48ff652429e2f81ce2fbca</a></div><br clear=3D"all"><div><br></di=
v>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>R=
egards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000009f2c4005e2195025--


--===============0574968958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0574968958==--

