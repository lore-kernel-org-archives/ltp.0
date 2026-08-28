Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B32C61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787915780; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=nb+8RVOwyqd1bKaKCLxw9/NFb+fZfWSG25qWuN82km5LGr3g9nVqjbZbvcZbSJ4jILI+6
 ARNmThf34fA4KAxl6Vsg8n9uq3d6FZ+OBbtmqKaSwUknb1v+Qi2Go0Jay0sj//rP+mr891c
 1QFC9lUhQAwHYofVoQPW71xO/O96oBM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C9EC3DD385
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 13:16:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05DC33C6EBE
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:16:01 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 637561A0079B
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:16:00 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-482e257a23aso415904f8f.0
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 04:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787915760; x=1788520560; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=d7hgxdBkWfSHVw41tfpE1ecNma0gdYiuzbE1VjMn86y+V2Wpw/KcgoELQk1ZII6bH4
 n+6oPbZy6kzfhZJwKj+NTbNH4K4uYCyQdpuzM0Cu6YQ6NEmZTFJ73jwnABl57E+1I8aB
 30/zQCKourwFei3ibiJUmX4fj1/lRRClVSyuJs+DYoRF8YEv9iIzRPFp2FadoWABSAG9
 0XV3Q5WfMNIVEofqivTMwRYguEDXz1Pcgi1IyCNz/SPtLXnYAHI+GpVX5C14Y0cIVB06
 OTdlGlLE71bRMOZfAkJcB2xjMJLwa2zA4HvGhc6b7Q/6QLd57Ti6ggi+3FE3nuPTX2Ue
 ApAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787915760; x=1788520560;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=UhDN+zIn6vNxo8/wRwO8q/9c/jZpKeTqodcmdwlZGbdM3eCQiAtAbdlVEz77I206Pp
 Eu4QYm9sDp/zjT4FasUujfEYdryCkcpplTk8VsfA52AO46ctLbcUDt0AJ7qzH6/GdGGu
 iyT2XMBlTSVkhmF7+aUandcHOW0Y5fRhVT0Jpz1Kx2Dp2y8LWS1Oor+vlCSRDuRVDotr
 jfTGyLJSRvG1tJEg3YJ6Vdsjl7WSOVmDoPSRvRGr55b8ub/ZP4gPozW3xr/HyQM6XHDi
 1a3psd25u6W/Yey/Q+lz6InGdHQOVJDlhCVBCdPKv/HDu7spy+FEmN8tTyadBmOc2GyY
 Dwmw==
X-Gm-Message-State: AFuF++mkgKv7WmmMYJsmU5dNgLWfOr9t0/y2qnOlAYTQTP5JFDs5/N6S
 mrQl6oSOiHe5s5Adukb8nbApJEDuXe8aqSejzVASqsaafToyuCafGpkaqhZlnQRE/4g9pnrypIX
 J4PpcgEJZIQ==
X-Gm-Gg: AR+sD12iDjPt80Hn3Fz1sRQ45KAcNkD9/XMABylh3oSvLZNXwsjORiH3FByow4IAZcH
 WkaP+FxgR2kx5Cn2jCgnqvkcTLIFT+xlt9uHXN0I5WjMnPyJJ+3pCrrR4KtFH/TRWXHqh7H0bkX
 O9MIiPoa1oIXkqpE2mlb5QalVWZBosWJSIQe1umcnQvN79Xb35RXNwPnC9NCOYqQFWjf9hhkTmf
 YufXFk1JzdwDu9t4S3WXgxKT+WWN/QEnVagwhNCJUJ8Lbw4FOO903BKavUY8oa6Suhz1kD6hFYg
 gmBkbQ+FHd5nbim1hQ0/Ff4QZORj4yQa95tRKZeSB3BExEtrXxxJyvP7gsjBoJHAM8OaE8VkDgd
 uHmLOtf/xatTqfXD6S6O8NNyXIwFCJXrGLTIr8kzxyzgLgFUiAAMc05sa7CZRcQMVTOxqM9rzgA
 SdcKo4hsXpHyGkNp6BCWjGGG5YChNK1OtD3DRjiRPRB10pX/te1zSYtc077ixSB4/BGBcxb1g+V
 uNML0Mx58iGo7LKHdr3QaovoxinPDSJTNBp7RUM4Rjle2g=
X-Received: by 2002:a05:600c:19c8:b0:49b:c8e:a211 with SMTP id
 5b1f17b1804b1-49b91c20bfamr94670875e9.5.1787915759510; 
 Fri, 28 Aug 2026 04:15:59 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cc8b917acsm4921015e9.5.2026.08.28.04.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:15:59 -0700 (PDT)
Message-ID: <6a916def.fa14b9c8.34d41c.1180@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260828100105.195974-1-avinesh.kumar@suse.com>
Date: Fri, 28 Aug 2026 11:15:57 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setsockopt08: make check fixes
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
