Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48035EB64D8
	for <ltp@archiver.kernel.org>; Thu, 22 Jun 2023 08:57:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1333F3CD986
	for <ltp@archiver.kernel.org>; Thu, 22 Jun 2023 10:57:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 201583C9A35
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 10:57:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2BB081000A5B
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 10:56:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687424218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NXmLSApMGHb2ytErrUdEF7X1LNjrxI2qX9FQtvnpOcw=;
 b=Roew+RDm0wjexsmuyoLA0LeHhVUijOvL5pfTEga3tCNPBI7pMuu9BgLwelIqYCd2Tnkdtq
 yJXy/Ej7JES4oLTN0tKEfzhtHIS1i/lOi+Cidcm4Tcw6MJ8407pjV1qOlPaCSs6RSrli5V
 c51wf14M19QHAycLFZ+f+swdsh2qj+8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-F7hyBIqIPfabRmdncpT5Lw-1; Thu, 22 Jun 2023 04:56:56 -0400
X-MC-Unique: F7hyBIqIPfabRmdncpT5Lw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b479d12b31so39082561fa.3
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 01:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687424214; x=1690016214;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NXmLSApMGHb2ytErrUdEF7X1LNjrxI2qX9FQtvnpOcw=;
 b=c/ClH00ym1ZQNnT9tXEngDBZFX4aCT45awHe9yFc/gLVWDv6Iuvp2UI/PbDqsVuURV
 Q68LPDXTcUiCSjDDMXYWWq4SrcWYEFMMzILQf+Ge88LBoGCT4bz5ESG+IwsPR63GKM/8
 qK2WojM4uF6S93IDv6Y8ds1CMafz+Bup8ARcdb86UXF4OssAPudl93dh5BnDjH0mrm52
 Q2EqMU7sgXja4+4HwbkaGhznDe6I3L+vYPT5W438zhaJ7NTfniqJI2dcvCqJTcu3WKFy
 qrlkYXpVpsdjsEyjzBcg9KeAc67D/0JTpsVzOPtN60boO0ChZ8XWWAlFHD7w5+mPlUu0
 z4tQ==
X-Gm-Message-State: AC+VfDwgsaGwYI1ZQ7b7iFqp1NwjYun7NYJDIqhPCJdMfsbMGdgE0jsu
 KTPsh47CMU7bUVeZEF/dA2/oiDtgCKKDLvjQB4AJA8zpkgJojOPf+GaXoAQH5DBjLANQNLnMh3Y
 maUfyXyBSgc8sQBid+wQEYz1MZQWcJ06Zhl4T3g==
X-Received: by 2002:a2e:8904:0:b0:2b4:90bb:c358 with SMTP id
 d4-20020a2e8904000000b002b490bbc358mr6121369lji.42.1687424214202; 
 Thu, 22 Jun 2023 01:56:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7XhBZs0KRWEVvfBiaioEEQV9Hm/eEVvy8G9KDwB6HK/n8v1r2MTnymIAVGx0Lu/32c4s6blZUKtxbao9YjS34=
X-Received: by 2002:a2e:8904:0:b0:2b4:90bb:c358 with SMTP id
 d4-20020a2e8904000000b002b490bbc358mr6121360lji.42.1687424213895; Thu, 22 Jun
 2023 01:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230529061135.24261-1-liwang@redhat.com>
 <CAEemH2dwz_TTzc4vucOcHyR1nMe2rcF0z9DN0P3Ct5PXS_2WFw@mail.gmail.com>
In-Reply-To: <CAEemH2dwz_TTzc4vucOcHyR1nMe2rcF0z9DN0P3Ct5PXS_2WFw@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 22 Jun 2023 16:56:41 +0800
Message-ID: <CAEemH2dnUKPukvCXTTunig_PVNwr=2W2=V5rd04R2oxgB2sWRg@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] hugemmap32: release mem caches and prepare
 for hugepage
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKdW4gMjEsIDIwMjMgYXQgMTA6NTLigK9BTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cgo+IHBpbmd+Cj4KPiBJZiBub2JvZHkgb2JqZWN0cyB0byB0aGVzZSB0d28g
c2ltcGxlIGltcHJvdmVtZW50cywKPiBJIHdvdWxkIHB1c2ggYm90aCB0aGUgbmV4dCBkYXkuCj4K
CkJvdGggcHVzaGVkLCB0aGFua3MhCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
