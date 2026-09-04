Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0973AC79F83
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788518741; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=HrBcFtbhjuyInl93Cg4Q81v83TvX8dn5/Oti7cyaNCs=;
 b=nS8WyikLlGLNGSXqpgJhPcEG636Wg7EdGNA4AhUTVI1Ws/UbMto+EWKSQNgI+6YAHQfDO
 VglKW218GJOqXcQQeh/BBM2U8R+3FE2k2lrjrkHnJv1WpmcboiKWYF3eN5mEKXcjorkrGGL
 HQdXiqg72E4y3zDtw5Kh6p2IZiVwpcU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9F683E974E
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:45:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C5063E27BB
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:45:21 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0921F100112D
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:45:21 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48589798dbbso495967f8f.3
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 03:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788518720; x=1789123520; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Uen65Qjfu3D2AhiX7xiXHHurZ0Z2+InwDxZ+6ALpUBE=;
 b=EZZrBwzVNEWsLz1YWCvjbt4raoL0g+A7fI/PgThQMgcLvMenlTY5tMcAX7p96mFqwe
 YL8wmcySXUs57LT/70fxgPjjhmspi58xGzlz8yDLNyb96EpAZHKgtn+NjGXpr46gg0ja
 h3+aiknP9y+oxH0mepgYGQSNMJE4X6eGAoue6eNwf2mV2LQtmOPwLyqBS2tz+94rUeGu
 1fgOIJJJrtFdwVoVP8NBiwsRIiVKYSjR9tIgY1ZgKEwblkl0OlrHuLRH2RK7vRMHvvTE
 nMePec3BjQEVMJT72gasRMF1Ecr9s7Y1ufv6FTzyrcnHmbaytegDtyXRKu94+str1EOJ
 M7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788518720; x=1789123520;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uen65Qjfu3D2AhiX7xiXHHurZ0Z2+InwDxZ+6ALpUBE=;
 b=PUS5jC8glrDNRfPY0WZOGrlPLYBRfFPfVH/tsgc9eoa+sreCVv5CctGj06UhESUCtA
 kXqJhvZbVJ2vOgu2VaItKhGhHd2vMCoooAWftjKJqCTBdwK6dS/eMNQKdSXtX8PQ9xAU
 /cMonHYXBjZbxbKuYhR1mA3altzUepG47gJvmhjr+VBiZS7PZHdAsTkYPiMz8/TLFWiV
 lAOhAgPVfBu7Dv2LvcoSPThmH49+B1UAcAe5vptkbueNfsGdCAkEF33Brybn8kZaw6YP
 ms9J9b6QbuAHBPC0CdRQoknt9icRO7IDISzaa13h0+paR7hDsaOMSwsTGJLZcGukdr5U
 t5rA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3KfXoAqwJRNXYQ5hrfyojQ7bYJ+ZxBLBf07yCVrSImDGoN+QC/ObDdpQzaSN232Zky/4=@lists.linux.it
X-Gm-Message-State: AFuF++mu/UZOZFyF5GG8Pj8sIwMpqe3T54IiSYC5vRC3jIBSTOIxfa27
 4AghdqDRWGjzeaP22LXbpQbN2A/d9NtO51+Gxqfgy7nilmuJfk+SBAbh6yehIQwi+/E=
X-Gm-Gg: AYBFou10c1hp984l2YB8xXfzzRt2Kez8CeNhOGDqT3eEsSr05VpzYuIw3xxFtMor3kb
 8HZ2xke/JE+gMURZ0aPgEH6feiF5nVHl3430AphLfh1SZllpWckIQhVletb95RH6BSABgKypsXz
 I89A0TKhKdtg7EUpWVzFDBWc/TlIdLpSwGYMhrMfbKldLqzYcEexuwpeNisSROeVosh0kKxmNth
 NTI6vouCy00TgRHkMtwaCohPXhtR93v2zodLQZUk8mJJM2k7dZ6//JUrGn+qq+iYOzIj6gTQwMe
 hWAQIzXYGr0OepC6w5ARiGEcXqPeb24ZqutZzRtmjbVqDGyQ2U701Me5PIE1tHzZL/evCSZuCgf
 o68R7wCDM0znO7ws2nUEd87G4K2lJfbbBHdzXdABOq33d9prlUf3UfayiKhEsaveyC8xK3t3Tno
 Y8x2O16mrpJNVuGZLQgZBjGUhq+jk3ShokAVWchkE0bNeDO0KreWHGsZlR03d+Lt7eO1+Kn6miy
 ZyuROoM8AFwcwiUpm2pdhQS
X-Received: by 2002:a05:6000:420f:b0:484:f26c:b9f3 with SMTP id
 ffacd0b85a97d-485872ebd4emr6710108f8f.28.1788518720369; 
 Fri, 04 Sep 2026 03:45:20 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm5631576f8f.1.2026.09.04.03.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 03:45:20 -0700 (PDT)
Message-ID: <6a9aa140.b2781ae3.d901d.f5f7@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260904104144.7749-1-linuxtestproject.agent@gmail.com>
Date: Fri, 04 Sep 2026 10:45:19 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Check minimal supported kernel version
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

> This exits with TWARN, contrary to the commit message's stated TCONF
> behavior. Use tst_brk(TCONF, ...) so unsupported kernels are reported as
> skipped configurations.

@Petr @Cyril @Li This can be fixed before merge if you agree with it.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
