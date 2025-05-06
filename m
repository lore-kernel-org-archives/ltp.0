Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872C9C3ABAC
	for <ltp@archiver.kernel.org>; Tue,  6 May 2025 10:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1746526779; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=XpbQqgpXZXxBmbyiQbqGfj4RvQ8u3penhMA3PX1P4gU=;
 b=DMQRRX0EOYdYXuH5eRhX2d1WgZOQHwFXkEkuVGIF5YnoiEA1hJIq47LpvSnQy8RQg80Zu
 SPI1s6Ih7IMIKfGmccz3XGUz0LeiHwNb3dTkiktab/oSVjIDojUmvZ/GwPDJdt8C3FDmvzv
 1sAKad4ibgwbZX9HipYnoZ7vFjflIZk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E95D13CABBB
	for <ltp@archiver.kernel.org>; Tue,  6 May 2025 12:19:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 589643C6FCF
 for <ltp@lists.linux.it>; Tue,  6 May 2025 12:19:17 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D7110600A96
 for <ltp@lists.linux.it>; Tue,  6 May 2025 12:19:15 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-acb2faa9f55so725457566b.3
 for <ltp@lists.linux.it>; Tue, 06 May 2025 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1746526755; x=1747131555; darn=lists.linux.it;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hy8AYSweSloDo7qxNyz/gcTc3a/EbHQaP1zdj4v3QNE=;
 b=N2JzLyDInkRkHuyzr4WNlW5LLtZxwyVdkWCBkw6JSA9miH8Gyh/55Fb5MzUSWlu3hG
 E7Pnxj8GbbKTqHrQ9h5shmG9Pg1eN6MCUbidVMyCrnNcjxIT1P2BRmyHtH61aHhHZYGm
 5vl6KUN5f8iiDsGbI/gH9RTuBwitvGObsv1U2HtxgAx1j8vxM9rHLvdDUjSSwnwqoKZh
 0AdBPo3wwY4ZJHFaAXvCRnrAm+0EsvFl05N0w+YhSKFhD5hytEKtG/WCz9gWuAUT1obt
 7eqZLzyas0A/N3gEQXsk7tMEydBtRIN9ozU60W7V0Du8uwzt+ocduhzjWezRn/p1/CGS
 ousg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746526755; x=1747131555;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hy8AYSweSloDo7qxNyz/gcTc3a/EbHQaP1zdj4v3QNE=;
 b=trRNwgklnhhon7DggwdrvCUUtc4C+sGxmlx203Lo+fYVaB0ItJLAqUWxanlc08NACJ
 H80KqV3rC/KXrOUhzRfA/dRgVuC6ANqihYX5VS2NF8gNR9YiWX61Jnqox1+kQLXEpLUI
 8tlkZ7WGUKMbnqbXNYDlSu+XEzAcaSaJ+qzX/+AKcrFzfI7Aov49aRIBnGyovD9XF+/8
 GpVCq5dw2wgF9Dc4PRb/lZnzz3d+ywCfjCS5uJCMIOA0geghMDH8+ZDHyGUMRV/ZvKDt
 XC6gv9HC1z2JgoyaRfDJl5vO3cFY81J9pT24n2tFEtFV7dd4+pKSmOpooFUVsgvqvbys
 t3TQ==
X-Gm-Message-State: AOJu0YyRYKuDjkAw/A6zcbNQ40nxFCNJucapj0DgSIzoMs02IuTP9keQ
 TRgUfGmp7pGoyKkdfiFfa3K5TKcB1XgqvY2pSlJeZUgtPmBkFWJIVdJOp6xXpI0=
X-Gm-Gg: ASbGncv10VNd2tW+JmjREugHt4zqHgpt2KlDWm0TaOoPqK7inZfDZPl5nxpki78vupD
 PJS/ZT4+x6M7qvWr0ProYuZN6PpLdo6hsauEp40eWMAoLVIerdOlJKNB/bSoBS1NVWX0iQtOZUa
 LFGv6aYNWSU3RaNLAIbDeKosioMIhp8mT65GXcj5ichgHdoj0NsmiuzaKIDx4QUGv6mcxMQymkP
 5qtdxew0ti26eBpXl7JsJhEjO3/QKZGVfnFMrXCdNgagTX7C91eWMHGiKfsw5zqh8myFSgPr+Bv
 6EH16VJVBHchbt02RQz4+Yfj8fdbdBg0DJOjFZ0=
X-Google-Smtp-Source: AGHT+IHgPpC6JLYI8X3G6Y3xvMdxfOre0vNDaYOQDzXrx6JGG5nYb9VKSFv20ZpbhepqJ7MCx2Dokg==
X-Received: by 2002:a17:907:9704:b0:ace:d8d1:a46d with SMTP id
 a640c23a62f3a-ad1d34d3597mr241196366b.30.1746526755170; 
 Tue, 06 May 2025 03:19:15 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-30a3476f4c1sm13557401a91.23.2025.05.06.03.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 03:19:14 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 06 May 2025 07:19:08 -0300
Message-Id: <D9P027Y7LJ8D.ZR000528Z1C4@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250429-conversions-modify_ldt-v9-0-97e4664c25c5@suse.com>
 <aBnaFPb0pBxZaWM1@yuki.lan>
In-Reply-To: <aBnaFPb0pBxZaWM1@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 0/3] syscalls/modify_ldt: Refactor into new API
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Cyril,

On Tue May 6, 2025 at 6:44 AM -03, Cyril Hrubis wrote:
> Hi!
> I've pushed the patchset with the change I've proposed to the tst_test
> structure in order to produce a correct metadata. Thanks.

Thank you! A somewhat related one is this:

https://lore.kernel.org/all/20250404-conversions-set_thread_area-v4-1-de663fa7dd9b@suse.com/

-	rbm

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
