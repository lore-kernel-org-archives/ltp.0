Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06F4C87FCB
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 09:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754301537; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1SLR9eIyrSN77ULrNTvwFv6hD4ROy3xnKKLcdAisXAA=;
 b=cGGFcDNyGOqHV+ujkYyjk+gb8oDM6Y4WkwHsfNszc2foBhKZ83Ffs+frWS4QlxL5QPfBA
 TwT2SbyS99MOmrqqKCOVx5tTLedNg5Ooi2vzcwLrebR7iE/oucF7b1KgSWypztxnoakXNPs
 AjLy8raNjgpHnA2o6GDlCnitsONPCJQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27ABE3CCF18
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 11:58:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD3203C9959
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 11:58:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F2E401A001D8
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 11:58:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754301512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SR9mvcCB28v/qWK2NQa3kAUe/7KHbWikbtzi8OPZ5NM=;
 b=TY6b4zXfiI70U3/eIf+k2Yy96dq0N1IzYfR37lbAY7VQf9dbkQ8qW8saBcIkCKCkIJCdds
 Iz8lTDXGS72tyEQ8ZxFFKOK3bp456azTu6UXuoml/uymge7rHoqQSw9yq+4Qln7hlrYVaA
 alW3jtPlA1TafNRxhmA6l12i8e3Jths=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-Y5YqIJYSNMuDaM466zdemg-1; Mon, 04 Aug 2025 05:58:30 -0400
X-MC-Unique: Y5YqIJYSNMuDaM466zdemg-1
X-Mimecast-MFC-AGG-ID: Y5YqIJYSNMuDaM466zdemg_1754301510
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3214259ce67so772780a91.2
 for <ltp@lists.linux.it>; Mon, 04 Aug 2025 02:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754301508; x=1754906308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SR9mvcCB28v/qWK2NQa3kAUe/7KHbWikbtzi8OPZ5NM=;
 b=FD7U4U+btJdpdjMNSkpRqKV60LX7q7LYnjKj54Hi1K97VbWxHfsRjf46qU+FaOKOni
 57xdfODxlqHf2wSMHasnpAeNGccuwp7XqPMZrl6gJ4cr9MQYb1sRgadgFCO6Q1AaJVO9
 R0s3bigFvL2sFpV1xuRUF/E/rvjnEy4ZUUDG8NjMsDX8HtB9L9Z77WMyaXlZH57ZRSoX
 qheENLPHMeztSa3TmLgk7Qp/852f4hTEAI1wiU8z/7pZVNUqyMWOTB1lYfy+92kdVlM1
 BsAa0RS/z2Rp4PvWwkSsmVzdTB3N30q2xmwkqtQadyZ9fONodzry8daaK/CyXHtciEf1
 Qb1Q==
X-Gm-Message-State: AOJu0Yxm9It+GuKJLjSRpMawr72YMLR9wCCJ6Xvim9h27NI3uXevKCXl
 Y58+8BauJ+TPPrjkpHWyhO3E9SOAoUV1G9U9Q/A6scnGuwwHwrFu1X3Y0G5kBDVfcyyAhHgGCy9
 7HVlCMo4PGTXKprBS2OlCjYpDgFrRpkw/iKc3O/XGvfQeWIO7dQFm7YeIfAywELXDWgZ0wgAutr
 OX0hbp5qM4Cb/7p/C9VU7W0ron1x0T2AZLv8gSKQ==
X-Gm-Gg: ASbGncuhnuydmzEJAlb6RBKiEpMHueyqpMEbwTlp89mEbc4AkgeAAFKxV89s/s8kVYm
 q/bgWYcxKZFZB9Y40jXzKT6Tf8YSBX33GViVfSi3KXg7i8M/1qyJUNuT03wgXRl9oV6SZOOdlhC
 P/RktuDihAw/J4vV7RHf73VA==
X-Received: by 2002:a17:90b:4c05:b0:31e:d4e3:4015 with SMTP id
 98e67ed59e1d1-321161f036fmr14338252a91.8.1754301508366; 
 Mon, 04 Aug 2025 02:58:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1uTrW2qWBPgipNCMKa1mjndAxp09jJ1nUpONkKFyzNoL2PIGKGUx0tzgVvIaIvn+n9xPf9d9i7tlDJTtOXHg=
X-Received: by 2002:a17:90b:4c05:b0:31e:d4e3:4015 with SMTP id
 98e67ed59e1d1-321161f036fmr14338235a91.8.1754301508016; Mon, 04 Aug 2025
 02:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250804093520.212221-1-pvorel@suse.cz>
In-Reply-To: <20250804093520.212221-1-pvorel@suse.cz>
Date: Mon, 4 Aug 2025 17:58:16 +0800
X-Gm-Features: Ac12FXxkFpBTqygrijIGTpVJ9R8DQ4Lsx_ApCe-FWhPq0l94nPfHQboK3u7wBkQ
Message-ID: <CAEemH2cbtvLVkTF5TQ9n0o7feUtrVQmgX+XwKmuFBQRwU6HSQg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5mLXHZu-f8fWZil1Nt-VlwhQn-o7Oo-62-9XAbVQaEM_1754301510
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] commands: Remove eject test
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBBdWcgNCwgMjAyNSBhdCA1OjM14oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBDRC1ST00gaXMgbm90IG11Y2ggdXNlZCBkZXZpY2Ugbm93YWRheXMuIEFs
c28gdGhlIHRlc3QgaXMgbm90IGluCj4gcnVudGVzdC9jb21tYW5kcyBub3IgaW4gYW55IG90aGVy
IHJ1bnRlc3QgY29tbWFuZC4KPgo+IFRoZSBtYWluIHJlYXNvbiB0byByZW1vdmUgaXMgdGhhdCB0
aGlzIG1vc3RseSB0ZXN0IHVzZXIgc3BhY2UKPiBpbXBsZW1lbnRhdGlvbiB3aGljaCBiYXJlbHkg
dG91Y2hlcyBrZXJuZWwuIFRlc3Qgc2hvdWxkIGJlIGluIHRoZQo+IGluIHVzZXIgc3BhY2UgcHJv
amVjdHMgKGUuZy4gdXRpbC1saW51eCBvciBCdXN5Qm94KS4KPgo+IFNpZ25lZC1vZmYtYnk6IFBl
dHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+CgpPYnZpb3VzbHkhIQpSZXZpZXdlZC1ieTogTGkg
V2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
