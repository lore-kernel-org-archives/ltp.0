Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B3FC02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 11:47:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53BA93C98BB
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 12:47:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8254E3C2CCA
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:46:51 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0FA3C1400F8F
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:46:50 +0100 (CET)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f6a47d617so27113515ad.2
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 03:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739188008; x=1739792808;
 h=in-reply-to:references:cc:subject:to:message-id:date
 :content-transfer-encoding:mime-version:dkim-signature:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U7uUoiRBBLYn/hpyGWTbrRlQl6UEFbR3EDO6HAsAJXM=;
 b=cT+xCxZkHLDvQ6W3H/eOCTXUiWopi2jWQ2gmSIqgQksACUrThRcIxmThcE+mu9rOYt
 Q84MO51mVUSgSAC/LgGCjEO/Xu2eIQSHzx4kHf6arUK2eeGYB6RgmgF46m5MO38M+iGn
 LqVc1rSS+2khr+l52Dv1XFvwOzHEPY/SiHPITSjsm7Rv3X765ZKk0QzlgaZHmzSHNvW5
 T2ma91lMlro7ROtPN2ifoCyavVScrOWgqokMja/94xYnfUqfRTToLP/vEGj7Q9MTWqxI
 2Ws59/3j5TooUz696X+/6NDyPWOfffCS3gO+rDfsh+KVTBbD/TDGwC7EN0qGOBD9tUhH
 KmsA==
X-Gm-Message-State: AOJu0Yxne2Z03NcBXFHgxsoNTwDq3OKocLX1I25m6m1HEN2fi69UKR4a
 xBDKbjOndx+bh6ppwk0HA9GCqrNTSoIx7tgvdAv3JWh3Jy/kVOsKLqnYupqdtl8=
X-Gm-Gg: ASbGnctteXXiP4sVJWURZvkuq2GDjywO1lg0tg2cU9vX5jN0FL71mlN15nHXtgQA5PO
 ldoGn8kebUrZjCpiXWOskDljR6ih5reiUzSY1pz2k7OevkOXjZOh/QBiCz52e6OZtz/h7/Ax3ou
 yDsIwX800bh8aX84CS3ZgBjLeqH00KuphQBDqkR/M90LH9Q5MyAum56rBwavGH18EwVmYml5I8d
 TK4G71X3A/N3bJRHz+TLn5qQf5oGD8FLVrnLgXsbi9mUdJn8A6qi3ubR8cPi9S2IEnj2w8Boqla
 Vq37+9HKuQ==
X-Google-Smtp-Source: AGHT+IFwWbvNo0F6YEGKo3Domv4OFokc79GiXl35UJAq/dx9KL6Bqyg0Hl4sc8BwsFgZ6s62R6xGTQ==
X-Received: by 2002:a05:6a20:9f49:b0:1ea:f941:8da0 with SMTP id
 adf61e73a8af0-1ee03a8f503mr25305245637.24.1739188006995; 
 Mon, 10 Feb 2025 03:46:46 -0800 (PST)
Received: from mail.marliere.net ([2604:a880:4:1d0::7f5:6000])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73077975f05sm3919069b3a.14.2025.02.10.03.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 03:46:46 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
 s=2025; t=1739188004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U7uUoiRBBLYn/hpyGWTbrRlQl6UEFbR3EDO6HAsAJXM=;
 b=hrMepib0/8kWUodCP9EgQ7n5zftZIvqcYmFXwVTZ8zXVD9QfLCA8WmVhS2247OPUvVTI9N
 AfQtwsJssEZL5nZ3HAFjqTX6zypufdAcCkjZ4FJaNOKjEZTp2IElGVi/pXyeW5wGu9WPU0
 0odVXCUKeZeAiu25PGt4StGiLFaDufDoLcbxmUyJbq0SF3QlkkCFTWAu0YwJlAM41Dbeqr
 1oEgAzBxNRlcFY6DiPdEAbz7AEReMNm4+YWgbYj1AQpcg6WvISSWPc/PASbJGcJyC8i9L9
 pg8A/HkqOskFnz/NZU8ivzsaN5B/wuJrOvHamz5fWW3jZutGxRuJGAZBvMzJqw==
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Mime-Version: 1.0
Date: Mon, 10 Feb 2025 08:46:40 -0300
Message-Id: <D7OQOXDWO2CJ.3VL7P7EKT6642@marliere.net>
To: "Petr Vorel" <pvorel@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>
References: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
 <20250210-mmap_suite_refactoring-v2-1-6edea3a4363a@suse.com>
 <20250210094141.GA1826068@pevik>
In-Reply-To: <20250210094141.GA1826068@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/8] Refactor mmap03 test
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

On Mon Feb 10, 2025 at 6:41 AM -03, Petr Vorel wrote:
> Hi Andrea, all,
>
> ...
>> - *	07/2001 Ported by Wayne Boyer
>> + * With ia64 and PARISC/hppa, an attempt to access the contents of the
>> + * mapped region should rise signal SIGSEGV.
>
> You kept this:
>  * With ia64 and PARISC/hppa, an attempt to access the contents of the
>  * mapped region should rise signal SIGSEGV.
>
> You kept checking SIGSEGV, but not sigsetjmp() which should cause it (IMHO it
> will not work).

In my initial testing [1], I hit a situation where SIGSEGV was raised in
my Tumbleweed SUT. I eventually found out that it was due to
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y in openSUSE kernels.

[1]: https://lore.kernel.org/ltp/20250114-conversions-v1-2-7869a9f786d0@suse.com/

I was playing with the following diff here but was unable to catch any
signal in the current version:

diff --git a/testcases/kernel/syscalls/mmap/mmap03.c b/testcases/kernel/syscalls/mmap/mmap03.c
index f22365b259da..25f9c5ce4d18 100644
--- a/testcases/kernel/syscalls/mmap/mmap03.c
+++ b/testcases/kernel/syscalls/mmap/mmap03.c
@@ -22,6 +22,7 @@
  * mapped region should rise signal SIGSEGV.
  */
 
+#include "tst_kconfig.h"
 #include "tst_test.h"
 
 #define TEMPFILE "mmapfile"
@@ -67,7 +68,14 @@ static void run(void)
 
 	SAFE_WAITPID(pid, &status, 0);
 
-#if defined(__ia64__) || defined(__hppa__) || defined(__mips__)
+#if defined(__ia64__) || defined(__hppa__) || defined(__mips__) || defined(__x86_64__)
+	struct tst_kconfig_var kconfig =
+		TST_KCONFIG_INIT("CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS");
+	tst_kconfig_read(&kconfig, 1);
+	if (kconfig.choice == 'y')
+		tst_res(TINFO, "CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y");
+
+	tst_res(TINFO, "%d == 11 (SEGV)?", WTERMSIG(status));
 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
 		tst_res(TPASS, "SIGSEGV has been received");
 	} else {


BTW, thanks for the mmap cleanup, Andrea!

>
> I wonder if we should care about these old archs. Both ia64 and hppa are
> dropped. The only still living arch is __mips__. But looking at change when it
> mips was added it's quite recent - 2021:
> c7f979b3d ("syscalls/mmap03: Fix SegFault on MIPS")

TIL, thanks :)

-    Ricardo.



>
> @Cyril? Should we keep only mips? And I strongly suspect nobody is testing LTP
> on mips, but we should probably not kill a still living arch.
> If all these archs removed whole fork could be removed.
>
> ...
>> +	tst_res(TINFO, "Map temporary file in memory with PROT_EXEC");
> nit: I would remove it. In case of the problem SAFE_MMAP() will notify,
> otherwise not important.
>
> Also, can we move SAFE_MALLOC() to setup and free to cleanup()
>
> data = SAFE_MALLOC(page_sz);
>
> Kind regards,
> Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
