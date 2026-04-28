Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA54FF886D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 08:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777364060; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=HFx07rxt9RQOlg4qRteaXMPN8ZDNO2KKtkEEXI6jQs8=;
 b=if+a1HKD0aKJ/ct6/WR0+7fKvTN3kl70Ek5E4NlQlyQC2KFnlZYxq0KViQBZe3/gXH/bF
 KPhM7ewW2lMgXARcA3QTbhlrugONfks8W3ByLLaAZAjvFsV2EQz7/fwrXeFG4qlfgxkSNVa
 jmElnGHyhSQYRov+YhoaGeCQNuborpA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 600FF3C62D0
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 10:14:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57BCA3C61A8
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 10:13:57 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5FEBD10009BA
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 10:13:57 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso111088685e9.0
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 01:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777364037; x=1777968837; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HxbyPqnuooBctLt5WlQissGL6hEtVNFBSJ3lgIQCo2Y=;
 b=KX4PxzTRK+/CIlxs18iaBIXm/P+vhnrnn2oex/Y1O5lkfdcJcZR2rRLAr+/VxXe4pn
 JPOjo8QJiaj2wv7/EWG7ZSrKs+k3pSnm2xH0vIKgXcVWBpxrvY+brXjraqhGH32ieetk
 yu3NdJ6V5fHnmmx1kYJhz8EyA4tlMBShr1g7ZTI8jEr3XkpW7qlfzxMDOcOlakGeiCzD
 cGj9dc2mGjeS9DTO9Q9CRnKZzPMn3W2UaYQ69QbXcTXcJZGAlobg8tlU4NYUjp1bicZP
 Zv5s5JKJbXRxn69f33kHJ6XLiqW0My7WfFJX6gOm5AID4etpXkQTa0vAol9GXGqs9SGx
 WL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777364037; x=1777968837;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxbyPqnuooBctLt5WlQissGL6hEtVNFBSJ3lgIQCo2Y=;
 b=IkkH9p3bB8hJnMzAg7L9DYqUEO+MMnaiKt/2XHMYtykxm00cTKw96miJ+1c6HgwU3G
 70kpWkzfTBUzM/qN3nzYGctM6WGuZIXmXapxrKKO+uxM9X5eKt8dCaxhaId0zE4vWzI1
 wIJaf8GevjwoFhI7cFjbUcoGtOYhTR6dqOnoTj6UiAqIq+D6kCY9io7gylddHErKYX19
 Jafcb6gQpDtiaHh2/RU22fjoB9ekvji9t/bzbNSJqrFxQwZXH4/AN1KCOdBPo2mfT4Jd
 K1HVmVkU/B/sxLhwwtYc5LVhojDrCJs4umpxaycrJ5+itRUfhvUu2LyReZ7w/MnpuDqy
 LAQg==
X-Gm-Message-State: AOJu0YyspsBrX5sxfW3DSD4Tab4NZCTT/EZO8hPqllFkaDnRR4vcOVXv
 gyfdSlPHATHt0acxzHRcsaaFtkRi7+kCnc9oDSe0m2gWRVioBZpgd3OHlTkj/zM8HFI=
X-Gm-Gg: AeBDiesBjEcDdnQ0njvgX6/zvhOdbWl6IGufmKdjVp8Uxf+2OUVlKGbXqme4w9zjMmk
 rD2XmUAHSqzMBdvOz6IJESqFey4TbQuArUnI78wchbAr4jtkumYCSYWV1gq4+lBjlZ84rCH/0N7
 5/uQdYGzb13qfM7TI8TZ3iKo9W/40B2a163kO/oSTwrpyhe8kCLfzv5eDqBTtctCOiH+CZ9KBe3
 BqS4CIYVqHRYT65pJpvzjacDddSOF+v8Pb5d5wEBDB92prDnZkFVUYZV3z60n0HfWLJ/h35T7N+
 Jc0R2djrlM/6WIW4rAs1FOAftLbgAwRR9KPXtW+pkbOPf2Yo2NI4PKnO+2aE42lNylRVEe+lZJw
 WiHIIGq3TULPNoP7h5h5YF0FdW0lxaEGlEpdfyOXNch7Sw017O5cqli2nS1iMlIdGQNkeK7HKs2
 CjoM5ycunJdiDSXlBRRP5AtC1o9eMgM30Z2CwrKH7KQiTQS7issoJuRQOyzfmFfUc=
X-Received: by 2002:a05:600c:1d0a:b0:488:f453:b976 with SMTP id
 5b1f17b1804b1-48a77b2051fmr33733275e9.27.1777364036625; 
 Tue, 28 Apr 2026 01:13:56 -0700 (PDT)
Received: from localhost.localdomain ([37.162.207.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463cb59acfsm5786961f8f.2.2026.04.28.01.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 01:13:56 -0700 (PDT)
Message-ID: <69f06c44.050a0220.368a7b.a5dd@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260423084123.657690-1-pvorel@suse.cz>
Date: Tue, 28 Apr 2026 08:13:52 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 0/6] lib: LTP_DEBUG cleanup
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
Cc: Martin Cermak <mcermak@redhat.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To all patch-set, feel free to merge:

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
