Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E91CD98F2
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 16:40:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 598803E5926
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 18:40:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A3C83E1EB4
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 18:40:36 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 92AB81000374
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 18:40:35 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-9159da9bba5so94748485a.1
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 09:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781800834; x=1782405634; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6sVT/chXqqvZ2xDMjONctUawNFiTZjPlxjgJbtTxOz4=;
 b=WpaaGbzl75MmFuXx/hpaqZkAhR2wgJ/1yQdG+yZl/wZ18hbrErs2jkCCaS7xpLU9jk
 CF7xvoHTjS6QbkG2nyPEyPDpTqMVGUEAw1/7mDC574KpZdYvdqJ9X+GWq5/9FfjqD5dy
 AqkSAyHcDzBgzk5XdxwxoYQeGXx7/h+LntgdCNcvxNOmsY8Rn7uMQvjQvkje+xdChGjm
 XdBkXzyo+oEKGUoKy8rsCUFyQzrHMNuq2wauMEg6LuVCemUkbdTZMFZFMWaakl4LHwnh
 bkd8uS4PqJjPSdAfAVcqGKwuBG/NsOS5C6RbmmDSu9UlXNZ6srsz8x93berVe66IGrWu
 KHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781800834; x=1782405634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6sVT/chXqqvZ2xDMjONctUawNFiTZjPlxjgJbtTxOz4=;
 b=RlxY8rhojfqmdseldU4KtdDEfHQtBo+b39XICVuCNoQVznQz3K/EqrvKch0vuVz200
 vYn5U0tkWsV2Le/s3BdD0QgQNQvCoGft9mgCAcfNcvZ7JZD8bZhG4sqKBM3kUnpUEO7H
 BANaEHoEgtCdkE8SaYXdpQuD/NbLr/5P0+tAD0EH8fPh4CXE8qMev2X7gQwS7nihBSoy
 GN+6ctsOG1lE1u5XrGs7Us10bMLIOKYmdAWJ5zpfbkhlWaKPwEZfT16/DDdR4/3PC0hO
 IwnMpzKzaXbFKaZv5wbxNNBh4CD75+yt9K2VGgkQh5i9j0MfObhLujt5Z4I7BQgfWQiL
 ToAw==
X-Gm-Message-State: AOJu0YwEl256OSF+UmImZinHYtgtlMFpQmSsZlKmdb65n2QLTv9Nj2Vb
 4uB5hEcK/fAldfLHa7JxWd8kTaOob2ACI0ZNz2wPfjmotHP1JpMBpt7x
X-Gm-Gg: AfdE7ck9sDba8FyCcFsAIPRJquuFx9dwDYiD3h9m1R3obdFyw3VvbUkJZJ1U3MvWNF9
 CKd63eazUDhiycDq/KEaLpyoIp+9H0cflVMpMderI+2qrRTNGK9RYJjp40LgCH4aMZvvwr3+u6C
 Qg5Al/XDDCXFLxux6D9ytt41Ypz9umjdojFH4AFTijF+E2bDtfooeBR/SxEMT6RUMNPytQlNNg6
 IG6ijbNqibobgpYw9poMX3w6/Umoc/O9rbrY4ixg9ma7BYbHsCvBkxa9/rSE9d/P35XnC3ZUTRS
 4arCm69cdcK0d6Y60k7soNltG+x0rTHMgSUPz2VdaPGU7CeVLf7inMAxlUOwVuGezEXYAPlsbX9
 z/IGwUApmWGj3mrmvt62YgXKH3heWBENiptmsIH8YReIwXqIRH00tbv/u8YFQKG5GCw2MUokAuq
 snWEWf2X1p4ouAopO6diq+cgZaNRRoOt1c7I0mU8X64pr6U9Y3Vn7MVl1d6bBn13ksBIHIPNWwL
 8XGlDqgmDKr0OpdD5lN0YNbzBF/1A==
X-Received: by 2002:a05:620a:179f:b0:915:bf79:3e0c with SMTP id
 af79cd13be357-91d8a7f1a9dmr1569566085a.4.1781800834192; 
 Thu, 18 Jun 2026 09:40:34 -0700 (PDT)
Received: from
 runnervm7b5n9.iibmcgoccnsuxewui1xc0qcrqe.ex.internal.cloudapp.net
 ([135.232.216.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91619ed7fdfsm2118187985a.3.2026.06.18.09.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 09:40:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 18 Jun 2026 16:40:32 +0000
Message-ID: <20260618164032.4098-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618-metadata_groups-v2-1-6ab298932233@suse.com>
References: <20260618-metadata_groups-v2-1-6ab298932233@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] metadata: add tests grouping support
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

On Thu, 18 Jun 2026 16:10:26 +0200, Andrea Cervesato wrote:
> metadata: add tests grouping support

--- [PATCH 1/2] ---

> +#define GROUPS_TAG "groups"

> +static int parse_groups(struct data_node *groups, char *line)
> +{
> +	s = (char *)eat_asterisk_space(line);
> +	if (strncmp(s, GROUPS_TAG, sizeof(GROUPS_TAG) - 1))
> +		return 0;

After eat_asterisk_space() strips the leading " * " from a doc
comment line, the string still begins with '@' (e.g. "@groups stress
regression"). The strncmp therefore compares "@group" against
"groups", which never matches.

Should GROUPS_TAG be "@groups" instead?

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
