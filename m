Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C1BC433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 07:33:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 520E53C8A81
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 08:33:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50CD53C8852
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:33:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 46CCA200BA4
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:33:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639380781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C+JX7ZbvcrzQW2MWzYfeVpqa0piyXK7xDMq+/TYo6K8=;
 b=DHqtHJSKkSn8iAebqT6AkOl4z8g5iCkHpi64qIqURTKNfqW/62x7a+dw9R55+s8175nDJ7
 d03h9SHQAM0v6KBplGnfcVzXDvr6lxN3Bazgt4TLYERGmWLQOxgq5ZWAy1NPBIPCX9fJsX
 2IIiMmPUHeS3qYu5JxjIbH5fkvR6DcM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-Dc26x2XCNH6UVuB5MKvTZw-1; Mon, 13 Dec 2021 02:32:59 -0500
X-MC-Unique: Dc26x2XCNH6UVuB5MKvTZw-1
Received: by mail-oi1-f199.google.com with SMTP id
 be34-20020a05680821a200b002bd24f9a87bso10429404oib.17
 for <ltp@lists.linux.it>; Sun, 12 Dec 2021 23:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C+JX7ZbvcrzQW2MWzYfeVpqa0piyXK7xDMq+/TYo6K8=;
 b=QLYCy0PTffSSjohnHgrOm8BBcKj26e0s+Yh9Xxe99NPkzkin0bzitQ5pp07rE/G7Id
 bfQ2TDgjrva9AH5jBEs70qc+XnEHtMa7oSTnYZIGm55ZLrgiB3DzAKHNFPFX/8XO9DB7
 KNZk3aX6cEIP5ihWqMbaB4PiNZcQdp8pFJ493aR4XGZD+OGdDzl7izDOSHzYPUexgdV7
 m/2mOqrzcDGW24DQcUkKrdkUpJlvoEyvu8a5Ui5pH2AsQgRUW9gVx15a0a2KV3WNCvbM
 DHDBBg3zmwrKwsr9zzAwk/Al+44aVeQ+YIm7ilb36C2mKJPd2UOa0KCObkoXW+y6DnBP
 BCmA==
X-Gm-Message-State: AOAM531wrJAA7SrC/dJIxOTJeCPfiyPYrwURhT0oMw1iEFsQeIg1Z2LG
 3L2MB4WNbPowvjvJX5CIzPEneK9tVxnJIaMsM06IbSDQQg+vIyz/AxRPkD+Sx376xtcAbyxxPIz
 cA3ju5LwOxus5Q2VjC7sBt+pO3wU=
X-Received: by 2002:a9d:1726:: with SMTP id i38mr23218709ota.176.1639380779314; 
 Sun, 12 Dec 2021 23:32:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyT1/nbQAry+fLOxtyDtjLw0ofRAyrfHQoHX+Wti++GcL32tTITEJMfD+jMbD8Bg+wzxEBATBi5qQrY9FMycB8=
X-Received: by 2002:a9d:1726:: with SMTP id i38mr23218690ota.176.1639380779050; 
 Sun, 12 Dec 2021 23:32:59 -0800 (PST)
MIME-Version: 1.0
References: <20211210134556.26091-1-pvorel@suse.cz>
In-Reply-To: <20211210134556.26091-1-pvorel@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 13 Dec 2021 08:32:42 +0100
Message-ID: <CAASaF6zWpcNgeqj=ZaYTianx9MFvu7zRsfZ=eiXT9e=iGBRX2Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/maintainer: Add policy for new
 functionality
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

On Fri, Dec 10, 2021 at 2:46 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/maintainer-patch-review-checklist.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
> index c7bb47810..4e2b267ac 100644
> --- a/doc/maintainer-patch-review-checklist.txt
> +++ b/doc/maintainer-patch-review-checklist.txt
> @@ -34,6 +34,9 @@ New test should
>    GPL-2.0-or-later; the licence for test (e.g. GPL-2.0) should not change
>    unless test is completely rewritten
>  * Old copyrights should be kept unless test is completely rewritten
> +* Tests for new functionality in mainline kernel should be merged after final
> +  release of kernel which contains that functionality (it's not enough when the
> +  feature gets into rc1, because it can be reverted in later rc if problematic).

Acked-by: Jan Stancek <jstancek@redhat.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
