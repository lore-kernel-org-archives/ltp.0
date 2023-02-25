Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18915C7EE23
	for <ltp@archiver.kernel.org>; Sat, 25 Feb 2023 08:04:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F2383CBAD8
	for <ltp@archiver.kernel.org>; Sat, 25 Feb 2023 09:04:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B27F73CB036
 for <ltp@lists.linux.it>; Sat, 25 Feb 2023 09:04:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8FA3F6001B8
 for <ltp@lists.linux.it>; Sat, 25 Feb 2023 09:04:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677312259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qxUcRR47Gh3Wjtx983u/NXeFiFsbsraCVWKmys3sz+g=;
 b=Bi5t77LrpDzgL7iRbGi4RGzpQ0pio8prNnfjYUi0ucv8L3VUGb9AJESEiHt16EmUKI8hIx
 VBwbfAYah1gHt0Z1VcRphYRakjg9U6QDfCuib53s2/azbMihPOUR3aJBlvSeUZymd5Dzpz
 j+EbClUOkjK0jD59TFK49GLcPCPV5P0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-601-FXbVsQEaPzeI8OObphPCVQ-1; Sat, 25 Feb 2023 03:04:17 -0500
X-MC-Unique: FXbVsQEaPzeI8OObphPCVQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 m28-20020a05600c3b1c00b003e7d4662b83so2370190wms.0
 for <ltp@lists.linux.it>; Sat, 25 Feb 2023 00:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qxUcRR47Gh3Wjtx983u/NXeFiFsbsraCVWKmys3sz+g=;
 b=wQT58gpyvMt9ErEfCOHhlT7wiM+2JzMZOybD7+HAI60iEzSoJGHqzGaXBfAfaiWt9X
 dtElpkDcqu8SDyk9eB4WWWJRKBEWsyzAH1jj6P1Zj1+sco8C1Cu/V0gGtSEYapwJYrNp
 T8DKUSbwCblN2q5j4OR2QegC69V0bM02ueAtBHVaxqpmC8p9CfWn+TAxkaX+MKJsClJo
 EfTmgXsPC0MDZMJrx6j9KLDJIY38xypgVEW3zqcNTxmnE8/XWZ21pXwWWqslFiMi6nK2
 QUXaa9Onur3BVJ49KfIB/77khK6TlVvrUZEKGRYmZlfaVQQY4V8a6rJ516Q1UJ1MWrB6
 sIYA==
X-Gm-Message-State: AO0yUKWcwFJmPxSggiH7Npx4yjh7gmjhYA/FwOvZWU9FKFp0qs5SOvO8
 bizQwNy18bc68Ppa+U2VyGgKmwr7vihxdERUywI5QOL7RlSFutHusD1DkhjsB4qRvLPJpQ9yfN0
 3vIO45o3OQKYKVJX8CBi6FNxVz2GTfT9DNco=
X-Received: by 2002:a5d:45c4:0:b0:2c9:bb13:2122 with SMTP id
 b4-20020a5d45c4000000b002c9bb132122mr41280wrs.8.1677312255510; 
 Sat, 25 Feb 2023 00:04:15 -0800 (PST)
X-Google-Smtp-Source: AK7set8IO227yehdqQqWdezpmUSxGRNZn48vYG48qcVzkqTF3CHi9n73Be3QnXEMGwE73mWqoHABpHkuMQdPTlUvabQ=
X-Received: by 2002:a5d:45c4:0:b0:2c9:bb13:2122 with SMTP id
 b4-20020a5d45c4000000b002c9bb132122mr41276wrs.8.1677312255227; Sat, 25 Feb
 2023 00:04:15 -0800 (PST)
MIME-Version: 1.0
References: <20230225003444.2368729-1-edliaw@google.com>
In-Reply-To: <20230225003444.2368729-1-edliaw@google.com>
From: Li Wang <liwang@redhat.com>
Date: Sat, 25 Feb 2023 16:04:04 +0800
Message-ID: <CAEemH2cjKVjBS2PzCzUozXew3ZqPyShjThOKkfEzd18h6fTK8Q@mail.gmail.com>
To: Edward Liaw <edliaw@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] pcrypt_aead01: Should be related to
 CVE-2017-18075
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Good catch, merged!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
