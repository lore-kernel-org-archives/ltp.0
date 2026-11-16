Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5E8606A31C
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=of5YgAy2
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8158B3E9C29
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 13:09:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 987263EA9D3
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 13:09:12 +0100 (CET)
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 57CED20005E
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 13:09:12 +0100 (CET)
Received: by mail-pj2-x02.google.com with SMTP id
 98e67ed59e1d1-3b196fefa1fso1579412a91.1
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 04:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794830951; x=1795435751; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+gRxMl7SZvVX6qffIuxXf7cRrv0Sw6cP/0Ye5DZoVPY=;
 b=of5YgAy2rv6sj99jeJRiiucsfrmzIXW38GChUzumliKIt34Vs9C4um2QiHZAzFrEWU
 +MAECAi5WjFp2yoL6lBJa7ia6RD5UVKdvflpfSLpj8PnzEw6hnlXBAHlbmGVdHKlsVds
 bFDnNSIywTKa9nwA/X9iLZhgVvGrp/Wq5Y8UzNcTXbPX/ql4fH4Ij35Idj13iHXZj4s7
 uWXJU3on6lOvi2uLKRZ/JQff4gDjRQQvjCfP/x93seEKfdynIvBpTI/WaTmf3/EZoWcO
 B4VS1tEOeYLVapZomSk7q4SJWe2I0W5N6G/BHA7I8P1tgnbgskaT7uTK+uE/tF5Y+qh8
 HyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794830951; x=1795435751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+gRxMl7SZvVX6qffIuxXf7cRrv0Sw6cP/0Ye5DZoVPY=;
 b=w/i4MT7gpYgeVogmr9MDIAnSzt5/c2oY0LSasd0ksI/5mVf+Au/4oQO8JBxWNSeOPn
 Y4Dehzze9yh3qCAJeorSjJTZRERatamlECFQYF4RyKhXBifM3Yyic7f7T5FjX3nP5Rsz
 R80CXuRQe2uCK43XfOPSyoqN4A3Zff/9V2JsYse/TsAzZ4gMiL1VZzO0HDCHY19QXLWp
 HAHowbeglqUFM6zyA6h4ryFgXrUhknZ0zE1lvB6yolvR8BsLu4LCPpYOngRS9twtVU8B
 DyHQ0uVL/ZrMyp3++vklRGRe/+yIBZiSw6f2EGrym/fvyRR8GF4U0uyEfD3GQUhSB2ai
 pbEA==
X-Gm-Message-State: APuU4Z9NyLh09h5Qmy7yM0EstFiVWUoSux9W3U11KpO6gCx4doFpk6Et
 aVRcQOJN43nuPBLFdP8lPEh/Cf6j4wDG1rWlx5yZin+bxAw/po7p02ks
X-Gm-Gg: AZFdTZcDVZjodlaZza4UK3+xU9OW4/GjOPXjNbpimuybJ9+yoXyCx0rkG4wyELuphl5
 vFB6EH1AJexvyanoCMT39DJUA412/uDd5bgRk854l7rrEUVfOg8mbPx/D6aty2kW3XVF8EiY7v6
 aFy/3VcR4jlebcCIWawa9J+Iqfsrd/tDFdXUklNcCnP1JqrsmX0uhMwgYPKGQUJKaSV+PDCBOfa
 IpPWgPDYkw+tp19Xz/wt8140s1ZUV8/6tQe5IKg763Vy1rR7GTmzsq4KRvp41uFGNZyc51KGjzH
 YRNbeF6VCzKOcVhGBtknLbgj5feiPkoKCv08NzXexlyM1mFslfuRX7cNmYc/Y22qji2tBHw6Cuw
 tJOcCOs/8FZZMMXt181tK7lYmBGo/2evqiXixEMpGolxlN+fCZQtUmm5riFfYMrKlBNznIClsgv
 5R77vbrenMTr+uBF/bn4/Bb4190SSbtH21v5ljaMcy1ECD8woDorpCPzzevhlD+bh3BbBYEWqL7
 ARbq/FpXxLBrBKlWNt8pNsWjJi2n0oVRMIP38eSfTYrGfw/dKYFabl2dwrVJCWY5wHaBQheD4Tz
 sJN4z1kyno0Qh5qRg8wLHeHiCoJTMau6Tg7dYB3iwr7Fprcg+QrGRgrGsZ6lC+OKyQgTI37baYn
 NXymJqm19/UG/mJRMtKbo+4TxX1cTN1j5vGKxmMJC
X-Received: by 2002:a17:90b:3f50:b0:3ad:c14:35ce with SMTP id
 98e67ed59e1d1-3b1b0d98b63mr10556670a91.64.1794830950597; 
 Mon, 16 Nov 2026 04:09:10 -0800 (PST)
Received: from
 runnervmccnms.dn0g2ckx25rehpuuvwnhmw14qg.xx.internal.cloudapp.net
 ([4.155.250.74]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d257a0sm22223857a91.11.2026.11.16.04.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:09:10 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Mon, 16 Nov 2026 12:09:09 +0000
Message-ID: <20261116120909.4519-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116072346.2462510-2-wakel@google.com>
References: <20261116072346.2462510-2-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] msync04: Check smaps when the page frame number is not
 exposed
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

On Mon Nov 16 07:23:45 2026 +0000, Wake Liu <wakel@google.com> wrote:
> msync04: Check smaps when the page frame number is not exposed

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
