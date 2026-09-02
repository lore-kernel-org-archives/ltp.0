Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1FAC61DFD
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 08:28:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55ABE3E5482
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 10:28:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68CFA3E29C0
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 10:28:33 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 17F2120008B
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 10:28:33 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-396d27bb2beso680799a91.0
 for <ltp@lists.linux.it>; Wed, 02 Sep 2026 01:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788337711; x=1788942511; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=voBwhISdK9NYv63VnagSb1A6a/U1ikKGkPnmcU68/sk=;
 b=gIoL1C8oytj24oFlOzVMH4FG84bfPLATOENV5OjjScx4ORIr/yScLxpWz7719JOe4V
 zwnVOQN6in31phVd9EnY5MSZCi9VVW2vrGCXGP3AcIu2O5xxCyUQsUMoXQhUFGix+cw2
 QXx/EGXCStyWVc2SO/UOkO+Ncz/qFfWsTU9aQRHtZY6eORSdYNzhdiw1v1OtEjW50ye5
 mI92ReJiLA1JpEZBSHoCEIItlP+4IB+hoHpwZ7OczHHcxyfNH2eXaAbgQaHmm6AhMoCq
 F5t+9YiH7wpXuReqY7BlWsqJeHoO4Fgl1Eld1ESTwilrXb8Kh+69Nv6zz/DHAUNl+vv4
 aSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788337711; x=1788942511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=voBwhISdK9NYv63VnagSb1A6a/U1ikKGkPnmcU68/sk=;
 b=ovfyqq0KWRf80bEMSe4mEyLA7bAiM/wm9glggQnecCsaPqfi8LRDvfIKRjNqC7K6M7
 qkYA74aerT9Gh9WeWqqDKClImAPc9P3+tRdJXcEE2oxaMUJvdLFTSeycFzFETak80KsG
 j+PLKKYALnuvQUUNRO0TSDVYO2vFc47FIeSXYMzG9TscmUxX3FCO3iL/wq4Gq6BsJVuO
 5tsf+43afo0FozCWBzkC9mDCtfICMoOi8tq8Wan4zuwI0MTPYJEceVGW4naBnweFSaG9
 3rzwdp4N/TkdpLyBdGG5vj2MG7wtbEqyOM34aOdXIrdrYJ8mICp2BgoqC39ZdUI/NpBf
 732g==
X-Gm-Message-State: AFuF++mp5a0ECEjEy3vMKRPgFWbojmNavNzPLNgzWuZkIuzxbUsQgNp/
 LObmVYglLs+YiG8/ViWjJsWhR2pHYgDPFhiu94QXlLfxNRk4FxEYY07H
X-Gm-Gg: AYBFou2X1kcTXRjpyP885ghxKObRRCgr85kfrcOgG551J4ZzSyEwphz2tI5RlPHQzF7
 ksJFj8+Pc3wkc0Ai+KU+zSufWhkyjx+WYTG1P1Kd65ZWwXmRe3UytXZO/pHB1RBx1fwczIcH0An
 +jFl+EmmEL8EWfVtkeMmr3bSdj54SZflDxr5f4du2b/HKV+fAAVOKdZdRZyxkJFKe68RWd+UJu8
 vTQRRAj/oHE6dtuuoW1zw7/ihkUbZU2zpyoGG7G3nnwRul1laRLdtXyzuuTpASIKZmwPGje1G6q
 +g3k5VNdgraGbkFUuWpngnwTZF0e/2Bu9pz9yedTzUwIkM/9AooKSrrZi8+QQJf6fgONGLM9zkh
 PXAwCxcyTYUU3rcKJnIZ0NNGLWcnOESI3BCjSF+LBQWmO6SnIGfsaCo+KGvFQgGOX0WPe3BvDwY
 8ZcBYdUH4DnU/ezdtpQa4c7uU8GzekMGYpBZ4xpLdWIb0JK2pDbRqCCbHdHE0d6skbXJMO/gSEY
 OP3C8k7hV8BAs4SU6AxyBFf6VGXezRiL6kDMv2KAYuXlTUWXJ/cLX3QvRGzCEDxIqRfQw1qUsg3
X-Received: by 2002:a17:90b:4a4b:b0:38e:70d5:b12d with SMTP id
 98e67ed59e1d1-39aedfd74f9mr4313266a91.6.1788337711228; 
 Wed, 02 Sep 2026 01:28:31 -0700 (PDT)
Received: from
 runnervmgx7h7.rbsguloswegutosmy3ail22bod.phxx.internal.cloudapp.net
 ([134.33.70.55]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1430e9eb4dasm7672501c88.2.2026.09.02.01.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 01:28:30 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Wed,  2 Sep 2026 08:28:29 +0000
Message-ID: <20260902082829.8668-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902075156.240295-1-pavrampu@linux.ibm.com>
References: <20260902075156.240295-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota
 accounting
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

On Wed, 2 Sep 2026, Pavithra wrote:
> hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota accounting

> static struct tcase {
> 	void (*fn)(unsigned long, int);

Both callback parameters need names. `make check-hugemmap33` reports
warnings here, so name them `size` and `mmap_flags`.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
