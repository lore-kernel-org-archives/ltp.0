Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A1AC79F9F
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 12:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789041984; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=PH+V+kBTMG0fkvgwny0nGMYXGrM3LyMlGcuonlDJSgQ=;
 b=MR8uuQGpqjqb3UfYhhg4BxOWDXsyLtM/5KsFm9EagU1YMd/Is1laqJAiOmCrGx8o6/+v2
 l/ez5O+5g7/szAOUuwQnpt4SJG8K5GUcE0bHjMSJ4PPAOOeNJ9p7iXv/yiY0M0xXcIHgGYd
 TIs1qaamRGsBPSjh86cPui62xDR3opI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BE973E9277
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 14:06:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C43B23C18A4
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 14:06:03 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6C6B11A0092A
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 14:06:02 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so13751825e9.1
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 05:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789041962; x=1789646762; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ywtzwDvs5ZYsU24xBOeH3kuhzXzfDvkIuJPEYwGFI1s=;
 b=D/Wy6UHWFWAXr3+cROXQGYytsZId56i4Wb+f7HY4zsk80Om/RK9wQQv4K9vrMO+hRb
 ngZScEOyWuvdAiju+jypdI+BJYF0p/Xe2T9mJXnrCSwdSEvDi+Xb05fYw9eupX0qQUiX
 vD1Gjpyl8NCjgCCOU/00ZfxrCalQm8pr6J9ZFOd3eHElRXmmxOHP/48mhazSpV27wCkG
 WqnBxAKRwBAy0rcWgJuNSQ27trlZ5MhJIz9C8ItxesiatcIVB3jx/ODRNqEd03nKtXol
 tVbR+jUkpeylANj0Zb1Ot8U4IiXFzmp7dAzKja+f0egmth6Efx6wk1uBS0p5D9GVYWke
 G1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789041962; x=1789646762;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ywtzwDvs5ZYsU24xBOeH3kuhzXzfDvkIuJPEYwGFI1s=;
 b=Bbvn2/mrwgLURuocqkYKGMvJH0QtHMeDUEJ61Iy6lQWdWrSOcbFu9+1O4CQqGcU9ZJ
 9ITv/pFEFMDrKONmKMqGX8a7g8AoGijElHnn586JUOHmhhCZ246G4eVJfGvaro9E8tLR
 oTaRlRdCBzN5CxC2xuiFNiSO/fTJHF2+fEhJmFqmpIGrILaDIbci3J+c+dWAz8l6xtza
 GiJ9Noi/k1HWp8nK/Aa6beGmEJXQdO/6iSmOyihSq7cNWZzHliOOop+LXq4LGjsgTiTQ
 NmPIkivuHm1FeM5zoeRoA0qPGszOUDDuEadJQ5QJvafz4nG8WhtkxEi4V6mtzwcgzlgJ
 4+WA==
X-Forwarded-Encrypted: i=1;
 AKwUvByfFt7bHfaAGt6zoSXeVqjEEL/I6XH9la332GQWQA3RUvFcbvXeWh/TAkhraXPSgDVEFwE=@lists.linux.it
X-Gm-Message-State: AFuF++kOPHM7Zh4ADCcOpnSiKrLAbP9TmQU+JOkEvrkhCsase02oL/0p
 8mW+FC7RGchlGbjXngDtFq4+NuzdRH579MjjFEY8D/ZPBko77ajs2E/PHmU8+uK012g=
X-Gm-Gg: AYBFou2ViGJRwmVdFojU1JAHCKguoHumOK3CmyWMcqHQeiLXAgzYdsGSL1NNryZgpgM
 1nDFIKA8n8US7+adNvDXVCSVnH897tb0gwLBcYl7Qh0j8za2p6NDyRt1NqNgYjIsZT0meQKjlfQ
 Y2Q/j6QXo1Y4WNwB7V00gLG7CDpEZL74t7SuEBSm0i07O5JdHAZiDjZgFdYXxfWPMAjKkL3K1jf
 xaoxS5/Cc9LQbXC9uE7HJtYzY5sZPrkBgV4KSPkA5L7Tyyep9o2WcuMqE0u7uyl8FfFfJAhCZGC
 KehJzmb4QoF7gBKesZVfamytrwq/q5XXcYhNQbZn1VzFflbpZ+bWNCATtS9dll9wmjPSmNt11+4
 x9M+u7EPyGWUiJiVdu6oBv8ElgbgWTOxg/EK7u9z+IZDt8YMpBwy/Lf6zxYIR/Lh0mKMQG+lOBX
 JLhnV2zeOO1e5DCbKOULuZHNHVEK09upY1pwJQliRgdqfCh4X8neDAxJfkWY7SRfgkaQJoQEcAW
 q3/q0SBXQW6pnukBhc5JL/lOIGSshON+KCztrPFPkBCsMI=
X-Received: by 2002:a05:600c:8b74:b0:49d:2555:1a6d with SMTP id
 5b1f17b1804b1-49d25551fc4mr147291165e9.16.1789041961560; 
 Thu, 10 Sep 2026 05:06:01 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e2212193esm32920925e9.1.2026.09.10.05.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 05:06:01 -0700 (PDT)
Message-ID: <6aa29d29.e9131222.16a472.fd70@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260910085649.GA1384688@pevik>
Date: Thu, 10 Sep 2026 12:06:00 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kirk: upgrade version to 4.2.0
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> Although it's not ideal, I'd consider either delete the current v4.2.0 tag and
> point it to e65b84ba00de6e5b6bdb63d5259490d7f9d460b8 or at least add new tag
> v4.2.0-fixed which would point to e65b84ba00de6e5b6bdb63d5259490d7f9d460b8.

Merged with the fixed version

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
