Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9CFC8302F
	for <ltp@archiver.kernel.org>; Tue,  1 Jul 2025 09:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751363399; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=a4MqL+aeV5ea7rKV5RDJZHfnwA7O6rsGPZGBim1IjPg=;
 b=NVMilnEhYJ2bxxhI84LCEWIO6O36d1bk0hHOm6HKAjkv72zwMhnrZQhmCZw8L1J9XJL8s
 FTu1UQ44QG9KXZzIFABYrqq1co9Oh0yc2OQUB/MvDDCorO4x8P2pj+t5mKbZHdC5wOEL4ec
 WWxBvOif32VVEJ9UbuvLJUySfZnVNy0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F7003C74D3
	for <ltp@archiver.kernel.org>; Tue,  1 Jul 2025 11:49:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 272AD3C6DDB
 for <ltp@lists.linux.it>; Tue,  1 Jul 2025 11:49:35 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 01E071400F45
 for <ltp@lists.linux.it>; Tue,  1 Jul 2025 11:49:34 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so22149925e9.2
 for <ltp@lists.linux.it>; Tue, 01 Jul 2025 02:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751363374; x=1751968174; darn=lists.linux.it;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLfNCmXYq1Nr2IpT53GuJfeMLIatqagCTEn2IDFDdbg=;
 b=aepXLsDfh2lGVu5ASZcf1pLS/48/1gGMjQrrhH3IfDQOsuGX705Q8RFq72nYzaEagX
 F7ieCy5Qz4TUoB2WDzZEyYV9n5O9MRRiS5RpBzQxA5jpVy9Bgt/oFgGfyFK9ZrMfloEf
 fk0ifrDsKY2ZRgVH6t61rmwywUd2I2XCLrikl6SIhVqOiTRJJLwSrDSJpc8xpUz16Khh
 +1BMbZbMDUDwcDXkTo9uURte2qysLEOij9z+KuSz1BKtljBwR47RtDyJ2i3Vohhrooi3
 f/6bNn20G3UXJd1SeVMnQ96fTm7RUkEHPxdiobRSTTgYkwppYq+fq5mJurlqYGC4SxXD
 8I2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751363374; x=1751968174;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gLfNCmXYq1Nr2IpT53GuJfeMLIatqagCTEn2IDFDdbg=;
 b=Or7r5pQB2MWiEton8y8ECJDSpLVStnwlZtp7lUbTMzr5KFcSp+1OmFfeM345S5WqRk
 CCHYdrFIT3oehLwKSUlU8D8lfx43mlPduL3iZy9caLyreT/WcO+mLvPYb3D6LifrjDRY
 lDBQVmvmrj5yRbQIV04H4soaMIxJgnD6K6oAKgEmQi0Zwj1EMBHAxAGN61tE31lUzAa0
 g5lwbuOjGDttNir2+0jEmRAHAtDm86OqNh/HEwHuVhvMrD6kWLYVd2M6hXWX6zl9J4Ub
 Sna9JaZPY0jemrAxK06bZdeskdodkT9eDpTbaUWfq1gu88NiBRVzFHzVQQqnQBfCkmSP
 mJ0g==
X-Gm-Message-State: AOJu0YwM/0lCnUxDeTPFfprMnrz7FB5ef5XqqRnvqX0JcuNrSbTQtoo+
 ywx2oxEuyrwpohKs4sljen22Q1SKdS6T1uz4j17Wvf122zGR/TY0yukLgHa0EQ+Aqe4=
X-Gm-Gg: ASbGnctJayvIshQRVkkfE+QDaDUgSyyYdTydZMjQDJUTgjVjH6z8WbC6nZZKVWP4cR8
 RvLx2wZ/U7hDFUI/G7Y1W2J5YvHMGMycl/H2/rWjtwgBhedOOHqFe9LWWA1XizbGCAqzzCQg3qW
 LhRPIatRFAgr2aqgM58WMcrt2OD67POEBCqn0UNQMJUZL62s2suwu688i3icVUi6N/ViGDLy2jX
 gzm/QDSZDCquXp4m3SvE9ZY3Rr/aL3eMgscuhAVnTP/zobfkm//6Riz9iNv92mNK47HL79JusiP
 rX/WRewNj1rwetKsoEs/7fYJW6uDjFK9jp3f+J8EaKQKEWbgLTEd8I+JtPBQ
X-Google-Smtp-Source: AGHT+IG4W4jnYcBUVPAGZ4mzbNkFCvJYumIszn6RxTkF/9BGhUoMeMDMOtU5W9hS05GtlDMMVSWhGQ==
X-Received: by 2002:a05:6000:2082:b0:3a4:f8fa:9c94 with SMTP id
 ffacd0b85a97d-3a8f482c971mr14538865f8f.13.1751363374252; 
 Tue, 01 Jul 2025 02:49:34 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 6a1803df08f44-6fd772e34besm80581476d6.75.2025.07.01.02.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 02:49:33 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 01 Jul 2025 06:49:28 -0300
Message-Id: <DB0MI07GMSJY.25OY7MTPT0W29@suse.com>
To: "Li Wang" <liwang@redhat.com>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?=
 <rbm@suse.com>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250630-conversions-shmt-v2-0-6bb1bf315cce@suse.com>
 <CAEemH2d2zv+L=K6Mv2AEWcyOyb=R+-WOQ-50f_NYxHuac4SNWg@mail.gmail.com>
In-Reply-To: <CAEemH2d2zv+L=K6Mv2AEWcyOyb=R+-WOQ-50f_NYxHuac4SNWg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/9] mem: shmt: Convert to new API
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue Jul 1, 2025 at 12:19 AM -03, Li Wang wrote:
> Patchset merged with minor adjustments(code format), thanks!

Thank you, Li!

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
