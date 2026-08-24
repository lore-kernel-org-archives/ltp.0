Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE0DC5DF94
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 10:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787568125; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=KpQQ9BQdlxbMi9fOCZh4PqJn21wIIYKR2QKWTC5f4kqxd+F/wUpXtVNR3FCKUfqieTJch
 +pdv8C0vqmTsNkwUTaaexhLe+es2aLtSocrE7LIkuSzzBMLgc8uSjnBf1EY37CHkR1cNFhM
 kdoARp6uX4uIJgYOaE9tCuCgGSQWLuI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C6C33D0613
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 12:42:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A4613D03E6
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 12:41:37 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0BC8D20007B
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 12:41:37 +0200 (CEST)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a374bea882so6314902a12.1
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 03:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787568096; x=1788172896; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Cq9i4/JKfIWpwXABQKfnmr2ZxJQZNongx5gk9BXO0LTOMn+72LOcOdU8taqJLGbrLI
 AHv+ZSyoRmS+iUAQou0FjLZ6MeeVjNKE0TUWazcViFFiOgdT8lFs3wsAIiZ+Hyki9pJH
 AYQMXL8DokNZCmTBYik13EX6p+MaoBshHgiqDyTsgnlT9+bbqXfqop7zpbS8YRvkiLpO
 gC3a7fh2AwPuRAF+iapN+Y9lR2LHL2xhVeJ3nbqag/wNXslC0+MNIb9TbO3hIVRK/vgV
 ie1Di4YQXoqU7IkZvLNXh9sWQ+LAAeShwSoBlJ7oj02WqhuAAeMG2/YRAZc2v1oKKtQu
 ykKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787568096; x=1788172896;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=K02O6CxKE6ARNwVS2TUzz7XixoIlZgA8NW6EnoJyLRWim/JQtN1FNq/n8Hs9sQduv/
 8DR4abMCmUe+BFUqlqETiX9BfZ3L6SfVm5EvDwoPF0ycJd7V8IFvAYOGXV0v8hgxQ99e
 oqKuzoZcPQwtI/4PhGoiDPrLZpW8xMUvy1v7rLPf/m76/Imch2J1W/sd9Cfo3P56HIgf
 kDDosc+Jj9flj8OnAFJw+hkSabEhr/Me8IHcCGUFgXSd2aXnLM9Ng7py6LezAxahCnLD
 4pWif35/ioDZGe7s05R8MStHuui1oiEixIW1JXIZb5jLB5GIpeBlYi1zQ+sisKRT6ZYR
 aRQA==
X-Gm-Message-State: AFuF++lnymn+EG5vzd4GXVJuXeS603yWlsguBM59UqyZ+MzSz5M+96qP
 vH+l+SUAeTwfiJ6sMzZnckXkH8B7lom0ICACq+NMm6XYPN7hQRzae+XuEJaWrAulikM=
X-Gm-Gg: AR+sD12B7w+hNBLGvRz4TvAfpmtS8enSMaJYR3eZcWUS63QevKmXxYy4S98/nO/RIge
 B4zrNFJjuWsOUC4Ev+fiICEKpOI5CTR+cZxrnohshlUcBE5IFP8wWznSDPfQ7IeRdSbP2P+kEMv
 T9+4QFpnQyvhlBdwJTvFBdMisqR+LZGU9jvu5OPsx2+/vU+C7gKXIT5QnNCjCkTNo1iF4gGbang
 teZzH3Ry8RDDl7/Tpm9xTmoiJD9PhKwnWcH83+811lKawUk669e54koXb9Frt7mOXVB7qNq3Y5V
 WRcMUK0mLplEJuv65trpOGI7hnlmcDf9CHTN0KA3dnOf/UuZ8XRMx07/BEOe2MUVFWeN6th6PhX
 FgUgfC0eXdwWYmTOzKAU1mYt5QGtMIIiJlx9YEsH4tHsJxxRrcsCxnEZTu58m4x6361+3Lwy+Co
 Bd8zwYnqjvdIg35rDVJHOG0X14MYwFYBnV3mAbqpXiwfdQatiQRhmLcVa8b1Mb6/5Bf83i+okzj
 IGatFNJLh0cHXkKtMBOwItRiZ3tbjreV50H
X-Received: by 2002:a17:907:7243:b0:c24:bf56:9222 with SMTP id
 a640c23a62f3a-c24bf5692cbmr788577766b.1.1787568096279; 
 Mon, 24 Aug 2026 03:41:36 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496295632sm1338332266b.18.2026.08.24.03.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:41:36 -0700 (PDT)
Message-ID: <6a8c1fe0.1317a01a.40cee.5e74@mx.google.com>
To: "Victor Cheng-Yen Yang" <cyyang772@andestech.com>
In-Reply-To: <20260821055341.2079284-1-cyyang772@andestech.com>
Date: Mon, 24 Aug 2026 10:41:35 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] starvation: honor -t instead of calibrating
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
