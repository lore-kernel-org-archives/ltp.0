Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053ABC54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748343662; h=mime-version :
 date : message-id : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=4IRoJBtT6Tay13jgzX7DRZPeixS78Y9SlXW3njHAmi0=;
 b=c//h73zymsxHWqJGsJ5A9prMF46Df4xLQFIe3dyTySey7ykOsZQl1Bj3QrE4sPfnDMFJ/
 BHUoTebAgrXNHLsSbqGYqnmMwEmJEqEAU7EtgsX87hKRw47zMbSwd0X9LZMXSqp48scfdO5
 0O9G85Ik2R1zC8iSmwPEeH/xqyUjYck=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CE903C5837
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 13:01:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BBDE3C053B
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:00:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0292C1400353
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:00:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748343637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=ekjZbQsunigcezSmGLFsPWqNrIsr/e8d8flvfOkXZX8=;
 b=T+6677WocWeZHts9K7j9GGtN6Db0pi//9nrTxNhOj/NugvPXWQPHUKUKYWEv0G9rZWCams
 bmpKXj7Pz5LvDCtupbcdBlaDR4z0DY558EjqsuPV0CdEhDz8LWn/WVAY03axnHQhgd/1rI
 1syYe/6clSOfGD96N7OVM9f2Cvaa4hY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-woGK_PEGMA2PvbpVEUdLhQ-1; Tue, 27 May 2025 07:00:35 -0400
X-MC-Unique: woGK_PEGMA2PvbpVEUdLhQ-1
X-Mimecast-MFC-AGG-ID: woGK_PEGMA2PvbpVEUdLhQ_1748343634
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-af5310c1ac1so1809122a12.2
 for <ltp@lists.linux.it>; Tue, 27 May 2025 04:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748343633; x=1748948433;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ekjZbQsunigcezSmGLFsPWqNrIsr/e8d8flvfOkXZX8=;
 b=i+6NTafsnNHWHnmUvzQx2IP6E04W/zL5vO3Fx9hTRelFtL4NOPwc/B3p/ICdJ9bK5q
 HQ8mxXVGrswdij3HwgBvcu+lhFNvOmD6E3akY4OxSfEvktJjdmUAg9mrbQux4yOGrd4y
 nGFYFMVdQHXwzPX0eGBkomZSAKPt0zPhyV5UCzWuK5T6SrZLy4jrycncT1Ewrto6OxoS
 jwkm2I52jqk/F5m8VCwV5DsSbnwHq1wknBm+7/jDDkDrnsrLSQ9gt+eytd9KA+Ue1nHm
 kGhMEjpU59mx9rQJU/JU/CqLpHAJOedXjoAiY3Tuodaf55yujINMlUkjniwPNpW9ZpfF
 84vw==
X-Gm-Message-State: AOJu0YygmAlO1aVGDnqvPc9smw7Rjsb+hMH9cMorrjjD6MvMfAO5ihi4
 qqTgkOXiwaWLTAEiI15NGh8HuOvlP1/hGsvgKbdCUrWv4Nb1cTZGJR6PrBDS73KGsvzQ5x+qlfT
 +kM3+4pMbfeJA3xUEbcPFzRLnJoDS7akrCNOBDDOY2hOHmYmIPOJBR07qNN0NRR4kXd1I3l1gP4
 rP1nYg+1i5rjFfV2hJG4I+GacLM+Cl7N4MAefglw==
X-Gm-Gg: ASbGncuwoTqolPHpbgCnOKqo41zA/cTC97LZT132b4wK11hZ9ByB3vzssxaP7ZDP4fV
 MVOF5f2RXqEvj3EQImsMKc/8tQe/7GBJ8/mRPews6+yutvd2WVdUQZdWQGtwZ7d2uwSXClg==
X-Received: by 2002:a17:90b:3ec1:b0:30e:6a9d:d787 with SMTP id
 98e67ed59e1d1-3110f117bd4mr19410788a91.11.1748343633403; 
 Tue, 27 May 2025 04:00:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJwt0u/Jyc7DZ7yb9x10F7wNSEMQhe8lPjo4NRmTHaKf8e33zJwdkieZPgTMLb0GwIZKjN33tBYtIzWJUWMWQ=
X-Received: by 2002:a17:90b:3ec1:b0:30e:6a9d:d787 with SMTP id
 98e67ed59e1d1-3110f117bd4mr19410673a91.11.1748343632086; Tue, 27 May 2025
 04:00:32 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 27 May 2025 19:00:20 +0800
X-Gm-Features: AX0GCFshdvm_hiSQ1xP56arG8GuFiCBGR0XO5qznq9ZU34hErCaqDwmA3tvhJUw
Message-ID: <CAEemH2czcnak7S50--_nh5Z2Ou+rF0=5kvY7Kx_87k_X5eEj4g@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J61dElTJ349J30cCxdK0AGuOxQtvdikQp-fKF5wduD8_1748343634
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] Reduce .runtime for Long-Running Tests ?
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello All,

After reviewing some LTP HTML test reports, I noticed that the ten tests
alone take nearly 20 minutes to complete. For example:

--------------------
bind06           300.15s
msgstress01      180.44s
fsx22            170.47s
pty07            150.04s
pty06            150.02s
gf18             121.09s
gf17             120.82s
gf16             120.13s
dirtyc0w_shmem   120.11s
setsockopt07      76.47s

In total, running the full ltp-lite suite currently takes ~1h20m, which is a bit
long for CI or pre-merge validation pipelines.

I'm wondering whether all these .runtime values are truly necessary to reproduce
the intended issues (e.g., race conditions, fuzzing, sync timing issues).
Or if we could:
 - Set a lower threshold for .runtime on general-purpose stress/fuzz tests
 - Introduce a runtime _policy_ for different environments (e.g., fast
CI vs. full weekly runs)

It might be beneficial to revisit the .runtime values of long-running tests and
set a minimal yet effective duration that balances reproducibility with resource
efficiency. This could help save time and free up test resources earlier.

Any thoughts/comments would be appreciated.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
