Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92998C5CFC1
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786710107; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Q1/aZlo7W/ZUqUC65XPIUawTKNPwH94/t0vKuF997ok=;
 b=o7pKjjw88/XyrrO55LjydjtMM5NLtDvz9klyagiovjSAaEiSfvVrVE5qGsrPIJGIElCv7
 swFaRZT/cgcEcabNcSeXHTKgf2yDUUb1c36/zEePkzcChFGt3FXDdzRHyYSgepEBjJO/1uN
 zInlkjMrCHWMRo3NFGdI3BYNU4Euyis=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3E6F3C7398
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 14:21:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 758EA3C6CD7
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 14:21:28 +0200 (CEST)
Received: from mail-pj1-x1047.google.com (mail-pj1-x1047.google.com
 [IPv6:2607:f8b0:4864:20::1047])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DEA781A00905
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 14:21:27 +0200 (CEST)
Received: by mail-pj1-x1047.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so1473666a91.0
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 05:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786710086; x=1787314886; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HazOFqk+SKCALFyamdPKMBF57+OEQLmHmSfO6/8xJRk=;
 b=bhrPNZygMm60UnSxQdVBL8zGWo1I/f//8h1S2DMv7XQkwE1Iv3xEp57/xmH1Yaa57i
 OXkTrHI0GeM7KQga9esaHgbft42rR3miil+Aqs2gtrLxVNPOPg92LWBnq4kfY96SP96S
 ubGLu1hFqcotc3YRi452JzkMKA32M7PUbwXFzlc/YK3OC3OAb0kZrkNfGw9yLhdFeoZp
 Z9iXA3U9pD1dkGjeKgOpkUCffbEemn5SLz6MpTd9I0H2p9LNXI7RPFwAMzUgUKTyMEVb
 a0pYMBGQ8w1BnEByL8cs0ncSc7zDKkoCvYn+Z0q8qhjglqExUairJ0SZkCfFaHAEKJgd
 bLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786710086; x=1787314886;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HazOFqk+SKCALFyamdPKMBF57+OEQLmHmSfO6/8xJRk=;
 b=dO5GNB8VX7Vw9JJ2+oQ76lMQt4vOl66mZS/VobOG51QUxQTLsXKkEigiGJLVTPoz+N
 J3X/ovwhtedjQaJwL+845olFfsFbtZ4HrCBx4kGbcTDG2ZOTUvFx4nKoczZImMxA/cp4
 XF0Jefq89pxjEGcggDSQwxuOhjiqBWcWos1EwpUwSl+yxMRmBKfefFXuNNlxP9yRW3jX
 AfFZh4/P8eeLXfqfSdBILRoD5mmbUP/e91V6Jn1KM8cfEziD1LWJeyx/j3AehLQLqutM
 TeWWl9YjRd/RUCD1uLDgBiAjV2sssZaHT1jbnnR5DWGUZF4KulylXW0v1LtvJDxstj8Q
 eGuQ==
X-Gm-Message-State: AOJu0YwF9BErfWjlo1Mmh7MRVLjLq5KPcN3HYcggMGnxan2T/NriOaKn
 L+geRF4XjeeFeldzlFn7/PKPW63wiKJvYRq7/Wtjg2gaasieTb2CUSdzLTQQPP45qPZ/RLk57Cf
 ozw==
X-Received: from pjbkc14.prod.google.com ([2002:a17:90b:47ce:b0:384:aeb6:624c])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b45:b0:380:71eb:4014
 with SMTP id 98e67ed59e1d1-3933b944a7cmr5494965a91.15.1786710085849; Fri, 14
 Aug 2026 05:21:25 -0700 (PDT)
Date: Fri, 14 Aug 2026 12:21:23 +0000
In-Reply-To: <20260727121130.1294997-1-wakel@google.com>
Mime-Version: 1.0
References: <20260727121130.1294997-1-wakel@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814122123.633912-1-wakel@google.com>
To: pvorel@suse.cz
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] listmount04: Detect EBADF behavior dynamically
 at runtime
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Gentle ping on this v2 patch.

All comments from v1 have been addressed (renamed macros back to
BEFORE_6_18/AFTER_6_18 and removed the unnecessary ENOSYS check).

Could you please take a look when you have time?

Thanks,
Wake

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
