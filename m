Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52FF606A320
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=SA/4k+Bq;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Ie6ulqhY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792575788; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=SA/4k+BqiV/y7Qzx5wPAnVyeaBtT5Wxf2pFlRmBsts2jfCLLgHnZK/207sLjT+0w2tAQ2
 N/FTn40DJc+sonyiys5wc7Yd6X0+DaTR2vlWLGaUGF7cQZXS5CNXD1MWBcteaU0/EtfxJKy
 2+OqmlEN5qa73JnimLYB/8KahofdlJE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8942B3CAE2E
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 11:43:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 090023CAA42
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:42:47 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 912F020091F
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:42:47 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so295968f8f.3
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 02:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792575767; x=1793180567; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Ie6ulqhYt3CCkpRZIm0BXhOU/a3+jeuRNP2ryNmaLWq1asi8MArCJFhE3NgKWEFl4q
 1hjUpTwkR8kY3E4MiZ+Gsr5AOerm6IIbmsWJLLc1hqemgOwCJYwcXf+x6J4ttzFCSBGn
 3/4MBMTqohACwgbOGlwRvlseyK3g5zsxuesMd/sSe/7Sd5zH4sVlZ5BYjeGOU/P5NRLb
 eS63r9MTFE87OamhVYdpizZXB4mn/Sre4LiIIbthKqN0xuvpY5Rd6yrD6tDWHy6i9LYK
 HonhbWB2SZehwgY/IAYpIHRGrpKz8SSt3ILoLCP4H6C7Jm9l9FX55UkYBmR3sfzmIi3w
 9a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792575767; x=1793180567;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Jb4bkCHJE3HKJQ9uU7knexcpOFSDIbjGKa58KFJfqonndW7PjIqaLXmFG71jtolUdu
 G7Smt49e+PHhrf34BWItdpa7h/sn9nmiskkZyDM6tBhssMphcHByq3V5ecuHKLjCV6Pb
 pQl3L/XWwk68E17oa1H2XiqOR6in1ll8PnRuGqoAXGrZqS3/oADno1Gb+KwPeC19uD4Q
 NfEXS77cRmmpq5D27x/JH8yRF6KkvYoo77u6A0SLm2QnN7jn3LE124uMnlbxJOY50oOH
 q8q8dQB5ZZKTN5pARg+PRVudTnpH8ENnsesKl/OAfPFQ64hlQwtD+XMzmUWkUYXXGSZm
 H1LA==
X-Gm-Message-State: AFq9FYKbT7ElpMPlwvuAcmxs+b9R65mdaArGhg07shxZheSVxw3A6UKa
 GRnslMIKVN7o6nbJx9zOVCp5tl+rb081976WuschlJnRjPx1DWHmD3oE6q1S+6dumoCf9vjla/7
 lB6INefU=
X-Gm-Gg: AYBFou1fQydm87c8LZKMYeF3/RqpMJxRiw3SDoH2YOZxaUydD3S3U33BCrCh1aluegS
 5hqVotKeVxe0Pjz9JwEBW1yhEjZ5k6f0QdYWxinIYiHgdabyIIdyy7WmdRn6PzPl0UoGvs5CUb+
 CdxCNLmriH4Jm75Z22g3r+UV6G6lA1lQthYqrn52RAmjelKENDnOXXTn+uqGfy/HQj7fHejJjxJ
 cabJB+qjitfxyv6+ryfWhhrcqQHREJSGew/j0h4/BKllg3SqP9l2zgyO7qVgoFqrvEyVazyxqNy
 rrmOBZTONhKuUU3/g+YfSa8LgoxJSmel8y+G5YvoSgQ48wKpt3F5DCPV6OqaE3QiiuoCj3fRAin
 esY+dDqynnqDUk815dy1Ha2MCJJpTapfpwRM5tkjSSC23HnYa3HjgdV7KSzzk6/2UozKnd1GGGM
 j46ktL3cgJtzrWvZAgTynCNVh9L4bKDmxr9Oj6InCldTZ9KJV6//Mv0+r6MMsbosxYLprBag0H2
 QMdvrVJhciJmdB2M94WUn1PNzxh3xQKZ4quoNKvaHlRKIrGhQNdqHD6rttqUoHbc0wRG7zp8OFt
 oxipWmoimByPZLb9QY7XAjl1Afm2MiRxycx2OLRNAg43LRbiyVgNiytpg68=
X-Received: by 2002:a05:6000:186e:b0:48d:ee0d:8b3d with SMTP id
 ffacd0b85a97d-48e264a66admr3255026f8f.28.1792575766895; 
 Wed, 21 Oct 2026 02:42:46 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254f0bc2sm4355814f8f.1.2026.10.21.02.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:42:46 -0700 (PDT)
Message-ID: <eQZkrL8wlagN4jVobjTR4L3eSOW7u1fhmdgw@localhost.localdomain>
To: "Wenyuan Li" <2063309626@qq.com>
In-Reply-To: <tencent_182C622AB08B4EBB09116956A32EE29EF909@qq.com>
Date: Wed, 21 Oct 2026 09:42:45 +0000
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/munmap03: Fix addresses passed to munmap
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
