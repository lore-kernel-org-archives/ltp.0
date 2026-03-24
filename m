Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E17F54AC5
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774363802; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=acyZNO5mJq8nv5cRzBEtobWo3WjvpxWNEdTUf5qX1TU=;
 b=U+s0ljsUvT9e9It8pw/xQJli7IvN0Hu3UamX8LKm6IlGFwu4gAWMLb9vq3deOn8joUVEe
 9MQdJL791ofnJNcE1NWSuyqA3F0ahgEjkKp5TCyVpLXXZr9premvFlIwPwQ+OaW6/HmHuYR
 chXiSwaYIoLHPj6n9LgP2YZpewxJiq0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 254373E5546
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 15:50:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EBB03E1365
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 15:49:38 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CF9ED600629
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 15:49:37 +0100 (CET)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-439cd6b0aedso3653568f8f.1
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774363777; x=1774968577; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=gqflRfZBduBVetgGj/2qCj/GEfrqInvMB0ZscMYk0T4=;
 b=IUZ820k9dlup2fiOZJGoCzbMHy/r5c9xAOkIdIvr4Up5UjbW7JEhadt2jrtswemPza
 lJpwc+XjGkSViSQFmHa5KXWZtOG1nG4Skftw/0AgglamDQY8dIIWPgwHbyqMDhp2J/kV
 AuSFQlIA2FydyjVeK/ygtJeINZf8xMaBW5deBQ5Pxv/r9nZb7Tpez3JLTOwGbfRNiUmA
 Nysj1e53A1O6b5iA3DWk7XTKTRoxEkGba9038M+89h4/npUM+YJMo0i2TBrvo16e4fR5
 N5KtGdJF/qs5uGEDKC95Gm8BgugIXe0EhaGIXb0CXxcBqxvNIEJj5LpSfMESde0kz701
 OR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774363777; x=1774968577;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gqflRfZBduBVetgGj/2qCj/GEfrqInvMB0ZscMYk0T4=;
 b=XtBMV3Hy+8YrsWpS9OCoBG3/WSVU6NFfpVup7lHDTopbHQX7dK7pd8+pWiZJgYH7zJ
 RhGuMG7UGST9ph7xHwHmCksXnjfR/PZ0/ISJE5qGRF+qZ8eecT99Dc788wRXghrHd7AL
 DZt1d+OFblet92dBKZ4Xwc/KG5CcEYDFFSXzGSk5nf4UiTijVuNjdz7AehQjWAe8v/6+
 0VyjLmc4Xaah5oXU0frSRH8/+eAdypHFGbjNi4r7pj8zsNrLWdWtGRv4zEU0VL1aGjSD
 uA/AgcDAJpqdLw0TeN6DmKY5o0c32neYXhtQPGkG5CxlxUEq7jLdCzIj2unWhSvyFtAg
 Q7Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTLJzTzsFjybFx4cdiwk/s0Y+Lrk1IO9arLiF4oQL+k7ASVMz1i1Dua3imUoml7RgFz8M=@lists.linux.it
X-Gm-Message-State: AOJu0YygTyEWRVR09TTGRVpSb/llyNKnkvy0RA8suqsXwIOyiO7MIzlG
 5YoGf2p35F3U5CQxo5Kp20y/AYZhzNianNzM2co1kR9P90kELpf8g/Dm0oQ9Dc/SLVc=
X-Gm-Gg: ATEYQzyqzoR383/MMsIh2s4IzHRjJe6crhl+plzC7Mn8g69aUMblVq3pLBswNGwQlUd
 YMO3B8d+b9hoFFIAFBlAg5oDdcnaohLQwy8rH9BdAmun2OAYvMSFR683uwwICHHo8g52cGY6sd9
 DMlI4yN9O64GK2NsNMUSy+g4gkQ8Tr8koM8D9qn98NBdy8n3xKehf6e0Teg7E94X9Vuz97Cg8+4
 NjhvEhl27wsn89JFb5Q1/IItgwGIVDeenGfggm+3jRY+2T6nCs58nxhBV51D7EdmsD5zskRnC0F
 qPh08TZIt3hef0IxHgWiY7/YmnnrR2wkdx01bfhXd2gFRsrnisCrpSAteiAdyl6z7dJg9aFilt8
 FExxPTN49PoWg0ocd0l40fkyflYdp72R/YFxPYnqayN7vzDzgT8/lp0Z3GEMwOcSH0yktBc+/Hs
 Tg3ieQdlwsvzaXiUvtzBPZ/M3/dLpoHslrWOgIpePQ
X-Received: by 2002:a5d:5f53:0:b0:439:be04:13c4 with SMTP id
 ffacd0b85a97d-43b6423d85bmr24659388f8f.4.1774363777160; 
 Tue, 24 Mar 2026 07:49:37 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b8508285esm4138152f8f.19.2026.03.24.07.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 07:49:36 -0700 (PDT)
Message-ID: <69c2a480.5d0a0220.19bc2c.fe83@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <acES9_FiY3EeCpPF@yuki.lan>
Date: Tue, 24 Mar 2026 14:49:35 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] Add listns fallback header
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

> That really depends on if we want the next release to compile cleanly in
> a year or two.

A bit early to decide. I would keep it as it is and eventually update the
test. WDYT?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
