Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AABBD4A5E6
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 01:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768527533; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=vyAgQumaIgRFDn47hKS4UFnoBqr61fasdIjeYo/5RqE=;
 b=FujLniAJT8i+xioZ3BkfOF5soGzuKH/Ri8WYJlWxSSsEtb/TwcIxDOJYUzP4u2uIPu8t6
 2MLAmQwNfInLNi0v4+tjo19+RcPSSBmRNiVISqiOMALk/storXkt8DycsVKB9Q9iyK2cVfW
 IydNTQ6aqb16zXj9RR3SiuLRk0yYE0Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD1F63CA510
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 02:38:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C50F3C9A5F
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 02:38:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6F2682002DF
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 02:38:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768527507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rcnm/4fCGJe3pJdl27N51QE91uyqDRLJEiNtBkUcc4A=;
 b=DFpMODouffWpEFlFrRUsQwHj2+lOrhDGN249JhQJY62l6MzhZD2ML9cFmKFpo2BnELuemF
 mhRz1T4Uwv7/QefRDmmw8hLJS4CQ4n2TuJ1D9qXvTm9omslRJ48QFSLfIakY9ATpeBMP75
 c4WJhamQ+F5BI4LgY3BAZhSZ2UiPxzY=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-yz7YvwgpMXeFeQ8tShGpOg-1; Thu, 15 Jan 2026 20:38:25 -0500
X-MC-Unique: yz7YvwgpMXeFeQ8tShGpOg-1
X-Mimecast-MFC-AGG-ID: yz7YvwgpMXeFeQ8tShGpOg_1768527504
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b0531e07e3so1738663eec.1
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 17:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768527504; x=1769132304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rcnm/4fCGJe3pJdl27N51QE91uyqDRLJEiNtBkUcc4A=;
 b=udrDWL5Yc38WB6R57vqjW0CFo7xhAP/IJuzW9dfrzJzei5TyCmCcgCkBiExGVDCPlp
 Xof+p6TzV91msnA8o9MQatbv4dybV9Pm9w3emXsQACeSwO8rrLgG0Mrjj/rM9fGb252Y
 3XBgMJnqWytAjN+aCIgnW+xZaRnJ3xet/i08zs0NgCqPH2mHYCflB6HTdFvbF/wJ/3Ht
 CDCWuTZy80bHxLy2Vz685L+lXhBy3rBPxLjhJkjx2sG9F+56fyXY7ovKrAXT4bkyuYa3
 HlzcLS2UJ/bWcX75eXfEG2PH0KkWrNpLRRn/mIfuM3qZ6b1uWXAdxHBNyVf/xJ45juKp
 86Hw==
X-Gm-Message-State: AOJu0YyPL06EECAiQm/H6teE/AjZo5ZcEqYM8pLEOIaZ+urLF9weLXyQ
 v6Fh7Oa0yLzGCFoyYOYRj6+0/PTNdHBxinGxra09S4zkd1LnMvC9j37NSez7dG6n4Jskvk/cwAn
 B2tbAL1wVP/CPdItfzHZxsIVeiY3thrEn+sZwSoTPBU/yOgXZdL6s1y5amkE+AWPImAJvlAl/ui
 9toM5xAaJ0dZQhVKSMnIfac9qDiUw=
X-Gm-Gg: AY/fxX6vfgw9pJNwRPm0NGX3ydQEWltrnfQmWpMSx7D12CpDVuKkQsx08bAFDPB08ue
 F2DhOnXlfGH2jhZjk2bwaU0m4QtU/sbEUZH9Cn4rj9/ooXPrmiS2HAj7mADTDtCbUPljYRy98NK
 /RVExuerwu3KYnInCSB0Uf7ISRqoDEpexwqWUqaA1SrVUDz3TtR2Jpq2+X6Nhsigwo2YU=
X-Received: by 2002:a05:7300:6d1f:b0:2ae:5b2e:9d45 with SMTP id
 5a478bee46e88-2b6b41078bcmr1091367eec.38.1768527504281; 
 Thu, 15 Jan 2026 17:38:24 -0800 (PST)
X-Received: by 2002:a05:7300:6d1f:b0:2ae:5b2e:9d45 with SMTP id
 5a478bee46e88-2b6b41078bcmr1091351eec.38.1768527503557; Thu, 15 Jan 2026
 17:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20260114140426.133180-1-liwang@redhat.com>
 <CAGsesOQpWLxd9z-pUbJO-ru_ahiEGyCfX-kByKER-X47bBDQVw@mail.gmail.com>
In-Reply-To: <CAGsesOQpWLxd9z-pUbJO-ru_ahiEGyCfX-kByKER-X47bBDQVw@mail.gmail.com>
Date: Fri, 16 Jan 2026 09:38:11 +0800
X-Gm-Features: AZwV_Qjrdn-Cfoo-t6L6lW4l9yFqPUS3nEIarbqreYyw7iFEmnalJ9ggsdqbTSk
Message-ID: <CAEemH2cj6CxapD4hqe72n21=z0Hc4pA_qV2hFdUis26YnEm3eg@mail.gmail.com>
To: Pradeep Susarla <pradeep.susarla@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QeZSAQhl_ncDAyM1zoyLxKYltpf_juGwUK9TFMeEH6g_1768527504
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] libs: adopt etst_* prefix instead of tst_*
 for libs/
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

> Could I please assume that this is now considered the definitive final, and I can proceed with implementation?

No rush, I guess we may adopt tse_ and tso_ finally.


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
