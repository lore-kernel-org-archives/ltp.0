Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D67C47258
	for <ltp@archiver.kernel.org>; Sat, 20 Jan 2024 08:35:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 993673CD657
	for <ltp@archiver.kernel.org>; Sat, 20 Jan 2024 09:35:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBCEE3CB6E6
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 09:34:56 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2015B1028F67
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 09:34:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705739694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FNnUKIc2tUGitE6jv02PJZcc/O+xZVJ+RiDNF0fHuuU=;
 b=MUoDk1cUgC3ihgrHRPd8wSiyWZwr/2pQnb66ujVZrQQdNHPylG6buHLMH1hVWnZhdc15WM
 1VHB+aOX8AHXu85H3g5mlV3tWHRD+dEOg3I954hUUIsGRt29HPE5CKoES35jplnKdHQ3Vf
 jlabTZw7fjjQJfKnURA+yYiHYApPqqE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-_H9RT8lTOvqnADGP8j3HxQ-1; Sat, 20 Jan 2024 03:34:52 -0500
X-MC-Unique: _H9RT8lTOvqnADGP8j3HxQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-28b88d79b87so1206445a91.1
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 00:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705739691; x=1706344491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FNnUKIc2tUGitE6jv02PJZcc/O+xZVJ+RiDNF0fHuuU=;
 b=wDUIUpmxaT1cfTDXt5vnh0VMXtcj85qOctuykyzZsSJ7s04JuIZBFw0JNkBh+s/qG0
 Wwzqkgc9CSqRLj1Z6pfnH+R5qwt8IpCr/VChT4eJUVBNqDcY9ziypSZRTO2MaknkHvd7
 UHDB7QKDBc7XaPh6trtATdegKGfoGL96AqurAdUHdeKSvlRVAXjbGdkkmUQ1BUFJXer4
 /l5sz9v+HnInIRiPcjh+HufbP1hbDyPr6r/964xQM+QUH5endi8acwMT4aJWCzK/e4ER
 QK5jew9UJzigjx5+QKXFJnNUMWyyO+z4byKq5ed4V/TfrHo6eZuiet8lpXCMIpy4Ep0B
 yCow==
X-Gm-Message-State: AOJu0YxZnEhqvkC1p2SteIPQVYMpLCfUQjp7sE1tYrClQRgVdxSrMrtq
 cKEbx7e7Qq+ViJGSo/F2Pgo+k8Szy95/SpM3NAqCq5rfQNMx2J+xl8qnNPeurHnxvYbp48Ex5KJ
 aqs+z3rAKJHj5iuZRZlPA/6iIOIn0Sgj4vshvlJG8uE2iylEq4dlesxwqJfRjRRHeI2y2X9ibqC
 577bsY3rpfkljv3RNI55ZPFeE=
X-Received: by 2002:a05:6a20:54a3:b0:199:9c5e:5d0f with SMTP id
 i35-20020a056a2054a300b001999c5e5d0fmr655042pzk.23.1705739691702; 
 Sat, 20 Jan 2024 00:34:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxuZO0MNz0YlHrgPlnoHsBMab46dKezR73l62wQqWorHD3Ra9CGjT1LFSDJBtww23APwCEAlwPbmuSP1NeDUo=
X-Received: by 2002:a05:6a20:54a3:b0:199:9c5e:5d0f with SMTP id
 i35-20020a056a2054a300b001999c5e5d0fmr655039pzk.23.1705739691378; Sat, 20 Jan
 2024 00:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20240119135252.32420-1-pvorel@suse.cz>
In-Reply-To: <20240119135252.32420-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Sat, 20 Jan 2024 16:34:39 +0800
Message-ID: <CAEemH2c1HNMV_4E32-0HEJe56w0qY6wn47Jz3Jk5V0DOwEQQgw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH 1/1] libswap: Pass enum instead of int to
 make_swapfile()
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
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
