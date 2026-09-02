Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56038C624D0
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 08:28:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69D003E60EA
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 10:28:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 629233E29C0
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 10:28:05 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E5D701000A3E
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 10:28:04 +0200 (CEST)
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-cbedd5aece4so1541327a12.0
 for <ltp@lists.linux.it>; Wed, 02 Sep 2026 01:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788337683; x=1788942483; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/x6iL3Lug8Q71qgC/Dd32PGU6RVcrGCNCd1A5R83EXs=;
 b=XpRF/kDe/tNWHi8m7CtfX6RGawY29vQHefRTSarUReoAgjDlMWE3kHqv4Rev+Mlint
 mgA9VdFbyJj//ju+ngKmBGDxCH4eAt5Sscm6reiI6WufCY9SNlF08GGJsh5m6F4a7OUG
 6P/jPShB/Snx1T4NX1sT5CMx+KGh/XIjKZxZlKs9rmoMmqpnXRhmuWMkugjN0dJM/H+6
 gwEhzpB5eFl27/DgXGOZjz79M0Ndxbj3BLXev9m8iqdbxTlJmCbBWYsv1PWiasI3BHA1
 G7DyJgIywNdfn9iOiYEzEKdXpKgUF6hSkmMZJFxhg5SsD2PhI886xtHYyz3axBVQNejL
 KwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788337683; x=1788942483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/x6iL3Lug8Q71qgC/Dd32PGU6RVcrGCNCd1A5R83EXs=;
 b=nUwMnLTluL/X2NxUEmpgiHAGWYAQ/bt+I/FrfF+EiFHJnCVO77pKzRdpk64496KZa9
 gUbHYLbIq0X+IKRikEFaCKR5ztwbqlM3/gcG8yLVhbkKXaeWf7l2Fc6O2upXfgWZBAEy
 ZXlvB7LcrHcR0DAP1l82JwFa1+NA5RB7rgeeYbecC+xYsGkWm8gcpyz/3ocFtlRmTuZ+
 idRn4oxPIYzTDmn7bdxBuATRY6zJrXroISW+lfLaDQX28M4wYQAC0eGABHy54NPqkjna
 Z28PxBx15jJ50/bWtxmqQh06Hz6vgNUFEJ70dDGZI77K0tQ392ZItWNCobxSamGoU8so
 kdAg==
X-Gm-Message-State: AFuF++ksqEz0OY4jPNXbuh2VLrYCbId1ZYLg/tAy7fpahVVyS1Cl9lfq
 CyBLqFdrD2KuIClP1JGOYqzMxmqqRr69vSlRVZb6UvsrJz4x9KY28D9P
X-Gm-Gg: AYBFou0REq3U7UuMt0L3Fd+qMEjShhhkFFuF5ASVhnfTjU8S/Ss8TTV6ZV49w3x/Iui
 Nvn7mJPSPkvCTPc7XZfLfAkaouYChVDCVlItGPiI9GV2KwoiCWHJrGek1tm/CpfNHCD7ELNfFSR
 TVHspazi8pUk6i/jfn+B6XH+WKE8K9SqCxsqipkPLaK9F4irlU+afVYpGogmgRdhXm0d+Ry7RMm
 YiVgPrfHqJ3DqL7VBJHe8xwz6ioCt9tFmheG4qwKvQG80dswp7WOTpnz6TkEYsuPdrFXKBlpqqs
 2yHbYYRekk5GFRt2XQdHmQIDI191WIb7F0r+uIvVBDR1yAnA7Xp3YPbBsQVn/eAteey+4QzF+wA
 EWkJhGWIQkoczHCdcA4O7afWCMhEeZHRygME2eq55709d1DRK+7Z6h48faGnMuT6xmWpvm84d24
 lwKRDtKUY/aKiZmXaLopahb60/oiYBeYcANXDv1AbyPMMpSdhzvtEbz8sdeMktZetCwoQ/UO5tH
 bIGEDuRz4MNg88XAOeg+6gEOTNLVhBaWUXYwsnshJUDHQqTV/bXBDja/gJ1IzZMDGpqxUEgBJrF
 M2I=
X-Received: by 2002:a17:90b:4488:b0:38f:cfe2:fd3a with SMTP id
 98e67ed59e1d1-39af648a27dmr1544726a91.15.1788337683091; 
 Wed, 02 Sep 2026 01:28:03 -0700 (PDT)
Received: from
 runnervmgx7h7.csywkskczy5uzdr4uags05v2db.dx.internal.cloudapp.net
 ([172.184.166.100]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c6aa4sm4601483eec.5.2026.09.02.01.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 01:28:02 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed,  2 Sep 2026 08:28:01 +0000
Message-ID: <20260902082801.8757-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902025816.3915-1-wegao@suse.com>
References: <20260902025816.3915-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mmapstress06: Use memory.high in cgroup v2 to start
 swapping early
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

Hi Wei,

On Wed, 2 Sep 2026, Wei Gao wrote:
> mmapstress06: Use memory.high in cgroup v2 to start swapping early

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
