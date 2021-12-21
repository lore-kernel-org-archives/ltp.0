Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39478C433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 09:41:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC2F93C921A
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 10:41:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A60283C8E4D
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 10:40:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 018AF600699
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 10:40:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640079649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m/DS1+EThga3JI9EgUfjpbzxOlEQqo529gmZzmBHihs=;
 b=RdUFCwSX+4y1ZydtQnC02i753ARUPjAYVzsR8ywUG51MrEeu4sFEaWVq+cFnLbnyaE0lHv
 22RSuu5T1DQXz/AszW6a6I7tDIlFmgLvSI4bU8eH6nQj27rNzoiTl46w1kNCY0sg8ibdvf
 INy2rYIyTRf9XOuYost3vJjtYURJ0dA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-YiMikH0cPou0lhsyRkEMvA-1; Tue, 21 Dec 2021 04:40:47 -0500
X-MC-Unique: YiMikH0cPou0lhsyRkEMvA-1
Received: by mail-yb1-f198.google.com with SMTP id
 r18-20020a25ac52000000b005c9047c420bso24776965ybd.4
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 01:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m/DS1+EThga3JI9EgUfjpbzxOlEQqo529gmZzmBHihs=;
 b=QFNGCPBb/hMjPGpL94UwAVXH8FztWGB1dG5TgHbyIoumIXCqiVqGom9ATJf0mbYHV9
 OQX5ybmyelHT2WOYShmiv41xtr//KKlY9Nu0VU6u8f9I0wjUgDlOiVYWJADKovngYnp/
 zEckAFXtH3B2tRtnDUfvwm3I4FO0xdd/0UmYuL3bncMQrCgVcWb6UOcC2RfBy4nJMqQM
 h9PFgVzheqgUlAIIdrC0uTozcSbLp5pGShd6pGnpkSdlL67bRrYSB+6pIJPCBwHDEMI5
 lUyek8GSy5fWLqcmD5m0JcWhqb/8sz8scm4++V8tkgkJMf4ed+i9z9vubm8absGYkLHX
 ijAQ==
X-Gm-Message-State: AOAM533YAsdJZJvWU1rMmysBKrXsAeuRD4jphXnXI0yRK/2qHDXoMfU7
 8GojmOXuBT4itUOB1a+uq8OdVDjP+iulG30u4PMOlRJ41KNWe0IIefpc1msdjsKHmXDXz63DlH5
 SzlaTP1PrMrJW/2zE5+1Yx/V0WTE=
X-Received: by 2002:a05:6902:4f4:: with SMTP id
 w20mr3371427ybs.421.1640079647237; 
 Tue, 21 Dec 2021 01:40:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/3c9V4v6amktEabkGwJaQWysj6xnI9hQAlvIGlRKvJTW4byrhaBn4BD7CJR1fvxw/Y96+6ptqljjo3rLWjxE=
X-Received: by 2002:a05:6902:4f4:: with SMTP id
 w20mr3371405ybs.421.1640079646994; 
 Tue, 21 Dec 2021 01:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20211220095416.583323-1-liwang@redhat.com>
 <YcDMnDRgsac/q8D9@pevik>
 <CAEemH2d6PPi94q3PhMyR1Js_Rqr1dpfvch=ex3HpuHfQKJYTnw@mail.gmail.com>
 <YcGb5abUqe8PNKoM@yuki>
 <CAEemH2dDEM30-fM89LDZq1E7YN8rf44doGgnkPXuce0ttP67OA@mail.gmail.com>
In-Reply-To: <CAEemH2dDEM30-fM89LDZq1E7YN8rf44doGgnkPXuce0ttP67OA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Dec 2021 17:40:35 +0800
Message-ID: <CAEemH2d=WcWcyzZ5ZPvYf9V0aRjSVTEZzxFkJyY5wvfz_=WXGw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib: add functions to adjust oom score
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Dec 21, 2021 at 5:23 PM Li Wang <liwang@redhat.com> wrote:

> Consider about situation, I'd suggest go with non-safe macros and add
> additional check in the last.
>
> e.g.
>
> --- a/lib/tst_memutils.c
> +++ b/lib/tst_memutils.c
> @@ -108,17 +108,21 @@ static void set_oom_score_adj(pid_t pid, int value)
>         else
>                 sprintf(score_path, "/proc/%d/oom_score_adj", pid);
>
> -       if (access(score_path, R_OK | W_OK) == -1) {
> -               tst_res(TINFO, "Warning: %s cannot be accessed for reading/writing,
> -                       please check if test run with root user.",
> -                       score_path);
> -               return
> -       }
> -
> -       SAFE_FILE_PRINTF(score_path, "%d", value);
> -       SAFE_FILE_SCANF(score_path, "%d", &val);
> -       if (val != value)
> +       if (access(score_path, F_OK) == -1)
> +               tst_brk(TBROK, "%s does not exist, please check if PID is valid");
> +
> +       FILE_PRINTF(score_path, "%d", value);
> +       FILE_SCANF(score_path, "%d", &val);
> +
> +       if (val != value) {
> +               if (value < 0) {
> +                       tst_res(TINFO, "Warning: %s cannot be set to negative value,
> +                               please check if test run with root user.",
> +                               score_path);
> +                       return
> +               }
>                 tst_brk(TBROK, "oom_score_adj = %d, but expect %d.", val, value);
> +       }
>  }

Sorry, the above patch is based on my private v3.1, plz ignore it.

For better read, here give the whole function:

+static void set_oom_score_adj(pid_t pid, int value)
+{
+       int val;
+       char score_path[64];
+
+       if (access("/proc/self/oom_score_adj", F_OK) == -1) {
+               tst_res(TINFO,
+                       "Warning: oom_score_adj does not exist,
skipping OOM the adjustement");
+               return;
+       }
+
+       if (pid == 0)
+               sprintf(score_path, "/proc/self/oom_score_adj");
+       else
+               sprintf(score_path, "/proc/%d/oom_score_adj", pid);
+
+       if (access(score_path, F_OK) == -1)
+               tst_brk(TBROK, "%s does not exist, please check if PID
is valid");
+
+       FILE_PRINTF(score_path, "%d", value);
+       FILE_SCANF(score_path, "%d", &val);
+
+       if (val != value) {
+               if (value < 0) {
+                       tst_res(TINFO, "Warning: %s cannot be set to
negative value,
+                               please check if test run with root user.",
+                               score_path);
+                       return
+               }
+               tst_brk(TBROK, "oom_score_adj = %d, but expect %d.",
val, value);
+       }
+}

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
