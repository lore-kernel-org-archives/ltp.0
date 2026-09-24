Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39824C98311
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 10:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790244738; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=XaHF3no8pBdOQFIHR2SHa0Kcjrc4WOVw2bQqj54K9qX4IlUzfD4fjwvu2fdhQcMBZH4EU
 6D13xry6iyN+p81q1iBBPKKNfsvrQqxMCLDtUIG5qvraEM55USVhnh/jGN1zEqCpZyaFQ7L
 ZXLrfEIWkcfluVeYwQ8Vb8sby5CsVHY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 781C23E64A1
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 12:12:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11F3E3E4F08
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 12:11:56 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4C737600B49
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 12:11:56 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e620fa473so11276455e9.1
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 03:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790244716; x=1790849516; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=XUrb9jQQwdYgIN7U3CR0OCaF9JKkuV/PIWXjNTUelIM//4oBlfbJU2k0p6/Z90vvlM
 dJyDbxtbRR2wSqjxZs9T2s+YYkrzZBR0fNsP/yqGA8yzM/O4Gf5GwSHSF6n3fd6BvkeI
 yYEUDfcydYFQPoUijwK5oY9Lb4IMEM0fqxH29t07e+Fz/9XR50oeKL7cBwp81FOEM47Q
 qDmW4w786j54mlvAv4xnSEHYsBf5NNpPV8oQS6gplSycoSh2vUpMVaYxgWlffQNzCcO7
 moOc/KxzM2T2sq4+C+ELvGCpiJpDbJlA2UKth7CaCGvuoxmnA7iO4AOjn+WXiA5sYSzH
 upRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790244716; x=1790849516;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=IUZI4qmdGxG/b4Fi8DetXunM00e7POdTInAgJjBGLdA5S87hQwMsCPTIawBt80Vp/D
 sKKEZ86ThlsZNLdTKFBwBnZuk7RmgnM9oVcpJloNnqwuUftZl2feSzr4jUaeaS/YTC69
 ZQ0RlqHcvhQBrr+yGyPHDCJmZQaAcsRp0EPHiBshGHL1R6qMQTlnOxLbADgNTIxbNp4+
 SwDabGI8VdhDXEB/qgjnmJLfq59OpF0yl/t7yajlxip/Pj8UZVKeIkZ22Xf/On4o8UER
 9EmCkAFm82tzHJrQA1TgtVs09Ao4JGlwN/QDQ0PLmnEvkmtYUzqVi/cQKyheOk0VCdkr
 Z3Pg==
X-Gm-Message-State: AFuF++k2zhEJlKQ0xSe165LL3dMeD1Gycs2cvQxaQ9WwUypiTfGbwQQD
 bioidJl0KZUT+o6E59D/eCi99s94xqdt2u7twiXviH3ajpxr+GnvwTGy5jV337SV5s8=
X-Gm-Gg: AYBFou1OKRVTAPoxgvPosbdWpNgtuLKcouV7czh+R/qqml2mubLa1mEEUVba8pGkyJz
 Ue890t3HPy6GK6D2NLCq3xLoKN8kL3DX5dqKI3m0Slhx+4ND0yEhnwMz5d1B0HaqzAsuUfIPoYO
 N25oN9IB1K2fnQJMbSCcJohE0zRY7w2zNQWnnjRhxiougyLjE8HzPBqUSjW1g2GJ+lvz6jt6nR5
 Ia8eeIqUriLRi7ov5Se6pFcfUKrflQZH+apqFcsUwmXyjcSV7Zx7AAHSsr7KXkFOwyVB7zo94nT
 3v98fjotD/TX+NWDUM/o6Q7nwusHcSei4UUmszyLFaQhWQq7k4OuVqGH+HDWfDJC6JgZXh2fcS4
 UtXiSBY57K2eQbpRdQBMiKnY7wvxxoGyIZ2yxwir+WkSFZ7Q9/eGfxnUZQuVpx41Ux2N79ljaMx
 HE++RrwiiqQdA5ZkM2tnLvzKwES9CB/DTUwzejA3d9XJ/P82DMmgR0vxkwPLYKxOpjMbf4nWj9a
 Yd3JRF4UKEsNJAy38gMi9Xr8pJSHbbLY6sPUSt6CayoBk1PwMNyI5ItsQc+7EJBXW4EqbtH4IJK
 zVD/yWB+n7cbhfh2rek/RoGlIgBLQZ1W18ImK6YXXrVfXa50
X-Received: by 2002:a05:600c:4e49:b0:49d:1d7e:4085 with SMTP id
 5b1f17b1804b1-49fe66f5576mr28262315e9.22.1790244715542; 
 Thu, 24 Sep 2026 03:11:55 -0700 (PDT)
Received: from p200300ef2f0668001c02ae826d62adbd.dip0.t-ipconnect.de
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5bae53dsm57914115e9.4.2026.09.24.03.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 03:11:55 -0700 (PDT)
Message-ID: <6ab4f76b.f6835b30.37386f.5d89@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260924095933.4183470-1-chrubis@suse.cz>
Date: Thu, 24 Sep 2026 10:11:54 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_test: Clarify the .needs_abi_bit TCONF
 message
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
