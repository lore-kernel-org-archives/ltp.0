Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4CCC61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 07:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787903786; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=J6a4H35FGEjJm/vPVuRJ8rEa3bCO2kw07WFzohpdK/KrM2cydPzPxL5Zg3sTXLmOduILZ
 juqfSRIRJG7lx2FmBASzWQDKShmypvetxVW8XibFpFjh3uU/EigEl3AOMubFhDYyn9zYEiw
 WrHeDfmx3KTU4h2+9ApjrVBgi6FdUiM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7A873E2FC9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:56:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F7F43CC02A
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 09:56:07 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0ADE66009EC
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 09:56:07 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso4535115e9.0
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 00:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787903766; x=1788508566; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=OQiGdnaPbcA4wDPD7weoJggPTmLx6rXf/UqqBU/JT2ALtOD5KZOKZdBTNW4gUMON7z
 43sd1cBN8McGOgVYfG5OWtpA4OsnVBy00ebCKIYBy/xJbrN5M2c/k/4vgBxoKhAGmrAo
 bqp9qfKOqUIMtDnZIBL0685Qs2nbcofc0bT1k9G+UXd0b0A8hFxTUjrrEqoNGLeamNHc
 9CQaDTGPmTtdRpGIUd/jXs63YeSe76egOxIDau4LDwzto/acYbhcfV/3SAaDzDj019q6
 Wjc0Q3/AyXLBkQzTUPvb9xxkrIdcsB/uewcj1lreafo54+SwQU2/N3Avd1RZRPApo8oR
 zCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787903766; x=1788508566;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=kMi8Pk0NgatjFin7yOSTa5hP/8nLNBnIOxd1OSQ1TouokOgOIVdpbmLuW67DUDyDz7
 T1pNsehoI7ZnUL5IkeY1SgSzWyibRAW5dgClW/n1zlh9cuRvqmpXlZEj71+6JRNn47kI
 eNfsOv1T7Hxppohukax1gsx3X644pm6gSiEKUFgNeDQxJsRAtOYUDbvscYEIxjP+Fsqx
 zZ4ZQXlY4KFxG/H4W1pp2dkyb7QhsasECDSNeEYsLsaYRuju1cFPH0Zb69fcSNv1O8SN
 wXDoB2CPtyUyeOqJ2c/ZeOiR487biQf/E4n7YdLZn1p6bBMqNyeO/71wYuoDCxNA89FE
 dZIA==
X-Gm-Message-State: AFuF++lUKW/S7cYrUoP4sHvvZ2x2yK9JSSoa2He07hDz+n5fcKIHCNv5
 7xplYJXeIGO7HlHm/+Isiwhz18L9pgQ/wU97wQ8iPciwV9ubHCPu4xcVfKyMdDJdbqM=
X-Gm-Gg: AR+sD11Ha8puY5CcXk3AyCNWP2pb/+VhYOSgVM5VHzwrBFLLwg/zTGQVxurKRrs5Ooj
 3THaU9GREZs1rwuScxgP7cUcn1kPkP4Rd/ULJ4ysKJ1mszoigRZV/N1rnCZ+svOXrxpnkKXjD02
 uYMS7B88hUurk/LcHahrdLWfiNYRQLBofPHJLRKTJbNyN/AELMw5UD/9Hsn8BSjCsg6WNDtW3/1
 EVeW/nFfU0PQpwwYypp2dBIFKHK65foegFsugDNcSJKsOh0u3bYh66kINYdDePvThF/mxQ2EdpA
 S7xXdR0DJiJV7IwGGAFqPxCk2jvV2tLbPm4PPOd6Le1Um+Sfn7UuGhJ7j4ZXHfNttYcIvU8Xsr5
 bZ56odvXXuKgfO2zPCAX2yTvYcH64VXOvVwaTCsFMGy5VzSg8dp8LxfBEYd+KUAZ3BTUcJoNCd7
 5pn1uNriwwRVhR22yn5rr5hygpUpBRDWJzM1+1WFWiUirGx427JXTBJlLNNloHivB+BO2D73OT0
 /tIF0IK43CoVziYs/DJGicPZIVEf9U0PRi85tpi8j4Wn9SJyEQ/jCtJW0wQcT0OWT/arFs=
X-Received: by 2002:a05:600c:c09a:b0:49b:8d8d:7ce with SMTP id
 5b1f17b1804b1-49b91c4f228mr59827045e9.15.1787903766396; 
 Fri, 28 Aug 2026 00:56:06 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbad08d2sm2643900f8f.16.2026.08.28.00.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 00:56:06 -0700 (PDT)
Message-ID: <6a913f16.ecee4ed6.355260.d156@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260722044732.3547-2-wegao@suse.com>
Date: Fri, 28 Aug 2026 07:56:05 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12 1/3] lib/tst_uid: Remove spurious TERRNO from
 tst_get_free_gid success path
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
