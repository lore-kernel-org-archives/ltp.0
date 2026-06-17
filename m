Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2610CD98E2
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 07:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781681545; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=XwtkNW/q4a/J41laOLNaeScdCmg01PtggRco4hS7xgQ=;
 b=gpPEktPuwkx8IqHKGuwxrjCmCnFsw8PqDEBVMsLdUmFrIM7xwDb51z9wGCFVaEdiclVFe
 IrFk6A8i0tAoHjZyLsLhP18Va2iKyJuw152jr2r6ohnQVrCoijtg3F66XqPj7l/fbVidwrF
 5/C9UQC35rrubGmlx5XdIJ+oOi3JT6U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64F6B3E58D8
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 09:32:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC1973E1FB6
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 09:32:05 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 034281000D8C
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 09:32:04 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so36315215e9.0
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781681524; x=1782286324; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/HnmBpAu4tnIt8N0gPWsVYLoU9nTHoXDHcZQn6/LdWA=;
 b=hAF3kCzEayWelRVj8P/9dKDlP0enD98+fmSX5su4/CGE7SWT53Tg6z8eLow9TBa9CF
 rc2mLWaLoNK3Bo9zwX2fMMkkYPc4aGxdEEDkHtIfMR8IxMUXn6iZZt/kBUFw6rPRro5D
 mmgU+bSAQZ9z8lEJk6f5lLYAT54XvUErxL8UNoui650bV/FwidxLhqdILzy37eV2pNJn
 XxareyEcnLl5GvYPaBNqRnSP/aSADkHfeL/MVBVLH4Q5UVtZpZduhfipGYIkIvdGZPuS
 syohjbuD0pHp2dCFAFFoO0viNQxS51Mc3vhbXjoc6pagyVj6qijUyh9H0e+56QDruiMi
 2Kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781681524; x=1782286324;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HnmBpAu4tnIt8N0gPWsVYLoU9nTHoXDHcZQn6/LdWA=;
 b=HFm5/8EF+/PYLWKdUkC4mXHKx2W8oF+ZTJL4NdxFumPlqPyouxpAJE/VGWLjmXsNFH
 slk/motOX5gZDe7tqp+CN8MudDHqdryPGVcPwRRtbCRu3NgGtqjk5bKmt0tp20sYUyBE
 PRQs56p7K5yR2j49T+FHEP5Op11v7MuNlLIfoDw7rQE37LWCl0B9Hi5TFfhluvqgJEj9
 0IWJilNnkIVV6W/wcJ/VMlXq+MWAVqAdU30Dg8Sv08hIPSrAQXHCGs1e0XNyDWQ2V2Pt
 l3Ja0m80FxOtXR6dEyRNxO7IxK1Eta/4bivgwUfsjGxbOTo6whXhh4AKB2QUH7NQetKv
 zvCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2A3sXIB3ng3LMxMtHWx1XXdJYbP1VGjqtHdChshafPGj3nGLF9/t7VZOD6c67b2Uuucc=@lists.linux.it
X-Gm-Message-State: AOJu0YylGzkgDsOLfQXnVb4OhzDYkuOBNRBQHPqsZP2sTafzRPU8CNbW
 EOWZ+zSI5XOKtlMBQM04z8FtZdf36Fsx1w5g7QM2oaGs2XYuDBXWUu9eep81HMCbsCM=
X-Gm-Gg: Acq92OH62+Uq5wgUXOjGLcD5qkIclU0p294ZL8OLiV/NR35nUfjXehfXElM4BSpP55/
 wltF89jE9d12JqjPQ4rQ4+BVL0GjeMM+eCDJZyt37Z1FqMhpszmu7nVeFVIsKiNSuxyJJDSjlW5
 BPScbZtXx0FcrSYSwOGV/IBco3hkeK2ek0B1BpGTIFRBrPOMZGvAOuT/aiy7+AGIxQT/Yh8Y15x
 msm3P9KZkb/bbq9OnffVkHUta+yjw7SJjUf26OWa/wIt7y7I27EyMDHQuM1aZs8GDUIAMfPSgrT
 QZ3xBj6AU4N1n3d4aZUf4J+bzbRyU2d9b4/LqIIvGk9lSvyac4K9zmqcdywDUvtPvEzt5ywOzVQ
 iHHuctdpWzt0jfno+Dz4xHqNhf7Thc9Hos+kQJv+dGbC511pIvMCdRBuXVjXT2Bf+mMNqO7ykxn
 j/fy6qlABIlcVm5g9vsGVlrq9Zp9DX1cfsr9OIl4EonkoKuC5Wg89zq1yfZ0LrhGBUBu4RVNyGM
 mZ+MBa6dA9TXeXKvre/tbz6
X-Received: by 2002:a7b:c3d1:0:b0:490:b92f:ef5b with SMTP id
 5b1f17b1804b1-492341088b1mr20367315e9.13.1781681524268; 
 Wed, 17 Jun 2026 00:32:04 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa97a07sm242622515e9.14.2026.06.17.00.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 00:32:03 -0700 (PDT)
Message-ID: <6a324d73.abb839ae.15633b.80c7@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <6a31618c.7f42fb59.24bb2.63c5@mx.google.com>
Date: Wed, 17 Jun 2026 07:32:03 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rfim: add new test for verifying RFIM sysfs
 interface
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
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, ltp@lists.linux.it, daniel.niestepski@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> This function can be easily replaced by access().
> 
> TST_EXP_PASS(access(path, R_OK));
> TST_EXP_FAIL(access(path, W_OK), ..);

Thinking twice, this can be even simpler by using stat()
and checking for .st_mode in returned struct. In this way you
filter out all permissions, not only read or write.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
