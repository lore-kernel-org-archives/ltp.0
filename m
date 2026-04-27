Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34B8FF8860
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 13:58:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EE0C3DDAD6
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 15:58:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F9D03E1604
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 15:57:50 +0200 (CEST)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com
 [IPv6:2607:f8b0:4864:20::1242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2D588600732
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 15:57:50 +0200 (CEST)
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-12c88e5f4aeso4370895c88.0
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 06:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777298268; x=1777903068; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82Na1i/QvQ1OEMKrwb876CxuRhCDtg/oP9hn0luqebU=;
 b=QCd+bTJfA+F2IyPTTyeLX87HC8gm4mlkvOJxPiDxFLL6gUXq0aJW+g7MKG6hr0oK0z
 Yxq6l19Zzyz3K/CdlibPdykGOzL5rfKUpxTsi+SbctzrKhRLZTG3Z6ZYjC824JP0g3+Q
 oY1nAisvyjdpDLU4DhIPKnyXYqGCES7/qNWcTHXv0sBneFOPWT3IpCiPB3gG93F2SnKy
 eLIvACbuniZThbBE6+rvA72ndXosIA997ewNwMmq+WTz7HOsuEva/gkqO9q/FIZ/t+xc
 OGNJoP+6avYiveDW5oeiB94/ho2KCiysjQqBmtxDqtvxw8u0bmFoQayiz1QsMsqAgfuu
 Ff9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777298268; x=1777903068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=82Na1i/QvQ1OEMKrwb876CxuRhCDtg/oP9hn0luqebU=;
 b=kQUi50o/UYdZiYHbHY+0pgZeOo/1gPB9g3/MFvf+Re5f43UoCpNGxI5USTWgvJspsa
 I1XNhxEDeEXHyq3wIn+gwg3YPzMmPF5leqpIY2G06BD5hqF9yQPitxKXrZqxXIuD8/5f
 yOCo4nBjjDBApiEESFwKgtvjvQlzNJmISw3ees4t6W7M26Sq/D8/iokCA/8XasiMpiKJ
 yk98zz56RPTYDUCuvGgd6PgFUzLvSr7QbU1kRovPIBybN2rRXcK7V0CyQ+qwxeLpwBE4
 SOAqC8/kKoAgJPK0RumE1qRbSbfgWwAUUBwZyLMLKD+AyBcbtwz6uOL4lUZguoch5yOh
 d/vQ==
X-Gm-Message-State: AOJu0YyvnKappFhC49zNSpC3buCOp2XkD7owFKm8mEudP13iTTNHHuhN
 tPaN6yFFjx1yWbt6P5uuQF/RMEzMClwfCfrJ6sOSGqkvp2bGEZjz6XOJ
X-Gm-Gg: AeBDieu2c5Vgfbw+Vx4MRBm5SLWKaRILfaaXmnuKVyk/loD6UiqLf8BVNGc9o2e/G/c
 F82QEu3iEoj5Wivatp3XxrKlYCumDo+wo8hMj4wD3rd+xTBxsgo60C5VMD6Su7/Klnb3VXWilvZ
 a1whP+zdWg5Q1R72hiPTvrqE2yS18ZIMVFdQ0aDBcj5QHvPnqQ/7s/V7u5mCC+SsAJlZW0V2BpK
 GTNRPP97nbaz1Nbcpidasv1GnV19DW+jPXYuumXpdt+HbJdMV3wt8DeoOR/0hfI1GkOLAmmrrxj
 221LrIQ6MfoCqwHkr3T4JZXsIEskeZV7xjROKMNQwp5LcizOA4ms2yM5T5VnymRpFxKFqUuMXC/
 nhLvjaEIXNc6slcsfFd080Fbd9uutp+AXQAv4co8HPTlY1o4rzfdsncV4VYfjK+kb3N6//ssqvE
 VCWPylV6DlJG9+NcI/7kidXl3vridUc+2G/7CGWqje48xwEdK+LElyYHX1Wqdau37t9mP5sjE2A
 uRnLnHbiM2drrD8vK+T1lvjyPXADRNzUb03pWaO+rzhS5nKmPZ4
X-Received: by 2002:a05:7022:fa2:b0:12c:11d4:61dd with SMTP id
 a92af1059eb24-12c73b39a41mr18080270c88.18.1777298268326; 
 Mon, 27 Apr 2026 06:57:48 -0700 (PDT)
Received: from
 runnervmeorf1.inpavvx5jshutkevxdyl5th1ga.yx.internal.cloudapp.net
 ([172.208.153.213]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c8e837beasm38879562c88.11.2026.04.27.06.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 06:57:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Mon, 27 Apr 2026 13:57:46 +0000
Message-ID: <20260427135746.3941-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427115941.31945-1-wegao@suse.com>
References: <20260427115941.31945-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mmapstress06: TCONF on systems without swap space
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

On Mon, 27 Apr 2026, Wei Gao wrote:
> mmapstress06: TCONF on systems without swap space

> +#include "tst_memutils.h"

Minor nit: the include lands after the #define ANON_GRAN_PAGES_MAX block
rather than with the other #includes at the top. Consider moving it into
the existing LTP include block for consistency.

> +	if (tst_available_swap() <= 0) {
> +		tst_resm(TCONF, "Test requires swap space to exercise mfile_swap logic");
> +		tst_exit();
> +	}

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/24999033042

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
