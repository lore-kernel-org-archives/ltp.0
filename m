Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666A2CD8CB9
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 07:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781163702; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=Uh2uZwbbJqGfQDipAOQb4Ry6igcg50xq/JnMTP3rqhb3Xfy8PhbjXrOQ3gxNlDKYKZaY/
 zBW8LNnQ3Zh+5fkiQQG+iz2b30PsV6xKCKdH9NSsw8k5mPNWiIAY1yHgnMRY1YvfcunIaVA
 okfsZz/ZcbryJTjaHe8/RASPlDyFmAc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8C093E2AB7
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 09:41:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BCEA3C2B4B
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 09:41:24 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9D6F3600846
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 09:41:23 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490afc47455so40376695e9.2
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 00:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781163683; x=1781768483; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=H6z1xWScWPXlwEiqoL+5QWh29MJHFYMXR5ou6oBaqHT9ZB0+KhRQPkPy00D5BvfnYe
 w0rJikKjmVhGoRX4zXzvDLyqaDyxxIcQ4TzhgUgGnaNvvp8rqAZRPf+EpWprHUhNUEfV
 xyQizMDmle1XEMeM6jQSpup4cR+XxXgw9XED20DdSBZl8Cefi5sFAVGIuL1FjcFAQdh4
 xcYhUfFNWI2paDfYLRKq5vIKGEZsWysr9RAgNBsFQNiapSatUKOj3i4ij116MYLLUAYd
 k5j66WXEL8IiuanBwSo92qx+4mb4/HbhYSLfKq6dLJua1NGLOMxWcVyJOiF0QyV8UWPb
 o9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781163683; x=1781768483;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=MiuBQH7P2C+9bxOVZwLL9iwNgW2wX3yIuX/hGVB/yGnqdZy/IvSjYilG3vkJaVTpFB
 0LZwdGmG7Uh7vwHjYa+B58ZBGx0IJinBMlvd6uYeuN3Zp+Jeh5hcF2sOTvaTEuTXlN7d
 V4gAGP0Xh9+219BMivTgihDczD+LRqH6fvSEVorVcBaFjKbQSi9VJDzujGz0N+4xu4cC
 v++Cx1wJHb8rMhW3h8wcZRJzVuxH+ZReKTp9XuJ3MxxOJvI2L203sBVvbWQLGqv1wcY3
 kI+gGNtniBgbMtrcihvuNG5Jgr4O/+FPnSH7VXOAKwFMda+b58V5RQbQIGXf27SYQ4QN
 Swxw==
X-Gm-Message-State: AOJu0YyV+tPkXMw7zc4W9g7gEb/YzUSePxlKNrPorCFpR00kW3/HwU8Z
 ezZkx8QPY4T3llIJMdmLPlBb9VpR5lyU7Nod6ClZ/+q7Pne3DMbP92agaA1Tr1qF9KFFp6u/hXZ
 WR0umZ88=
X-Gm-Gg: Acq92OEUn0zFhDe5ePbExmjBkO4+e4kzSaLT1VIOCiFPYQM2bzMfkrlHhVxsLKVdC4E
 2NDI/DqMSxb5GdRbfOJsaS1peXfb1kYCCQwAAesF8yG/PvyZdixGp0aOwERRvcsjw2wlwg2may1
 4BZKH9yliT4nR1PHpgecl+8LTlnPzrSmgBx6K+YnpjTcgO0tVBhlS7XZjr1Qq4NmynKv93liXWS
 ziuH3NWsW5QbBdDjql98tv6omr/XWrCczGtdU+n1E20IXHFRhPfxZ3Va5vCvYmU0bn7f8N8Jeti
 +IUV78QEYOcZjI1PTjLXurHeY1kll7F5gfFhF1y+FwH1SvcfsW68jH4ejr4TsSL79ZkrQVcqeH+
 TOK24lLu/dP+3H9niZHnshMiOCOhFmiup3sSloUY3bZabEdykYBjPcBbMqAcHa++K40VpQLXh9t
 XtlGpbe+WlhIkBize1H/Jze6oouTLDR26EbCRvAYkobZoD52sqKnSglsq109+B07rYpiwQSJUz2
 fL0+G3VYH51WZDEKnVBsZ6Wn5gY3naQIbtF0poJVJ3m9g==
X-Received: by 2002:a05:600c:4745:b0:490:9d1b:f088 with SMTP id
 5b1f17b1804b1-490e55bd5bemr18843465e9.2.1781163682983; 
 Thu, 11 Jun 2026 00:41:22 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2d0475asm68319815e9.12.2026.06.11.00.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 00:41:22 -0700 (PDT)
Message-ID: <6a2a66a2.99c1d4b1.393860.aca7@mx.google.com>
To: "Ricardo Branco" <rbranco@suse.de>
In-Reply-To: <20260507181045.19489-2-rbranco@suse.de>
Date: Thu, 11 Jun 2026 07:41:21 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/2] userfaultfd: Add new test using
 UFFDIO_CONTINUE
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
