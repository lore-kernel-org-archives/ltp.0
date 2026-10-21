Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D08606A31F
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=izMygi/5;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=PCp5nwSY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792575272; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=izMygi/5tcAimpw+ooMxhYkziHYpc4E+tA5FgCV2TzZ7n2LtiibwBgIo15K2+jdQXXJSC
 zPGerPQl8OFylh2ukIqhsYQm6d0p1BgpcG6mfzxaxNlXxYU7R8ZNQPuIw8ZZfiKKjmgCxRi
 TXdSzj+HCZCocQxRW+cbRudD4hH1sEI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8B603CAB95
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 11:34:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E6E93C0493
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:34:13 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EB1771A0099E
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:34:12 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso308018f8f.0
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 02:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792575252; x=1793180052; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=PCp5nwSYsSlEqstsex/q87P7OqtDdOeXUcsGt0E6utg1HEi+Hly0xMhzIF5p8ifVju
 NVZ5J5UwJLdUd8rXQXEPmclHUcET2SOceIt10PSDZR7N2JgrF40ttk2NZpxGVou/lZCD
 Qu2+wcIqw5envHEHOB0f0jvQtUSmE0/Z5V1Y5wOCIYOQVs63HJ0VJjYmJrhmrYH4zmqW
 d5DGcVQr3cOL0d8FdK2Ud1HBpVhEYy/xWSK84JYNS9wO8vFbmQVrTBLnZuazdLwCFQXI
 eZu4UOcQ+P38wioJ454XET9Q+SK9YazhFmK91Q7+3f9yBkqGL5BgUC/9SPtkLLX0cnA7
 GwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792575252; x=1793180052;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=sRk1+Jweg73ZjHB0QujkKvfyRehGde718IGC3IhCEl3l2BXDmr0NGKQOwKsZR66aqW
 IGH5QYJ85Cv2fdC76obbWCbQiVwPEk6mNeAsY8HSp7Fvz2CQPYiuNn9isQI0iCy2c63e
 TUUrl643r7parNpoyb/Bo/a1fDAIG0gfyeOmw4/czvfx07CSRUx1FOszFRkE1RZN7APb
 TsW1jvt89/Bbi6DWVKT28Xte3s7HYmgk+w1M/aV9RlE9MpUqbRpt8lNYNfAeizfv8Gbe
 6VzKNPrfKpvRAtvt8gZRcGnE6fHqgQy+80GpfXhIZkHB8Qd7MMkOGzfOn4J3g8G45vGY
 j9yg==
X-Gm-Message-State: AFq9FYI2ptFSmEHOLuUAow44S69H/LO0gm0ek4ZMJUHDH0xrTclO91QG
 UwQ5hd4INru4hVQBOyBm4VhLQQ7xyGbJN32B1ihYB6ghjn9KxdPiYq1Q5UrqAICQ8rM=
X-Gm-Gg: AYBFou104ACE2h+mNHvpqf39O4zdSSoMz0u2HIYTTHz69NvbIynNVvaQh7TiCyFMllC
 S2sh0RAIiPmAmgJxQSZ0hM2+svNxugvLvud8OaFFt0HVpqwIHkZCgLdHITE8PMevYd0+yoU//nI
 YQ4ntT02+yvzWUSGWbaohtHCvL13U4Bj4VvejBQSoRRNfsbKjdCtJN9XJ7UGYXUwcIJDeIpB+ta
 +kuX/thcdiKvMLCRTs2kroAaZJzo0tuBGw0URIcWV3ktdlygIzKaZQNv2ZvYRSGn96BLWmZdBwj
 Tg0RuYDYfDWCfUVCMNALckVj1yGZWpB5RawjUlsdj8XHykvXBMeRp6D+ctQ3uMqlG8VVPpABPb5
 6Fblcbks4tJ3gGi9iUme/WdO0yYVGmC6vQqlU+5tdev/cVhKJioaQYKODhJxUmRZtJmxdRRgN8V
 noqorgkkiyGGDxidyB5wQCjVmgQM+tyjMo17yAoJD7h70HMDErW5OIWr4Rg4+576fvE0iOFk+cc
 kH2ixL2BXZTW47QsqMht36iniueEbCZk4aftc478yni/p6N98JJ01l5a7md+IQZN4af54u6kqjr
 aajvuewv9GvJsSIjhJVc+uhr05/wetXSBBCmzr53ms3JeBi/FH2lCWef1u8=
X-Received: by 2002:a5d:5686:0:b0:488:8bc1:a2eb with SMTP id
 ffacd0b85a97d-48e264f47a6mr2143949f8f.39.1792575252182; 
 Wed, 21 Oct 2026 02:34:12 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828ca3sm4330498f8f.25.2026.10.21.02.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:34:11 -0700 (PDT)
Message-ID: <wid2JxcTrUbv0nrzXeejga8fTdcmsxPdN5CE@localhost.localdomain>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20261018160115.154430-3-avinesh.kumar@suse.com>
Date: Wed, 21 Oct 2026 09:34:11 +0000
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] openposix: mq_close/2-1: Initialize
 sigev_signo and check for EBUSY
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
