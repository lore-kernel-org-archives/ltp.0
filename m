Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E10C43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 07:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784014287; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=PzerZ6VAC8CpoovZi58xPIsKs3AY0k9uTx8umePrOt0W6cr1rcnuOjZ513nPsb7jxCRZR
 PHkYmZSKDnA7w0AjKiD9ZoFQkHj28u1mLcBCSnISl8qVid6pYuHEjDNOBXrVPuB3K8sEeyd
 TIJaFzIf1DiSwn0qg3HM1yESr6SkvGk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03D023E25FC
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 09:31:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 275873E010C
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 09:31:07 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 06236600822
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 09:31:05 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493ece78b0cso29013595e9.0
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 00:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784014265; x=1784619065; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Q011eJPnzsaKNNEJK16iCc7XP72YYWaC4rxIntGxk2c9Ix10CFGXJbWh/lAubpBt4o
 O4aIsDQNjwogwLSjEuamIb3ZhOvEPyb9xi8t9Ao3k3v3DbFcE5r0dilqTEV1cUtt7npm
 ZwX5WVfGU1W9hwnboVm42JaPIVt1Oo7suFGB3RLYt+GXpwFu9ls+ckZEROMTbFlbqh8h
 DvMQYpDpkn0uhPU6ccFrBkpTNB1AvcRnRwi2O3prRfNbyt3LtecavbK3L0MHrw/KahM+
 Q//HPhApJW87m/ZPi17C544lezshBvpDECZ9yoCKoci6HrPM5Vq0BgL735ldRZY1jgyk
 S0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784014265; x=1784619065;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=r1Kj4fs6Mqig5sWsSgue87Tuy7vgp6uKfZwjVXFPU1vWtOySraSZ0AAor89+yU9oEP
 yfjzVrKMdlSeknm4snojnUNoH0eoKcvPXPUv/gr3YqvOu2Q6KKfDrHs1EAP+e9c3uNTu
 i2HyEzJPOlUFR6XNJ5/gh3jYqu7hLU32C/D6enINf2ID12RrXnCWYoU3iNHqC0V+JUCM
 U4uzE4ZLIfNaNXQBM69g98GX0UbXVSY7cUc5roElZiY3Z3/YQ2ehRiwuGYZxuXGyDkSB
 FpEuQ/j9zFlW6kZq6/sR30Je0PvDWblD+PNKFLoJ/+1aLZzQbCeMOoVu0PCxCh1CSjl1
 oRDg==
X-Gm-Message-State: AOJu0YwdJU9yIQFeUl0FmzRL+pCfArhqTAC0dGubg/OYTJFVM3hRDPxj
 4lsZZ/yr3az84YgDKIfhuFmqPqzUhjjTqX9i6L+uSoqCLs9jXkheJHDFjE1heXpgkns=
X-Gm-Gg: AfdE7cmctPSsQQk7SoEzTNaL5ZYijB5VQGgdGIJ2xIStHkPq7Ra0XwLU8Hwt8SqCBqX
 aLro5E5yqJLvdK0v+UrQ/zD6JptJX6+lz62VNg/RBdCGi8R8L0Ayw4PQ9nZ+ynPs2zxckX9jSQr
 RwzK6CuBE+HkVAJXPDAeObY63vP5ZIpnKBm8njW4O1alCPUxQ2IwTZ3N3+Zr8qIHy50BdyN4SC8
 FDwUajYAadXOaNh01TeX1gAkb+AnCorpyZgtRZewp+W/Q8+Oe0IFM9k77LRGJ5hD6UZWcZJthew
 QQy/4mwjypMaCvjBvy237dQ8+Wo5bKLTL/RXERalu7U7Lpa8i6L4QF8UJTMr+z/yIc7Vj095FJH
 8r20EWbcXGZrgjbN4rIrPFsbWeAh4jRTXJH3VVSo0gfzEiKPO60FaHPd898/EdprTYNTqnR1Vte
 9yZM/nj0+6ceWepk2hfpEQgwmQTPxHIKlg/DU3
X-Received: by 2002:a05:600c:699a:b0:493:adcb:d368 with SMTP id
 5b1f17b1804b1-49538f919a0mr10197745e9.9.1784014265306; 
 Tue, 14 Jul 2026 00:31:05 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a322dc6sm57701205e9.10.2026.07.14.00.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 00:31:04 -0700 (PDT)
Message-ID: <6a55e5b8.7a9bf0f4.39f92d.bbf0@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260706-fix_make_check_landlock-v2-1-4949150d17e4@suse.com>
Date: Tue, 14 Jul 2026 07:31:03 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] landlock: fix make check warnings/errors
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
