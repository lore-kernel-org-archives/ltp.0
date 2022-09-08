Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433F2C54EE9
	for <ltp@archiver.kernel.org>; Thu,  8 Sep 2022 15:15:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 743EA3CA9BF
	for <ltp@archiver.kernel.org>; Thu,  8 Sep 2022 17:15:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E21853C2482
 for <ltp@lists.linux.it>; Thu,  8 Sep 2022 17:15:20 +0200 (CEST)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 41620200DDE
 for <ltp@lists.linux.it>; Thu,  8 Sep 2022 17:15:20 +0200 (CEST)
Received: by mail-vs1-xe2d.google.com with SMTP id 190so18627128vsz.7
 for <ltp@lists.linux.it>; Thu, 08 Sep 2022 08:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=SkwWoCi8UgXEfsHYgRfje0YtiC3ETcnbcA7Yo+vU2j4=;
 b=KNphIDBZ5xJvk1q8RnDchvQVNO3B+XthVq0Jjo2PtYCQVkcSChmg0WlvG4FpmEGRBc
 rJXDC8AecpkuFSFcK6Rk/OE1mOj8ovraU7DGYfzZmVHK4N0SytoF3ExUYis7yIMW4esW
 YlhY1bM/xX8W1FEWF+ZVOaoPPhU9M2WSs7f8MBC6LK6dfZgoxitRS0r0u0QraMswRDMs
 KqLbpfhwWBldaXLBBz0+3lkBpMuATyU0nd/q+1kr+mFGnGMoweb6a1ckjZM1gFvrdzbW
 auxZyNvZfmWmdngakcM2qVUqJfSMPInQsmxMRXsQzi8qOYbIwjq8Vjmxz+nUBdO6f2JM
 G6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=SkwWoCi8UgXEfsHYgRfje0YtiC3ETcnbcA7Yo+vU2j4=;
 b=BUSF1+uv0Bo4zuI7zcUBU1FEDAk12pcu2Ppk+kmdKmh9g3yj73j/D2CRsAiCxFMiot
 FKOrp/cnSN7pOqW36eW20ddMAta8p5UASjKNpSUYEAjOgWkaLscEj/enyDzdoP5GhIjb
 V6s6xlWd/l6XRYIArv6Yav4aihlGDfPKCPpipGh7nW/CDojNoGuGPHrzP/7mGjJd/q6P
 ZLzLeb+7E1+vQjZUtrU6lwYQn3ogdVNxoFZmv0Q6qGWFB8D0nFtc+TF3HfYkd4G3gpN7
 qOUZlAayPbmDbNjPRdJ5a1SgVC73wz7qRzo3z22alM2YpjfT96QK8ELQsmIrbLn32qAe
 u7YA==
X-Gm-Message-State: ACgBeo0GmGOU2fbRtnuM5EuOUXjFFK+0m2G8dQH+KwzvmlG7y7WNuJ0G
 AiYi3GPmEr7lRoRcDLMu6Wn/UFXhhyRDULTzQ+8=
X-Google-Smtp-Source: AA6agR4ro+u5Ak3l7nUgg5y7PmaEMZXOOZN/HpK2p6D8BwfIZUWwZTT/JVVS5nRJv8J7IULiif+EIkbYzHvjpAWjtxQ=
X-Received: by 2002:a67:a649:0:b0:390:88c5:6a91 with SMTP id
 r9-20020a67a649000000b0039088c56a91mr3433307vsh.3.1662650119046; Thu, 08 Sep
 2022 08:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220908145011.21212-1-mdoucha@suse.cz>
In-Reply-To: <20220908145011.21212-1-mdoucha@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 Sep 2022 18:15:07 +0300
Message-ID: <CAOQ4uxggycpCzXLGRwq07uXRop3-fVZzw9UzJ48Z8WiPzXyXfQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] inotify11: Fix race condition between fork() and
 inotify init
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

On Thu, Sep 8, 2022 at 5:50 PM Martin Doucha <mdoucha@suse.cz> wrote:
>
> When the child process runs a few churn cycles before the parent completes
> inotify initialization, the parent will get stuck reading the inotify
> file descriptor until it eventually times out. Create inotify watch
> befory fork()ing to prevent this race condition.
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>

LGTM

Reviewed-by: Amir Goldstein <amir73il@gmail.com>


> ---
>  testcases/kernel/syscalls/inotify/inotify11.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/inotify/inotify11.c b/testcases/kernel/syscalls/inotify/inotify11.c
> index e426f9e1c..dd32ea7fd 100644
> --- a/testcases/kernel/syscalls/inotify/inotify11.c
> +++ b/testcases/kernel/syscalls/inotify/inotify11.c
> @@ -61,15 +61,16 @@ static void verify_inotify(void)
>         struct inotify_event *event;
>         int inotify_fd;
>
> +       inotify_fd = SAFE_MYINOTIFY_INIT();
> +       SAFE_MYINOTIFY_ADD_WATCH(inotify_fd, ".", IN_DELETE);
> +
>         pid = SAFE_FORK();
>         if (pid == 0) {
> +               SAFE_CLOSE(inotify_fd);
>                 churn();
>                 return;
>         }
>
> -       inotify_fd = SAFE_MYINOTIFY_INIT();
> -       SAFE_MYINOTIFY_ADD_WATCH(inotify_fd, ".", IN_DELETE);
> -
>         while (!opened && nevents < CHURN_FILES) {
>                 int i, fd, len;
>
> --
> 2.37.2
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
