Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C32EC61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 12:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787832316; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=nSCfrK7PpUsNCfoI6ci4wpeD8XLr33UIDrhb7oH1ZjhN1+RgIt5V81ej4MT2lZA1SgjEm
 I2npDZY99U1am8uKIUBT1ZDnk4Y7XPO0aiWFdB28gnUqXtg21FObBRzfEQRHcE9wkfxo1Y6
 62vL9nL6Lrs7UyTmXPOygsF+x5wxLQU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31AC53D77B7
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 14:05:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59A953D56E0
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 14:04:27 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 09892200962
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 14:04:27 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso20298185e9.1
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787832266; x=1788437066; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Dq/Po7y+RpwJk677RDmld+4M8EH2ZSkb91HnmatcqT4tui4T9yh5KJhnDZH24vBBQN
 0v4wU7q4TEw6V0x55+XVrq3nI3iKEJuTsQRRu3l8Bfl6PY5f2VEMpbjc9AqTleORQULy
 qTxvYJCHnyIUthHarW57D8fGX+PbmnlRU20lRa+/w2LtVznXoHV3xpkY/dqobbTxf33H
 zGf783m1pJOOqExfv/tCUocA79QdXU2UznB2Xm0SBZpMWrWduLmrBuCnV2NNqjSIx5bt
 fsExFZvkSWAn9cdHoHNCHBV7akUlyiV2VCCVgxwtYcxy1MTt8eBtBW9IBpcCEhDrGUUN
 OlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787832266; x=1788437066;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=nOP8wJYdM7HyBZYI1f9ZomQFrssYmmPzihvSX2osBvL8/Mp3yL4KvJM//YGk5o/JBa
 KsYx6wQIcVCsbA0XWVmK13a113/26A9gICHLu5Hu+StGuBdsm4Fy2Ifp8oA9z5tQuUa7
 mw6I2Ds93pHamIqbEn6cIuF1vkFztpzVgdRW8qL9Hjx271aLNI97Zj1lYvvn0LvexjPg
 ZioPrOSj3RP2zTVglMFP3maOTXkPRPBzPyDgup65qdh0RERTtBBCCab14GrEbubLJe7+
 GzAi8daG1q6yP7++dwLQuEEmaaU4z1vwwNQoes18GK8xGGjzRr4pvVNNn5vQAyXqiD0b
 b2nA==
X-Gm-Message-State: AFuF++nE4LmcPhEeiz8L+Begof3sA5QestRaiPOempW7girXa5H/LL10
 1ynvua/0yDDtzVxQHO6ACg8GlRWTucme8lWLJ1sP/9qfHfygkCJVLaEnYcYvz+DOHN1SAWWTdPR
 aDqWpZoUD3g==
X-Gm-Gg: AR+sD11vBlsmj9aBkCpZMFIvXLeLMD35xHR+tddsat9ICP0hECIXOGtuwO+duH/vErU
 b2KjhbkHNKU6ATBII2GVxISGOPeW48H2SNgnxliu8kz/c5M2ge/HqWqBn5y9JlAAiNYAMr/76Vr
 Ko+wyuTnc3uybBehXg2xc7VSkDgMN0nW/bSMYT4ljFm24AUVGYEEPt5gINg8uYNhYOquPcya6oH
 WOcjkUbGAqVZmw5Gd4LdJlXB3RpUpCp55wS242LHBU865GfDDiLXZjZpGfwczYJLbrH80Ez/s3Y
 xR+BdHXHIAwXGJh5Z00Exxav55bqUPf8ARaH+IUvwqP0yGPj4vnAQbvS48EqhI5nlwVwR/n1IEp
 laMtuEZGvzlf6JJUFtePXydupLdNQWPA1pdxstlYWhw3uGY/GSbeDrHPhDb/rdKZW2OBNZHPgov
 hIwFrz9wqThofdY09WVROpR/Eg9IplV9we/mxqWbqxVlTU7pioiKqdNqu3U3zBJ9g6697T9LHWX
 Vn79chZd+ZHvSxjIbFhqAGzPtw7NFOFaR8o
X-Received: by 2002:a05:600c:3510:b0:49b:909e:922b with SMTP id
 5b1f17b1804b1-49b909e92b5mr15387995e9.1.1787832266410; 
 Thu, 27 Aug 2026 05:04:26 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28dc3f5sm8924454f8f.21.2026.08.27.05.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:04:26 -0700 (PDT)
Message-ID: <6a9027ca.e862d496.24cf69.927b@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260827-convert_fallocate_suite-v5-1-650ab2acdac1@suse.com>
Date: Thu, 27 Aug 2026 12:04:25 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/2] fallocate01: Convert to new API
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
