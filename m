Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84BE606A322
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S+TsY3u0
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 786193E9A19
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 20:18:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 588283C00F1
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 20:18:35 +0100 (CET)
Received: from mail-lr2-x0b.google.com (mail-lr2-x0b.google.com
 [IPv6:2a00:1450:4864:38::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ECC28600655
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 20:18:34 +0100 (CET)
Received: by mail-lr2-x0b.google.com with SMTP id
 38308e7fff4ca-3ac4f373d3bso210451fa.0
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 12:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793301514; cv=none;
 d=google.com; s=arc-20260327;
 b=XoIkQy2CpoFDw5jNI9GbXqXewCPftTu+JC0tcQszX8nsorbTzxIwxL71BANm0pUpFD
 btMbuMevP/GFdxU7O9ezdxUgEqyhB+PRdnagDU8j5snmK0ggKtPXaSCbjI7aex3z6mgf
 Sip9HHvi0+UDlB6p16zuP2vzrjS8P/P68QXUiLDgDTi/b4BSoQW/TYuQiOr/D7EhRZjF
 /pMur7PnQPR2fl9yaF4JQzDhxPUxQ1XP+OkIt4Azk7SqqhEs8iZTfBH+NLLD5sSmVAdL
 XnS6fZ1LdpIV99+fCUHMb/Pfzxbr6+fqKx7ZQW2Xhm4CoGoyrM7xCJvKzd+Xfa+KNZuN
 fpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zGi19Wr+uZ7jaR+JUDIMwu1MpVlwg/hES0VNUGXQGiE=;
 fh=/hJnUO1N7Z0bNEay4+H6I/UlSuHaSzYEPx1FbNoSWk8=;
 b=mTWDs9qLZkdh32hDw9DQnCppP8Jb6WIa031IPSlU9F/BcVMASnrgzUPz+LZp+PcpoT
 71T6Ho4gTJt6P+NrySINj+RqbvXUAaSWqG3eBf8Luz2wdnfKI5TJOt7MP+JWJdGv5SbH
 QRSjnyAmhh/8/fEkMb75KQO0y2aN3YLrrqQUffdy8KHaS8hE8LGccJG4L6+03G2+5cUL
 C+O/uWHr+nnw+jmPQqew9ye68vboGTRMxD7kJbcCK4yAKrQ4agu1xSouJTa5FaUX6QIt
 lHsBlyaWa7po2sy92HkOn9vs4qvwZpwBai//OgIUw1oYpdSNFKx5wM6nKMxmw+MMCsE/
 0Mbg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793301514; x=1793906314; darn=lists.linux.it;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zGi19Wr+uZ7jaR+JUDIMwu1MpVlwg/hES0VNUGXQGiE=;
 b=S+TsY3u0VGFg8L2VjlDLpAdgBFv2TmzLxpCfS4vZ9nMtBd8DX8IuXylqLv6vcxJfYt
 fFCp9wCBs61AF2CKFqiGlykZLcAv2XPIYu0bHvLpV68a2EFUanbEK87fG6yPYIEhIMyw
 tJCQoZBPvu5i1kvl3UJQy9GZnqKFXaaQe6C1GMsd94IhTdfpc89Maj7Jhk3xGAHEwuvJ
 uhUJsxE9SGNLLdN4WavQkGxsmonjOBksxGEiVZGWh/TW7vzve/aArJdAEa8IGsZe9dx8
 zaJ1m1//6jcK59cx9tYpKC7Sc9loW3gqwj2KjXD2wPAf1pXGWo29nzREhy9mP1+8JTSU
 anfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793301514; x=1793906314;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zGi19Wr+uZ7jaR+JUDIMwu1MpVlwg/hES0VNUGXQGiE=;
 b=HFYFo+AIFShlB0ZIuU3flCmsNoRn8FCegG4gHPScfLX8SBBc+J9QukmNlLRvHiDgPU
 fEkXMGAdr7H1St6eWDFa1osz6MUISR4lXVtDOdXpaChRyw4AslBVopVZkHmY38+G8ML/
 KYElU9EIwvdx7kMBGUom9xiVv0z7TH1uyM+4h5xhiz2AhFkQzamexK6ilso8bpsVD87M
 VyXBuPe0OFOoJBpjwVWu94psw5pgim2gDVRAJ+700V6NzgyxitqWHeMvGPnn2nF5atjd
 RrraflU/zr5NUmsv+F2H49dXnX9FKuGgGH3VvowHkhum2byta8FRHZ/cacl5IHHfsakC
 bsZQ==
X-Gm-Message-State: AFq9FYL88HLm1gAaqICKlkpNMQgQUlb6o3Lo9pKLbCrl3OixLGV6PHot
 0SYF7HmL1wrqBZTeVSzRtrATCC7zVsTyk0/6IiAuKB8K5Oy8mQ+6B8YQL7+XXfZJkgZuD1FX+bB
 qvWngVN+MNqSffO7LhRZ38oL+ZwPRe3Q=
X-Gm-Gg: AYBFou1SKJ9ifZFbkjIv1t26pccEtRGNpyoD1+tqFLUONbGK6+dpnRsNZjfgl1ADJCF
 DqLHzgErMhn3bjAFITroFnm94NBDF31Uq9j3CkViy04zgl26qBxptMizlIM3tjTj9JpYi7Yys8Z
 UiSZG7gK/7kmUllrUn8QfeKtopOwPTRV75BU7Knz3Eff7GL+Ge4H2fL3X4mN75WrMaiNVcVt1ch
 Euv5+ljfBgZfdwORx5d56rdWs54EXw+nxn5XaKDBqM9jhwNJZsuPonihniZJqF0kJkGMK+OoYJQ
 RDFQRjlGR26arkjf44qJlznJi4tCZ4wvBGmamHufQGtE1ArNWskliw0XQZxmCgvvIVuSncvUrII
 eNqlVNZ2ciSx7JhkWt/NQmjOXx62tFc23OMQelmeWMJdUh0uaLQCbVQ0nGed6ZtM2mWbC4l4=
X-Received: by 2002:a05:6512:3e1e:b0:5bf:d6f5:f966 with SMTP id
 2adb3069b0e04-5bfd6f5fa47mr405402e87.47.1793301513706; Thu, 29 Oct 2026
 12:18:33 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029174907.98721-1-dennylin0707@gmail.com>
 <CAOQ4uxhc6a5jdwj+o_pCByYpwOC20=uHj0mi4D5n3UgrTqR7uQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhc6a5jdwj+o_pCByYpwOC20=uHj0mi4D5n3UgrTqR7uQ@mail.gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 29 Oct 2026 12:18:17 -0700
X-Gm-Features: AclHuK_8VrzokGWXomjZEgCHDMKIkH6MgppVgTX-POqoNF6kX7NhfdTmuPJdxGs
Message-ID: <CAGEkeHdYqS_9wipk9oy=ofo=KbNpOwccuqVEYPg0LqzCykXUrw@mail.gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] inotify13: check rename cookie pairing after
 adjacent moves
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> It highlights the mismatch without cluttering the log with more information.

Thanks, Amir. I should have followed the existing examples more closely.
I'll place the expected value next to the mismatched field and check the
rest of the test for consistency with the usual LTP conventions.

I'll keep v4 limited to the diagnostic messages.

Thanks,
Hungyu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
