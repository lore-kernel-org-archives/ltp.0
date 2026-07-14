Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B4BC44501
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 08:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784018051; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=nG0F//OsjfLMsdLKZ8MMKgf5P8T7ESmDUkOUIBp+F7s=;
 b=fKTmZklUseT5HK/7Q9IlB/iX006joUr7SlWrutcKnUagUXLTk3ooiuhoqYvAYyThUMNP5
 XACvYxnzCydhaJga7vhHXMe6eYDYGgw+fxaNKuFT/o2D9CXAwoRQEVDiC7GsVYAA/7pp28n
 qFhXfvOfn6ACrrs7OO8WynmOIkwoNQg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 826243E25FB
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:34:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EBD23C5E52
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:33:51 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 02D4C1A007B2
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:33:49 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso2692399f8f.3
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 01:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784018029; x=1784622829; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=v8rCf0oUkHHQZ7xn4fBMn44z8PNIFDBxIbO8HOumGLI=;
 b=IPIBd6kVS0EFDefiCCsB3csPr58SoGWjWP+skaXZrczridYUPdxpWcNyKlSe2gBZeF
 DGJSkyhKp+h94zp2Ul3/ca/vmjajUyeWBUHY2naiy/Zav0Dry2S28ipQ5rVLf4AWnDKZ
 T5y0w6fU+DxClCNi5ckkmGDSTEXjsZH1ftO+JqW8pMgESwfDWVGPeTuFO7GVeOV8wf9E
 rDqmjNTXA95Bdq62quzrJ5StLz57evwaQx1SaHgg2Nu6DFYjGvor4gmLFJiRfjo2a07F
 IRJsbL9DuePPVyZpiuTmBcEdJZKsHXKRE8vvQKbxRw8Uz9MDaKX4Gyp7dRkKyEg+YgeO
 9Oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784018029; x=1784622829;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v8rCf0oUkHHQZ7xn4fBMn44z8PNIFDBxIbO8HOumGLI=;
 b=tC7IhjKv/he8xnPTzHcz3oQc+cfLVO88bRHPw+wd2NS4RalnjoV8q5cktzRzw3TZH9
 XDLa1avyXGybZhmctJfWSTQS5HNb6Td3Lna2s4Nk/9JKmql8VGJeidy802s2IrBrV+HD
 muvapasMdLVTQz04EcUOClzUKOjXTNbl93ilw86aCI9lR8KEjHjhSmZsh+f/cnZ/YwS0
 G90usk6hQ5M40dgR+iXz8OlZw0najKbDhRUKmrlFUbgo7YFNcfaUp86G1XIiQqw5S/Oi
 g7nkN9XyAtgVNNq2FgLzhYNG6h7Sk2OfVSlcXjQUEc8Ux9HC2RfSlVNMCkOvrvaEKv5+
 jTVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpEsqz018xUYtCTdZi2L4qjY2MR6h75cS6yKjwXPd0O6BQ3zSlBYFIGDMGTFWC5loZ9EKU=@lists.linux.it
X-Gm-Message-State: AOJu0YxxvMlfpTM+8TBKv/R9jx8627BxVPVYK63RPx6b9OUDqz/VZDv+
 q04eL3TUKgD0widNLb9wV51e+muOaMmaVEcvBGHSbFhq2G6YIONzRw7WfLvL7cnFdA4=
X-Gm-Gg: AfdE7clJqZwy8h91FWJc86Ae70EI/L0/7hqBYY1+fuhXYTKmwBk95/ke8thwe1I1G0Y
 fiky5pvmPDvJ94GGp9bfe9UEPC54cPxlF6xALZqZrKAibpcXW2gCA5fPcL7Jo8NvmA84E55cEgR
 Kry1wGVqcL5bbS1gtDLV5OxBCRzqvSXi1lKTOxs4+BZxzE+McMp3TNKGY3EK7M+xKX0NmuMxZbG
 VMsEz7Tld4T5SBZ+ERkomoqBOyHYXJNCC+jlV9jlExUFU9kYrfIIIEXlgw1fYyFo5ljJoIr+ahu
 p9IyKv9VWe6knaDrLp8qMMKVbWyUer7I33OkRQ5WfZ1MX5VtcIBBuOr4f/KC3RZgrfp0Ee4yMgA
 zCHwS9MUVVO1NDSKvYEMEFlTfi1PCi1gFs3XRoSMWguOwtla2i+Ut7eJywOqlkZ/cE4VzbER7A2
 4Ay00zEZBM+zIceutzI//QDP3ltyQRoq+v/acg5jLhvSEEea0=
X-Received: by 2002:a05:600c:2b06:b0:492:45a0:dcef with SMTP id
 5b1f17b1804b1-495158c6a10mr20237115e9.5.1784018029338; 
 Tue, 14 Jul 2026 01:33:49 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a2e98b0sm111315795e9.8.2026.07.14.01.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 01:33:49 -0700 (PDT)
Message-ID: <6a55f46d.e11288f4.31101c.d75e@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260710070511.GB1157094@pevik>
Date: Tue, 14 Jul 2026 08:33:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 7/9] SAFE_MACROS: Add SAFE_POLL()
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

I sent a patch to disable a couple of annoying rules:

https://patchwork.ozlabs.org/project/ltp/patch/20260714-checkpatch_remove_rules-v1-1-b5c561f2dc16@suse.com/

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
