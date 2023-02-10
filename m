Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9131C636CD
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 06:11:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3987F3CC076
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 07:11:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD9373C304A
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 07:11:00 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6E9776007A0
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 07:10:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676009457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YYqQm9cJRWpGzXFSdHLlCTR2kKulOAMtZYcDpMPOuQI=;
 b=DGgaoHioCOh92v2DnwCnTHh10kaXH49kyVq015ztHRYOtPACDmL8pnmOtfU3BpbbjisAaD
 VqHGoI6ilc+KjCOjCFa0WBuz46XQcCN8KkJ9r8wPIbq6lt5Itg+VIv/YCgYHbPZi8Y5BPt
 mxBrK9xURFcDUlFOTuHApzEE7TKYQZk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-417-Txf7B3dAOr2yDE7nnlladg-1; Fri, 10 Feb 2023 01:10:56 -0500
X-MC-Unique: Txf7B3dAOr2yDE7nnlladg-1
Received: by mail-wm1-f70.google.com with SMTP id
 h2-20020a1ccc02000000b003db1ded176dso2060126wmb.5
 for <ltp@lists.linux.it>; Thu, 09 Feb 2023 22:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YYqQm9cJRWpGzXFSdHLlCTR2kKulOAMtZYcDpMPOuQI=;
 b=F8VGHSKhMk8tgA1wLC57G4cwbXPmGN0ivhf0EUyq9BOpzvNbl9yqaBeamTd4gds/ik
 777otjTxMrf1OpFuThv1SW/C37eaJmn0BU2GGltFmWbSR0U3+voHPHl5rhjIBeilYzq+
 o+yXi4V/6h8VHbfUM/f95rlJHv4FD0Zfq3iKSVq6VxrNAymi36Xx8WKw6kSGKKTPrlMj
 swhjPrtdR1LfAVnK4PZCY6vkxdRfkM8HlQYhuYXAVVNOE7Iw2Wi7ZqIfTeaovkaC8hh9
 YVjvqk77UZtdfUGNYRtaB8ZsWTy5qixp5PaJULbyghdwhBcGFiHnqpc5usCuamj3myNw
 qmOw==
X-Gm-Message-State: AO0yUKWoMC1xfX0KOw5VXlReC8/N4z7mtnw+wfNwScWLBdrkaasXHj2R
 TCo00L2gcmH8ei+OZk92a0tFtjCxw85gF4b+KUIa8PAnj8R2szhDakueTEoVss6CIL9YTnN1jPB
 uVLeiHwu9qGF0eRgGbCmssTZwgV+PWmWQ3rMO9M3S
X-Received: by 2002:a5d:40c7:0:b0:2c4:ee3d:8c05 with SMTP id
 b7-20020a5d40c7000000b002c4ee3d8c05mr215760wrq.707.1676009454598; 
 Thu, 09 Feb 2023 22:10:54 -0800 (PST)
X-Google-Smtp-Source: AK7set+mrCe6RQezSCQvu29IXjorV7uYGi7xpig9cjn7TldjxQ3IY14aqna5U4JbEar6SUi3E41OZQjTPG48zPHAMl8=
X-Received: by 2002:a5d:40c7:0:b0:2c4:ee3d:8c05 with SMTP id
 b7-20020a5d40c7000000b002c4ee3d8c05mr215759wrq.707.1676009454368; Thu, 09 Feb
 2023 22:10:54 -0800 (PST)
MIME-Version: 1.0
References: <0328e9f247cfb76b27b68e9592bfb1954ddfe2b2.80b5c6e1.08b5.4363.8caf.668693c771f5@feishu.cn>
 <0328e9f247cfb76b27b68e9592bfb1954ddfe2b2.a192d563.9c88.4b19.a161.eca7160d4e8b@feishu.cn>
In-Reply-To: <0328e9f247cfb76b27b68e9592bfb1954ddfe2b2.a192d563.9c88.4b19.a161.eca7160d4e8b@feishu.cn>
From: Li Wang <liwang@redhat.com>
Date: Fri, 10 Feb 2023 14:10:43 +0800
Message-ID: <CAEemH2d_iF=2bfhJhgUN9MbF3HELCC+qOQ2s=9tjaXkyA3x3gg@mail.gmail.com>
To: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] Add ioctl_loop08 test for LOOP_GET_STATUS
 lock imbalance
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
Cc: ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Shouyi,

I can't read your patch contents, could you make sure to
send a patch in the recommended way:

# git format-patch -1
# git send-email 0001-xxxx --to ltp@lists.linux.it


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
