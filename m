Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA9FD690E2
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 07:50:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52E8A3DBAB8
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 08:50:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB2313DBAA1
 for <ltp@lists.linux.it>; Thu, 28 Nov 2024 08:50:00 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5044163583F
 for <ltp@lists.linux.it>; Thu, 28 Nov 2024 08:49:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732780198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YxGtKmSAEWck7d6puwjdFlG6iMYUuMFwM+QvZkWU0Fw=;
 b=jDhhEddmkzPZPnvbkJ7np3klFDxGk2RLfNHVpuCGATkB4CJ23boD+PcXnp5DxNGgMn1myq
 sz3VtJxah6qblogI8Wk9ClW0+TjAj82mwEFRnmnV+38NYqbIpbwEMoGZwEMdoMe0eO/cMk
 WvNx9fJwp91TFqJORcrY9KzYTGJzrjU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-VdrYUIkSNyigCbHMonLR5A-1; Thu, 28 Nov 2024 02:49:55 -0500
X-MC-Unique: VdrYUIkSNyigCbHMonLR5A-1
X-Mimecast-MFC-AGG-ID: VdrYUIkSNyigCbHMonLR5A
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2eaadc7c431so866028a91.0
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 23:49:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732780193; x=1733384993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YxGtKmSAEWck7d6puwjdFlG6iMYUuMFwM+QvZkWU0Fw=;
 b=pgYiq+cFZBzOQVACDOXsa4ZogTIHsQnfrfQ+Z0IcDhz0/dcJSlDixLYSbXEzRsqX4p
 lguFVWXZvJKkirzSlhjuESqc0ysGrfZ0CxKOWdWriyUrQaQKpsmyNRq2WM/SZmqHr2WX
 4zBQn9jeSln5AKQhYgB6rdqw54n1Z9UvBQhZoPMldjN+8lonINVb0JL6cBaYTLb435Tj
 CcjOSuh+GgPLIERgi1f+D6w+7HipyDNoYJu3jz4DlI+E4a57Oz8Vk5J96mqSqHXkA7ZB
 S5BPXPyjwl/Bb54udWneNMroCdCXwXAquyAwwp8Tjnjbtqj77NebvgW9fRvPmRbxOvmm
 0hgw==
X-Gm-Message-State: AOJu0YzY4kvZq/603klh3Va3DFm8JiJoGzYs/+2p/hJ7Dytb+SnjdQ93
 CNvDDd2+qq2Mr8Lwk1lKgQtlV4J38fVsqdYvL87v10ckzym2K/WfPNq0YLA6Q/2/L9eAqjZw476
 NrsSfoiMEvgDSdVQM9SSyo1w8lHtovYMrs6JyHwa1s8ONeC0qGfYxthdBD/Awdf/MBC2C7pCJB7
 rmkekUashckHhrYhyJOZW92iuwOjM5JvRC2xjM
X-Gm-Gg: ASbGncsa51ipW1lOM5/8PND3czlpKfZlckgv+BvHU5SdfWuUY4LR36Pmb0k9KKxyCWz
 8gIpyPYA73tiwM/pTp2kygM33Bk2Dww5J
X-Received: by 2002:a17:90b:3c12:b0:2e0:7b2b:f76 with SMTP id
 98e67ed59e1d1-2ee08ecf438mr7841563a91.19.1732780193323; 
 Wed, 27 Nov 2024 23:49:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIUp/1g2B0KeLYiTfABjvhwicXm2sFcaoNdERda/P/aULPndrydVxB48dx/BoUd0oZ1EPgjSMbY9My14K6JQo=
X-Received: by 2002:a17:90b:3c12:b0:2e0:7b2b:f76 with SMTP id
 98e67ed59e1d1-2ee08ecf438mr7841554a91.19.1732780193065; Wed, 27 Nov 2024
 23:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20241125-input_refactoring-v1-0-b622b3aa698d@suse.com>
 <20241125-input_refactoring-v1-2-b622b3aa698d@suse.com>
In-Reply-To: <20241125-input_refactoring-v1-2-b622b3aa698d@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 28 Nov 2024 15:49:40 +0800
Message-ID: <CAEemH2eK6C1QSF-jfiAQbfaOL44f=Bi9o2z8OLdzFvQ+7SeU+Q@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 82MXIVU5U0u1PqaaaSu-4ncqeHXhLGW3KxzY0NW3JHU_1732780194
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/7] Refactor input02 test
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

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
