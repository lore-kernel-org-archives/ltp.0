Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83102CA5FF0
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791206343; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=aVcfwkVYaboh5MkGFL9sQbeEmFOmzMV4Ffv42u49lFY=;
 b=RtRZPBkf5UU81kxsyFFra4A5MJdDuEQzCM82YNGLHUCG/HAiG3EdRfYPiWl/dhNS9XKut
 03ESk+kRDjCgLWSpMVNk4GKhnQC2XSRWxqVE/SH79RPrMnhGpPSMlJqRKGCgWn5cLDX4GW0
 GwKLQ3STGxkkFS8KQNlXLiJa7qm4LxU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 250C43E4D68
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:19:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D77E63E4B3E
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:18:41 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1F8CC6001F7
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:18:41 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so16323535e9.2
 for <ltp@lists.linux.it>; Mon, 05 Oct 2026 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791206320; x=1791811120; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XziL8CpWuIt78GhQX2LycApYeSDPmKI98dRC9ChQOpo=;
 b=bQQqZU4nflA+Lm5g17kFfdxeljiLd/RJTaTtAPVeMH0UBzxODos8aOtYRjUTU6K9rN
 r+QdE0REGoku+8zHJwK9gG6wOASZlfjrtzCuKQw5kectoh8quw1hLXN65xcRy5xmbMg+
 dNe1POjWpcR/Ua0zRFy0taipit2mZgM57Ww0xugRn+QQLr0djaHxol/+YPec9PAKeErs
 KNBu8L/gyDQ2ZPWIV/pTUoBVJLOnNhRjKZcMERGfg/uOSqVsInTMQwLW1Ucedykjc6RF
 K0yHwAbZGjt1z+CSQRBGTBORYoOKI8zZr85Q5CiogHSIPwJ4ApBIPz2FHSn/k66DK5eg
 Gn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791206320; x=1791811120;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XziL8CpWuIt78GhQX2LycApYeSDPmKI98dRC9ChQOpo=;
 b=sZMs3q6x5m3Vi94HMjCJA3Jm1rDoWEjV4My8ZOLWMny/+U5vczMIHA6BQWMCw4cVJZ
 VxNlfacvjvYF5IAZIYHYoHaf8m6sCyCbSdAzZCi9+Mx3TE8RPYyQFQuwlaEk5iMzPbfe
 SJYYfDBBxwVh7OkFpQXsMahkS9tGFggW4aMB8+XZX8y0SegJmXZ5j7PNzfYFvNGp1kBa
 JiUGPSzgO9eHzjFc5jTeZelYuVHiZ6sRzLz1TOzVx9bus+jsEbo5AdyMH1AzEi05t4IN
 r1XCSzzF04fyBGa4LdgvFh3ebCH5vl3Y6l467UnrJcMwN0WDbnCHfZRGPQgZV1EZkJOg
 sKdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUEqs8qMOSLCQmxrpYo/i6uLNYxOd64XTOf+SKPdNRPUjgsWkQf+uTst3tSNCP01Sa7wA=@lists.linux.it
X-Gm-Message-State: AFuF++n5+1mpgotb4IhciIk9hd8oinPoOE6J2IBZr7gOHCgMq7EixSqY
 3Q9FSoTkfWwejVcOBV4VCumUZ5xK3pq8izISn29L7UoNJyfvgrgQluIqs7Wio1oJA6E=
X-Gm-Gg: AYBFou0l0vg80zcIG5+0pZCr0nC/J+MRYs39rTM+nDE+A/TBwKBPgCww2sVeccCwutE
 wg4RG8mivks/jsSwflB86n+RFI0+lKSl5gyOn7PQfdxTxKxzlvVEfXwtS8wsU02fLiOHpXIQLTW
 8KXWArayf+pdgLAtRp429H952EwuvyFscQsPDb0uHvB+z3suya3F0WAapgQO1TGzQEpecgpNf+z
 fWo48Be2y9JogdZyvUdTaz3QyaJlGnD5NgGiwLyQf/4TZbgfcm0coLBJgbjRp47RniCp/NfuPIc
 zsgkNkiDwFBhCGghYD3JsNXRg1dOHbAuIaxFKH6XctiLFxO1aWPyeOemqmjIGPQf9eCmBHUyZ8T
 rUsawxX5dZXpBt8DZJ6LSljLwYxQQ3A3ffIKXKrf0mHEsBd6xpbGJEM4DADL8t1PA5suW43tfO/
 dIAOCrnnzCVWoLsYSd9DVZnr3hk7Kobp8vcQuRh1XrPEqvaWYeA/JVRx1deQtHUxOllYMCzXNad
 MmOurQf0/PZt9yMD3JlnhVxB9T9dJArxgCE4t6Wa5qSp/Y=
X-Received: by 2002:a05:600c:37c9:b0:4a0:159b:d2a2 with SMTP id
 5b1f17b1804b1-4a1680f4309mr114068545e9.29.1791206320368; 
 Mon, 05 Oct 2026 06:18:40 -0700 (PDT)
Received: from localhost.localdomain (p50918b5c.dip0.t-ipconnect.de.
 [80.145.139.92]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17125adfesm113720595e9.15.2026.10.05.06.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 06:18:40 -0700 (PDT)
Message-ID: <6ac3a3b0.d8ad2571.1f7eb3.6f50@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260918125156.8501-1-linuxtestproject.agent@gmail.com>
Date: Mon, 05 Oct 2026 13:18:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/statx13: Add basic test for STATX_WRITE_ATOMIC
 on regular file
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
Cc: ltp@lists.linux.it, Gaurav Pathak <gpathak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

All AI spotted errors are correct. Please update the patch.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
