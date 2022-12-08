Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6213C4708D
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 03:37:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E44463CDB72
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 04:37:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0448C3CA846
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 04:37:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 39784600490
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 04:37:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670470643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OwBp2prknF93VNIdf8j10y7ddqSsZiViGMzEDCTKgUQ=;
 b=FvYP5b5DHfIaHwxec/cCwVsuIkqb0wjSRX6oNcq+Cj5m9WdgrrhMP59MZsP3RHaD/xue08
 H5x8/R1dllZNP5JFzeYIk3kNf2deURz9GfIJeZagZYiBO4j8NBn3vE8HNolJf4yMS6Y559
 pZxEY3xBQnnY0mBSKbf2qrDezk1tTt0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-BjX-EYKLPa2yWhHTv_d7Iw-1; Wed, 07 Dec 2022 22:37:22 -0500
X-MC-Unique: BjX-EYKLPa2yWhHTv_d7Iw-1
Received: by mail-wm1-f72.google.com with SMTP id
 h81-20020a1c2154000000b003d1c8e519fbso1779126wmh.2
 for <ltp@lists.linux.it>; Wed, 07 Dec 2022 19:37:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OwBp2prknF93VNIdf8j10y7ddqSsZiViGMzEDCTKgUQ=;
 b=M94Xnmn8QeRHvQPc7uaeYQvIQ3jOKtQsobjzvP/vb5edchw+byZmHrT/XBobbVFOxb
 6DGzSxOOyIoxyAqyYLtRvVlWGj88NAugdQGtxAw+0PEx09zJ/4z2rzSuJgpyRY7EtCHQ
 Mm5jEnkFEcONLolBs3MkBUfFL0ukOpu70CKB9Si1M1eDWkzm1JS+UpcrSjpT7m15T3LE
 ZMCi2JnMdUr8qEJjkZpe6KoPW0bKp9/hfmCOTK2Ap1d0wtxCK/SDJcVnjH2kkxwcG4fr
 1Az14ninW+8OQBe8FtBQdIcHyLLZiF0jL3HfXW4E6wyruODfoCCMmMlHL7f5pZP8zj4b
 1E3g==
X-Gm-Message-State: ANoB5pmQ8PrnkaIvs1PYMhT+kekXM5ZdFXSwDe7ioaZMR2IHZWz7gbid
 vSgiNC5F4TCtZTXUYQ2/JEX9sendupyOUGwx3RtI1yAAavc7tWMfb2WjOszitt06PRSVNi7wAG6
 RFN/9GyzymVmhCYmsdau/05Mfkvs=
X-Received: by 2002:adf:e5c6:0:b0:242:5c6d:30d7 with SMTP id
 a6-20020adfe5c6000000b002425c6d30d7mr10547430wrn.316.1670470640323; 
 Wed, 07 Dec 2022 19:37:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4AFZF6wxuSghwW5xqHuAnUEDwCnETFjA6qExJMFLkVfBFFLdvhZxOf0K0fu2uar0Lc8hgYC+2uzABg0kC+1mM=
X-Received: by 2002:adf:e5c6:0:b0:242:5c6d:30d7 with SMTP id
 a6-20020adfe5c6000000b002425c6d30d7mr10547426wrn.316.1670470640154; Wed, 07
 Dec 2022 19:37:20 -0800 (PST)
MIME-Version: 1.0
References: <20221206075747.17352-1-akumar@suse.de>
In-Reply-To: <20221206075747.17352-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Dec 2022 11:37:08 +0800
Message-ID: <CAEemH2dW2u+tYQUtvresJXMYYfaqiXqtKksdK4rHaGTCG+5L0w@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setresuid04.c: Rewrite the test using new LTP API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

Avinesh Kumar <akumar@suse.de> wrote:

> -               /* Test 2: Check a son process cannot open the file
> -                *         with RDWR permissions.
> -                */
> -               pid = FORK_OR_VFORK();
> -               if (pid < 0)
> -                       tst_brkm(TBROK, NULL, "Fork failed");
> -
> -               if (pid == 0) {
> -                       int tst_fd2;
> +       SAFE_SETRESUID(0, ltpuser->pw_uid, 0);

There is no reason to modify 'real UID' and 'saved set-user-ID'
at this time, we do only care about 'effective UID' made changes
successfully or not.

So I tweaked the patch a tiny and merged it:

--- a/testcases/kernel/syscalls/setresuid/setresuid04.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid04.c
@@ -40,7 +40,7 @@ static void run(void)
        pid_t pid;
        int status;

-       SAFE_SETRESUID(0, ltpuser->pw_uid, 0);
+       SAFE_SETRESUID(-1, ltpuser->pw_uid, -1);
        TST_EXP_FAIL2(open(TEMP_FILE, O_RDWR), EACCES);

        pid = SAFE_FORK();


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
