Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05E3C79F89
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 06:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788762802; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=CdYzd5R+GBEXViwG9kognkqySnNpFPMN8i29YRhRJ/XEhIz8TLahOhQDeY7B+ajgfjDxw
 ZdNOQmrm7NkYi1ex05FPU+iXpJqR2MrLgDNSJEWPLSDGfyvE/qe8ZgcW9rK0oHXcunSvb0l
 pSA53JulCQU9oUJmoJ/H5zlHc0+3iLQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D3963E5355
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 08:33:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 404BD3E5249
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 08:32:48 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F3B0F100060C
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 08:32:47 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-484392e3d33so2130148f8f.2
 for <ltp@lists.linux.it>; Sun, 06 Sep 2026 23:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788762767; x=1789367567; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=YTyAzWmf4XkOnNuVmVJUlsQxqe8AFBvy6FX3o38KaSqQYJmlHxF9IJgrruToRqHUpt
 vQOkGbM0vS1qPjXUYX9zxRn5tRdhx9ml4epYoSKxNLL5iXi3bJ3JkTCUu9UYh2I2CAJB
 snI7VtAuY+bZ9wWImIAL51whmRB4AcDVZAqxMf7Z1Qk/pz5zbUL1rj2565C/nbtK9+6G
 x5O8djIyfKR7C/6GxJ9y0Qu53gJFEfr4UGGbZgP64fuHR6wmv9lh/9F4m8QqI3AjIdW5
 UgLhxqHaQtEiupcLjHCYnTN9PXa9fBsbaEkOtV2sO2/mWPgYc7yZj4NhpNlr4mOpvhy9
 rjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788762767; x=1789367567;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=lshx18R5N2/M6wR8Ny4E97XqNfdbNUPiu1472Huh6GJR5yEqquIB3OJEqRiEuFklON
 nJHuxzOZdBeOyU+i8bC7opl99s9pCYUdpFz2xnYTX5E7B050n3tADGoZhjp+b7OpFyhv
 +1ErJCUKvD9goNrisefkJyShP7iql0XD5aduuDJLnIcYpE4TP9HAeGcrADHWFSl4uKrV
 4t874f1iot4JxFM7pz0gByA8Vuw9GiuJhGxHbnSRQTKEc32ndOaSoRv42SsNBaEEtZdp
 7T6cqIBmh2OsNV0lAaTs5eyxt6R0QiQGqeHHeh4nE7FXlCB5rmJMuGiaI3uxCE9irD7E
 ja1g==
X-Gm-Message-State: AFuF++nvuZnSdnMcqx5RfUVGwobDg6upKlJAVXN6jgATZIdczmaGOV0J
 6m7aJ2Vdc4SoGM6JdpAehRXT7emL3jl6C8H5LveyuUwRXLVPjF5cujfQ3q2S0N79fMm9Tvo4pyu
 rTFBmKHfo7Q==
X-Gm-Gg: AYBFou2RFSeoUzsmxhneRxJPv4YANObD66mBBASN07EZszZ2w18+CHNoPbKTHDOzZMB
 vEtgbiqTDe1/CjYbOGCUi5RL5qT8zTfox/XtMxQo6dprj64Em5japlT1RAP65ebSXX6D0p3/uWE
 O4Z/NSNFqK1G7EBL9S7JtpYEsolS4y6Z/4HmfmCP9dO4MJ1xRqkOJn6vIaIUWlyahD2DIHDF3BW
 KH3fBhbyiF5lo5XLe4Rem2ZSvb8/IvhrIbM01qmsIGocv6dNnpPaiBggyooGE1Wph1cDLQNo21w
 XDksUTZlj897zZy8+oW7oJ+O2wzfqNlvJZr2Q5sCWwy4ZWLUQhrd3BPynjkRZQgHU6gpXyADAaC
 Y5mOXrRGU4Np064IoFC2X11XED1p3E6hkSYlThFvDYjygEce6NMKpJlG4bfui3Uep9CSK2Cf/l/
 6ziRICXqtkjQT0yTmuylaOR3pfi4402M+c9uq54Z4grBKh9MdyC2RqtwdMVI+pbJ4TzhDF72gWI
 H5GmzD2ccPxXfs5NYBWzrrE7thCmLrQUTuNMirvXauuSGlgPvkSL6PwFrD1QMuReSucBQQ=
X-Received: by 2002:a05:6000:26c2:b0:485:9a53:9145 with SMTP id
 ffacd0b85a97d-4859a539201mr5673049f8f.40.1788762767349; 
 Sun, 06 Sep 2026 23:32:47 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48594172546sm17414365f8f.15.2026.09.06.23.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:32:47 -0700 (PDT)
Message-ID: <6a9e5a8f.6a211794.8262c.330d@mx.google.com>
To: "Victor Cheng-Yen Yang" <cyyang772@andestech.com>
In-Reply-To: <20260907014516.450196-2-cyyang772@andestech.com>
Date: Mon, 07 Sep 2026 06:32:46 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] hugemmap24: Restrict the 1TB slice layout to
 64-bit powerpc
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
