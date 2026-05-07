Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2CECD343F
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778153578; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=c3/GzdWGXstDoAI+B/AhXJW3VVE5wO86q8YQdF58BkZrU4YI8td9gc2hWMoP5ORP/aSCv
 RuBDIYbx78+OIgBkTEcno2x2CxD0jTOfem+UqmYAqmneP8J1+IjKwnEWsI81zbNuFGW1rV5
 EEH95ZbUB/Hj3Dg9tqDLJMIe1iC71Gk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 302F03C1C54
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 13:32:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B388C3C1C54
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:32:35 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D6138140024C
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:32:34 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso472902f8f.1
 for <ltp@lists.linux.it>; Thu, 07 May 2026 04:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778153554; x=1778758354; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=GJ9EaN2d6wljEBiN/2xqb9cEO0kpthc51rKU6BViD2D6qz0Fww/7/UB8+PUdOhHKHH
 SEBribi5YiOUq628Xx4ziNZxiNnA3DRoHdUK58FFOIdbnTL41Z2dJ5htih112zdnBjxI
 SHgF9tDolu2/8sTcR1Wm3untn3yafnFazxQ6/uyukexuxpKHjzAwz0kbe/Jz/CDvZ2p7
 kOzssIZnjV+miy41GBuDgU/7wOjczRarZYBOsBPmZFBcaTxavpeStCi6BAp4qmgS33TG
 1SZUoLuxvqRu3DdtXzICCGvTK08coBG462I85wIXhTxzuD0KGM/NJTdJWU9hxOP2ejvX
 /4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778153554; x=1778758354;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=m1uxfMlJteWG2tKR37dKzqVdGO7MXZHReUp5ynV94yLQn4h92Qor0M82g8fGfj9Toh
 SgR3o+jcoaZWYGJTIcEEH9DXFkMS9uhejBw8pApOU2vsOOrCiTAXfsnECPHFR/9cbNYg
 B+Hadup9KCiTf3FOyeTjCtjIa325NjgPO21QZa7bzN16t85Psomr7mQIv/lPDleS8f6t
 jEu3n0gK+53xr9w5qooLJn7XLXV3EJVGAcf2iLfW1f8xFtJW/iC3TtuSD/DRtde0A8IA
 vggSXTjQMyOiRYtjYLImPqduzsgOfqTIq22XQ1iULICy2MeNVYAytLNjZqxI10nvJmhz
 rnig==
X-Gm-Message-State: AOJu0YyUhFrtxK+VOKaxSHRRkDMpohBV/Z97ImZOYl9sfOwspf+FekWd
 5FfrBCbMnOIXM7TxuYcI+O7DEvcR400HpCJBFsc18I+OyqvEMSMDJr38Tf0YNzTW5jI=
X-Gm-Gg: AeBDiet66USIMyuGusgNGs3rC9Sf+wcSM2xRBWN/dpt/w6kB35mwOxmwu1ETJ8QqIu5
 uuTPmjm6k2zwaKlNbOlwuhWmjn7+8amFnBc18Sso1iEuj7gx0Q4r4tLapGi62f/HjoJQveTM1Rk
 hrbuZdUUaKKSTX5w/bxxiwaBoqpQbHoHcSguN8MDWV1v/3rWsF+Q4DqBg005wHXSJT7JBmwRrAT
 29MRBzHoHdunSY66+sacBBTW73k42curTw70KH9PRZpiaFml+eSAq6bOt2VycAz9LRY1H4j8lnq
 SPJ+EJq19BZo8LFIkUCdfHAmUSfNfZxjGwBOvkD/7A97VNbU+f4xcOnbpMtN3kfbfOMfvoXWdsz
 83hjPeFB56JvwwYLw4KGBWlSAW7LkslIYZC7LsVjJvEqL0GgdWIIiZJ7in4P59qDn0Q8OjY40Wh
 e0cAFn97uZZme2tRf0rKXqhLO4Akz8GGWlNIe5WsofYxvQw+tLh5Q=
X-Received: by 2002:a05:6000:15c1:b0:451:73c8:9101 with SMTP id
 ffacd0b85a97d-452e96d5755mr2826908f8f.18.1778153554011; 
 Thu, 07 May 2026 04:32:34 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055e2d3d0sm19322097f8f.34.2026.05.07.04.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 04:32:33 -0700 (PDT)
Message-ID: <69fc7851.5d0a0220.2284c4.9783@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <20260507104815.12161-1-sachinp@linux.ibm.com>
Date: Thu, 07 May 2026 11:32:32 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RESEND][PATCH v5 1/2] doc: Add CVE catalog to
 documentation
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
