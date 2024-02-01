Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5811DC47DDB
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 06:57:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 650B93CF8D7
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 07:57:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6E4C3CE189
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 07:57:32 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DFEF5200245
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 07:57:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706770650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=esf4kHGL5oZHJmeal6O+ztJM9fCrVJzUVMeEHprO5rc=;
 b=Kr27aC3WoXd2pjCp2Zm0y96yii5vYYLE7ZuklRUGtfZepgte9f76qyD8ff4LrSrAOqQEn/
 FcD5+ufVZDPWnSK33728eNSqLE2pVyxE6vf+PDuErOwy9BksxqMh8JCiJFOn1vIRKDtRqk
 QEu1za3WQ4xqZ70K1+ASNFI6wTVY5vY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471--uudtBmlO_eUO4gX86Wz_A-1; Thu, 01 Feb 2024 01:57:28 -0500
X-MC-Unique: -uudtBmlO_eUO4gX86Wz_A-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6ddc261570cso613320b3a.0
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 22:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706770647; x=1707375447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=esf4kHGL5oZHJmeal6O+ztJM9fCrVJzUVMeEHprO5rc=;
 b=HtdaqT0muZDmeFM0YNsp9SMS+bqE5tKLG6sLMsX15FkQrN4S1BQMZHpR1w+PzkCGJv
 oYEOLavuD8lGtZL/95rFnSAKpqIZKs2KC0UOWZdBY9eTvkmXkDiE6rhWZg8Tkcq7H+i8
 1bJIYzOkmLCZ4ub5H/euuh+dcBFFVSkVvALeKEKTp9UsExx+0s7NIbuMtnChDWZ67WOC
 2tTSJdZioP8RMXGM2bPH27iqBL2/V+fa0NnzX+1aCnyX71cgESlM4syQKY5MHk8fDUa6
 LrzAojkAcU7mpZJQ5foRB9+3fjFRFNMQGxnEFRIg9+GbsUS76BiExIFOPc9Lylo8nVHA
 lBtQ==
X-Gm-Message-State: AOJu0YxaIamOpKt+QZqhDqbv8CknoOms5A+N4HibNumPUB9o0ZGQheuj
 NoBCWbYiT//+wcFlKf2JEeZWDJFNXpLd5db0Epor91+RVz5xJ1U2Go7tD0mjYnXlWCZ4Jm5VD5M
 YAZhxN5aqickbjVcGfi6lKfxLdbeqNlvSRdb7uGIM0HubKRMfNBNutKOa//2OVSkrf2WdEdnaj6
 CxA5LdmYJUiKe+bthCYpTIkaA=
X-Received: by 2002:a05:6a00:bc5:b0:6dd:9fc6:ee38 with SMTP id
 x5-20020a056a000bc500b006dd9fc6ee38mr3251973pfu.27.1706770647142; 
 Wed, 31 Jan 2024 22:57:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEPRHph78MIgguM3xDKM84lLJSeaZ/szWhX9nCUY4IqyigY/jQBXsvnCJfOaA5uZpAlOrDGK6DCxNZlI6tgHk=
X-Received: by 2002:a05:6a00:bc5:b0:6dd:9fc6:ee38 with SMTP id
 x5-20020a056a000bc500b006dd9fc6ee38mr3251964pfu.27.1706770646865; Wed, 31 Jan
 2024 22:57:26 -0800 (PST)
MIME-Version: 1.0
References: <20240131102514.2739270-1-liwang@redhat.com>
 <20240131102514.2739270-8-liwang@redhat.com>
 <20240131173840.GA18869@pevik> <20240131185310.GA30901@pevik>
 <20240131190122.GB30901@pevik>
In-Reply-To: <20240131190122.GB30901@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 1 Feb 2024 14:57:14 +0800
Message-ID: <CAEemH2fVdZdTnRUZSWCrZrqKYyuVWvu8nNQ4A=d3h7389KO3+g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [Patch v6 7/8] swapon/off: enable all_filesystem in swap
 test
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

T24gVGh1LCBGZWIgMSwgMjAyNCBhdCAzOjAx4oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBMaSwKPgo+IGFsc28gSSBnb3QgZmFpbHVyZXMgb24gcHBjNjRsZSBp
biBvdXIgQ0kKPgo+ICogc3dhcG9mZjAxIDYuNy4yIGFuZCBvdGhlciB2ZXJzaW9ucyB1cCB0byA0
LjEyIGJhc2VkIGtlcm5lbHMgb24gcHBjNjRsZQo+IC4uLgo+IHRzdF9zdXBwb3J0ZWRfZnNfdHlw
ZXMuYzo5NzogVElORk86IEtlcm5lbCBzdXBwb3J0cyB0bXBmcwo+IHRzdF9zdXBwb3J0ZWRfZnNf
dHlwZXMuYzo0OTogVElORk86IG1rZnMgaXMgbm90IG5lZWRlZCBmb3IgdG1wZnMKPiB0c3RfdGVz
dC5jOjE3MDE6IFRJTkZPOiA9PT0gVGVzdGluZyBvbiBleHQyID09PQo+IHRzdF90ZXN0LmM6MTEx
NzogVElORk86IEZvcm1hdHRpbmcgL2Rldi9sb29wMCB3aXRoIGV4dDIgb3B0cz0nJyBleHRyYQo+
IG9wdHM9JycKPiBta2UyZnMgMS40Ny4wICg1LUZlYi0yMDIzKQo+IHRzdF90ZXN0LmM6MTEzMTog
VElORk86IE1vdW50aW5nIC9kZXYvbG9vcDAgdG8gL3RtcC9MVFBfc3dhenUyZlRsL21udHBvaW50
Cj4gZnN0eXA9ZXh0MiBmbGFncz0wCj4gdHN0X2lvY3RsLmM6MjY6IFRJTkZPOiBGSUJNQVAgaW9j
dGwgaXMgc3VwcG9ydGVkCj4gbGlic3dhcC5jOjE0NjogVEJST0s6IEZhaWxlZCB0byBjcmVhdGUg
c3dhcGZpbGUKPgoKCkVyciwgSSByZXByb2R1Y2UgaXQgd2l0aCBhbiBSSEVMOSBwcGM2NGxlIHRv
by4KSSBndWVzcyBpdCBkb2VzIG5vdCBhbGxvdyB0byBjcmVhdGUgYSBmaWxlIHRoYXQgc2l6ZSBs
ZXNzIHRoYW4gcGFnZV9zaXplLgoKT25jZSBJIHJlcGxhY2UgdGhlIGJsa19zaXplIHdpdGggcGFn
ZV9zaXplLCBhbGwgdGVzdHMgZ2V0IHBhc3NlZC4KCgoKPgo+IFN1bW1hcnk6Cj4gcGFzc2VkICAg
MAo+IGZhaWxlZCAgIDAKPiBicm9rZW4gICAxCj4gc2tpcHBlZCAgMAo+IHdhcm5pbmdzIDAKPiAj
IyMgVEVTVCBzd2Fwb2ZmMDEgQ09NUExFVEUgPj4+IDIuCj4KPiAqIHN3YXBvbjAzIG9uIDYuNy4y
IG9uIHBwYzY0bGUKPiAuLi4KPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6NDk6IFRJTkZPOiBt
a2ZzIGlzIG5vdCBuZWVkZWQgZm9yIHRtcGZzCj4gdHN0X3Rlc3QuYzoxNzAxOiBUSU5GTzogPT09
IFRlc3Rpbmcgb24gZXh0MiA9PT0KPiB0c3RfdGVzdC5jOjExMTc6IFRJTkZPOiBGb3JtYXR0aW5n
IC9kZXYvbG9vcDAgd2l0aCBleHQyIG9wdHM9JycgZXh0cmEKPiBvcHRzPScnCj4gbWtlMmZzIDEu
NDcuMCAoNS1GZWItMjAyMykKPiB0c3RfdGVzdC5jOjExMzE6IFRJTkZPOiBNb3VudGluZyAvZGV2
L2xvb3AwIHRvIC90bXAvTFRQX3N3YVQ4WkQ1Ny9tbnRwb2ludAo+IGZzdHlwPWV4dDIgZmxhZ3M9
MAo+IHRzdF9pb2N0bC5jOjI2OiBUSU5GTzogRklCTUFQIGlvY3RsIGlzIHN1cHBvcnRlZAo+IEZh
aWxlZCB0byBjcmVhdGUgc3dhcGZpbGU6IHN3YXBmaWxlMDIKPiBzd2Fwb24wMy5jOjE4MDogVEZB
SUw6IEZhaWxlZCB0byBzZXR1cCBzd2Fwcwo+Cj4gU3VtbWFyeToKPiBwYXNzZWQgICAwCj4gZmFp
bGVkICAgMQo+IGJyb2tlbiAgIDAKPiBza2lwcGVkICAwCj4gd2FybmluZ3MgMAo+Cj4gKiBzd2Fw
b24wMyBvbiB2ZXJ5IG9sZCBrZXJuZWxzICg+PSA0LjQpCj4gLi4uCj4gdHN0X3N1cHBvcnRlZF9m
c190eXBlcy5jOjQ5OiBUSU5GTzogbWtmcyBpcyBub3QgbmVlZGVkIGZvciB0bXBmcwo+IHRzdF90
ZXN0LmM6MTcwMTogVElORk86ID09PSBUZXN0aW5nIG9uIGV4dDIgPT09Cj4gdHN0X3Rlc3QuYzox
MTE4OiBUSU5GTzogRm9ybWF0dGluZyAvZGV2L2xvb3AwIHdpdGggZXh0MiBvcHRzPScnIGV4dHJh
Cj4gb3B0cz0nJwo+IG1rZTJmcyAxLjQyLjExICgwOS1KdWwtMjAxNCkKPiB0c3RfdGVzdC5jOjEx
MzI6IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AwIHRvIC90bXAvTFRQX3N3YWhPZW9kdy9tbnRw
b2ludAo+IGZzdHlwPWV4dDIgZmxhZ3M9MAo+IHRzdF9pb2N0bC5jOjI2OiBUSU5GTzogRklCTUFQ
IGlvY3RsIGlzIHN1cHBvcnRlZAo+IGxpYnN3YXAuYzozNzogVElORk86IEZTX05PQ09XX0ZMIGF0
dHJpYnV0ZSBzZXQgb24gc3dhcGZpbGUwMgo+IEZhaWxlZCB0byBjcmVhdGUgc3dhcGZpbGU6IHN3
YXBmaWxlMDIKPiBzd2Fwb24wMy5jOjE4MDogVEZBSUw6IEZhaWxlZCB0byBzZXR1cCBzd2Fwcwo+
Cj4gU3VtbWFyeToKPiBwYXNzZWQgICAwCj4gZmFpbGVkICAgMQo+IGJyb2tlbiAgIDAKPiBza2lw
cGVkICAwCj4gd2FybmluZ3MgMAo+Cj4gQWxsIG90aGVyIHRlc3RzIGFyZSB3b3JraW5nLgo+Cj4g
S2luZCByZWdhcmRzLAo+IFBldHIKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
