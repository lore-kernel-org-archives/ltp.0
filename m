Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DEBC61DBD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787666594; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=DBtEUtFlUgUWGeXCjGnlonmcU9h8yzrwBGC8NlAjKFIYWRoWDcMQLCU8XxHcG3bsdqZ2b
 wNB5ZDyvQ70P0CdzSyP8BYpxJ5WhFqOPbJ/2kbY1f5z3McqdKES0dkx8gyPuCrGUDnJipUb
 o6UnMM2EbHG4ZWY4CvVMXOtWo7ZOdb8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8ECC3C5E18
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 16:03:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 218FD3C062E
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 16:02:54 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 71D5D6003C6
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 16:02:54 +0200 (CEST)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a41191c9a9so9365298a12.3
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 07:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787666574; x=1788271374; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=LUCkWkKlWg/2nf3m6Sb4GdzKAZxtN0onwY/FSJzpOwkY/QVU5RwONkyVgZ4aCrnm5Z
 0rcp3qedJhpDCMTnRZJdrEVeHQlleceHYau4xIac3UpQSuw85cooQ2nur97l7y23u+1Z
 /KnFqUrry4mL+9Q3g5hgcF6/uIgY7NrXj7SIfp23b3crqx5e4UxlQ+cxxjNN8iGNJlt/
 yalSKvVabjM9Tc12BGnfZjEjDr0rbCkiNe+Pd7TjPMDzESepIuJ2Qr/hNWzKa566ALed
 0+u3TjOWJZ5L96kj2vfoV6I8IfDZncV+qCYhSNFJVyfqmpZLaM8VVeUxqudWJBFSGr6R
 EpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787666574; x=1788271374;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=MtDs6DWPzpE6RxRFG8ayjpMFXHX4c9VMhkHH1n4MC87sWKe94qAp8RFDVER7+r7ki2
 gel/bYnK1lPXTRWVt9hLXvw/vNpLd6LNp2XaaByhCy6JpRqFoNrwNTd4y/jk+hOWxAjP
 kLg8HTtjv6rZzipgd8LIM0T4/3mgKLrAr6HU2TOgN9OhppQRWPbLEeeyHYTI7nlgTOs+
 tJoR/UKP8LPGS/+kUmPYJg2A81YKQbO4z3rObGtC9Xecl8VdaBIg9CRivncJE9plnDen
 p3g0TKuiU0GPOJUAq9YutHeWLR3pR2p0rBd1Gjtu3TnaK8Jy0uNTP7DwxHuW9hMjaKva
 re1g==
X-Gm-Message-State: AFuF++l7PxDJ07YAi6/h80pIL1BwKiYQ5HcOOsd0ipwm9qgJcEIvU+LA
 iPHJ5rijdE2bNXQEPs75XHhUlOAOy0Z/1XCjgj5FMKnSU80tSpP95b5M6pZTFYBz3n4862695o6
 LLB3L608=
X-Gm-Gg: AR+sD11+jAd6Y2niHGYD58zD4u+DASr2x6l8HgXnyI1GZ8FJcTpurWJV48tE6nAbWaz
 8vOPWoS7Nj3zbWUMm4ucXhuqHI+UYdRDIh/tboVPiYIjUrROQzWOP5c+UMagZNT8Lb4Bkd8gf/t
 0WLwZL3gLE7rjracVRCRWvoWInY1OX1JwjNtT+6vsWQ21qwHcpQidrl6dhlfn5iLc8C64C5gOUa
 GXVASh1iBE8qVGqxuuDnfJ1PpydkS0vU7lngXTAsJVxV0eU8o4NI4j9pZ1lFbkDTb/9IujMHLbB
 aWRCS8PzIGCDbUfNIz7dCCrzuTEiGaG8yUot5QamTo9hQr9dP0nwNLwwBdbl/2wCx1mCKrzRyaQ
 wexDJkoZ9PHbZfravaYWeQWyK+JaxWokjRutp78qFU8d2/3VErQHotle9UT2pMDCk3eJqFI5kZh
 FaFh8HZhyuvPkFS5dV2LDVEDsmDZPvte2W7RdPjPIbuVyHiC6kuoei/92/ZcSwXb6v6hkwDv+w+
 52wA36j8JyCpS4HDI/0X93JrewiHEq2NEsj
X-Received: by 2002:a17:907:930a:b0:c1c:6f0d:5b22 with SMTP id
 a640c23a62f3a-c246a654342mr4110453266b.11.1787666573748; 
 Tue, 25 Aug 2026 07:02:53 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25026bdb17sm165285466b.32.2026.08.25.07.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:02:53 -0700 (PDT)
Message-ID: <6a8da08d.42d66b02.81a29.9c95@mx.google.com>
To: "Disha Goel" <disgoel@linux.ibm.com>
In-Reply-To: <20260818121436.1397-1-disgoel@linux.ibm.com>
Date: Tue, 25 Aug 2026 14:02:52 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] memcg/memcontrol02: fix fd leak in cleanup
 path
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
