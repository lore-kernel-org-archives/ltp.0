Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FD0D70E03
	for <ltp@archiver.kernel.org>; Fri, 29 Nov 2024 02:05:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3B073DBEB5
	for <ltp@archiver.kernel.org>; Fri, 29 Nov 2024 03:05:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B8823C7261
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 03:04:56 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 359831427B91
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 03:04:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732845893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lBuG4ogv8dDhQqg0d9GfAo7bhZO0r8NgvO0fKuTPp1g=;
 b=F7LEop0+0Bdzar8NHJNofI4Ip8lVSF0gR50gTtVXIzS3m/hDp7LSUREoXqqfpFo/A7F/L9
 jpHZbUAtJfhpMGHHPyZCMjVO+/ebfta8q7FOBTzoKvfDc5nd4X24UpHs1bHK0poE9brE+o
 UDri6bx3E7kVDgbmgbLY2ALZpXBxM7o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-0ONjekCGOPC3CQPBRVWUMQ-1; Thu, 28 Nov 2024 21:04:51 -0500
X-MC-Unique: 0ONjekCGOPC3CQPBRVWUMQ-1
X-Mimecast-MFC-AGG-ID: 0ONjekCGOPC3CQPBRVWUMQ
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ee4b1a1057so660973a91.1
 for <ltp@lists.linux.it>; Thu, 28 Nov 2024 18:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732845891; x=1733450691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lBuG4ogv8dDhQqg0d9GfAo7bhZO0r8NgvO0fKuTPp1g=;
 b=GCS77ReGsco82LRpwfwd7psX+axHwSsHdvIj8K+9UgH2Z4ayXpt7Oyk8nnwU/hlGVa
 TVfwnyJxzXFfElxsRrqRzoxZ/CecwrejTfWaqffB59f6dy3t/ZA2H+hOjpsYWZaKmzjO
 mTVt1pOfB2ZJHezUHnoPR1bAHmxJ44OqkuIRR9gLLH34CvwMLSEHc8l9O682hhadbAoV
 PqfqPVXdZMR/9ibBeiKzj74gnl1A+p00lcMdFCYll3B51U5z2D5jl16zjvl9iKoW33/u
 aSTuFe2gOPcMFsJWdAkxpJLA+8R4KMvqKH/5rLdTNhTQKj7TAwt13PPsZRdRXNmAw1Pt
 CNUw==
X-Gm-Message-State: AOJu0YzxKXt8F1S7sAcC/R9rrq1fsXatuuCF3KPf8D21H5cRyH2XmO/0
 Zch/94xd/taa8aLcYaWXaIuEoA3z5NjjA6AXZqYZotp05A/r9X9vfTyAi7pwF9yvLY7f5pYYF9W
 eoUdDyCJzjTmmJdQnhKcCZt/6hrBvmkMEZbZGjhCpugEod5QHhsK4rUaOADoPEK6jLfF17H6xcd
 4xbqyDb86PJ0/k8XLokFPtCuQ=
X-Gm-Gg: ASbGncsdH+Z3R6DMGE/PFgVJyIfmks8QntFwwk+wCWTVzOvtYLtu+gVPCFC+BTBAZXc
 sCOFR/aBMPRG9DxiJZTL3n6QkYK0RSHDk
X-Received: by 2002:a17:90b:33ce:b0:2ea:6f90:ce09 with SMTP id
 98e67ed59e1d1-2ee094caf5amr11011137a91.27.1732845890904; 
 Thu, 28 Nov 2024 18:04:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIoL2Fv+yr405290qg58wQPl54yZBNB+IAGDmOoEEqdR08YRHXSmwvw5K0w9xwvrx2ok7T08bJ/tchmTbSkic=
X-Received: by 2002:a17:90b:33ce:b0:2ea:6f90:ce09 with SMTP id
 98e67ed59e1d1-2ee094caf5amr11011104a91.27.1732845890437; Thu, 28 Nov 2024
 18:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20241125-input_refactoring-v1-0-b622b3aa698d@suse.com>
 <20241125-input_refactoring-v1-4-b622b3aa698d@suse.com>
In-Reply-To: <20241125-input_refactoring-v1-4-b622b3aa698d@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 29 Nov 2024 10:04:38 +0800
Message-ID: <CAEemH2ffU-mtK4dqzSudrCCOW=KhpVFAj_rZVddiitn2WYVwKg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iDgHfIWqqICD9nAIuD9A_qP1li8y-cgQYXSj6u-kaG0_1732845891
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 4/7] Refactor input04 test
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

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
