Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6669D6CFBB
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 05:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769147531; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=7ZyFiQid7o5ZvHcBnu64rYpdWuy3WySGiGVvIYvI9Lw=;
 b=UrJJkV2db9ekSlMd27RnV/1JQS7LqWNX64XE8TQA+dRyWO1LCk8z4bmeGRg5C7K6y8Iku
 nQktMey6oIFEi3l4vlmDsKo9eDOnNXEG2xje86Chr0RVupLL1+qAqwAVM/cKCon0tf538K0
 EPBJJuiI98dS6DZqOccL6sLFqK/vdMg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A3D13CAFBB
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 06:52:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F84F3C5A8C
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 06:51:45 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 41124600454
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 06:51:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769147502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=57C6O2ubnL4pdAGal0VP9WWJtvJnyfUYf22qloYbOzQ=;
 b=aEVLCFyn45Qy6G5zXpLSiFvHm+fZv6CVeKLZuFhR4hFUCuP9cLlA2NoEu9e+iieLj9825e
 ptK/YEqGObJoaPIiBxFVy8medp0hZOUEuTdB2NPRyCg6pLMBZzdq+UWWAmrTyBqTp++wtQ
 tmjuwQnUZLU9BCtO7fXei9/ktAc1/ZU=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-ErwOb3WtP46b-YToGDoRQw-1; Fri, 23 Jan 2026 00:51:40 -0500
X-MC-Unique: ErwOb3WtP46b-YToGDoRQw-1
X-Mimecast-MFC-AGG-ID: ErwOb3WtP46b-YToGDoRQw_1769147499
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2b7174ab5faso8594376eec.1
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 21:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769147499; x=1769752299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57C6O2ubnL4pdAGal0VP9WWJtvJnyfUYf22qloYbOzQ=;
 b=MVzKD1qdczIaJ9wblCLyGf45iRoxby2qrIq8zZCiwS1VjkxCCYxLzB4eS/D3zQdxvw
 bVhmVGuv+lA0lMK7hhoq064Pf5qkchyETCbU6lKvfZPLRXoUyenm02hPCbETAWE0wnnv
 y++fP4m1c1em6CWcmsaQRYLCZEDOSmJZmNKcTGD5yV9zFFNRy1tWLdD2l/D+Dx3YGIk6
 4TBTjxhw3VZ8Wntcqph6QxmoFk6XQFsaQCzM8XHjMGvoN/Qwp+Ek7LWKB/Zn9rR5nnZJ
 HhIFEMEQsUhoszM2fPA1rs35ZP/aRyjHBe+PFhV33DvvmNPZjMPsXkEJ1W+cc1IHoT4f
 X9/g==
X-Gm-Message-State: AOJu0YxVJV1Q5/Vf22Rhrjyw0JcYzRK7/X6bq5n2Wh9wiAFlc8ZfBZ02
 BjOSY0XA/Bkm0dkEyxbDb8C22cxBnBpFRhyFgH2/4VdFUz6ppcNrJ6yaHgRhlPH6KJAq7Tmuu+w
 likfwTxnrPyQbOnabVggvg6GloxG2kG212Ep2QdOswbN25d9m0f31HTRcoICJdC6KjpiUtTumyW
 JOetHcFmIlH0fBlT/EQLN7pzmChSo=
X-Gm-Gg: AZuq6aLjxul9UGOP/n2ygA9v+oY7YFUgmszc6/i2b0MabWYJbM6rukJ536wussnRob4
 89UEk6cn09vJbrG5ezreCKDqKXMBin54hve/tZErNGBmR2m3zuhdUJuAFULbueZ2wXcUrSI8eA2
 NeKCo86iXWxS1pJGN6TyV0aBApkm2/C2VZm3ygzy3akdosEWP+qb0XPeNpB/7peHY9hwE=
X-Received: by 2002:a05:7301:5781:b0:2b7:12f8:5eea with SMTP id
 5a478bee46e88-2b73995e9b4mr1200373eec.9.1769147499173; 
 Thu, 22 Jan 2026 21:51:39 -0800 (PST)
X-Received: by 2002:a05:7301:5781:b0:2b7:12f8:5eea with SMTP id
 5a478bee46e88-2b73995e9b4mr1200364eec.9.1769147498732; Thu, 22 Jan 2026
 21:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20260122102210.87453-1-liwang@redhat.com>
 <9fd4c53c-219e-4e11-b25c-f43e7d378897@suse.de>
In-Reply-To: <9fd4c53c-219e-4e11-b25c-f43e7d378897@suse.de>
Date: Fri, 23 Jan 2026 13:51:26 +0800
X-Gm-Features: AZwV_QhfePxcSP13TRxMBu1LmcYFZmnRP0Nw62Ak4hwGy-HMpMtlr3QjClJ_W7M
Message-ID: <CAEemH2ffDEV9QRchjcYqGeY1xPyH_6A8zRGEqudeAf74qWFRmQ@mail.gmail.com>
To: Ricardo Branco <rbranco@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s4pONESzNgao0XyfXgP2iO7A2JHLc8uYo280QPGihYQ_1769147499
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd05: allow TCONF when UFFD-WP is
 unsupported
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: Christian Amann <camann@suse.com>, Ricardo Branco <rbranco@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo, Petr,

Thanks for reviewing the patch, but unfortunately it is not sufficient
for all kernels.

In newer pre-release testing, ioctl(UFFDIO_API) behaves differently when
UFFD write-protect is unsupported. For example, on RHEL10 it returns -1
(EINVAL), while on RHEL9 it returns 0.

I think we need an additional follow-up fix:
https://lists.linux.it/pipermail/ltp/2026-January/046268.html

--
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
