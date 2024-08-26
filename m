Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86555C5321D
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 07:45:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C6EF3D2706
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 09:45:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E5AC3D2706
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 09:45:15 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 84618600799
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 09:45:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724658312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tp40pYGWhydw/08Vv8tZASyY9RDojkVb2SIdCXlBFnY=;
 b=fuYhZfsAayE7CCIfS0YpYsvvopIt0spLCnv++IpEpQ9pURxt/B/herMSbmi8QJCIHu0gN5
 /9qB7oJw1ZO/4Sr3AcyQvwEt8ylWUcRxvpWlEIX7JMkjPUJEg8CoXEFk9SPue2dV1txSXK
 gEWNjdt6q2HAxnqyv9zrdZqalJSoM98=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-8uWwd9ZfPLy36mAljvL83g-1; Mon, 26 Aug 2024 03:45:08 -0400
X-MC-Unique: 8uWwd9ZfPLy36mAljvL83g-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-6818fa37eecso4302570a12.1
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 00:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724658307; x=1725263107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tp40pYGWhydw/08Vv8tZASyY9RDojkVb2SIdCXlBFnY=;
 b=rTXAuMNhoJou99twybZNdOyf6/YzH/zW6fdr4BEUwPmjMhfHPN4m/Qfr1212nt3Qvl
 9zX1xQnHjB70p1DrG26fxvF/PVFwemWSKCOq83wAd6ppkKurkk4zeN4UmXWttCAHj0EQ
 UzaNngW4LJiTlMbw5GBYMuEmwQfgutFdkUbJvbP0q6hdZ6SReDQ9FzIGPVP2rA+p9EZE
 r/euBCUvxv8aDMO/wgqs51rEQgzoE2mVMdGJevLPQwa1JKyGsA11/r/ampyvGz6aqwAh
 8mr21R7ciT3LLE4Tiq3WLwHiekzu8OeZZZ5UTeG/iRRkwXwYESuAxBw0t/C3aijqOCNF
 5lPg==
X-Gm-Message-State: AOJu0YwqujQ5ESReGKOUNlQG16akEAcF2aA3vmsgknf03y0l1aLtZHza
 zcScTRWxlP/1vDY44BPUdm6SDGNjDI1WXLpY+lLbXrXV/sgaHdL5Ua4Gh0EN2f/GeEbZSGSlCoZ
 WVLBiYJOAF4C6gECaL1bTB6iAxqffX6i4XMu8+KJWzogzNTPQ6kAhbQ+TjMpnaBhMAYahIZ9RQO
 r44sytz83lVqxra8VTqAChdlM=
X-Received: by 2002:a05:6a20:e18a:b0:1c6:fc54:4d7e with SMTP id
 adf61e73a8af0-1cc8a079bfamr11471751637.48.1724658307653; 
 Mon, 26 Aug 2024 00:45:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+gsuZQNGuaXSMXZ3Fb4f0/n39vI1009/7SvfF6x0goNMTkVbY/ii75mDyHchmxf13KRkfGO7A72tZRmxWYjc=
X-Received: by 2002:a05:6a20:e18a:b0:1c6:fc54:4d7e with SMTP id
 adf61e73a8af0-1cc8a079bfamr11471731637.48.1724658307111; Mon, 26 Aug 2024
 00:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240823114217.1261861-1-pvorel@suse.cz>
 <20240823114217.1261861-4-pvorel@suse.cz>
In-Reply-To: <20240823114217.1261861-4-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Aug 2024 15:44:55 +0800
Message-ID: <CAEemH2d8phkUyrWFYALbkAMu3ypBZ+LMUi9oRL_gRzbPv1vcvw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 3/3] ci/debian.sh: Make dependencies really minimal
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

For series:
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
