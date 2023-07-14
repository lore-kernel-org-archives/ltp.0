Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B952EB64DA
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 09:25:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0ADD63CD7CC
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 11:25:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADA623C9753
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 11:25:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AD67A1A00FAD
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 11:25:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689326735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6jC4RHx9TX7NuZZfd8Txtv5QglAk5HDAmXmOOl+iYlY=;
 b=TpFSd8NPOKLqY582IKoSzkyOg2sLOVPrg3ovy7VzjCJUeGaI2GOy5Amepay2+iDwQKZOnn
 K8ZjM0+YKEl6xwP6hKcyFZlpaWVdoZjILgqzyNaAC9uWt3C8r/td3n+s+fik7x5+j0uqsF
 7nC9d9iKq+bhJCAHy1dS8h3c6dP2cHw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-tgjOnDnKNiejsSdQCWSKgA-1; Fri, 14 Jul 2023 05:25:33 -0400
X-MC-Unique: tgjOnDnKNiejsSdQCWSKgA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fbe11238a1so1645556e87.0
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 02:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689326731; x=1691918731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6jC4RHx9TX7NuZZfd8Txtv5QglAk5HDAmXmOOl+iYlY=;
 b=ElVcZZL90wZ909ugqMPSiPSgEtVBmmB+QmRlbsf/F9CaJcpk6xTWVq+u8VBa0T13Nd
 2SVjDjc2dtp75FaRAHYgWyOG9lefGKTPWtk03lADPt9uBBkDqy26jtsvxniEPnIps+vD
 bx8ADyFF4yl7XLXo3bLBORjjoM76HHiL8PGrhv6+sP7W0jftj8VLNzV43SNtScpWkFBI
 wxASly/SeUv/dt36N1W/MxsVn+bezeCdrMPX4WS8e01usRaTKnwh3jUIdFVzF6N5NGfa
 2HDTWf6bP50gXWMIQ3kmkAFx2mUMxt5nx+bouLssSAcLFqjspgpnqNApjDFo2us7qmZw
 mmCw==
X-Gm-Message-State: ABy/qLZOguFe6dWTNXbUiUVCr/0FLO1NY5jjDt5BQchyHWLBfH6di59V
 vtcdXGOh9t7CXxMnmTT84KsYlfNMeptHWoY366M4fTQYC7ox/WxPK8jTRAWJ34BVdDlPdH7fO8p
 jvTqATOpgLDmLRBvDM4+GoVHXK7WUFK8sjAZVnA==
X-Received: by 2002:a05:6512:2315:b0:4f6:3ef3:13e8 with SMTP id
 o21-20020a056512231500b004f63ef313e8mr812259lfu.0.1689326730956; 
 Fri, 14 Jul 2023 02:25:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEfyZVini4TIXQYy80DymNU+tzrTPiloOouAMWrA0utU2GR5jUVLPxVqBFFD6QV9FqurnFdNG9q0mqSVPZiM+A=
X-Received: by 2002:a05:6512:2315:b0:4f6:3ef3:13e8 with SMTP id
 o21-20020a056512231500b004f63ef313e8mr812253lfu.0.1689326730635; Fri, 14 Jul
 2023 02:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230704091933.496989-1-pvorel@suse.cz>
 <20230704091933.496989-2-pvorel@suse.cz>
 <20230704092536.GA497945@pevik> <ZK_m_8OuewzitKmH@yuki>
 <CAEemH2eE8PUY_at7C-aUX+75ALdM-jjm71L=M-ETYc94RKJFcg@mail.gmail.com>
 <ZLDvTYhGI6_Q5vDE@yuki>
In-Reply-To: <ZLDvTYhGI6_Q5vDE@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 14 Jul 2023 17:25:18 +0800
Message-ID: <CAEemH2eGdcF0HiERH5d6UG09R_GfXHScUxCgu7hcjhNApRSkeA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH 1/3] Makefile: Add C header with generated LTP
 version
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

QWgsIEkgc2VlLCB0aGFuayB5b3UgYm90aC4KCk9uIEZyaSwgSnVsIDE0LCAyMDIzIGF0IDI6NDXi
gK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIQo+ID4gU28g
d2h5IG5vdCB1c2UgdGhlIHNjcmlwdCB0byBhcHBlbmQgdGhhdCBvbmUgbGluZSBpbiB0c3RfdGVz
dC5oIGRpcmVjdGx5Pwo+Cj4gVGhhdCB3b3VsZG4ndCBwbGF5IG5pY2Ugd2l0aCBkZXZlbG9wbWVu
dCwgeW91IHdvdWxkIGhhdmUgdG8gbWFrZSBzdXJlCj4gbm90IHRvIGFjY2lkZW50YWxseSBjb21t
aXQgdGhlIGxpbmUsIHdoaWNoIHdvdWxkIGhhcHBlbiB3YXkgdG8gb2Z0ZW4uCj4KPiA+IFRoZSBs
dHAtdmVyc2lvbi5oIGxvb2tzIHF1aXRlIHJlZHVuZGFudCBhbmQgd2UgY291bGQgZXZlbiBwdXQg
dGhpcyBzY3JpcHQKPiA+IGludG8gYnVpbGQuc2ggdG9nZXRoZXIsIElNSE8uCj4KPiBUaGUgZW5k
IGdvYWwgaGVyZSBpcyB0byBoYXZlIHRoZSBMVFAgdmVyc2lvbiBpbiB0aGUgdGVzdCBvdXRwdXQK
PiByZWdhcmRsZXNzIHdoZXJlIGl0IGNhbWUgZnJvbSAodGFyYmFsbCwgZ2l0KSBhbmQgaG93IGl0
IHdhcyBjb21waWxlZAo+IChidWlsZC5zaCwgY2QgdGVzdGNhc2VzL2tlcm5lbC8gJiYgbWFrZSwg
Li4uKS4gVGhlIG9ubHkgd2F5IGhvdyB0byBkbwo+IHRoaXMgaXMgdG8gcmVmcmVzaCB0aGUgdmVy
c2lvbiBvbiBlYWNoIG1ha2UgYW5kIGJ1aWxkIGl0IGZyb20gaW5zaWRlIHRoZQo+IGxpYnJhcnku
Cj4KPiAtLQo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNAc3VzZS5jego+Cj4KCi0tIApSZWdhcmRz
LApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
