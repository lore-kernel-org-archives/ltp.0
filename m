Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F6D606A33B
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KODTq4Hu
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EA593EB426
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 23:35:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82A803C0960
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 23:35:18 +0100 (CET)
Received: from mail-pj2-x08.google.com (mail-pj2-x08.google.com
 [IPv6:2607:f8b0:4864:39::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 064DD1400B8F
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 23:35:18 +0100 (CET)
Received: by mail-pj2-x08.google.com with SMTP id
 98e67ed59e1d1-3adc0ac3566so872617a91.1
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 14:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794868516; x=1795473316; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i/rhVBBM79autC5afarknOC2CxLZr7OzaAbUlPLEgTI=;
 b=KODTq4HuIpk5UKrsKIg7TFk3Y4qXOF9Anqy88269/djAHR0CT3ugwl7q7aLEroHtgE
 PhH3TpOIcJDvwd+IyH536gdHSdVSiGND/IeATGQudVbgA3S8K8soe9ndPt64oYtT8cin
 RFK9CPtHqqewkVJIyL9qxck1hQfWpFKmt/Myx8m3kHwH7pydZiBL2ypIxdAzF1qT1u3N
 f0rdNhq8MUO73Fc0E8Vm11/pgYoh3jMXgLemH/ekbRg/M58DsVJe+6YeIUWmJJQZfH8R
 RSY7oouLu+Vxzxd3OD/Kxn305V/98pdc/7eK9Okov5zsZm6mpEgS6o6iHhDyyKUXR8La
 OnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794868516; x=1795473316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i/rhVBBM79autC5afarknOC2CxLZr7OzaAbUlPLEgTI=;
 b=bQrD4YfL1mlwMN6zTtdm9lcmOoN1oCBF7Rdl9HghjZDCd3VLvvegBneAvqgymkcxKz
 86+pSNX+iGjb3pDERO1YjpfNkz/fXwSc2PCLGKIiwhaidgvBCZO3gmIXyoUfempbYM5O
 Hyn1e7hzF90zAiFOaLBzaDA8EGoCO4AuSXFk19vLO/9RDZZczRkojJtneRjSobpdW1mU
 7kuAeUYZIkhabkQ3hNxEio2aw+NaJBisYT4Mr+/USsY6l/M0IVZQszy0oDZKCkmFLSjn
 dpMoZHENIwRK2NOzjmzOXUavESf5ScI4ectPhD9XGmXVTf6FC0l19KwZQ+1PKOWRzItI
 c+Gg==
X-Gm-Message-State: APuU4Z/Nb2a+dP35iNhyT1ma5NQmMj0SKZyFv0TmubI+IiaSQccLFEXu
 UR+2AXy/WeLPR9/kPAauQBWwGyX04phteOs3WnHNI4zycx5UP4JzdZX/46oUay5g
X-Gm-Gg: AZFdTZfTqu5kMgY4cistKwgEXxpGMnfTjc5geyxfa6RQ/blNNC8WHPzkfjwh88+l+nE
 DIypzu2oAn8dwXfKIK5oUx5esLA8mien9WC43XWSbcRCKYQhBG18tUhZYIIsh6lLxR5fTVLx6cT
 Kwgwrc1Nvd/qre8FOq4BlgSC8Jf9wpYJap38vwNy0AmF4ZYniGtIJnE9ihE70JdCOkIUeVF6aVr
 /yvuFCGZzEUiMmp5WRfj5X+9XdJhgxeeboc2ghChUrtTchiotjLVYQW6d1gC7+eIpKNDxgB50S3
 6CHs4Y7HY3/PTOpBYWTVgdjD7j4j4Plo62GFzQ4r0z5htI7YIa3X11vKszjXi0TJz2HRd5/kPP1
 wBKQ4Zhf/4bNW6BupN3pfh8oo/KflpvLfAu9nCoBTKlBJhoQcRyOsbZHytkI0Ag0NyKLOp049PR
 PUgeyv3d04g1lgBBAjHN7+CvUf0jaT8b1seEEBSdyBENT+sAxwjnXZFWGWj8HSa9GdzMFKcwOsw
 iKgUIRRh9dv26Qjsea9TzgPXwAEJ1AG7p0V6VI5I93yCoQTsdAab0VobNUgR+QIOrFK6eX31oek
 4Dxpyx5UbQoMqWsvM0+7dbU0CzSjXNcBxIf+35w8BAC4pitG/YjbgwRm25wLFWPmHT/+zWWZeYQ
 2knZ6osY/95MXGAc392Wl/r5yl+LaVWmzbOdiV5AU4jA=
X-Received: by 2002:a17:90b:5906:b0:3b0:934c:5e41 with SMTP id
 98e67ed59e1d1-3b1b0b4acecmr11162612a91.29.1794868516173; 
 Mon, 16 Nov 2026 14:35:16 -0800 (PST)
Received: from
 runnervmccnms.tpeq4opckxkudcgvnjlaud5nje.xx.internal.cloudapp.net
 ([20.120.230.197]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abbad610sm1019631a91.2.2026.11.16.14.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 14:35:15 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Mon, 16 Nov 2026 22:35:14 +0000
Message-ID: <20261116223514.4404-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116142240.3153725-2-wakel@google.com>
References: <20261116142240.3153725-2-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] msync04: Check smaps when the page frame number is not
 exposed
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

On Mon Nov 16 14:22:39 2026 +0000, Wake Liu <wakel@google.com> wrote:
> msync04: Check smaps when the page frame number is not exposed

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
