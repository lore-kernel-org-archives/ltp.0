Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8B2CDB481
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 13:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782307360; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=5eEL363xwcVX0P1JvtFScZj7P4Y2z8MoqPwIbzALhew=;
 b=JKYBImsn5kJDxk7hzXdG7KVVDTd2vU/INyF4rl4Q6bvetbc7q87oMvb7li9FwP3ktj07t
 a9aBDcu3dd1BSMT7JRW/7IO14EPDxiftY/7ITXThgwyYiz8Zu3nyE0hlaG+qwgBwsZcHzXz
 4FwROQHxioIpaVq0SFQ18ukEwZk6iS4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0323F3E6265
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 15:22:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E01593E2876
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 15:22:19 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BAB431000A23
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 15:22:18 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so7750885e9.0
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 06:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782307338; x=1782912138; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8MIfNgijfiAXzGj34R1GyoFFjA4Zf6jPXZH70U/WnE=;
 b=d+76dURB/XuD1Rjo+e0f3/WanLVQplMAlOTeVDxEa/7G/z/lvq/d+NffNxAFo5jaO6
 wLz8qFv3cS8epUZXzU3PFISUPwKKar5MYtpTvmxGv/lrJoN5Qeu8w8Oa4DG7Rv3sEyov
 u1ZRDAEh0jiUx5Oabe9hpV4s7Qd3/QMYtvAlS9Jk/mqmsMfTl1uD/p+aVh6OH4lQkDOO
 uJpBOOC+BaVjJew3hrCVyMxa2l13kUMZ0OZ2pNcoe5yBo1SF3Cx6312kUgDq1uoYhdvw
 RJYx2pDu920RAl0633PSKHDl7hkHZ+Yfa9E3N63P40kVslHQrfuNtVzlkkgqLidbaDl7
 4TXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782307338; x=1782912138;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q8MIfNgijfiAXzGj34R1GyoFFjA4Zf6jPXZH70U/WnE=;
 b=W1Ij3lzvjHU0DUIg/DGbTMZMipd0gZleb26SuCqGgGmyeF9teIn1w2OoDKdAl981Xv
 +o5za1M4IJ7txuGvk1EZU9+35KxaSOoxWW1WeppHfcmVmayY8ZxOkGjCT5oyJmC9sNVW
 si+A6jHqLqftwviUuU7sXf10dDVtX87B8HH4MoH3DZqJ0ghdRQGHxnQZI+h6l1qGNEMK
 rvrxZ71veSbrM/Lc8tMRSD1nHDjoyiraFqxp9GOdB9A8bAaBW1TO/tBajLukZVzyN5dA
 J3uQ/KXlPlOSETELv7OBjXb6+suMi6SExvfEfcy5cPFL4Qsj4JLp2reB3KjcIIgTKAJS
 +gOw==
X-Gm-Message-State: AOJu0YyjTDwkz5aSy/81L9wEOsnuANYJyRNFqEidc8CSV8V++p7uXEMg
 BS3/uigoorOw2b9bhhPrhaVAUkfM+PRKMRVjPwKc9tX7Mb74FlVeJ3Ls7EahJAqbgce1eKFmzN8
 WLPAZanXC+w==
X-Gm-Gg: AfdE7cmxN3K+HppmX4Q2S/H+dychMNcdNNP4DzLXy/5c1luUAGrtAURsQzwPIWldS9E
 wWdL0tS8T/5nGzpufzpAGyuQ/C7diG85Asr8r513bdaSYN8bu3nTavjpvd/MMJxvmfTj0zSKnGQ
 j1JTaoctpqQBTVRwY/fL3luiHG+f65yVuq0kso66yD06TAX/fNA3okUP45bQVhMh3TXtLXa+SgW
 4qhb69redvQlOTDIUvAHniuzKIOxwQqVSzRnkiuZGBsjv+wSd7ZhM+oslwsVCELh2kiybCQWjnO
 fuEgyz66JDRnpBpOaWwo9d6OCHmeYrZS+cXVrguPMwIluWSDaYJ5eOuPwgoFXvqH/xSgHKK11gw
 qmDNPH/Ykdc7qvsdy+zN3NWg3PoIfQhAmbsoyOQK8msSGtJajO52M9ax57s2SMTedT1KL56/f2x
 PUykMU5dDaV1HgB/FJeR2fourNpJYhoMfnIU/zQeAhiEWLwM1746KkTxF+BjtMWQ==
X-Received: by 2002:a05:600c:4ecc:b0:492:259d:567 with SMTP id
 5b1f17b1804b1-4925b379aafmr118843535e9.23.1782307338042; 
 Wed, 24 Jun 2026 06:22:18 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd154fdsm424637575e9.1.2026.06.24.06.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 06:22:17 -0700 (PDT)
Message-ID: <6a3bda09.a05553f2.30663f.4863@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260624091900.4107041-14-chrubis@suse.cz>
Date: Wed, 24 Jun 2026 13:22:16 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 13/13] metadata: Add runtest file generator
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

There's a build issue related to runtest/ folder. It seems like
by the time you call genruntest the folder is not present yet.

https://github.com/linux-test-project/ltp/actions/runs/28095394061/job/83183512348

This needs to be fixed in v2.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
