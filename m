Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF0ACA0EED
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 08:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755849799; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=z67Idf8lhDBF0m1OWtmK0wmU+pMALrwYdqwbvEGh64k=;
 b=qdqTa5212eOaXRXOfOnmwFqv73CwlGNMFMyHrPHzv9OwNbyCNQx7i10d371AM+rxsrfNK
 M2WdMtY48UVIFvb9K4Q33OIgfXmG/mRjUZibrRJxzUYc1UraJTH8KY3NpVKLE1Fr4lnA2Df
 ijmAMuZYiS4QZmvJv0gVWFTUMBkhAv8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A5683CCE5E
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 10:03:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7665A3CCD8B
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 10:02:57 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 24F4B600463
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 10:02:56 +0200 (CEST)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-618aea78f23so2795583a12.3
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755849775; x=1756454575; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JCo8C7enY/LWqHJ1HNK7nRzJUm0xkSCVWmJBRWzSQsk=;
 b=gFqjk715Fn2OE+zJQrBpY/oq4km6WgEtYHv3LBfcGJE9jxITORqUT2AZKSdHC/S2s7
 vzUeOuHxKP4doPCJIfOxuYR3xJFvz+TpygowdV77ujJ3rykJt5kpJaADLIo82dXc3YkW
 iFBi7ZvPrEhZYaDZpShz/g1PDwlW+BNZHKUa4lPdXx5KwLw9XuRaU9MXUZ+SG8Y44Enk
 uwixnHEzAKPryRvseidEyJam7hhljreBETnwx6uT1W+PLSkznoQPKpdxzeCbs9deP7wj
 vBBpsu/MwCkuEJjEvaIfgkojT/QE+wZLg/2XBlW4H8NQWDhIPRT14DdgKSH4ydKRMgxf
 KAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755849775; x=1756454575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JCo8C7enY/LWqHJ1HNK7nRzJUm0xkSCVWmJBRWzSQsk=;
 b=Z8zOdE3JIxjbrINLU7ihhqQljTKxA81JO0BuJhtYchRdwOpV5cWdAlqBgRjIGwrZKB
 IPW4uKBzDLdDcSJaQBEvC650PatYujVEAgCzhlw7SKMkFWBGpdVxDFClHwNw86avyrmx
 C0TUFTwyFH6yee1ZQKU4Ey7iMjOKooKtSMBC1BrKvK4WYiRF9lihE5i+8jNafuWNAIGK
 NqA4a8qkCVbi+TLqN0Zz66+0UrNYR865M7ly06hgdT6O6+dTHlbNVQ+1yhpi8kdgSMYe
 vGy6SfepQS+udfBLOlXu1IFUsvTYChS/mUIbDU7Ve/XRlG9kg8TNyfUZ596W5CtRpG7s
 Z4bw==
X-Gm-Message-State: AOJu0YzTIE6NkjCQgRimIkk1VetYnZbaRHMtKnhjotgDo1DZaKdaLMRA
 yPGK+DXCJEmsBHxAMRHXmp9b3RGdCHWgTN2RDA0Ms7V/xdDlz53uZ1/yzuME1LOMYt6/c+oxapi
 dMRM=
X-Gm-Gg: ASbGncupqUDDxYPtQyV1t9h5eK4vBxXZS+Qc5JhWhBEu+i7s2/yCLoQxC0+QhugOH9O
 a0vM+KCnUfhMfVeH+L6l5BiBTNLxxWeoS4iMd+zI5Akshw0CeomBYCABQ/X+/DjVlF7LB0ifs5q
 DIb/X2xj+Zc6YD1o9Vd/b5AUzmUgdg0ozHyct1qqoFXd5Yh9n3tThCDWLRihqb5XD2m4e1YODSv
 Mb4/At2lpPWsj2bdDOApcqrsL/L76whouhDjMSHWAkpLTTgEJDJf7J9UQwDqdoAuXBLfQWKyivf
 2R6CtUJnFatwKFlXBzdM1YJBnaO3WX7xYFCw2hPlHmuZXY4c5uN6WsZjnNVHCyPFgzy6T3xD5Bi
 FoVAW9851nGBpfnxP167VHiGyjh1kwfN7u7hGTsappY4=
X-Google-Smtp-Source: AGHT+IGWt/jyUubIftacNTvqkIPPcQlEqAByXqERBGfIzzGAPiFSOdIIEmzMtwz/Ch9BTEHleHl70w==
X-Received: by 2002:a05:6402:4314:b0:61b:fc6a:7b7c with SMTP id
 4fb4d7f45d1cf-61c1b43d0demr1463512a12.4.1755849775310; 
 Fri, 22 Aug 2025 01:02:55 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61c25b5d77fsm167536a12.49.2025.08.22.01.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 01:02:55 -0700 (PDT)
Date: Fri, 22 Aug 2025 08:02:53 +0000
To: Li Wang <liwang@redhat.com>
Message-ID: <aKgkLd9SIJc3YcHZ@localhost>
References: <CAEemH2fM4vHRdgHh62krquK5CFuHvpKdJtj--S6Vvt_i0xRBFw@mail.gmail.com>
 <20250822074811.2192404-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250822074811.2192404-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] mount: check path exists before
 tst_is_mounted in cleanup
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Aug 22, 2025 at 03:48:11PM +0800, Li Wang via ltp wrote:
> tst_is_mounted() now internally resolves the mount path via realpath(),
> which will fail if the path does not exist. In sometest (e.g. mount05),
> MNTPOINT2 may not exist yet during cleanup, calling tst_is_mounted()
> directly could produce misleading warnings or errors.
> 
> Add an explicit access(PATH, F_OK) check before calling tst_is_mounted()
> in the cleanup, ensuring we only query mounts for existing paths.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
> 
> Notes:
>     v1 --> v2:
>             patch 1/2, keep no change, do not send v2.
>             patch 2/2, adding two more files for path exist check
> 
>  testcases/kernel/containers/mqns/mqns_03.c | 2 +-
>  testcases/kernel/containers/mqns/mqns_04.c | 2 +-
>  testcases/kernel/syscalls/mount/mount05.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
Still more test case need update such as following?
  13    111  testcases/kernel/syscalls/mount/mount02.c <<cleanup>>
             if (tst_is_mounted(MNTPOINT))
  14    202  testcases/kernel/syscalls/mount/mount03.c <<cleanup>>
             if (tst_is_mounted(MNTPOINT))
  15     21  testcases/kernel/syscalls/mount/mount04.c <<cleanup>>
             if (tst_is_mounted(MNTPOINT))

Maybe we can just report warning instead of error?

--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -481,7 +481,7 @@ static int tst_mount_has_opt(const char *path, const char *opt)
        char abspath[PATH_MAX];
 
        if (!realpath(path, abspath)) {
-               tst_resm(TWARN | TERRNO, "realpath(%s) failed", path);
+               tst_resm(TWARN, "realpath(%s) failed", path);
                return 0;
        }

> 
> diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
> index 4d3bfc52f..ac8311559 100644
> --- a/testcases/kernel/containers/mqns/mqns_03.c
> +++ b/testcases/kernel/containers/mqns/mqns_03.c
> @@ -130,7 +130,7 @@ static void cleanup(void)
>  	if (!access(MQUEUE2, F_OK))
>  		SAFE_MQ_UNLINK(MQNAME2);
>  
> -	if (tst_is_mounted(DEVDIR))
> +	if (!access(DEVDIR, F_OK) && tst_is_mounted(DEVDIR))
>  		SAFE_UMOUNT(DEVDIR);
>  }
>  
> diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
> index d28c330c4..790607ecd 100644
> --- a/testcases/kernel/containers/mqns/mqns_04.c
> +++ b/testcases/kernel/containers/mqns/mqns_04.c
> @@ -123,7 +123,7 @@ static void cleanup(void)
>  	if (!access(MQUEUE2, F_OK))
>  		SAFE_MQ_UNLINK(MQNAME2);
>  
> -	if (tst_is_mounted(DEVDIR))
> +	if (!access(DEVDIR, F_OK) && tst_is_mounted(DEVDIR))
>  		SAFE_UMOUNT(DEVDIR);
>  }
>  
> diff --git a/testcases/kernel/syscalls/mount/mount05.c b/testcases/kernel/syscalls/mount/mount05.c
> index 66e102a32..5585e230e 100644
> --- a/testcases/kernel/syscalls/mount/mount05.c
> +++ b/testcases/kernel/syscalls/mount/mount05.c
> @@ -35,7 +35,7 @@ static void cleanup(void)
>  	if (tst_is_mounted(MNTPOINT1))
>  		SAFE_UMOUNT(MNTPOINT1);
>  
> -	if (tst_is_mounted(MNTPOINT2))
> +	if (!access(MNTPOINT2, F_OK) && tst_is_mounted(MNTPOINT2))
>  		SAFE_UMOUNT(MNTPOINT2);
>  }
>  
> -- 
> 2.49.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
