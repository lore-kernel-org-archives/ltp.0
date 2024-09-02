Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B108CA0ED3
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 05:52:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0252D3C3199
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 07:52:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 566683C2669
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 07:52:19 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 515E060081C
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 07:52:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725256337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MJENSzxDM4W7cX2rmABSOuQpmO/Or/fBHuk/Spdf1dY=;
 b=XM70ayzXlhpAZRCB/7fM+XF8FsZ5vjS1OU7sP10Anp50IvPZt3A6pqy3PJwBZ4/P5eU5TN
 a2wcZuiAsVepZvq1DGx9HBtvYBoM3cUkc6skP7sZgp0druDC0vZzNBhjbC8oEZATGr3Z/U
 eelH8N6xqzRHnzBSHNFw4sHzmXHdycY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-CnjgFVarM7q_N-wfSZUjRA-1; Mon, 02 Sep 2024 01:52:15 -0400
X-MC-Unique: CnjgFVarM7q_N-wfSZUjRA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2d876431c4aso2364014a91.0
 for <ltp@lists.linux.it>; Sun, 01 Sep 2024 22:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725256335; x=1725861135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MJENSzxDM4W7cX2rmABSOuQpmO/Or/fBHuk/Spdf1dY=;
 b=osDTr94zEMIswrdZLmF3XKrIJZBbT00fbaN/uUO3xSRvzAigiNYjSYfj1yZPolJvwM
 Gqb+aWRfsJjr8waAXnsz7hJBlMZN05YARkJY4ptx0xXI6BZ4Mue+KSNTejC1qnkyxQQe
 CPFeJ3TL1DPgTGQPIrFV9tnlz/eH5iQ4ky6ssQG/pZXXxJINqHCRGNBpHkiLX1F9hOZC
 MKIcKqMZz/e3NnqYLvT2XdLuyKo2ylNFeuVOTQxE1Em0DFTal9FS5H7lSukoSqQCUyZn
 w6aAcMkdgLQ26mLA7T/ZTaTCixk2/KidaMYOmOULFGniXvNcpa62IrZ4Z/nCjNgMg47A
 YKNw==
X-Gm-Message-State: AOJu0YwMDuVnmoCGk1YZjkwF2V0o2qotByhq1jQPFmJsGFYJ2yLJO0SS
 B7pw/YsCI5AVTx2QKgZtna18SNpf6AEnuYKItoSM+h0ldNvjkRcq5W/Bc05L3z6DnGtX60yx352
 5i86wRLxlatd2LDJMJQESJ60vA916DrYUHnrn20c+lziv1esTENGZuErYHPwAYaDz9CXD/MYScY
 A7dsxRyclha10bHuoZQTHfoYw=
X-Received: by 2002:a17:90a:f30e:b0:2d8:82da:2627 with SMTP id
 98e67ed59e1d1-2d882da277amr6891210a91.27.1725256334691; 
 Sun, 01 Sep 2024 22:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9+4ygEDgD3rYOtVkC6yaagneg9SdlwqRMnkbAlfkB9sndozudGJPbtafoI7Dc4CwTWjUMGmqxGiNd1lVmo/c=
X-Received: by 2002:a17:90a:f30e:b0:2d8:82da:2627 with SMTP id
 98e67ed59e1d1-2d882da277amr6891194a91.27.1725256334261; Sun, 01 Sep 2024
 22:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240902040310.630308-1-maxj.fnst@fujitsu.com>
In-Reply-To: <20240902040310.630308-1-maxj.fnst@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 2 Sep 2024 13:52:02 +0800
Message-ID: <CAEemH2e8bMbhHucftcK=+EFZ7aKMmWNLrRR+M3a9b17Q5e_8kA@mail.gmail.com>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_setaffinity01: Convert docs to docparse
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

Both patches merged, thanks!


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
