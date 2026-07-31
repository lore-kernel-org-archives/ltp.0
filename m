Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CFBC54F54
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 16:50:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CDA23E71D7
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 18:50:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9ACD83E2958
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 18:49:44 +0200 (CEST)
Received: from mail-pj2-x0a.google.com (mail-pj2-x0a.google.com
 [IPv6:2607:f8b0:4864:39::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F32BC1A0034F
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 18:49:43 +0200 (CEST)
Received: by mail-pj2-x0a.google.com with SMTP id
 d9443c01a7336-2cf5e516e67so5746745ad.1
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785516582; x=1786121382; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lv1vdWBpeb6mHER1XdrtGbW7tl7wa/YGFyhD5jKKm4g=;
 b=C1NwlZkTfFXGL1q7c0J/YBLSowu+I6yWHZzF+KqYfBKTlAQlPz/4V9Dh07bFFZ8jCO
 zMTxQp8eeXSlJx4a3Pxq3Lw7FpBoRvsBV7bf/bxCMESPYeJx4uOON5cuxJ5rLqWthXTG
 3euam2sKKititbagt//yeULUfkZ1qZrfVIJIYHEAvnQcMvToPzSrPdtIg6ngR1yABKBG
 Bnz/Dub7ucfVCYfY3inkLUrvTKt6bKxfZ0oLixBScctdu+aBbvuE1PuBOsY1BqvlSLPj
 HYLipxlhFQs2DRJpUFzfQH3GmeUGcPbQMfuG6230bBPxnELx5gws2AyAVo7FEhNv93Qq
 qe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785516582; x=1786121382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lv1vdWBpeb6mHER1XdrtGbW7tl7wa/YGFyhD5jKKm4g=;
 b=nUBJgVBNkjieQjR1pX8JWTwtO6oqDvz7xQW1h3/NeReUdEW8JzzOGytlbSFApCgaQe
 B3RgN7ku+pVZ8f21d5QdqPz0FtHaNca5YbHuLUdeAz+yfqj0zalM+u0A8n8EkIu8UOBm
 dxJYB5pxVjbge7u/+i8ew8IToFb4LIsz2mvbckgerCbcwTuAZrJ9SWjHu1zc79ISCE2j
 c0gs2L4DwUN7s3ZdKf2FiyDwdpSwI3l7bldNzt51KRHNMjr7UWuVGH17CGcpk2ukks7b
 bt5u258RhdmY5f0lrKT4QqJ7s95qIZCtWsNk6vuh0QyNtdQi9FMMYZHkWSAZ3eiXFj1g
 ubnA==
X-Gm-Message-State: AOJu0YyA2R8pCJQDx3HycaNuMVL8DR7R0BwLV4hxojcOzg7P8lT1Eyej
 6TC7Mnp1uamWLXvp37hNNcBvBBWXKAmkOZ2uKYOKCTEef1kzKw29j5s7
X-Gm-Gg: AR+sD10GTdgGGLqRhhnUUxlaj3vtPNmE7kV+aLACUfZpuVbRxVWTIdlVpAFDXNiadJY
 seUp0enycCJEyayofATqtuZlWtTzIzJ8YFgrJBwMuKvFxqxqVLTmiR2dL2a7wMTL4Hnuurrq/x0
 dK3mmBJHfak6G7105zlpeVyL/idTgcwdbMSRcLC8sVYb/4m3dNttAerfU7jOutSK5tVz+bBD6GP
 dJAb1lU8ysHbCdMISY++a3a0OKxnktH5fXAbZaFwrK9fjgnID1Ax7okZl8+9WnZH8CrQes2f9ye
 hcZuHhVY5Ud6Ggg3HGxQv9pP2gz4lQLSHFCXygl58CTnqaoHwk0XnpZYcujcLljB5UTM8pmfxYz
 fgk9ebgpsJqRvlQvCgQEnJZEIX/HHv2PiVsLtPdKqAa5CUBAu/fyuWu+o3Kf85tg6sypY9SgTFO
 0Q7+5Or+ZLtFs7ojInsowt/KU/mutpcWYMVVkPPjAj7OOEEw++FpsUKFU4Jg8SsZ6eeS2QZ92Ym
 z9mKFyLIcdwqg9NT5ZkeA8ZRIDQihtbinQO50sJKp8WUWxyssL0yZTxMK46e0tX2ewP7FDyU0ZB
 r6K1UOb96g==
X-Received: by 2002:a17:902:e5cc:b0:2ca:e9dc:7357 with SMTP id
 d9443c01a7336-2d05221f824mr6909735ad.9.1785516581981; 
 Fri, 31 Jul 2026 09:49:41 -0700 (PDT)
Received: from
 runnervmvrwv9.rfdfcp0adv4ubaqtheixahij3f.xx.internal.cloudapp.net
 ([20.64.182.25]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04b15d26esm7700545ad.76.2026.07.31.09.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:49:41 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 31 Jul 2026 16:49:40 +0000
Message-ID: <20260731164940.8925-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731-cve-2026-64600-v4-1-8a222eca3a5d@suse.com>
References: <20260731-cve-2026-64600-v4-1-8a222eca3a5d@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve: reproducer for cve-2026-64600
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

Hi Andrea,

On July 31, 2026, Andrea Cervesato wrote:
> cve: reproducer for cve-2026-64600

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
