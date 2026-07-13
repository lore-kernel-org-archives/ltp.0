Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34101C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 11:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783940739; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=4qDLYaLkvJhg5DN3iNV71wnHwYklHTYXGDzq9gskNCs=;
 b=L6URz6GtXWDz2gzptQdup/BD2co2Ww2BHVe4ZoRI/lZljIkC8QYR1WTlByIBPSatlzmge
 6PqYFbfhvf7KRU/6HnKE31s42iTVB+hiomTY+0/v6oPiKD0pPxdyk7XxqY3gHrDOf09kVNC
 2oClmQFSt2cKu4mD5p3bdsqxbuoG/1Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BAF83E7AD6
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 13:05:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15B3D3D00A7
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:05:19 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 836B16006D9
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:05:19 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4938d5f86f3so22693925e9.1
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 04:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783940719; x=1784545519; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZttLkNsnQQJc6YiGKuUT558MMeeg+ml3P29g/PBRwoM=;
 b=Kor93ZsIV+lHa4/6viYOpFxQHJ0Z9gok0eZdE8WH+lIkZEULxcDgkZLG71oeSVK7Dv
 OMS536nPQ4QO8N7spC4PXgmJQ1D8sZ3UIFSTPRwUbIbjEf6T5WqxOBbMt4dBtlP5jzR5
 Qo2y4X24H5irMdwfbz0bIFVB5i3b9Dq7qZmsG5Sm+QkmpglQfAEPaN6GuaqxXNY2dMpB
 9yACPSoCTv/WgMsXWafwAgqepDPOR1OT/dfKRIJ9abeGcUEuGH8nbqPySxcvp1JLRxWa
 k/pfGFoirkBTWncvf8s52ZxS5nEwHsHafAMerZyZjHOIHhWsuBvzj//1p3aPedichzkI
 y5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783940719; x=1784545519;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZttLkNsnQQJc6YiGKuUT558MMeeg+ml3P29g/PBRwoM=;
 b=BIp1gqEawFmQsOkeHqtLWx0xzXZ9DqoysW32iiMfh1+71D1UwPS0VQlrJVjRbi49ck
 r0YXTqamxvn8IeOPVC7xV9JgAMgqfbUELqK2gjoU/mXh5CMjiIM4w/BtXJwHT7GpL9pO
 M+sbY5B2kW01iTGi1UqJLba3l73BkGzAnBzd4043x74WHT8FXYmnuoHFH+nHNCrnZtQc
 AUp5hl0VjeENn7XES/BNHqUS+Z8zOpotNlPPsJ1ur9lF4sci5kizPWlkOiXnF1G/v6RR
 hA75kjG1i4EyF1YAfGwlyv7jKnzkOTFB3E+YVzF683TK7o4AzWFnHa2i9F8aX86QeTrz
 NVkg==
X-Gm-Message-State: AOJu0Ywn6xlc2KNiQEr8chpkNKqz4fd0XMVY0an0kOGUhpmp1APRF9e4
 71/59AFMoGNbM5wm2IuYZ/p0DDwoc2YtM0w0iU/ZdOkwV/ECigHu01hXIeJqIkaeyG3R9jULLuS
 Z6rniuI6mFQ==
X-Gm-Gg: AfdE7clGSf7sU65wkiTFJmdbDaNdzruB6hG4dbLt3UCgC27ofeKQ0Bsi81bxebQ2E7+
 IXbcuOI+pFUpYumabCTY8EyHM9qWPSRw9vgs2CA0fWiAx7SIDlrSdwIVHCe7rZMeap7qA5BTPHi
 Yu8I+7ryhOu8Igt6OLZaElYxmuQoWySVY8K56MrM9cO+CpibWhpbWETUJQHgRXmkEHWJk/a1XxM
 gTj4fvM8hdP5WbISDLVwVwstXDDzf6L13J8S5/XKOm2tO1wAmyN3icydiyUm/jjMLgdXz8+8j/e
 hc/TvtW41ukVwMqANybOCJyf3QU2PBzQL6mwAeHQfT0/zgnYrDCEG8c22LsuGZiUh9Ss3DpM4FM
 m1Qk3fZL3XlpBm2IFJj/jS+//h4R8Z2GhZK+9VhVYwH027DFJYCEohvJu98h/WHlibifKUNs5He
 vaLUCU3wi4+S17t4CzqnqrW/XTchcCFyQt
X-Received: by 2002:a05:600c:3b0e:b0:493:f806:fc4d with SMTP id
 5b1f17b1804b1-493f88268e9mr80357675e9.0.1783940718783; 
 Mon, 13 Jul 2026 04:05:18 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d97527sm297408015e9.2.2026.07.13.04.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:05:18 -0700 (PDT)
Message-ID: <6a54c66e.d419c4af.35af2f.a6ca@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260710055556.1109220-5-pvorel@suse.cz>
Date: Mon, 13 Jul 2026 11:05:17 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/8] metadata: test.sh: Add support for
 building out-of-tree
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

here I agree with Cyril, I don't think we need to fix out-of-tree
builds. We need to run make inside the folder from the very
beginning and, since this is a requirement, it makes sense to
avoid fixing these use cases.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
