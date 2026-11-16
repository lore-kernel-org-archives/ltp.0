Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12915606A31C
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oGbomPbo
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 581D93EAA61
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 04:10:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 137313CFD77
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 04:10:04 +0100 (CET)
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3725D600142
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 04:10:04 +0100 (CET)
Received: by mail-pj2-x02.google.com with SMTP id
 98e67ed59e1d1-3b108f702f6so1218208a91.1
 for <ltp@lists.linux.it>; Sun, 15 Nov 2026 19:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794798602; x=1795403402; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qR8bU2WdRKXNIz8PimIZpzqBAdLc/Jfkq7dqn5cWPO0=;
 b=oGbomPbo4/aFDqw17uTG2xC4OGH4RiSU6/xTGVjyrGXzqHMJV6OEvReJMXAdXn0EA3
 PaPbwWT8hwGBsu96hZ3AyAqEoQ4ufbNZ+3buADMtJJipZz5ixNucv4P8191g8A2E6AWU
 DC+8PeDE6qjen0HoME5C51Bj7HziiHE0yNIzClFFl9UfL3SMRZRCXryQtfnAW3OE7Y3T
 oQY+JPWrlhe2TE+0yRApZhPvg3W7ODSGbA5J7OT2Z2ro0/2jmCa0dMND/rf5d62IdCOw
 /8YylxrW+f5SAc55CqcFe1mjieEB1xiIye1TtR6qJ+r0q1RFV4PQxPx+aMUorsJYbshS
 KxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794798602; x=1795403402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qR8bU2WdRKXNIz8PimIZpzqBAdLc/Jfkq7dqn5cWPO0=;
 b=NZh6HY4nptbzhLw4cxwxad2rvXB0E8a4rTldXhpeHaNdZaq3k5+p0W0aYR4BrsCEgg
 smia55bBUQdZp/Ydy8UGw+qOaxgSgyt0mlaV7CsOTpamezI4lT4nINJ/lW2ddMuhUBLu
 AB6mJaIX9wSYhUSOhBEojfAX7COE/tAT4qzRfUTmZJov2zhZO6DLfAoLKBb7U9/NzQJW
 3GZeyRdZC7QEAbURVFCqOaubT1SHEQ85zXaZ9muwyFkWzrRJq2bGI4VGNiXfWzilkbDb
 o9aJn4ASBa//U7jGOyYsTUQMxAlwzH/UkHn6qB/VNjnH6l7mt39K0aJiRC0rlTNZMWPO
 NRxQ==
X-Gm-Message-State: APuU4Z84m3YjC/+hieGyrRvsAX+3kY8ax0KKzIFNjeCGZFLumIPXhtkH
 s0lCehx8TgMJe0+lun3YGfcKPA23vq9wrQBmsr9KxVnr9sOhAU9SV82J
X-Gm-Gg: AYBFou01INJqXc2JZYdUhL/9UZ6v5ee2QX1fnZYzZJ9iOkSfa9TnRirykH+uBQoE7Nm
 j7Nvmzt5fR9r3LX14rkpS4KHmZzar0LJk9i4GnMnh2EZI09RiOhwrgLh7kcaC5YPWoRsMZ6Rp1V
 708lPwKK83z+C3J+QIIVV9+tOb+UFdcMatHmFDSgLVJkzF1wxhZfC8OGItjE8Hnpai3MDdfdMxo
 ePIBUkemSu+WqtQd40pGy5+CUvtIE2c3q/Na+3x07are86enYncLu0wzHJmoQ9V1EWy2wCwquD1
 4/8KbIrbU+14PwMFrybb4cYTYg9SgMAABmcJcealVmY31XEKD2TjER4nQkoj43j6xBqX65dYnHf
 dOUTzu5PuMaYbXpJdXcuk607rknLQR95bvYZ4J4asZXNa6efjPThlE1EHJWeSXhnpvnGBw6Hdl2
 tFegKl/snsfY/XbFETbt9UX/+R67c6V/u8ZZBVLMpPhCgzqYIxvVOZ1LAgK3KagofIOZgpvilgp
 ngzoixA6Ic7obBb9cAnXG0AiwcsrFyHU6LjJhfb6EP9Cq90qnNVauC9teq9yAVWgUhHEHOK6PDN
 04iXdISMwh48aHo2CYC4++XSmUEBu7oaEEEuu7TgyPkeFnPyOFigd9AFbVBqSHM0uEViZ80UhCC
 kqMsyWUat9igysIbF481ZZ+Ws914Y5xPpsH/yjsTR7iI=
X-Received: by 2002:a17:90b:1dc3:b0:3b0:9782:8721 with SMTP id
 98e67ed59e1d1-3b1b0a0e116mr8596450a91.36.1794798602349; 
 Sun, 15 Nov 2026 19:10:02 -0800 (PST)
Received: from
 runnervmccnms.oxzsxm2yrndupi5vjvtbmggfsc.xx.internal.cloudapp.net
 ([74.179.101.114]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1aec622b6sm16069550a91.11.2026.11.15.19.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 19:10:01 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Yu Miao <yumiao@kylinos.cn>
Date: Mon, 16 Nov 2026 03:10:00 +0000
Message-ID: <20261116031000.3719-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116013147.69993-1-yumiao@kylinos.cn>
References: <20261116013147.69993-1-yumiao@kylinos.cn>
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
Subject: Re: [LTP] memcg_lib.sh: poll for expected values in check_mem_stat()
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

Hi Yu,

On Mon, Nov 16, 2026 at 09:31:47AM +0800, Yu Miao wrote:
> memcg_lib.sh: poll for expected values in check_mem_stat()

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
