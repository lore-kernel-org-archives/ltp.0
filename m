Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE4AC44536
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 12:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784722695; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Aa7wAKUy9z+xyEA7oKylkKZlwjzML71Nv7p/XwYbwJs=;
 b=AcTlLe7n9DoWfplql2oF995bxuNdw1f+SUVltHFy4aKYjKK/94qDxzH7NkhYiQEOP+uBg
 EeOpmDVg80qNnPA6QThaRisEUYiDN97ljgGQtdGhLvlOl0sAOxY4CvFtkMh7jgjtwP9te2O
 87OY1lVNof4g+Svj+d5XFmpg8KubHv0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33A0A3E57AE
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 14:18:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AAE73E57AE
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 14:17:55 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 543E31400BF1
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 14:17:55 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso40706075e9.3
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 05:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784722675; x=1785327475; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bfSlHpYNkYcAICDA23Hw/HXUkKX3HXqS67aemKTYpQw=;
 b=V8f9gMfMhMvWIwvFGy/beb8GoDfINVqZl5rztascUGgSeTeh/vGD0lUe57+2OmzRJ5
 kZbpz7PEt0EelTJ1mjnwmRDbpgY51bIKcnOdQj0NRhepRm6ii/fLaaUZ/e33F/J7QieP
 kjb5mB2lnA2Zp0OKmferZfm3qP/cWP8O55rGb55a+Xf62O8Nh7fjqsX5LN9Vqw5TGGYw
 tIps5Cpf7C/PoRHxtKW/33p5J+uLAN9WBwxkaT8AMjISeQ/r/ZsQ43xushBC0nmy4cXd
 jRBKs5gRRi6RAPtpbEoYpN5fZ1VQ6MNBTdt1Gt2qqW0yRzuM+To3q9SeDLJnrCHgD0Ng
 LAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784722675; x=1785327475;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bfSlHpYNkYcAICDA23Hw/HXUkKX3HXqS67aemKTYpQw=;
 b=hPTTpsSM+M44PxC5ycMQsoaQMAkJJ2AM3Yok4WOsjymQEBqbao/gkhiBKtpoU8In6G
 ahIFyHQR8musvJK8GXIvAyQyxTqphWehBV26xazZJgR8lm7YBmUPDbhi2GxVUksV5g81
 2kfc4luhnL5gk9r7uvOsoGCb8+/WRgzLh8GgouwFsS0+nW/NyxTpfJvgHT3WGteTX4dJ
 b4eoXUFNU7K9YQmflEDaWHLp3a7pOmJwCHigoHiOoqF2S4ii7zPR7XNeDCtTXnd/9Eqo
 +535U5+t87CrTyJYFVx9PSZ1txoADRlv1CgbD0N0tm9Bbxh82JcR7cvaeAo5pSbq/gSo
 Hlug==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSfhz/8gdNS/Ik432Pwb70xrsTKr/NTbeAVdmV8gZ92GUSdgCd+sxdzg0PGY7DzamGYaM=@lists.linux.it
X-Gm-Message-State: AOJu0YwAf8egfqjATd/D9p/OEIxF/4n037/wVgJAjSI6XmGqN3u2STLj
 tze6s75QjAhznvur60jtiWeOhSea5QbF49GHOQ6lrfsQ0/KlpBBsiktoIYMg+g5CONM=
X-Gm-Gg: AR+sD12spyieGe57HsE4OwWbewkXQLFLW5fMdUxQ+OfNQPZ7f9MWbywo1SbFgZvj3rj
 9BdnUiL5y2nEfVz6Lwlze4Y7YK9C9VCCjhOmfbkXzS6RRZXFx89+e3iEYDVZIWPuTB3h5Eg4Zu3
 dlovjn2kMmon+mvEd8ckoQGPuBlJtt7upwZIbC97Ha+VXwJWA76ZdXhIrq3iQRMutUoaMcuoY+t
 NCZGvITR14+W08r7KxS75Nt7UwY6YRvt8wFnIFgGSs965IgOn3XYvDZtOd85iub5ybMiu2MFdP2
 kwIqiuEH8h3NB9BXbSww45bv/dsBA2cnccM8RuVIV/87Pk9vFzoQyLl8Tobj86p1kPC/4e4Kg/R
 Ha1yHqXj1QnZYgaJs5BC5pT8HHPNl17OZD7y7Th8W0boUUEWUIBHQPQjqg0pgh4suSEx/a+FqDI
 IQw4G3pufIkaMeAOCuOloV7Q==
X-Received: by 2002:a05:600c:35d5:b0:493:d0f7:69c3 with SMTP id
 5b1f17b1804b1-4954a749117mr264528925e9.33.1784722674575; 
 Wed, 22 Jul 2026 05:17:54 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm147795785e9.3.2026.07.22.05.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 05:17:54 -0700 (PDT)
Message-ID: <6a60b4f2.332cc45f.161033.23b2@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260722080456.GA826637@pevik>
Date: Wed, 22 Jul 2026 12:17:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] checkpatch: relax parenthesis style checks
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
Cc: Linux
 Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> I'd say it depends how your displays tabs (if tabs are in the sources, we have
> .editorconfig, but not all not all developers have their editor set to use it).
> In certain setup it does not look OK + the problem of inconsistency, but I'm ok
> to ignore it.

At the moment i use the standard kernel guidelines for TAB (8 spaces)

> 
> > > * OPEN_ENDED_LINE asks for not ending line with '(' or '['.
> > > i.e. instead of this:
> > > 	ruleset_fd = TST_EXP_FD_SILENT(
> > > 								   tst_syscall(__NR_landlock_create_ruleset, ruleset_attr,
> > > 						   sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
> > > have this:
> > > 	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset, ruleset_attr,
> > > 						   sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
> 
> > you choose the right example, landlock testing suite has been updated to
> > match this rule and now it has stuff like:
> 
> > 	apply_landlock_fs_layer(ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1),
> > 				path_beneath_attr, MNTPOINT, LANDLOCK_ACCESS_FS_IOCTL_DEV);

For some reason my email client is not showing the correct spaces in the
example:

my_ret_val = apply_landlock_fs_layer(ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1),
                                     path_beneath_attr, MNTPOINT, LANDLOCK_ACCESS_FS_IOCTL_DEV);

or:


my_ret_val = apply_landlock_fs_layer(ruleset_attr,
                                     sizeof(struct tst_landlock_ruleset_attr_abi1),
                                     path_beneath_attr,
                                     MNTPOINT, LANDLOCK_ACCESS_FS_IOCTL_DEV);

to escape the 80-100 lines rule.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
