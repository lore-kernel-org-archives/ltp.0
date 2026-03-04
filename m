Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCD0EF8FF5
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772638195; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=v0dVktfoJ4TXRBqZM5iRX432azc5YuqsBWCyzOc5usU=;
 b=oHsXumiwOAqjVmXYbFUe1tL6z7JS9bHKZ2sp8eH7mQ/uTBcQvUIQ9kYXfXA+YLFhV1zo1
 8Eh+2kr6RGtVgfBRwbkwRJ2kov4Xry4zcGo6KmverXxu6bo7kG/BUUGo5980qB43dIH4wNL
 5UZJqkiA2YoUsTK6W0GJDtiV4Fc3xxI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 341073DC7CE
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 16:29:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F8E43CAF08
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 16:29:33 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F1126600B4F
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 16:29:32 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439af00d33cso3730424f8f.1
 for <ltp@lists.linux.it>; Wed, 04 Mar 2026 07:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772638172; x=1773242972; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1/0JKtWz3mUT1QepXprGUJqfGUajU8B/fmkkMf6iGXA=;
 b=C1rqgSbAldOzzN0XIOEFMc2kc2XWI5M7bExm/EmF4OsGE9u83KMfqmT591BVK2cUG6
 FJqXWYPtU6fHV5E7OoSm68KJ+ExktDE8W7N39koyWBpyGtE+RXqRHZ0wMjA/bZFMQYOD
 KExIOIuNiSvi2BsD2JFpdnhSJ2T+3XwtLBOgVNO+JjJnbS2y70/LGEbtNm9XZJLugts/
 NwjxT0jH04kAM5BUZd8Z6su65nVop94JS+rs8JrAaKgOVGUJ/uuoyWrb1eJnu1XUWeZa
 duO4zG1PMsQe6hwtlNAQcn/zHvSmJXiEqkeRzR+7XYsktJn8BghfrS9a5SQ4C93pFYl1
 /aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772638172; x=1773242972;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/0JKtWz3mUT1QepXprGUJqfGUajU8B/fmkkMf6iGXA=;
 b=KAEsy8eGGvZWj2TSRUpA0FV4lqjWOca2OwdniPzDiac8PH7gVp/CJGUF9mkY7iIxo4
 fmpA9BIzHH5W0SgmqnD2HV+6P7s2dO7+wMgB0/1wySKY8zeIxmYYRi7MdzhReU63MVeh
 O5hQjTXXOGYh+BCinzzLLqfXJMvz5RIuA4OltagIlglA0P7/fLTzeVn+zM3AQuVwXHAF
 a3n2YIwr1Kr2aEwWhvvt9l1nUyDFHY0RSp64+St9+k7ktjwrwk3ErpvPzLNu+OkKsJ9K
 09aHS4dYMDsG1Fmiba2VcgJFk9ugz2egdGiTUNIjaOuhQSLFBpeNLm/1d2Gq+V3fHPkC
 nm2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKgQ3GlxTefvdKbjYMjr6GNKpCWzyXAq0j+U+lEekGHt6q+IsP/OTwmfxDeMYWwxubh0A=@lists.linux.it
X-Gm-Message-State: AOJu0Yxi2yUQY2tsKfHOOETi0CI+/fJe51OOUdPjVYF+ObqCBqcN+hfj
 exEyAAL/wInxKlhQ6sXwBeyzWhTRl8DnmX1EekxcKZLWloMEFOsnexc6Y5ZIZAK8xX9MxiG95Wq
 xInd1
X-Gm-Gg: ATEYQzxiNM7p9+yurYyBUJESVTiKc+wXQhxvDjlwcpZJQdaOtkFuBaxOfO992CBZUvg
 X899S0lmT8uvO2j9glUjrhswcFyo33EnXWE8F81jNmQEjN0fjScWZx1VeQCP+8YAq39KNOV3isl
 tYGi1zgxtwxVSJRVhMT0z0CqGA+AZC0tA9l+64luVlLAtvGJbyDUCNdG1u090sb55mAcJRGDBdo
 3QFQppuDypXChvibqKzyy8xYDNy16CTKcw2k1kHu/R2BvvKn4/L4Hpp1qDSvSocfKPjKVmQIQlC
 1CvO6VjdO6a1UsLqbUuyJhja3AXBOOp6BlGXNgMvvC+kjD2m5AUZf0cMxPkeg8gZ/W1JA9yjs/x
 Xc+WplR9r8ZCtNTOj0lAikY2SuQ/1px82yKdp2YMaemdSN/R3cDnr+u/oZB8ArdqGetKAEmf2YB
 R4T7aqMc0AQ2P257dMbhYnHo623ajCfpnnqQT6ZglZ
X-Received: by 2002:a05:6000:310d:b0:439:b114:60c2 with SMTP id
 ffacd0b85a97d-439c8006d49mr4363260f8f.34.1772638172202; 
 Wed, 04 Mar 2026 07:29:32 -0800 (PST)
Received: from localhost.localdomain ([88.128.90.53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b41831easm27322119f8f.12.2026.03.04.07.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:29:31 -0800 (PST)
Message-ID: <69a84fdb.050a0220.18749d.4545@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, ltp@lists.linux.it
In-Reply-To: <20260304141236.9080-3-chrubis@suse.cz>
Date: Wed, 04 Mar 2026 15:29:31 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] syscalls: sysinfo01: Rewrite
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

> +	sys_load1 = sys_buf->loads[0] / 65536.0;
> +	sys_load5 = sys_buf->loads[1] / 65536.0;
> +	sys_load15 = sys_buf->loads[2] / 65536.0;

I would go for:

	sys_load1 = sys_buf->loads[0] / (float)(1 << SI_LOAD_SHIFT);

That "magic value" needs at least to be explained on a comment
otherwise. With this fixed:

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
