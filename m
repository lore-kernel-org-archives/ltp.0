Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F310EBFD1C
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 09:05:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A90E23E2945
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 11:05:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5657B3D9251
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 11:04:59 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C6A026002AC
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 11:04:58 +0200 (CEST)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-38be5e86918so41008221fa.3
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 02:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776071098; cv=none;
 d=google.com; s=arc-20240605;
 b=AjTK1DohfmL48mmZEWEOtIdcBM99ZsGXML+CFp9MsAJkBxBJnx39Cr4QT5bXy16JND
 zPaKkoL7Ci7++Xlzj+R0YnSR96IefC3yAgu8X5drujoZdiw12PCY1USn7CXMSZIfdVmd
 Zzmug7S5mt7pJZPRlRc7Xm95StAfs+AujjZ+vSP1Td/eCogelc59O84jujzU2sikskxH
 wYM/ZLpOEFRVXlxjrSTjgQDRkZTlGwTQ+9TSblEXGL0FdARMKwjGirZH89JoLn0Orex7
 ZCWWJlVjmtE7aiMCvtPUK6RrtwDge8w03y5ltxJEHu4W9iIO9+4tSQkjw1QIX+SS+Uln
 t+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yIlOi3GvmMMMfuQOoGINci7ZSHQ3MWoTeVsquJCwIds=;
 fh=Ka/N13XSlqAN8mpqWOWPAvIrH2A6rBxVZCu4d4o5yGY=;
 b=FXEDcUQqkzp+FkOfoR9+LvGPICtlxjU13Rbe0ITpaWYf66GNA2tLz20L3pKgGZWSon
 960Fl1dOGmAbc35MDI8XA/YArNE9G5DXSMTY/Xx6EhJK4RBsbPzbq5ji3b9fFroH79ZU
 agLq6ReyCXkaFNLIwT8mNmgitvPR0oddyOjiPWS24Yhbux0rKxpTZWKQnTDkRgfs0YLt
 g/HTj6mYDjfiRV+Tj/Mv0vyP4WfCjN2UnhC0oMSUX5mkiWnBEI5PmUALVtvEugr/EYOP
 qU53Pv1im8LARLF9gW8cscKxe7gLHotaUiCi4dWOVhJgq9msL5V6/qULFSM/WGX3BEUx
 v9vw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776071098; x=1776675898; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yIlOi3GvmMMMfuQOoGINci7ZSHQ3MWoTeVsquJCwIds=;
 b=pCTxhGdCVY0vxSX3shNJXysbJbHwqktL81pJPsG09s4j8Fh7+adrITdT4r0kEz5Ih8
 Kj1HCrl86oED/w3FgCbSclR0l0LAXJJ6jSMqcK4zH+4heIbG+KFokgbXTpjN7YdW84Dw
 D0+CkSFhvjJ+X26Ed7vEQBMQ08KEhZR4vHOv/ltOYrNjc3C3yVoHSgW4PfeNC3GfNwU4
 7YpDdr42jpUhaFa3RT96NCMUcdkLNsbZGOnPVnsNV+A24Dg5zJigNWk918ovNm8TOq/+
 CihlUVh7e51ZluaEYJWqRBtTubhqb6PQ1S42qhhNVnbs3lGdGoG7kl8crEgK0IsLiRHM
 py4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776071098; x=1776675898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIlOi3GvmMMMfuQOoGINci7ZSHQ3MWoTeVsquJCwIds=;
 b=IVGRZA1jYaX4xEkybu9DKpVT9aedNjVANyUvEaRC0nU9CRJqsMIsoxQVS6OtkRlPlQ
 WE7pAdv45fU6G5VCXefYzlzLhRoUZ+wDe1yxXdId0TB+SYEfwfYclfCNiCzzCCmbBCPk
 mijUBAIjM/jaaANegevkzR7sVUqDaxFVhNU2ZtrtunVyS4tWtPAMTV+D6q7ud8Qn97q4
 0HXUmdfi3wfLTmp0Q2183biB/uJjifsPsVRAeU8WR5Zck94RGdTnVnPlAEFUvBF9WPqJ
 wudktbcV6rtNCC3ukSkl92NJLUaax4GgzFNbvTcCjLsRotmgLVA7uuAT2GKMXTruAb3t
 dweg==
X-Gm-Message-State: AOJu0Yy0He639e/8B20SN/GYII8wbOjHCy70Ls+8wimI0zf6sZqTLTYh
 //0srC019ERfqbAGupeWKz9AEmVT1Xib7WWLcFk9jZOASRJByDEL1mFNKaZd8VlwshLtKpUwLhK
 aSZrUmNMqti38f/CwKaAokazt19H6BeIvBhKjFlLdXcdM
X-Gm-Gg: AeBDiesdE+nkpxzhGwFLQYXNPVb5Q1n1T41+g2ZEP57HA5nE8cqznESM9FdQ6SHhL5J
 QN3Z/wcvQPTwOPycWAR2QYSpzWfneoFS8Ddw3HMGE/UjXD2BEW8ZVID0h+k9dG9pIh4soTdM3ZS
 G+tGtLZYBPPU9AjsmqLkA5v/FAGMNjwQtNQ9F+4qWDtH+UQgD29LiHz9DsLFUZ1UdSSGvEnety5
 OXfK9OFMvjq+yIuf4PKPkB+naSlrjAWl4qEmGpsOAq2gT6XtTBaovMw1BdVoslLhV0gizDjYc3b
 APYChvs=
X-Received: by 2002:a2e:9fcb:0:b0:385:9b50:91a8 with SMTP id
 38308e7fff4ca-38e4beea127mr40028001fa.15.1776071097626; Mon, 13 Apr 2026
 02:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260410175031.16921-1-always.starving0@gmail.com>
In-Reply-To: <20260410175031.16921-1-always.starving0@gmail.com>
From: Li Wang <wangli.ahau@gmail.com>
Date: Mon, 13 Apr 2026 17:04:45 +0800
X-Gm-Features: AQROBzAbC2D7y_uNmpwGOAf-rfHY3OZuCsrrLtBWNesGecrLqNAK7WyT1cbq418
Message-ID: <CAE1O6miFju1u4-yJd2zV5Kx1A=97kqpWu=L7onNSVF0Req+neg@mail.gmail.com>
To: Jinseok Kim <always.starving0@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] include/lapi: add leaf Makefile
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Jinseok Kim <always.starving0@gmail.com> wrote:

> Fixes : https://github.com/linux-test-project/ltp/issues/1262
>
> include/lapi and include/lapi/syscalls lack Makefiles, so 'make check'
> does not work in these directories. Add minimal leaf Makefiles.
>
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>

Reviewed-by: Li Wang <wangli.ahau@gmail.com>

-- 
Regards,
Li Wang
Email: wangli.ahau@gmail.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
