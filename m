Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648E2CD98DA
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 09:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781516579; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=QppCyqkEGCcs6amV6oZSfYRIsCw7HcHlxUzd1dCb49AjlgzXKY+KLQREt/tkAp/vXzZ+Z
 /Dg8T7yz9O8i/1ua/2wULVfOCBeVjOYCqDy6JDrxc1PjftCze0+39b6NMvn+aqhm+j/bBG2
 2D1TldJ1cslO63piW1AO4rmRUQGZ8KU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBE833E5B53
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 11:42:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 160A23E5B4A
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 11:42:41 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7897E60086C
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 11:42:40 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490acbb0f89so20063775e9.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 02:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781516560; x=1782121360; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=e4JewhZb2u/zMsD3ouvSQ6bR5DdnDERCrtDm7HVS8siAlAYSu8JcUuygomBWaXqR19
 m2gTPJArRF3KEbQIfZjYzpzAVYr2bD3fsTt9mKVmWbxVGH8i34FVWdbG3QRG64nLHOvI
 hHzbpPKv0rFL5lh15PgRZtVmRdBzrtT/wJZMEa7SXrSlw5XNDO0heTbdnDXYzfW6wRX8
 j0RuHUFkTTSIEwaLi0zQWS7rQJx74JOCMpU70X/voNOyNwuIHrz8AeFochnCD20Nj1UU
 s5MaAdqQz/BVId+ACLK1pjlNOAE6aIBoNykwU43Q3w+3zCcI6R5Y3/kC54XI3yiiIYjo
 HvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781516560; x=1782121360;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=oO/+jIwF6C0ZUuluC2ZzpTWvG1ROCRLkMipfMmgHkA7pw4ZpX9KXynvuxpmIx8aZBN
 QVuMJVsFkE0rETC7miT9moxLLr9uFdQplRxQtsufECMRMbAq4SlOzoP4xG0FDIjBRDNw
 2ULjgL9YZLa2ySfUVSAbN3vI8nYFCg700djy0YlhJ1O8dF/UxjuhvMMc8pMb8p3cWuL1
 Gu9ijot9YsW5v7h8bdMybYn51jh1ay3JuhbXCTSCkzk421F/kmNwL7/I3iS7Dy7RErXX
 SBcKB+JydhT5zvLPGF7OM4RsjcxySFwFXvQ0mBdZx/9eSocyavW8OjW8pCXSHgpmdHlT
 4gEA==
X-Gm-Message-State: AOJu0Yw4JrXPAwofkrTlPDwoxSDPP4OJjtVWGYAbFd4/qdnbqRus85Yc
 +h0RxSjdHeUfi1eCe1ljHbCA6oeHZulfv8lHs2JSKFMbOst2ATxsin0F7Sb3BbcBxDkaMhVBEhB
 MrNMAZ/SdGA==
X-Gm-Gg: Acq92OFANEdhF7TBZCvay7o++wn5KeuBRAv93stogXi4N5NB8QPRW5wskMJHhXw+zml
 lI7C9WhSaNzVfJd6ni8AExD5qv28UN5Ges9OLFsMVzNUwLD2/44lqlAPQKKLIAxD6XVaWsdHRgX
 kqCFexyzC401FwzgUfypJTbJX8wXT7/m9+5kRNWSqDJ59GoP6u53aVUJuZZ08dXkWpRHQx1l8vF
 TDVhF9QCoaeiL1Fj3Mu+fdAMrFAr3lCyEu8v3TgLHvJZuNKGg3hwr6rk15W9Nr/jSoEQ0th37mb
 YkHZ7J1EwX4fRtW++XuheuON9KMVuXVtW2zlUvaGkpbA/BTZc+HOZme3TmhYYA9qnCfxHX+6vKe
 zEc2jNs4ZCxLrb7VYW9OCMkXDNMzbeHyvBjDjLY1AbkEYMjsDcQ5t9Hx6rl/HK/hcruLH0eZkZq
 aFla7p13yR7g0R9VF3u8i+Yejy/4mHv89yZTA6vKmDxWc8K2FxWbxNF/oJ0EygOMlGBS9qcfmE7
 rx15L9ZLZfYHe1bTh41qPqHqyzpqEA9VoI=
X-Received: by 2002:a05:600c:3495:b0:490:e18f:d112 with SMTP id
 5b1f17b1804b1-4922011df49mr123654075e9.21.1781516559730; 
 Mon, 15 Jun 2026 02:42:39 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220207efesm204830125e9.0.2026.06.15.02.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 02:42:39 -0700 (PDT)
Message-ID: <6a2fc90f.f32a6769.125ad9.3a4e@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260612-fix_clone11_min_kver-v2-1-90cfb4b687fb@suse.com>
Date: Mon, 15 Jun 2026 09:42:38 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] clone11: skip CLONE_NEWCGROUP on kernels < 4.6
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
