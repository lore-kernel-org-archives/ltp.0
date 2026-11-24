Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8E606A31E
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=S+NIz1Km;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N8Ry/NAU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795509782; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=EY8B/Tx/XuCOFZPOFuksXyqD7rV6mUk7VblgmwDR8m4=;
 b=S+NIz1KmRhPlbaA4lPIDwQt+Qjuhh5BcPHUT5iTD5R12Qo1kcAniPcq/wEoc7Q43p4EWV
 CcSsI+vkdz5JVmYj5PZb6tRET6N+h+wh8rbBSn9tsd6i2ee+h0GZJclTsWStLSX+m8c7kaW
 xgelRMjQD2++jkIDWU79G1oyMBFrJKo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADFF33E97F7
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 09:43:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4339D3C8540
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 09:42:42 +0100 (CET)
Received: from mail-pg1-x545.google.com (mail-pg1-x545.google.com
 [IPv6:2607:f8b0:4864:20::545])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B38EE600445
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 09:42:41 +0100 (CET)
Received: by mail-pg1-x545.google.com with SMTP id
 41be03b00d2f7-cdd77f53db5so2253556a12.2
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 00:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795509760; x=1796114560; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cbGo3XWG+mTs1Yj0HtOzyZ3tkhuOUnIniVlLUHhVlyM=;
 b=N8Ry/NAUygfnglCiKoSh/G6A89Bogv1oTxu26Z6y0LN/ZpbFinVddm8dv0Iwv4zAFt
 NgF3Emt/L01kEHCch2GUD55Ht6xXo6vwMGgNM7OCMlNOTw9ZvxCvEEPhE3m5DJ+UPzPD
 w/eL5lbB3+zH8mDEtzoQN16EUaEfC3DtaMyr8MCR1GsxtGHkMNhARq8ScxiG3Wq0XtnU
 Q4rt9FyDCozoKajC11v5GODGkzPhdDYhYNwARIhXuT28PTlM8xWR+G+XwT491+94fajl
 ugFOlArUmapwt7whT/B67m8LYJo9KmxcunALkZwswS5nDYGI1oL3cQTMNFYSjnjn2PPY
 FHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795509760; x=1796114560;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cbGo3XWG+mTs1Yj0HtOzyZ3tkhuOUnIniVlLUHhVlyM=;
 b=XhLlLFobQi18ZPqZBc8R8Pp7fVq3FupciPyLD3tK1FkSgjh/lJyWSbR6ysx/dYtD/C
 iMkW9vFj8zwXhNiefvOm28UDYB5VYgdvfqpPWe/qExW7+ftoBPwEnTgLYPlY2T++R3uX
 jnBhAeHovgU/GOwokOYozMIpol8FoDCuEGNFA2CkW5i1S3ik5DAzw13EfIvzxDuD0jxD
 mGnLZlGAjtGwtZ2ZUSXMN65RsrGtJaLr2xd8bvURBNXe1gZJaEDqjNu5+tbl9pLCkiCq
 EEW7mg5Alz2Qp//NQLN2cFgMvT3k6FZXy/2bpj9sYrjZYjAKQGQqjY+w4+IcEHXsvkKe
 4bnQ==
X-Gm-Message-State: APuU4Z/OnfMrDfm35xKU9fm2ln9UGMaGeVfPQbV7EH+Z0EFCqbMDEbJe
 P46ELojbHOPH5Uk+Zjh/XEU79ikqu1ygEsII+adt8niQ0Uw/S5mDbKWXj7wHPnxAqTwiPnmUQpM
 IW5bdOgEPIWq8bwFQ1Jr9x9blIvBgwi3uOOvNBHAP5Zf5iRWkgsy945ZKiVEL+ivKxCtKHNRBoo
 Cg8HMxNFBgPL39OF8TO7eH7HuqDA==
X-Received: from plbna5.prod.google.com ([2002:a17:903:1585:b0:2f0:453e:a622])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf0b:b0:2ed:4c7a:31e4
 with SMTP id d9443c01a7336-2f03ef59365mr132610305ad.1.1795509759727; Tue, 24
 Nov 2026 00:42:39 -0800 (PST)
Date: Tue, 24 Nov 2026 08:42:37 +0000
In-Reply-To: <20261116142240.3153725-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261116142240.3153725-1-wakel@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124084237.2967692-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/2] msync04,
 pipe2_04: Support kernel/userspace page size mismatch
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>, Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

Gentle ping on this follow-up v2 series:
https://patchwork.kernel.org/project/ltp/list/?series=1212846

Please let me know if you have any feedback or questions.

Thanks,
Wake

On Mon, Nov 16, 2026 at 02:22:38PM +0000, Wake Liu wrote:
> This is the follow-up to the earlier series [1] for running LTP under
> the 16K page size emulation of the Android Common Kernels [2]
> (page_shift=14 on the kernel command line on x86_64), where the kernel
> reports a 16K page size to userspace while keeping 4K pages internally.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
