Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD42E9380E
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 03:38:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C23EB3E295A
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 05:38:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C43173DD13E
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 05:38:13 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0F0F414004EC
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 05:38:13 +0200 (CEST)
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-38ce8a5bc20so40295571fa.1
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 20:38:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776051487; cv=none;
 d=google.com; s=arc-20240605;
 b=QxMNigd93tNCOLKdIz3iMaXEXQwTvY9odeEm2bni+pXrEhGGhIh9MOI9XvumVoew9B
 cpHBHfWpGQRCqLYY3BNnhPMpWQaoyBQjRCUS0lcahngst2g6UGw3KNdJmkYJzPcJLoHb
 gqXudYExEmM2VENM/2O9IsxsSLcnln7ZSX9/16BDK+CF3io9OIAJJanp2fGOqyC/GlJh
 eIBBBT+cjPXGqJKOXs4a0etrD9LlnxEljJzJuf43N4iEdKUw3+NXqhtWVe1qIpdbOnK8
 1ndMEzZ7WAIpia+CE9WvneNAAymK0mir1ZdGlXGhFb+jBdyWlXfe95RouD4k3EuvivNk
 4VeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=H25Cn1hJm2GTaZC717gzuLSZksCfqN0d13PT0ZQtEh0=;
 fh=VMBw60+5U800FNixJt956WW7GMxjBbBghast9nESOAc=;
 b=W+5T6fE1Ke3ImTN1NjThnt5xuboCwjeeGwEASh+CjdGYh1ORUBpJO1G1xxkD1Pk73/
 Uym+3NZyYjiQzA2ntSUt+5xakKk2HRVpNc6BdTKaNiSgcnKl4DQdNWNEmyyz9c5fBNmV
 v4oanfiGFeOeninuNRDu13Y5CfeDJg6MBzdcuL1/GUs78fKZx5lDIML0fW675vkE3Q/w
 KG9Naf8HTrdiLP0ZHErQPqYw5nNbo3Fuw2pWL+EHI2/lNEXTqVnKOFFKu/RRzQDOx132
 yJvbMkNcKTyRuGMhO/cyF3l4PKqealUyZZo84Wdu7SNMOWM1EOvB63TeCivkPRKSmAXW
 Ew8Q==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776051487; x=1776656287; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H25Cn1hJm2GTaZC717gzuLSZksCfqN0d13PT0ZQtEh0=;
 b=TNgfnQVpSTyFIr2ZX0cZUyXrZA6XZ/am+u4uDKkBhE2fNXHxhw0RnMHLmy25fp7JzX
 vkF/bP9KK1oj87xaRGnPWODdZ333b7Mstpq04kPdoY07mAke6E5kqr4X/Plc402AdUGH
 4eaTGzj4KEbWo8eMkHa192yqgufT5RdSHwuCZ2k2it6ijppc+T6akS+j9VDNPFmNszrw
 Nupy1vLdhs0VVzIHn0rUB+cCtxuOV1IJhAk2jaJwsozx5jIHv3emJYETMay1ap2lxvni
 GEN0A4IkebP+iXM9u3lexs+CKNEluE/vSxmlhfXH+cOCwBYLMitdo921QvUpADCvJ8qi
 wrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776051487; x=1776656287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H25Cn1hJm2GTaZC717gzuLSZksCfqN0d13PT0ZQtEh0=;
 b=p3CtVokbcEFArMoGfwv2nUl6tasGKyOXGPTjmTDE+uScEpSZ8cPCkXBTbax8GuZOsk
 0e/j1ZxCORkyv7WTHDAo5dUBZo7IcsTDsYPETZy6tC2C1ArZU/yFeztk8fFYN0/H3rbZ
 AwJOXDWoZBwKfzWXUTztv3nffxPNHt59+sFNS9VVwWhLGF62rOdqrmYIj5NTfe5s13sW
 5Ef1IMO1fZ9smHJU8HAkTLQZLX+P7yseOD87VCOrYbgkzqP35SKGLrU7XPvRfqA7Fm29
 h8pnkqPLGeJybfjPwqDUq2mP4yQny38oaZB6gscDtblga5sSBBs4eoi3qvNNe0iEEqxh
 aFzw==
X-Gm-Message-State: AOJu0YyUJDqQcVUtVzmrxZvol0lthA+j/YYB4SqOOud/LoTs63Kwb8U6
 nuQ52ugxoBGv+LGLuAYNK5OIqTDGIB2kjt3NDCU7AvrmEmzmP/qetPpsrlmAYnQ8SxfZCU6o0zq
 NYVd34L/vnaibOdwQrYUiIyVPrauTdzA=
X-Gm-Gg: AeBDiesUoSxG7cl9gW+FKOqATgve34QLciQAOAmotLcQJEwgMMvNPQ/ObdimdGYnRxT
 H77sivV/4LXwLtXOwTbXXQVqBQBBKSRefz/qceVtLBzTlGhoosn1G/PQpHsRIWA/Cd8vTeMrHW0
 rDdteHGqqyhx6EWNroXiztVFwKG6NPdOKA4weHpJyCdSx4x7bkvY5ietaSuOsLplHLYaVccXX4z
 pZrmOGCf92ypAWtPoxVMNZvfhQk/PX5ZxlmQBGJCIll3E7odpD0EbI8cTLKFY3yVuHN1h6tNv8e
 JPtgciw=
X-Received: by 2002:a05:651c:210c:b0:38e:8289:7938 with SMTP id
 38308e7fff4ca-38e828979bdmr2025511fa.24.1776051486865; Sun, 12 Apr 2026
 20:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260412141039.1075095-1-samir@linux.ibm.com>
In-Reply-To: <20260412141039.1075095-1-samir@linux.ibm.com>
From: Li Wang <wangli.ahau@gmail.com>
Date: Mon, 13 Apr 2026 11:37:52 +0800
X-Gm-Features: AQROBzCO7OuZBFPf-NjxozKPBahCGwS6r2p4lM5KXnD0f2Hw21fi-JCvZg0_VyM
Message-ID: <CAE1O6mhy1i5yZBW8VGVjTeU=Wqe29DY1i+iOqqLMVJC+sRr5KA@mail.gmail.com>
To: Samir <samir@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mem/hugetlb: use SAFE_SHMGET() in hugeshmget
 setup function.
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

Samir <samir@linux.ibm.com> wrote:
>
> I updated hugeshmget02.c and hugeshmget05.c to use SAFE_SHMGET() and configured the setup paths
> so that shared memory allocation succeeds as expected.
>
> In hugeshmget03.c, I also simplified the tst_brk() message by removing the unnecessary
> __func__ usage and keeping a straightforward shmget() error message.
>
> Patch v1: https://lore.kernel.org/ltp/20260407054943.125260-1-samir@linux.ibm.com/
>
> Signed-off-by: Samir <samir@linux.ibm.com>

It would be better to improve the patch description, but it's a minor issue
that can be improved by people who apply it.

Reviewed-by: Li Wang <wangli.ahau@gmail.com>

-- 
Regards,
Li Wang
Email: wangli.ahau@gmail.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
