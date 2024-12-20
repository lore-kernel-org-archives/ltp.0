Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4E2E77188
	for <ltp@archiver.kernel.org>; Fri, 20 Dec 2024 04:00:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 071B23EDF9C
	for <ltp@archiver.kernel.org>; Fri, 20 Dec 2024 05:00:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F6E13EDD00
 for <ltp@lists.linux.it>; Fri, 20 Dec 2024 04:59:59 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EE1ED600281
 for <ltp@lists.linux.it>; Fri, 20 Dec 2024 04:59:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734667196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bVYdanjf6tyngnLKKJnswxrjlvLkndD2mmMd0NaQVFQ=;
 b=Ls1KcC+0kk2ogyEX0DxJvWdfHV9fnPdDeRKEMWN2YJOvTkVBO6BMWGsYV9RFkclsEmmqZW
 VgpqXFwBfZ5cHa8LlgDXxnkKTkq3uANTIlm5J4AodTGuoQTH9N5Ig55kdFG17wraAKFgdM
 GWA0VZOXbotaqXCV85GEaDJ2umRVnpk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-usAc9AcDMv-KmA9vCARByw-1; Thu, 19 Dec 2024 22:59:54 -0500
X-MC-Unique: usAc9AcDMv-KmA9vCARByw-1
X-Mimecast-MFC-AGG-ID: usAc9AcDMv-KmA9vCARByw
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef7fbd99a6so1348884a91.1
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 19:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667194; x=1735271994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bVYdanjf6tyngnLKKJnswxrjlvLkndD2mmMd0NaQVFQ=;
 b=qT0DLa+lVDlV7V68E/9j8A4QB3+Pwi4OwfwPH1vcyv2zexgSq7dRbOFpGOk6tl5b9b
 rnLBFAVOkkE/wgDQJ/KMQVOxqkfBPAIjTPvEphbGgOsCajhbSfSivQcO/soRHop97hLB
 qTqFyXQmRSMrOmjqXtHiO2PW06WU8mvZpcfoHNTsZpmXnh7hxYMTXc0cHQ2UUwi3by41
 bq8qWAPSZ9/0wb6oO+5B9xDiNev08GAHsRVnaxB5dEqpv9OvXEusLUUfriH+xV5eTAwE
 zgmeeCyP7ZfcINkcOQ+/WvBUeHM6xcjXDOeLFNx9OAgkk+dEkzeFSX5XJYGMt/NwcRxl
 sxMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSfsrbG0sj1KQJQPEROe41DFGNCsuPVcVAawrgW9K/TqZfJeho5I8+Y5BDXZqzw3nXLdg=@lists.linux.it
X-Gm-Message-State: AOJu0Yzr2Tjfv9N13XWNKqD0vFes+qP8nnC7SIoQstcKXEiniTaB8o3V
 ofNGxnsw2qgPUebqoVHh2cZhIL1VFXV9Xom82fkwTshDnp4ZKnrkKHBhHEgKEzP94MoAzcSmrUV
 /ycXDSQjMyTCkoiMEqTfStFqWA3P8bnVoykkfra2ugAIyh8tbuPRVlP2E4uxMCgA2lyF0mhNraj
 2+blQmBSdQmkSmz+mG265Q82I=
X-Gm-Gg: ASbGncuWFdwWezWE+hBUtXsmqaQ7KA26u+Gg77Z7Wc4Lj2LRqT8XQwAMT3PN+Z1tThS
 deJH0QQxeEJqd1iUtBNrOS8XZjuaRL1JVKwZlxJI=
X-Received: by 2002:a17:90b:2745:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-2f452ec7001mr2057455a91.28.1734667193851; 
 Thu, 19 Dec 2024 19:59:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IER37i3vIxEcQn00KJBK1UZCHuvaK3R/ZYdI5P4zptOVCJxCeXOCK3ucMYXzxPZcpQuhaM63ceb4siqYW2OtxA=
X-Received: by 2002:a17:90b:2745:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-2f452ec7001mr2057430a91.28.1734667193488; Thu, 19 Dec 2024
 19:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20241212060448.204158-1-liwang@redhat.com>
 <b6da77f3-45d6-4eed-b2d3-90ad20c63e50@suse.cz>
 <20241219130738.GA111004@pevik>
 <CAEemH2d_P7y+y+P91Lxxi8jBVN1mEjWtt4fh6CRQ07+Bv0yp9Q@mail.gmail.com>
 <20241219132800.GC111004@pevik> <Z2Qfs0C6_TAre2-o@yuki.lan>
In-Reply-To: <Z2Qfs0C6_TAre2-o@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Fri, 20 Dec 2024 11:59:41 +0800
Message-ID: <CAEemH2fqyVyUbOr=tMdxFQdKNTFvOU34LUwBYnfqFaZfGFbKNw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4VVi1TlHczy87TMNIehrMu4yQnLyUsDwvRfzipPxZxs_1734667194
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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

Hi All,

It suddenly occurred to me that we might be on the wrong track in
solving the timeout problem. Because 'max_runtime' is intended to
set the expected runtime for the main part of the test, and is also
used as the loop termination time by tst_remaining_time(). So the
multiplier has a side effect of extending the looping time of many tests.

But our original intention was to avoid test timeouts on slow systems
(e.g. debug kernels), and the timeout is a hard upper bound to prevent
the test from hanging indefinitely due to environmental factors
(e.g., slow systems, kernel debug mode).

So, shouldn't we only target to extend the timeout value?


--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -555,9 +555,6 @@ static int multiply_runtime(int max_runtime)

        parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);

-       if (tst_has_slow_kconfig())
-               max_runtime *= 4;
-
        return max_runtime * runtime_mul;
 }

@@ -1706,6 +1703,9 @@ unsigned int tst_multiply_timeout(unsigned int
timeout)
        if (timeout < 1)
                tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);

+       if (tst_has_slow_kconfig())
+               timeout *= 4;
+
        return timeout * timeout_mul;
 }


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
