Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377A3FF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 13:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777381397; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=eWalWUjABKPLZwolorJmRK+5QZsP3HXZPP3Jxg6OcgNHbQMtUxTeVbIjMoyQzGWE66Wb0
 WxjSfzxzg/nharJ1GE39+eJjo+oz0REgeZrxf9Mg3v7JB7OVZYuCEVKVyGpk8SJ2Q8Ly3Pd
 nY/thoDvabPk6x+q40Kv9D46v40xTf8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35F5A3E49F2
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 15:03:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C948C3C7A5F
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 15:02:53 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 397F96002DB
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 15:02:53 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d77f60944so8214041f8f.3
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 06:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777381372; x=1777986172; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=FH6465HHPfYlFxFyBD0QF9z0CJX/c2qjS29b1Prbztvs+MTlGzkUsBQI2EmnVcMsCG
 6/wI2ud3qqqJ7vqlV3u+sWUBddQRZ7w9cZT5u/oHutOLkUNFI+pI/X/TaIJEsD5EkivU
 S63zwceKcGi7lZxbygqQ0J6ewVZFTzGyqXW43HRPF3AkGeVOsuteSZxyd1Z5DRzaSQVc
 z0zEQ19Z186kXLqH2+yd/Y6m2AOF42wYrg2pea9mc/fGeNkNVz8iBqfjtVDy6DmEoPDa
 6W1pkX/DCIkQrF/8DVBOuZj1TNwe1gY5ny3RdXHWCDSU4EKz/j58rn1TxJtHtLX/5Uxa
 JHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777381372; x=1777986172;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=i+3hRyuZLJt54J3LYW97qWgWL+l+uKMKXQBHBQ9DoaLfvYWrk5Ls2L15JIRMjsCyl6
 Ht9xE6cWCWzfgVd4yYcnJUIjnEuR99ugqGD30m4gBAknuZ0jVJXAeUEldID1mC3TCr/s
 QzjXi8GjCggMeVoj2MeO4njQohimLhOJGHRza6TvrL/fRaA5ZgCHGlJf9GAkShJrKp11
 NVnN46R70LqRzeFnElRxoHSOA6OzQGGoEfZD4B9KwrTX2cKFJMPQNBjbeYzdVgQoWnk6
 n8NNLQ54FqXgZyGb8w0rl0e9kZ95h8RJCgFwESzYloyP11kRGTrAOl/P3h3oh4RKt0hy
 MMGw==
X-Gm-Message-State: AOJu0YwTGussyA/X+raGs55Y/PH8IEzf7Q/O7p924MQGRJf8XHD5jW2e
 UgJ+JxiXcGiuA1VNaQFsNJ1iqinFD2nb/DCtjTD9CskaUOziUgWh+JW2R5r3wBySmU+G99iGoJL
 jz8cFbebjI/ZS
X-Gm-Gg: AeBDietqcZzwWYiwRr/dvD20NGOkou3ugQaQ8cnVJ117WpWOxkeuxb3UMQwJ/zkDB+c
 UK/DhtTR3XjsXULihv5ecnTS2hTzedQJQdRxjFtd6mKUf87J7Cyyed3ecYa4roh2vl+FkJ+CZi+
 IIraWtTheF89FvXBrVVEVS5F9uEHBIquAZVZpdivVBezA18XOHrVfD9BASpPypkAbH0dtMD7d7O
 m/yEuBO1CoiTp6G8d18AV7uqJ2LBqcf1+FbP5CFLlBy127RpxnUEukYcQdb+n8wtmCGB8xwnXFZ
 KP/cFEnUuaDAEmf792Rry+0t2shrLIcWb6noqV5Eeweq84EU4gE4RL2n5JzRyUtAOlfcGVN6LSa
 DmrHmXT57LAH6RBh8pfkMna/v/JD5sGLKN2Q1po4vSt4Lmr1lXjMFB5H9iD0/B6HP+xAS3mfPVy
 d6xcTQMtANAOGFIaG3ntWZDlpLSOSSYVX/vP0JJZNcxJyqqLzmbiAdRCPMLItKFOXAr3xxACA5g
 oJUAF2isx3BiP6CJ3GG6fT5wOOhm6EvpvRC6xM+1x45dvHYIw/JrEO7
X-Received: by 2002:a05:6000:24c4:b0:43f:e44a:f276 with SMTP id
 ffacd0b85a97d-4464761b8eemr5935556f8f.3.1777381370529; 
 Tue, 28 Apr 2026 06:02:50 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d4fa52bsm6605065f8f.15.2026.04.28.06.02.49
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 06:02:50 -0700 (PDT)
Message-ID: <69f0affa.df0a0220.2b5a5d.a0ef@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260423023141.28151-1-wegao@suse.com>
Date: Tue, 28 Apr 2026 13:02:49 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] cve: icmp_rate_limit: set icmp_msgs_burst
 within network namespace
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
