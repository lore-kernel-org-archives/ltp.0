Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49609CDB471
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 12:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782302781; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=ZaIEeAd5rrycb63hApgPwI4AQ3t8ZQ1BdGLBcYnUFPa0OuUYJ5wjYRlJLv1zGasGhKlSl
 /Elm6JYwzbL2X/jBJ9oSINDeDeHktchHOr0/MrPxFaJlJG006tmAj5xpJZ+LEmY/DbdtDtu
 3iA79xDwuYybhBqOxRpvjOEVNqum3j0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D24B83E589B
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 14:06:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9EF73E2F1A
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:05:50 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8494B1A00930
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:05:50 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4629051c9d1so629035f8f.2
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 05:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782302750; x=1782907550; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=B93Ix0Gp8ZyIpMnBgmo54sX49tRgglCzwN6dFKe+6rYgJAyvce8JbEfjl29yzLd8tb
 d4IRWl1FGnKHY502mBuCsEmaMd109naxJgD8IiUMYsJSCqAxYwD6ivssLX3yDoznEtuw
 HR7aLNvP7eqplCdU5EkC+B0ji1/lgpfHYWz3ycpkoJXbtxamOoUN6kElnhafb5ramBF5
 aQ9LPsFrqB9AEtEQBoYKfNbz3ZsV8o6XQz9Yx9u0NuC/wF3wMurSaReHDDdoEZWyKi8X
 uxDdb0WnPbzFP+MJp3wpUHQJN1zTVKbSKKM1g/wiCepF86b5y3xzR0WSx42vMiGS+J+a
 6f4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782302750; x=1782907550;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=KNqANqcmJ96z5iOXURWEubJgrxnjZpHAc52bxqMgyeeS5wXJxBHOLrUaxp7eF3Zafl
 aPLDoUo4AZsn1AaSDpsuyuaVReitO0HrztqJhQdWoNIMskaBhLdnVquYJsbxvj6fOP22
 y9/Q4kP4/0w1Pbp/J9tx177ER6Xmp0WOLJCR8uoJacfaPjLS1o2U9XgN61X7QFT2isun
 ZECYCfFVY1aklXAn8bZWZcZcy4shXSu3gI9Aai7Gh7AlKj8J5g/eHePLgq0oSQTCWzGw
 T3Z7WQvZ5opOkyC0yMxi9NW0NTIofuGd18VvAUR/hIJJVsNBNkHsm3DtuFCC37C6jkgx
 AEmA==
X-Gm-Message-State: AOJu0YzMitelURiMxk4LA7WanWoUjJF2t10hPt0mjktGVPGYU22Hj2NI
 WJNY75+3SMGsOWtWKsSJ68yam9LkteXyIgFmh/K0DN07JmujOJ7AJXHdnxnxuryIkUQ=
X-Gm-Gg: AfdE7clCesIsteBlPpJ6XlVqpEkeTn1yBL+ZnC/OBtt5GCFKXc+3JNHSfz0NpklHh0N
 h1KABd/+F25NgG7KwTBm0B1ffbrljuIQFV/8oNWn0FWziaDhwj3i+Fbdz3HN4lSxGCUMCgpVnhU
 TYzoW3CIo93nyRvE0xvy+DYzD8pdABhFr8BbXHvV45DbbnWpPFGKKyK1yJgtJJLPZ74X2Wj5J/d
 74/XicwiTLW8D740VBtBaET66LwU8MsYw/Tjltc2/mzvr0YxvNWmTYFz4BPOONUMsZwcQme6FwQ
 TsI+QnvXYdorrhqGz953r8i7zq/kahk2W2MKAB0b4nCkXkHh9E+tUzG2GV0BRNxLIbFan9bQ9Cg
 kUwwNBOtUuzcLzyZeR6rpNXlSPA1BzkP+ZOCfOzt+10iv/SKkwAVhcmN2b4JRavFzqpal41bJYr
 LM2s1Vo5E9OinGJjSgfiUSFiaQkpT2d3lJx7iQS4gDm+rYSsJR3OaJowGgrZhLRQ==
X-Received: by 2002:a05:600c:4f93:b0:490:3f7a:108b with SMTP id
 5b1f17b1804b1-49260852341mr39414765e9.16.1782302749821; 
 Wed, 24 Jun 2026 05:05:49 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4924923392dsm717278925e9.2.2026.06.24.05.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:05:49 -0700 (PDT)
Message-ID: <6a3bc81d.51d65a57.6d346.43a2@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260624091900.4107041-12-chrubis@suse.cz>
Date: Wed, 24 Jun 2026 12:05:48 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 11/13] build: rules.mk: Fix HOST_MAKE_TARGET rule
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
