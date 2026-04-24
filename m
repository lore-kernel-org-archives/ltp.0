Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA5AFDEE5C
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 01:57:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 153E03E5815
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 03:57:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 647103E25EC
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 03:56:51 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9722114002BB
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 03:56:50 +0200 (CEST)
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-8acb550db18so77222576d6.3
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 18:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776995809; cv=none;
 d=google.com; s=arc-20240605;
 b=RVg8HaiSLb63YGp7z8wwUflyG1AE6ILEvaN+R02nnphCvTSJ6qnCXAdPi4hq3LIUoy
 7N8kdIqVoYGsjGe2zJWp6xkX9d4u/vp7dveGewVGRayiORSHRT0+0ygcLlau0KPW1O11
 mLGemWJklm5EWRNQYtDhCcHY35x6PXBk7hj49rAFIY1NrnJkR9UVKnYnSq5c6GgXjK14
 +ShUitQKPO74IRBc5HwAGRiN6rwXZRAoB9Lbi4++oQb4fhIDstgOOW0I8PWvOALqLkHG
 Ylc2ZirF2wcRqDtrVV+ETgNy3Y4pmtNRjWAtnhGcrhsfGFOC5ALzOV4PhxWyvdiON1LN
 ngJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pAKjSECIBfy1UCak6WVWS6e0EaaVGWXh2aVDhx9ziy0=;
 fh=bLRSLB6Hg0q7dw2tQxYczcg7wLhrjJbRMhxP/DiB9Gc=;
 b=MvonQiWY5ggUKWzs/wUv8KPUf0fqrq2VIP9vP1AHtj1YU1++gtjLDWVzmm5YrReQ1m
 YaRbye7iJUvZv3x1GfRUXWpfsUhbg/XlQvfDqvKMkTdhbdP/yEMFCKJfUtHjZ6RJavVs
 BA07o+3dHMfPdS4UgxSVUvcLoPcNLk5dRJs0hYaavk8UMMznoenPGrNZDm+Jx/DSbwAs
 LXlsMlpa3J/+9u0mvz30SYLDxj4tqpK2xjs42G9p9FHxbNTuyj4elKzFwa878m9HQ1Ew
 RemeT/xTP2CO509pCh0F3Gwyy0Qij7xpnnKb53TTGhmnDioMmUkBZW/zC6dfzbZufAkq
 idrQ==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776995809; x=1777600609; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pAKjSECIBfy1UCak6WVWS6e0EaaVGWXh2aVDhx9ziy0=;
 b=BwwH/FiOvPn7AY4tAtbf95z/7S6jLaWhmrpF5jMARPcREhfEUKhaRp450UetDvrOzL
 365X4xW/tZ965xXjtm02ORnLdiba33PdC/OkPDC4CZGks+ahXRwKnnKy81TGZiEdwllb
 DSFWxCB/wRG105IFHc2w8iEiJMAu39WJBmT4yhxztJNl9W2zegqDhLF5TAXtxs0bMAeE
 nOD3T2VkSZySVE+BwceZjXV7vgGKkp0C0a+dNWswlxohrzPrU92wtuKAz35R7pkDx0QP
 UVMMmy0CA7Ooudm2rw2ucQ+MrdNEBE0u42ai2mV5pIErzkDAbJHJ+zajJvbLmL+YvAHX
 0tPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776995809; x=1777600609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pAKjSECIBfy1UCak6WVWS6e0EaaVGWXh2aVDhx9ziy0=;
 b=BhrkLljqtjH7j0qDqaugr3QZjppJZ695Mn6A0lf6Sqdwil5BMJ/z7aNW9z3KhoW8hK
 cjs1UnLxu3a9y6xc/p+QX8B9j6uZBJvb/hCzpI1I4Ye96Oxckmsm5xzPqsrtiUF8gyOj
 jsAyMiCVNdL0hS8kASNgJJ0pA2V2HVh1+98/hQ9lrUxZQybNFwggMs/cwylEIafHymNM
 QH8YaTMXwsO4MF9Sk7GiQT8DepE5YCIIRbaXly/jOoAJfBjpdUuycFKMFSLtZPjqWQgU
 4uG3aUGzG4df8OY1mSlP/U03tmXGSyz2SkebIHVyplxnAQXmRcjjt2fUnuFfzX3S4Fsp
 VzFQ==
X-Gm-Message-State: AOJu0YxPU+SpleGtargnHqMkZsrK58+lMdg3At1iqKGBiCr3ilR1ov9j
 6peL8SXbs1uJV0cF1lOap9rn2BLPDC1+7pevLHf45O/OvBwmKUQy30MpCyUcMsGXbYXdLXfWxF9
 yXxmCaoL2Nc2JptwPsdvqtYWHc5tB7g==
X-Gm-Gg: AeBDietsZE/RAUej9Eru7zCqtpe8TMtG4/O8raF3nFECeezKJ7vpGTagrMWp9cKxGke
 YWYp07Gb+iKZjcHJ5BC1Cmxr/luZ7y9aaIcAcT/OPSZfgTHmoUrwx9uIAPeUVUq3BPlZQDbhqtU
 rVcr0wJdKJ3JICLfuOh+HXu+VaDFIh7AJx3jBlfmCa0rt0qs7U+4sfTRqovyN+mhnyAKlgi+Jkl
 MgG9KK+OZxn5rxDh45REfdBXFB8eI+rFvm63thWfDY+Y+xmVtz6hGrMbJBrSaL/2m+1i5Dc4azy
 4yg/eoQeQWWQPHK/gQ==
X-Received: by 2002:a0c:e018:0:b0:89c:5743:d09a with SMTP id
 6a1803df08f44-8b028040598mr455386176d6.2.1776995809313; Thu, 23 Apr 2026
 18:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260423084123.657690-1-pvorel@suse.cz>
 <20260423084123.657690-6-pvorel@suse.cz>
 <20260423093834.GA664424@pevik>
In-Reply-To: <20260423093834.GA664424@pevik>
From: Li Wang <wangli.ahau@gmail.com>
Date: Fri, 24 Apr 2026 09:56:37 +0800
X-Gm-Features: AQROBzCT3itWMcA6sc9xeccPgqJIt1I4CTTRszy5_pfvjLPh_uvc5bkCOxgTakA
Message-ID: <CANgNiRz_vKp6zKrHoUDKF288Wyr3NW7EBvUJJP+Vu663g3bAOQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, li.wang@linux.dev
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 5/6] lib: Merge functionality of LTP_QUIET into
 LTP_REPRODUCIBLE_OUTPUT
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
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it,
 Martin Cermak <mcermak@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Reviewed-by: Li Wang <li.wang@linux.dev>

Tiny note: it would be appreciated if your replace all the reviewed-by
with my new account in this patchset.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
