Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72F5C55184
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 16:13:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B81253E94A5
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 18:13:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEC353C57B4
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 18:13:28 +0200 (CEST)
Received: from mail-qk2-x04.google.com (mail-qk2-x04.google.com
 [IPv6:2607:f8b0:4864:34::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BEF6360090C
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 18:13:27 +0200 (CEST)
Received: by mail-qk2-x04.google.com with SMTP id
 d75a77b69052e-51c26eb5e81so14051371cf.1
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 09:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785860006; x=1786464806; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9mpuUj7QDuFWc36lAD4BNTHjv1NfDKdhVYC8ZrE9B+4=;
 b=QfX3zZTRc1ANsV3iOlL3kb2pThMogavlA/1ycz2QFOGs7v5mE2t57G+5MH/xiVyPxS
 dB+RrhXZgxyQKbPz1IyxLIggzO/TJVKsKzhJ7cZpQVpcbiiThEeYrRAlaZRxVfUbpZoq
 P5ZE1gFZ2y/WTIXMLcA3JmXliVQvpl/yqwPKYhcd8zrbF1pjwnN9LYhMmJOvQefsNlk8
 XfQ0ncbsukuMsah1XgJ40YLcJRfLeNu6JicEkcHTOwX16NqZ4kgkUN5LRam9fm/CHaZs
 27s9POodACzxeUjtnr3rQzrDQaYLbcQOz5uEeQVijCp/BI/+0UMH0QyjKkIgxjy7BrsU
 tCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785860006; x=1786464806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9mpuUj7QDuFWc36lAD4BNTHjv1NfDKdhVYC8ZrE9B+4=;
 b=qK9/sHasTuixDo4MxdU4fEb7YuIS216JodoH7lt5t76VY31TM+dnJ/b99bjOvgOKUH
 vk1t/CWknDp9Jn8X8dCMVKsetpN1hK8V37t8O95i1LnbrPm3ygZgo1JS3A5t0BGZMCL9
 4cXpI+JpUkGNZtm1JP4Azvc7dtpTdIib8luhtZLR7BiFn0hkfeEWiSYq8EpEJqVV/Tgp
 x/dJRqE7vFNLm4jqAozR+tW86pw0zhCeTMDWA0Xf7N0sl6xf2i5Lyluo1xBQqxCtmNei
 1e6oqC4LOm0F/1CGMT4h4iGCK6gsEExVVnWeCMhEXqXn/fqMkroIKbr6/JwNds43QsP+
 RqiQ==
X-Gm-Message-State: AOJu0YwlPZ0eTosbCAguHfJEr0GwnrWEjDGnUZyndchN1gj4BDyUA7i3
 q1Jn444DsTIOt9CO1A1Dp3Bx2QCdpCpz87TcnxDAqeqcLmX4xC2bFueVXkhUoaRh
X-Gm-Gg: AR+sD10nJv9T0j3jaQYejlCFy44zg0oM83zytKG6+CYQkgCCXVe++c7vkRCQv6DAbv5
 X1PGBVdfyJzuTxGJREpidaD0bzyueA2hK/j4qOI/HvfUtO5XZzbscQNPr2rKd3hT65EoU3yaMln
 ZZKk8aNiDPHUXfCMJAMg6TKmsl/wqVXZj8IWD77Z33MM88AIXJcKS23qz5eshW2+QGwYl9UnbMy
 5/HKympOGKU8y9piAS7FEVyk4BkQSqIFAYeDga8Ht04zbjShCO22neMeWfpq1deVKWfgVoDhVpN
 dGxHnttqjfl9XNtur1wdYEEDW62+VYTyV7fK8xCbkR5v9b9kEkgfWg+PKcsyz3EZcqJ+x2sSpwS
 OcJJO/YLkoIx9RhD6hPFySDQNXuQ0fYvJ3KjnJynfsqbHa/OtaLQLor6FTj/PrzIOskdvMgi72i
 Jh5oYGJ+vtDo5GSsYdTVDngrgAcC9Zzu3SSGfMnH2X7Qe77sxABY7TFVCm5spl+xlbD1YD36Oas
 hxEd5ftzhA0WH11oFMFGcSas5GCzzhrXtjG8KU6GNQZ5EGIp1L0DVE9V7z7/RDB+ZoyljNY7nag
 Avuc7gGf2Co=
X-Received: by 2002:a05:622a:c8c:b0:51c:19af:6341 with SMTP id
 d75a77b69052e-52ce61d2d25mr1320761cf.36.1785860006313; 
 Tue, 04 Aug 2026 09:13:26 -0700 (PDT)
Received: from
 runnervmvrwv9.xjdwqik2hx1uldfghgfw5amd0f.bx.internal.cloudapp.net
 ([172.214.47.57]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9087ff9d773sm4816166d6.5.2026.08.04.09.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 09:13:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  4 Aug 2026 16:13:25 +0000
Message-ID: <20260804161325.8435-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804132857.552304-1-chrubis@suse.cz>
References: <20260804132857.552304-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: tst_res(): Fix TDEBUG | TERRNO
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On Tue, 4 Aug 2026, Cyril Hrubis wrote:
> lib: tst_res(): Fix TDEBUG | TERRNO

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
