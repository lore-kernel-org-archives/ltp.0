Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC3CD3940A
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 01:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775181532; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Q3PrYMItxgrSk7/+kHBjSczKr6W6QTP6mVQj89qinxs=;
 b=Zmo2CqMzXNqfi2MSxdlPuWn54H5we6M0onxzC0fadqZJyrbhgPqi1TF2CpYet4TbOydAD
 eFjbqcBBMhTLmDQNBhIAmbJb6NuVtkUAT17uxZ+s+SVIz7VXwh7iVaP+MCqJMO65/6F6QN2
 N6YjgVMxXNChFqUEcblX+fupfBl/sWo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19B3A3E56E0
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 03:58:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B52223E1D52
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 03:58:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D5F1F600934
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 03:58:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775181506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=opLGvWUp9ST1iEjFizb5nQ2ipDhR8zeqQgwIW/oMSVs=;
 b=jDhWBFsficqTwpMRD3XPRGwIlXkLVzNhkEIef4E05jr3NLvDgUBGG0A0V0iiujxsyqKRM3
 JBWNs5Ea4W5FqhMRPtx9EgJiG9tiIiIPuKtcBJm6zEGDyk6+JwjjJgyz57ySNP8e92uPoO
 83XIkir/K5IKWcWjx2XpPMzQbcmb02A=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-VkN7xWXUMPa4PwE2tNCV4A-1; Thu, 02 Apr 2026 21:58:24 -0400
X-MC-Unique: VkN7xWXUMPa4PwE2tNCV4A-1
X-Mimecast-MFC-AGG-ID: VkN7xWXUMPa4PwE2tNCV4A_1775181504
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b24e9b4d82so25634615ad.1
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 18:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775181504; x=1775786304;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opLGvWUp9ST1iEjFizb5nQ2ipDhR8zeqQgwIW/oMSVs=;
 b=nv8b6UUbeyHnZRQaTPM4NZFrGxqNifOjzziVmZlvXdK7x0E8jvDF5kQf+pYW7IX3et
 XXYkamoGzkuNXxbNCvDh/lU+xcY9aPRrnZNfH3nH+HTTXvo+R5BOO2YKNq41s0n3IYBf
 B7VXLnhnhfKnlptcCx0lp+Oi3Kb+/N+rhgGtMvxnbUTtaC1Wg5cqVaNOmH+VQ0kibaK/
 UQuGc7HWQ/qfV0tsCdaVO3x9kJ/CxeW1ZXywHZDs2b6MrS/iVh5vP/Qid9nwH+G0sURv
 Fsg4SJhq6+2s7My0jldP5jatG2sXfO8No7bClOBkBu/JfYvA8PR33qF6EakLWaSYPeJB
 S5vg==
X-Gm-Message-State: AOJu0YwIonCkKHO7aw9x9HzEYeGLSNqPO/BwMBlL8RQeCqzHozSZG6Ua
 Z5mbsfixuNpbTUpnnjKhvKv6BuTDuXpvyJXD2gjeCRnYj7JKpS3jG93mUk/VjUXkK4na2feWbNr
 kVmJaRUQM/M5Qu34iPbU+GqyKtAmtgNkagjl7D7FPdj3AodZHyF6T
X-Gm-Gg: AeBDieuRRacFAC7/zGBzFwtVVIzUkRnlIsho2Ol1uhBR4SS6hwJLZ0c9Wtu4P0u3kiR
 kKYqlYbD4HRSChubZjoWecUG6OETt8W2hHPf1sCITbTk6i483LJ8mswpfZ67ULFFzTnN1P5vf3X
 Ww7tyoK0MCZ++9IqSPGEfOQuH8uwsLlC97/QKt3y1TogtOEwydyrTQSUO/RGtcLbKuGhfhdyqUR
 Legjs4xEqjlUST2QL8bsNrkR69PBVp2v6Fu2a0BYz0WZxPzo7jh1e9cDgVsmbq2sT8I+UyD6ykB
 RkO/AAXUE1lHxxmwGRHwp/tFQ44/Ih7HxoaZUy+DZWUfyNJHvYZAIBlOLmoOBgstf7G2fenwopn
 GQSV0kWna/4MGqFc9+A==
X-Received: by 2002:a17:902:cf09:b0:2ae:4ad5:b76c with SMTP id
 d9443c01a7336-2b281c0641dmr11242175ad.10.1775181503677; 
 Thu, 02 Apr 2026 18:58:23 -0700 (PDT)
X-Received: by 2002:a17:902:cf09:b0:2ae:4ad5:b76c with SMTP id
 d9443c01a7336-2b281c0641dmr11242005ad.10.1775181503208; 
 Thu, 02 Apr 2026 18:58:23 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478945asm58423695ad.28.2026.04.02.18.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 18:58:22 -0700 (PDT)
Date: Fri, 3 Apr 2026 09:58:19 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ac8eu_bYc02ywvhX@redhat.com>
References: <20260402205534.224141-1-pvorel@suse.cz>
 <20260402205534.224141-2-pvorel@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260402205534.224141-2-pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yZU9JlBiIw9V-5g_rNSiPMZ4hO6rQubjLMWqQuzR560_1775181504
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] tst_atomic: Add tst_atomic_return_add()
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
Cc: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Apr 02, 2026 at 10:55:33PM +0200, Petr Vorel wrote:
> Combine atomic loading and adding.
> 
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
