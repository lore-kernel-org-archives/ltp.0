Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09FEC43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 11:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783942012; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=5ei4Gj4nP9HziQekVHYUrQNIQZIlqH5UgQFP7m8Bzu8=;
 b=XlWCS9d9iyJkg1gLwR0I/CTUT9mo4slhzL30M6/ZITEp7DidDRui0wZsV6OlCrBL60O34
 xvu7Wg8TmOqJOQFZ+Z+g6lQ3tIqVkb9Z6nicWmSNqWvEfs/vmTRSv5sB1VkHdi84xQYNLy5
 5PdeqgucJqdASJQ6vb2bU1ysnsfVd5o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DB6C3E7FCC
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 13:26:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDAE53E5C4F
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:26:32 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 59C6660071F
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:26:32 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4759b4f0897so1623189f8f.1
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 04:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783941992; x=1784546792; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S1X/IaW3oBwcntxhOUnNGk662p/lTLdHx/PfsF/jvfo=;
 b=HoYazLXKlHf4cmpn74Z4QR95vuPGjRzDR+Wwbx0Jd2GG2Zv7wl2ulmAeMKtNVylMyu
 f66V7wtue+Md67HDWALg8otX3kj0c7cKaxstZUP2u5GL2D2z6rQew0zgIuEv+YPTtEQa
 2efSKiIqCG0WW247EVi5YqeL5LtZkGGgr0FjZl+u+yfo87FsnCVuc8Ulmk+psUSJCECO
 /a0sxZg5/5tfcMiiac8zj3hqIDSlCFFYvBWVHVyg4rsSjGpQ2E7G33k/yJfSxJtTo9hN
 iNnsUGL7wJDBXumc/Er9qATLbF34J4KeVVo4KwOcxyvfSA96q16KdWfVDonBLGpplfkz
 vNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783941992; x=1784546792;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S1X/IaW3oBwcntxhOUnNGk662p/lTLdHx/PfsF/jvfo=;
 b=BwMBMENCubyT8tyZWYaFXv2YCmFXVuK4JKwkdJihfM1S7ZATETf8Bh3yWSKvgnVkHD
 qka6XpzMuIQFwZybsUECbiYKMJO5/Ke/CgYMM3+ulZQCSWcZtp9+PZeXNpUDOHJ2OSPG
 hPmQhIjpDgdzD/lnZQvVaBM5F3caKnk9uSFmQAqw0cI8Fwku/yVWzZ02NhUscNymnMZZ
 YwKkZVLmXJiiCQmFrH4thUxQ2G4kz4epaGPE3XAYnAwgYcR+ftkoYFS5x076YJfsgJBr
 NSuK+Gzrk6+xU0W5iKWCXMbyeLeNntD58+1b43oiI3jopT8d3dAhKFEQHS4cCX0rNkbW
 FV6g==
X-Gm-Message-State: AOJu0Yz2TdtpF5MsAveEoog+fd4s8PO8oItAChxk2O+evXej2OhVH1nF
 1+NSZLtJTkUOSW7cTFmEGi/6pbvA2ubsvqIi0OrVnQVv/isFmRP2MYHB2a51bZA1LLRT26gYido
 3r/2Py12aJA==
X-Gm-Gg: AfdE7clitYe0qv/Tsu9hcJiqNOMfYpf2L3bE+jTcP2pZNsnU3EWFZQppUieheJbhdxI
 KC1rI3IrAShX54vrjf40FrvM5ya2mNZ1hgHpCRWXYdYcUcU4CxrgIoPDykLRx1MUh212VxDmWOg
 GOYQlecczjXvI0Li4/m3+diaGt25rxxyPWR7s59gTEdxHoTGHoFYzsWxMWs9YNlKdiyCvtKOw94
 CQTaTHd3hpZU8Vl2ydMiiw2uivvc5wRHrs0GLcWZwwbeBNmKsRLHxREp+WEafdfUJjDPDazQVVs
 xbPWgZOQ96r69v3f9Oqs4bOdDK1dq2td4z/i06rXm+JNpbSaLjna09fWjK3Te5Ru6d8S4Ot/tbM
 tslYKMyf16ljTnjp4Gndqu5JFwGDDeAswPjbxoOZ7pQH45CpN99Kc5A//qcozP89G++VKYqkm2U
 O9z/92DwRsOP1Scz+8uua5FXxT8XC8s9/k
X-Received: by 2002:a5d:5f88:0:b0:475:f0f0:9ec5 with SMTP id
 ffacd0b85a97d-47f2dce39f8mr9481006f8f.48.1783941991694; 
 Mon, 13 Jul 2026 04:26:31 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960816sm82028246f8f.29.2026.07.13.04.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:26:31 -0700 (PDT)
Message-ID: <6a54cb67.159d33f9.35f09c.0c86@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <20260710091437.92148-1-sachinp@linux.ibm.com>
Date: Mon, 13 Jul 2026 11:26:30 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] mem/min_free_kbytes: fix comment typo and
 whitespace alignment
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

I guess this is needed to fix `make check` issues.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
