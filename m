Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8E9C79FB7
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 13:41:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6315B3E9331
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 15:41:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61FFC3CC9B1
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 15:40:52 +0200 (CEST)
Received: from mail-yx2-x08.google.com (mail-yx2-x08.google.com
 [IPv6:2607:f8b0:4864:41::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 76762201103
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 15:40:52 +0200 (CEST)
Received: by mail-yx2-x08.google.com with SMTP id
 956f58d0204a3-66d0f3138aeso2011932d50.0
 for <ltp@lists.linux.it>; Wed, 09 Sep 2026 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788961251; x=1789566051; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eWrOZq14zsePoxDsvP1kIKXcktlLeXULFIFlCmd9xKU=;
 b=UMIrFgQcDptRUjSuPK6MpOPq/w+cNM4gRZrODRp6FlVw/k9igC0U4AO9Q861lPg8Gq
 1CZObRLvygXoE4jkamM6+Bpf3QIuxP/QQRzUFL619re2gZtXeKlakCTYIls7gKSBjwH+
 OtmvChldo6/r45PCWYOCvDgD4juPV1PcVsCD2ko0YAFE4dvlWx9QztdWhjHk9UjCBpFv
 08RP1HcjyKWYlFgLWi6Vq4H/4l3urGP1+8Z6prrDVTBHapmEYgDW07lA+OF9TV1/g53K
 gCHfHWmhbNpOZGRYdQat6FY9IO7wejZcWXBVhhJV4ZEB/LyJskx6hNNYFgHeWBOW/BvN
 Htqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788961251; x=1789566051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eWrOZq14zsePoxDsvP1kIKXcktlLeXULFIFlCmd9xKU=;
 b=Swei6Nafl2jtmWlvPhbhrbXzlulLiJXTJYVUHKzCxqiT2TqbI1Nn/Cv5pC33IDUMpK
 xwhIQLytxwcl/fQk+lukojXmMFVdpju5WrGM/pUd8RoBCco4tLEwtIGtSWYcRKj6Lg5u
 FnZH8YLdbPFjTlr1S5TZUObSs9j0A5QXCmjN3oRqv5VwYKKHxzolsERZTV8sgM8UNysp
 gteIUudYq8dRdN8C1AuCkc4V29S94p9fXFpqjzFymJmwCsuKuZPPG27R8I5NjDbz+eu+
 9Wmw4BdAfabLtJjelIGnlIqHPohYW+jokK97jXEIXRjUereeRReOJ8tocncI6i7D0MmC
 V0ZQ==
X-Gm-Message-State: AFuF++n0NxQlU3b+WbzsL3bNjcWD95ia3oeYSq/iY4/7+mF11xXmPs1H
 n53f02+j/2lb4f+Jb6Ha9ClnxLgaKiUMhRsmbLFKg5dV0IqcmvJm+tct
X-Gm-Gg: AYBFou3AjE3vAcXd0KAZj7dtBqFi9wVgW2x93+KY1kld8ExxNXcITPdQfTOdY1FXQTg
 XEsa/q3LMDr9/pN6v2SsrgaF2Ee5bcd4qLDI+ahgxyllaWC65YeERgluypDQGjw8H1Iv3xo2eu5
 rIyb/D+Kmxc1WR9rZ4WozhAzni74blyKhNGT0yvANWxFlHbNv7UOpGKFoc6ZOvdgBweHTsI0zic
 Kq5/Y77OjitmNVReMia+hiDh16KgwM2H+D9gphX8Kgyg5XOjhXNp9iwN3vsDkrQNX6yoAlDosC4
 X7KrUI+zsqvoX43rfg7niNF8vbPaoViUvBAyj0ONJMOOV5Y9ETQjpku/kmsi09uCBrDJEqUouH2
 cEMVW4QFrkf6Grk6SWJ5+e4cv4gMg73CEm3zZHJFgVYNaPRuBxaKQ3PRw90RBr98d/ccfjJoGOJ
 xl9VJw3XiGikeWQa2Xry2h0BKG4K1e3klE/kcFAI1SN8+DuosrOkBQlGS0XpQgr+oI/a/CCuGcX
 jUvnOdmm12/26lsOImyXk4JagKAgMsbbLEuMdGQdV0dxH+7/xjsD05k/Tgu8yX24UpyE37TvzBW
 Apzo3L2KuOg=
X-Received: by 2002:a53:d14c:0:b0:66f:7f07:c1b6 with SMTP id
 956f58d0204a3-66fb5a1bc2cmr8779119d50.27.1788961251039; 
 Wed, 09 Sep 2026 06:40:51 -0700 (PDT)
Received: from
 runnervmejwal.evz1atmcliiexf3fmmiqzozgad.ex.internal.cloudapp.net
 ([64.236.201.57]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91171d3e8f4sm311926d6.46.2026.09.09.06.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 06:40:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed,  9 Sep 2026 13:40:49 +0000
Message-ID: <20260909134049.9899-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909-coredump-v10-1-0a25762cac77@suse.com>
References: <20260909-coredump-v10-1-0a25762cac77@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Add SAFE_FILE_VPRINTF()
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

On Wed Sep 9 14:07:15 2026 +0200, Andrea Cervesato wrote:
> lib: Add SAFE_FILE_VPRINTF()

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
