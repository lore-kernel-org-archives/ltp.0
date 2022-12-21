Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04623C4332F
	for <ltp@archiver.kernel.org>; Wed, 21 Dec 2022 05:36:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B15C3CBA20
	for <ltp@archiver.kernel.org>; Wed, 21 Dec 2022 06:36:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBC1E3CB864
 for <ltp@lists.linux.it>; Wed, 21 Dec 2022 06:36:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AAC921A004EE
 for <ltp@lists.linux.it>; Wed, 21 Dec 2022 06:36:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671601000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z+BkuNSoOkCaqHpH0C7yALiPQcpcqZKIKmNA+C86gb4=;
 b=RHukWFqE9BwgP2K8+8xyYH97VN9SCMpghEn8nHca4C3u2Ignsuphq0zS1Tb5orHiDwSvNe
 chVrdybSt50zOKOrA8JIECnUo2erZqvLZya3moafj1M5Waiu2tdqKu2/FVnASlf9e+GqwG
 YMninpRPTK0St79c/hYLa34Dzwh+dZQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-tmPmyPG4Mba9xytxw8dxhA-1; Wed, 21 Dec 2022 00:36:38 -0500
X-MC-Unique: tmPmyPG4Mba9xytxw8dxhA-1
Received: by mail-wm1-f72.google.com with SMTP id
 x10-20020a05600c420a00b003cfa33f2e7cso7498109wmh.2
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 21:36:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z+BkuNSoOkCaqHpH0C7yALiPQcpcqZKIKmNA+C86gb4=;
 b=mnRMhd2vqnJ7e0brwjFQIp/yh10l0Ib4qgHxi1NQv4yJe1JRxWVwHzvYUeDadp2f7x
 KV3Sa6sxNvZ1Z/FhxXvHCvRNe/Htnio3OTNZDuChOchBIAMLeVxLELgszTHceTH+NBTY
 0IssL4ykxG148lb9d8ZzPAsLYTLlMmPxv2MY90NLBzwxnz/5ueAG4i8QzAGre9P3K9eA
 I+wrXVKFFBAU66y7YxZLe8rRnlghzgaH2o8/Ph2O9jxw3Exp+onKCJBtqigx/Cp/VTC8
 IQUotaeeheZg9aJsSeZLw3PhhIgLn5eo9KXGKNlkrDPgmI8Bu/sEV+QeHsG/BHtcjiCK
 Ym2g==
X-Gm-Message-State: AFqh2kqSYd00n9r+1OC/4p7zqMq/SEkuGZJtbdsI6smbVBFNIsuZEenH
 ZF2ZZHIovRbysbbrarZidZQnGFTXQt3wWHMsnSU2WRc+LH+oSfD1kTg9Iy5OVbru8VpzwK3mgEe
 5OBUtY1FOqGsuoBQ/OHoYfQnyLf8=
X-Received: by 2002:a05:600c:201:b0:3d3:58d1:258f with SMTP id
 1-20020a05600c020100b003d358d1258fmr44523wmi.121.1671600997067; 
 Tue, 20 Dec 2022 21:36:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu4tzhX7Du/U431/CgWUvcKqUpxv5O0l3fBkoICFZ/CckYga/93bFLpc3GFDwHpkppFU2LKYuuFzdXYMXHkZ7o=
X-Received: by 2002:a05:600c:201:b0:3d3:58d1:258f with SMTP id
 1-20020a05600c020100b003d358d1258fmr44521wmi.121.1671600996829; Tue, 20 Dec
 2022 21:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20221220144232.27950-1-andrea.cervesato@suse.com>
In-Reply-To: <20221220144232.27950-1-andrea.cervesato@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 21 Dec 2022 13:36:25 +0800
Message-ID: <CAEemH2fsm4kOgkdhngSKjuvR2bTuv7nYWur=_t3MyLrqWgD4ww@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] Add runltp-ng to upstream
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On Tue, Dec 20, 2022 at 10:44 PM Andrea Cervesato via ltp <
ltp@lists.linux.it> wrote:

> runltp-ng is the next generation runner for Linux Testing Project and it
> will replace the current obsolete runltp script in the next future.
>

I'm catching up on emails of LTP after back from a covid sick leave,
but generally speaking, this new tool runltp-ng looks pretty good
enough to get started.

I have tried it out simply and decided to dig into details to produce
more valuable feedback.

but now yes I look forward to having it:

Reviewed-by: Li Wang <liwang@redhat.com>



>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
> Acked-by: Petr Vorel <pvorel@suse.cz>
> ---
> Use https protocol
>
>  .gitmodules     | 3 +++
>  tools/runltp-ng | 1 +
>  2 files changed, 4 insertions(+)
>  create mode 160000 tools/runltp-ng
>
> diff --git a/.gitmodules b/.gitmodules
> index a3c34af4b..d1d558b9e 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -4,3 +4,6 @@
>  [submodule "tools/sparse/sparse-src"]
>         path = tools/sparse/sparse-src
>         url = git://git.kernel.org/pub/scm/devel/sparse/sparse.git
> +[submodule "tools/runltp-ng"]
> +       path = tools/runltp-ng
> +       url = https://github.com/linux-test-project/runltp-ng.git
> diff --git a/tools/runltp-ng b/tools/runltp-ng
> new file mode 160000
> index 000000000..39792805b
> --- /dev/null
> +++ b/tools/runltp-ng
> @@ -0,0 +1 @@
> +Subproject commit 39792805b3c2c30bde665b01550994aeecff6071
> --
> 2.35.3
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
