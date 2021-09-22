Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887F0C433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 05:04:02 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EBB61038
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 05:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0EBB61038
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38B5B3CA1FE
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 07:03:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 417FF3C1C52
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 07:03:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6279A1A0060E
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 07:03:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632287027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Q2890p+9jHjvnok0/2uUZyKHYjroJpfhPPvT0LVM/M=;
 b=DXCe4C7+UwYt2fU7F+rgldfG4NQzduTR1SxTHgzF901KduqSPv7Jm985AedXVH9kJstIFa
 /Tem381JC7rXdtDHblwuNJx8MrX7HoQb2UV2C+L5VZt4ASlUNVGW5mxK/23cs+JDGQsJyx
 WxyVmC6IEuJfckVPQyzNHD2Jkw+nhPY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-yMI6nAolPKWOgPX6DL74DA-1; Wed, 22 Sep 2021 01:03:45 -0400
X-MC-Unique: yMI6nAolPKWOgPX6DL74DA-1
Received: by mail-qk1-f199.google.com with SMTP id
 bj32-20020a05620a192000b00433162e24d3so7558444qkb.8
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 22:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5Q2890p+9jHjvnok0/2uUZyKHYjroJpfhPPvT0LVM/M=;
 b=iVfa1mmGBIi+gzn2F3J0hURdlCgbURy4eBvHjZKSIQMH74IKTetIf59G92QWXHZj65
 jnEbpahuAxd1tZTKnZ3gyxRC7b/OkPzREjkrFfYYDH0b7MrPGcKYGEFsF9bS9pbx2OCZ
 NcNZBlUSw+0e1QQUSp+TYAfUWz2WaRkuiAUanwKGurDlai3zXe9c2ZHgwqEaQOJ6kCWx
 GoArMeZmHUSb3vP6Z/AjQnCBZ4pr5L2z3tLz7xO59F10w8qQXYVntKQVBwPjsH8VKXvv
 X+sF9NytZ4GhHZbL/5GX2DK3MQhJtrbzbhwxMkxWuI6xgOT1Vv/4atLeLPpDTqJEr7Ml
 5T5g==
X-Gm-Message-State: AOAM533EVD9m/ufRMWDV6vvRrxLm9DjBNU0dgBNG03be0vumUPB0Ze97
 Gv5nusJ7jD4psuFPwt+uj6J67P2QInsn5BkQHJ2CjfJFHu0JbSoJZC7YlM2tX837jNoZCcae6gx
 /fhie7J8TZhQGo9lUNnvoxy2hgjw=
X-Received: by 2002:a25:2f48:: with SMTP id v69mr41041409ybv.339.1632287024859; 
 Tue, 21 Sep 2021 22:03:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywv0YQU1JDLN2h9S1um+pYkeQF6jwrXRZ/uFZkwa1txuCQV7ELOGvP8IzWEH8JsEMXqKcfhHcgd4dWGeHAzHY=
X-Received: by 2002:a25:2f48:: with SMTP id v69mr41041377ybv.339.1632287024499; 
 Tue, 21 Sep 2021 22:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210817104625.2559362-1-liwang@redhat.com>
 <20210921203349.GA2014441@maple.netwinder.org>
In-Reply-To: <20210921203349.GA2014441@maple.netwinder.org>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Sep 2021 13:03:32 +0800
Message-ID: <CAEemH2dMCmYDkZYxfaeJ_oQCCcHzeMgSOGVQ_wS6BwCrp0YiQw@mail.gmail.com>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Content-Type: multipart/mixed; boundary="===============1451723575=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1451723575==
Content-Type: multipart/alternative; boundary="0000000000004463a505cc8e7047"

--0000000000004463a505cc8e7047
Content-Type: text/plain; charset="UTF-8"

Hi Ralph,

On Wed, Sep 22, 2021 at 4:34 AM Ralph Siemsen <ralph.siemsen@linaro.org>
wrote:

> Hello,
>
> On Tue, Aug 17, 2021 at 06:46:25PM +0800, Li Wang wrote:
> >
> >diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c
> b/testcases/kernel/syscalls/fallocate/fallocate05.c
> >index 55ec1aee4..74bfa4861 100644
> >--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
> >+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
> >@@ -26,8 +26,8 @@
> > #include "lapi/fallocate.h"
> >
> > #define MNTPOINT "mntpoint"
> >-#define FALLOCATE_BLOCKS 16
> >-#define DEALLOCATE_BLOCKS 4
> >+#define FALLOCATE_BLOCKS 256
> >+#define DEALLOCATE_BLOCKS 64
> > #define TESTED_FLAGS "fallocate(FALLOC_FL_PUNCH_HOLE |
> FALLOC_FL_KEEP_SIZE)"
> >
> > static char *buf;
>
> This change appears seems to be causing fallocate05 test to reliably
> trigger OOM (out of memory) on my test machine, which has only 256MB
> RAM.
>

Thanks for reporting the failure. We purposely increase the size of
fallocate
to reduce interference from metadata changing. But not clear how much
size should be a proper value for a small system.

Can you try with decrease the number of FALLOCATE_BLOCKS?

i.e.

#define FALLOCATE_BLOCKS 64
#define DEALLOCATE_BLOCKS 16

Or, what about other multiple sizes, test result?


-- 
Regards,
Li Wang

--0000000000004463a505cc8e7047
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Ralph,</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Sep 22, 2021 at 4:34 AM Ralph Siemsen=
 &lt;<a href=3D"mailto:ralph.siemsen@linaro.org">ralph.siemsen@linaro.org</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">He=
llo,<br>
<br>
On Tue, Aug 17, 2021 at 06:46:25PM +0800, Li Wang wrote:<br>
&gt;<br>
&gt;diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testca=
ses/kernel/syscalls/fallocate/fallocate05.c<br>
&gt;index 55ec1aee4..74bfa4861 100644<br>
&gt;--- a/testcases/kernel/syscalls/fallocate/fallocate05.c<br>
&gt;+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c<br>
&gt;@@ -26,8 +26,8 @@<br>
&gt; #include &quot;lapi/fallocate.h&quot;<br>
&gt;<br>
&gt; #define MNTPOINT &quot;mntpoint&quot;<br>
&gt;-#define FALLOCATE_BLOCKS 16<br>
&gt;-#define DEALLOCATE_BLOCKS 4<br>
<span class=3D"gmail_default" style=3D"font-size:small"></span>&gt;+#define=
 <span class=3D"gmail_default" style=3D"font-size:small"></span>FALLOCATE_B=
LOCKS 256<br>
&gt;+#define DEALLOCATE_BLOCKS 64<br>
&gt; #define TESTED_FLAGS &quot;fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_=
KEEP_SIZE)&quot;<br>
&gt;<br>
&gt; static char *buf;<br>
<br>
This change appears seems to be causing fallocate05 test to reliably <br>
trigger OOM (out of memory) on my test machine, which has only 256MB <br>
RAM.<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=
=3D"font-size:small">Thanks for reporting the=C2=A0failure. We purposely in=
crease the size of fallocate</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">to reduce interference from metadata changing. But not clear =
how much</div><div class=3D"gmail_default" style=3D"font-size:small">size s=
hould be a proper value for a small system.</div><div class=3D"gmail_defaul=
t" style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=
=3D"font-size:small">Can you try with decrease the number of <span class=3D=
"gmail_default"></span>FALLOCATE_BLOCKS?=C2=A0</div><div class=3D"gmail_def=
ault" style=3D"font-size:small"><br></div><div class=3D"gmail_default" styl=
e=3D"font-size:small">i.e.</div><br></div><div><div class=3D"gmail_default"=
 style=3D"font-size:small">#define=C2=A0<span class=3D"gmail_default"></spa=
n>FALLOCATE_BLOCKS 64</div><div class=3D"gmail_default" style=3D"font-size:=
small">#define DEALLOCATE_BLOCKS 16</div><br></div><div><div class=3D"gmail=
_default" style=3D"font-size:small">Or, what about other multiple=C2=A0size=
s, test result?</div></div><div class=3D"gmail_default" style=3D"font-size:=
small"><br></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmai=
l_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div>=
</div></div></div>

--0000000000004463a505cc8e7047--


--===============1451723575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1451723575==--

