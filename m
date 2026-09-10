Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD97C79FB9
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 10:47:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6102A3DEDC8
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 12:47:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6DA63C198F
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 12:47:12 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 73CA61A0091A
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 12:47:12 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-398a384b5f7so3462321a91.0
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 03:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789037230; x=1789642030; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I2qBHKlMELyKx6QqdSaidYQ4fWQaQ+akI2yfnRY1cIo=;
 b=SBVpJokDJmCI2zYrGmbHc8LtK8vMYtf8cjENy24+z/5+HIEGOqrRHRtud8iE4wxi7S
 2EJvMOeWXCsNKWmm8WWW/41huXS7ghLCl1fie70mievh62Jiq1FsqKeyp5ROexyMqoNf
 KLimy0r9AjpEnBgZFAGMdopNfZZT2FjcQdXUQXlWwaqqvBWRar0RhgjD/oU4fe0D1Q38
 Lz4kWetLyMKiOij5KuCsCcqhtFZNt30m/SUj2mfwNII7Bp65MTavHZAmsNE+2ZOW3rqZ
 eyf9pUccQV7KBKbb/ba+uZzg2qNmsCdPWPk4Jt/935c7VO0ooiw2JferyzIiAP3LaJS8
 hhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789037230; x=1789642030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I2qBHKlMELyKx6QqdSaidYQ4fWQaQ+akI2yfnRY1cIo=;
 b=liaQtOJAdzDW6btiT48wWMmCUhMW4u/+Dkc8oqk7aQKM07PIy1jOR5KcdGc9nTvUuc
 ffNa/Vw38w7ILirN9bIk4NqVJw99cfyftOCxu33RdZhracesD5g6bNCAu6Gn6/GjfT1i
 E07BkMHLK2ic/iADZ0MtB843RrZ/jl71jRL/1nX8jWXDrlw0Vqh1RT93SimmkIHnvO/C
 fM7KUTIPw7HZWzCWZeyS6gPmy8LfQVXkvxoc8qbHCdHPtQ1GIGTJnXi2tMrHBLXppfVQ
 dw8pwI3Woc4BQ9o7sfXWxGFL1KcYdqUm2mmg7a4r4wpR8ODqNSMx/2yxuwx3+/dKY7mh
 svgQ==
X-Gm-Message-State: AFuF++kXQj4vEHOatRUBqbC2RYZkV0V4QUKKwAhGIkOa9fLUJbvADk3R
 QKlGLHe2vUPjLovSPtDz9zTE1v0ASNQiaKxA84/l4JRgbeB6Y2rNPtaE
X-Gm-Gg: AYBFou1URo6JPVO0x5O+9lHN+IeoCFhva5LeWvJvfltY+2HcmkIajI116sCDgJS2/en
 u1ecCoPvu+AqFKOagl+JsIDkumzv5xtYqDac6NvhreVOy6RLCG+sHVMRj9SGqcpelZu5j3vIMME
 fX/OupCzBCl8eEeMDgzjlHgULH1eYWhLFVYmi9RCRQuC5CbwwEtx/dqOYs/crbalre8/NxL8038
 4nZ6fU/waHqIb/zgJU8Uur3IugrHFGm1EaftveZ6A0Ti76vJ5MEa8nFLF1WBs6dQVksL5VPeK6u
 TywXAeIZZ80VxTPtnw8myXTouOwsH+elaJcyxxFk8WlNFYH3U/kIeu41xbJlW8NGua7iJgLhrc/
 w5Z33EOxo7KR7llnCSwzOeWaiHfzF7bf1lQI7CizjnnvV8R0XPtwVCqJxqxI+xxfuWJxUFd6Is1
 3QHdtPNh7JcMqG6QZDzXJlDgwpvDM+Zfiom2184d9q3JvtIaYbPDBTXkcJw8BR+jros7D23w00y
 /7EZQdSky36sqo62i3uyNYi3r1xCGg6GFySkxLKX1pFErjb0gHbRj9B+5hYWQa8h35kNhYe3dB9
 PJTdFrD6KGr3ILXtZSsp
X-Received: by 2002:a17:90b:2787:b0:38e:9eb2:9d43 with SMTP id
 98e67ed59e1d1-39bac34331amr18948330a91.16.1789037230545; 
 Thu, 10 Sep 2026 03:47:10 -0700 (PDT)
Received: from
 runnervmlun5p.nf314jw1w1befhwsxly1t1jp0b.xx.internal.cloudapp.net
 ([4.155.134.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d776184fesm5260040a91.17.2026.09.10.03.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 03:47:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 10 Sep 2026 10:47:08 +0000
Message-ID: <20260910104708.4480-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910-fix_documentation-v1-1-44313069bbe8@suse.com>
References: <20260910-fix_documentation-v1-1-44313069bbe8@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] doc: Fix examples and generated links
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

Hi Andrea,

On Thu Sep 10 10:33:41 2026 +0200, Andrea Cervesato wrote:
> doc: Fix examples and generated links

--- [PATCH 7/9] ---

> +#define SAFE_FILE_VPRINTF(path, fmt, va) \
> +	safe_file_vprintf(__FILE__, __LINE__, NULL, \
> +			  (path), (fmt), (va))
> +

safe_file_vprintf() is static in lib/safe_file_ops.c and not declared in
include/tst_safe_file_ops.h, causing build failure on any call.
Remove SAFE_FILE_VPRINTF or export and document safe_file_vprintf()
in a separate patch.

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
