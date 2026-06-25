Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE40CDE000
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 12:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782391831; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=ToH32gJLRo/O5s6Pmy3k3qYHV1K8CmHX9dshk1GQBvTB51lX1UBEdiFJf2YTiEIzF6Nku
 fotWq2l46sCaFe4Ei+YrrG38UY9kVGM5j2R47lOBQ6DkIRUuSgLQVSyEKGAxMCh78FIpoyb
 OyLJ+HMydtE4+zOtzr/sGiDOdF02brA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCD183E4D76
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 14:50:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A68393C7154
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 14:50:10 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 84ED7200985
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 14:50:10 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4924593f45dso26294175e9.1
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782391810; x=1782996610; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=GLWUkwDqmg0jlG8dTfuzeN0zrpkONmc0tsmaoB23esIZtsdE7uIRLxTsWpG8AOT03T
 4J5lk3i77CqytghIyb2Yru3hul+D6fYOj1t52744Y7BiNpMrP3DHlR6/xStgr/28XuqN
 E3LPv0uhXGmkorAkUVs2wSTBxQHnAWCeNUhsf0ykHnZKH6i3oE5gtG4rnHfr5H8t6ltn
 B3TGIgq7MNXLqNPAaipXzB9PR/jbyopSSdzTnr2LfwqNgA6vcR+tLGXw/fNLxb5SAiW/
 qscnKTXZV0uyrbJJA1ohqty1OGVh2wTxAxsM8YTfeJH4wJqwp0VJgUfR4vQKuEZRu/uN
 lm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782391810; x=1782996610;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=XD1whEnohV5hPcrG/6a7HyZ3hYRLhIquw4o1OV25TkZZyW0Pi1F9aa4DSYGLxTJgSt
 8MTAlnyvoyYYRp/Cp7LV3pbqiFepMT1Y00PRi7bomfdenG5IGpVgyk1ZN0tWlbMJoizU
 tHVYcM9AbjXfQnU3IFwhXcrM1Ii7vWAUPV4P6nUTKsZmfC/HOVBGKX8b6pSb41IgfiOH
 hlp6ZnvmAjoWcxeYnXhBsdbYVWIoUn/fqOwMJ54l/GRdZ7LuCFIUPFOqcZ0jUjYn7KuL
 sdeB5P/8VvpMfYmmCp+nN262H0DLSN83bPP2BLpVs8J5CaoBMQqS2yXqLhgKFaey+2km
 F4Gg==
X-Gm-Message-State: AOJu0Ywrt0i0RhB6egtEXOahJb2Jm9e5QUBoavQ4Abe1QTSv1e8AuTZr
 SxEy3b0JREXyQfxyjmT9NcnYczfaBC5pnikbaUCjfn5JVzfEiny08D6KSMeUS4bv+Dw=
X-Gm-Gg: AfdE7cmRYDHJyznVJePaGrPnAdbSGKlhXFMeDrZrFxpVMq1sj+VspGpN9QbqsKhTaxt
 +5kIPbAt/oMBy5VKSUI+vmDrIwXwimIYBzEgwcQSKC36NCB9QT6NI54k5qJyOj8pB6S8LpKu0at
 ynFF84wFHMPvFqpSikCf/bHAxsQc0+JoGLOMZaU4tKPWwfq5Ylq4roLCBkbjE/meeGE7q6JjKXe
 rx36AuvVyoSiUk+24KK43Gt4R3EbszZeO1sXALmIrtLjR9HdF5spMlHZ8qis0UZvJTlGg8RFWVe
 Xf8aun6bAXQj8uhEFAoIQBgdUPwkdZdAuziUPnrgcBe58f9nlhUNfxvIO1SYWzhW4OllyKNiBQQ
 HxjVTEXJNgRUpfYYuZPDxa7UMrDnzPdq9uLqYh5QXeOzR36ff/Y1P8Ck3OpKY9cxhhQjFAT234M
 9+KT9YGER3OCTKEDm1YXC0LP2caO4x21z1fcNZpMu1eGp1qifn0KST5nyEUDsGeg==
X-Received: by 2002:a05:600c:3143:b0:492:4cce:53e2 with SMTP id
 5b1f17b1804b1-4926683b1a2mr28763845e9.3.1782391808952; 
 Thu, 25 Jun 2026 05:50:08 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46de7effe5bsm3887671f8f.5.2026.06.25.05.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 05:50:08 -0700 (PDT)
Message-ID: <6a3d2400.cbf3efe7.2f1b58.64dc@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260624091900.4107041-10-chrubis@suse.cz>
Date: Thu, 25 Jun 2026 12:50:07 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 09/13] syscalls/setsockopt08: Add .iterations = 100
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
Cc: ltp@lists.linux.it
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
