Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C96BC5518F
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 07:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785828964; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=mnefXAqyiS8/0wEzOKPQJrW4lDBqB+sin9vbuFr58MH5uriNlneXOP9Z8NgfkuMMjekBm
 s3IJElo8LmwJ92MDWXO8jV2HP91a2Y3Q5y50VM4IScGJqhfKwwz2UI93bsIqBQrMTBR+30B
 aOKPKOi6BvUMYEL7v5nTcimlG11KZ4s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9ED133E2D25
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 09:36:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE5E63E1A22
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 09:35:44 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7AD821A009BC
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 09:35:44 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so16590165e9.1
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 00:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785828944; x=1786433744; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=YDfdjkR2H/MiF0PfAotm/yKUY5N94dvnoqKRUnPghtxRLWtfLQXkEwuNe9OvZVfXrB
 QjjHEsnA52N6/jnfPAXFxhPPDSfh8Jj55WRmyhR5ZveE4r14HQFxaHa4CgzTMC2aNo6S
 eW158qmX8chkLx06dxZ/BB7tdlu0voVKPtFQPYlQSnCC6fNOyGg0o54WfvG2ViIUJqkd
 bXkMOipPsTiKlvIWNzrlSkDn0CKBs9Id1g+a9xve6zkkUKLZacddahTU1AbmvDihcx2X
 UazFlRZS2qfl05D+M+Ee6DIJ/9hgENSaHHZqycmVxmeVKX+EKp0j/8izbwsVMsWhiVvP
 X18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785828944; x=1786433744;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=EuIdaP1Dq/DphKehKoKwH39s7C9nSM0MC/iVlMaqBGIP404ge+48wIMQLjHnqkssQt
 dKnWCbvoLN3gelUrNfrXuHXQyayiQUdm8/XUnWCbxOOoY8LV0IWCmcZxxJYn9TNQDa/H
 nHqMPuC6gYKn9eGRAuVWMK4VFNvADfAl/EkvlWPv5vj6fY/OCzFOAB7KPYgbsKMw2yOc
 rupXiTUn1aO4aCXprfQ+fI1GfbIr8xiwJXDgfdDl0eXWPwbW7Hk560w8V3GZdxtwFhiD
 l71xgTBicKYDgphmBQeXw/vn/7XK9FYv3436RpyguocyhOlfBi2zisgsp1nrXMgTcR1O
 OHEA==
X-Gm-Message-State: AOJu0Yz8VUKvGyeckqdFeQu9/O9iSK0jX+I6DzLeNwaDwwqYtlIpJjOT
 x5uPSlSQ1q2RCG0WY7yZmG71ZSiHlD0FqfpwvcTMNlC9A9C9RGxWMbsD+ge8U8SfYsmykTxoz9F
 P20SppuM=
X-Gm-Gg: AR+sD10DDYOzLQb21mJpp+MtBi0MQ7zepYPZw2xMCGB2G1bdmdrUQKgJaRGGYlQ6rFA
 jxGtkTHVx0MA+35kj1VzWgfxaihuEjy+WrHHRVDWvL2LbSjGWXeggdsfG01VbQA8OYASbdsF9FO
 85qg+h4x72/Z6nw6MDN9r4nfDeLxb4gv7XtGGYUlI/x3A6f3MQ5MOKUKyXsKf8Th7BbVXTL8Pl1
 IRCKcQbbAaEnEUvTTLo72YeFamlOQz3mLDTYqgxywyQENMXfLl4I0unxBeRuwCr6O0SUFNC5zzu
 wwYz6Ydnpzrwq2ARGvOeh2EndvbPrj0YQmmMAe6VaFmvY6aej99l1R1G8n+yBFWWOIfAwWDBHb8
 BZkzmGND5IcJFQU06g8EeOGDyzbj7Sbtp6jVALkGlzDD3qr2GEkwuzY5+tIQHKX7Klze/IxOM5X
 D2XPAm9RYlv14yXsQD2840kiUS1nOXS43XAC+QMFzHl2Y/OnlohPXpIU8MzxEc+rNWmzyKPvcWt
 d3aFsDHuODMbrHduryjCo2nljkbF8JPoU1Ry1mob/ZOGvxzgXgWMR9hm7NfY9nH9jDlwnA=
X-Received: by 2002:a05:600c:4fc5:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-4980f23257cmr292106015e9.11.1785828943847; 
 Tue, 04 Aug 2026 00:35:43 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807ba6abesm232210485e9.2.2026.08.04.00.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 00:35:43 -0700 (PDT)
Message-ID: <6a71964f.55395e76.2a249e.a321@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260710051323.26430-1-wegao@suse.com>
Date: Tue, 04 Aug 2026 07:35:42 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v10] connect03: New test case for EPROTOTYPE and
 EACCES errors
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
