Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30FC606A319
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Pe0+Mbs6;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=NKTu0st4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792575247; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=Pe0+Mbs6lKQxHvcRyrU6/0upge6MZrm0tcbJFQstfxKMUbaBaGC0GTuXVCpsdhBWRZgSD
 ChI40K3GFp4YKG2gZ8gzr5xgADbvMkJk5BISEnsFu08vNDpjVAVC76pZd1bJ1OVYcvAk1l8
 62lluuiOcA2TGExO6OQrNPg5YpTCuj4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9432E3C1CA1
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 11:34:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 747823C975D
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:33:36 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DD095200165
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:33:32 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso6210315e9.2
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 02:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792575212; x=1793180012; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=NKTu0st4LidPo0smzVbv/L0PIKBDsnDZ5a+tLIiyD/Vy4caNzC65YCUt03/G4js1h+
 fFuE5tNL9O4thmcdxlQw1JuwT+cEjzWh1BsDE2hV3hnBebTJ2bQd63x3H85hTxJHoUPg
 UE/PemnZI+2sRtvXlaxsU+soCibzrBksbXQppkcEi+4v/aD+2ZjY4/H8Zk8K/zO4j79f
 tPaWCaZqMOPKEbiZn0oRbZXG1AaN8VUNplIA7fhUD4pvEq/Xr2BbL8suueYgNlpj10eC
 CYUXxvj6uvq5iDWNa5SXNua777dpqZ9tleWFVu+LZuiblBNK9uurlTgLk8xAtNOphtJN
 NfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792575212; x=1793180012;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=mM4v5fgHLrdlKVQCC8u5zSl76l7E0oxgLCc8HGRJdVXFmPeR0TI603hAuvxcELiNk1
 rxDV1G0spdA8Wude6NOxVK6JQQZG2YYweFzRSXWpLSPbHA1vsbz4In6nmIuwrP86uGNU
 JjJYwoy2JRvjKPEr0R1yINOxnhZfhBpVbH8slLfihzmsBp9mjqVHPiSKCPi4XhscQaNe
 XOesULrxcE9Smyhhg7T3vJy6zEtSBvTMzNIrejlPuLKxZUt+7O64hkynPUOXQAxiFMx3
 uj21MMaBBZLr3whD5FHb+0lzuzX0dwWB9CwPufzPZJXcn7riP7VTAqraFx1/TAh9PpgX
 nFgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByRzb/NcvO4gkZ6bbYaXulID9xJBFYsPdASGTFG9pewWNuBprxxGjFpaGeKDhgs3gE8skU=@lists.linux.it
X-Gm-Message-State: AFq9FYJClMnCLmt1FHCfUm+erx4jRrJnQ+niGfZ3XggWcgUiTWleQQl0
 YarHPrGzsBeL/0gJwTNUGdzqeZHlCpC9Mrw11AaBu0sT46ZVs4+dy2ZyU+ysc4A6Xys=
X-Gm-Gg: AYBFou2IfBi6hDP2cDE9wGWNUdE54zXvn2lldwYtvlukuJiqCCQbnqXAuJklUn7Hx5g
 +yMiqjAERgzZFhfPLA3SbFVugE/DnLdSUUe6DA6A+DU279WLYPA9kaW4uRUkY/WKGAmUrvJCil2
 yyfuF2EvPKz1hm8UtrmSRHI4XYL8791ZpgHdHPDII7XvQpbNjih9u8ZtXNkYhcKGdYDwxdyMMeI
 739DhNuYARpYFpbZbxQDuKkvrb4V89a/ZNxiSbinJDi2/DJtBnb6QXaUpF6TM8Kjou8KaxAIH+2
 MagmyiN73WtxMpmzk4th9LjbJSAVnR/ZE4H/PfHTa6DiVZvDHEwprPFS2OSPLaq1FFVpw2NH9qU
 bB5ENJuQw+nPx95g7uHLcik/r63L0AXAKDXwkvUTA4RJTBZkwuUK9k7IiCDbrGoqj9GLa/iqwSk
 QULXFMFbqTJaxrO5d3qbq6GdXRcttS2H9kcvDAmcSKPcRNAlpZsJecjf6ond+GGJlcPb78L7cSj
 L9rYQND6P8JArsj15ZtEa/n8J7wmgd/LzEcngEcq8McEXugZyfRMPaBgbH8xdSzLrUT9vTfdnKi
 vS5g14uLdOeSui4p4yzI4KwNLXWhLkbdDhIluRE09+pAquJqpe3LDVKUrnL4Vavhf0lxmEqDHbk
 fwCaQ
X-Received: by 2002:a05:600d:8645:20b0:4a1:f377:5c75 with SMTP id
 5b1f17b1804b1-4a1fdd6097cmr19999395e9.33.1792575212183; 
 Wed, 21 Oct 2026 02:33:32 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d1e8ebsm129365045e9.3.2026.10.21.02.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:33:31 -0700 (PDT)
Message-ID: <kgYvrQ9quAy6lg4m5do5rFhk6Pkrb2X7E2xj@localhost.localdomain>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20261019190513.3897-1-linuxtestproject.agent@gmail.com>
Date: Wed, 21 Oct 2026 09:33:31 +0000
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] float_exp_log: Fix ldexp exponents written by genldexp
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
