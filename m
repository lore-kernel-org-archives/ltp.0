Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B59C54E5D
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 06:32:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91E933CE67C
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 07:32:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EAF73C92E2
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 07:32:17 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0B04F140077F
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 07:32:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710829935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jVLqWdyXa68GNiPjnlz6SyZivvekXL4qjIK1QxnQN1k=;
 b=NWCVsImzMofLLCER0EiYfy28cAj/31m25OJGSpoC0SRsOh6s7Htwuxq3sYOBzuggkx78t0
 bbAD6WTsnEtetZZCJOhe2oPsVPAXrHRvkciIZHdPqclDcdVH32r8XBoGefuCQSAhtJi33O
 xa0dmJK5XcFpnb9AMLYrAlqGFByR4w0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-73dKZI-tNaCC53YFrCiGTA-1; Tue, 19 Mar 2024 02:32:13 -0400
X-MC-Unique: 73dKZI-tNaCC53YFrCiGTA-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5a486a8e1fdso3234920eaf.2
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 23:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710829933; x=1711434733;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jVLqWdyXa68GNiPjnlz6SyZivvekXL4qjIK1QxnQN1k=;
 b=a2SZBPhvGVqMgKzi1GGrllVmGocTL+dq7V+lo3DDBOlK9FqsB9sa5/kRdKJuDOxe8f
 uMNStZ9XKFbuJZ9chopLKKtAKN7tQKSDYES8P6a8YV2dHNtNJfjhx7x9eNUy95vmO5/T
 v/fp9Fd+XrUi3sCOWRSHIS/AScCIcLB/ZTr6XZMdltBg/utFjW5k/8GtPwYa+8i1BF9a
 fzxP7Mo4+cEDa5tdZODTmPOpGdOVeesGQ23h7E3PUYiJrc6MFjVJjTmLG5qAwPmREjjC
 LH8YkhVNvbm7Lg0F1lHb65riAQMk/DsBL+YhfjuoIQSXq2xbHRTRGdnrQ0DxjOzzW3Bf
 hCYg==
X-Gm-Message-State: AOJu0Ywvz4mG9Ku4ggsIl18dpNpfEMcFU5vEJncF29DV7lcZNSPyaALE
 sdw8PxjObGkzgo0U64C7W80Z+7G0K/EdRybhbjApVJfxWFyFakiIp80nkXf7hYphz9AZU6IqZIN
 d4MkkY8M58RGbEYSi2EeSfs8BohEd8EKl7umzDiKXehbPA6Mo2m1ACYd/GPNgMCD+fxk6fljfDo
 1PsBT9wqGXisgNSdaavAHIvIU=
X-Received: by 2002:a05:6820:1609:b0:5a1:17bb:40d7 with SMTP id
 bb9-20020a056820160900b005a117bb40d7mr13855397oob.2.1710829932953; 
 Mon, 18 Mar 2024 23:32:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHeGm+262s8dOSaKUfclPSLZ4sVKedc5nxXbHqbbHnK8S7y7lBzHaHpFNn9utQqxWapnCXqc6oRFxwOwtDwN8=
X-Received: by 2002:a05:6820:1609:b0:5a1:17bb:40d7 with SMTP id
 bb9-20020a056820160900b005a117bb40d7mr13855388oob.2.1710829932666; Mon, 18
 Mar 2024 23:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240318162539.407214-1-pvorel@suse.cz>
 <20240318162539.407214-2-pvorel@suse.cz>
In-Reply-To: <20240318162539.407214-2-pvorel@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Mar 2024 07:32:49 +0100
Message-ID: <CAASaF6wL5s4kEpCmcfh8SE1qJ4dgBL57z2o+nx1YodLzeEvYcg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] include: Move inline functions to special
 header
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

T24gTW9uLCBNYXIgMTgsIDIwMjQgYXQgNToyNuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IDkxMjBkOGEyMiAoInNhZmVfbWFjcm9zOiB0dXJuIGZ1bmN0aW9ucyB3
aXRoIG9mZl90IHBhcmFtZXRlciBpbnRvIHN0YXRpYwo+IGlubGluZSIpIGNoYW5nZWQgc29tZSBm
dW5jdGlvbnMgdG8gaW5saW5lIGJlY2F1c2UgdGhleSBkZXBlbmQgb24KPiAtRF9GSUxFX09GRlNF
VF9CSVRTPTY0LiBTZXBhcmF0ZSB0aGVtIGludG8gaXQncyBvd24gaGVhZGVyLCBiZWNhdXNlCj4g
bm9ybWFsIGZ1bmN0aW9ucyBzaG91bGQgYmUgaW4gQyBmaWxlcy4KPgo+IFNpZ25lZC1vZmYtYnk6
IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgoKSSdtIGZvciBzZXBhcmF0aW5nIHRoZXNlIHRv
by4KCkFja2VkLWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
