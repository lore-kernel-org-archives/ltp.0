Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051D7CA0FE8
	for <ltp@archiver.kernel.org>; Mon,  1 Sep 2025 01:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756690346; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=5Ixp3Wq0SwjeDKb61Bcnh7g6NOC67pQUy/DmOQvoqzA=;
 b=Qiw72IdA42jhPThNsiXdorPioKWA9ML01Lc7SotFEiA+NFtp9FIHOhqFs8KrgrO0OQxUX
 aee8a/rxAs4Tynd244mRHjqWqcTG1Dpw4amaGWrAvXHLu3UXTvN9jO3h9qDNA52qIDsruuj
 Qj/H34sYEfmOeXCHkpXaKN7lUmBSSbI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC5DE3CCC78
	for <ltp@archiver.kernel.org>; Mon,  1 Sep 2025 03:32:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D504C3C2334
 for <ltp@lists.linux.it>; Mon,  1 Sep 2025 03:32:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 07D6A6002EA
 for <ltp@lists.linux.it>; Mon,  1 Sep 2025 03:32:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756690323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ncsW1K2xu8okSJdis61RbCjP8QQkA9+5clw9PtVm33A=;
 b=iUl00lTC6LnLSV25DgWb+wSLCtlS4DDDqAe9BCN/Ef6kOmOOzzzL7QfNJ529D/UiI7Bb9f
 IRb2osvGiy7oZtSGq43TQamD+zP3i3HaA28oSLv0IemXQk/0dKScoapsirBo80bRn5JJMr
 I+7msu66hefbRzTY1VtoLjTzmQMxNFM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-nIwbGb0nNaSBv70XZjlmog-1; Sun, 31 Aug 2025 21:32:00 -0400
X-MC-Unique: nIwbGb0nNaSBv70XZjlmog-1
X-Mimecast-MFC-AGG-ID: nIwbGb0nNaSBv70XZjlmog_1756690319
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3276af4de80so5710427a91.1
 for <ltp@lists.linux.it>; Sun, 31 Aug 2025 18:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756690319; x=1757295119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ncsW1K2xu8okSJdis61RbCjP8QQkA9+5clw9PtVm33A=;
 b=NWXoGmpANE3OEehcu7lQNVZR/w3nqnaNi+agIZu5PuTKyho4UiKoWt+wNOJvH0LYO4
 h9wT9blOlbzOd+8gooKIyxnMlJFRowbFmX/l7yzFqdQ4yOGs84Q11C3fY+VVxc9xtp06
 mcskSN/1UaoKlsMXURN6c6E4hGZr/5ndVwBi1/5gVdBWxIp05PuA8HGhcmlL2wWodqEi
 3VnYsqXzauhkumIEVTgLdBudch963vQlnjXJYmmyVL75qQjJ0NquCanuOfMCQKaaZ1us
 5AIoGM445+gSM0ap/QI8tNqgRSdsbRsSpSc1gQb34hXGJCmX0Di/RiytWiSXj/Iw5FoH
 Ga6w==
X-Gm-Message-State: AOJu0YzW+cYUkWtA5xnxEuwlq+2j9cJYkNNWkHEDjLD+KybUpKypWFPG
 Lo/ZMAfG9fG/Kr039Y3DymPqi3L6PJBvA1FNBd/hsVWIKH2TuGBzvDa1XnCpYtFyPWrvH9PQp4E
 8dTiT/ouj4YUJU0Sxa1PGzb2B0lu8mk9AmxLNXkP7oRZWXpYHjquATlXPemjTgGZ25NiiId69C1
 mVMpsVRB9wUewAgCSi1JDJ292SKM0=
X-Gm-Gg: ASbGncuDQJEczeojCiebEz5JECPrvdmrUg15hhn2qXa5l2Hi9AU3eoyhEXfxVsL940i
 HQu5SOqiHHhWaaHgkvLMpyOyq1APddLa8bDZ81Pk4/GIhlR4HP+ZHuunvhHGFnKQd9TOnpPVQdx
 +IrmT6I/U2jpmxdn8Jc4ttuA==
X-Received: by 2002:a17:90b:38c2:b0:327:e67d:6595 with SMTP id
 98e67ed59e1d1-328156cc9c0mr8374298a91.25.1756690318926; 
 Sun, 31 Aug 2025 18:31:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLEPFh1ruQUpspOzbEMhXmjQ7X8Ca0YZULuqyj276cGY/oNuejH+xTLPurnThgmvcYZ+yGsoiS6zmX0tZAHtQ=
X-Received: by 2002:a17:90b:38c2:b0:327:e67d:6595 with SMTP id
 98e67ed59e1d1-328156cc9c0mr8374277a91.25.1756690318376; Sun, 31 Aug 2025
 18:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250829095635.193116-1-liwang@redhat.com>
 <aLGdWMyihjYsuiCk@rei.lan>
In-Reply-To: <aLGdWMyihjYsuiCk@rei.lan>
Date: Mon, 1 Sep 2025 09:31:46 +0800
X-Gm-Features: Ac12FXx7DfZFq1Wlt9Uf7sqe3-0yCUTl0jSf9wv1f2CuedEOl-TmKQLELGj5i5M
Message-ID: <CAEemH2fG1u3wn4ft1TN8hcpwOc_YG0trJvyK=DyZ0k=7B2NKKQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xBpXWaoDL9Ba5i_WT2ILcbXlPH8yczxbdp51gMYcVoM_1756690319
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] sched_football: synchronize start with barrier
 and add proper game stop
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBdWcgMjksIDIwMjUgYXQgODozMOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gTG9va3MgZ29vZCB0byBtZToKPgo+IFJldmlld2VkLWJ5
OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPgoKUGF0Y2ggbWVyZ2VkLCB0aGFua3Mh
CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
