Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95525C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 01:23:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D970A3CC969
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 02:23:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16EDA3C67D6
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 02:23:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A1BFF1A00CBA
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 02:23:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669339416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LGfLKYd+0a2g8NTId5Arm1noQe/eQc56QTdpkH3dDpk=;
 b=EeHbp/nPZT+gbQUXZ/BrzxutVS2Q31KdBpb7KEAQc0s6JfexxL0hZxpxcfzwOp6qTZWc1i
 XME8SEENh5+t1xi9buqnOEX3Pj5fbKa/G7Hu8J6lBCQZDZPX1+9sxAB+WpGMFuntaUrqju
 np/tPnjaKMxctGElcmjpLRoNc1UM4bQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-122-u_x-QMUVNy-OzX1i2rYmzA-1; Thu, 24 Nov 2022 20:23:24 -0500
X-MC-Unique: u_x-QMUVNy-OzX1i2rYmzA-1
Received: by mail-wm1-f70.google.com with SMTP id
 p14-20020a05600c204e00b003cf4cce4da5so1170875wmg.0
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 17:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LGfLKYd+0a2g8NTId5Arm1noQe/eQc56QTdpkH3dDpk=;
 b=W2qVDjT/3rlDQqQLPuj8EOy3hNpsMVxMJu1YvHigiyZUs5bsSCtRQI80kd612zYwqZ
 emZFiVXevU6KeU7hsWv/7Zu8vW7UYYe0+0G/egZ4OQzLuvO/GjBj/1L3jMM5IxMJx0QC
 SbNANy7eH55FNxXYuxEI31Hv37zQsxWoSKJHzSJQ0fhw3gEgG5jUVDenBNZEga0PQk1D
 Z6amZBR9OqybaP/RQG8E5irS9lRle2YGafgqbJG/no+tB7V85LRgrdQYXQ5hFqAg4ehP
 ABhjzOiGbPZYfpuUjWc6tCFVzMcyvwEDVKPH/T1Rp8x1/YTEoCT76ALfb3gs5zCBn2BH
 l7pw==
X-Gm-Message-State: ANoB5pmWo7/sZDf1MgFbZjf1XbdyuIa9OY+zSFTIP56ufnlxCVZh6aiZ
 6XdbRBRUjNhT2i/aNXz5KbSvabEeudLv+C9AVDrX7le7cEeo+s5hl4Edd85st3EWBIytP9azTuf
 B0p4lVcyjRoNBxZ2XbZmz7sujPYo=
X-Received: by 2002:adf:fa12:0:b0:242:1c:7507 with SMTP id
 m18-20020adffa12000000b00242001c7507mr2676596wrr.42.1669339403857; 
 Thu, 24 Nov 2022 17:23:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf48zzuOZypCoPFt+58SeRAZOj4za9/c0fWhC5R2CPAA4ILhGLOvGoATsP3XnpXLH0DKDkSuJtsPaz5rwu65Rg0=
X-Received: by 2002:adf:fa12:0:b0:242:1c:7507 with SMTP id
 m18-20020adffa12000000b00242001c7507mr2676589wrr.42.1669339403667; 
 Thu, 24 Nov 2022 17:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20221124122429.14238-1-mdoucha@suse.cz>
In-Reply-To: <20221124122429.14238-1-mdoucha@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 25 Nov 2022 09:23:12 +0800
Message-ID: <CAEemH2fHEF80BUKodBGAVvLgDwMn3YsQjho2RT2O8xwJb03r5Q@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] save_restore: Introduce new struct field for
 flags
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
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1336563016=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1336563016==
Content-Type: multipart/alternative; boundary="0000000000002a66b805ee415e55"

--0000000000002a66b805ee415e55
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 24, 2022 at 8:24 PM Martin Doucha <mdoucha@suse.cz> wrote:

> Tests using the .save_restore functionality currently cannot run
> without root privileges at all because the test will write
> into the path at least at the end and trigger error, even when
> the config paths are flagged as optional.
>
> Introduce new tst_path_val field for flags and replace path prefix flags
> with bit flags. Also introduce new flags to control handling of read/write
> errors and read-only sysfiles and rewrite save_restore implementation
> accordingly.
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> Reviewed-by: Li Wang <liwang@redhat.com>
> Acked-by: Jan Stancek <jstancek@redhat.com>
> ---
>
> Changes since v1:
> - TST_SR_IF_ACCESS => TST_SR_COND_ACCESS
> - TST_SR_IGNORE_RO => TST_SR_SKIP_RO
> - TST_SR_IGNORE_MISSING => TST_SR_SKIP_MISSING (to match the IGNORE_RO
> change)
>
> Changes since v2:
> - Fixed save_restore example in C Test API docs
>
> Changes since v3:
> - Renamed flags to match tst_brk() constants
> - Added TERRNO to tst_res(TINFO) messages in tst_sys_conf.c
> - Added save_restore flags to newly added hugemmap08
>
> Changes since v4:
> - Print caller line number in print_error()
>
> Changes since v5:
> - Fixed tst_sys_conf_save() call in tst_hugepage.c
> - Fixed .save_restore in newlib tests
>

Thanks for your revision, applied.

-- 
Regards,
Li Wang

--0000000000002a66b805ee415e55
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Nov 24, 2022 at 8:24 PM Martin Doucha &lt;<=
a href=3D"mailto:mdoucha@suse.cz">mdoucha@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Tests using the .save_rest=
ore functionality currently cannot run<br>
without root privileges at all because the test will write<br>
into the path at least at the end and trigger error, even when<br>
the config paths are flagged as optional.<br>
<br>
Introduce new tst_path_val field for flags and replace path prefix flags<br=
>
with bit flags. Also introduce new flags to control handling of read/write<=
br>
errors and read-only sysfiles and rewrite save_restore implementation<br>
accordingly.<br>
<br>
Signed-off-by: Martin Doucha &lt;<a href=3D"mailto:mdoucha@suse.cz" target=
=3D"_blank">mdoucha@suse.cz</a>&gt;<br>
Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_bl=
ank">liwang@redhat.com</a>&gt;<br>
Acked-by: Jan Stancek &lt;<a href=3D"mailto:jstancek@redhat.com" target=3D"=
_blank">jstancek@redhat.com</a>&gt;<br>
---<br>
<br>
Changes since v1:<br>
- TST_SR_IF_ACCESS =3D&gt; TST_SR_COND_ACCESS<br>
- TST_SR_IGNORE_RO =3D&gt; TST_SR_SKIP_RO<br>
- TST_SR_IGNORE_MISSING =3D&gt; TST_SR_SKIP_MISSING (to match the IGNORE_RO=
 change)<br>
<br>
Changes since v2:<br>
- Fixed save_restore example in C Test API docs<br>
<br>
Changes since v3:<br>
- Renamed flags to match tst_brk() constants<br>
- Added TERRNO to tst_res(TINFO) messages in tst_sys_conf.c<br>
- Added save_restore flags to newly added hugemmap08<br>
<br>
Changes since v4:<br>
- Print caller line number in print_error()<br>
<br>
Changes since v5:<br>
- Fixed tst_sys_conf_save() call in tst_hugepage.c<br>
- Fixed .save_restore in newlib tests<br></blockquote><div><br></div><div c=
lass=3D"gmail_default" style=3D"font-size:small">Thanks for your revision, =
applied.</div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></d=
iv></div></div>

--0000000000002a66b805ee415e55--


--===============1336563016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1336563016==--

