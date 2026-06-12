Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A58CD98D6
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 14:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781275459; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=XBoRmVCNYD8D51zaemMZ5nazAP26ntYhe4Ah3sU9T+uCp0Hku5ObihyTm+dbE3kRfojP4
 YEmzEABp+94PW8+lrD/rxqt2SL3DoDA/z9e/9vvqNkvHD8OdT2mZ7Od16LIAd0P70kvQQ4J
 7PyfBSIOILVGJLJfSZ85su9ICr0c8hc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4BE83E6A53
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 16:44:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E0533C8445
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 16:44:00 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 916F26009CD
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 16:43:59 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso10875685e9.0
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 07:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781275439; x=1781880239; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Wd1e+Gk+aLLKqA3z5ZiKLQlvCEreoGbNgfw88M8E6QLulnITIcTYr/gLy+KBdaffj5
 hFXwfSIIV8a0zyNE0G9Gy7uQrXjwg0VBVydt5RDNG40lOhAzszUV1H/O/dROhyWWP4aV
 PdBwBxJTnzeZmIIiL7qp4YFJ3MbnlVOdz+iT4AYeEMBI3fu9rTqJzjFy8APCskNj4/Xk
 zrtduO4PMDETfjLFcqBttOFNx7H4IjTsevJroOIdYO4Fj5O8/OPyITB3oPdDwDNYr1Ku
 EqbsrIEObSCqze+5MVux6dacpWBPfmIOAr3nTg8roYB0Jn+5sq6PsXnp+IZXjCzYvXms
 WUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781275439; x=1781880239;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=PGicTEEiOR8GfDblS99ARpEACWH/zt07tnFACkQa/sgzwBZeh5uUoxn87p65+1b36w
 sfyR3zp1vGRtsCqn9H6vdt72LUY5IOmMhWEI2SyBHZE5HMTuMB2nejs4p5VVYWRWtEk8
 qdfU98uU9TRPDnOxxeS2kFsmXTihmimDFXAVpL0Nwnx63VxOcaYnMUX128uonfcPODVK
 Uj853Ow0nNuD2dnvJP3EHP4mPl/ziyxJvm0iwvndNFMLx+88nSwZ1BIy9XbfG4W2VNv5
 sdx/QictuPbtpyt6IRYCjz/g5j+h+ywmAGHaFvQKnMi2naaAHwnrAbzWer7IluX3jcAH
 sUKA==
X-Gm-Message-State: AOJu0YzR0KeEHgPfFD3OjdCVsCwtoE6NGad19xr7WXh/4Q5S9vc/3l/I
 Nvtz6Hj88j9Bi72UBzjxA0leneZmQ1ox3Fs2HWhKLzUa4xmrhkeb9AJBxNej4Z2EssI=
X-Gm-Gg: Acq92OGwUQz7mzpJyd/OCPRNGhaqAfYuOJRtn4VknbgbJXgRDRKviv8yTrnLFzzeIZC
 07uRf0SMP/fcyYIDcdTHKn68DBHsKPB7oSGVDKIOXS3WUcXfiJfwAyDeOpEdkcS/Ol7sM8F68tA
 C//7yoZldFg0smgaPHRNlo9khz84y1CYImSyD6O7ndg3cma+W6qO1Jg5YNnWmoDYowwJqdST/o0
 mM+3vtMenugLovfvA4fYrKBZIAC3ew+qnB2lsAGV+6HsfYB1B9aAnHz6LKwQHihvBarUEqd3oe+
 m6xowBU/mwNZthjSkpDhvfQkHo3MEGueqv9pGdDodt2BY4fnCjsEKe6mJmllnr3jcHHIVyzt2qQ
 8LiLskfeHhMXQBHT4uvXHZTXmnQ1vIn5y0Ox6NcjKxOM23tlT3V9hCJtyAwYU99aSkpQA24ihCX
 YIiWjyLxnCdpwPCuGUhUHTm4C75zctl6MTHg2gq+b/wrflr1BpRbVdy2qHbvWHci5nVBZIDOSi
X-Received: by 2002:a05:600c:314a:b0:490:33b3:4be0 with SMTP id
 5b1f17b1804b1-490ec504d2bmr40647785e9.20.1781275438632; 
 Fri, 12 Jun 2026 07:43:58 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26392esm6715365f8f.3.2026.06.12.07.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 07:43:58 -0700 (PDT)
Message-ID: <6a2c1b2e.fc4d66b3.38d513.ee64@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260612-metadata_extension-v1-1-ac9999d74a6c@suse.com>
Date: Fri, 12 Jun 2026 14:43:57 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] metadata: update stale test expected outputs
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
