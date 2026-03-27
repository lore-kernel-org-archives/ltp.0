Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086B910BA431
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 07:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774595001; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=SKFmcbtWQLmlZxXLlZSYW1VCqv+GzXBUaMwnrLMJjNg=;
 b=PAZHCnYh2t5zREYJZVI6h+2lxI86sVe6gXBAY4pDcJQBS3knDFomwKjcsotKVTqPJbcmP
 tKPqyhr0fcZ5EJGAdDQHRPvo1/g9o16l0c6I7ML+stIYW+/DZT0FLrH+2SbQz4gCyoBjsqO
 jk9DJUruC9+V/rWLb4k831KjqaeKB1s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C06D3DCFED
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 08:03:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 887723D9E8C
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 08:02:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BA46D601514
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 08:02:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774594975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IGii5oonFRCtW7LGEEJVanGlfc+d81TGw63/j6H88Nw=;
 b=hFStn7vcBuoqBFI/sHzqds9ZuZoi2B0WMhdW5EHE2l8uySV3wkE1Q1i+0BKT9R4SdAhBkv
 kp6nCl2Wi9bKA1bSmZ2W0WbWmsvzlH/LML8E1tzPLI44O748/a7cVUdX6BpZKtDHb/4yC2
 n078aBGIdAE7dmK1c/1EFxuE+BD4/Ec=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688--J4nB6VoPy2yMdUxOq14sw-1; Fri, 27 Mar 2026 03:02:54 -0400
X-MC-Unique: -J4nB6VoPy2yMdUxOq14sw-1
X-Mimecast-MFC-AGG-ID: -J4nB6VoPy2yMdUxOq14sw_1774594973
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c737b6686ddso1270643a12.3
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 00:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774594973; x=1775199773;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IGii5oonFRCtW7LGEEJVanGlfc+d81TGw63/j6H88Nw=;
 b=VR3QnfJ5HybBklnEn9pCfEg/ZHEHxq5SrsUtI95rLsxFVEvHrWnPo6CIzy/LiFDQnd
 OMt23Y3ephP3tiPH0fK13uyPvwxq7gvbAv2d3mkE26P2fbqhHnTuu2yzJDSbuHDq2eQK
 sizK3WmcbGgEWJ3aWk1zuvaqUEQs7V9xHSLEy2Lb8bGqHWN4mdyDIkAOpihVwCjp2JN3
 qBBGlMOuE86nXHLFR/hql2KLcQLW5GhGn9icSJVq2AHhd9VhMi66IILNJS7RrpQVd4WW
 AFIW3LgQ4CV1D+i3dIGwJnI6wqTYFeqC3gy2o3b6aeqohjn0kkjLCbdxYwRo+TZyFcde
 6wfg==
X-Gm-Message-State: AOJu0YwAumAh9e3CS3bNPhPgJC08ZgR0y+PlLQ9nUh+joeaFmnSYDCLL
 atUm8NB4Xpc/efZrSBufygx8pEMETVhWbki1G4+3BBoZmlEtErd+rWRa/MbGeLTaI/UjP3owtx4
 9pP8nICwHNZeaqmMkgbPwI7bbmmmvwJveVb7a/wVevAJRFOaCCiwTGMcyIfY2
X-Gm-Gg: ATEYQzwWEoEJ/thMgPF9yUA5bSgP2wdn7XoiPlGf5l0uC+MWqI8dUCHpendEEVAMQXn
 58B2aPrlViZ7n1vfh8/zw1K9/v/dExitXpmaPvNveByEAc+W0KW5XVTbumTxQRFUAxdq904uD3u
 uPEk/0ogYk7RS9sWH6wDw3qYz3X4nKmIVt97iroMAkBUfrP5AXkm206P8wVu+veU9NIyd6hheH/
 McFvfE/HZfu/PLv8oS4yUM/XCa3hrQEGOeR0v5mHXVIdimAu4S+FgXfx5KdIaObLnQk0edD/dny
 0TgjZPPj3uVgzFF71HZwxXvw8DRXWLwS/GtzFqweqPZIljIHi10mJRa/AH7qMoKPJdFi3VBTYRI
 J63IxkNFS1vUbdk8qSw==
X-Received: by 2002:a05:6a00:1ac8:b0:82a:5ef0:210b with SMTP id
 d2e1a72fcca58-82c95e8804cmr1500633b3a.15.1774594972641; 
 Fri, 27 Mar 2026 00:02:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ac8:b0:82a:5ef0:210b with SMTP id
 d2e1a72fcca58-82c95e8804cmr1500597b3a.15.1774594972035; 
 Fri, 27 Mar 2026 00:02:52 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d388e5esm4813355b3a.37.2026.03.27.00.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 00:02:51 -0700 (PDT)
Date: Fri, 27 Mar 2026 15:02:48 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <acYrmGE0yu07rJsn@redhat.com>
References: <20260326144006.3035-1-chrubis@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260326144006.3035-1-chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5VkiNgCnK8Y_r-K1aDAvik0nCKiRWn2J39m6kEM-wZQ_1774594973
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_kconfig: Add runtime checks
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> So far for CONFIG_*_NS.

It would be great to have a description for the feature:

Something maybe like:

 "Currently, LTP Kconfig parsing logic only checks if a feature was
  enabled during kernel compilation (e.g., CONFIG_USER_NS=y). However,
  some kernel features can be compiled in but disabled at runtime via
  kernel command-line parameter or sysctls. When this happens, tests
  relying on these Kconfig variables attempt to run and fail, rather
  than being gracefully skipped.
  
  This patch introduces a runtime check mechanism for Kconfig variables.
  When a monitored CONFIG_* variable is parsed as 'y' or 'm', the framework
  now executes an associated runtime check function. If the runtime check
  fails, the framework logs an info message and internally overrides the
  variable's state to 'n'. This allows the existing LTP dependency logic
  to properly skip tests that require the disabled feature."

Also, add test_kconfig04.c in newlib_tests/ to verify this works?

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
