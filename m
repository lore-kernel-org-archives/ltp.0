Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82303C27C6E
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 05:40:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A2973D0D0D
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 07:40:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52E163D0988
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 07:40:43 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A8CFB1400DB0
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 07:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718602841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KftTdnjIWxXdnAjkBq9WgmjBUwYq19JUrNfEtkGVv2A=;
 b=bnX27bXP8oTwzD/hyv00nJezwWO0a0XRLcd/G1ocoo4i5+eJLDUod4II10gpzt9PVcrdFg
 l1jiukTi1sk153OOANzdWSrOnMeo1fu7v2W7icGTazRQVV5qFw6/daw6yYv/CLdgei2P1A
 CKWsF4ECTNj7KLuAwFW3N62HVNhm3Jw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-ozLlU46EPiy_jX5MJKfWtQ-1; Mon, 17 Jun 2024 01:40:34 -0400
X-MC-Unique: ozLlU46EPiy_jX5MJKfWtQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c2dd7fb263so4356265a91.0
 for <ltp@lists.linux.it>; Sun, 16 Jun 2024 22:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718602832; x=1719207632;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KftTdnjIWxXdnAjkBq9WgmjBUwYq19JUrNfEtkGVv2A=;
 b=GI3S40F0jIy+Dw93DVKPPK+I8U8dJGlc/5o+2z5Bc8v8P22nm2tOH4UexLFrhw9IWm
 7gfFXM62DH4uePu49DFoBWehTEWpnMFmHyXC7SN3JOpKk1Ku6slnLpP+qNXlGSUP3NwM
 OJgFFXrxdqyTQJo+161WR4TSlWXaRSO51UlM5P5VRwfTEiMYe3KvlCDEKSoE3x4SZPpS
 pBv5JbcafV0o68NPVRh5ch2CyAp6x+G3LwojuRa11Y0uBCFcYGFhUSpfmWyQ7UBJxfnS
 c5yYLLaugqg7UPQrYDnWuW7OL5ZasV/yOyjdxRaDz6Dt+sy2ejx74eBVvI4gXs06Xdhf
 9oMQ==
X-Gm-Message-State: AOJu0YyNuJocFuc7GZBYatmqSYHRuloNFxUil7hL9iDbGKeEmbaiJ40c
 1IMKIutbytc8YvtceWulaOvkx9mfWFagl4xieKDgmrM1NEmh9fX4Z+HqSu0MqcU0C7YBBpX8rh/
 nYYAhrqai2k9ST5kvLBGaBPHgp5wMN1OJj8zry1zaNiyrwczZe7oC+Tw4u7/unk7LDrXN2Capew
 9/Rhkdk2wLtB3sYeErspzW/HCMoLSrHL96b0EF
X-Received: by 2002:a17:90a:fd97:b0:2c5:24a0:adcc with SMTP id
 98e67ed59e1d1-2c524a0bd2amr1957209a91.38.1718602831857; 
 Sun, 16 Jun 2024 22:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyEGxHKb931Sh5SRBhatszDtqL0zobXDT7V/qroNqBSs07Pg1Vrgi6yDAoR8Gs9KnYFx0vc8Ub4UVCtKyrqTE=
X-Received: by 2002:a17:90a:fd97:b0:2c5:24a0:adcc with SMTP id
 98e67ed59e1d1-2c524a0bd2amr1957199a91.38.1718602831404; Sun, 16 Jun 2024
 22:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240617053436.301336-1-liwang@redhat.com>
In-Reply-To: <20240617053436.301336-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Jun 2024 13:40:19 +0800
Message-ID: <CAEemH2c=Z4pSVp6CAJ5DTgr36d+MgUtLvzxXvsqX9syR+fBR6g@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] configure.ac: Add _GNU_SOURCE for struct
 fs_quota_statv check
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CI runs for the above four patches:
  https://github.com/wangli5665/ltp/actions/runs/9542345839/

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
