Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9F2C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 11:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783940540; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=m5n0J6nuLKnMj06V/u49keWxA1EH4gqaJhTPEjKcoupk+SU3X0B5jvJIVYukIGQh42srK
 40Xdiwa0raUcCTBumVfQbkGgc5o1heoAoJ78hD7Qzol6Gfjc00yENvQUzjHGswDDOfXcHfO
 Qp+DK66eywWNqAoHJP/wQiZQ+6qDL2Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07FDC3E5BA1
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 13:02:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 449E53E265C
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:02:00 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D762B600156
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:01:59 +0200 (CEST)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c15c257a488so394606066b.3
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 04:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783940519; x=1784545319; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=M/s65rixRw90A9RtAS3+DHtYttaJysg2kENC0Wu834dH+RvZzFKE6K2nykmGqEAVTX
 LuBDmLNS9btpqygL5/AAZ3e4BmZrSs8j8m2KjA1QCqIRaZgednlRRSYi10Qt2Q1Ne7JL
 oP4hDwIKYVLCH9oiUCQq8JrfWyM9Rvsy4b7la3cdAlcwSPnjLZHeIBoSCWRTiLnVx8m/
 6eo5NRg3BDBges7hYLuCLvNYt6+BQghmqJUf1X1cUck9OtybOcrVLm0z4oHuSCs5eH9M
 AfhZTA4QdTDH55trUoldq2c+c3QjRySvftMA5nhimAjubkUbSx0KCJjWIL+4E6x9IdCK
 RGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783940519; x=1784545319;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=IMMjrx+kTmYiDWe1UWz/hgy1IaxG5kY0bxqIoA8aAX35YVWcbaM7D1+mbuusG6AnbL
 OXRtLyPCsMNq3jztf+JDJYXJx3YkYnT1+kR7xTI0Qp+21/Au6T/dzeosh+GUoek/zVfy
 LxHtdD9PxIqWly/5MoYZQ6YJWeUe/vtGrFP9OrVpWbVfwkTkLS/j4NWS2ku3MgLqhQ6k
 Gz7PNZZ+8xBfE3w98S7AxUgWhBJuq8RxYl54ueYxDfFGhO4FqES7I4rpnNGNJmlWeFQT
 cfdj+ajoxyC4qMvuttoZhRE8uDgEuBLtDW0lXhAPbQshqpnglmStmdtG9HJfWOAzYWWm
 8GrA==
X-Gm-Message-State: AOJu0Yzk+UI5KCj2S585WSotEdDV+Fi3aVjVaXGSRsF3+ALHtwMXXlSi
 rDZTFxlJ8n3P4pTigqmaW4o6YLcTuCU68FG63j/A2zi5f/xmHBXXZRH2I/r+sIzw75o=
X-Gm-Gg: AfdE7cniCNfJMiXL1y1UiL6HVr9NFL5d9Wwv0JivcYrY6ItPhdn0L8k8f4MLXGw6tZu
 86PUZL0IkQeFshrD+pNM3/2aIg6ko1wZakTSGNCcoF5w+upFMIX4WtU6dlOGRdyclyQHBG1/gz/
 R0xfqWqqGA8ZFGv7vb+sQr7a9Jy9eLl+0jXRoMM9TY3rE0BsxpRfCfHxq+eLaZrMBO+gGlkq027
 6w62u8fnBmPWSFCnD9UuXS/OLKXiwz/Pvd9avYqkEY1pwHWVVVWF5VtlzS3T9ExNNhuIqQLerEK
 G2koywN+cNOOcHHUcQqzt0YAXhejN1TMwp68vUwCnXjqyZgMpzPfXqcpaXRqM9ddPOJTT2hTJGS
 hYe8TJJstCOY4ON4pfhZ4SApfp/ktHknObrjlHSRVIlPX1BEBi02gR2JKI+OMP/P9oIgyoD7niV
 zbdsVCaN0PYuurYlkFwZKrokOOivXwD+AY
X-Received: by 2002:a05:6938:a082:20b0:c05:8586:da12 with SMTP id
 a640c23a62f3a-c161eaa94d3mr224017366b.50.1783940519193; 
 Mon, 13 Jul 2026 04:01:59 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15c6bd0d72sm804279966b.7.2026.07.13.04.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:01:58 -0700 (PDT)
Message-ID: <6a54c5a6.8ecf34b6.2b256.5b20@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260710055556.1109220-4-pvorel@suse.cz>
Date: Mon, 13 Jul 2026 11:01:58 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/8] metadata: Fix dependency for tests
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
