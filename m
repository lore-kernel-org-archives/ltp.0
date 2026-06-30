Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DADBC43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 08:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782807099; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=O1p50nC+li+OUc7lGPRxILf8AbC5Yh18JY+HQeNK2bER2JmU/EVaGObIeZWJTS8hCdQtC
 0fZ44BshCgyH+zu6TePrVIRe4VS2EhIydlFqY9NN3W09tF69oKTf9JUCK6kyYvrpLFTwbya
 H8ky5UuTLG4vDQXfroM8wUs6oh4FSfs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BA303E4B18
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 10:11:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A21183C0EC7
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 10:11:18 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D04111A0113E
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 10:11:17 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4939a809b24so26631135e9.1
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782807077; x=1783411877; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=NZRNmDHJsBn2Xqy2/d+fJntYhqUEs49SJQx9434CJPxjOiE29X7ZZo5tSWpx2wgTb9
 d1weyC3G3FGQ8wjUt3hrDcXV9i4YTZu4KWatQvJjYQFNaEDVgNeCKhLBIHYOrPUvSO26
 dOPTKBzrzZ2i3MXkeTqJzlu2S+FVzDRjBDVxDahScOnWz1PfU2fRbwOti/Arjpu63+jb
 xuDYJlxfLo+15I03GHqAP8pkLb/G7tH17MNDq2rYFAmMnNLPykr0+A3LHy/7IDNLEQAw
 5V9LNisSY7MAMnJj82rnx8t1CsciGP3cXxyTO63vu7QnKDKGpj8MbpR6FhPquRYepaXA
 JLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782807077; x=1783411877;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=NyAP6+rr4wJPVfaIiT5znm3MEtI/zrz7crs+mjLbK6MXrNYr+PHxlK+VMreHUvceyX
 zlIrNM7S8N0W2IRLuNFmG0Payg61Ph8DNI0rnM2nYlnYfHciV5cHMcdXDxZOvzvud7Mu
 M65Bl6ajZFH4NZnml9HYPU1Iuw5BNFbwS1fIMJjDMUSY/WAItfZlVjX5YAodvSzKz9h7
 58gcOMeqW8G6VgK2tmz4tWwAOkGxnUVY19miae/6RGiTEnrd9fnAO6vXC+OS5geC2+by
 XEZBXMHba2cKFuXLl8vzBDe2unFsFixOyGpRbp/LcWlXN/gj29Tei+1kt95b7X/D+B1G
 eqLw==
X-Gm-Message-State: AOJu0Yy72IxfxZPXZjf2n/MReQ2oql2oT6gWiSN6jsjYakO0Dq35zSum
 PnuHJfXBRmbIbDdt4RIK/Ho7TUrB4nhZicumYv2IYYQLSKO2y4GRYLuwZ/0B8pqlJzy9n2+cJdI
 SqsEJ4w1oTA==
X-Gm-Gg: AfdE7cn4EmsINUra0YS26v7xsrmpKTBRNNkJBttHT1lfdfgBf5rzH/6SAGvRIb2A7x7
 AeGrogaYORj3hNA9yswGmZeBUZy1Jw25ob0E+S4ZyjM4CzE1pRGKyh+87Qzd4AcLvT1fScvjMIz
 3Y4U/YKqn/IF1X/LE7knoHYFU5T/oeJ/dT6XbLWKm0xTr30iho7VLYXNBU4BOSw5gDOxGeST93P
 ol7PybpIOHMuOZ/c8I0HYARC5Cy4KgJFqAVNUIznwSBZYp6FZGgnh7SwZ6mEqOzLVvbwTT6kHYO
 nkEUYi1y8uzm4xGjOqtHJkFTZJV5pe5Ix6jyEQPWqw3gH0dF1eFg5IzUZlMLd1++rS/ma13L92N
 0Xn5T/YqZvNhVP7Tfs6JwjZNtXcjgW1U+m87jCbgFaNwbeewhtKzmrsw04CT5OGD7uqHqQDqQhI
 koRbzbzZFkgYt20TH5W6PcIopdAuzCkLBuB6Y5WKTzTa8dF6DNI42zyuSnPVj31EAbwXc54LHNb
 W4m4JOT+WG4xTIzsPbHQtbbFzZhNVeMzcOgXv4Togx+1kLKmO5d4lyXEr7OljLS2t4=
X-Received: by 2002:a05:600c:c114:b0:493:b499:3ef2 with SMTP id
 5b1f17b1804b1-493b82c4e74mr31039675e9.37.1782807077099; 
 Tue, 30 Jun 2026 01:11:17 -0700 (PDT)
Received: from p200300ef2f13eb00680747d6cefceff6.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8c66c15sm51910605e9.2.2026.06.30.01.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:11:16 -0700 (PDT)
Message-ID: <6a437a24.117c96fe.17e125.fe41@mx.google.com>
To: Pavithra <pavrampu@linux.ibm.com>
In-Reply-To: <20260525153352.188816-1-pavrampu@linux.ibm.com>
Date: Tue, 30 Jun 2026 08:11:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [PATCH V2] memcg/memcontrol04: Fix race in
 pagecache allocation measurement
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
Cc: pavrampu@linux.ibm.com, ltp@lists.linux.it
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
