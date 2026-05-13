Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9F6CD4851
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 16:28:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 298713C574A
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 18:28:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F30BD3C1D75
 for <ltp@lists.linux.it>; Wed, 13 May 2026 18:27:45 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2A0E91A00997
 for <ltp@lists.linux.it>; Wed, 13 May 2026 18:27:44 +0200 (CEST)
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-50fb4a7d704so51948291cf.1
 for <ltp@lists.linux.it>; Wed, 13 May 2026 09:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778689663; x=1779294463; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dq/VlNUJbY3tE1kDbaJuIUmEkd3eVI8pfMu+xe+IvD0=;
 b=ZcEqeuTQaRt8GM0C/PnKAmAic/TY82+MpDHGCHIajTakreZ5blevFZPDci0IR4ThuI
 1rGd7iGWIH8Of8jhepnMAUQ2o/4ileL7VIz7GpM59fVNNytAYyc6QHVKNlmfSuqKreHZ
 sDoqr2L2D1uxGZTFc+tdXrDCits/VhD8LhVppFavZ20QbqqGyCW9Xz8KoHfjH0fOImCq
 uhqvWQE/fMnAqrvcqPJCPgu45GLyBYCN/UdAg+E8Iac02tWtZVwPIoKr/20slSxzb8Hx
 MZJVjNPH2T9fqmpNu452mXDRSRHdJAnETuS4jAV8nyPgjq4lo5maVETc5D0kCn7Q8rTj
 Afpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778689663; x=1779294463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dq/VlNUJbY3tE1kDbaJuIUmEkd3eVI8pfMu+xe+IvD0=;
 b=EkKlRy2NK11V6C+sxPGrhT8uNK1wr2b36dcrUr4zyd8rWZVm+NR0fIGHkGNzDVwUrC
 v1zW5UtMwfKJq30MfT2m+6f/ZSJJ3NfphKoJSVeiyXLcapvNPI6KHa3ECs10MnFva+7A
 xklClcfkCPSVcNkNWGkVMdJM19Ncpgpg1aoNv0Tdle1RlYA6fiVhc44pylRMaUROLGPk
 AV0fs5H/28W6yzAzYwkSJ8re4wOj7aiTgAlhnTF3ZTuwfn1fpkZKkczEF6mGW7G9IpRD
 rj8r5lhHz/tlTUUpPK8mXFfQQ8xsdgfYsCjJEMZb7zRm+5i3kiK2EghUgsXm8Ph+MX07
 QRzQ==
X-Gm-Message-State: AOJu0YymhPAf7bJra7oPnvRoSZ6W1ICI2KwLmAd2IOJ+CUDBZLvT6zOY
 E4Zj5e1+XpwfQzzVORgLqLwaXxJ40b7JcwvOUk/eYCPoChC6MRiY9CRb
X-Gm-Gg: Acq92OF+JlndRgMxfY0ZEP+V7XD7N4MpsZlQxSXoPq8UXKUKm2tIFRkzzi2gLXykWzA
 BYMcASbhqI2dR3UKb/RApKuwUx901qpj77mynFmpARLf82gv/RfeOwMSA59LDYhpaCUKMwj2rl9
 qioaWcUeBLyevwS+n4bQutw+MS1y/MYWivxByeMnqTv4JNKaYbKjsod6L2obuV1IP1LfMWqELZc
 m6Ky1AYjXoHNfy/+q2RnYI8k3xOVZSlyLx39HSzttoO/stgUq2URAOS7u7fWlxuyGnmhe+HDQ9b
 SWXtUXSqHfjsvYgAwDfUMvfJ1fWb7NXFRZ7qgw0yPTozMnX3WKvL+qaBWvCFCdvvD2VQfWG5dzW
 c/nxz5qd22s04eJWgRH5hUfvjAKc2CxWtBk7UsTcu32ymMObKh0pFi99SZFKB/zk02++WQ1/jb4
 q4zV+WGiSQCH00xGo2M46P8ThsSQbePkco6gyfASfg2qTVMMSK/FY0MBcQ2YcCptvk8BK1FdtBi
 zOj0EYQyp/D+AKM88i7SjwTqsACQsYI2pEZqYM=
X-Received: by 2002:a05:622a:54b:b0:515:6c6b:48a5 with SMTP id
 d75a77b69052e-5162f51ea48mr53812421cf.27.1778689662751; 
 Wed, 13 May 2026 09:27:42 -0700 (PDT)
Received: from
 runnervmeorf1.4zsvnx0dqyzujgjah2l4ucpvih.cx.internal.cloudapp.net
 ([172.172.87.51]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148e836e32sm152663981cf.25.2026.05.13.09.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 09:27:42 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 13 May 2026 16:27:41 +0000
Message-ID: <20260513162741.4013-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513-fragnesia-v1-1-80c5b3b09005@suse.com>
References: <20260513-fragnesia-v1-1-80c5b3b09005@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sockets/xfrm02: Add ESP-in-TCP page cache corruption test
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

On 2026-05-13, Andrea Cervesato wrote:
> sockets/xfrm02: Add ESP-in-TCP page cache corruption test

> +	acc_fd = SAFE_ACCEPT(srv_fd, NULL, NULL);
> +	SAFE_CLOSE(srv_fd);

srv_fd is not reset to -1 after this close. cleanup() checks
`srv_fd != -1` and will double-close the stale descriptor. Add
`srv_fd = -1;` here.

> +	file_fd = SAFE_OPEN(TESTFILE, O_WRONLY | O_CREAT, 0444);
> +	SAFE_WRITE(SAFE_WRITE_ALL, file_fd, original, DATA_SIZE);
> +	SAFE_CLOSE(file_fd);
[...]
> +	SAFE_CLOSE(file_fd);
[...]
> +	SAFE_CLOSE(file_fd);

Same problem for file_fd: none of the three SAFE_CLOSE calls in run()
reset file_fd to -1, so cleanup() will double-close it. Add
`file_fd = -1;` after each one.

> +	splice(pipefd[0], NULL, cli_fd, NULL, DATA_SIZE, 0);

SAFE_SPLICE exists. If failure on patched kernels must be tolerated,
capture the return in a local variable and add a comment explaining
why the error is intentionally ignored.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://patchwork.ozlabs.org/project/ltp/list/?series=504173

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
