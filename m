Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E5606A319
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=q4rbTR3W;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=SKXosBIa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792577088; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=q4rbTR3WJfMdrNajdQG0yy0cZe2VzcAm3BuGyUirrQT1X2iSankPKmmITC5a7Is+hcnSJ
 vLHFUwJSBWgPEhMFyXbWjVPD3QP1j6wAxOcl/tN+ibpjv8e99ZT60BBohSTvsU0xmTjd661
 zdZvLjG9SjkHLQWPP52Ic2AWw4PzgF0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AE8F3CC354
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 12:04:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 142243C01E2
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 12:04:28 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9657D100098C
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 12:04:27 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so4075835e9.0
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 03:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792577067; x=1793181867; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=SKXosBIal/jAVJ6BVNOUo2dws/ChBw/UMRF+oGHyZDxZFm8ubNiFsoYSozbC1ObrWu
 TZuWinRALCJ3uSFX5KZQQgUg4Eo8GfkFUR3h0AwWcNxYY1u2D0TucnaaHYM0gqnSMWcB
 VHwjrWnBzOygb/8cMnN+XvwTtiBrohZb4IqeRq4dxCRGGvOAN2prDmWx6wUfzvMLQ3cU
 fehCgIMMI1Y6aFkiZizaESNonfYl1WtcbudYHFPR8/ILzkCKaTNQHIHEPAUT8Y9bDyPi
 r1dXj8/mLlho2j5mAuG7tGjuIYLj6zeDjIggtm16sETWUsMNzz64b6f1gqU63fLtd6Y6
 et+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792577067; x=1793181867;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=IeR9SZ9pjanEmiCDi3ZdaOtBvoAyQ6bPifC697KIWaEcLgmyHTYCnDq7/mZvgE8Y6V
 cOvaFlBrLAxpp7wykio6nttRV7RZ2/BdnuG7Lfl5lW0x9BK/jhzTY9lZ7i7DdFUB9ScO
 fqN64EEzrTpq5agcYYMeJN8kCe5j6ubgNQbg6RoQKuuvpyjXR6/xgHGLepgFCjeC19Fz
 IJB8dNIM14c/wemHudTvf9rTn3uUTnzpnwyem+obOjCUyTQZBpqeOIrh9kilbLNqF51+
 J9nywmQAbbLEjhjMVKckOdj1iyyQyuxEwiklOWQpyaRXflfsUBAgZmG3+hLmaShE9O7T
 7bAw==
X-Gm-Message-State: AFq9FYIjAHK878P2iuBMLngX4RGLcNUiM0ypj6zkaINh/yhkOBHqEd5w
 Jn6MXM4pYyfEsr6s9wWxB8T2AWpIUFWi32Tt47QW/vLwrXgt9JrHe+yEk274WVlVO6RMTBgfqJd
 RDs/E3jI=
X-Gm-Gg: AYBFou2ALrFXyPNzD+KU8qMXI3z8Y+H204cW527t3x99Oh4WrvbZsm94fQb2CHgnSUh
 ck5XUiS0EzdxAahDc9kkzMEgPh0/Wd6LTapDbOo4POz39gOwoPt2P35BHizKXSnRNfEuPt3B0Pz
 DcyuL21GRg+keHvIMXoOvj46+xqnpomFf4ZceMkwJ4aRuQ1WBAuIL0/Qo5/s9fyXTgy62raH9W/
 gnHnyLcFomplNdEp8QD7IEwx037x8AQagqf2lO2wJJggms50AtrfuWyzggJ8rod3rmqiQEsvWIX
 GXEPMcSy2oSeaGUPrtgL9w7skr9P1utJ4EAFSukA7VgXBNlXR1opKZD7iqWvePD9bkLE+fJUcxP
 AI1UQkuPWP1MBYApQ2MqsXFGj/fQQh5Q/R26E0ap4KBMqPsw1MbkZoaeHGZ8Q9jT6zl0Wqw5rf+
 gWFikyzUDyQTbuGL1sa0zR5ZbINT3/Vd3gyM+q6VwFA6oMPgeYRo9W7ndCBJyP89rzs8WOUoTaQ
 ua92h2piIlxUJ1HpMnwx728qq2Aw6hWEto4gXr3+w4OQPooo+XTCtUGhSTmtMk5bQD0/6fvEWGn
 4ZK4TrE+xoJHUTz43P/A1fc3OWPeJGL/y/emrkN5+OnyEz2kP6CJcgVE7JI=
X-Received: by 2002:a05:600c:800e:b0:4a1:cedc:ab51 with SMTP id
 5b1f17b1804b1-4a1fdd3a79fmr36178605e9.35.1792577066899; 
 Wed, 21 Oct 2026 03:04:26 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d85a9bsm158264525e9.15.2026.10.21.03.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 03:04:25 -0700 (PDT)
Message-ID: <xBpQRflejy4dJ1gZ5Vlua6jclxapBIr0KF7n@localhost.localdomain>
To: "Victor Cheng-Yen Yang" <cyyang772@andestech.com>
In-Reply-To: <20261006020331.3791608-1-cyyang772@andestech.com>
Date: Wed, 21 Oct 2026 10:04:24 +0000
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Use SAFE_READ_ANY/SAFE_READ_ALL instead of 0/1
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
