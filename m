Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA92606A324
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SPwlGYOC
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 830543EB542
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 16:45:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18D683EB386
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 05:08:23 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8B69E100049E
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 05:08:23 +0100 (CET)
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-53653e30353so37065271cf.2
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 20:08:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794370102; cv=none;
 d=google.com; s=arc-20260327;
 b=T8gcO7w37V5lzmsBAFFZjpugGR3UODgsrz8Q8ZYsYmE3qLpkiznRqf5S9LnPXP/RgI
 9094nBAI1s5UKuS8kgNltc0UvbgT/iUuJ1ubFjLnk1rXGv+VeGIaw4reoGO25lUqJBFS
 tOPlz22zSnfeYhmdng8EyJXtDQ4bLT2jf+XBGpu+mn8DkVajMkpC6LSwlUTd2NxA+dx3
 9fhzzw/lQae4TRlkdKL5VtPnFBeTKbZiELo8E1CJ2LNGJft+YHVIEDSTVO/A+pUNIz4y
 C2c2dvsEzCUY0GcFKglWqTgkVFyA/+GQEfGLj201rOUxdqtKaUngCn6h2o5YpS+ZZjN4
 UpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=wMyEFzJd3xwnk8kws4Nor30piYysMvmCTdzdfQ5mFAo=;
 fh=TeX3Xz+8rLDoNZqT2LzwOC1od1RVZasJhPrcd1MjXeU=;
 b=Dvv8WFoVuq/PmPZRIc93G07OmZDT6g1G7HQxJspRnmaKfB+7isGx1bzPnPyVsnvFBo
 3aizGsti7pzDbrNCywhthAivmXC6oJgSRFGivHhwiFhFF1ABoO/3pW6fBUumKRDk5/Uk
 kQ3tGg2zmkEHkRbpU2uNOQkd0VEVb5MTBleSgONPEoSpb3FmXozIxweQG5rmSWwADdKh
 tHAUltv5P6nwoTiGzfzZY1KhKO1Spqq4br2tu3hwZ2A1AJ9A/W7/DDasecXi4Ry3jjGC
 kGKW4v0BWQnBq/dmc6ruHp/eSxNXCsh0e0orC88YcyB6pRbKoE51YlUjlJSbEgvfZPp6
 CfbA==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794370102; x=1794974902; darn=lists.linux.it;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wMyEFzJd3xwnk8kws4Nor30piYysMvmCTdzdfQ5mFAo=;
 b=SPwlGYOCYRDqcXOHCtTjnbt4OW9Q2TQIHmR7KxWIgwQDp8GnLtGTIBfdj4bTZeigKu
 Nfwui23CwS74Ma+SAZcNfW5nBETBKp3W5cFRLgaBdiq7tirGDM6xBmOU4HIHZmy4I0ZP
 i30TIgtpSadORH69f3DiHA5FKTe1DlLS3d3Wuh4iJhy6ntGxl6scpG1/1lLqXV/jCfVB
 qSiaMVBka7iZwUe+ABgcdiltKrzb7bp7pPyaOftLmNv2wijagXzbI7Ukbkvv15nHVIM+
 PMrQFkyZCWy47+o7zHDm0xIWEjaC0WMhWzkbSj9V3Ks6vVNwroOP9bcCcji+IKInYNkH
 aF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794370102; x=1794974902;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wMyEFzJd3xwnk8kws4Nor30piYysMvmCTdzdfQ5mFAo=;
 b=2yFg5AlAUTxQ7+5gE0qR7dc5r2Dl4iyqfPLLGblswvXhCrOKTjjHwdvaqrQPUpggGh
 6J5hk/T4yQlZYxQ5xv8d5zBcxfQ0YLIWsKlbRT3GJOcRplDEfyoTm+xmWWNKa9NEMFsB
 fSBSXScm1ox8C17qb+MxXoczMXaPqnGcKmdTBKMHylya70z+cB794kQ0Hqy3QfF+Ov+n
 Q8wVT4mt1FVZH9kSHyUp+n+UnubW+qRZPyQmFuL+IQSnoBn958mwqK3UKHEZIfiSlzoX
 nVs5gYlpNCL6hygJ4hN02fHTdLZBVgBv0/Cj5KdGy0qlPyjk4yxWls5Q12dYGWsWHXwD
 QLBQ==
X-Gm-Message-State: APuU4Z/VaYDBYht98tvNuiMLOadaX29fgawJ2E0NNwySDJhJtwA6g5oI
 g6++DS4ikCahETzf6dYh7q+Fed66VzH6wYL1mKtWEhMXy0pGk7cJHPN+sQIZS+q+szdepzDcNDF
 vKJvteSyud9viz7/Fphbwy1z4Kvnub+MSMUepFc4=
X-Gm-Gg: AYBFou0xWGQzFeLfssz3je1wvsgV2yw/5pWurUAVvNxHQ9slKYvsZ3Jmr8C+Bh97U5w
 ZR1bR6VMzr95vtmnHwxVWcvpEEbYqz0woo7x80Q5V1WB8GI+qLeYVVp3NoiX9GfACzZtEtGljlO
 jrV8TyEC6XsMQDrvm9fxPlQhp6pTQAmcgnYIRxIH+qLOuWVK3oQ12Ad35IILxEnrc5ceZczR2RJ
 vWVJpFMGe1Bq5wd1ApDBzNlGxdg2L17L0gQhmQGOb2RLvt130ORWUILE/S+ZREbQpgpodvSYmNf
 e7LBZ3bhD+swjW2M6TzEbdXNZWrmiUy9mngOeK6P5+0qWOJIxD6ijwHP/Eewh6ZDQTe0tJgROCr
 BzgQsa9xg9f3Wi8cqNoZKsxf0CVsVi8jGjVA=
X-Received: by 2002:ac8:5fc5:0:b0:535:e0d5:f3ac with SMTP id
 d75a77b69052e-556c1196b2bmr16287521cf.54.1794370102213; Tue, 10 Nov 2026
 20:08:22 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Tue, 10 Nov 2026 20:08:20 -0800
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Tue, 10 Nov 2026 20:06:23 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Hristos Nenkov <nenkov2004@gmail.com>
Date: Tue, 10 Nov 2026 20:08:20 -0800
X-Gm-Features: AclHuK_x1iRRteq1T_3tLyv_f12OBCNTE4s8UdXVRag8VXwvgZp9YHS2Oz4qEC0
Message-ID: <CAO7_G+wYCDjBpia5UbAJc52v1Rn9uRKoLn=UHhg_U4bs=UYeDA@mail.gmail.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 11 Nov 2026 16:45:35 +0100
Subject: [LTP] [RFC] Proposed scope for replacing FTP/HTTP stress tests
 (#1207)
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

I would like to contribute a replacement for the FTP/HTTP stress tests
described in issue #1207:
https://github.com/linux-test-project/ltp/issues/1207

Before implementing the full replacement, could you confirm whether
someone is already working on it, and whether the following direction
is appropriate?

I propose a separate TCP bulk-transfer tool integrated with the
current LTP API and tst_net.sh, covering upload and download, a large
single transfer, and bounded concurrent transfers for a configurable
duration. Data would be generated and checked in fixed-size buffers
using position-dependent patterns, without creating multi-gigabyte
files. Both IPv4 and IPv6, partial I/O, deadlines and owned-process
cleanup would be covered. Legacy test removal would follow only after
the replacement coverage is demonstrated.

Would you prefer this standalone approach, as suggested in the earlier
discussion, or extending netstress instead? Are the existing
transfer-size and duration settings important compatibility
requirements?

Separately, I have an AI-assisted local prototype adding opt-in TCP
reply validation to netstress. It has built on Ubuntu/WSL and passed
11 isolated receive checks and 8 loopback client checks across
IPv4/IPv6. Those results apply only to that prototype, not the
proposed bulk-transfer replacement. No patch is attached; I have read
the project's guidance on AI-generated changes and understand that
independent review and validation are required before any submission.

Thank you,
Hristos Nenkov

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
