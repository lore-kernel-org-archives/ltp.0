Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7ADC5DF66
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 16:29:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A4BB3CB749
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 18:29:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B2313CB9F2
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 18:29:12 +0200 (CEST)
Received: from mail-qk2-x08.google.com (mail-qk2-x08.google.com
 [IPv6:2607:f8b0:4864:34::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A8EE8600782
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 18:29:11 +0200 (CEST)
Received: by mail-qk2-x08.google.com with SMTP id
 af79cd13be357-934a3e556b2so99834685a.1
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 09:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786984150; x=1787588950; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E+BkPnksMnJ8xDl/l5vJjB4u5xeo8R4bzgi2K3TcF8Y=;
 b=Rxy/hLUi2eyhNG0dqHGYCbvNQR/3Cln0NhGjTNgdo7ihiiQhqdkx0O+MrOWuq8gHzq
 Ctq1rZuf2Z27NmzNQFNcKIN544om8O8WnKnvXObK387h9U34cJnyAJUcog3bIbfpVACn
 DYFBe3SxNN81atYUIjXvIZ/l/v32KMYf1FUKXqv1w82yeyiNk6MrK8MCiy2SGlofYr+F
 87LoYLiYQLswHuTP4KdmW9Jcl0AphFwBBhBlhh7WJicpa/b3FepBouq+B2g/5v40AE6N
 9w1VW/kxuK/2KrieZM1USOiDJvhfsjXqRIgwiiVtmUf/dGJZ9Lkgdbbd8Or9K4Xh2xHo
 bxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786984150; x=1787588950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E+BkPnksMnJ8xDl/l5vJjB4u5xeo8R4bzgi2K3TcF8Y=;
 b=pjD+9U3TenGtizEVBtpt7QyIiFekLaEZXEZqsy2OwFsre4g6iGf0ztBZoa9mjkzxgO
 RFQoigE1rcrgshgEHkmZdVQA6+ErBbdoWki3Qoj9UK7bQIkuSqNP8zSghGCR4ZduX/A+
 dMbxZXUWAWqB4z9BC+ZuFJqexF6seIVfr/GQ1ttb262AwShr6lJGu21SpVAQI2CcvYSy
 Y2/CiHdYXhzWY/aiEk1k8yCNjllV07eqrviKmk00VwC5yDF3h2ki0OwDdu5DK2FnJfHE
 MO4kjodPJc5kFhuYzmCpJYex0Z1fdgwtRdLHKC5nnRMGO3u555cvPyK6WJi8TF3H/Nc8
 iN1Q==
X-Gm-Message-State: AOJu0Yyriad5ojPnBqg2TSuyYtqLL5novUUY6t2TbXSAO4fQoG9dNpTR
 BxYyhOtv1LH80Nmy0sFhvgy3WxNdUbqR7hyKkWKLvIazeYiPXVrn+4nZ
X-Gm-Gg: AR+sD121UtWuwgqfcLTI9O4j8VIaVgwXpqJ+ULPV7cuVwjqKHnkQYwGidUYEGJEgI7V
 9jFud524SXxYDKhXT9wG29+bQbndzLX2r73TsKtVpuu3MVivejovKrvs/EpRHY/is/Z6vaw46NJ
 /fi3wlWabXCyYLUhO/RE1EW13x40aW/ZvK9WQrHz4wC6z8Nj1+HqXUunLzoz9NYRIy0YX06Fbp+
 dO70IlNxqxE1XSC2N9RE+0SiIPTplunIljTVRosAqKLQGSQ0Fqi3FoeMYcFIGyFk0JwXVhfTZLN
 ZWr+8KynMgA1RCspvcpf4A1UE3vTiIE5Su817G2OpMoYrebHKFoKbshqZAyFb9/J8zl8S/nNi/F
 AKrs0wOT1eVndabHPT6Mr0/Ka4nMinprUXkWRXYIfkQZGh+MsSuZ96wZrzJP9o64hDUyOxPjgV9
 bNG6HL2We+l5T7AitH0CT9dR0QoDZDm1Xn6Ko/rjCR+dyjufJil2Lb+tKVAQhcPEhQzXTDinsUo
 XxPBy3tgmsI6yAxKPa+h2/PRq+WlmCwAg7eD/L5JM4k0/u8wpLgpe9M9Lm/p0qgO6P0JQXFCicr
 UGI=
X-Received: by 2002:a05:620a:701c:b0:936:dbf1:f495 with SMTP id
 af79cd13be357-93704b1ba0dmr210803885a.1.1786984150319; 
 Mon, 17 Aug 2026 09:29:10 -0700 (PDT)
Received: from
 runnervmzvulz.ol4x2y3psyue1kkbfce20tfene.bx.internal.cloudapp.net
 ([172.171.254.146]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-937034324d0sm84777585a.47.2026.08.17.09.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:29:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Mon, 17 Aug 2026 16:29:09 +0000
Message-ID: <20260817162909.8879-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817155701.943752-1-pavrampu@linux.ibm.com>
References: <20260817155701.943752-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/memcontrol05: add cgroup v2 task migration charge
 accounting test
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

Hi Pavithra,

On Mon, 17 Aug 2026, Pavithra wrote:
> memcg/memcontrol05: add cgroup v2 task migration charge accounting test

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
