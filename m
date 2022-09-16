Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C575C32771
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 02:12:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F7E23CAC57
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 04:12:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E785B3CA493
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 04:12:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1291B14016E0
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 04:12:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663294345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oC6lORiB3BGU4EMv5x6Mke45tesEWkTZccDjKT4Y2ng=;
 b=VkDP+D2UmEgMF2k9DJpDT1Y+L/dS8AM8Yyy2yOPW/6WVTDdVNscmxu/hNHYhJzKih5nfqX
 euK9rPz34QLdvyNkRD9hMwCWdVR1KL7DogmDmR1JRvrMG7BDczwJxUKGUJx4Ne8qNor//Y
 ZHiTC9lrmafVt/boCwW3HgS4ySlXUYI=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-226-mO6hDZBDPtOoQUyVeJqF_A-1; Thu, 15 Sep 2022 22:12:23 -0400
X-MC-Unique: mO6hDZBDPtOoQUyVeJqF_A-1
Received: by mail-vk1-f200.google.com with SMTP id
 s5-20020a1ff405000000b0039ecef730aaso5004583vkh.13
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 19:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=oC6lORiB3BGU4EMv5x6Mke45tesEWkTZccDjKT4Y2ng=;
 b=lG+YZn29qQrErvF1VG03lkarW76l9fZZtpwYiTknhQ1PyS0LGh5WVSTCGPcVP3rWu/
 i/wrB2t7Dxc4s8LXftdwe4BNXUgI5Y1QoQ2xsSKvFcGWn9RG6wyGrJGBfI5nDIGmZT48
 4T4uJGqFQh44SU4Gjncoy8RWUN7KC4gHrq1LViIyEgyCryzBB1nGIvC3jutm3Xojqqwz
 AFwJOISwc0FdxjeHsL+TzK7HhgCcBeKLXqB7+vlkcBB/LqYfWvNHRUpKbkW7gsSG4dIP
 2qMJ4CZVrrZ+LpLO6A7nKDJLt+2dJXpMUtGGlZJT3xxIe0EHRjrF63BOK80OHh4vj49i
 th6w==
X-Gm-Message-State: ACrzQf2zRkHvS6DuKdjEIChYYeVtsh4K4SAfgQSndukDyezVMAbp3rBR
 Aw9rODnJ39eK7Os58h0iBzmN5XYNwjdKom0BjHoyAskcnorjfXeOlvxs5brdXV8Sv9xQjoJMfYi
 CugtCzYeFUIiEsOGvQWeVT0rIRC8=
X-Received: by 2002:a05:6102:2755:b0:398:4f71:86e with SMTP id
 p21-20020a056102275500b003984f71086emr1442249vsu.84.1663294343497; 
 Thu, 15 Sep 2022 19:12:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Y0VqxW1Bl09/CMhQ1V8iJO09F5a7r/Zzn/8eP34Y74Rq2yUasvzTDro5r50I3bhD5q/5HOEmUDarku3hx9wY=
X-Received: by 2002:a05:6102:2755:b0:398:4f71:86e with SMTP id
 p21-20020a056102275500b003984f71086emr1442244vsu.84.1663294343288; Thu, 15
 Sep 2022 19:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <YyI/KU10+zSi7Fpj@pevik>
 <20220915074900.2639623-1-liwang@redhat.com>
 <12066736.O9o76ZdvQC@localhost>
In-Reply-To: <12066736.O9o76ZdvQC@localhost>
From: Li Wang <liwang@redhat.com>
Date: Fri, 16 Sep 2022 10:12:12 +0800
Message-ID: <CAEemH2dbmnka=4wiib-ZiiHn+1qVNUsm4jY9f2iP5Tqan3zSOQ@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getitimer03.c: convert to new LTP API
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
Content-Type: multipart/mixed; boundary="===============0252695863=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0252695863==
Content-Type: multipart/alternative; boundary="0000000000007d2d8a05e8c1e4cd"

--0000000000007d2d8a05e8c1e4cd
Content-Type: text/plain; charset="UTF-8"

Hi Avinesh, Petr,

On Thu, Sep 15, 2022 at 6:00 PM Avinesh Kumar <akumar@suse.de> wrote:

> Hi Li,
>
> Sorry, I missed acting on the review comments you had provided. Thank you
> for
> implementing them. Your patch looks good, I have tested as well.
>

Thanks, btw we also need to take care of the .gitignore and syscalls run
test file.
Someone can help add this when merging the patch.

--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -466,7 +466,6 @@ gethostname01 gethostname01

 getitimer01 getitimer01
 getitimer02 getitimer02
-getitimer03 getitimer03

 getpagesize01 getpagesize01

diff --git a/testcases/kernel/syscalls/getitimer/.gitignore
b/testcases/kernel/syscalls/getitimer/.gitignore
index 6533d4b50..0a46a1021 100644
--- a/testcases/kernel/syscalls/getitimer/.gitignore
+++ b/testcases/kernel/syscalls/getitimer/.gitignore
@@ -1,3 +1,2 @@
 /getitimer01
 /getitimer02
-/getitimer03

-- 
Regards,
Li Wang

--0000000000007d2d8a05e8c1e4cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi=C2=A0Avinesh, Petr,</div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 15, 2022 at 6:00 PM A=
vinesh Kumar &lt;<a href=3D"mailto:akumar@suse.de">akumar@suse.de</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Li,<br>
<br>
Sorry, I missed acting on the review comments you had provided. Thank you f=
or<br>
implementing them. Your patch looks good, I have tested as well.<br></block=
quote><div><br></div><div class=3D"gmail_default" style=3D"font-size:small"=
>Thanks, btw we also need to take care of the .gitignore and syscalls run t=
est file.</div><div class=3D"gmail_default" style=3D"font-size:small">Someo=
ne can help add this when merging the=C2=A0patch.</div><div class=3D"gmail_=
default" style=3D"font-size:small"><br></div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">--- a/runtest/syscalls<br>+++ b/runtest/syscalls<b=
r>@@ -466,7 +466,6 @@ gethostname01 gethostname01<br>=C2=A0<br>=C2=A0getiti=
mer01 getitimer01<br>=C2=A0getitimer02 getitimer02<br>-getitimer03 getitime=
r03<br>=C2=A0<br>=C2=A0getpagesize01 getpagesize01<br>=C2=A0<br>diff --git =
a/testcases/kernel/syscalls/getitimer/.gitignore b/testcases/kernel/syscall=
s/getitimer/.gitignore<br>index 6533d4b50..0a46a1021 100644<br>--- a/testca=
ses/kernel/syscalls/getitimer/.gitignore<br>+++ b/testcases/kernel/syscalls=
/getitimer/.gitignore<br>@@ -1,3 +1,2 @@<br>=C2=A0/getitimer01<br>=C2=A0/ge=
titimer02<br>-/getitimer03<br></div></div><div><br></div>-- <br><div dir=3D=
"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><di=
v>Li Wang<br></div></div></div></div>

--0000000000007d2d8a05e8c1e4cd--


--===============0252695863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0252695863==--

