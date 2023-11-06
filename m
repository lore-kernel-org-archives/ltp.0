Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2073C4167B
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 11:16:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0099B3CE059
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 12:16:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42D873CC72B
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 12:15:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2A945600D05
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 12:15:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699269354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q1G4POiBsKLNRQKkVZ/RSu0FzEY2VfKVACR5BoyU0zA=;
 b=atnZm6SoAMtK7K43N2btQejEAWyiv/3vScmEV5BZKJ9IWAjnHxfeuv6FJ3WFgXkqKdctCw
 a7M8WOVq466TKx+WNMoScSdndDKOZiAo4B/ej/CGoQ8IDckW6AeuNzS0Ix7hVo5SGDLFFp
 NNG8uc49eiIW1bPlrLgSqIlPML313Mw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-PkvIUL2LPbSDOFawFCE7bQ-1; Mon, 06 Nov 2023 06:15:52 -0500
X-MC-Unique: PkvIUL2LPbSDOFawFCE7bQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507d4583c4cso4617793e87.1
 for <ltp@lists.linux.it>; Mon, 06 Nov 2023 03:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699269350; x=1699874150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q1G4POiBsKLNRQKkVZ/RSu0FzEY2VfKVACR5BoyU0zA=;
 b=wpwCrQemXqCdip6hwwZw7OAoyhvCdIfGn6Dr+LdeWpHBMzKN4KKV2B72V6U1NUjAZ9
 iQ42GwrdKyJkNr/tSgWqtg5VY1T1f0RayZXuZcxQOLGLMEvcS6HVJd9TqNWOSc3lTScb
 OxE+BbXNdzu8YHboq1bvN9oyx5QeDEz9DRSOFwLiMil0PUUXqUqxYuRIEetnbCzspmRM
 Jam4eCjsV9ju9NMk5PyOBE/rwd03LPdghUEHvBwpngouC98/qyXkPBjsD/INfefwn7nA
 C1zAc5e/RPViE5h3ouIAXs5TLBD0ueQsUIsHUKEOHO7YB7AlbI2TBx3YHTbKXOWNHbsq
 C6bA==
X-Gm-Message-State: AOJu0YxMNMeAmdlq8fy9qnANsw6A+5u+LsDTCvNbYaD0E7hzH+n8df1y
 DtBFTs4x7WaNMr0dKnttavLqenR9A9XorprMwyZG8rUIwNI1O0WZvooYKSpWazF642xwKya8ipc
 bTZVm5a9E+lCbu94ly6Yup5+b40M=
X-Received: by 2002:a05:6512:2396:b0:503:343a:829f with SMTP id
 c22-20020a056512239600b00503343a829fmr28374943lfv.23.1699269350707; 
 Mon, 06 Nov 2023 03:15:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdVFzICS9/8tW0QFv3HqlHu6psf3y/G0Dp5p2ozzsPgmCfZZ8FmHOfyra9Mgw0hkrB9sRP9p3a7Pv79oZsEOI=
X-Received: by 2002:a05:6512:2396:b0:503:343a:829f with SMTP id
 c22-20020a056512239600b00503343a829fmr28374928lfv.23.1699269350410; Mon, 06
 Nov 2023 03:15:50 -0800 (PST)
MIME-Version: 1.0
References: <20231106110819.1243292-1-pvorel@suse.cz>
In-Reply-To: <20231106110819.1243292-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 6 Nov 2023 19:15:38 +0800
Message-ID: <CAEemH2cBRNxsXCpPW7Lgfi+9r_e3UCkdLNi8R4kFw2y==PCHLg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] ci: doc: Remove Ubuntu 16.04 LTS xenial
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
Cc: Ulrich Hecht <uli@kernel.org>, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
