Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E9EFF886F
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 06:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777358092; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=jI8u+Upi5dBJeQjCj9IGACFIBvuzB8qEGD+JtHx7xCc=;
 b=b8ZUAcw+D2Ue09Ra9EQRb1cokClE8u2BsPDqLywQDsujFN5GObyofSdya9idRnkNgoDCY
 nB/rqMJ+K6a+94t1eZ7xsbv4B4GeDsjceIOkh3G4hR3fwtDt3nu/UXy3BSCS3DuF+Q64lEb
 Jd1qhw69VEl8Jqg57D0Zhg4O/A9r4Ow=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C59163E252F
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 08:34:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87B3F3C5F08
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 08:34:28 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2382D1000942
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 08:34:28 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso4969752f8f.1
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 23:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777358067; x=1777962867; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pPumh/2sXwE4ONXR37Sqj2hEBLGXGV1+PSdyOnfmHZU=;
 b=J6t5+w+SPDqj2Zy4CF7+01bTT4k1zu8IPG9Wr6n0A87kjy32Q7iHwubDfiJmDB5XML
 QaIMtGKZJiOtBxeiBNsnrJagg1stR6+zz+6uWMp99QVBOL7ObsP9xJFt8qIi0P2nIzIw
 lLavUgO7JmJuGu0Zk1k/9X+jzCdgCqRoReYKrynHPX4x8qBlNK1woJv1Hn86z+buj0x3
 JLYNAmOQ55hcNW4Nwp9SScCWKB3hfyYQVzrk8HVZ+kNk5GAXAq9/R8YjFWmlczyQk+ht
 0O3+x7uqZ843aqstr17sgXz7KvWLIA6xvAAV9JOGbvSpohs954E+lSuyOzj16pK9UUzs
 FNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777358067; x=1777962867;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPumh/2sXwE4ONXR37Sqj2hEBLGXGV1+PSdyOnfmHZU=;
 b=Dh+zvJ3y+tgontgPkp6W+VK19EtJJaZj3iNP44DNpdwm/3uXRR4dpUSTxVOMKrZAEC
 iM5uph+xpKCI88qkXgkIxmuIG0yeiT/VXypo54JGGpfqVHv5oDxmYBhWp6lLtkmIbL9j
 ieo/3LoAUndZSVb35SVn/rZVKVxv/DMN0YyyL+WYmySsiJSd/G0SNSBkYxhSGp7658V8
 ZLvuaOK2/VCZArYRYIGYSy5/XT6VaGxrozja26dWnOs4x7injaJkpNuy/eaWBZ0y1ecM
 CROY3LwlLu0haedTmpefAZx0zDzMj6KTN12SaEIJ3gCvHgrQ4+q6ZkB+rzSFQqykff01
 44Hw==
X-Gm-Message-State: AOJu0YwEKSo4OOtTplDptKNBPYvz6/5HpWi6O1VV3vD2TaZGN6Z+oPqA
 dZCxtT10jkFIzMp6krMZ2pQt/PLeOmRjuabYKD+wNfEX0ynKGLhfwHYlS/IT/lkaUN83sbTy0rM
 DbB0T7ns=
X-Gm-Gg: AeBDieufpL+SxmKONuAp/ORjgsfAu8CjWWnGUpaoXZF2gsVz0XGMorVSi/f5D+iJlO3
 rVb8TKiGIC+a0ANkyWpF1Ghga+2Mhrl2AsapSBT/VNtzdZqTInI50Sf6x5MriGBE6tTOTh6OKzB
 iURNFVVheIr3g6MQNLwc0Vui9iS09ckxDdjcB2qJwaO90N5Qpg7DjlthZc2FubDJir/juXdXccc
 pJwGI7LnNFGyoJy6L4QCKwv8oHBstvdojPTVl7fX8G5EW6Ju8XddBAkNuX6GQQRfKaOUE/YM3RP
 l4K66euyLecf0bU2MYuUoZrL1oAIkgZ6qesYyn9t0OBoHhw70kj0MF964kv2pqnZLlqxcxFQSQz
 6L4+KRLX9zO1Yp6ELmj0DuzgE1+Q7ZQZi8HQSlB0nNVHu6w96h19QSRpRNuk0nFUmi4o6GJsNjd
 I4bDfVmTSulXdh5Ya2oLPKIWurZGwmqufdyiEFzBhG4/Mkwm+/7TrI
X-Received: by 2002:a05:6000:4553:b0:43f:dd8e:869a with SMTP id
 ffacd0b85a97d-4464f2efc6dmr2071904f8f.3.1777358067459; 
 Mon, 27 Apr 2026 23:34:27 -0700 (PDT)
Received: from localhost.localdomain ([37.162.84.198])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463cb59e5asm4234796f8f.5.2026.04.27.23.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 23:34:27 -0700 (PDT)
Message-ID: <69f054f3.5d0a0220.11f19d.445b@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260427150139.31685-1-mdoucha@suse.cz>
Date: Tue, 28 Apr 2026 06:34:25 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lapi/io_uring: Add IORING_OP_READ/WRITE
 constants
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

Merged, thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
