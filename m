Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAD9CA9ED1
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791820314; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=7ft9oKP3/DwZkfYN1yhBTjaAm87pBREuFzlpS073NeA=;
 b=Y2pSnDlUVY8oJy+aObpWUznxyj3go789laiU+7nagt0Ze7r033dpiHd9Air59shk8eatE
 7fNrxgyL3egrv1Mraou5Yf1zZO7sGmqzFZIR+mddBsN63wXE8sCkce/QMkR+QzHe3ErsMYO
 aefrUM/Ae+DSxkS6/F44qlnUNZXRUXM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9A253EB137
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 17:51:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C94D3EB12D
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 17:51:35 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A402B1400961
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 17:51:34 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48c02782159so1250894f8f.0
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 08:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791820294; x=1792425094; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HkF61FQjOVHetGUPPakoZ5NOcmoDLLJ/MXjwwAyU4Ug=;
 b=cWNG5RJPhSHV1yKIktU+Fk/Tek9jqQvWSMeGcy/Qa+seplJPZ1Z5vwChlLIWZ2aoxs
 Zt/CG/8lzzlMBGxWfgw9vrJAP86PCwICZR9dPyLAVWeYhRNlMnmEWqMZATc/NiV9w/Bk
 RRc65FdrrpIZtF+ty/qILcMR+ANiH2EYjenxk1sapZV+itnPjFVk16QGeS88EHLCWEsY
 OthJvCNpVkYUK3ozzphoyvECGwTyxzt99y1wRj2qHU8gThP6HYFbATbZwpFhZN2DxBS0
 mLCSjE+NGW+hdxQCh3Uha+baEPIfAVTU7XrAPDlwN3q3kR9ExQ/4c4XDkHZQmO8cMym1
 SE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791820294; x=1792425094;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HkF61FQjOVHetGUPPakoZ5NOcmoDLLJ/MXjwwAyU4Ug=;
 b=AMQJ9GF9IrErQe6FmYLacZXtjG4sDRbCe+qv8/i17XNuMCGowP6pQTWx75D3scoC4M
 dDpUKbkRymiFEcTyJfnOiy0qUwaTHJ3CRQFFUy05bsCXGcqO4wip6eXiTWjd98jafjiK
 E2WFG9doxRnFCFX2qF5CMcA1cQmAxMhNEAbpGaN8M7a/sZCa/ph67FEZiuxvXHyiT9wc
 jWS9FWm9sE/i5/i6O2LzruookLQov1f2s+rc7X9rpsRU6XCJpTNrVQOBgdMAkLQ9Plik
 5o2yMPmo0OBc9Qqo2xFWn0f3i1XmaaCWhLQXQtg75M5EmjePtlJtoqT9GRvqSiDBmBnS
 /AHw==
X-Gm-Message-State: AFq9FYL0a9N2RYe5RKUNvKoy8o+IxzAoKs544PHvNkxSCgMe1P11O6yz
 6xlK1vSnCW6VqckQ6x+6a7FImzwC3KJ9qfvB8Bfwg6J9i+G1davgEVhLoJvCIk7z76U=
X-Gm-Gg: AYBFou0KqDBFeHGhh2rUd0u1OydbLkLzHTa58Mm37OjJ/Wd+aJxMC3QdSP12MOTiBT5
 A5XoAr6akK3grs+RSHYLxnXRidKszOlHonwL+Z58EHjxPvmWs01Gvl+kA2lBBl3MLNBlD8iuY0d
 T3j/dfIChjRAug9tCTZO+MBNLR13kgx2tW7ERpnKS2TYh4Ro5fkiB+/dgYNhOcEFRWIm5oFrOnN
 EauCGmgRHxQuD1QWmzrM90RL1x/CUyWD61z4PrdbUvPXxcCv3vbX5wWRVF/QUygsEQP08o6r/zA
 hfxRbBxY+VuP1y20DV+ze0uQ6KqrilTBLse/W4ZJLVR+5YllBZkpWw++SVRFneIt1pvfgYCJqpZ
 RWUciOnvwhL+ZPxcMF6k9oTVeqGgYNa6b6agnvBExDGfWv4xMyyQxki2D4FqHu3IZ2vC2gMQrDD
 6Pj2+je2BQxWlm5JNX+QPNM6RFybl1ronRDmH8Hn60lkDaCHTmTZlKKacKbDL4rX32+7LOh4N86
 GZoad+9Oab8Qa6qfV4Un6z37fcXAi3qt4tqWhqcTDQeMYDUlOoS1JWjVhrtFheW2dW/1Zkuqf9z
 0lk1Tm1lMwli
X-Received: by 2002:a05:600c:3541:b0:4a0:2488:71cc with SMTP id
 5b1f17b1804b1-4a18e4e9ee8mr175767785e9.32.1791820293872; 
 Mon, 12 Oct 2026 08:51:33 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18e49792bsm477612765e9.4.2026.10.12.08.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:51:33 -0700 (PDT)
Message-ID: <iDTNt1jXwFqCtxRdYVwoga28j8OKFAmDRyJ6@localhost.localdomain>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <20261010033622.68927-4-li.wang@linux.dev>
Date: Mon, 12 Oct 2026 15:51:32 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] tst_kconfig: add module mappings for
 vsock/vsock_loopback
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

Hi Li,

> The test needs root only to load the modules; the reproducer runs as
> an ordinary nonroot process in the initial namespace, which can use
> loopback VSOCK on nonprivileged ports. Drop privileges to nobody after
> module loading and regain root in cleanup() so the modules can be
> unloaded.

Please drop the root _only_ if we are root, we shouldn'f force the test
to be root always, even when we are user.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
