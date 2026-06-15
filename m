Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD35CD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 14:39:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD5D53E5C2B
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 16:39:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D51BE3CD509
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 16:38:49 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 74F5D2002CA
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 16:38:49 +0200 (CEST)
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-51764768c36so48484921cf.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781534328; x=1782139128; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZSv5X62MAMbrgdFZqPjr7/o1ooHotasf77Qq5U+bI0=;
 b=awQ8ioOHBXFHl73+K9EHpGG3iXmwR9cjGnRg/0IJn6/pRtsYjhWkubyAumpdgeiz+7
 Ae/5XMrO0sJomQ96WfjcjT4R61vKsdtGtNAu2AhALo5YOkYm05VZrC/K3tcwN6l/g8a2
 hBuhBX6hDHWJ4VUjnp3ONrsMuCLsuerAx0PKSKqa5s20VBlAHh0mCaH6m8hy4khfMxN6
 cmDxA4E78geaW0Q4Ig/lN264jdokT4aXqLdyq+nVW4AJdZU8eemCBIpYUw8xPzvoIS1h
 XfIvhOiqsxzZcABRRty284G1ZN2vahyG18WDwx38LUfVJ+IUsa8tNdhtPANP8E9OwwM4
 TATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781534328; x=1782139128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2ZSv5X62MAMbrgdFZqPjr7/o1ooHotasf77Qq5U+bI0=;
 b=ZL8DQ734sZ7r7LT//hCxeJQ1DS3TYSaGxszenzaORRt4FYmgLQgC+pOM/ZRSgtXzFV
 Y/jTQCDbT3fgyNX9dxWw2z3Cd3ZLNhnI5sD8Kj5/eL+aT91Bz6X8VqSWFNrKN0jLhQB3
 G9YJIR5pLQClwN/qvtpcAFvCJQiL6f7rrPiYYd+5m6UAwV95eT2eqjtVSU6Pn9yJGOtR
 o4q7MH4OAdbo8gKkkraBjNrBA8MiGSwXffg1A01t/7/EzW5TffPlcxzU3sr+eea/k5tk
 uFffmBorKaK5qt9XgJn/THJw4fahCE5HEEemLZxpffz/+5I/debDIh0r/mFmesk6hLzk
 37Fg==
X-Gm-Message-State: AOJu0Yw2t2lO2tNOMyNTLTPLqrr/4NFYaHNjXQwjsv9KvLjj3LeZNRny
 28DMRKw0C2RqgCIcd6YvVUYODzmY+82Wmh0nUSByeJ+SwoHpbSQAaJnh
X-Gm-Gg: Acq92OElQYK0Ic2GCXmdgY6Zh7EzdDxZm708I21jcFUuXTtfkbwqcsa0+B08G0ipR5/
 4a+MVSqM1oyH0Tb5wsJ4uGHen1lsLexWu1fT2f7Rc3KMQCv/zTPHOTAxEEB2UavLPwDxFt/jwtv
 qDfltjMXltR/7Q9pTwt/IsilGCgZ1L/zrLlqkytB0qTQW71cfptq6uRgj3TqEzrlBvbqchMTJKn
 IOKVp5kLnGPzkSoQ1Gj7+hY3hDXnp1wBVBAUIjux50mnTW6Ddw/N0gg2mssC678mGnJguKPz8t7
 HDIErhuP8zXBueON4Q87ybAfqTMsLsOlIvXpfliAgFe0x6uIJsIqdcUqqK4gZCC+4XccW/yjzWT
 eNRjYQq84dpwW0UGfy8zTO2UIvJ9VUaLCrjd3fie/2kilYwG7gj23Bv0CBOJvt1avclM9sKny8r
 3hekMHVFF7TSeXS//QHCZQzIYRkuRLjCkb/UwjKS7oD6Rp7SSKY+J/fXydZVQg4IcM1p4jWvfBV
 OZMR3vqv74vcx1/ZizbE+lg88aOSV2LJcAJ7Cj1xg==
X-Received: by 2002:ac8:5a13:0:b0:517:9d3f:8fc with SMTP id
 d75a77b69052e-519534dbce2mr169156281cf.7.1781534328165; 
 Mon, 15 Jun 2026 07:38:48 -0700 (PDT)
Received: from
 runnervm1li68.uyrlpyg104benkpdkze3f00j5g.ex.internal.cloudapp.net
 ([135.232.208.114]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb642740sm109463371cf.7.2026.06.15.07.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 07:38:47 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 15 Jun 2026 14:38:46 +0000
Message-ID: <20260615143846.3986-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615142526.70655-1-mdoucha@suse.cz>
References: <20260615142526.70655-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: Remove pthread_detach_1-2
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

Hi Martin,

On Mon, 15 Jun 2026, Martin Doucha wrote:
> openposix: Remove pthread_detach_1-2

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
