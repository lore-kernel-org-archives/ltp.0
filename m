Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45EDC5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 12:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786364652; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=jh5/Yr7nR/liUpDrsXlpey13dfvJCZ5wkNei8OoYB01a7YzojCyERGMb6mGi1tAtQXD+K
 Mu+Ao+1769AP9OAkI6aTESt8JGyZ44HKBgCQD6Y0zz7PcQSvI8blyaJ1Xak4E2u2cxCWtab
 0Uc7t+7k1OR7yAZlmBi2/so/dGQOoA8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 404483CF294
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 14:24:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDE783C93DF
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 14:23:52 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 76C88600541
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 14:23:52 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47fd66a094eso506259f8f.3
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 05:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786364632; x=1786969432; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=JMY37Xs1kQqTgJi17XBXEkBUGrOeq636FnTBAJ630nmPuZKU/U/CgfSogtA15NODzM
 Bdb5k3GpQgAJEVJtBKiGahIVf1+fk2BJlmKYFHeL7gze19FQ+dq6EkSPWydn8CvoCzTb
 pt7ha9b9JUyLONp0NOkH1OejwDiXmvMCynzV8PQ/XLt8OZr6UPKSboH8cIAcdKd8ljRv
 MVpJNhg4gSSaVZebcBYeHjHxPic5ijXLvHB8lyY0NAFSQhiRsr2XarEpKEomfBOChbIS
 Dh+zDIAkFRxny62gKo0CP+V2606UjHhoVwXkBtfejYaT/D65A2YH9Oinnku3H/OKzTWR
 2/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786364632; x=1786969432;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=cMHGcWojZEmo0n7ayJJ7nWqPIuzZfK05qfCyK3N7AfxFCTghEryoJk5nMosKoxSiB7
 yslYU4qUxRBSiTgYCJEM2Y/uy4maEImSHx4pbMG4Vmbje9PTavCJ3FyianoIEEnZoLWT
 JINBST3xbMVuCbt/A1BU+bdse8/MZ278Cd5cxJ+1X/fHZhzrsr60ELj+LGo4UT7oO9Ae
 nOQM0BNCzQydYdDUfFwRy5HHOH+bkCgMfDfgTv97PJx1DeT5UDjTHA4QkO+iR8XILZ5B
 RafxLDzQTlDOXc4XIgXlVbTufAd+3rEVuCbhj/tBpkQEasIg206MKhQLL6RbtWc937nG
 lJfA==
X-Gm-Message-State: AOJu0YxFy1jExVf4UBJnOS1LzEzhnDyxVJ/DpLZ2OwFTtiFeB29R7X2c
 Nlx3yefyAvIdBxYtxafWspZNqtXUlPQlZOFFVAe4skrCsMpu2eA2Px6lSuOQrzFaxWzoaApsYHW
 rXbN4
X-Gm-Gg: AR+sD10LreoLm+QRbtRzUVB3z06Kzx6S4LvZRH1ap5izkfQimTDumhRyGtwb9RbxzII
 3bklpyQ0r0L7ZpOCF85jbqawUJBUETTatT/chuHymAUIJlpyo7zePgW24odqyi/ToNBtYfhupuY
 hVD3r7MaRK1aLS0nytjW9FE4kt3Iv93BFVqM1P+LCv5RidBSus1jdP1kPq/jS1PjouF74XJtID5
 NiLwsZTg42m9HNqHJvXAv+l5I6ArgsnhkzG7kVGKMXB7bTb6Wt7coKyXT8yf1JT1ETbkvWVw3A9
 TYpnThoWqoFpJ2TGDPTs+HIgSdFwryLQREsjuBd6U7Y6oHCcLcLJE4j8oJXM4i0nRzuU3jbXDKe
 QTUodTYZwSc28e2QD/Z1e5nohk/c90Yy6wIkJ9Vvf5V6UjrIfr5TwkH9UVTwK61MELGlTin8CFD
 BO52kr/cJf2oGrOYghm8daeq48FrxKJOG6KTQaqMzYjvPdcIxGCn2z+w6TYHVz/cRu5GS/Kg==
X-Received: by 2002:a05:6000:1787:b0:47f:8802:c182 with SMTP id
 ffacd0b85a97d-47fec63cdd1mr63413661f8f.29.1786364631447; 
 Mon, 10 Aug 2026 05:23:51 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800215078asm33536251f8f.12.2026.08.10.05.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 05:23:50 -0700 (PDT)
Message-ID: <6a79c2d6.14e24f9c.2168bf.8de3@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260807104442.2831991-1-wakel@google.com>
Date: Mon, 10 Aug 2026 12:23:49 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/file_attr01: Fix EOPNOTSUPP expectation
 on tmpfs
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
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
