Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B145BCA600C
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791469633; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=OL4VAbDQlgzRteOmCgIeVobUDAt7PFLJvCzQPgxTVc8=;
 b=od01UUjcWje2k5hskb3ttNVj47vTkNJVUK/VloJ2LP9rXC4wpd2aCF2J80qiBgNslZOpD
 xnFXlkN0WFd6ctz84MgeFn6f++2RgO+WM3ZKYpUTi5OwFKGunl6Z57zAdS1xuLvcNTrg2nO
 v1BHgKheTfEfwO1+eUybZP5rKcLf35M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68E8C3E6AF4
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 16:27:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 272F23E6AEC
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 16:26:51 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C2A976002A6
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 16:26:50 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so22301655e9.0
 for <ltp@lists.linux.it>; Thu, 08 Oct 2026 07:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791469610; x=1792074410; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uQwDI0EaaP92h3tCraee9I5f9/v2zsgQc92PyTJDO7I=;
 b=K+3nRH3PgekPO1im9jTxZOfc24Fcz2P2Pyx/IAEmwwf2FpVxTc9Kj/NDbygjHon8IA
 ZCQN/PWllX8ENszEpkSk+vzVkeQTBXOfdeA8eFDAtDYzqrSqUH04D1/GqLgMoksyq1xm
 TqHL3A0Z8wYmNWAGSFsFrdtSGBAXr/D/awV6kktFLRUmudbrUdTiyvmP4rcvueZJXjC1
 wp76gi18YcCr4A4bQDY1YrHhyJvKFzDK9R7+6WBPSf4fbAz5exx71741BWObsmKwnKuM
 TvaFTY+yp9r5DsSiMqfDXo727JVlIIMVKpngGaVCtdFq0RNtMP7hFE2rSVjidXvrmLVE
 1OmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791469610; x=1792074410;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uQwDI0EaaP92h3tCraee9I5f9/v2zsgQc92PyTJDO7I=;
 b=bU+Mloqus8MdP+oCkvTQvoBFUkLKwdKUERtUBvxIH8WRL33F9vMxgATAq2SHLk86n6
 62vEiRTo3oSupOFtaY/CK43zLfBpUS383RYtZy1RGyz+GYKtcJrS9kFNyWVBeIsNOjSg
 Yb6pE9GRjEgkvNoWWNAjrP9zuRPBCBubdLlxDGSrccUVYTyuuLpjpT4uCAz8Tfqd1hfl
 PEolK3YEm1dMaZ2ekeURdjSeaoWl47+xK/PKFbJjxqLjXsN7Agcds62kH3icipx92dpj
 ea3J0dpzp7uznLlVcIt3cy+107sB8C+5zRNw/EBLUYo70J2friJVw6Z56rMYZI4PLdRD
 HoSA==
X-Gm-Message-State: AFuF++lTXa6sKCdC+x9mLZoAFpI3dx2rpmXg8H/9IVT8mq+oTCgibdMn
 jWBRI49HdOS50FPZcdbgv7n39wWDjT3I67D0HwaWLKUo/S20T5hZEZ5+jk1j54BCRCg=
X-Gm-Gg: AYBFou2GCrrZCw7435coMKt9hDtfRFO6FMg8pYNtrpkaKthRA0590iMfmQxwqKBPiOW
 CKIH+NESrgE1sNlIw8Hy3h73qFLFX7uuUbzy5FS/e8wTS6OFu+j+SirVXyNokJTiHjI+Mxgi5ms
 Uog/K6sntqr9Hq32gbSpJPB4xAmd9yugFmgruBji4NiBmQmISo84lrFE65aeVhRr+4f9gsr7dEA
 96p0bqsbd0gCAKH11PNMf1OaDsFnGTwcn9olKbHZADI4SscjJtEEfBr1vexuaPE10fkq9qO3ah/
 SabZSyJapYDEPBl340iOzpo98OxWxG5jK8utLgpOY7EkuLyfAkau1snO8QrmVb9V8h5xhqAFxMm
 lXZb2nmuy8uokB0VzzBkbmncAoY+kA/wfx5c3fN+HSMWPPRXtLeh3BUEKWSkIxOHqiHBG2t8eDA
 cS+Bp1YKlGKbpEKkzue0Vzu9lce6B42Wg3ibTui//a7YOmfWdBDCrp4eU8GCF+Ij2hFrK2TQHtz
 YlDbcLdiiMyeJ/FwOk30rFsHtrbGIBLjKt8CMoYrFPe5UU=
X-Received: by 2002:a05:600c:810c:b0:49f:e427:e88f with SMTP id
 5b1f17b1804b1-4a18041f900mr100248675e9.21.1791469610032; 
 Thu, 08 Oct 2026 07:26:50 -0700 (PDT)
Received: from localhost.localdomain (p50918b5c.dip0.t-ipconnect.de.
 [80.145.139.92]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f48ab77sm153749415e9.1.2026.10.08.07.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 07:26:49 -0700 (PDT)
Message-ID: <v75Sm8xICeaStfgkZwgSXKPMwoGNoLSoZy8v@localhost.localdomain>
To: "Gaurav Pathak" <gpathak@suse.de>
In-Reply-To: <20260917105304.9674-1-gpathak@suse.de>
Date: Thu, 08 Oct 2026 14:26:48 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statx13: Add basic test for
 STATX_WRITE_ATOMIC on regular file
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
Cc: Gaurav Pathak <gaurav.pathak@suse.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Gaurav,

please make sure you are using the versioning tag. Probably to start
using b4 is the right approach: I use it for more than a year now and
it's easier to track versions in that way.

Without using a proper tag, both patchwork and ltp-agent are tracking
patches in the wrong way, causing (like in this case) a wrong review
from the agent.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
