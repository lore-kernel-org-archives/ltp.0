Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81015CA9ED0
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791806049; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=kYEoiGLgbh7GT/vMHTm0FuRc0FPwOQyjsLLBadjTYh72dk4SxshoGYds6S5z41qnj7xWg
 zcvPLS/2L+m+9bMWWEM1/yw9aZN47etysIpGkZsJYS45G8feI2c5uTTES7RivTkMlc6sQTP
 SeUfaotEikyC74VQJW6ytpkEFZgze8E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60ABF3E49D4
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 13:54:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BF623E49D4
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 13:53:49 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 573B11000553
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 13:53:49 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so1016737f8f.2
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 04:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791806029; x=1792410829; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=dGj4DHlw0j0jOHVnjLVhnVJlOuJv7tZzPP8Xmj23eyD8bxZqmjJUFZ+nq3PD/q2pwV
 cUveGr/J9gthdff/OqtopYQprs5A3nGFejRkK4MpmW+uEfNrFI6h4HM/vJfQpNXQ7/JE
 FhALAsPrChLm0MqrMaMZondbSCSRL28qXG6u5vqElD8SJs6SwKJy1IsbDMHA640MXDws
 84MJ68DpNLIvlo4VRJL3owXioNDQwN06tYo6b7ehAzwu7LzwcDPq6o7gh2TDh8G4CK3t
 WD03a7E9jE+4r1wRk9KG9QV+CWs9ydBVppumtgihMhFHOhfPliKo5jEvhGg38xdjmab9
 wYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791806029; x=1792410829;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=m06U4hipZKxHB6mQS8+FPXm9bRi47Zrle7yJxl/lnoCPeCZHTt1EJT/3DftuKqBXNP
 pZYELp4HHcUomP8Ic+ARAos/POgwZJgMe+wkwQVthvlqOh2dnqGJL5KLNKUVC3F0jbtz
 g5WUkAcPaAnangJoUJezB5QuBAMAzxs29M+WZWdy+HaFM0qecEQ3BcYZMhFTwocQbGtl
 eKVBEsmfLrWKwFD9JLp2FgwbV9Y0Qi+CkmuUpGBNBbD1eOKDruceYOesSo6m9bxwoY++
 5Pg6N2sXQVXBNWGqtn9bW2znnkKrHta3TLHAlMK67dQWh5lAUoBHv1d5dJc6eNdPabCm
 nMLg==
X-Gm-Message-State: AFq9FYJHdHlfI69FcsqwSFFvae3q9flERTEVTK+WgksewLA8PAe7NoWR
 KY3CPkGiLstq50X2ac3dUCmKbY8DDMJczIxsfNIcI573SVIKip3DV2wLqZMHt/vF1EBxrEo+37I
 xFAwHp23E4vjc
X-Gm-Gg: AYBFou0lENsvQKmbhPBQrCT9RmqyuVyRd1ALiVeSA4kIrpunKrBqvX+HGHFSlZkKLre
 b54Yojor5cVjK22WfMwT1aae0kPym6x7P8/QiEGKwwky4zMel3xZ6jgDuPOg3/5Uwp2cwC+nIJq
 5MpIyaL/m+/BVnvZxBzeXMOJ/2CC0JSxaIviO1EWCESIb4aRvy1Ij/5gTJz5wBkHqzsAaM0DcFO
 qSDyDflTj94ruMYvQEwgUl6bv/SfRoyYlmQPe2zXzxgMQp8GIdqQn23FSj2jyrAPMl8iIo23ZuQ
 /i1A2j8jbI1Gpcr7oj31Qj4N93t3w8nTHxe5BkY9hQVCtkRM8CyQjCuA068dRN246Q+2avr0KUY
 uYpqj0NWROBWsMACALi0Jky6CJQ0Ev5RQUFn6Uzb1M8Qn2sIFP358XwuTyQ+qdhmERR4KtL1ng1
 NXN0ZtC0enP7x5FJIDz556TaKP1eaEy20dMrDV9JnVkVq6nCBBJsLmWDzm/HdmyGgKcUKdo2PNe
 fNHhWtgZwgIrlPqXWmLwDty+joZ53Wy2+UUW/ssc/qJtPgsUZ9lG11ez+G2M1FhTT2Vx48L/cPc
 Mg==
X-Received: by 2002:a05:6000:989:b0:48d:b650:69aa with SMTP id
 ffacd0b85a97d-48dbacf596fmr16008915f8f.50.1791806028644; 
 Mon, 12 Oct 2026 04:53:48 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9ad56a6sm17957344f8f.52.2026.10.12.04.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:53:48 -0700 (PDT)
Message-ID: <qzBOSSBHumfued2kRkDXY6qAlAcWsj71GKKD@localhost.localdomain>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20261002130556.1236937-1-wakel@google.com>
Date: Mon, 12 Oct 2026 11:53:47 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/procfs.h: Add elf_prstatus and elf_prpsinfo
 fallbacks
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
