Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E171C433EF
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 03:58:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CAC13C821C
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 04:58:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D539B3C821C
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 04:58:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 231CB140005A
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 04:58:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642391913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=419U3XqPDR5HNVPXGjJbNi7dFv7K9mpEoNO0KTpVBQE=;
 b=GvTTXGOGECaj90EzU4LrqJJFzCK93tuidBIDWkt/I15FyD2Zl3nc27PrQWxMvyT57L3d3q
 aJ//qJIRv9MMGV2LAhOHPs22Fd6zsM4+IJFQJTBA1llJIk0OInWsE13y07ejhD5Ueco14V
 QfjrfvWTmADlvyP3sBFiTcpvP6XcNlQ=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-NLxX5V5HNAKwuWRFdTrtjA-1; Sun, 16 Jan 2022 22:58:32 -0500
X-MC-Unique: NLxX5V5HNAKwuWRFdTrtjA-1
Received: by mail-yb1-f198.google.com with SMTP id
 s7-20020a5b0447000000b005fb83901511so30698658ybp.11
 for <ltp@lists.linux.it>; Sun, 16 Jan 2022 19:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=419U3XqPDR5HNVPXGjJbNi7dFv7K9mpEoNO0KTpVBQE=;
 b=oYaFKtzuiMtvbzNyzaAK/VPf3XG9ohssZ00bEl5wlAZyR1SVs2Vr09vV8thcpxqNm5
 WbA3RWuGzfNlCNY3dvgpkdIwzY0IpIKY7yvCiiY//XQXOuN9ktjH2psPxwgZ2VfJWe0l
 R+4rcDCYxTEwgM4/1soi7Fc37tY8BvVNNqFeX2gft8ndG1ThjxmCxK1/6kRSEf6csyz5
 U9cwvGEc7+Qa8w/K+qYDI+lMamzqxA0jagvbHHQat5CciIdCC+SVyk6hwXpMs0DinqqJ
 VtkMCN51rnDC5D5iUJJfj6uRUKQfNX018PABV6ATeHHdJWVDs6vvN5T55bJ+kBLcW7K8
 b6DA==
X-Gm-Message-State: AOAM532uZ1+emG/okoLrihQt4gQyx3V/XempMZiar6+qTJ1Gvajj5z/N
 HIaJlytyK7QteDWmgCTcAX3/ZX5mnF/GYK65HqAKVgOIo8ynEg+eH2Yrgk0993YSiVJVoMlIU8+
 IKM027Hm0cipZfbhviWN3U1LmIYw=
X-Received: by 2002:a25:bf84:: with SMTP id l4mr9735714ybk.398.1642391911903; 
 Sun, 16 Jan 2022 19:58:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSLdXXwqqrEO6t9u+S4MYwGY/MARwrxDqcLPoiTkCJp+HAz7cAifGGfTh99AurLWTvJywp+jGtipEgEapp6iY=
X-Received: by 2002:a25:bf84:: with SMTP id l4mr9735711ybk.398.1642391911726; 
 Sun, 16 Jan 2022 19:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20220114194444.16949-1-pvorel@suse.cz>
 <20220114194444.16949-3-pvorel@suse.cz>
In-Reply-To: <20220114194444.16949-3-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Jan 2022 11:58:18 +0800
Message-ID: <CAEemH2dWsywQ=cQQqMxeL12xeOtVMuFoZDxRbkhi+0kCbdRyxg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc/user-guide: Remove "2. Colorized output"
 section
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

For patchset:
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
