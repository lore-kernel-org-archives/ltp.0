Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3DBEB64D8
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 12:38:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02FAA3CC4A9
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 14:38:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87E783C9CFA
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 14:37:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C8BAB100054B
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 14:37:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687351068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WCBib3kmLAopYJEbGreh6Vfy7/7wJNEWHVPCGUfgMq0=;
 b=Z4ToiXEAMANPN+vQUCuFApG+gGi1OXkg3Gkw5xZnnZEl8jvpeGCGYUYeqkN5sorVsFzB9i
 0JnSAdWM4XQaOJmDNZH1FF5TPB4lxDLYLt2qkZYJgqPrQ1VHfaiLfJY3PAQGk0GkU/GThX
 NHO6KKTdZOKQ60DLB7kpr6/hqx3Z8L0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-5vD-A96YOBKZrLdqX4TPAQ-1; Wed, 21 Jun 2023 08:37:45 -0400
X-MC-Unique: 5vD-A96YOBKZrLdqX4TPAQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b3468c6b6cso45585351fa.1
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 05:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687351064; x=1689943064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WCBib3kmLAopYJEbGreh6Vfy7/7wJNEWHVPCGUfgMq0=;
 b=D2O4n1KLf+D5BtYpuSMv+joWOnriDcZANdUFW9PiviIyJOiiM6xT7QQ6yj8JikM5/H
 lNeibJK55bQw8ICwaeKwLTvHCJchDUL+OBJmc0sEjofsZmfwtR7ATtwkeCtz8hGVgMBO
 Xqk9FaebhpoSXhosWUhebpnFOKWAMS6npQpEtlMu5TyafYs8fVIzIzYkFstlU5jxsdij
 bYC6bT3r7hziMaMeFSzQqIDg9qsk4mtSPEtOi++Ap9DqDyAdJek+y7EBInnjUJ651Rp/
 RRoBw4xy4It9SblJ24m3WV4+K5dQgIeLK0iGH0hTRTaPwbr92XnTRT2ku2TjY2hQVTf7
 Uc1w==
X-Gm-Message-State: AC+VfDyL+WGolffqkBFGI224YHYLDiFX+rQUnjGjXDaIOQTtBUBoIEX4
 3hgFyPclBLgqGu8jLcMX487ISUw3i1H5/qwXMqoWv3YlPR+atrBb9JGxveKE52kVQpGonxn1pyO
 p8dsU0eC7/U0bDXSCQ1Pq4XLZsak=
X-Received: by 2002:a2e:9682:0:b0:2b4:8168:2050 with SMTP id
 q2-20020a2e9682000000b002b481682050mr5179230lji.29.1687351064091; 
 Wed, 21 Jun 2023 05:37:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78vcbZKOu4o+rw5AJqtkvmlJ0BYMxo4dwz1++xMHOv/ve+nISYNd5/OtglV+TegLl9L91ivWcVcCHNAaJFZMM=
X-Received: by 2002:a2e:9682:0:b0:2b4:8168:2050 with SMTP id
 q2-20020a2e9682000000b002b481682050mr5179218lji.29.1687351063783; Wed, 21 Jun
 2023 05:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230621115443.12676-1-mdoucha@suse.cz>
 <20230621123140.GA407092@pevik>
In-Reply-To: <20230621123140.GA407092@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 21 Jun 2023 20:37:31 +0800
Message-ID: <CAEemH2ezk8Z-vxUWF=zoMk8LKvCqmu_9XG=ExN8Xi5Sk+EwLpA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] Remove KVM tests from CVE runfile
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

T24gV2VkLCBKdW4gMjEsIDIwMjMgYXQgODozMuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTWFydGluLAo+Cj4gPiBLVk0gdGVzdHMgYXJlIGN1cnJlbnRseSBs
aW1pdGVkIHRvIGJhcmVtZXRhbCB0ZXN0aW5nIG9mIHg4NiBtYWNoaW5lcwo+IG9ubHkuCj4gPiBU
aGV5IGhhdmUgdGhlaXIgb3duIHNwZWNpYWwgcnVuZmlsZS4gVGhlIENWRSBydW5maWxlIGlzIHVz
ZWQgZm9yIHRlc3RpbmcKPiA+IGFueSBhcmNoaXRlY3R1cmUgYW5kIG1hY2hpbmUgdHlwZSBpbmNs
dWRpbmcgdmlydHVhbCBvbmVzLiBBZGRpbmcgS1ZNCj4gPiB0ZXN0cyB0byBpdCB3aWxsIGNhdXNl
IG5vbi14ODYgcGxhdGZvcm1zIHRvIGNvbXBsYWluIHRoYXQgdGhlIHRlc3RzIGRvCj4gPiBub3Qg
ZXhpc3QuCj4KPiBHb29kIHBvaW50LCBJJ20gc29ycnkgSSBmb3JnZXQgb24gdGhpcyBkdXJpbmcg
cmV2aWV3Lgo+IE1lcmdlZC4KPgoKVGhhbmtzIGZvciBkb2luZyB0aGF0LgoKPgo+IEJUVyBJIHdv
bmRlciBpZiB3ZSBzaG91bGQgcHV0IHNvbWUgbm90ZSB0byB0aGUgZmlsZSB0byByZW1lbWJlciB0
aGlzIGluIHRoZQo+IGZ1dHVyZS4KPgoKKzEsIHRoaXMgd291bGQgYmUgaGVscGZ1bCB0byBwZW9w
bGUgd2hvIGFyZSB1bmZhbWlsaWFyIHdpdGggdGhlbS4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
