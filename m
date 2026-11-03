Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2356082BC1
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yOlSYv0r
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 632AA3C9CB4
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 19:14:00 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0F383C8315
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 19:13:43 +0100 (CET)
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 34B291A007E6
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 19:13:43 +0100 (CET)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-824413e10dcso2387518a34.1
 for <ltp@lists.linux.it>; Tue, 03 Nov 2026 10:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793729621; x=1794334421; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eGq1L/UOwz3YWRusaeQUGQpmb0QYFo2IRb2hl5D7x9M=;
 b=yOlSYv0rE6kwl8ld/u48YkIy8cRD32PgwDBXQJ5Dyo/7VcXTG2ICQvaQIxURKZjSBN
 iIoeMlyY2AZEbIm3pwAqZ6jJl1jM2R6j4oGpN3x1rL9OIf46Ft9mDn6SIHbsC5BFtzy5
 tAMPy/RcUj7ghPXPHdyzOz2m2qXkt6c1c2BWxMmK0fOLfABESSixl7LIn8xfEM7Mcgw6
 THPLyax9+wAimmoTawb5rCJiIXWt54l2FmTAjus6kFB3Wg48YWl/Icx6AbWs6dqxl7HM
 bKMXoP8g0a3RLBab4o3uc/RoVphWZyR4ZCVV2MlS1ljdZawTrk02cjz4E528f/ONBNbB
 rOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793729621; x=1794334421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eGq1L/UOwz3YWRusaeQUGQpmb0QYFo2IRb2hl5D7x9M=;
 b=JZ+LVgCeNuHh031y/qSJvfmIeM+TuaLTzMXc/eVFiuV+foglI/rAbJ3sA0ILQTFq2+
 mp890mZKt5TvEkTvy517wgxtpEIPbXNcTikqsJU8T5nPcBaxXH8lGmSt7A+4bzS0RXxk
 9Og/n7/NbjUhNfT0/edHmBWiBBzq9ClOdLIKyEDdErGuN9i27Jz1PE/qsS68iW0Wf847
 CXMe6lMRHsS2rePmytwHEwpnBL+e03qLv4OUq24IXzsZExlYEtn6JTbXw+r0u4ZtF79u
 WO6R98u1CP3Nd7Unx9BnBqss5OVzVcY9Ca/csZmdgYTlJKqL729BpVDBsYhDKGIq5TuO
 90vg==
X-Gm-Message-State: APuU4Z+RaVX1xj96manE8PP/sDU/N+WukxQFPKilAfdRoTICD2F1UgyW
 V8LA6wxGtIvkQqSGgUTpHO+BUUbIVwyWzPM178wv4YwfmZtepIQmCrF2
X-Gm-Gg: AYBFou3gGXxCVjA5L0xINypMPU1NxqRfgmlkmtJx4ik74Wh5REuhDq1PG4hv85DEnKz
 19rRzpO+CXbSBVDCHHZLs1dxYwFCY9dMC/QkW5AVBQJQkKk3hBGWiQy6XmazDgv8NB1XN9t9gqM
 R2AO6mdV1/efOvFaOkAju7ItyrUUVXDPnB7HBSYbxHf/+Ju7GCypnH0lZNnSfZSt7/R9yJc/qSZ
 xzmacaC+Rtpjen0GppCCA2cDxsnYBHIXI32Z5rrlICYKPSOU27Nbx1jm5K1AEUXI9YK5jUgloOZ
 jtQRYuQxCuzfw3VWgqWr8OOmBnpxJwDwxglBLcjsVursqOKx9mKuDuyg75Qn7zRl8UkIasBU7tn
 qJKEw+ydd7+6oPAcBgK3eymohK6RbsL2mUg+g9dZoBi2u6WbLa55uAPt45ieqpXcR3Fs6l2InjR
 +P+6ssqGQQk6tYFeCFPwwzoqIIYunqGLtQcU+1F3fEhvzR+5VarPHmlsnCYrWT4Hdp8pqhVqQ9N
 csnbXej1OnSNE9qcfMIzd4HXsw0MSNw+MvuTzSmDAQp1VCAWydk2Pbydi6xPwBYvVVyegvJe4hk
 mha1aPRiFa+YBCmdDj9IuCRrk//+56krCM1f4x9n1BefaFWbz3z0RJcpYMuo4o9YRufW7RvIYkb
 USN1qMxP5Py5uiBSXZuXfPryKiaEorJkCSv7M3KIgYdEkHTOX6YO1FZuOTRew4QgrwpU=
X-Received: by 2002:a05:6830:640e:b0:7fa:ac4f:79c with SMTP id
 46e09a7af769-85d364471d1mr9823674a34.24.1793729621093; 
 Tue, 03 Nov 2026 10:13:41 -0800 (PST)
Received: from
 runnervmwuk1x.rxxrvns4gc3e5ng4kbsxw1xzhf.qrox.internal.cloudapp.net
 ([158.23.147.106]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354d12f2sm12240114a34.17.2026.11.03.10.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:13:40 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Edvard Conrad <edvard@tuta.io>
Date: Tue,  3 Nov 2026 18:13:38 +0000
Message-ID: <20261103181339.3887-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <P5WKBbq--F-9@tuta.io>
References: <P5WKBbq--F-9@tuta.io>
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
Subject: Re: [LTP] syscalls/fanotify26: Add cases that list the directory
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

Hi Edvard,

On Tue Nov 3, 2026, Edvard Conrad wrote:
> syscalls/fanotify26: Add cases that list the directory

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
