Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A861C3DA4A
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 08:19:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BE643D1F44
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 10:19:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2F8C3D1D69
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 10:19:16 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 887C5602990
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 10:19:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722586753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=onFNdz9rtdBRa/rHQMnEs571SDIrP+oNHsAiwlcnYAA=;
 b=ATeE9cUKffXe3B/GqdZEuWROBVVitsQl25gGaDbrvdHnPDjEWUxO3NbfAwjwEVg7d5p7sf
 nm5ANm8g0a9CHLsuKiS5nOGiFdM1pZKhmba34n91HBiFIVlpxK+GV4U6tCtSFLaziQ0/g/
 2FY591k3WBgDaNH5KzOScj+Zo5BA8S4=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-K0YQUbL3OcOxZ7Bcoy-cpg-1; Fri, 02 Aug 2024 04:19:12 -0400
X-MC-Unique: K0YQUbL3OcOxZ7Bcoy-cpg-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3db18cf7be8so8557959b6e.1
 for <ltp@lists.linux.it>; Fri, 02 Aug 2024 01:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722586751; x=1723191551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=onFNdz9rtdBRa/rHQMnEs571SDIrP+oNHsAiwlcnYAA=;
 b=JZvCM/m+vZcDp4fACZsWr/fDohGaeZsf7fW3lFZy7ADPthjUW2psMbxPV+rm1F11o9
 eE0Kdi7XcQp6WqEanwbyAGF4x2z4ZFRohM3XgJOW0ADhvCqQH9cXE3QnQLzNY7evpIOQ
 FtQuH5R/OBU/ZLGeJLHBAz9FzZw2unxaYOhjTFeN77GrR6/hxMXXhEZxqKd+g86pQnBh
 hhj1/t6F3cSz0xY0+7j43nNBQ8BcSVKi7/i0Ge34NL0eGbBRTw/EBEswHWlmuXWKMjyC
 07hCcPXnTOuxX7eCAPt9jb/n4YV6Oh5/QkJ3+BRAYCRE1wY9Nkd+TXsGONiYM9ejPrrM
 Wp1Q==
X-Gm-Message-State: AOJu0Yw6Wtso+wedHGf8l6JuovCu2Z5u0r5EkLLuCbgnXB+23DX0W5G7
 DlU+RZzpc97bg+7IIySJ36YuaZeRJOfdyIAiY+KZNKAj47ZZ/dbDa7IfJSAFzH0sh4lX/DUm7a4
 KuUfDRVo7PyE6+yIBYAfoptV7YDJDgmlH0lNgRs/q9U7XPEdXkmwnNXCjg9yL861l6omIf9F0IG
 DACZct0iCHXJTw+8LAg+0bhdI=
X-Received: by 2002:a05:6808:1a0c:b0:3d6:3106:52bb with SMTP id
 5614622812f47-3db5577f29emr3736375b6e.0.1722586751181; 
 Fri, 02 Aug 2024 01:19:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEkjK88oGq3ux8PHjOzB2YUUbGWFt7Vzagn1pdflTszmO/XOJXo/Wi9iLBiZV+aw0GeivVnAHUzRbtrgV+P80=
X-Received: by 2002:a05:6808:1a0c:b0:3d6:3106:52bb with SMTP id
 5614622812f47-3db5577f29emr3736353b6e.0.1722586750829; Fri, 02 Aug 2024
 01:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240802081136.271850-1-liwang@redhat.com> <ZqyWQz9SgoVqKAM7@rei>
In-Reply-To: <ZqyWQz9SgoVqKAM7@rei>
From: Li Wang <liwang@redhat.com>
Date: Fri, 2 Aug 2024 16:18:59 +0800
Message-ID: <CAEemH2eb0RBH8Ev-kbTCiAK+PKOvg6SAJyOQLgT+6E9+tzYRiQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] catchestat01: skip some tests loop with large
 pagesize
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
Cc: Bruno Goncalves <bgoncalv@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBdWcgMiwgMjAyNCBhdCA0OjE14oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiBJc24ndCB0aGlzIGZpeGVkIGJ5IFBldGVyIHllc3RlcmRh
eT8KPgoKT2gsIHNvcnJ5IGZvciBtaXNzaW5nIHRoYXQsIEkganVzdCBiYWNrIGZyb20gdmFjYXRp
b24gYW5kIGhhdmVuJ3Qgc3luY2VkIG15CmxvY2FsIGJyYW5jaC4KCkFueXdheSwgdGhhbmtzIGZv
ciB0aGUgaW5mby4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
