Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA32606A31F
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Uombz0t1
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7EDC3E619B
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 21:05:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEB0D3EA672
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 21:05:40 +0200 (CEST)
Received: from mail-dy2-x09.google.com (mail-dy2-x09.google.com
 [IPv6:2607:f8b0:4864:36::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 306671A00640
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 21:05:39 +0200 (CEST)
Received: by mail-dy2-x09.google.com with SMTP id
 5a478bee46e88-35adc681e1aso5002970eec.0
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792436737; x=1793041537; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S5Vqcveq1tiAhUYwAFtcW0H6DarsdKe40PkPVphu7vM=;
 b=Uombz0t1pR8Ihcc2qlWQlCMEbiEeNc5ERYn4wQxYj6o3BKpgFCI2EKs5GAdDlh0Dol
 eCU2zpmyNMqljUTeu2LeeU8SwjgkD2Opyrw2O7qMJ6Rlm++2AEZoqYbK59lMZyh45EEw
 DBAP1TKDegl+oOilh5UXVGajcJzys0YbSyyt6VPcg37WrD9Hl//Sj0ZGMQAvxoV8+vVR
 Faq1uGEbGoPWaTUc+zO1BpFXlkHonlBRoUR9eYbPhjt6kfVHkLd6SlEVv2Qkw3g+bo0B
 G/OAlgoZimzRaVzPPlFEcNYJv7FTZHcFC12zcXkCyFz5KJdmPVSECEwnotB+H2o4pxbM
 ORWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792436737; x=1793041537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S5Vqcveq1tiAhUYwAFtcW0H6DarsdKe40PkPVphu7vM=;
 b=2FYNxCgjk7wAbOnkvJPCLs60CkObCHFPnl/QuVZSjn99dTOvMiWw4JlgPTUoNvW0YX
 Os+n77AbYXjb3gcZ5NcyX6tgQYt5ywVxikWN4MGc4EBjMDhECfq1v2zu6jA/mkPYTWJi
 oBIHd7XHkz0pRbjjQOhXzBMaMqdytxReCgxA/GA/jAr8SPVqPY3toSo3/KDLKLgiSrFe
 eAf54nC09djRbS03Lm7rosQh5Sr2ik+Yya5GNj9Ho+yCrwK6dbx+PrmcesMUlmfi9pND
 Xk8DalJFAWjFVQpNTjRoOGxX/9q1olfV/sarL+I9IX2b85s4wpkqF1/dE95+dH+6O436
 3Ing==
X-Gm-Message-State: AFq9FYL6hjE3Jsw6VYpi0/NxaFfXxYT0tlO4QhwkEle/hEPo0skNbGlr
 oJYHCxUfVjWiluPcHUS+Wl1Np4ZRjBA3UU7kh8rJ2FQoMsRLWCT+sh34PfCiyKU9vnM=
X-Gm-Gg: AYBFou00zJ7g+G+LI2THv8EmkSbq7PT8FMuIMfkiGFk8Ht8BDi0qDQllKDtiW5nhiwr
 F+QSSGW9yTzzqofSoAgQzCuLRnsF76GWGbrmwzIlW7wtY4OV+2BLpHecj38OVM8tUuy7UdXMeIu
 ergq5IBR7cqq9yXSgVKNaiAFDFLS2dObThrk6q31O8KX1W1JhFBFNSpg9J8bUqz1aBWZucbGZHw
 nXCXoIgeYRDKSRrbaC37rwNSmtxP9tAluRo68qDJWLKAiY+quCMbeYu3hObBiz3HOqxPcJqrhb/
 CcnXlOUXqKa1LOHQDbMu0lXICI0i4GtG6f2Scb7+bxbp5GMjFSj7gkVzNqLTx4EFMl0rMXzTXT3
 mnjZzgCe3vYYPOqcc2kJLtVMXyNx9eW+dPJn4DnKNDIQvPMyeH+oxWUUea+YdFXZjuuLq+c4lxj
 YwjrTD9aLhz0VSAo1Z04KbFguY8FxrISngPPv8288f3Vx/UwZzJU1hORPdfg5PNVIn1xkDMrGXa
 EM6nG4sRBT30FSX4i5lJsfFsmXEtD10AovBEJXVkbX0iYcPCVHnJc+6uxNBmwToA+YwOeyoiAPL
 CtPo4ldAPedPpA0PlmefX38=
X-Received: by 2002:a05:693c:87c2:20b0:35e:d765:77d2 with SMTP id
 5a478bee46e88-361a3b053e1mr13028082eec.41.1792436737323; 
 Mon, 19 Oct 2026 12:05:37 -0700 (PDT)
Received: from
 runnervmxehtw.2cyvlgl0p1zehawpflwh3pgf3c.phxx.internal.cloudapp.net
 ([20.163.63.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360813b63e1sm35830728eec.8.2026.10.19.12.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 12:05:36 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Stancek <jstancek@redhat.com>
Date: Mon, 19 Oct 2026 19:05:35 +0000
Message-ID: <20261019190535.8983-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <89fe77f22e26d912865c8b8266b150ba7459bfae.1792413314.git.jstancek@redhat.com>
References: <89fe77f22e26d912865c8b8266b150ba7459bfae.1792413314.git.jstancek@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] nextafter01: Check exact results and convert to new API
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

On Mon, 19 Oct 2026 at 14:35:31 +0200, Jan Stancek via ltp wrote:
> nextafter01: Check exact results and convert to new API

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
