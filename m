Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4049BC44506
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 08:32:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2B2B3E2EA9
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 10:32:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D8803E2793
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:31:53 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D9B7F1000A37
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:31:52 +0200 (CEST)
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-902e4af2d9dso2595076d6.0
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 01:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783672311; x=1784277111; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bWBsdcqyHT1pDBWZNrTrh6VD8Z7vYO/56/USi+FKMC8=;
 b=NAW0jzYUHKr/OxX4SIudVva4+D499NKlBbW3IQUlbSbnph+E82afL6+tDgTnZdJGhZ
 zF2lAokwYbCDqqeSvCIPS5tWw90GsUA4lDwGiZkzEMlQm7U/dA5C3OWz8hWeruur1HOx
 kYYFdnMW36J3JmwoIYgTgJhzdGwhLOGPvck8Wi4/Fx00WWfEmCI1CkdFRq5FvOyka8og
 +Eo15wXQL3vfECwsWOKXtqq2Ac82icVVKKu6g//UuLYaq0rLBB+i8P0sHDgNm9s1wxKA
 WVime+Z4yNuXTEum+kKy9Pidhm1Lw8tYuh+T8O84d3HoH8H3vPxS5QSkWQZBv/uAYel7
 kJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783672311; x=1784277111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bWBsdcqyHT1pDBWZNrTrh6VD8Z7vYO/56/USi+FKMC8=;
 b=aBLyh3KbrG+NfcWeSxCHhOlo/lIkKg8NHV5eqeDNKCREnadsvs0jW1SPzzdKsra+DR
 EMM8xu+BmxcLJHHiJ/ViPRs2e0TXve17fbsCUgCqc1E5XmPSyJmm9cNhuM50hsbF0HIi
 qoBOuoDdUkA2uTskVBO2Evn9MRRdr+nJAqQNbD7fIobDR3JGZcBgDv/hnv5xWz4DTpug
 8/KjZzas+cJXbLpKqu7ksCSBHEGmA6p3U0/PCRam7k7T5pazdxOzszbXqOieAtKVGy5L
 1wyzZjAcGIBQDMZbqEqtpZqFJYtXiJQipW3i+FeHfAErKkUkXfW5Y1/JPizbRFY+b/qb
 nQaA==
X-Gm-Message-State: AOJu0YzrYLZdEtFL0ZWTn6KgA+RWYZ89n+TtlR84qp9tHoBmd2EjMHd1
 ynHqo+eCaVEOP8n3l1/Rrq2rnVKfODT+DTU6bm2i7E1UB5PiC2XpmT02hA6t0Ura
X-Gm-Gg: AfdE7clBBHqSFC8VyaIkhoUax/ni8iJfzuVZm9n6wFaZnI1oFZ6eqXapNx4YEXzq9og
 6C2d7+gKCZXX7F6Ra3jKvS5Cdoq5UPeoog91W6OmhyX2Enw2iZFmmBa6p+KCKfsnwq4R+CSAy2w
 CDPtB4+fwdt2mWzywujybRLwTDIhMDfreNYBtAvscQ8aBt45UFfCS8nmxx8KAvrC0AQBf+kwdaE
 R0wwPAG2YqVDVvznWs5+LN91laYTZDT1cYRyfWRZuhzFbQLfl6wfQ09xVFlsejWXUHe3Y3X7ILY
 SF4GkGFqqDZKzv4QTA1H32+C0og0gotoJrO0tm71P0QygYEAkSbn1DeK5k3dP6EDy5FeP3zY7iu
 KKeErqldjLeIhKW4hvmov/cNUMRYY+DLM4ajGs6MC5h7UXAqfqY0G8Di+b2tliAUKj/Rcs8bbRU
 WZDUfkdbz0aMmp+zjRhdLT9qFl7ZA5Oj7IDF4/i2tWHTQwMFwMv6POf2EIW4plMbE8vrDwx7L6E
 Lhhk4j7QXcOhO9vKRF/WZ3YUsUIqUK5dHC6Fg==
X-Received: by 2002:a05:6214:610a:b0:8f3:ae0d:c315 with SMTP id
 6a1803df08f44-90234591918mr20946316d6.4.1783672311664; 
 Fri, 10 Jul 2026 01:31:51 -0700 (PDT)
Received: from
 runnervm5mmn9.b2snqolw0euelb3mofnhwwxadc.bx.internal.cloudapp.net
 ([4.246.135.35]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd56c4b78sm36500296d6.18.2026.07.10.01.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 01:31:51 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Fri, 10 Jul 2026 08:31:50 +0000
Message-ID: <20260710083150.4126-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710051323.26430-1-wegao@suse.com>
References: <20260710051323.26430-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] connect03: New test case for EPROTOTYPE and EACCES errors
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

On Fri, 10 Jul 2026 05:13:11 +0000, Wei Gao wrote:
> connect03: New test case for EPROTOTYPE and EACCES errors

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
