Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975D2606D833
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WinGbuGq
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23DEE3CD0CF
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 19:57:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CF663C2026
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 19:56:52 +0100 (CET)
Received: from mail-pz2-x03.google.com (mail-pz2-x03.google.com
 [IPv6:2607:f8b0:4864:3b::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CD47D2005C3
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 19:56:51 +0100 (CET)
Received: by mail-pz2-x03.google.com with SMTP id
 41be03b00d2f7-cd5f0803c1eso366015a12.1
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 10:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793818610; x=1794423410; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=39pXN4bDEPxNNe8e++fkUa/rt8P6eYCWz/l5AUI0HlU=;
 b=WinGbuGqsZwVv85aHNua+gqBAxDNiMtNgWEkn4LytTw6btg1IzbGbYjMGE0epTeuCJ
 iIyfCFHsVYiB+dJ1jK06SEclBzsdA7llt/hK/ssZSfMg4i9wVAE4nKLKqhahWTcO79+H
 aqCqzV9f8roaigLSrYHX8O6jmqySeJsUyZcbHIk+/NgTeiLgekd8gW+yIipZmCjfyTxY
 lxV9/7Q4zwRRrfpgMfXjAENhRfT+FZnRkL32lfoatvTceiu/9O4yKSyzezdGaXFCAWKD
 8Gew2T7yHd+P25nLw6gb/vb0VynQ+/0IH0xSxqNYFnecqfV64zKWS5x8rON4wlphglgk
 HN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793818610; x=1794423410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=39pXN4bDEPxNNe8e++fkUa/rt8P6eYCWz/l5AUI0HlU=;
 b=cfV/9x8UQZiyuSpbI5IuUop8P3wL2VhKbSBuitDnaYLgjc+m2QoRhsqIhtcXzDBSdX
 q+gbkZ6xkaqfpVSwQQfU9CKyt9Mxp71swxgbHWTqNnoamZrswXU1sdhPrV0UmIePIOSV
 492j55zpvTaEmWHunZKNLb0mjxcEM6V96ie7K3QsX84yizGHDAZd8e3IkJw2ccCpVXG2
 8T/qbR+IvhENrKgG8PjSYOPfw1PEzhgZqBO1GKSfLGMcTHMaRVKLz2iqCZwTOdXa1PbB
 dch67ym3UsfHHl9UnewO2dEQurWwrsACyX11MO+3SJmndSpiZh+1jySgtXYwX3a8Tqh5
 qhJw==
X-Gm-Message-State: APuU4Z+APVKVb4JJhOuwopiJuIS/8V5viRibQSRfCqhZBfPvGWr2LsWx
 nzfBIIWABmXfWe0S+A0p7g6hKKT3Pxo9VM+gRPdTktj9lG63xt3X3arI
X-Gm-Gg: AYBFou1LRyQAM3XixQtH8GywtIZLO1Vq9aM1cfR7mJ0oo/DvjueAY/jvyHoQZLb/HGT
 dynH4hiVpsRBATBqpoTySdQSX29Wcdps9iQVZAd+RwPbHiaaQLjQVCl2i+ylmBFXTLVfRmxsEnZ
 C3xMagtOKlziQvxHGnVs4M6bRkxKv1T0hkqH4kbnVCxEeLtCPfXF3BUw1thZDg8i1YscpbS2p7o
 zUSed11PvbF17Tt/lJSatGFDpC4Umicohqcqz8LLVZ5yLBhDF9Hnz21b6HKYf8KN/dk5NUqy2a7
 mOn01NsM0M6qQG+rwOyxegZsroC6n35kZy6onHA5ESdHVGhxC8xV+WeW1Txqsz1HrF8maxVOjk0
 GETeVevpWzHfxh4V16XkOj2AOqe8RYBYTLH+RlvdRDtgpBHD6wsOebW7Mzxrr5asTT6/67+q5ly
 xX/+Gj+qzxPHmNC1iUwU08K5ZDPMb0g44uxAOy4cxwSKRUQlFOhGvpWTPo4Q5EivzKW+PhClaok
 sC9T2i4TGkSbfmfCMDDheQA7iOdo3df9TXaUsCqKaeOTTGL6lWOvrkbPLx8Bps/OHaWeXftQFGN
 0C/W3UXZzuh1iYNblHMTf8+XJ6b1S2QzZa+Ys85GkuNTgV5hMrmysbyzOoxWEZYqqeyNM9oqJpR
 Wypj/a96Xu4cb/xjoUS6ECknzbpEn11i/yCNwxtRJVQ==
X-Received: by 2002:a05:6a21:8cc3:b0:3e2:8114:12e2 with SMTP id
 adf61e73a8af0-3e9289cf994mr13422655637.36.1793818609964; 
 Wed, 04 Nov 2026 10:56:49 -0800 (PST)
Received: from
 runnervmnwato.kwb5gxdwn5oujakzdtqahohoke.xx.internal.cloudapp.net
 ([20.80.165.209]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb46443e37sm1493477a12.1.2026.11.04.10.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 10:56:49 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Wed,  4 Nov 2026 18:56:48 +0000
Message-ID: <20261104185648.3467-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104162305.385749-1-pvorel@suse.cz>
References: <20261104162305.385749-1-pvorel@suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify.h: Print flag name in
 REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS()
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

Hi Petr,

On Wed Nov 4 17:23:05 2026 +0100, Petr Vorel <pvorel@suse.cz> wrote:
> fanotify.h: Print flag name in REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS()

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
