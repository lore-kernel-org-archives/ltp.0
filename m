Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F9EC9830E
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 03:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790740437; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=CZtxZ4rMH/MMmPrJgE1gMarrufjoCFRXn7S62+b5Re4=;
 b=MZLRdMsNB1f9y0FFp/Fa8n+hwjcYmrpSxyc9V8MPn9BePnAfDuAQL+8YOFe14VmfDT+KC
 2Nge+e/NvTN5bjR7taw2AGMQfHpTG3TYMKBiYCrCKDTvca69bAKABnbEz0ulbsaQzOam56b
 6t6Z/uRW9tmsgMcOj1NqEP1cJUIQvsE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D5633EAA88
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 05:53:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C798E3E5833
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 05:53:36 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E747614000A9
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 05:53:35 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a006d3fe83so10377955e9.0
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 20:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790740415; x=1791345215; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y6ApgRe48zZzFDxu/OK49s/ZSCJhaj+PnBKMLX8U7Iw=;
 b=c4Xm1jxN9JdNSNhYJRUPr24aE8j40IAQiKIL13e66tluH+k0+F+XQ6Z6Qv+Kjoh3IT
 7dkDsD0lJ0/HM7TqAV8D/BgeZawCCKaDKHY57n+oFqNPgaAmAqKY0zB4Sa2vIxbYols3
 v/8+w4eGKge3IgNYIGfvONFSsi/son7hmlKhKNMOQ/0VMwjmr/RtsvUJg1Q17cGg/7i2
 YPpEj8Qh6pFm5mPOmybG3FhyDcnF8SGqWNuD140IWnXUA0daV7Kx9D2AEzyAsPUIP5yE
 /6CSUm3z6OJ58lm2kS4WgKraMrRHxX8Ygk6BsrhThkBhj3JotrkLfZO735bUSUySQhCv
 T+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790740415; x=1791345215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y6ApgRe48zZzFDxu/OK49s/ZSCJhaj+PnBKMLX8U7Iw=;
 b=ghaUS1B3k5LNWZtkdcHVZHegegnxss+QK5dUROvso2pmpEP+RxWwKQHIeddJE2Op8w
 dKWUWzge80yKsyb7y9I0ZA5LK+XPsXW3TlywrdieNN0uGHsTpVIBjs0pgFpNfMh0L1vB
 utcA92FpFxz8YSrIdGuPXRM/hcTjjoJhHdPCyRm8Ze6QC7euf4VOlBPaP7qdikE3HuMp
 ylSJ2gWPxnsiILrxafS9ElehjyZdZrml8tSFTINvtyE6Lthqbsj0apIag7KkqKYYROW3
 rwoX6y/KjGBDRKSJqURuM+adFlnO5jAnwq8z2JK/y0x82bwJl8U6G9E/Lz6YTwzufe92
 nasQ==
X-Gm-Message-State: AFuF++kb3K9Tlf1e8qeBm4IT/5kaUEWwa9FzK5Orpvol8re0dJcjo/38
 F3cxsWvhwrbMFNsEAkhaRihdA1eyFLmKnd1u5GK+tuiAfB6G0OE/AuDJUuDA7mtYcZ01l8lgIzh
 bUCQ=
X-Gm-Gg: AYBFou2mwJxXeeA3LAQyIcjhHGsZ+V5+/u45SXd6jAbZzUgdexWMVEL1bc0jXIBPL8H
 oYDJdJy67lL4I/exu7Pn4sb1tJwLNFzaE/8E/tjToVQtm6PNwaRKZgr/hwdCHBYfWzX2P79Xp6U
 Hv2Mfy6VPoR6ur85mFcf3/k5xNAMkhV9oAEp0JkNPTV2bpBXc2rwlj0/sb42BrPl+NHCdCok/kR
 PMzMl4cOhDc330RLo/xxtD5unSuZ56wEuRmuXi1LBMuo9XYN9C53SRvC46gIwIdldG+s1bGfZ8P
 vFkEyDo9bIHIBSSR27X15Ut60Oly5RajBlketvyP2qE83lYSwlt7ZW8ba3VQM7oVHi5hE64g1rr
 av6KZu9BOF6RalGTtjLYpk97BRfltKMWsP2a0ZPhxvwX4AyqaaSN5gu2xTMFgoW1r3x+lHwYlB4
 MTFkwqg+yK3njqVvcgc+fFSuE1LYPOQQZV5jPnKtuJ9EuTOR0CXMonGLeUSMJjrYUvhj/cbDtIR
 jndV7R2hHG+UjK+3Mv57Mb6t5yUK/GEEYYuWRO8B1k=
X-Received: by 2002:a05:600c:858e:b0:49c:e0e8:bd94 with SMTP id
 5b1f17b1804b1-4a00d75c7a6mr64044275e9.1.1790740415345; 
 Tue, 29 Sep 2026 20:53:35 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-48b029bfd2bsm46298f8f.11.2026.09.29.20.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 20:53:34 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 30 Sep 2026 03:53:13 +0000
Message-ID: <20260930035332.3360-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929022340.524-1-wegao@suse.com>
References: <20260929022340.524-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] memcontrol03,
 memcontrol04: Bind test process to a single CPU
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

v1->v2:
- pinning to the single CPU regardless of page size base Michal's feedback
on v1

Wei Gao (2):
  memcontrol: Add bind_to_current_cpu() helper
  memcontrol03, memcontrol04: Bind test process to a single CPU

 .../kernel/controllers/memcg/memcontrol03.c   |  1 +
 .../kernel/controllers/memcg/memcontrol04.c   |  1 +
 .../controllers/memcg/memcontrol_common.h     | 27 +++++++++++++++++++
 3 files changed, 29 insertions(+)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
