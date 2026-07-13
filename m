Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2484EC44507
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 11:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783940508; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=oV9TLLk4JkPBtOzVlnLYYRXhVd8VrB/UzdtbVuodl98NUu381UqICW0CzO0mbr6ptI5u4
 phUo3WC7XalwtqW3oEqxCnpFGcpp0slC2jGbZcLlx6ZYIOXIVBZBfCDdxWJwE5Yx7M8U6Rh
 wQaZOrj2Ng0Gcwn6n3V7Qix2T0+i8ro=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41F4A3E7AD0
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 13:01:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E618B3E265C
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:01:28 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4B7376000E2
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:01:28 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so2573807f8f.1
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 04:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783940487; x=1784545287; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=HMOg9V21AStIP81MSgMGx7nt0p2KgSwdF7hCpA1fyyoiijIZGhbAtDApRSdZPfZ9aJ
 K2wAjELPizhJg5S+E7Fx9UNUkokqSDqHDcSHRrR1N2t/ObyIetvsZikiT7xSTVOIZ1e/
 EL5xxXohUmFUKPfA3cNea6DssM8QZXe3SnKu2l3TdctUcJQXLYGRqnMPj7iicCMu+AJr
 an6GJZ5lnpnFrXrlndFlxaqypKsKn/x/n7r8tseVYEw52KoNNNUFR2QCf/t5JEN2D//z
 wc0mXn/nnmNoro1+u43amddF16ITMU7r8w0LejfrSRP3QveJl8eYl0v5zwTXfeuq4YJW
 EPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783940487; x=1784545287;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=B6bSktPHP4/kVtB9m0K1hRxZ9gZ6eDHpm5WiiiNBX+lA6MXhIHeT/88pM7wJTT97Jn
 ztFXb1hOB6qecA/iJAsltynG2XODIrd+4eFsotyc+Zj7zrgrNTbi+WUw4jNaBUolt8Jr
 rMLQ4DbSKmaYap+KB8seO8aTcfqumhy0nCchL5UycWsYa29T/PJtLcm/6AH+PfCBVRd8
 nqy2Q4f/VTJt5Vpfod0Bak6WpqqKRscWdC5N94cgAxHl5GlXuiJkcvku1eoxy81oEKBL
 oJjPnDEASoEe/VQ/hsRcGQr7GrsbFdah4gkFYHDM3JIjpTb6A3ZuyC/Z0AlRSWn0NuOU
 3Jng==
X-Gm-Message-State: AOJu0Yybi/iAYZKJnjI8/Z122Gq6EGb9okwevaP92CQ9AG9kthdQfaBg
 1PkVETVOa4INFIqjj8k+SqvQzCfGkuliiY4Tg6u758YCt8gQr8uCaRPy+20wGgltgrM=
X-Gm-Gg: AfdE7clu7kSN/YlYsVkeUg3kDmH0+GT65a5dXfNYQN0mGZJGyZaQjfQV1bdg2qb3yVa
 hSY4Gy5l9qmLgqFs2v1x3TT/lx4rIWDvrM6hcPZyECoCAEAvdsoYikRYcX6yscxbWQoGLTeqCqO
 1uGLAtwmHcvAKQ99ynuxUkZZPFE0E7EXDS66gzodr+uBdJf/PO+cwNzXJbFPksAxN+1gA1AzK9/
 fvo19fsPEBemTPeQ+/5XtoxGICTUUvDdMozRX0XE4oMIHbHrdHZMzLPWLLg7Jt/QdML2tBZ3JoW
 /g9iVLWh+hfYJ9PNqYlN+RV+1nnnXb7hpxQWcTjDQRVnsdOVteOorAytFBBsvUaiVWs1xEeMcJD
 Ne4ty4arHnhO04BZ30RZypFH6krItJ39DMIxn+D3zE1IFNKCVNG+Omp9/QNI7O404gskRmRC3af
 7l57rNGM0Z1N0Kzoi8xyNQuyhx588+Cbqt
X-Received: by 2002:a05:6000:2285:b0:473:6e8d:7f3 with SMTP id
 ffacd0b85a97d-47f2dcd1a25mr10155053f8f.1.1783940487468; 
 Mon, 13 Jul 2026 04:01:27 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9b4d850dsm84906884f8f.0.2026.07.13.04.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:01:27 -0700 (PDT)
Message-ID: <6a54c587.41a38e5f.1bb169.07f7@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260710055556.1109220-3-pvorel@suse.cz>
Date: Mon, 13 Jul 2026 11:01:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/8] metadata: test.sh: Print the test name and
 result
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
