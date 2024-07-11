Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B13C3DA41
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 03:48:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57C3E3D3873
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 05:48:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D7EC3D073A
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 05:48:08 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7E6001A01176
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 05:48:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720669686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qbL1t2pByVRjjJOp+AzvcDViqv7qUuKocSb04tGPQ/E=;
 b=P9o6OGehxybYFlwKXyiQACG4fedgv//U/4G8li7Da1toIgHui+4cYjPD7hu1WTf8TXB+BE
 QUGb01J3EB1yCvzOyOuctUdP2Fzi1E9D6Vz9AwtyIQpiYGT49eW2pHt4xqntc8BzUUasXz
 +GASoxB4IcdvW0xEqN7m+CQxdzlsJJQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-hcw2_bYoOACKozehJvHyBg-1; Wed, 10 Jul 2024 23:48:03 -0400
X-MC-Unique: hcw2_bYoOACKozehJvHyBg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c9015b0910so1128975a91.1
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720669682; x=1721274482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qbL1t2pByVRjjJOp+AzvcDViqv7qUuKocSb04tGPQ/E=;
 b=bMnt/cl8ziDsPBkY0GCBZmT8qM2gy1dz06PZzbQGfTUVFRvfO5gjtOaQZMkmsCtqIn
 mSPX65O1MXvj5n/NgEQUGg3Wq/Mdi6mwLb3c4GzPAM5y1VRZ9CAKqfzKKY0gkzQ5Vyl9
 s00yp6m2UALtFkpLavDBoPsdyy0nKe5HCUr4g2eWC4D1plbIjz0FE/PUe1GpM6S61hpp
 JabsyvEZ0YZ4tXQfEIgmoIR0NEIAu9scCafZsF+b3swqWnSSGX0+zOD3RB//eonRp70+
 2aDCypiPwPh4BKMGF+9RgAaUHdl8HHmejXsr6ypf26LVpfOmxKp/E5UfMMBDQ2CS1LfJ
 ovqw==
X-Gm-Message-State: AOJu0YyNSGIUfOLnsSdPYvdtrI/vfPBEafeAuAvgxk0kUEaT9cyxSgwl
 plmpOCOvzKBUdAN5lqIJU/miWs1WzLDPurRTioWB16YJ7stmBWQRBy07t+WlKC/E2xllePG141V
 8VdrHyPHTEDzwBra0pInGSD1YyQAWtYa/bxj/dPwfVnnE4/+QmbAmsPNdxSDq84uazKGT9NmVWo
 vEM91Tnu/UgZ5H7fiJ/+Tdq0U=
X-Received: by 2002:a17:90a:db97:b0:2c9:648f:f0ef with SMTP id
 98e67ed59e1d1-2ca9d883b5emr2224637a91.9.1720669681817; 
 Wed, 10 Jul 2024 20:48:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnt+rCapYR1XfS6ogLMZZ/rxwXVav4vOvXRxkoR/wAcLoQhM1ZMZTHdCRMuZaHN7B2J/udhEcds3Vm8zthy0Q=
X-Received: by 2002:a17:90a:db97:b0:2c9:648f:f0ef with SMTP id
 98e67ed59e1d1-2ca9d883b5emr2224621a91.9.1720669681443; Wed, 10 Jul 2024
 20:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240710-landlock-v2-0-ff79db017d57@suse.com>
 <20240710-landlock-v2-3-ff79db017d57@suse.com>
In-Reply-To: <20240710-landlock-v2-3-ff79db017d57@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 11 Jul 2024 11:47:48 +0800
Message-ID: <CAEemH2fQdFpfQObLwbasEkx5QAnwMy1oExEzkdZFQzoPa_8j2w@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 03/11] Added three more SAFE_* macros for
 landlock sandbox:
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
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
