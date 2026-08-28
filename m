Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA54C61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:30:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47F4A3E9A61
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 13:30:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B835E3E5DD1
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:30:38 +0200 (CEST)
Received: from mail-qv2-x02.google.com (mail-qv2-x02.google.com
 [IPv6:2607:f8b0:4864:33::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 21EE2600BA2
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:30:36 +0200 (CEST)
Received: by mail-qv2-x02.google.com with SMTP id
 6a1803df08f44-90c8bdf100dso2482846d6.1
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 04:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787916634; x=1788521434; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tja99uozlqwv3nkhUah2KklNOemBVc7cEYaCCWDGhCU=;
 b=MASOwd8IgmcyRVgEuch76Y9H2ookOdzwykM7+7MJ5eyvwxpjSlP24ebQEfYH49f5Hg
 BlZwOHUPX+MKfjQlLs/i7TQzPBcbK8lzi3INylCBdznQHaCUUQgvbwqJFGBCYtllRLFv
 nZ7Tnq/x1N2/d+tCf+BQxtH3hVqz065jFJ+LK7gck6B0nxz06H9Y/RjW2bYBkcGM+WcT
 P9XYpoYBtapDz1/5qsMJFWAR0G6JgI5BMezMIEhKHZD1GMgbPlMnI3zVO6JoKmH2eVF+
 zyOC/cBtKCjMzj//kn45KMMxyiYvaILcS944MZyTAURKGuPokRyfEd22N+51AuOSpBsV
 65BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787916634; x=1788521434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tja99uozlqwv3nkhUah2KklNOemBVc7cEYaCCWDGhCU=;
 b=J4OKhDeVgWKoniOKqe5nZof1Mv7/g46E24JIlXB5HGfwCDMp5MUfnQoB6TKSh6ts4e
 Durci9Ox9tgfBR/OvBPynF/R9pfywmXN3ndBjYsRrKR4m+stDaQnT/8ffhbc5plJedjU
 9uSzIZ5pq+IyHIC919+3FhH8ndaU+fWg70dNVwD5Dw3jNl9M15FbjbnHXiNxdJtkqyNq
 s6w1MuLaBYn3CCp7xswbkSgBzoZragvVVP86cMZuMTEdxi4QJ944JTqEkmLSOv7eHVei
 ut2Doq49rpIDOKA9dWpDryEnquvvZT368QKszUqoYfORgaFMU4T/qIxXyL8vp4zSAWkk
 KHPQ==
X-Gm-Message-State: AFuF++m1jWmwiLV0aiwJaQmNtXRFB/YoaISmYyn7HYZrlQlUhRk4wPC/
 TLmBRue6SOaxYO2Um8RCI8fdEifIcxoTSUd7+H/aNG/jAnzLGCn2yPhE7Pw2EKTh
X-Gm-Gg: AR+sD12+BRSMDGR7zPSUCmVHMdcrlBAwDs/bjmne5Y4lEK3ASrGZrY1KbzrMfsNHmkV
 2WgK2JLtzwpmQuoFrMus75lDsCp+PPwoTDw5CtKZ7x08A453yK1P97+rqYXTPhVtco9sTRMUzh3
 jvhtRwYBGfoFvHu9CakvVjwSpNOE87/ti0nJ3aJaJXrefCRth5TeJ99Qg6I8akgro4IRwWoPjAt
 KJIMOI5hu0oIGM3ixuVVXtO1Bzkk7bQpxqWo7WrnSzlFYsjifLQIfv1NLavruh6bJgrDgXvVJeK
 CtczxuZZEUBJ77n71hDXsSG82n9OBNajv2Rwv9Q+XHE9vbHLwY3XOv6MsoqFAI3L5Ff5kp0yKDX
 v/a3A4aKiwTBEOzdIhqePM7s76+Ox3xHC4rjlhWsnJUHhugaQTv6Yz4CX3l0hqHRbsMoU/vtUy7
 YUoRLRMy3JY84lXo+L93tgucoKyXfBjJ60fPhjJv8EM9GMr2y1ggUbKqD9DDs4MXxBK/ShhYhvk
 qscwkFZ3K9lGGIY9DXoGLcSZ9kxpiaBBboXhwSnN/GzCRd34o4XUJSGdrI5RpN5JjY1RPgedHdf
X-Received: by 2002:a05:620a:2841:b0:939:d63:b614 with SMTP id
 af79cd13be357-9391390b4d1mr59232685a.28.1787916634463; 
 Fri, 28 Aug 2026 04:30:34 -0700 (PDT)
Received: from
 runnervmgx7h7.jpkbqqh2jgtedct41erira5nte.cx.internal.cloudapp.net
 ([20.161.70.182]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9391723e87dsm124375685a.15.2026.08.28.04.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:30:34 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Fri, 28 Aug 2026 11:30:33 +0000
Message-ID: <20260828113033.8995-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828095724.194900-1-avinesh.kumar@suse.com>
References: <20260828095724.194900-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] setsockopt08: Handle EPERM from disabled compat xtables
 in userns
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

Hi Avinesh,

On Fri, Aug 28, 2026, Avinesh Kumar wrote:
> setsockopt08: Handle EPERM from disabled compat xtables in userns

> +	if (TST_RET == -1 && TST_ERR == EPERM  && tst_is_compat_mode()) {

Minor: Could the extra space before the second && be removed to follow
the surrounding kernel style?

> +		tst_res(TINFO, "32bit compat xtables interface is disabled in user namespaces since commit ec1806a730a1");

Minor: Could this 108-column line be wrapped to stay within the kernel
style's 100-column limit?

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
