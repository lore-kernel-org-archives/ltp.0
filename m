Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBD0606A31D
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N0vkKz1T
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3620D3EA66E
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 21:06:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C924E3E1721
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 21:06:31 +0200 (CEST)
Received: from mail-qv2-x0a.google.com (mail-qv2-x0a.google.com
 [IPv6:2607:f8b0:4864:33::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A35FB60081A
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 21:06:31 +0200 (CEST)
Received: by mail-qv2-x0a.google.com with SMTP id
 6a1803df08f44-91beffbaa0eso13217606d6.1
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792436790; x=1793041590; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CXCF1W5y+fKAi3qSpwpYfLTWUdJ6F80UdMqOqIweRS8=;
 b=N0vkKz1Tw9DrRFJalTCN+2gOY3aNZ4TubHQn238N7jfEQscsHYF1ssAXOmDABlavGX
 +LUvXIXbEbf1z/z1CWrloPPStPh1GyU2/S+MYEwmCYZetSckLaRc41a7xjzvxvGTm8Kg
 vBC4hmYQb3ER8wtr68kSNoQcx9q0BGJsWBDV0wBALxAeFZ35fN90hEv01ll3BimG3XIB
 BXvhe/2BgTNr713gE3RpsjMiu1lbTUQqt9HYoGE344ryA/+qv3Z0UiTsj7ecGr5HB69k
 /74ZUE8Q8gouK03N/cUCcZZkyL8kpce710qZ8sjdb+8twtUWsmriRq0r4DXl+Ag4S/zh
 gsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792436790; x=1793041590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CXCF1W5y+fKAi3qSpwpYfLTWUdJ6F80UdMqOqIweRS8=;
 b=bu+FNzBkg6c2ppyTe2v/swd9syBO7NuVsOYS4kJb0DZ7Fy/VFclvCMsno44G4eaH8Z
 RIfPZ9k7CGR2BndaY7GOj4hGAzfst2+ZaMJ41XHaCEzrw9OlblDVJUW686izwkClshmN
 qjlFDQHJ4FZM9pSgvHFcp0wnutE6cE8JaFHw1tqYq1JDp7RxFjDog5vTNwomH0CVozev
 RcDM5Il3wTYQBiNab2m4Dfl8Bp9REKA1DYx1mNsKLHRzqHWVqt0OnvZq5nzI+R7raCaH
 gIITA3/bh5xYPTweglJZgD976SmvKJMAWYqt4UuezymLBnDcDTkD+O0Mi+MaNnJY18S3
 KJKg==
X-Gm-Message-State: AFq9FYJGh18rO0Jnws/i/65RopY80uQAwOSzbWnBpFpmwC1+wkLVisT4
 Fqry4AqUxThQDQMSFqzPnvAyTzxRnNmPQnuEDGW9wIfGK2tyv/g1LsIb
X-Gm-Gg: AYBFou0X2Il8v8877TCzLWSyVRy6UHz70HB6kRe2R+Y/C6QbA1pAD3h0DbHoFliCSg0
 FpSpE8RoivXOAdfpVbPkqL1RGd7NiAkLFncFCO1NCsKMUv0ZaR7nLhBoSbxWEAA/DvnUy/G8fIQ
 iXtAt0vVDTSXmzADjuj8GvoOLmS2ZuLjJdL8kt2BmMyM8imIXEUG1wiG5i3hyLwCzHGd+oM5Dbn
 I9ZAYV3A49ICjQDiklm/Z601mSv1/Wl40qPDkvhs3xQJZAM4obmMAQIEY3GZpc5tYIR3adhQOZy
 fWOOnZnuXIrIIq2MjXHQxzamkYAiwnaZ1XNwL3h4VwDOpqH8LVPQ+gByaQRK+IG52yl5TQ1pM7I
 gSpwq8Y7H6FccyMkICU8l7tkvGwCD5msnvmGLvhcAi2zDKqMHQ571P6rqzFFOEWTTXtJ7Q2Ollo
 W4CFANYHAZtykGRnTHv8rx/K13U+/FKDbqTG4ggbdWxvGpKbi/0hMBU9sVVAplZ4fXDdlOM4t85
 a1GhrIlxP7I7PnVsqrcjy8oQmfGXKNzkDRecIjO6W2AnQM5DcSLgDx1GUW3Z7TFkamENnUmWfKt
 Uv5LurKwo0k=
X-Received: by 2002:a05:620a:6f96:10b0:93f:31f0:6a7f with SMTP id
 af79cd13be357-93f31f06e75mr766177185a.69.1792436790275; 
 Mon, 19 Oct 2026 12:06:30 -0700 (PDT)
Received: from
 runnervmxehtw.dtj4yddoao4ujjevhu1asbapuf.cx.internal.cloudapp.net
 ([20.109.92.208]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f4b059cbasm32349985a.7.2026.10.19.12.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 12:06:28 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Mon, 19 Oct 2026 19:06:27 +0000
Message-ID: <20261019190627.9273-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019132621.3943362-1-wakel@google.com>
References: <20261019132621.3943362-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] swapon04: Report TCONF when SELinux denies loop device I/O
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

On 19 October 2026, Wake Liu wrote:
> swapon04: Report TCONF when SELinux denies loop device I/O

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
