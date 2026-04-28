Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CE5FF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 08:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777364970; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=QvG1JGfga0mP2jPVhWIFVJRs6oC4RAOYppHfj4zEav0=;
 b=IbZr1uPbZb1kQkCYzD8lBb5cAgoEfws4cbgC/VUv2M7h0WcybbFs4qQRqaQ73tSIA4bB1
 HMA9kM7wynEFmKLKLgQ1xSXvxoqGDE3YRDjCOWFvUlrrARDLmnZ6g1RRkvT7OI9d2OR44cL
 mIVx4gK8j4iP17J3yQVUvc/GUni43k4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 851EC3E49E0
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 10:29:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 655D23E2530
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 10:29:06 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0B4B31400BCA
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 10:29:05 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44509921fbcso1154888f8f.3
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 01:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777364945; x=1777969745; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1LiKl2OWAnNfjz3wJu9xFJP5lzSO54iym79wxfjNfLo=;
 b=R3BSA+IUln9nC+tx+JX31ec4AX/8A73UknXNXl8LmcAuXoJkYimOtd3Q7FOf828K3l
 ePqPpLz9+cpD76iqZlwc1cCBV3AtQS/A4D+nmpJ5Des12iqakdHUQs7I63UCuwcsLJqy
 WrTuUBHKCdNfBTcAAR8X1yXcXbo74WPhc17Uli9buKwhe+mXh4j0/mxJJZvDoQPWq6Z4
 QnWdiStXhq2mziR4Q2PNBTf33CxIs0YMFFG8CU99RaMsJaRoT/LtNo7FDJEAX+0YQ6SM
 r66X20LEepmpByeOJCS6vwX2Th3KjapmW10XJGyv6sQNa02FW57Li2AQyb6pGedNZ8EB
 pjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777364945; x=1777969745;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1LiKl2OWAnNfjz3wJu9xFJP5lzSO54iym79wxfjNfLo=;
 b=Y4cW34k6T2EYpD5socwkWo2jEvsKPE0JsLMEW6LDt2CqOF38/B/a1GcoMawIRBZgde
 YjWMRSKEowYVVWIhh2AZwG6zJdbcPdtDZfoVnlsdTvTyDqUm2tEQ5F8v09pItQL/y6ga
 D8d6FmZ7ozzrP2wjFWZc9E7fwoxTruG63bqPzg7vzkgCjH158WmN6QTjag/rFhlCYe8a
 M9QOrXvSF9+jWeIhU3L9BGHfDn96IFb8WesyYacDWkJmJXK8irU02D27mNbAbzCNvQYO
 fk9r5GQjCuglCQspsmRUkvHOBk0QwNkwjMkL3rPuAtbJnUDb94yngWIG8sO1yC3S3nd3
 E/QQ==
X-Gm-Message-State: AOJu0Yzula53SXjnp86NajNh/aUVidRbHzeIAzjsSU/J9GFa7CCV3rYz
 m8EweCT34j7ENSkZ4kenU0X13hVgF/uRwa3vmOOEwTh1eF/eS53unAoQd2fLJUmBQFoNJQh8wAP
 ugUPorio=
X-Gm-Gg: AeBDieubn/Q02n4wzAMj9m4K9Bd1sKTQHdKlPX0y0HaHuNwk3AM6EaujjtqjwnE6myO
 1b1rRzpUNsZpw+E3SBDv3lztU32Z3sZ/oRVRENx7guxJRsGtbZt+FzcgVQJu0KizWch/63VobUH
 Ltoc+BYgb4a6CdCqVy6CaBcQcBmfGR2UBN7a/iOxP7zIeGfBdiUQqLK5jXMZuAnQfT5hnsLZEPt
 Mz71jC76B8fX6x6ZYGjNVq6noeJOe07L3Swl1ecBeK3ydjHYgMFKSK6DXIA0iUrOGgdGDJqRgnT
 iZqij2+zveywFDivtczdW/U47D/YQfhsHuxXwksXL1IjXQnSavPPJnwXxo9VlHh+PlpgOnEzXnF
 WuYK0ZtowKkgBjGkA0liojqw7/aUozRMzwAkqwiwHtmV10b51KSo8OLwHLXQdR52hfUXVRm9VXY
 nYGNoyxhJGp7WjrJ7umJJ/KdwVLpkoLSUqsEFhbEMq7XEkv6wo/j5r
X-Received: by 2002:a05:6000:2f87:b0:43b:8858:1146 with SMTP id
 ffacd0b85a97d-44649c998a3mr3951121f8f.41.1777364945016; 
 Tue, 28 Apr 2026 01:29:05 -0700 (PDT)
Received: from localhost.localdomain ([37.162.207.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d02f2a2sm4770813f8f.10.2026.04.28.01.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 01:29:04 -0700 (PDT)
Message-ID: <69f06fd0.df0a0220.166db9.9ddc@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260423023141.28151-1-wegao@suse.com>
Date: Tue, 28 Apr 2026 08:29:02 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] cve: icmp_rate_limit: set icmp_msgs_burst
 within network namespace
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

Reviwed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Ping @Cyril

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
