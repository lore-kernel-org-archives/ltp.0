Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24573C5475B
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 05:02:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47C9A3D2219
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 06:02:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28B3C3CEDAB
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 06:02:19 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AE1E460312A
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 06:02:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709269336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OPk8nLLuLhHcR2sdIw64Ac/ARp/sXO0F9cJeYR1u9/g=;
 b=TarFrZ6CwZ/z+3K2lYp2aFh6tBuOOi9pYYaHc/lhZMPFuSLfOVOCu/tTxMNPBNPn2+5Lrr
 zzmW9sZW2L7cSd1Vyl8/xtfzM65ixL7DEAKTCrRW0wz9GviXHZKNwqVA0JjIYBZhnfsP/j
 /M+w5/JlOyBdqpGDgnxAa4xO7lUxy60=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-MGuH4RKNOPSZ_lHqEAA6Aw-1; Fri, 01 Mar 2024 00:02:12 -0500
X-MC-Unique: MGuH4RKNOPSZ_lHqEAA6Aw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6e580e5d43cso911232b3a.1
 for <ltp@lists.linux.it>; Thu, 29 Feb 2024 21:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709269331; x=1709874131;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OPk8nLLuLhHcR2sdIw64Ac/ARp/sXO0F9cJeYR1u9/g=;
 b=foNKmXLVTy8jEOwpuUTYIeWssliJoKP6o2ewl6TqgBmJRg3FiXQXj10UH5/+iQjzYy
 onNXbpNFbjnDgMqoDo9kV1ZqXlJS3dt1u+GBTiGkd4D22pJNT7JcEi0cjghPnavHRSLH
 QJzyY9Ux53rbwGb3hS/U7VpfaAQhVjCUk/J6wetId0OZBUDOI9M3AGPYzlMHjC/6kIcF
 M0JbrIcWBKyUovWXZzawE0VoZw1EMMHhNpoCh4QoQn6v/jUajcPmpnM9WU9p0mdNtD2X
 TsuuoQLd73nZ4l799C83ctTLLvJI4SifE8WctBXmu/Fj/eJnIlcD8XYQWcatz4Oiz2hF
 IiYw==
X-Gm-Message-State: AOJu0Yxk2czc3ZhxuhGe9pDg0pFp+gQHTCK0CQ086SZnQipabT95B4Vw
 Mx062yh3qdviFO1gTIhB+E4VI4U86CAp9GwO7BxHsjlBBqhkQosB/Nfrdh36B2ZN2w8XpatxQ36
 Co/+RmknDiqD92c/sS1cdRo17t/F/wOZXl1s+cvLvZ85BrM5+JzIv4kQfliHXzGD2G+jEXhinn1
 QxN998M/pHrmvAqVL67pBZZZ4=
X-Received: by 2002:a05:6a21:328a:b0:1a0:e944:15b7 with SMTP id
 yt10-20020a056a21328a00b001a0e94415b7mr670985pzb.5.1709269331506; 
 Thu, 29 Feb 2024 21:02:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2bqLS8nPsJVuewrUF3VeKgRN+frtitxiAs8ZsnnJGgrf4OntlStcDuFZ7MAeQDHLeyoBCUKmldgGhVX4tAP4=
X-Received: by 2002:a05:6a21:328a:b0:1a0:e944:15b7 with SMTP id
 yt10-20020a056a21328a00b001a0e94415b7mr670969pzb.5.1709269331233; Thu, 29 Feb
 2024 21:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20240214170949.793338-1-pvorel@suse.cz>
 <20240214170949.793338-4-pvorel@suse.cz>
In-Reply-To: <20240214170949.793338-4-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Mar 2024 13:01:58 +0800
Message-ID: <CAEemH2cuq7P_eK8fFR37ZgAF+w84Fkcat_BRM9nmXpmoODkuYg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 3/3] tree: Relicense GPL-2.0 (v2 only) =>
 GPL-2.0-or-later
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
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <mbobrowski@mbobrowski.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

All looks good to me. Feel free to merge this patchset.

Reviewed-by: Li Wang <liwang@redhat.com>


--
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
