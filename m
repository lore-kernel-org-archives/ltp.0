Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002DAC3DA64
	for <ltp@archiver.kernel.org>; Tue,  6 Aug 2024 09:32:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C86E3D1EE2
	for <ltp@archiver.kernel.org>; Tue,  6 Aug 2024 11:32:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBB1B3D08C3
 for <ltp@lists.linux.it>; Tue,  6 Aug 2024 11:31:47 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3CD92601BC6
 for <ltp@lists.linux.it>; Tue,  6 Aug 2024 11:31:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722936705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tZKbYBI67udx1WGolf97W1T/QpN3cnmCsFe8nTykYAw=;
 b=B2FtY5dMwxms+urvc7mQ7QFbjh7O2nNP8gCemag0NFKlfdo5yG3KAf8jWxzW6Soj4s9JWi
 RjI48T5CJ9KgcrooiNlBqTgKS2QX5sk2FIgu807Ky6xjQDTgUDONO5YvhKc85JO4kSoFtY
 POKn+4M0+YY7M4FNGHPib6Dse5j+fiw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-0rqReUIvOTi1PUBtM_HaPA-1; Tue, 06 Aug 2024 05:31:44 -0400
X-MC-Unique: 0rqReUIvOTi1PUBtM_HaPA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2cd4e722d82so440020a91.3
 for <ltp@lists.linux.it>; Tue, 06 Aug 2024 02:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722936703; x=1723541503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tZKbYBI67udx1WGolf97W1T/QpN3cnmCsFe8nTykYAw=;
 b=CDOdfxSjOAY0cDeIfdV9ZZ/uYBppEaRRw+eiZB9h0xTN2PNs2HdVS0w4svMcYi2ld1
 Lh/adSiUMt6sCwnw6QQlJnnkvjbd0O8QLmkjfFYBCacsOvhUg8fktuicjGoLk6GWmRvQ
 WN1/vYdC2YUO6wSzCNeXefuOIzTpriAyVv8nuLo6OBDLN9FP2vdtrE+oTvRJ6zdtklmQ
 EBY8JO5suIas/kR70pWdzVbl/oFqJSNsXWrQm79bBTErj64HJ1gqB2bnvgNer9RxqU8P
 ZfSkAqMggEG1lUh1y2y6wB5kSUcOgf25+lRienYF5bcfsReuzlQ5JDQu6iieYyBSmdCo
 lBkA==
X-Gm-Message-State: AOJu0YzfnQg2EUFbErby8cLhrAxS2tn+iqpS3RjyFSe805qk2x0CZJF/
 Km88aWyb38++jVRmh27rAbFxv7j7Mur4RhRA/s3IHvNFmyL9A0T1X09Wsll1lTXb5fc5KCEdb5m
 90MX2ZH5oUZJoQkFV5WD6N0z0gFZiBoN3rwaH+sI6hDrxuKuzItyWrL53Bx5MglHysWV6vAqP62
 Y1nIpOB6svr60GQXlraxtzKYA=
X-Received: by 2002:a17:90b:17c4:b0:2c7:f3de:27ef with SMTP id
 98e67ed59e1d1-2cff95647eamr12362654a91.42.1722936702852; 
 Tue, 06 Aug 2024 02:31:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtbK6ArDGye1jo2Bl/dMBgCKLbgnasxKBylnMN6+WWGVODOov5muifhhlwwMB94RcXZoJ6X8rYP6+yalokbOI=
X-Received: by 2002:a17:90b:17c4:b0:2c7:f3de:27ef with SMTP id
 98e67ed59e1d1-2cff95647eamr12362629a91.42.1722936702373; Tue, 06 Aug 2024
 02:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240802100816.1617563-1-pvorel@suse.cz>
 <CAEemH2d_779D8gEJfz0aOej-zW0R91FDsMf3fBfxrAgOf3RcQw@mail.gmail.com>
In-Reply-To: <CAEemH2d_779D8gEJfz0aOej-zW0R91FDsMf3fBfxrAgOf3RcQw@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 6 Aug 2024 17:31:30 +0800
Message-ID: <CAEemH2cquv4UEA-dnEvXx64s3-D4q-x+WsNzV+T=uzEmXYGOqw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] doc: Document "No new API functions for old
 API" rule
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

Patch merged.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
