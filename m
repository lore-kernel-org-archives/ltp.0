Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C33EC43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 12:18:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B45613E77B9
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 14:18:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 818D83C5E52
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 14:18:30 +0200 (CEST)
Received: from mail-qk2-x08.google.com (mail-qk2-x08.google.com
 [IPv6:2607:f8b0:4864:34::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 088701A00901
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 14:18:30 +0200 (CEST)
Received: by mail-qk2-x08.google.com with SMTP id
 d75a77b69052e-51ce209041cso2892651cf.1
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 05:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784031509; x=1784636309; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VPZPEUCUb/TwaEU3QQ2DIHRqpMT5DTG11VIulnjADFE=;
 b=a6u8y32YoVPP7qKtRLXzp0vZvafkvSSksuZ1G1k/i3MOBGTUVLQU2IJop7tGkNyCfJ
 MrI3fqnxaj1YDFt1w2d+SMcrWIXXoUBm5Xi5MeCD7HkIrT9tfTDD6vsShZLXeKYz6pe2
 gm8JwA9ToxTz4GPTnWpUMJF4QpGUWS/KxQdRC/mp+9hqzL6RBdu5JendOObd96+x3BAV
 /VVRqh92DOe52vb/MWWRvCLjSC/rE/c5VT3q7prJRCvA3V4ZsC3LjWHxSa9wLxFSKNkK
 ea8Q5Ky+fSZxOoy1wBxmFH2QANQIlR/0FrMB+qgWai8QcUVZO+Id3lG+OazIZmzNGHKH
 uPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784031509; x=1784636309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VPZPEUCUb/TwaEU3QQ2DIHRqpMT5DTG11VIulnjADFE=;
 b=NZvTDz8GBUgY7nCl1cUFgPaYIoz1m/hlLO/LD0Lmr2ypg068FSu59KfXXeCwW/U/3L
 LqMAbUwzRcJBP0xazmf0rutakri+Y4wD50yUzCNZvTJhFJCZoWuyMZU0Xu8pxTn/xnwi
 of78DvJJMLpqYNN4GijZ6pkMC0bxzG0bZNHpzjBh6jKHipmKjDV5nOLN2zfTXqXc5xOG
 PoGfBBw7ERAaFEwf9R2TXdFnZrsOjG52/xRVFkRTsXYnBVDOPmMaw0kZLB0KZETvhgcJ
 ouu+4obZzDs64gX0l+JjJz7vwvHLBOu2o6AuGX73vfx93+YwVEaHiOC/MbrVUm//MBL+
 8/kg==
X-Gm-Message-State: AOJu0YxgvgXSs/m5vzouP7RDMlTGnQXBuVchvrafgBLlUFrJRTgMZlME
 xv7Byf9PRUnLpm7w1FkeI9uibzJ5gPu7tfAFD4Z9vQRbSy+rHGAzcA8B
X-Gm-Gg: AfdE7ckg4w0BiF9nPFMGByfK92ic/l+ueaABpeh6QKk3Gvx54d0fxx0L0Bus1JveQN2
 2dYSbBtva3dMOrsVywwLyOglnlgms4C9lEg6BMj6HTLPlbV/bqyMkcuNX2/164sEQfsKHztv5hw
 Fbskp32KnvJ4g7vco8PYPqkcXdPdzgUquVTvaAkJn6cskrpf8ohoogLIZYukjBwgeQVRUg4YB1R
 srj7CdBpyimg4kPEfwz/XuGwoUMWp616xhqLU1dwn4W3ZkZKbKazyR7R276+g62Q5Pduix0Hdlx
 qbozmNQd1HGNbHvfVk8noAVI5rKLKruK6lGDw/sO5eR/sTaYnC/VW5ZaaG8cgDtjvpA2oDFrxHJ
 B+7FCgR8Hs+yN/nh4sWUMyNdZJ9KfBNSJQOc+MlHrJiDmvMd1Tv/sHKE7lCmUAjrhIM9Uugv1CR
 P+iwQND5LTL15s38EtGEDZGOqgz8mN80uq7ZnB5ozov4EFSy/3D6xzKd95/BfbLAG1p4jgB92rD
 OGSuVjUa6dl1Tu9wr0OXe0He7DEFbRLiX+nlw==
X-Received: by 2002:ac8:5a04:0:b0:51c:167a:a48f with SMTP id
 d75a77b69052e-51cbf2f8f92mr127045051cf.64.1784031508614; 
 Tue, 14 Jul 2026 05:18:28 -0700 (PDT)
Received: from
 runnervm5mmn9.b3yniapqfpledkdknmdvdxy3fe.bx.internal.cloudapp.net
 ([20.62.255.18]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caae5e91dsm114170451cf.21.2026.07.14.05.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 05:18:28 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 14 Jul 2026 12:18:27 +0000
Message-ID: <20260714121827.3999-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-syscall_invalid_nr-v2-1-b94a8f60f112@suse.com>
References: <20260714-syscall_invalid_nr-v2-1-b94a8f60f112@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscall02: test invalid syscall number -1
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

On Tue, 14 Jul 2026 12:56:04 +0200, Andrea Cervesato wrote:
> syscall02: test invalid syscall number -1

> Add a test verifying that a raw syscall() with the reserved number -1
> fails with ENOSYS.

The subject and the doc comment inside the test both say "invalid syscall
number -1", but the commit body says "reserved number -1". These terms
carry different meanings. "Reserved" implies deliberate kernel allocation
for a specific purpose, while "invalid" is the user-facing description
for an out-of-range syscall number. Could "reserved" be changed to
"invalid" here to match the subject and the test description block?

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
