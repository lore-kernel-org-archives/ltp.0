Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00ACC35FFC
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 01:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742435078; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=6xSfOwuiAE6/YjPzI5OYvZoFBStus5nh2oGa00X23Vc=;
 b=MtAgPqZMbDyxnGGhxJMYPhKlPqjaM39oN/C5vVC3saQ0XRHZFbDZ6TKvgXjFBtfl+dyXM
 dI50BSx2Tva2CwlfViysozwE4zFRxtSQfM3veUnehWWgmhGpJ5VQ8/b+MOQq5IK09M3AICA
 tlD278ctawkmUR2HSnofP5VriHcuomw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B5BB3CADFA
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 02:44:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71DD63CADA7
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 02:44:16 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 33554600760
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 02:44:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742435052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P8AKgvkerNSlVycgii+qzHgeQ2eZhYAjIJ7v1vyx95o=;
 b=FbxDhKcaiO6dqVnrDSRFeHcn9Le28RP6px1LKcvD94e5i8X/n5X2JXh1Yc+i8+QGe65AFa
 vvMCnbOyMbm9HwgqGkCsAlfA3OMXfMvjIHGGXYoE3c4xjDGj5m/Bz0jLXgHszvvLAvVPmM
 ziz3yBIC58QG2WFJqjMgafvq2+PAjqs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-f_8ICefOM4aDo7d5IFuYbw-1; Wed, 19 Mar 2025 21:44:10 -0400
X-MC-Unique: f_8ICefOM4aDo7d5IFuYbw-1
X-Mimecast-MFC-AGG-ID: f_8ICefOM4aDo7d5IFuYbw_1742435049
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3011c150130so428420a91.2
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 18:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742435049; x=1743039849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P8AKgvkerNSlVycgii+qzHgeQ2eZhYAjIJ7v1vyx95o=;
 b=KZavEXTUHvgV5EQsIOrFQRh3hHrg3++6goBWOrrzDrTc5AKbMAphEZUMlK9NiMu1P9
 VRWw7pr7km3F8GXfgwNHwJJrBaQ0HhE8/Jhr9+YEMnRuWyfSHT2eP/qeKgXgglWPyfi1
 HslHAejnKf/VCZmGk3l4UOmalyQg/bXs/H0Xld1GFJjUwPtN862Gr3q6Hn9cVJlZJzL8
 6i/BmS24hdG0YkeOEGYrvdY4sBpG+zLpN+PggtiqD7c+KjzUIpG3rfops6klE8L0DZ+t
 f1EdxCt+9GvnhiLLvJhUVlKrqpC77iWFqVdOqeChc3BozMC+vUakUVXUaQ7JaB682LNb
 YeJQ==
X-Gm-Message-State: AOJu0YyiTWCaREK6bJJC23CKuTQepix3Wqa1HvqWSulni2u2iJ0yi9dZ
 HT+ZohBa/DbWY7el8H+Qy9R/Oczj/ZOk2PnZdHNyM46+ONJMQ3nGSUq92vJTEv1tBzotp7g7Kje
 9XoFGecHCwJZAfPShH7633OEzsLglLzWcCOHJV0cFkO2MCaTzNHpCKsZENUqMl/B4p0gQS5yUXg
 ymV+gefkaBy7mRy4C62H1RFSM=
X-Gm-Gg: ASbGnctwKmeqUg3NypPOVaAhnr3FVxuRmFqcgdZ/4rYr6zrAzpGDF3RrpP1NWw9iykk
 7nYSaPJsdPJlquTqcQCJ8/8A8Iu/AcwUHBLr3FwvWd+BQEPVIqCU+DfEbgBma0/DW5XM+G1DVdQ
 ==
X-Received: by 2002:a17:90a:e18e:b0:2ee:9b09:7d3d with SMTP id
 98e67ed59e1d1-301bdf93661mr6976128a91.19.1742435049187; 
 Wed, 19 Mar 2025 18:44:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm2reVmF4T3lcuci6uwNlhptpk26foGqDa5tZT3bPdjye0OzJelDw5qbHkQirWPjyiwdQdPenH4WwrNBSdre4=
X-Received: by 2002:a17:90a:e18e:b0:2ee:9b09:7d3d with SMTP id
 98e67ed59e1d1-301bdf93661mr6976114a91.19.1742435048887; Wed, 19 Mar 2025
 18:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250319172424.42961-1-mdoucha@suse.cz>
 <20250319172424.42961-2-mdoucha@suse.cz>
In-Reply-To: <20250319172424.42961-2-mdoucha@suse.cz>
Date: Thu, 20 Mar 2025 09:43:57 +0800
X-Gm-Features: AQ5f1JolIQzztTXY_JQTseWQfPJbh0CS1VkN9fbz8TjtRGM1HPzW3AdqtTHqiFI
Message-ID: <CAEemH2eUkVZKY6=73hC1+_0KBABh-cJKM5_2kJwe493hB7GKpw@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7pXV2UCX-tYSBXjfZkMYNiRF3kPl8USApCGYwC0fJxM_1742435049
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] move_pages12: Increase loop count to 10,000
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

T24gVGh1LCBNYXIgMjAsIDIwMjUgYXQgMToyNeKAr0FNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFA
c3VzZS5jej4gd3JvdGU6Cgo+IFNpbmNlIHRoZSB0ZXN0IGRvZXNuJ3QgcHJpbnQgaHVuZHJlZHMg
b2YgRU5PTUVNIGVycm9yIG1lc3NhZ2VzIGFueW1vcmUKPiBhZnRlciB0aGUgcHJldmlvdXMgY2hh
bmdlLCBpdCBub3cgcnVucyB0b28gZmFzdCB0byByZXByb2R1Y2UgdGhlIFNJR0JVUwo+IGJ1Zy4g
SW5jcmVhc2UgbG9vcCBjb3VudCB0byBtYWtlIHRoZSBidWcgcmVwcm9kdWNpYmxlIGFnYWluLgo+
Cj4gU2lnbmVkLW9mZi1ieTogTWFydGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6Pgo+CgpSZXZp
ZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgoKCgotLS0KPiAgdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9tb3ZlX3BhZ2VzL21vdmVfcGFnZXMxMi5jIHwgMiArLQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdmVfcGFnZXMvbW92ZV9wYWdlczEyLmMKPiBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW92ZV9wYWdlcy9tb3ZlX3BhZ2VzMTIuYwo+IGlu
ZGV4IGE1NDU0YjFlYy4uNDQwNzczYTM4IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvbW92ZV9wYWdlcy9tb3ZlX3BhZ2VzMTIuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvbW92ZV9wYWdlcy9tb3ZlX3BhZ2VzMTIuYwo+IEBAIC03NCw3ICs3NCw3IEBA
Cj4KPiAgI2lmZGVmIEhBVkVfTlVNQV9WMgo+Cj4gLSNkZWZpbmUgTE9PUFMgIDEwMDAKPiArI2Rl
ZmluZSBMT09QUyAgMTAwMDAKPiAgI2RlZmluZSBQQVRIX01FTUlORk8gICAiL3Byb2MvbWVtaW5m
byIKPiAgI2RlZmluZSBQQVRIX05SX0hVR0VQQUdFUyAgICAgICIvcHJvYy9zeXMvdm0vbnJfaHVn
ZXBhZ2VzIgo+ICAjZGVmaW5lIFBBVEhfSFVHRVBBR0VTICIvc3lzL2tlcm5lbC9tbS9odWdlcGFn
ZXMvIgo+IC0tCj4gMi40Ny4wCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
