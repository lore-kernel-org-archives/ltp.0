Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C31C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 17:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783617257; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=pr0U4tzDBLk+pJH2Kssz1M+T3hl5077uCx6hZ3ZXW/1CTYYllI4zwOlXEd87FvZ1bRI0Q
 3Zzg8WYzkfAHOkn8xN4lBzvgZtdo0oy1OgHkSGVviiVKgp4arIcdxP8b7DlWT8mh3ureRfi
 QKL1C23OsC06AH2P52Hx5+xVsdb/oU4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC80D3E29C4
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 19:14:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 648FD3C036C
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 19:13:58 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C153C600A5A
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 19:13:57 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47c6e9a694bso68620f8f.1
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 10:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783617237; x=1784222037; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=fZG4xzFrqR9E+drxzMo0bxSlru0JABfjSNEsbPbFl25j/78fbCz/Ss0X/EYUhMYMwN
 z+Hwbr+R4w8EuzKgvSAy9I5wBQEhccu10VzoE4Qznq7M6VhC4nh+EGRYTlvZDAnc7xsr
 A0pys7F6RdIYosEcwRCIJ+Pf2PLAD8dKr0z/yuE9/BuRaHqfKObKpAB9yD40Mv3DBTjn
 u4gq5GtiCsohUE7Bpa1z310oiBFEir8C//W1W//uipWzSRTDoMLgke1191coQPI/KX/p
 KnLemdehOU4ZwwpZUEJWwLgEJGc1i8zmtHeSwypXUnTh1nqCUg+m30NYYfzBC1J3f+9E
 Thpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783617237; x=1784222037;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=gNX8FNkxguNE/jinIqe5UDycHNtNn0pJfEIPL4hMpN/AVY9eh9tDk+qqpsoFPwmHDd
 ZxSbgSako7fsVjQ2aOWqntiwYVSdpnea8d15v80hQigjUdbBPmtoBoL/SIlktSZtzsmX
 Khi06gihxejL2OOpTz8wd6f5ZRDpTuyKORiboYm2i/khyX6z2w/iWfcPMfdMV+iFz4OI
 zsxG987FxAvNKAzwnI/8/G7IWG0qXI+qlRIRvzFgBsvAJusAaWtL5UpN16OOSGiTQGLy
 U8WCGe/9nUPlnjhlULBxkJZvlnb6FWuMVBy5HFALVDAV2lxy37KqkTkJpF08LkT29Peh
 8KjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpe+nlOzax+c1QKXWH4vsCBrZ1045F8PVFFAgu//RebTa1+y1MjdM8yqoviyH3/a1FjznI=@lists.linux.it
X-Gm-Message-State: AOJu0YyJ4ghozSPErWSnW6N5coCW5bTCnr3fx8cRfiEt3cLUWFwXtQHO
 kNIb4jl7BVS2Nap8MDj1h84xo+cAwO6Gus2MKpMKpCG8U1UTKrjIa0zMcFVAac1Fvwq2baIvKh4
 yvuawxOg=
X-Gm-Gg: AfdE7cl+GjnesAnqaRNt9BmXhAXrGfh226w3kDQHMipr/lca2vkwv1s7MhKb8Edj3Sc
 CgcdQVS8BClEwS4rlgBl1EVqLfef25OTaGiuBham8maTMsoLo0U8mwh8xKEQ6pGix6hJ9geojM4
 m2CvjXqOzMhju7OyUKtt9PgVix/hy7QExCu80chryTooC6IpkkD9F+lQNgvH/8XRgFcyXM9eMgd
 5euZtYrsNaHz3oCcLX3C7M7jj1weHI3H1iS5cWj+yr+SScxESFWzgSBzIzJKZvYCp8ESXwLuSHz
 uqtQkfQkSrfwrKVUfv9hFFnjOYrSzlVIWcD1FNfTqltDUaxTOYiRiZzXBxYsli5u2fF/2/T1mrs
 n51fuO0JmMd2Q47o23P2QplNOOn1t/P6bZlQyST4sffFGxRRwHtF2GQrdhWHcVTLSZg9vvBNTaN
 3kiEp9pbQ2iFMMaCU+efp+VR+whHgMxKKN
X-Received: by 2002:a05:6000:2308:b0:46e:7f72:b702 with SMTP id
 ffacd0b85a97d-47df07c12e0mr8844746f8f.22.1783617237214; 
 Thu, 09 Jul 2026 10:13:57 -0700 (PDT)
Received: from localhost.localdomain ([37.162.206.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039bcdasm54977159f8f.21.2026.07.09.10.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 10:13:56 -0700 (PDT)
Message-ID: <6a4fd6d4.f7de3709.381bfd.026f@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <0603be3a-0bc9-426a-99c4-2b9d5df97ba9@suse.com>
Date: Thu, 09 Jul 2026 17:13:54 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] statx/statx04: Skip vfat and exfat filesystems
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
