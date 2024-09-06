Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE933CE7AE0
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 07:34:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 114513C2145
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 09:34:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80E5C3C050E
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 09:34:40 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C3BF71A003EF
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 09:34:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725608078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LILIagve2XKnwVCiM0NnOldsegua+OOjN9gOy9vXwkU=;
 b=AN/ynxZjFUaVY7TxzCR55tfdPsAAyADaklr44Bbw3/tNaYvTy2I0WwJ9S9Df0o0LncLXP7
 cLxIONccARz3PHXuuSsbOL2BW+TwBgpS1utt7EGK+tmn50upG9/sP5lu539+KU0st0DhBI
 8OgFzmYxg7FsXAM5TaR7wYEbmlnPGg4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-djxEjOWQNzW35g0bAd0qJA-1; Fri, 06 Sep 2024 03:34:36 -0400
X-MC-Unique: djxEjOWQNzW35g0bAd0qJA-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7141f62ac14so3269882b3a.0
 for <ltp@lists.linux.it>; Fri, 06 Sep 2024 00:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725608075; x=1726212875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LILIagve2XKnwVCiM0NnOldsegua+OOjN9gOy9vXwkU=;
 b=BndH5ACcE43Ni1ctEkRQ8KpBH/c5CYtWNUXgRO25eGTXSBxHR/ro5/+V7Le/fO4tlH
 GjD6kO8e8WG+hO5lQP7uaUeausYKZ6jIuvMOwKweTZX+8z9b8/IHZcjLXQJByu3ODHmJ
 2PFk3Aq5dCraBXc8gD55A72k0I9kZCwuuvha3YLq9Aq+nmnD1btozqjg78H2f5U+7MhJ
 KYdiyhBpDxonkZGqX9whkVmVdQXy6AGBFZ9A72KBkoVdfDPi2mCWOpu2+vE/DE9rh4wu
 yKPddyLovfiVy91jyRXONxu6UTjSL4eOQZmp7Gpy0QYsNECxVPKdXqtsjibknXdmeJS4
 mjuQ==
X-Gm-Message-State: AOJu0YzGPENN13biSWectBTkBaEPCMxLnxAn+E7yXsNqhTH3KiV349LB
 lKgzbiY4St8L2iMTtZPldA0/vePLfkEgEmr1IZXml+qedv1OqdMzj355dkRafJc8vW7KNWm0hzK
 CQgBk+fivb7qGdxOR6S/PgSBz54Y1JxrGVrq6hZ1Fb+d0Y0tZbMVfLXTT0wvhAX6zhaPIWDKVVK
 qJc4fo5kUeP5jzlH/ueG4QHRo=
X-Received: by 2002:a05:6a21:3213:b0:1cf:1a90:fa6f with SMTP id
 adf61e73a8af0-1cf1c10bd3fmr2861804637.20.1725608075129; 
 Fri, 06 Sep 2024 00:34:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEscu313th/++nO3XodR6M6C7qbq2pWVWBVknw3EwQvTYQ8QowpXyoOkdSwcYFvYwRItiRiHutr2lbkNKjeoNA=
X-Received: by 2002:a05:6a21:3213:b0:1cf:1a90:fa6f with SMTP id
 adf61e73a8af0-1cf1c10bd3fmr2861777637.20.1725608074748; Fri, 06 Sep 2024
 00:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240827120237.25805-1-chrubis@suse.cz>
 <20240827120237.25805-3-chrubis@suse.cz>
In-Reply-To: <20240827120237.25805-3-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 6 Sep 2024 15:34:22 +0800
Message-ID: <CAEemH2eQQfhTfVo5xrBHFjzuf4dn=VqK2M=9Y3+hy+r8yzMtAA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 2/4] Add support for mixing C and shell code
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

Cyril Hrubis <chrubis@suse.cz> wrote:


> diff --git a/testcases/lib/tst_env.sh b/testcases/lib/tst_env.sh
> new file mode 100644
> index 000000000..948bc5024
> --- /dev/null
> +++ b/testcases/lib/tst_env.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +
> +tst_script_name=$(basename $0)
> +
> +if [ -z "$LTP_IPC_PATH" ]; then
> +       echo "This script has to be executed from a LTP loader!"
> +       exit 1
> +fi
> +
> +tst_brk_()
> +{
> +       tst_res_ "$@"
> +
> +       case "$3" in
> +               "TBROK") exit 2;;
> +               *) exit 0;;
> +       esac
> +}
> +
> +alias tst_res="tst_res_ $tst_script_name \$LINENO"
> +alias tst_brk="tst_brk_ $tst_script_name \$LINENO"
>


*** Running shell_test01 ***

tst_test.c:1860: TINFO: LTP version: 20240524
tst_test.c:1864: TINFO: Tested kernel: 6.8.0-1010-raspi #11-Ubuntu SMP
PREEMPT_DYNAMIC Thu Aug  8 23:22:41 UTC 2024 aarch64
tst_test.c:1703: TINFO: Timeout per run is 0h 00m 30s
shell_test01.c:11: TINFO: C test exits now
Usage: tst_res_ filename lineno [TPASS|TFAIL|TCONF|TINFO|TDEBUG] 'A short
description'
tst_test.c:1535: TBROK: Test haven't reported results!

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0


Here I got test failures on my RPi4 (bash-5.2.21) that the $LINEON can't
be parsed correctly.

The reason probably is some shells or specific versions might not handle
$LINENO correctly within aliases, especially when the line number needs
to be dynamically determined.

So I suggest using a function instead of the alias.


--- a/testcases/lib/tst_env.sh
+++ b/testcases/lib/tst_env.sh
@@ -21,5 +21,12 @@ tst_brk_()
        esac
 }

-alias tst_res="tst_res_ $tst_script_name \$LINENO"
-alias tst_brk="tst_brk_ $tst_script_name \$LINENO"
+tst_res()
+{
+    tst_res_ "$tst_script_name" "$LINENO" "$@"
+}
+
+tst_brk()
+{
+    tst_brk_ "$tst_script_name" "$LINENO" "$@"
+}


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
