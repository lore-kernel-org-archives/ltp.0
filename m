Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5C1C55179
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 11:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785756460; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=U3gqQJ13WsX22zKlJwXv50+o1nqth84DHbWkik4KgEJMoKmxY3FQnp/6iLXZRw8tAJK5E
 53v6KaVN3hYKJm16z268tM4+YanFlp5x4mhOxtbWkL01ddqOmo1c4oGZkXpmkk20ot8quF7
 JqSWAqJSh8kxkKNANMDyXVCkF51JVGo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4C9F3E71A3
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 13:27:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C3903E53BA
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 13:27:21 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 95B9F1A004EE
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 13:27:20 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-495590dde14so19661055e9.0
 for <ltp@lists.linux.it>; Mon, 03 Aug 2026 04:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785756440; x=1786361240; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=YQthCWDyfSG6yEjJHIJlRGmNJMVJI2qkDFUCzcbtHP/7CuoT77fkcB1MtXPEKwwFVJ
 JlkEzOA6CAjMzf7JLSOxvT1UxALdnsnKFoe5JBSmU4IU4WCFSo/cKprQjeI1exRq+0Dm
 fc0peytxMF5zAFmzWZjKqnhfdmF4niPOYEttYd9h2g0Md9VSepbwDuTtUKzW7AkUN4LT
 cAEt2Szo+JZ53dolikRSTnpMMyPGeKCCSmmoWVMOspypJTfvD8boaNzB/qyr8T+XjZFB
 Y/VtJ8/lRYxwnGJhegaFfNzHht9z8GbN1WwxKjABUAPklyBG1V1gnNGSWat5LD3SKOAq
 185A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785756440; x=1786361240;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=JEDOzp4+tq9U7HYSuNOsf8SSWVsZd2+0LuldQOsM8BGddrbfjG+EoJGuYGiPrbpSWM
 n8FCALP3SiSbusVL0JJ7q29Lo9P5Y2sQ7HjvCA7U5PFacN6cB5L9VJUDwkk1MVkClf9U
 IQPcSSTeCTQtrA0H1qb2e/LYeXk1OTMBVocRHBwsKPjNGsIhmtEDge+Gcluv+r63uDPm
 DRH2EJLMRicweiSxMm9AcKGVhjr5eFdSGxavODnxRYLfH1DxDjVCwhnGfZqj84WREfXW
 /CPr6EsXod+ZdL0OT06JF4SyX3NtL6T+Qv/eItmihKJ8/BcrUce1+hzfzUZqnXK9xJ+l
 Hb9w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5cpdav/ogULyfxa9Jgi5ztRH5l/0nbcDsuTav3lam1qld7CC0Wn+dyPtsOD3wQzZ0kS0=@lists.linux.it
X-Gm-Message-State: AOJu0YwT3/89TVSS/Zhv03y+OXvOKEFcLR6iwRRGyIjqvee1/XKE7eaw
 +him25ThI8hK6ABdM++cu1BfCERD4NPRrAJHETC4HJn8giVKPZxW0nl6Pzt95TD86IM=
X-Gm-Gg: AR+sD13NJLMbffvEO4meXIFtu3uCgUzkScM6w0JEvlUSKs3naMP+ov9eleml1Zo9ox8
 49pQ6fqvfszmLQ5G4Amy0GRS7Zgb3TI6gMycvxnPZ3LmjfylS/Aijp3toJpbrPaCotqbvIwLk3e
 p+0jWOJSOLJGjO99zP3NQMPu3n6YbiS39jJw1Vv0s4OO1Qk6OjvDfl65canDEGMU+m1suZ19tle
 D4ieQYx1N26Ua7tGz58BEwSvF6ez8Xe6Q+DukMbjwBbJMFnMUaVZHnzeOJlOUGed9aAoWi4M4eQ
 Fw4vmAt0cRLc98nVwxj7D2PAtLdzdYwyANTR+qVEjiPBx885kv8trlkQK6pR6rRiHaVt5xUa27w
 vTkpsX/jYEHlm5NaxBpPI7jFrqXUCxPLCyAsw32SbZxwmILiP0a4JpUu4ZggnDpz1Kd8WCQosHk
 WDUmxR+UExyIaC8fAbUMEZ8X1iAjBOWhUTZf2jYrvRgRUgxcKyQUIUx/pvZohfs5ws9G8Azz3pF
 EGLwBElcFMkf7/KcmZlxXcTPibqiOVgosIMpg==
X-Received: by 2002:a05:600c:1f89:b0:493:cfe8:5b36 with SMTP id
 5b1f17b1804b1-4980c66d7c6mr167477015e9.8.1785756439959; 
 Mon, 03 Aug 2026 04:27:19 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b8d04fsm295266895e9.3.2026.08.03.04.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 04:27:19 -0700 (PDT)
Message-ID: <6a707b17.1583746b.1fc047.8237@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260803111553.229452-1-pvorel@suse.cz>
Date: Mon, 03 Aug 2026 11:27:18 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] MAINTAINERS: Add LTP patchwork instance
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
Cc: Tim Bird <tim.bird@sony.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
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
