Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0132C433EF
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 10:05:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEEB83C96B1
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 11:05:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DEB63C4F5C
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 11:05:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5F58660111A
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 11:05:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642673133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f/BvpKEhsZlyaChzofT9VmpZXnv679Rv14lda7DplCY=;
 b=cw98Knijf8BhPjmjDr/0QAQdbztWk7KvkKS5DgN0l+E/BdAeb4xbohnS8aXGPoiX6KFFIu
 zOD5fpjEnhFA3YUQTQn6pM3NLTTYqdScWcaCSlZJM6R3HRjWZ+AkbFu1NJy5BSx8QeCCUW
 X9OElzUp9dboeEeR+sAMm8cyIH85wns=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-B75gZTgGPAaxpdALyC9gcg-1; Thu, 20 Jan 2022 05:05:32 -0500
X-MC-Unique: B75gZTgGPAaxpdALyC9gcg-1
Received: by mail-yb1-f200.google.com with SMTP id
 4-20020a250304000000b006137f4a9920so10119069ybd.6
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 02:05:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f/BvpKEhsZlyaChzofT9VmpZXnv679Rv14lda7DplCY=;
 b=H8tM41Hy7B2PSukkDtUT+w0HIevGPOmMhYYGtOMcqJ6iLR0ls9eMeC+u1w6hrhNcig
 d85GpQRw8EMy47JVYMEqJlVn225i6VDPa9BO9i23Ifq4LOERgoHlpJ160Y4NXNhAdZbf
 qaYJCAmo5EAEHz0ykpII+uNpUid1Pbwky7jJ/Q7MEqdtC4seaT219Fm0kpDNWxkkHb1e
 9LGOmO2Oqdh7lQQp7yzxWUjOh2txgS3NgcOGCxK/6ZuWRIzhUvtlfI0KJccd8Q6RCaAK
 qz3fZpdL6QwmYKZ0IHr5OtbADtT4DUdIWrjZXGzI2jNdIye5XVOvCm54rmZ9ODX84EuM
 a1tg==
X-Gm-Message-State: AOAM532bK6wrbZxw9WMBpL3U53kQBsTl8hDjGlT4HoowqzcSdUwPtR4f
 uF5khGEuH7iM7JyXdV+LbKCeLvZHGMS9SlDc5FJn644wK8UiFV5qYkeJkReHeJkMYZrQLVJ7lTQ
 hXwyyv9YN17nfkzGy/7p9ctKOowo=
X-Received: by 2002:a25:d57:: with SMTP id 84mr3322913ybn.145.1642673131564;
 Thu, 20 Jan 2022 02:05:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyctDvyudacNDqbu2++4Xv4ZdSwfxmOselmHynRMnUiduSnneOB1EJpdVpTls+AA/qhjfqhV9UoDaq2UgG4djY=
X-Received: by 2002:a25:d57:: with SMTP id 84mr3322896ybn.145.1642673131382;
 Thu, 20 Jan 2022 02:05:31 -0800 (PST)
MIME-Version: 1.0
References: <20220120095044.19789-1-mdoucha@suse.cz>
In-Reply-To: <20220120095044.19789-1-mdoucha@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Jan 2022 18:05:17 +0800
Message-ID: <CAEemH2d0r4o7m7wif=vicAREfthKr-fyFpJ=2DqHrLtiLrwtnA@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Rewrite statx04 test
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Nice work!

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
