Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6057CD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778153693; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=t+tPDrkda4uUQlbqtfFN0F8xSI5bPkZcInK1UohHcIQ=;
 b=hhEMhsWfmgyLIFtAQRt4Hi0LOXb38K9iz1bK4s+h+4UcQ0KLDP93jdNHTEWt+5Ue1LzFE
 j1YC4jhZqu4kS+I3Zap2epxRk9klpaH/7UHaG8teg9uflkePB+e79JnM7EvbhVYZHsza5YT
 J0FYzABy9wuC4j7G1ONbqLBOfSm1J1Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80EDF3E5F76
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 13:34:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE7DC3C2807
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:34:29 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 75DB210000D8
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:34:29 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-44509921fbcso378154f8f.3
 for <ltp@lists.linux.it>; Thu, 07 May 2026 04:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778153669; x=1778758469; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=g7F6tDJGUay27cceJkP4GO+On1HAIUpJ+OufuKD8WYHisrdbAnczyzHoQO664Glnk0
 iQsQcllZIbp0vDqFTCnJMEpQQWjQMItdNhqNxkw8MWpxRAYR9LYyiC5sY+u1MaHpejsg
 lfM5C+NLlHyy5DeAVMIYUpixQrJc/lCnKJoJ2W9PkYZ7NMr+OgNUNd150UgXd0HgrHeu
 er9UigNTO0S+3K7TQuRsVijWTGIvXW160p2CneiZ6ajzN/HbMlvpldePHKaW5rz0pICG
 zjfgyEUw1iZKGRg7BJbkuymlAKZPVEvnOTKN2MN43Td7G1wYdr0hmnlrwVSiKzx3Ep8v
 OUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778153669; x=1778758469;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=r7rg//YL55VUL/kbIVvewUoji7q7H+QBXx1W5KgRDl3VYhC5+PhYx6qKx7U5ag8z+N
 vh7hh6tqhnfTVe5z/MSpfrLNQGKWb8XCS+9Pc/5H0wghaP2uRjrAoRN3PjmJNDBg5AKC
 4r5kbGBc1awsy9TDOnj12INc7aULY0kdYPna8Mzp+dzUMKX3jTqX1vQsTgTD1cWcj4xN
 oY66e+3E01coqqr0KszPlj0goAmKae+4z2h4DWxpxHlDnb4FnnyNlE2WkqmCT2bN6W2r
 1kUmOuIAnEGd6FVP8gbRTGmP0WJPB5T+deanhXe0q9ZYXI7z+h/PklyjpYpovXWSokh6
 MJ2A==
X-Gm-Message-State: AOJu0YyqH73+jdoCinodLkVqS/UAYMMmWUwr/+WwKawnlQc7dFEkMC76
 xb7e07evql71DzRl1AYTM51JWHXt6iKoGP9MYrnFF+33WLsgh3Up5SKvYwLJiiGuKMniLKLfeQT
 lWwATYOYLDw==
X-Gm-Gg: AeBDiesycWvMdfHSvYEF94wW52iHvmKY1J7uwLP/TODcCn92aqH2oUBi8XRyz64p4BH
 /cY1XFUvvns/L6/RKptmgWcQt8pgPDRrzvtrPDmEMOmWqLMGRIQDt96YAcYBSA6MPf/2Vla7Kso
 pJ+RmQni6Td6Cvena65VOrKe5wG3Um724cm8gA08dgK7f9ZweMoZ93LUW3R7SPBGxXCAAljXMPn
 6MWf0595HmBPx6byTAKrCpZAVw1llW8F2CITyhXBXVhrZRIKe56pb8pypHov8rNjaqFBkKi2XcT
 9vjmbQ3sPpoxw57Pz6JHXZUDNogvogsOlFodMWvYyFA4HuANYWYvR7+u33DFboHgigQgwuvDQXB
 h7FGYhsiEHuJfO7ErSMeRCX7x9kpxTArA63gtQyVYMz8voHm/onOw58L/q475LOuBGEsnnbAA3r
 YyiVigHEx4sOlhIQNKstSFmkhq3uZcNkbX/VlbAGaH/v0KB/oRNgI=
X-Received: by 2002:a5d:64e3:0:b0:441:1cf8:be9b with SMTP id
 ffacd0b85a97d-4515d9a06cemr13329289f8f.37.1778153668522; 
 Thu, 07 May 2026 04:34:28 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a48911sm19763871f8f.11.2026.05.07.04.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 04:34:28 -0700 (PDT)
Message-ID: <69fc78c4.5d0a0220.2e1d3f.f3ea@mx.google.com>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <20260507094643.47079-1-li.wang@linux.dev>
Date: Thu, 07 May 2026 11:34:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ima: rewrite ima_mmap auxiliary with
 TST_NO_DEFAULT_MAIN
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

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
