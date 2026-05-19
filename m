Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC922CD4851
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 08:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779180221; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=fe9qeR9OtkXjRIGuQ0xC2WXn9njhF2PKIVXHyfcxs6Rhg7Pi7U5V6xrsJZ29p0/iPHcuc
 sKflZrZdIl61nWnqC8Y+UaU5eWXzZue22XjWaz92nBhBuy7ijcU67kZXlluXc+aQRNgIeE8
 S9OnySZz8QpV7yg9qqWpTk1bAGHdu6s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 336193C66D8
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 10:43:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A32A43C5EE0
 for <ltp@lists.linux.it>; Tue, 19 May 2026 10:43:18 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 47A5D2000BC
 for <ltp@lists.linux.it>; Tue, 19 May 2026 10:43:18 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48e82c23840so25417895e9.3
 for <ltp@lists.linux.it>; Tue, 19 May 2026 01:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779180198; x=1779784998; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=YUxEPEeY1/H0Kn7bq8AgC0NTjmfuHDAK+aZ6py3FTpEXy4TRScr5IjXxMBAXmNeLkc
 ANR8P5wL5PjwjykGWY13Dytlg1AYDiscpy1z7DkyZzU2th0jlK+ElBo/OfDnmXm8wRMG
 5yUnIKu+EKxz4F/OC26HfYNdub/PY3bc2tyRJgud0gkt9gZni56w9ntAO9B8FoVvEokF
 0ilLuA262FiIOt3tvFOYOh1PIyHfRGf+wULOLm++1vfB4pxN7+Ug5XBZeIjsCc57URxn
 tSufaugerUW30s6Zutm5ViFTddWqNYK1AxJ5x3L/jiLyiSE96p674zJ1taOUxSt5HFgS
 M/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779180198; x=1779784998;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=DyQrs4o5AUqTOoy4RYL17Sgs1Uky7synfF4U/qqa3Q84NxG1flAyJ8JKCpi4ZEveJp
 PskEdbmWMKwQz0siPLCi5eiOPDL0+JcueCYDcCWdH+hIpN1x/0ufpvuyuundtI6i6e3N
 agDsm9AMaWqyVZcstV81fbCtfrdlbH45tZnXoAJOSE9TVDCbz0H2Y4BZ3zJmyjiYnqQ0
 sGctdtyzSSCeXYZYynpkpDzNvpRq9LgxEnOE73AhCGNTNr3c/mWb8E/Y+2b1yUXKC//V
 iGBfcIK6xETxiDg/CJJ/VqtDBo5nSXlqHWFu61xQUkOArdFBDA94+Pv4TCumkMi4gTNi
 rxAw==
X-Gm-Message-State: AOJu0Yx9ao+0IJQ6vLNaNA1IPq7rk+JVfDJspIxbNTAGb+2hyGtn3PBL
 uCm2tTrXCgZg772lm29iN94/OIxyZ6C+B7JTbLKXPkj1w1Nq6q91YxoQUNYghTOG+NeTf6PSDId
 7ClL3LSm8EwQj
X-Gm-Gg: Acq92OEoNEosHdz7ihoKDl0SnD1NEZSw6JnmrQq6LieyVlkQmYs/dmF3QDAYvAPVCMj
 S6uYA6Lyx3rvTRJXZENSNX21bgybIMYGN0fLZLHiCZ88jCZat8txeNnh1r/vEU3De4rXOWynoRW
 1KcCkQqwfxfM21mEx0Cpsm8rcs3twlptXKP+trcUjkQChU8CKrX8nTiLN6AWwZlTisp1Ed7Nevw
 Q21enNSp0FNP4YfbK+aDobmn7Py/0+LJ57AZxmDMlAMSbLT/XmdUxfUsWLBI6UnBj7yKrsPRap3
 VibdnQzGqANQ5UDKOwqMo+QYUUf/5syWt9LTmE2Ha3Et1/MTABfq1/vYCveiP4f2F+NMhHlZuPK
 7FWRM9NMcELKb8kvVYxyzqFI9D6Grs9jf7tJrw0cPNg0X/ePyfGn6HqZgo7qMNwuclKiJUIu2Fb
 gxy2S+s09lCJTQFJ8PZUxu/DlDnzuwW1dWuUrwG3m1JDNvAbeMVPh/hqiNI3tVSOqh94Ywzvxn
X-Received: by 2002:a05:600d:8496:20b0:48f:f7cc:f6f5 with SMTP id
 5b1f17b1804b1-48ff7ccf76bmr132378925e9.31.1779180197538; 
 Tue, 19 May 2026 01:43:17 -0700 (PDT)
Received: from localhost.localdomain (wl.mlade.cb.wlnet.cz. [193.165.72.195])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febf81970sm143269305e9.8.2026.05.19.01.43.17
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:43:17 -0700 (PDT)
Message-ID: <6a0c22a5.1e1038c1.175b08.7bc9@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260519065757.7693-1-wegao@suse.com>
Date: Tue, 19 May 2026 08:43:16 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] af_alg08: Allow EINVAL when calling recv()
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
