Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92A606A320
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uVTSUHiQ
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA0383EA9BD
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 14:33:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB0433E304D
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 14:33:01 +0100 (CET)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com
 [IPv6:2607:f8b0:4864:20::1336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1759F1A00996
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 14:33:01 +0100 (CET)
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-37198ed3727so2460838eec.0
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 05:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795008779; x=1795613579; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ma1UrJhEMw3tOQrw/5Jc5au68IDTzDiFc1VLI2lEE6c=;
 b=uVTSUHiQjSMTAiMMI9PG60EJtnm39DKnNieFEKNmVPasOwKn/+eLlxcvh9vgIdaY0k
 dALhNOJW2be3X23uKxq60UZuL1PWXKJUMOZoIkQcb1C+9LlAzgn4KQhvXAQyajphlt0o
 7PU0FF9fCSNeziQmm3NDS0Mgvp52UHvK1+sxDsSzbMPSlCgcgTYvTJQRtD/8QGFWIHQg
 rELkDYJDI31XLDAPBQBpR5Mrp3V5mPGvKLkmW2TJ1frH/xOBkL6pHA4ubmdaBmvww0Na
 xgf+A3tLHKj4Vj1eYger4OzuLP1xgF2iFEhGqNcxH9tYEm7lNS4MHG596axlNhW428Wi
 hemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795008779; x=1795613579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ma1UrJhEMw3tOQrw/5Jc5au68IDTzDiFc1VLI2lEE6c=;
 b=tRwaVHiw9l10LHgNkeE0HKSE85mBO+PhTzYsr8kYCLWzl11P2ZpjGN1IuxXhK0QnBh
 nVk5YaV9TdrWcZwkbU1AvJ+WnI3B0dgtccSR71e73GwY0iufamZtvHkWhqJhjv+ZUYqB
 z23oDbqgoxr9XNnG52gEvi6TAd4neUyc41Nj8hy3MgHbO1zZGcxhxTomTPJT4jn7cWFv
 559TdIqtpZ2k88Wiom/I+CK+zJQtrPO3JL4Yx2TIUji9LFjbZrau3dPAwh+RsJ3Opp4f
 5JVSrE4zNyPrqpFT8EM8zCodqjM4UAXX3CrhmCtw02SmZyLX1L/yHduy8cm6G6XnHQgh
 H7sw==
X-Gm-Message-State: APuU4Z+lWznC3KnPqr8uyD7Wyn8OI8vEF1K23S/LRfAkYbuxC0mTiHoh
 NdhSKoPZ8Mvn5zxo2IKTqOH0uRqA5w2WkWBS+wTMzhKlUjmsMrlJbdce
X-Gm-Gg: AZFdTZceO5faevwrlqa7MmHxsqW4/Clx+M7ZqRIWQQE9GyTtd4FaL3Vkn//ODTB+nRs
 eUwHOIGtuLgPph5FS5evHvmxDxtUrJ+XStpKaD6fN/aQYb3A+QCoa3CvhCAb0Dv8sgFubXl6GYD
 E3tASGTQzLRet+bzEvNxutL6RLvCguYOUZ6BaT04F7qSJcR64CK2NSXLJ1PgikKK5Lo09/CkZRD
 shZhynBOjw9jCrhkQJmmA9WsVM7mha/Rh7taf1NphlCIae6xDFQTgHKw/SxCV9qwO9wKzHV+g+G
 WxdtwzQxsT5wfT3Buk5QC9H3yeNpN07TM+RSu5jJbn40ZMdm8kNqcanK/4GC1xwOI3CH7+Xq/dH
 OP+yN93KDayQzvFZCYNbNKVy45MwdU4JROAERZh5CdCBiuwxOI+tmZDS8gZAxb8YVt8eLwISf0T
 6ARz+bpWcOacgVWvw9NTnhlKGiseDwLUbOkePXr0wHG2Fi1AeG1Yl7c8JeXGS+I2jNijZDfyTAf
 0Ykfps03Cs64lJlFkxkImNKPOyb/MDwhLcDxx3C68oFZdbr5FBIGuLkWLH24O67fPbSBjCmJ5su
 KCsbwXs7BJ3Xx5NBf92EtZhl6c6hB2A2Xiazas/eB647zqlAY75kJQi13EskPyuCxX5sFtdZM8p
 /aggzaOLfUpCf/hojzfrMEp0aF4n1O8lALR9PHkUj
X-Received: by 2002:a05:7301:460d:b0:383:6f73:eb34 with SMTP id
 5a478bee46e88-3836f83337emr644965eec.2.1795008779084; 
 Wed, 18 Nov 2026 05:32:59 -0800 (PST)
Received: from
 runnervmccnms.2hnxei5tfybu1e0bbkcnqnq4pe.phxx.internal.cloudapp.net
 ([4.236.89.29]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a45260a8sm14160362eec.3.2026.11.18.05.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 05:32:58 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Nov 2026 13:32:57 +0000
Message-ID: <20261118133257.3734-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118101720.2838268-1-chrubis@suse.cz>
References: <20261118101720.2838268-1-chrubis@suse.cz>
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
Subject: Re: [LTP] sys_rtc01: TCONF on system time mismatch when STA_UNSYNC
 is unset
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

Hi Cyril,

On Wed Nov 18 11:17:20 2026 +0100, Cyril Hrubis <chrubis@suse.cz> wrote:
> sys_rtc01: TCONF on system time mismatch when STA_UNSYNC is unset

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
