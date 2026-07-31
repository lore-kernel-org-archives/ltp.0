Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102BFC54F54
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 12:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785501913; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=AqwVcIxFOiHgavdEspkVD60GRCH0ZB2pb68S/PoqrAc=;
 b=PNfmL4AfpSrrCbppo6YJ0dqK2Mk+AvYksU5meRfXHmNSlpFpHXcyv01E8Y7m7zHpW8o3I
 WpJz7Y9cBKGKVQ8B/Qqqugmu/yE6IyAf+RigOKJQVKRCAFtiGccr7EtqkKe923LGr8BxPn8
 RZtzHhy0MbrMruVtZcSlUOzIxA+KpIU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4C263E7205
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 14:45:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 792A83C20C3
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 14:44:55 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0E198600A25
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 14:44:55 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so354450f8f.3
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 05:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785501894; x=1786106694; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BVp+WMsveYUmnjxMZf8r8ktrvSdLVSL8JGUepk90O40=;
 b=Z4FL9GOFpiFD277YL8eaNqJ/EqaTvYMy8Th+0hfqA5ywIxWl3HqN8WjnyaDTuXyUt8
 6KS0qjk76kxW7T+qoET5RUXzHMpVLWWroVWciWrYPE7ieJaLWrctGWlGxEyKIF/CVRAe
 0gp3ettD538bonyhXzOj35PC7FQHqzyx4XjFyxk5kQVAG7TgKvRsG2ZpS5QQRERT0bzk
 wXDJmBFyS/wYS24T5fMB145u4XXAFgl5tBroYGs28A0cgo6rBvsLNKlPETo76pD5eofu
 l7j1I8RN74yJghcYb436YnHK73urT+mSfiCYF4V+C9RWihVwbHOBgoqIjB2WinEl6wfX
 x+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501894; x=1786106694;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BVp+WMsveYUmnjxMZf8r8ktrvSdLVSL8JGUepk90O40=;
 b=eoOfsQgsGs91/sb64zqHfIlojow1o7DjDpn/jnFDjuvkT7wvNC+YXwqFtZ/FvZYqMn
 F7PA4Z5s2/nenIeJqOINrYkIgfKC2E36aPQhV2HUHUWy/8dEJzfdlbP9NGR5ixevah1h
 5CapSw5FaWX3w6xhhgZgFdkaPVhD43h278ZHWJbATn8iCf3j6s3tEb0hPnNOIUPQGxki
 PZEfRViL9u4sxHgMP4/L4jMdTvZhtMhWiqdnfIbG2qEeH4pis9myqUwgSXVlJL5rYnbX
 a3Vi6dq8WaIycgy+gvzK9OaeEM4Wp3mkrVi4eddQGCV/nzPWvA0fC1RHWLd2tqWWk5EX
 kCmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrXgQpo6EyFXxeE4Gz+MB3qPlPDg53oXXnmQqriPOPFpN2k/yZ7a9D9NYT7BK3Xca0MUWE=@lists.linux.it
X-Gm-Message-State: AOJu0Ywh10zWGnRqrkr13/pTIuUpuQrIDG/btTo4OINE6Ozng9gcziiG
 tQP4GUrXcq6TLUhe4YYeHs7pc6zxSX5/eFeYH6gxJ9R7JaDn8mEk4eb78oiV0jc67g2avCJzZwo
 VVPIzkzbOOQ==
X-Gm-Gg: AR+sD11cv72di8uMeZKHCUgOPWk5JNR0Fwm5GavGiZvTDDLw9slqG2LIdTNz8UPstF6
 A2wrAs91kQjfjFvJ60vL4ixAnZfTf62sW5OBJsZNtv/9yZHT6C3C2OTg9WGA4TTNOFwev9LJLfF
 nKEb4s58hUj51kcu6qKH0W3KIwS0pL0tYBo2JjV3D7nqH3RPzeqRlvz9KdJQnjvu5H6ClSU2m/w
 l8Z57nWDyjBRcDm41pOL4QvxDQcAfK6gqJWxcRQq26ed19KhKCuO/h1SMPDgVFabmjMCwQp5vaB
 zRYwmFBsa9Gjicd7xYqxqgIlxgToWyXIWhsD5sgzaRatalOWCTa68rfDfCLE011aZkj55prALrH
 zDdvwshD/tEjRJnjSndRPCyLjBNmE7FBwLnNdaBEfU8OLLrG8jpwsPGJa1fnXhVW4DRuxGfEL7x
 1mxyxHtS7VyDcrqrtW8bwrC/1gbtJC290ohsEQBwPqoaKcdo8SmBUuWVrC1jNuBRQKzwX/uOWM4
 ncBEcILI1Q/4wwd/3k/7FGmzercq1ykiZ1JWQ==
X-Received: by 2002:a05:6000:41d7:b0:47f:9260:4bc9 with SMTP id
 ffacd0b85a97d-47fd2b32aadmr4292320f8f.29.1785501894414; 
 Fri, 31 Jul 2026 05:44:54 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41cfde0sm3993130f8f.3.2026.07.31.05.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:44:54 -0700 (PDT)
Message-ID: <6a6c98c6.3c943127.1c122.1c09@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260731124232.GB196217@pevik>
Date: Fri, 31 Jul 2026 12:44:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Rename function check_kver() => check_min_kver()
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> In that case we want to have both in a single commit, right?
> => yet another version.

Yes, I think so

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
