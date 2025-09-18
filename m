Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25126CAC597
	for <ltp@archiver.kernel.org>; Thu, 18 Sep 2025 22:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758235643; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=SnU6xjFRF/me8XcuJMYqHeDOVpGkMgDU2Z5ArPkFU9E=;
 b=Hbc2J/0acAG3Z4kmvVWB3O9vDUBIB+shPQNKrC8go1FYg2uNYR9/VS/3vgoWhggTSLIXn
 i9GVonmk5/qrMfXvE6CNwWqinqzTn1/Pji60uMyVzs+pCfNyYlYMEWoj3c5HJLlvc31lTPb
 844QmftAGCPlpFxkqXBDsxS0GRIsjpM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 064E53CDD36
	for <ltp@archiver.kernel.org>; Fri, 19 Sep 2025 00:47:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC20B3C71EB
 for <ltp@lists.linux.it>; Fri, 19 Sep 2025 00:47:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E9E0A600807
 for <ltp@lists.linux.it>; Fri, 19 Sep 2025 00:47:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758235619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OUSnx5ArPpHUZe9fSS4ZCMD6TUWJHoi7xpbni3kUGZk=;
 b=XDd+1pDB459NrOO4d78X4iaCk49Aj0vzO7/SJXSwvdp2l2Wpf392FG8WBqSOa4EzNSIvLg
 1NAtqwRcnHBBTbIIAeGXq1Pg+er+HsT+S0DRH0iG12/0sui6ZIPBE2eR4ZPIxtG/OJRiN/
 WaHV8tjCVrMi5rlwIB63yj3Enk/SDWU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-n6VemhZBMc6RcNBtR9A2Mg-1; Thu, 18 Sep 2025 18:46:57 -0400
X-MC-Unique: n6VemhZBMc6RcNBtR9A2Mg-1
X-Mimecast-MFC-AGG-ID: n6VemhZBMc6RcNBtR9A2Mg_1758235617
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-324e41e946eso2303329a91.0
 for <ltp@lists.linux.it>; Thu, 18 Sep 2025 15:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758235617; x=1758840417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OUSnx5ArPpHUZe9fSS4ZCMD6TUWJHoi7xpbni3kUGZk=;
 b=vEBpBen9+EkuDTSYsbPrnw6oyCU0ROLHQ3rDhJpVE/UU+HP6i3XM46/NtcqJIlwy5r
 2Mz1liy3qpV4HXtFAEXupv80PO6/wmxwGSkpq0SQXBFx61sznQP8iQZwg+dN+8mTXvlE
 DpVYwgLogiEV8p35bYuoE2Tvup5zDjhKp9VMim07NFbBIdDAtrWc1v3BPzl1Gy2fo2/k
 6vWfnXlZXEopwPDnxdcxmIlw+8EOJZfdbTKdtuWYbGLGznPJ9Gb9n7lWb2UMsoe/0mMV
 1pEz3XdmG7V89TL14KQ7ZPjmNwt39QaHBRQfyOnpuLNm3yVVNf+zLlvGXyn2839dbn2p
 uwWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9BkwI1uCMpJbcFraeCanIYloEUnOedcwT3AoOryCucbg5ZriYDe5JyQUUSx3LIBq/EKs=@lists.linux.it
X-Gm-Message-State: AOJu0YwNnCV7/0OnMom8aPK/DytUmg5xbtMXync7YrrIzk5euYZ7ry0M
 ZMXt4apG/yCIVWBNpkaQxg4HBqOqT2l33McJiSWWzb90VSSR9altzyqwXem/Cd+x2smdNjx66YH
 M/T1D7XnD0TmJoUWjBoSfjpn+JjOWIun3z+YjdIJN5uCx8B8VXDZ0rMnf5ykWNIWbjNVqmCxkXn
 emwwjklh+ogvYTlehO4eC89YLBdAE=
X-Gm-Gg: ASbGncty6Yxi1SjRS5sVe+jnkghFJx/yBc7yQF7XFLQvbTttZ2wHABHKgWvOT+hhcAp
 4O5cSDsCUgy/FIRu6crbfAWUe3DSF6WkmeoreTKUekZWPnzRxDORkTaDWxG1I+OdD1hTIJJs/wh
 B04DgqPXoG4mqfchgWyXZFqg==
X-Received: by 2002:a17:90b:1b11:b0:32f:98da:c38c with SMTP id
 98e67ed59e1d1-3309835fe90mr1064055a91.26.1758235616711; 
 Thu, 18 Sep 2025 15:46:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn8poQHK7M6Hvc8e4PsbwyfpUQzmIbsKlBa/XhvDmAH/EIvwbxzRRshdXX8c5541bj5WCFIt3miSnWh7lHTcM=
X-Received: by 2002:a17:90b:1b11:b0:32f:98da:c38c with SMTP id
 98e67ed59e1d1-3309835fe90mr1064034a91.26.1758235616262; Thu, 18 Sep 2025
 15:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250915144836.6201-1-mdoucha@suse.cz> <aMwjkaDHEyUGyYgI@yuki.lan>
 <f24f3a60-5430-432e-9d18-bc549144dd72@suse.cz>
In-Reply-To: <f24f3a60-5430-432e-9d18-bc549144dd72@suse.cz>
Date: Fri, 19 Sep 2025 06:46:44 +0800
X-Gm-Features: AS18NWCUFyrNfI-Wth0ZP7PsNeMl4VxPDcstbnkCfn6BUySOHEzGchfanzw_oPQ
Message-ID: <CAEemH2f46hNmV8YRCsGJdB-fzsULrusto751ZE1OCybMWphe3g@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H1WILLzCPK4MeRZ7pePV9k_avHnuxW5M5ig1fI1x_NY_1758235617
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] aio_cancel_7-1: Rewrite test
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Martin Doucha <mdoucha@suse.cz> wrote:

On 9/18/25 17:21, Cyril Hrubis wrote:
> > Hi!
> > With the TPASS message added as proposed by Li:
> >
> > Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
> Hello,
> yes, please add a PASS message during merge and delete the two obsolete
> #includes proposed by Petr: <sys/stat.h> and <sys/types.h>
>

Yes, I helped merge it. Thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
