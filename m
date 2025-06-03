Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC5CC5AD49
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 08:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748941166; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=4e2PMUp7lWGxrcRAgfHCJ8K/I1VkjgbFAs3A03vk4mw=;
 b=aLgRfnVhL4sOXkGqUaoonbg/XJtiemDrPDcJot62/rh3yemsc2pWeTqUGmqGA/mi9yF9Z
 JjUTgpu0JNR4zu5vimk4+C8n91YyWjHJR6a6zWSXmyzGTewDLoMOgsnHimERX9LkAec5TGg
 TxzwSAuE5stiWlYi6hGYSc+//JAnCdg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 664953C9F78
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 10:59:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 115BA3C9F5C
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 10:59:04 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3D4D4600E2A
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 10:59:04 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so39292485e9.0
 for <ltp@lists.linux.it>; Tue, 03 Jun 2025 01:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748941144; x=1749545944; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hv8nLtxjlxWMLcZM43m9uZ686M5burgHc0z9ypRH+fs=;
 b=feyflRkTppAv/hfBj2qVeOn9rwDJOlWshxZg+CfJIA/Or7iNxmo/Sgb0UcCFBQd5eq
 clzx1KvQKnytnKbw9BKs4NYCqO86tZ51GUIULJd7ZVz1gSN79KhhdwsgjG5P8JCHENwO
 2sgp7jGMHNmd4kW7A2b4fWS8HLLDQlRLvaqorkkvq0TAN1wdJh4p1q4ZY3+OoL4h+MA2
 w4GQq/kemYV4s8mFfHGQH9jKEA3bNQeYYzRKZdoUD+2bXAlvkkt2V9kZdEttipQOBb96
 Rk0bFxUG5VzGBQwjO8SoviQFSOVIHYIt0Z4rhQCaJNP3VP/dPkb6ThiukqbMAOY7ETXG
 2Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748941144; x=1749545944;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hv8nLtxjlxWMLcZM43m9uZ686M5burgHc0z9ypRH+fs=;
 b=RIlb0Sb6qljsJOD64TxB0EaaYcZiobEjMJNofiiMStUI2m8nYEE3JAw2rQseQ+8u4I
 94aU/Gs2mrLP53CVkYTaIsCh2398y9BhkZojXfUEIzMCUqzIY2PeWe+oMFo5gYVycsYJ
 z/BIIPu+fFyopZG8yDAIYNqZTq5kEtWOcSJjRuwJ4+8l56YgQbKwsOAW23DAdq2u+QdX
 6UifeOz+OsEdu3J28OmCrKTisgwTSnpvKTTSxqEp7CmYSTKap43wM7xvELNY3U9p3pGK
 fs69gEEdsYDwemUgesMK3WyVVcP2Sm0aCTPb0/bf95vlQS0F90YA9GyiedDq9XeaGSSD
 aLlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU07X+ltM/a7/43YXi7DKnInGHti/7mobAFV2g5d8jNuOwA+/Gl3bSpW14k48AclPmRiLY=@lists.linux.it
X-Gm-Message-State: AOJu0YzS0ObT0TrgfVChl18zOb1oKfYCOscOeWVFXh7NzIzFqa5cAcKy
 2Qa8saW6Jl3req1Iin8jUtOYJS9NbGUwaFyr9TFNvvmGHxe0Ry+6TXwHnbhmB27HFwt8xDE/sfL
 6KJtF
X-Gm-Gg: ASbGncu1z1i78kH/E8+Pry8THMgxsPa2p/c7lw1/JHV4APuiQdDrf5Z6pV5CxUCkDhw
 S9xNvfZjdtXX5/hePhbP8/PH5jECbs2Qlb8e0YCbEWTb8qpKmCM2Z7yRHY9hCCFXqxbvkQ7kPTi
 SbLMizxtJugxq9ya4/6O2vhWbrLggZ3XHz+OcWFCrjNvrrtRYS4xRXBrO7vz7uGWY2ytNrAnOt4
 Ke0NQYyW2EA7XM2eLFwZRN2XXgIm/T3ntV2Rxw9crRmwgIbC03uZPxW7IxAV7DaCZ5N0DwGiftH
 d0JElX2liL4FEqxRo+fH1U3hoKo/m9BtME71JSMnAmiofSaPf/pwpP1Xkzdp+w==
X-Google-Smtp-Source: AGHT+IGZ1Z+u+ATvs+YRQD5abtD/20aW/ruaqZE5AEdfzzELZd6mLgB2HxNuogbqn6fNST9mThLhbg==
X-Received: by 2002:a05:600c:190c:b0:442:ccfa:18c with SMTP id
 5b1f17b1804b1-450d888d49bmr113064445e9.32.1748941143710; 
 Tue, 03 Jun 2025 01:59:03 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73fbcsm17448019f8f.48.2025.06.03.01.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 01:59:03 -0700 (PDT)
Message-ID: <142f1f78-8968-456d-8612-3a706f53ce8b@suse.com>
Date: Tue, 3 Jun 2025 10:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20250602155710.63165-1-mdoucha@suse.cz>
 <20250602155710.63165-2-mdoucha@suse.cz>
Content-Language: en-US
In-Reply-To: <20250602155710.63165-2-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] open12: Fix O_APPEND test case
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
