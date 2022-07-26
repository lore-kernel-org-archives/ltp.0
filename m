Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A45C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 06:11:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 382103C97B2
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 08:11:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FE1B3C1CEB
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 08:11:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B3EED600839
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 08:11:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658815868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=flyPb5/rB0+iEim5l74VJdjPc9aHzpK2y4Z2SsSwTkc=;
 b=L2WS9WPEc0JYMGe6KhdmL6Ptne7mBUCtbF3GQ8ImI63qV3cf6fKTLt70hcFyvDCKqnLeJO
 qiA6k+YwHDQq7sdyAeIsB0lQYVnmSSPywUXpRCw2mNY9RCJthsTJPmTaH5xntecAzasYP5
 XxdbRYEu1uy65kbyGWriH0aEK4yXTew=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-b5Z3wGOkNGe1lNc4TWtiQQ-1; Tue, 26 Jul 2022 02:11:07 -0400
X-MC-Unique: b5Z3wGOkNGe1lNc4TWtiQQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-31f3959ba41so19624177b3.2
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 23:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=flyPb5/rB0+iEim5l74VJdjPc9aHzpK2y4Z2SsSwTkc=;
 b=bgllBIE7psyBh6L/g3xQBcGUS3cvJqCNYQ+PaCnRcs6n8vLIm9AJ904JNWSR3+FEp2
 fYpqFZcomjxOgmdFWLwmHcJyTklPBXXXGIh5KGnHWjCFXR4bdooFVv6tT9SQp8yWE4XL
 GuTaRBZfhrbSx0u2EBYb4RM2lHIjMdbwducDRM1Hwd65kuT7dYXpmlpfFwbrcX9xx/1z
 D5MoCIv5lc+gsrkmiSQq6Xnc9BtdelEuOTDupD7HCnEKCzM2Bsux1zMcePSvCvPkUdn3
 PSCI0nwtVnoMLc7xmi0RT5XZdz57abR9xHsim6WRmGT1Hm7UI+ixTTFljyDaRgk+THqX
 rOuA==
X-Gm-Message-State: AJIora+/M0aBnMobrTBrpMzdkz7l97Ld6v1Um4ODPVQCJoTy2tGiBmbL
 tG5h6g5/qQTLXtFi/8IvFbFcG/Qkf0nPV9gnX8v48UTOn+XNStYcyJCOBV4fYS5QG2yM+DI8bIq
 NXHXIm+9j6dnx2gpI22sv63EIy6k=
X-Received: by 2002:a25:34d2:0:b0:66f:fc01:5d7 with SMTP id
 b201-20020a2534d2000000b0066ffc0105d7mr11952589yba.412.1658815866521; 
 Mon, 25 Jul 2022 23:11:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1toJTF7elseh8f0u+yn6VqB5rC4LKWRUdvSbWj+GxVkOzEDg9K/6ap05dIpsCelZJsnzJjc1vQOAW41Cx6szLw=
X-Received: by 2002:a25:34d2:0:b0:66f:fc01:5d7 with SMTP id
 b201-20020a2534d2000000b0066ffc0105d7mr11952576yba.412.1658815866319; Mon, 25
 Jul 2022 23:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Jul 2022 14:10:55 +0800
Message-ID: <CAEemH2cW-yEk598waeFkDT4tkN0hoXqDwKL3LKCuzBqWfNqvUg@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 00/18] Expand Cgroup lib and modify controller
 tests
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
Content-Type: multipart/mixed; boundary="===============0355472371=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0355472371==
Content-Type: multipart/alternative; boundary="00000000000075cb8e05e4af2a4d"

--00000000000075cb8e05e4af2a4d
Content-Type: text/plain; charset="UTF-8"

Hi All,

I have completed my review (and test) on this patch set, generally looks
good!

With regard to the tiny issues, I think Luke you can just against the
concrete
problem to follow up and fix it. No need to resend all patches with a new
version.

I would suggest merging this patchset at present (in case of blocking
other's (or duplicate) work).

CI builds pass: https://github.com/wangli5665/ltp/runs/7460955660

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--00000000000075cb8e05e4af2a4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi All,</div><div class=3D"gmail_default" style=3D"font-size:=
small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">I h=
ave completed my review (and test) on this patch set, generally looks good!=
</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div=
 class=3D"gmail_default" style=3D"font-size:small">With regard to the tiny =
issues, I think Luke you can=C2=A0just against the concrete</div><div class=
=3D"gmail_default" style=3D"font-size:small">problem to follow up and fix i=
t. No need to resend all patches with a new version.</div></div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">I would suggest merging this patchset at=
 present (in case of blocking other&#39;s (or duplicate) work).</div><div c=
lass=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gm=
ail_default" style=3D"font-size:small">CI builds pass:=C2=A0<a href=3D"http=
s://github.com/wangli5665/ltp/runs/7460955660" target=3D"_blank">https://gi=
thub.com/wangli5665/ltp/runs/7460955660</a></div><div class=3D"gmail_defaul=
t" style=3D"font-size:small"><br></div><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr"><div class=3D"gmail_default" style=3D"font-si=
ze:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" tar=
get=3D"_blank">liwang@redhat.com</a>&gt;</div><br></div></div><div><br></di=
v>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li W=
ang<br></div></div></div></div>

--00000000000075cb8e05e4af2a4d--


--===============0355472371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0355472371==--

