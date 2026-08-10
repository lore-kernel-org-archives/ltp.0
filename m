Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152A3C5AC82
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 09:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786353469; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=lWFShXT3bBjaZXn91p+gBtjTfw/npeW/+KQ4w81k6EjlzyqEZSj+ku4MtlEj7+ss5jylw
 FdPulWZy4wDf6bqT6kDXH2n0nppFWnVmo0McUjYplkrlvChwCkHKD5a3oKFyUyUxSRRa7Vt
 KxfK8z5x7JuwzYUZXDOFJDCXlEBwX6c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C86363CE321
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 11:17:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7E9B3CE141
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 11:17:28 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1A25D600067
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 11:17:28 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso18828215e9.1
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 02:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786353447; x=1786958247; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=SN2iDTN99IlmhQwzHZQcggqKN00OYnauH7VrCsQz/hs5DSxzHSKP2ibNYed+J9e9N/
 JSZLC/ZKWfrNeSXqFnJBbFAEBzFNfAAEMja2AoU06upPMmujXMh7aTSigko9AbKbLyp7
 EUaoXr0KRrhtv+DFIr3b1B/xfwndxvabqP4uF57ErSV7mb/U71DE/PX0Ve9Qd8UPKfsb
 mbYoRDq9naKPLWGlLHbuJPl6fSDsPsoST6V+lSoRcIPbYQn8NWVDhY2t/2n5RUXH04oJ
 jH5U2NH4dXqLeTrfSF8AsqF9i4Zz8673I79GsFFQPnQ29QOLWpCzDWunAmaKTOGcUPff
 OFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786353447; x=1786958247;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=My1a7ML8Dc+lKiVouaGcgbUmwtXY7/HfuMFDOBzhZprVWEYklsI+h7VxJj1/1HwahJ
 ykcdIkWAgZerY5VAumIlpstb/zrP3t/9CXIpJYsT+dDbrso5Igzw/Qq170+gknje9ELk
 omhB//Obr4wlE1PRL74AehVkM+XUhvA6g2l9CDkt03Cy9TMEdj+u16nu0k/NY0Z1cvog
 hN8gA65OWy+ZZ7fYoVj4Q6zAJ++TlhTjRvWYcNyAaFP0uSj8RlyAbLjZ5jOvBGV0Orq5
 fZa6F1vzNmR+hRtcx3kFTodWx8vWEFsFX9M7YvGtvG1sIQjERDuAC7KtcAjfnvXxcENd
 f8kQ==
X-Gm-Message-State: AOJu0YymZ3TZblygyxhFRxqs1JZOv1cb5x3McCXF9HU0AV0wskKh4twN
 h8FUQk4Zry0gRd6mbJ6c0s/00xqUn6l1Tpc6bwxSlQ45rRy49saRRF55R+yOfRAfOMGgyTxjzbe
 FdV/7
X-Gm-Gg: AR+sD13RpoRp/1NKe6BxRJHjXN50O22q4Pj+tZm3r2WJh1/KBNSxDTFaS9SyeSVbg5b
 ojTTWWapEl8mYiUHQ16QDnKJpa6m1dXkb9mbNHl0s7dlWtZzA8TxefdQkDQR6Y4yq+2dvy8CcTL
 NDBqRIoTLyJirxg5YvEk1imxLCYep6QaMS6dwO5/UwXzfzDMBpXnQmK3pMa3UFr4mjSi3oupDEp
 S+nIpKiCaU0F6TJPEklAqlNKsNpQUCq1LFavB+I5avIfg919JCtmzBSRDQkhDC5VK4bR4b6U1Z0
 M++ndiJks2uSxRRgsHi65lbdISjHDzRkZLfmRfHOZmvu+OTmXO6E+w/2AMJdG2FezkfGIKkiQpl
 9pxtOjEsxgOqw/M9RsaX9QwtANGOys73hmFzk/cbrwuaOP0K1TjtnW0ba33lLdc4QJJ80fgXKaH
 om8IV3eh08AVxxjXw2Man+gAwWbgSDmvLRNdx/SZyu5iP0dObnNAfh1/robGmjrBk0DoLOpw==
X-Received: by 2002:a05:600c:6089:b0:498:ee7:e407 with SMTP id
 5b1f17b1804b1-499727e7eaemr4580165e9.17.1786353447453; 
 Mon, 10 Aug 2026 02:17:27 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995ea3361esm284345085e9.15.2026.08.10.02.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 02:17:26 -0700 (PDT)
Message-ID: <6a799726.09e844f7.2f9deb.ad56@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260810025817.1665141-2-wakel@google.com>
Date: Mon, 10 Aug 2026 09:17:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/2] lib: Fix overflow in backoff polling and
 timeout multiplication
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
Cc: wakel@google.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
