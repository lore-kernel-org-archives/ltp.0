Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E02EC61DD3
	for <ltp@archiver.kernel.org>; Sat, 29 Aug 2026 03:34:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 926903CF807
	for <ltp@archiver.kernel.org>; Sat, 29 Aug 2026 05:33:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C263B3CF807
 for <ltp@lists.linux.it>; Sat, 29 Aug 2026 05:33:44 +0200 (CEST)
Received: from mail-oi2-x04.google.com (mail-oi2-x04.google.com
 [IPv6:2607:f8b0:4864:32::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 245801400436
 for <ltp@lists.linux.it>; Sat, 29 Aug 2026 05:33:44 +0200 (CEST)
Received: by mail-oi2-x04.google.com with SMTP id
 46e09a7af769-7f4e2118db8so586778a34.1
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 20:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787974422; x=1788579222; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y+FrwMcK1YIfYxEKzE78xA6gxq/JuQAOpKdz1frMm5c=;
 b=WFNkWwIN7VAeENC75rlx9b/cCajbYOq4C7QPR9ms5vcB29Jxx2lXgA0WEBFjwRlUwy
 IEyo6xrEr2rFPcgBK4EOJrkCI2MidCFksoS8bQlE/FfrA7pWgfEw0bMWCptfrDxlKF30
 QKQHxG/7XZ4uYzx9IGeF38dQ0Dg44CFvAnfzYZrnW4RHvkDmJaAoMX5UcRVsnBQCiOnQ
 1szgagJoZGsfegL0eKgkOI4Lonbh730aT+t7r3kjAs+N30g0K5nrVIWXNVErPz4cgMmY
 XYvI3FLDnZHau7xs6dE7IRA2XPQysiQRKlTubdGTw1IxVhdLwaEdF8f19ra6r0A2rKFu
 eKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787974422; x=1788579222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y+FrwMcK1YIfYxEKzE78xA6gxq/JuQAOpKdz1frMm5c=;
 b=L8IGc/ZLQi/Ak81pcTIAPKb0M+T6DxcdnHjE8PL7dre0LS3MwJ+JopqUSJ3MIjIl9X
 Jr/4u35rhsoN7JHTfdqjZw/qZiqqn9HIQ2VV7eT5v1NPw5S0cM6yZsDF6otBEblqx2Mo
 O/6yjb2Miw+K3DH7/aJ/kgeMmy6tIlnka0cs1VsiybOWhoki3b6VFbW6x2NdISSbO7bl
 sz9pocLl6YSFUUfxFlVro7QQqN/zeVQC6gLSsgWU/iCpxR7OSnkpOzyFxh+UZl3o9mZx
 a3aI03N5v8nzbFQWU9N/tO43lp6ezSQyWEguqwTaa7y0s+qMPueVibCmGaKjAht/iKpf
 pg6w==
X-Gm-Message-State: AFuF++kfWzK1Ly8g0zbAnglKGz0T1MdRNoaZofpRdqGtrV+80SytCNst
 j/W4pQ4rU+YBNSiVCIQ7Vkj/Ye7wjLE1Tih3dSJCgiBCr9D4+yGw4NCG
X-Gm-Gg: AR+sD13x6Q56/L1Tdnt8Wd+qfDxar6lcaKlbCpJ26NeYkC2xViibJqBqKyU0IX9u08b
 i1lZlV4dMRr33mACuaBOMH96HhMo4nKCR3befLi1/R+QUJTcCgT/ILYZH5hO94NgscN8Fa8WpRs
 vhggPrzpSiBB8D0xlhWpq+3ZNmTkDeulXwkw1LgvhKCneFOGOUhr2L8r4dIl8HC/d9XkyfwEuCS
 0HmTO4HHOxISOQrqJoKUhlxguAMcAEMRMOO24HWw8DwxIuXO+flnWwmDGll0AK3e9h34okF4fiR
 YBS+pQZOmouaecnEdAxNgwkj0o6r3Of/SPxwhX65Riwb/r0Qn9KhAcQ9l0XkWsaARwwbryfvkxq
 PaJNVwv3EIcuUI8oJBzvjdshtKrIko3ojRJPfi3CCiQb/Xrt+ZXstfhQsdnV1haCh7bO7wIUpVE
 MeZJL6VMwGRo6Myx/d6d3ZGSvIoA3jfdg4qk1jC0KnCSV2IsaDFzjWJgtoYV2QTAQBgDTIOF65Q
 GP+Ih7nYYKctonWAYEDLk3ybDDi0ElUAUGUXp9/RA0NqdIIGGBQfjGlNrB9UJwZolCeaOBfZT4H
X-Received: by 2002:a05:6820:3095:b0:6b1:65ad:3181 with SMTP id
 006d021491bc7-6b1c66d53ffmr12117454eaf.16.1787974422466; 
 Fri, 28 Aug 2026 20:33:42 -0700 (PDT)
Received: from
 runnervmgx7h7.uwzlcyryxkeuzosgxp3bao2qha.ex.internal.cloudapp.net
 ([172.183.91.49]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1ce290532sm3433550eaf.11.2026.08.28.20.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 20:33:42 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Sat, 29 Aug 2026 03:33:41 +0000
Message-ID: <20260829033341.8766-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828230924.2635548-1-wakel@google.com>
References: <20260828230924.2635548-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpufreq_intel: Check for per-CPU online file presence
 before reading
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

Hi Grzegorz,

On Aug 28, 2026, Grzegorz Jaszczyk wrote:
> cpufreq_intel: Check for per-CPU online file presence before reading

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
