Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35030CDB474
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 08:52:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E1553CECB6
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 10:52:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAAFE3CB4A2
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 10:52:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0266D1A010C9
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 10:52:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698051130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aKhGlZOuXb6JEpqsSYb9I45dA62mhdKIff27ZxeMFag=;
 b=al1ELFWpJICMNKfnW7cV0SgwiXRquZzbyMDXzKs0iPRw9+SyxS+YcblCAARdqCEK+hHHEB
 rX+h0cqDES3K32KKsSXEXDXN7+h6C0Milzl6YNFzv6SUa6IK0jwgco2UVUg8mjDnaAvANl
 6Y3T1bDQHGFj54L4ulTdRa2B8++8cSQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-CytTBegMOlab3o8CYmyxPQ-1; Mon, 23 Oct 2023 04:52:07 -0400
X-MC-Unique: CytTBegMOlab3o8CYmyxPQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-507ceeff451so3125381e87.0
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 01:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698051126; x=1698655926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aKhGlZOuXb6JEpqsSYb9I45dA62mhdKIff27ZxeMFag=;
 b=BvxFuCQtHGy54Z5amPBo2IajJhk6UNpT2RUrDsVW/oxL4dcOfOC+l5/Epw3gOayY5u
 qJCSL1vBhXZupoEcGa0iRSBctuG5yF+8am4B9uJH+/HFo0plofb+n8QuBQvbjSIUM2bv
 tF/5QpWFBmMvJMVfiUrXSXvfluUC9gfjE6l+52y6EOnAnH5X5HWxqcb9384MtpUOxAbu
 riCF4teLqrV9e1CAhK60SO1mk2l5K7jrDbmEF51NdynxH/Da3n1LYor9ekOZYdnCZ1+5
 6fngDj8xPkQmGacjHL0dMX8ArwbZI8hms+a7NKiF9le0Lhtth81I2/c9aYoBZ0hdfU6x
 4IRg==
X-Gm-Message-State: AOJu0YzcuG4Uv/QyYcuwM+NEQ4iRX5CRS/Z3JTMoEwhjwKnPmN3skWYZ
 jDcq7TgyDHd9ui0wcKxKtnd0nM33vp7gIlF/urI7tLRjPx6vrBpYzb7Gp1EDnEkkcInlMl9s+wb
 TpqWynQ2/NLGh29Af2mbledrVzfA=
X-Received: by 2002:ac2:533c:0:b0:503:3453:ea7a with SMTP id
 f28-20020ac2533c000000b005033453ea7amr5627093lfh.66.1698051126431; 
 Mon, 23 Oct 2023 01:52:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7Qxn792cXxNODtyz+v/AqyZI+BpXU7MYzXD2T8+cXBpPzIGQGXYBLl7/GQ3156hTrWG7SOkf6Oivo92liuJI=
X-Received: by 2002:ac2:533c:0:b0:503:3453:ea7a with SMTP id
 f28-20020ac2533c000000b005033453ea7amr5627084lfh.66.1698051126149; Mon, 23
 Oct 2023 01:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <875y33vsks.fsf@suse.de>
 <CAEemH2fvE0z4zDfbKEG0Vj60cVZ1v5MuA9iSDZGMPHzMw8amtA@mail.gmail.com>
 <ZTJq0FYkBwr2KyFM@yuki> <87wmvdvjfz.fsf@suse.de>
In-Reply-To: <87wmvdvjfz.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Mon, 23 Oct 2023 16:51:53 +0800
Message-ID: <CAEemH2cOgpgiCTJbyHfF7j-YLLJ3Sd2-Fv8d3Lmg2sCMwxAMYg@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC] LTP open monthly meeting
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

> > Maybe we can try to set up matrix channel with IRC bridge, however I
> > have no idea if there is a suitable free server for that.
>
> I am already forced to use Discord by a couple of communities, it
> supports text and voice, it's better than Slack, so that could be an
> option to cover everything.
>

I keep an open mind for any community tool, no matter what
the recommended one for LTP, I would like to install it :-).


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
