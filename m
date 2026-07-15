Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ED6C44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 15:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784130443; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=NB+HAS4AqUhlIMjwRdErFA7DI0bqCfgdwCj5WCEn0ALef+VmFD64YjHVzkx45rAPvguBO
 WV38pvLxg8fIcrHfzZXYBzZZXqhwsp9gwUTWaQnek8ybg0dy4ojVxyLcsHdFl+h4KuJiHet
 vtCGvHcnGz/zToixqhGA1/u7YXCX6+Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B6AE3E76D4
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 17:47:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C27DF3E1DE7
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 17:47:03 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CE2D460066F
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 17:47:02 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so12685685e9.1
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784130422; x=1784735222; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=fj7TYPbbRBUgbysjFruGe8S34AVb94W0reDLcfYtLtVZ4afT65uxacPJqZTU8+3Jkk
 naVW/pYrfQGsYh2NWvKQmyYFVLOwtFfEqfAEnGAYiPTeM26zMYAUhlowTqyE6DtcrZD2
 o0+7gg6BYXenx5N4BTOIwz5WqYWunn0BcbIKTp9yc+SaZ4rLUIhZcdJ8Alr6iOCRd463
 IF2ak0Zn5KjVVEe5cAoRVeM/60M2EWtDI+Y6lSKfGotHeDv51I9gFZCJr7L83L78ZPpH
 /Dghf+mP77n1KaoJEcTplApzCNPowaoPiQneYMHkh1WJYFZVbolBuHJTjSom2nDkEqcb
 rMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784130422; x=1784735222;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=L1hbzklERpmDouA6Rfy0PI4YI0OEe4PmPAN90E9wjxiTwDW0m79c2VgS85BbZGi24v
 nkOs6OgXDc0krdJMqH9tpXVy/zOmy5yTNaosMIP1K7GuX0DbrArmrA2cYnjYjI745qBB
 gG9qFV6+XUPlBlfpoBRx6z4RHanfDnWSuRFaNae75H1enmwMldN+Ll/8FcAkH1YnCbiy
 m21+61fSk4Yv9VNi/2IWHemTdEnnUpnkV6iiLOrh/ZDepcaPzX74wSlb7m+Ad7cKcti+
 JxBK6ZWtMayOLniyPDJxeXjDl7uq6hxfoU7h/PDn5Xc/tLfF/t9B7eY5V1oj4NCYuxbA
 sE5Q==
X-Gm-Message-State: AOJu0YwIUmxsSG31da+1l+1xr7mG1s8VTMtZ0JYlLNbgzso1TtQ/v+oS
 aizzr20pNL2tf/qezLNTl0bXxH3aiyZwB6SQS5WplCS/XLzA9Kd9G9437HTYoI7YB4g=
X-Gm-Gg: AfdE7cnuvMqoOKikJCVhE3k1JwKby/eelntD1ByCzuZw1eBPmVJ9KSOZHaUFM0gWKlO
 OMt9fxvQtDiX5CpY+3fT6Ci/57cwhvm6K5as6v04Ym0/KFMqr/1ygnZ9KdLTo+SJQabHfjffag0
 JNIIHkJW77+UcJMz3EXRHOUXSyte+UUxRoNhDyvwhZuSZLQc9ywZpoZnX/zHcW8Vov99ovrFzJc
 hy/Lmk6jNp7FzgvQZlYKxJp9zSN/yWDU4wi3EpN8FpzX/zamzrsDqic42Z/P7+VGEIZwZDAKTIF
 5DCywj5euSUJXf26gwsnRzZEb3QiWert8iOl1hVkFyEZ6m0K9cVltJyVZREI7nCWGPCwkGenNaN
 WSiLHrls4/6UorubBkyJnyGs//VZTQvJHGDiy+h409t8gSsbMEE98xtCRauHJYKiQ6J7N5Xpdcr
 KARrrmjfutsnpZb3pbl6W4CpjblXsevmmZ
X-Received: by 2002:a05:600c:621b:b0:493:faf3:3ead with SMTP id
 5b1f17b1804b1-4952cc3c566mr85391875e9.4.1784130422178; 
 Wed, 15 Jul 2026 08:47:02 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950871e830sm162775805e9.2.2026.07.15.08.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:47:01 -0700 (PDT)
Message-ID: <6a57ab75.51d65a57.113a29.fb7a@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260715-hugemmap35-v1-0-1d5911d1f2cf@suse.com>
Date: Wed, 15 Jul 2026 15:47:00 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Regression test for 49ccf2c3cafb
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
