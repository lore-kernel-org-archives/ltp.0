Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FA6C43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 09:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782810234; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=z0p+QdSAwbgnEMxfl6D874ihp0ddyRL+JidDzeJDSwA=;
 b=EVC1CFf7CHv/xtimKWjE7vFSQbeT+QrLBIODXXAgvvrSW2MypOa5ALnWHHfzh8UsvYIa3
 KYvyxiWxsScbNs6jNFX+LVMuoRfpkG62jl+6bYAXeR2ovrLeAeFysdGTAhOkNPt1iEK1eRQ
 Ol0D6ISMvmas4p5yzwk/Tg3MLhbVIDE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC2BC3E4B3A
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 11:03:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E95F3E4B29
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 11:03:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C8D30200D0E
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 11:03:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782810210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hfCmnlqavYDi2Tm6slj5d35vNb2rvWZxXWiFvgOfZ9w=;
 b=Su/V/9wdy2S1sG5OhdZ/NQ0EPILpLgVR2T3L2e9x5rP3DTuOXxXd4FeHK7d3BHmGqmn2HV
 Oj0gjffYo+Tvo/muIXh7lfBJM0il1NN6v+eLACFsedkcqfJ95w9HeZW9AUec9wiW87GHQA
 Lt4wzfOOw8rRzJAnURbc3OFG3dFcqsg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-EqYKu1kdPo6onW1YBe_xOQ-1; Tue, 30 Jun 2026 05:03:28 -0400
X-MC-Unique: EqYKu1kdPo6onW1YBe_xOQ-1
X-Mimecast-MFC-AGG-ID: EqYKu1kdPo6onW1YBe_xOQ_1782810207
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-475e540a0ffso182754f8f.3
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 02:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782810207; x=1783415007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hfCmnlqavYDi2Tm6slj5d35vNb2rvWZxXWiFvgOfZ9w=;
 b=cxK4RRbWJ60cFdvMoc8mI9pO2h5HqGltB6FttH6EAnJ+qvibUNHPa3EJpLWCI9w0ap
 jSJOyEpY0g+lDYgtHob8iWfrDkJSkXEfO/bwpF+6xala3B6fEnRIWLnwYAEEWXrvBQES
 UFOgpSMZ54M2/30AYL8AMd8nJbEWt4MjRKun56KXQFSk+Rqaiv5C2E6yxCSY/HZZ3Ojw
 BzC5rQ+gEMWqErWnpfx/JObUvmlElgYJePJMB0D3EGk2lD/QI7ox488w1RHI50E7k4+m
 Pzd7Sc7dQJ+Ri/XP8m9tAv+l1qDx9mmPwlt8J8BKCLITaWWLLBd/CqLKCNVGsJprcFjf
 oXYA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rotr2CAm+Kq/ZA9SgRsrDBO0VIduSuvn1AFgcxMSf/AZxBOzAXtn8FBGCLMf6cPubU/a0A=@lists.linux.it
X-Gm-Message-State: AOJu0YzPkAlbE4VYWL44fBRoFiM5ZnzYOQUcDP8IA5v/lrrfRWNIHcOV
 u0sKdNWPNpL2lX7lMTzoGZkFy9xaJ40NNHXUEjxkx7tvt4M2Atj/pQ6fiN/48vlSqjRaud1usVm
 QHIXWP22SIH6T+fx/sqRxr61AC4nWQdGO+JJYrOd2nTqZf4YqcTBOrcp3sjRkgbdziLDkBey1fQ
 MovhjGxOxfvzSXQxBkoMsd7QBMsE8=
X-Gm-Gg: AfdE7cndC0NEF8pq4zF+n2srW3L8SYIfff7Rsbd7S30HpkwKk8IV5HwcpM0zGZ0YIIV
 F3EsE3hWBQO/vmjudlaqW9GfiHFxsmG4laKSAOKMPB3gIbnwmThAGnZUmNNI4501FYDNA1Q0Nto
 i73HpuOMD4s4c4iuO9TS+YS9HTTimzbXXLMDj9zHur+Yeq/Z7BFSIvr7WyoFlui/Vf+Co=
X-Received: by 2002:a5d:5d0c:0:b0:474:9002:c749 with SMTP id
 ffacd0b85a97d-47550ac1891mr4110364f8f.17.1782810206610; 
 Tue, 30 Jun 2026 02:03:26 -0700 (PDT)
X-Received: by 2002:a5d:5d0c:0:b0:474:9002:c749 with SMTP id
 ffacd0b85a97d-47550ac1891mr4110296f8f.17.1782810206121; Tue, 30 Jun 2026
 02:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260429105644.986278-1-pvorel@suse.cz>
 <6a4377a6.51d65a57.19e759.3280@mx.google.com>
In-Reply-To: <6a4377a6.51d65a57.19e759.3280@mx.google.com>
Date: Tue, 30 Jun 2026 11:03:08 +0200
X-Gm-Features: AVVi8Cf7s-1eXpYsUx-3O3Urp3kndeaO8lC907GZeErtdabpSewcu81i08mumCM
Message-ID: <CAASaF6w2cwaYmWBcJi3Dm3Pu_d0R4jUaN8wJLTbwt4M4Tv5a-g@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 55CQ7AswwzWgd5NzAxMvao1LdjRyhsRN2yoNzS8aBNQ_1782810207
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Move runtest/irq into runtest/kernel_misc
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: Tim Bird <tim.bird@sony.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdW4gMzAsIDIwMjYgYXQgMTA6MDDigK9BTSBBbmRyZWEgQ2VydmVzYXRvCjxhbmRy
ZWEuY2VydmVzYXRvQHN1c2UuY29tPiB3cm90ZToKPgo+IEhpIFBldHIsCj4KPiBhbnkgbmV3cyBh
Ym91dCB0aGlzPyBDYW4gd2UgbWVnZSBpdD8KCisxCgpBY2tlZC1ieTogSmFuIFN0YW5jZWsgPGpz
dGFuY2VrQHJlZGhhdC5jb20+Cgo+Cj4gUmVnYXJkcywKPiAtLQo+IEFuZHJlYSBDZXJ2ZXNhdG8K
PiBTVVNFIFFFIEF1dG9tYXRpb24gRW5naW5lZXIgTGludXgKPiBhbmRyZWEuY2VydmVzYXRvQHN1
c2UuY29tCj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
