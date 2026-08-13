Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE38C5CFEB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 06:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786602356; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=aj6+PoLPOh6/Dy+3JJQGoXddmA2qdHkAMNxV5QvnBYHbmb2gNGWhtClK838qkWiTE9au5
 a5v1MJkd6YUR75aS/ie3PS9xE8XoSTzSHEcaCFNE9CM6GYoGTRw9gQeATKWX88nosznBA3p
 OxTEtAEBQjlcUSd4Xd1BM3dSWLQeJPU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E25F63E6BEC
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 08:25:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E59B3D86E3
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:25:37 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 83399100079A
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:25:36 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so17974215e9.3
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 23:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786602336; x=1787207136; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=RMTbLY+KQiTxq5rGAbxWaIzuZLqA4LrhGRp7SXxLg9yewTy49sq8FvFwCXAXjGu68k
 bkvjLJxbvPpcKYG9S6tQLO+QSvGrLdYnjN9+gVSXqAR4cQo/YFQzT/sOzJBksqFGxFTk
 dLmDDkPYI6821kUUtaQS+0GLTtd4SlDU8q38GixsEyZiESJxlHCNUXlkCjq6kdf44ACd
 CJhO4o8yqg0EFRRNh0TUJw0RAhvPYRJu8WUo6UgjfL13I/wxrbty8+S+3/VKjbnR7O4r
 C+XkPRpjR0tN9IrdaR2m/B7cZKZbWUa/y5nySP3sDXfVWtZVZbWUPF2rz+X5CHEpxJp7
 WNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786602336; x=1787207136;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=pzPS22bWoDagLaWXbCA7mW/Ebl++PKQJ593tsSATht+cBLmrx7/qTKOwYSf5AXGNp2
 +Lw/vm0Kf9IjZq0y+gmx4XSLP4Q7PznV361iVv9XbuKpTgt+iWH1Bx23vw8GlpmO6tPF
 bbzp33jUjdi3FFjAvbbIZb97Wlo3tk1kvqPcurddi4nMckH3prTQMNKecC3WDYiwTfDF
 Foj1bvAs9K5OJn8/GWbg3AcjeHsMUYzq3ibiGYX1FRiLoEWAkR7UHRNWZGeys4RX90mg
 GwTsmW8N7FMpqIwkjvkZsKmnJnv6Pn4gqqNx+ESGP/AgB02/aJYKqYGBLaSlzSUA18j9
 5N2w==
X-Gm-Message-State: AOJu0YxuZmVl0v09Ggr9VtFfqijRoZ0Mrxo3aeZq8GnZRByGHNq7xMaz
 UEUAE+JwfZmp7Vi3zflHpImm/L3s/gvEporXNF42T2JQvjYX7clOp1HbZnoVe2mnz4I=
X-Gm-Gg: AR+sD112127YMqnYES56t4KImUYdqy3EX+VD0Z70OTNqYsC96Q2VSUt9S/Bifmb/5R4
 autlQS1pAkd9hdq9CnEQklY4IA6BshDfOOn+lpmVfyxYyz9YC1TXevAuSovKWnyz8rO1RUD92Nv
 0OON2F9Dk5mzW1z8ZT7A5ZuTh4IOXQHuZPTKez/1OjVRrkDPkr+Nz/q1fC20wTcP8sxAw6K33zh
 hAyZUqD4lKnfll8Ps28wndY5+W1uAnkN3z0t+G/w0EMnwnYjugmUCpmN8Y9ZFXVrmxDABlJTMlD
 r9/xjKa1tavTLkx6B2mjVsGOZfJDRsBsw6UED7znwO77RS0vVK5PwtpI8Oy9R92ynkO/Zx32mzR
 4GJyLsbSNtrkIY4QE1IirPevLpaw5Az5qetvQ18DX2QTVvyuUsMNa05RHM/u4juNnxkZNTzJt6Y
 0yWSJmMjcpWII7u+jzxdchO4fAH4AfAvtxQG6dylbrGWCjCj5BxEiuu0tA2vh7z7abQPW5WbOga
 vfF+coT9w==
X-Received: by 2002:a05:6000:250a:b0:47f:91eb:342 with SMTP id
 ffacd0b85a97d-48159cc614cmr4242741f8f.13.1786602335883; 
 Wed, 12 Aug 2026 23:25:35 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a569ab3sm3713608f8f.11.2026.08.12.23.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 23:25:35 -0700 (PDT)
Message-ID: <6a7d635f.abc13152.b1704.ce34@mx.google.com>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <20260813023216.79848-1-li.wang@linux.dev>
Date: Thu, 13 Aug 2026 06:25:34 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscall: set FORK in tst_sig for some old tests
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
Cc: ltp@lists.linux.it, Li Wang <liwang@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
