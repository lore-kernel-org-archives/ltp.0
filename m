Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03662606A31E
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h2abGMdF
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0B5E3EAFB5
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 21:37:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D4943E98DB
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 21:37:21 +0100 (CET)
Received: from mail-oi2-x08.google.com (mail-oi2-x08.google.com
 [IPv6:2607:f8b0:4864:32::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0C2A11000458
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 21:37:21 +0100 (CET)
Received: by mail-oi2-x08.google.com with SMTP id
 5614622812f47-56820670d00so1338538b6e.0
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 12:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795466239; x=1796071039; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H5LlygKpAUwMzw3UpX6lflWl4IZn5taAI78jmOR8vfA=;
 b=h2abGMdFuzZB/RbOQ9UWElvDGnLYq21udVZ0gr59JsqQdIVCd58K6yDpq0ZBPUajCt
 80Sy0Vf8C+PuGodrE0xavkffm9uBt1R8B5c2N2e5FNAkEkLKwxN3zz542JHbnIJptbJI
 N4m2U6EWyfxbIkDLIRyi/Vt4nFXZvarYK86YmHKwFHl8yTXk3sT3/x8MKAGnY9cQenx6
 CcO/nWN/8CC4jSfUI81HL9LEoGGYyOHx4/M6rPj6A3ia71YmB4hAsJXs2cHQnhUoJ5WF
 IZ0vH7e+nFPnRaslDAyXwjpMZ3p9jlixbbwRc6T67OmBXRrWdGzNNhIBNJn3uVurJOK2
 P1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795466239; x=1796071039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H5LlygKpAUwMzw3UpX6lflWl4IZn5taAI78jmOR8vfA=;
 b=XNB3Aq0M8sNqOlNz3GxIoj97xxM6/PUBYb2ecIGsB+zDhnpm6aEDD4jMHvgFMFZEI9
 TQjLK4Cn+tkjRhMEbRLspvbE7atU0US3B2zVchyNbexwSL1DJwSprt8rDr2ulJ2GxNVm
 C6rMH2syYcm1Qsm0UMpY8xqXmzUnzm2taZDJoL5iFjb0ABbiYmzsy7HBOmIcb+Ad+M7I
 PEnVv+7tU9j89axSPPxIeqB2yMfRfpAfWpMPK58p+0jfQLmdP0Fue+jRx3vza5p1gbdH
 i8OunE/xrbEROoAfZq/MyRSEmgcyTsmU6ofAnjvWk41E7dCbP8X0qtEE2cdM6b1BCV95
 XO5w==
X-Gm-Message-State: APuU4Z+U7ql8/CkB8b1g/lJ90MhW/NsG5Iht/J4KwNYSUPIZ8IgnyiN/
 xnihlgc2G67BVPOIPt4c39KKHZ7ghFZXLG8Ea66H9bRUjvwqtVv2wn+U
X-Gm-Gg: AZFdTZf7aIk30oGLm4joRUH9yDd7tFdy1hQGYkDh9k5FEbjSwTdE6vrGF6vOC1m55bB
 MLgaNUcjrVGwjWbEHcVv9jzRESsEw96iZteSW9UqDa17NuJ4ZK9AuYDgjluuEn9gi461ojM2gLa
 jL+RYCsryRh6emTJ/7BpYC8wx5sAFw3wyJLBUGWDRKa/l40utQDX5Z9ivnYdG3f8PNSq+tQ6vz+
 bmp9xA5ODOLuZLKIomINdW77WijwKxQhhb/ESEHG0posNmm8Qo+5mqp0i9w8YLME+4uNkMdMfc5
 7XV114I0LVHDROASy3oDuKu0OCdqFiuyyOlkVqbGFsbYdYvPt0bVs5VZQOgQ1UYnZLW8J61gqMm
 fLsExg43/fCy1d3aMh8nzj8ERZXis/OghG/2OmnVnNXy0glHFNQpB8NQncVythoq3laZp/J4hSs
 rTny44h2DfgOFYxNcj3U0S07wWMe5LIhi1vZ/6sus3OiwsgwFt9EnuH3SWibbL8DrJ0/TG4Roau
 5aViAFNoEZpe86kJXZ1cqV0dbHrxFrOjm9dAXovt9omPzV5ukuI+vMD0Lem7/xL8ojo/vzGOPM/
 LDZIhUPMNC4PT1aVxF4PYeRpzrwVx3gPK6lQIxFMy0KlWT1dWJE+zh7iV/JpMJcJujODpieRXF0
 GW6Q/HmwhoStukIHBCudv6hBiuT8BFsYWYF6b93+fsJs=
X-Received: by 2002:a05:6808:4f20:b0:4f4:3790:65fd with SMTP id
 5614622812f47-57a0ac26b1amr16300388b6e.29.1795466239582; 
 Mon, 23 Nov 2026 12:37:19 -0800 (PST)
Received: from
 runnervm0hi8g.tvc3osbaktsu1pqxx4xvshtzdc.gx.internal.cloudapp.net
 ([132.196.55.107]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34250ef2sm10394550b6e.3.2026.11.23.12.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 12:37:19 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Mon, 23 Nov 2026 20:37:18 +0000
Message-ID: <20261123203718.3745-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123123351.1496233-1-wakel@google.com>
References: <20261123123351.1496233-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib/tst_test.c: Scale default tmpfs size with filesystem
 block size
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

Hi Wake,

On Mon, Nov 23, 2026 at 12:33:51PM +0000, Wake Liu wrote:
> lib/tst_test.c: Scale default tmpfs size with filesystem block size

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
