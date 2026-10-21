Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2165C606A319
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j5/XmewV
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87BF63CFC40
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 15:35:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C5B73CAA4C
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 15:34:50 +0200 (CEST)
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D0E951A006B7
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 15:34:49 +0200 (CEST)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-824f3901d55so481614a34.1
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792589688; x=1793194488; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kxpaj+ImW5ATaG83U0skv7HnSn4U5qn1GVlsU/ohJwg=;
 b=j5/XmewVGLkO+/NCevN/yP2Nu9r4u8GzcrRNdQvPsQqkYWrjqreE+iGNwCklWvUtcH
 Cij7sywCJIhdgNW7BTC3xjRAJ4cpsKtrfTm0DNJ8JbM024ZH11C0JLULvpb+2krlsLZX
 JzEMo/v3qdN/nd9OSy//qhswl7iIGm9OPaJlubh+1xWTHeDRFbRpVIqThnJj/Jlo+77h
 zB2wtS8XKm4TrcCgeZf0T8sAdki76tVihIz5wRKvcmbEC5QYTil8/MWiKneqUH7sIfhH
 Bvis+EiDhMYW4TNxVWUwcGYSrB3Hxkh4EdVSCZpdZv/K01uaSKz2qbldk3dWfxJY3gU/
 bFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792589688; x=1793194488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kxpaj+ImW5ATaG83U0skv7HnSn4U5qn1GVlsU/ohJwg=;
 b=yHmGOZ5sBFqCEF/FYgMSeHIgDcCLPCRSiK2qNULSvjSsoy8cCD+YMeKNdJ9fPi9dNb
 CmBD1Xxvzfw8GQm/9IGal5Nel6cTGsB9h+eSUB7HdQ5MxvjO7q6iC1s/fN2w7FBtIyqQ
 Qaetku1Fd8QhU/lfW/vmeqNwtFY3Cgv35ggCRGhe7bBfoo/EtGCJPayfZZyXt7zreEOP
 2vsJKYNQn5BYAatabSy0X9OWLSZ5lnKKJi6NZ1X9sYSUXcZQ8yWZGHp7UWiIQ8+yPsLK
 pYrB1sQeAwAKLyBB3ZphYiseHG5QBSL0jvkHHh89+4TX7cdIMLX3qxjgOVCcX3XCrT/A
 nUsg==
X-Gm-Message-State: AFq9FYJIWumerqSuD5KHIhdskf2eNWZ2K++MSjX23RoxMY4qof++RyyK
 K+3DXQxXVKfuAR5S8q9ObF+LFE30+KL7ftf6EuGwZr6A2Gp+ijk20K8W
X-Gm-Gg: AYBFou2eacaljh5CRbDSL/fdeMO9heAPj8WS2GEw8P5QJZT9HdYal5jFLip48f8efG9
 5i2Xn1suDvbs4MBjvuER3l5iq9rU4WDFl20ObPCK21yZpHBJs21En8ReMsflyKD8Mn72Yf8dJ8G
 PfCYf9Al9d5x5EerawwOi0yLFTVvX8RIW9Spt/wZA707XlXfnkyuZODktwLs8ZufWtL5twzNwpt
 /9LyQrmmeA/DhpeubyudK0LrLSMeGN3VdndtujuB2ozaU+7D5G5rZW9TVIlwvhIfkcHtIE+OfUu
 safuYMswl8X0JKq+al6MenQMQN4J0O+X6cSIw0sNfvTZxUsYPLZsa+lnDcyQjV/CKUCj6eBwUXo
 uD+8w4dI47XIncMsaS0oMxKEvazMw1lbK96mzWwdI609JWdbToo6ObzSnYYnuVY4i9+72olt3gk
 sTyOPUEyUz30bAEgkaLCI4ht24Pl/i+x84HCl/MR9W+8sEXQAi/ugsSygiAJTqG2dh/BN8zixvl
 FrdARsa6JsbGOAr79V3EndScO6KyiSA61hmt7208HANu32MnyrDmZ0h3R83MoM7IYNKcWg79E2z
 GqAmyjHtY8p6RNmgtTx7JMQPpG1XaKvVBZ83nFldAwr7Z6Jt9+usWLMGXusQdNZJb6Un4A==
X-Received: by 2002:a05:6820:1f11:b0:6d8:e4b4:2873 with SMTP id
 006d021491bc7-7093fbba442mr1228791eaf.29.1792589688295; 
 Wed, 21 Oct 2026 06:34:48 -0700 (PDT)
Received: from
 runnervm8k3b6.bbtuyqy0xgnulbf4x1n5xyw1wf.ex.internal.cloudapp.net
 ([64.236.176.199]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-709036d65a4sm2226502eaf.8.2026.10.21.06.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 06:34:47 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed, 21 Oct 2026 13:34:46 +0000
Message-ID: <20261021133446.9440-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021084933.19097-1-wegao@suse.com>
References: <20261021084933.19097-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fsconfig04: Check FSCONFIG_SET_PATH
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

Hi Wei,

On Wed, 21 Oct 2026 at 08:49:12 +0000, Wei Gao via ltp wrote:
> fsconfig04: Check FSCONFIG_SET_PATH

> +	if (dev1[0])
> +		tst_detach_device(dev1);
> +
> +	if (dev2[0])
> +		tst_detach_device(dev2);

High severity: If another process claims a loop device between
tst_find_free_loopdev() and LOOP_SET_FD, attachment fails with EBUSY but
leaves dev1/dev2 populated, so tst_brk() runs this cleanup against the other
process's device. Track attachment ownership, including partial-attachment
failures, and detach only associations created by this test.

> +	snprintf(path, sizeof(path), "tune2fs -l %s 2>&1", tst_device->dev);
> +	tune2fs = SAFE_POPEN(path, "r");

Medium severity: LTP_DEV can name a valid device alias containing spaces;
the preceding calls preserve that path, but popen() splits it into multiple
arguments and tune2fs exits with usage, producing a false TFAIL. Use
tst_cmd() with an argv array and captured output instead of a shell.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
