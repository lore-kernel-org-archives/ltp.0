Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B53C44507
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 06:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784270974; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=fgeXrRqPUmjZ31dpqiAzVYiaaQXsHnxfwawoVTcA804=;
 b=gBvkvO8VRSBB1X4ZQM8E5+zTtJGkVFcXnuXonGDcanTGgyYY4Wfsh/IK28pL9XbUqfmlH
 LaGiW+zq6E2wdt3OAKSv8U4cYgXQf04dUnWYxKIUQNX/s9lcXw1VALFdJxNOtMCVjXvs1Gt
 eTZJfe42J4aQ9YJhASPomiCeZC0OqXo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D9523E24FA
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 08:49:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E71A43E1B7A
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 08:49:13 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1C6F61A004B1
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 08:49:13 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so3337201f8f.3
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 23:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784270952; x=1784875752; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+eOaSVRb3hQlLZV+JoX6+Xc5oNrOlEmNGFvjFaTVkLk=;
 b=ExW+pU/XTtZM0DEvplCYMG7JfZjZk5goeKR/kVsqZ7gu7B/UCGbCkJ8D60yK/vhT0w
 QnA+C3tziCf6gbLn4SjZut8SHCWlIBm91nk1C4cD9rDwL+/bk/lKycp3/KxpefMaC4qU
 VqYBvuVGN10xvgPj+8aJUOeil4qdJ7WvzQDtrGWN5TIZ97020nPdy4mEVzO1cb5QSPS/
 dUfxD6MTwAYjusxEGeGJDy4pZlPotG1aVy18c2vhT5wgG1zv8+Autw6zu7iQ+QocH5AU
 XRwStMh+VPlzAeRkK/pC/MwujDB0cCCPCQIv8CqU+TCQsarpCXtBXat7KM6Zbp+43QJo
 xfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784270952; x=1784875752;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+eOaSVRb3hQlLZV+JoX6+Xc5oNrOlEmNGFvjFaTVkLk=;
 b=SRqk8UrqtKqZjRgPkvnUfaZYF7QQX6zkjUKU5xTxCcSu7A5G4AchIlbKFAn1nhZ94h
 KCiRImmhTI4yoVEhOY+gFoK3sngrfH0HBv8Eicu66fGAVBHGsMo2s77llEu+rS1d3vFo
 OPLafnUql6Us/jYsyoeKRQWHlykpTqHyryzv4FreXlx5MUxI324f0ECpMUwshtySod4B
 DDoKp3ljp4AfOVFWU/WGUnb4W5CfaiMkIB8aHtE4+95NoeKZrg/MVnqRga5uuhrdl3Fg
 S+V6735V2iMondVWtG9bnRBpfFZ30fCEBuqQTECIzpuoJdhYuYj6k+5BIbV08RbOOpMj
 16jQ==
X-Gm-Message-State: AOJu0YzYktraH5Mkx4dfxBcZ+0FEaMZgjXJNPLcP0ahZ+HYwiC6kNfKL
 gLWmxvQ1XHfYfPMF1VE3h5JE5iORxa6fTcq08LCWk3aBEJ1y9J/GOQO0scbqud1pbn0=
X-Gm-Gg: AfdE7cn1Xko1pEYbs7CrCvGMHe41RYycPCj7GpoUECFTBWJFohN7QgTR8vi40Bn7AEo
 A82jVKsBeKDvR5AyW03xj69DMMzSQKIor24Kjx7Vws42QgDdcUy1JmayxIDLWAtYlSc/kA7FbX2
 pKJow3pc5InWIAl6P+cSTGOs23OZ3/wMhgnFxndFTCdb/1avVpYe2iAfOJ+6YaU+cn+SKOWA0Qc
 THalii3bbVN6tDUoFZWzs50zDkFgC58Fhbtl95oxFZ7E6OG23xoJwvE5Db/PEuZJUNirUgXaBd2
 RO2AubCI9tF1d7jGPtl5r7ghXRLPWrlyAzqutnnJpc1PpZNYRey97/2/WjobuO84PZ/5/kcZeHl
 mY74TjRVWx9qDhddbNeBYcRuKFRa/GmumPCU2LzWVZjtScpspZwb5Hq/IweqeqPf9fiBl8I/gNC
 XwOzqUHlQkvCVjpbccXGnhdFp/aQ==
X-Received: by 2002:a05:6000:718:b0:47f:4889:7562 with SMTP id
 ffacd0b85a97d-47f6231c8e5mr1887816f8f.36.1784270952355; 
 Thu, 16 Jul 2026 23:49:12 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49ab8sm1381096f8f.5.2026.07.16.23.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 23:49:12 -0700 (PDT)
Message-ID: <6a59d068.b7086f8d.bdebb.42dc@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260717-fix_tst_test_hugepages-v1-1-a63bf2ccdd17@suse.com>
Date: Fri, 17 Jul 2026 06:49:11 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugepages: ensure CONFIG_COMPACTION is defined
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I was not 100% sure to use kconfig or change the message, so I opted
for an hybrid approach (CONFIG_COMPACTION implies the missing file),
let me know if I should update the code or this is already ok.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
