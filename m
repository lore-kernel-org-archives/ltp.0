Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F14606A31D
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aREBvXH/
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC64A3E6286
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 20:03:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40D433C57EB
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 20:03:30 +0100 (CET)
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EC179600845
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 20:03:29 +0100 (CET)
Received: by mail-oo2-x0b.google.com with SMTP id
 46e09a7af769-828c0b569f6so87200a34.0
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 12:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793127808; x=1793732608; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kSWgyFy6ajSyQiwCLEFz1i0R0/x+EvFZ62/Dt05PnIM=;
 b=aREBvXH/qzVBENt4oUlB/HPVcMaHlkg0f9tH2mgNOc5/KIe9IOeqtSQRb3Ylqre0+a
 nyMe9HphaMBYWQ7EhA3j0XYy+gUZx3+u3YjugrCnxdE+ElfheYa20feRjKAAH/9tHnbS
 hfegXNzgx7ONtQytwooTKvIV9jnmSlhHj0OUeXjraOq+KH+12l5vnuqrNwVAvHlQcrB1
 bsJkxqnVtLovDM6Yvlme9Ezv9pqEGFe4IIfBQI4X+Q/fNch1bNExZsZulMCElcL1iQCk
 TgVg8vUqXw/luV+bHo6wcE9G1tvxZhNiORV3QMZC2Ls66fWsOEiNg7DyLmcrjq6swrdS
 hzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127808; x=1793732608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kSWgyFy6ajSyQiwCLEFz1i0R0/x+EvFZ62/Dt05PnIM=;
 b=kwSSYkFcAIp0udBGSYPOsflMyvB5DDskxrtPaJQ4UNfxGmI9254aNUfD+kt8JysTbj
 C4vh72McLyQfoXYSbdEp6YxPS+XvEHqhLqj7wdGSvTiaguUXp2QiArdO/hFmeT7W7yT/
 mMKp1jothD6KqG+dWR3K0a551Zjy2uwZLPYhBkXQtJrZe0upO9WEU+U3jHC8chr5OKwg
 jMlHxIGDrvpyrn88K9XUXPWsrhW5UXBgKtU5XTIDzSrCyDc2at4wlXq4tn36Iir6/rtZ
 ZDKTju/wSL7UiIiPO97uoMUeyEA7NN7M8yi+uFFufRPHlDEG20y0lJmu8YetRAFBLS5U
 eXzA==
X-Gm-Message-State: AFq9FYKtQnlPhotlhEVYdYO4atAiMpHoW+hYLMYHvlhEqH/6gKwymV/H
 ZQZ0RXHlifk2LEnrU75THVp9N+jWjnxmAfPGJk5PbMgWbDBXzLm/P6Ay
X-Gm-Gg: AYBFou3/XH04pGjY4SfhpS/srgahVReppdRG3bvnOr8Utuails6KeorUdFUwRpnKDqJ
 nj+ojnmn/g4y9agnsql5d+d+Kx0IMb09X43wwp7CabgMunV4GNIt5BZ68iL7AeFmBb2g23fEDit
 IR+VsxsPq0oRp2J78NJeVwuLg/pUBqw/dyNddy0Q5fPePNHZ7tqw7KYPIRAJvoXoNjtpCpJRMt4
 3bffR3eo7LPeQ7x70t6cOP0ZiKqu3xLruDTcMmpxpxlvoA7FuPgTFQhq2edcTzS+Nfk1G9gZ+1C
 M/lu2ViAybSkJKGuakwKZp1ofl3HxF1nhArE21l50Mv+MU5KFwW4a4fUp87QF0k0gzNSB/2MGLF
 B/SJxYhe9fjZ7kb/s+eGcMNyXE5A8dw9po201m9BmEIiWe8UA2qCyV1wXTsFsD0RmJIYIMW2md6
 28LEGwy503cfByJ5F8+Gd6T+VkBTYIf8ggsd35X2rsUG5BnQxJKerRKE4cpz24DXlGVwRVOyGuo
 0B0JajHDMN5DHAHXqyhGElXlsGb1CRdRS0Un24YaXtvdlkGz7G2EBxJWiujVGGJURlRhF4zeS5v
 K1HOxOpPzTKy0qCN3N0fjLh2w9ebbrJ+2BpBvPA0frBGbNeS1jVQLndy1sTYLlb9LWpmUA==
X-Received: by 2002:a05:6830:2e01:b0:81c:5aac:798a with SMTP id
 46e09a7af769-85abff41744mr321919a34.13.1793127808412; 
 Tue, 27 Oct 2026 12:03:28 -0700 (PDT)
Received: from
 runnervm48cm3.tnudb5bzi3depaj2hqlh4whdja.gx.internal.cloudapp.net
 ([130.131.205.86]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fb0741c9sm11620011a34.10.2026.10.27.12.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:03:27 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Ramesh Chhetri <rameshch@linux.ibm.com>
Date: Tue, 27 Oct 2026 19:03:26 +0000
Message-ID: <20261027190326.4177-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027163542.13514-1-rameshch@linux.ibm.com>
References: <20261027163542.13514-1-rameshch@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/connect02: Handle IPV6_ADDRFORM removal and
 listen() EINVAL
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

Hi Ramesh,

On Tue Oct 27 17:35:42 2026 +0100, Ramesh Chhetri <rameshch@linux.ibm.com> wrote:
> syscalls/connect02: Handle IPV6_ADDRFORM removal and listen() EINVAL

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
