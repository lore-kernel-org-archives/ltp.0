Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF81CD6E60
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 15:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780415878; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=cIVeC4JCbw0OtcySBPhGczbezeFJpW9x/hkeXzljuPHmbNJGTSU3Rnlxl6fxtZXrPOWW0
 4h2TXQq3tqfSnt4ScK6XiF4j/S3CCEhDsEkkqWW+6u27KD98U4v7iEH1uY97UzNNnItsVYV
 lV7cG7KiTru23oYL0wbvxxkcCzZcag4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC9803E7226
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 17:57:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BD2F3E56CC
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 17:57:33 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CC51D20009D
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 17:57:32 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490b4a8e28bso2260635e9.1
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780415852; x=1781020652; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=R0y6PmIAuGrBM1QwbDniHNqlrhM/qjG3/kLJnmqO3UMhPRy8/eXWv2gFJQm5XpGT5C
 H/Fg5LYMPm//8UkTc9koXjoJ2y8r/ItBe3Q2+oQYaG5FpISTMIv6Ej1X/HIagAjxCdkp
 aebunmMR8Ra9/WbjfyEr9RJ4IUGQ2JZYxaeKWuxMG0TRIHomw+Nfd9yA1h3st2lSNQVG
 q96658B4939oJrt+w9pkD8xvudln6aXN+DYKtgfodk+DGFJYYGDVLnEHnLdR6+SYEuEa
 YomiLSOdTH7sPEl13rNtxLGEuKk9wznT30oUhwO8FsPh8bB78MhcReIK6P4PuAxSvFpT
 V89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780415852; x=1781020652;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=PyGEGZjmzJCEVo92BQQSseLMCTXwyni/DB05PkbZOSSzPbQbCakL08+8nmFIY2QApR
 +ggoBU+avECUtqKOt37tv0dxHaGgKShmWhtPUaDpfSrHHTzJDh+NWZOCg/VBx/6ckt/L
 RLzR+ug9+LVe7p/13PiK1bHIeL3n1RYennEbvVfsc37SSTVriDWf+lmRwLytQPFwv3nn
 TmV89jImr4S29aNSvhAJwMMbDhQaw5rsB/BIeS0j1/48fG8eH4cUbGvArrgl04gXGTqO
 PiuCHdS6qXMLA6ilB6DDQsNuvMQUoygJXAqv31UWzVTiPKUymRawduimep+uigU77mx8
 9gKQ==
X-Gm-Message-State: AOJu0Yxo/Y7pdkvs4TkUpXS4cAMHIQb8sb6cO+2ius3HP/kQaNEWGpDW
 SpaBKMv28/aeCZMkizTfhhoVfv8QNTeYIzGSo9B1op10FHDW6hy0GzFcNw/qhd7wSk4XZhAhvhS
 Q5UH+p60=
X-Gm-Gg: Acq92OFWUVeEVH7HxU1MBl8pNIRpqhdJCXvEwa05+FRrhk6TE2dxtcRVqVUqVX3FHPB
 V2cnqzXLi4CXZk/K4UpR88BQI/82GOyUZYguQKnqyisMb10S6XXLmfRKz9yZ0dN5NXVYvbZ6aGH
 +JAM4ms0kbJSdC4ipZBTa3T8VsJqcZ5JDqWpLNKfBzcfnew5FbyOm0gO1H9utlEeP0MiI7mRc5n
 exr8E7IrERn+/2LUdZ3OKwKvAYGT9ItZEBXfSGwzcXa+ydzotWfJSz4ST6crBxd5bArSDL/oFIU
 9h34deSXknnyHrG3LBkiUGh2poBlaYaZ+xy74EpQDZu237ESyqwAgvK3faqBgBOlevVBMyjs322
 5fteoVqJJ9mPwItF4jSqT0HzKaGeQQsyeTyqon6gH1NwSw9LO4cGhKtiPZwrUQxab3JSwPS6tvG
 B3jRat44pSusa1HMJk+/h8fYhag785c38bjvRn1B1yhVwVnRCwR5wCa2GH53Nf9kztKFEOvnPe7
 pO4tGhiS1B1Ez4k/mqFlg==
X-Received: by 2002:a05:600c:46c4:b0:48e:6db3:ff33 with SMTP id
 5b1f17b1804b1-490b508f1afmr5620135e9.14.1780415852158; 
 Tue, 02 Jun 2026 08:57:32 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b5609f10sm168685e9.9.2026.06.02.08.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 08:57:31 -0700 (PDT)
Message-ID: <6a1efd6b.fb590497.32f883.4058@mx.google.com>
To: panzhe <panzhe@kylinos.cn>
In-Reply-To: <20260602090214.252840-1-panzhe@kylinos.cn>
Date: Tue, 02 Jun 2026 15:57:31 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] gethostname02: Accept EOVERFLOW on alpha
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
