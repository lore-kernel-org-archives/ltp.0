Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9EFC27C4F
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 11:53:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E6A53D0D68
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 13:53:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE0C33CFCF8
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 13:52:57 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 72251602773
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 13:52:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718711574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lsn2v2hNP+coRGZFd0e/SVrRGqSB+JZFNUJUDMd6zpU=;
 b=IYIS9QaaZqyrNX1t6TFpf27g/Bq2ZnABW0dqS3ekDdBxpxJBh6W62geK9i424UVmWom5a4
 hWB7dRwVj57HIhC+qMJ6gToMsuIInlZsu2V6h+mJlS5+0PZpKd6Mnf/l7MO24X0dvbtxWS
 /SiotoOW4okLDS4gVzzZB0ZzF5Kqzic=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-0UrgaowJNSCvVyyJoyGNxQ-1; Tue, 18 Jun 2024 07:52:52 -0400
X-MC-Unique: 0UrgaowJNSCvVyyJoyGNxQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c4f3ccfca7so3818683a91.3
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 04:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718711571; x=1719316371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lsn2v2hNP+coRGZFd0e/SVrRGqSB+JZFNUJUDMd6zpU=;
 b=HAwO3Az4LD2/bZM/yIxZxGGO0xlEIP/hyYaHrxgfolDSqNKFJzoMnwbexVtSpdglI4
 sNvetN+qRTEmhk8T3HvvYdpHrs58KuEXEGOFUGFpL9VTbHsWoEpZgyuYIUjw6xA7bzy2
 VpzNEqlh6BJCoCs39RctMVDXgirSiBpd+s5FmOLy8VIrLVFWQswkz3lPnijgghII3zCp
 kSAt0gIe+Gnhw2Rq0fNXLvUv6vVzSAxAh7yYo+JXBhS4ZddvlS2WGF/GNOw9wl7ibhBi
 lpMO+Ep6p75GOmP8hkKEh74bKom5BUsK6xF7cpX7TBWbdFnR9gabnp410cOBKuK5+iep
 XiZw==
X-Gm-Message-State: AOJu0Yy2DQIAzslFyxWfh6nCYIZRuLbROzYRWQV8r8TKezVimNDcsN+L
 fr9O+V8qLCMfcUb0yEA3jxdzo8gPOUrcD7QJJ0imS0K+Z2b7rpdBuGug049zyScwqNXBu124y0H
 N/Ff2gzqWBvAbrQ0m2w16VqH80KSpdEy1IQk5fYMfZnBJYaw5cKjPViEJQASo5jXAQVXvcgOr0r
 MM4bJ225jz+10QqDSDUBG5WLn2x/IM3ggsT0bR
X-Received: by 2002:a17:90b:80d:b0:2bf:ac8a:c795 with SMTP id
 98e67ed59e1d1-2c4dbd356afmr13050147a91.34.1718711570712; 
 Tue, 18 Jun 2024 04:52:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+yw3KWhvLfJWUzGetWkJ42nwZEbjoCicowpYSqlTCSmwgY2SDpIlEaAcdERV5dK6T2bHuGCKKlXqhFtLVmnY=
X-Received: by 2002:a17:90b:80d:b0:2bf:ac8a:c795 with SMTP id
 98e67ed59e1d1-2c4dbd356afmr13050123a91.34.1718711570235; Tue, 18 Jun 2024
 04:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240618103117.371469-1-pvorel@suse.cz>
In-Reply-To: <20240618103117.371469-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Jun 2024 19:52:38 +0800
Message-ID: <CAEemH2dE7RT_GVsXR35vKiLBCJh4OiJnjipHDKa6+1HtQ7oxuQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 0/2] Update taint
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Qm90aCBsb29rIGdvb2QgdG8gbWUuCgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhh
dC5jb20+CgoKT24gVHVlLCBKdW4gMTgsIDIwMjQgYXQgNjozMuKAr1BNIFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gUGV0ciBWb3JlbCAoMik6Cj4gICB0c3RfdGFpbnQ6IEFk
ZCBUU1RfVEFJTlRfTgo+ICAgdHN0X3RhaW50OiBBc3N1bWUga2VybmVsID4gNC4wCgoKPiAgaW5j
bHVkZS90c3RfdGFpbnQuaCB8ICAxICsKPiAgbGliL3RzdF90YWludC5jICAgICB8IDQzICsrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDM3IGRlbGV0aW9ucygtKQo+Cj4gLS0KPiAyLjQ1LjEKPgo+Cj4g
LS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
