Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B3BCD98F2
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 13:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782136716; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=t+tPDrkda4uUQlbqtfFN0F8xSI5bPkZcInK1UohHcIQ=;
 b=OpLZc8jwldw9ZvyKkRNVeNU0+M1vwX4mtwZt2JeVtVEeXqYn1nxBojSQ/KZZDG8endD2c
 3zEM2tmudRFiEwxMUf0Xgll1q4ka4NEQAF+IxSDCzIxr/Iir7Kd5rY/2Ue+GqzFpekUHwfT
 I952Krb6I+iLK3wI2K8BAZlAXgmvSCM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6756F3E0DA4
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 15:58:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D76A43E0DA4
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 15:58:16 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 298D6200760
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 15:58:15 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so3387062f8f.0
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782136694; x=1782741494; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=Gh+NFTsW+0rpx4AHSLH/d7I8kKv2qjvXHkw8Gv8re+5cg+rXHPA3G3YQ7OUSvrLYkP
 YnJcCBa7EvH+pBqs8LoY7pBaGkW5u1emWXaXIwOxq5T2xDfY8Ena/ZLEbcrCnshidUtB
 nFoPyklJ0aUGVWQ+rKGtnN3eXxUpxBVwZnMhGCMN7dk9WfF82QPsWxvHELBnzkzS/iaQ
 TXfbsSnXJK9k1gvrtHGvIF58EWW+0qt/Z/JkxQwi+USfXexg3NgBWQsIoN4/kEfu/WrP
 GzWjJdkvFU5qmb2ekNTs/xF7pOCjIDaaEhwe0dtzrJ7vBzSdaGga11ntEH8L8BgP8WFH
 M81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782136694; x=1782741494;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=ESgvekyEr7zaUYiux4ptzNpQAVAD2smEiAGo7muiw+UilT1SqHKDsKdk0lfkWC0j+X
 M+0B/4RI85oQZw4aeF3zgdKR4KA23rt/nOKylWbTN6KoODLQOd2NeBtW2MnsO7kxZnIt
 MrP0mDJmHTZoUhzEdo3b/beKWQPJSKOHK42qK5m01XKmH8IncURxJYw6XXX2zlU4ONvO
 dxXatEuPCwXtBJ9YIJIhFqIlO03w4YH5GgLmwoY1LN5MP4q4yRfZkl5rRpFjM+sg6QVJ
 YaohNJDMv+vWEbYx5fmmwdgDmoNLPGsswriXHIW4C6ExBmhoMOCEiMnGIiK20FcmzH+V
 2I4A==
X-Gm-Message-State: AOJu0YwIpxKW+l2/kWiil+A2BPgN7HFnNYBIGTuAO77RivZ4i4L4rrnN
 Xw6dpm4xenGqQppLGsrqij+uXVuFwdHiAKbS1AtGedeMMb59qmnW/ffpzSKvIl3gQkU=
X-Gm-Gg: AfdE7cmo7flykJR1UDyBSAXD4SF8s27twixMFJ6wdN2dOfkP6WdX/wgTyzwHNyq0QSs
 4Faz4gVf9wcWKf5BO8vBPYIlEJV5vGzNjQ/MqJlob05vYxO5qyDUKc6pcNcRQ4H7JIQwMvEeYN4
 UN7I4+DlzEPCiXGbieFoz/3/JqjfDTzCLukkKv2trg3jmiNdn1digUsheNeJqrfjJNbWogBil4U
 rgXaA5Q7ePijuVYqWvKn/LZ6svSSbVlrwin1eQTBdnxcZfiIeAbS/m/gij4XMSHWSC9qiOYJ5PC
 BTUWLHESqcccOmQslv05peXPw0B2a/VYlmxcox83GL73tDKmE9Rg+AXurCN/LIBWnF6b+dZ1jwQ
 ehDj3vNpnW6v2LYt/1wid9NtBi5Tv/1oGgzBSeJB8s39BigHF65NVpxJWD1vJgGCbPFj68ouqeY
 Pqnl32IbQH8jHB/4BZCYPH3A+OCWmwUBM/gzUHia+FhLz8vVU+ayi18OT8OACUPg==
X-Received: by 2002:a05:6000:41e6:b0:460:70d1:c75 with SMTP id
 ffacd0b85a97d-4656c69b3c4mr21368329f8f.13.1782136694462; 
 Mon, 22 Jun 2026 06:58:14 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f56aasm26273767f8f.6.2026.06.22.06.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:58:14 -0700 (PDT)
Message-ID: <6a393f76.40769b9b.256904.4bdd@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260622135652.3516051-1-chrubis@suse.cz>
Date: Mon, 22 Jun 2026 13:58:13 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: Flatten the directory structure
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

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
