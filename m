Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD583109C02F
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 15:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774453711; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=7W/+enJgSJX7QnXn0QfTuqlCOpfClUsjmJ44x58iuTk=;
 b=PmQYiUyj/I9o09VGEyc3JhkbfwUKev0DX7/J7bszfdVlXlupJ8Jlv0odi1jXMBFjtw4/D
 MWg8xKgm19gcaPeKpMSNNXGKX1uuU9kWfRwCY1ItGWvrwQ6HKzzN3FEYM8Zq/LmbyHHKTvN
 zsUwjYnkU+wiIIaJTL2iGs+244oHls4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C7933E5529
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 16:48:31 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 472AA3C2C33
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 16:48:09 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B3E7B2005D6
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 16:48:08 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so384435e9.0
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 08:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774453688; x=1775058488; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=VlIRiL00bUDXNqDXc3XegcjGeUXSqG5j0aHWbWTOJKg=;
 b=XUif1GrMWiNQ3kPTtyxPPY1+zkpUpDkzhssNtrdHzj0eGKDD6EN/x87p9WLVxQX9qh
 YnSuK41y56isn/vwpQ3uODI4p4qR3LjVtOCvDDyLPk4XTb+p/rMrBLCbyElHyv9b4SsW
 5pNwgvW9qywN5JYCbE5Bu7EAV1uRUDouoGUNrWe3gHIwfxcTNjVEJ1/ju5YS0+psp+qY
 4ow1cgIZpcGUwWvvskJzxqUGk9VKZo40fp2+ZkJx3FgywciUcph3H/VfVNBPIPZgVBdI
 GFhy1ha/max4fpGc0o3s+rbL5FKTcIB9ooDSIKZXs1JNDXFWlFfbgiKsLuZQMaS/kJXl
 LJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774453688; x=1775058488;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlIRiL00bUDXNqDXc3XegcjGeUXSqG5j0aHWbWTOJKg=;
 b=HqmD9NKvVge6XPPSoIg+RscuTwyQzbiUulHFvhMYNEy1kioVb/1j0umL2C0JR7fM3M
 iNMoco4ixQcM/O1glSbmsHjPm5z4yiPKwnYiMIhutcHvH1g8g2g4juoQKuAIEZcsjab2
 Z1gCDluYu24uZ0lGtww4fbSrcExa+txvhbD/6ebrzxfID+TzIyuZ2fhANzmXm8u/CIBs
 mMZvwO7hoqzbBeoBBbchUUXA+L+dlExvoM0GGQhA0VE5vrmPGxmjWGF5H5LlivS528sj
 2/OBJzr60e8lqr5Z/N8fB0c8YT4954Re0iNtbi89Odz2nR3ZI+Knvhiqd/MUefCsa1mi
 7Epg==
X-Gm-Message-State: AOJu0YyB0d3Qu49NFFDd9wkAFEvqTIJZBLbWt8rAhX57inz7p4rS0+sI
 xuPt29mwkemmP2hRtvCwCnh7QY+tRrIVE8FMQtWwWMNhRVnvP46UqhgzLkimWfSPb/k=
X-Gm-Gg: ATEYQzxNADE3a16CyPcUqwNOyZ599r5T0cNrm1nCtiiJI9jZvIIWFlN9gnN3WzfLDeL
 KmakNqjM66UZEta31zMpVWLUSn938TFQUdrec5Otros933dN6OESBS0CcvPERBI16/JlMgTRtJG
 P9BrkCS3qunBVI2xXfRZbctjMaRGxcX/yRPZtjCod9mLBM9nXqc9taSb2qLpGk62r98JqkSzwUH
 Uu/ma0eThpRR9VteBkjXWCYU5eyKTIKqAPy5vVkFBR4h7ooFdbA3BZrtala36DslClONYW5aW2Z
 pQ4tY7GxRfnksz4QpvNObSfv8Ct+D7gtfJflvBF0qZ+eWwcidsU37WzXBL1mMml72EUbciTv8ut
 FS42/LJd5T0RtlA5gaizCLT4kNj4EF/PgG0QZEDQlEdTay0ETf7+1fth0Dn8zN9Y4kE/c6Wcvpq
 IfnDj7qE5FaCSz2UF00AJQmO7bnotcmtoE55yJkSzZHvVPpPKjPFtV0UflClHSXh7gAS5pYihFP
 1wMJ6qGjgbNiIBoBXvYXN333toho/e9pe13opeMsHDtdwDKE0qgigCaAuaBg+CwLIeC2nT2erwD
 7g==
X-Received: by 2002:a05:600c:c16e:b0:485:3dfc:569 with SMTP id
 5b1f17b1804b1-48716042b0emr59476265e9.16.1774453688061; 
 Wed, 25 Mar 2026 08:48:08 -0700 (PDT)
Received: from p200300ef2f4fc9002ac0653bb49440e6.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48717319272sm34584105e9.8.2026.03.25.08.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 08:48:07 -0700 (PDT)
Message-ID: <69c403b7.050a0220.1389b1.789b@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260325122207.1967-1-always.starving0@gmail.com>
Date: Wed, 25 Mar 2026 15:48:07 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] open: fix cleanup condition and use snprintf
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jinseok,

> static void cleanup(void)
> {
>-	if (!first || !fds)
>-		return;
>+	if (first >= 0) {
>+		int limit = fds_limit - first;
>
>+		for (int i = 0; i < limit; i++) {
>+			if (fds[i] != -1)
>+				SAFE_CLOSE(fds[i]);
>+		}
>+	}
>
>-	if (fds)
>-		free(fds);
>+	free(fds);

If SAFE_MALLOC() fails, the fds == NULL and we have a wrong memory
access. Please change the condition to:

	if (first >= 0 && fds) {

> static int *fds;
> static char fname[20];

This was pre-existing and I didn't noticed. We should use PATH_MAX
in here, instead of a pre-defined length.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
