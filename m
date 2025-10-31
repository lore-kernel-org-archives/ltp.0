Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A04CCF9FF
	for <ltp@archiver.kernel.org>; Fri, 31 Oct 2025 08:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761900334; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=53tuteeWgFDiaoVXIaV/aUuni7yWd4SgMPKFLjmUGNo=;
 b=Oksnt+3KH+CJx4sByJd4bdxNzz6KqjYDsKPFbTGqRKc0UXQEK6ogIiav/04WYMHi07Et9
 GUjEnWPetzilrOcL3napwgBDLOi34SH9PFX/qadIeihP75Z6y8CDUL2Ov4tyd/gcaFrG/ow
 GTxCmZ7nBOGi57GHFI3CbZUC0gZ0Ieg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 397EB3CCA24
	for <ltp@archiver.kernel.org>; Fri, 31 Oct 2025 09:45:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E94FD3CC834
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 09:45:13 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4DD301A00357
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 09:45:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761900311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eZRbBvjYXpGUtyg+eVlMr0iTxXEE5DXeBiaMI9wfZQY=;
 b=CcIBlmoIcZRozp30qJihOUG4qEJlXdaKqA7UD1bBXqiJUDZmnC3r9s37TNelXbRHrIDzoq
 1KRtXfKwkz3ItiZAlNYaEdsO0f0sQ2jNYUgafLYXJ4oS5oSGpbdp/+ilfQbveCyKV+oqZH
 u9UPkfjE3Xe0t+UGnM9GRNhzS4QVjeE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-RHUWZCLCMnuTIzvZvFy2mQ-1; Fri, 31 Oct 2025 04:45:07 -0400
X-MC-Unique: RHUWZCLCMnuTIzvZvFy2mQ-1
X-Mimecast-MFC-AGG-ID: RHUWZCLCMnuTIzvZvFy2mQ_1761900307
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2904e9e0ef9so44122985ad.3
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 01:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761900307; x=1762505107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eZRbBvjYXpGUtyg+eVlMr0iTxXEE5DXeBiaMI9wfZQY=;
 b=ehoU4mQwGJ1lwyK2RyFdja151BjVc8dJ+TzJoYeJCUg4snGWFIJKU10/MpsZ0+6eTU
 Cc4ukBXTdBlTd4fbWsy8Vi1bd9h/qIrvkAPNrny6qpgFyYMIe34/UpwCz7zNxslw8/WQ
 XXBEgpjRmGQ9oKLEzqYee0RKgTCLuGRfvah0EDUnk3rubI7js/NkSSfLeZ7gfmcjE4vS
 rhwWylF66mBBYlS5V/LqzsZOEpPFQTeWMoYIj3nWjgpkqOQLww8lQt/36/HL7U45gND1
 WMvw/QJa11Ml4jrkWu4pe1zCvgJXka+IllfHhJIcVSjcqoLfzKhiNSMtEv4ESgYQTQvw
 udGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfOTUWpeC3TKTdQnEkjvOKQXMkxczU5BBuJ7QIFhE8UA7EoV4ZXiMpZKfMaUWCYX9ndsI=@lists.linux.it
X-Gm-Message-State: AOJu0Yy7lf10GYdgd7p7QxydHG2AHqjAhrwUodn9uvYRvGHsMHzvb85r
 +1Ovch7L52ZCklm8Ttri68Xh+6v+nNipoTuC3uUs/hKPrOWHL3xeqXqobDYqYgvCEbw5wfvtorp
 N81EEB4xjfV1V+UMwcS7ZtxbjuRNCNjubvU/leiYaMUOHodg+9RjpPapsm2paNIR7fjCtkrtWL4
 SK3COGAqUUYHnO+q8LC2S04iDPluU=
X-Gm-Gg: ASbGncsIsBles5CN+2+cAtdsmP05Q4uzj7hxyzz6SjdUTvJTvgaRZtTJB7MRnDIrwSe
 4RYtBiKBp9xOmK0ni7e1Z12FV8slMb/KCMxfxPLvOtfETbUgCBLmt7l+gHUP2OEQl9HyaoeD3Z4
 3KPY6iNUqhBr5jnjXHjohGzPDafaEgN558BrtqEl7LpnOsyItp2iKJ5v/O
X-Received: by 2002:a17:902:e5d2:b0:295:2276:6704 with SMTP id
 d9443c01a7336-29522766adbmr26864965ad.51.1761900306838; 
 Fri, 31 Oct 2025 01:45:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRXrbuUvptlW0tpNVE5OZPq/uwmPQQh36AowaJoO6lkGpi4Yc9CrKwkabGD7WET/YluiuYoJ9EiilPZbQEgtk=
X-Received: by 2002:a17:902:e5d2:b0:295:2276:6704 with SMTP id
 d9443c01a7336-29522766adbmr26864695ad.51.1761900306492; Fri, 31 Oct 2025
 01:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20251031004445.25185-1-akumar@suse.de>
 <20251031081346.GA800577@pevik>
In-Reply-To: <20251031081346.GA800577@pevik>
Date: Fri, 31 Oct 2025 16:44:54 +0800
X-Gm-Features: AWmQ_bnOfExm7PAN3NV07rN6k4Y-fEesBrgiwkFjU1BBFy2IEN0WnYOAVfd9uv4
Message-ID: <CAEemH2e5RpG829uHWSdLepDFSkmu4tO5NX4Sv6-38H7G467xWw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4l2qaGzOxPiAZ6AxVQTE4u7oAGa8o3qm0ssEgRYyIN0_1761900307
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] swapon03: Correct the test swapfile name for
 swapoff() to work
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

T24gRnJpLCBPY3QgMzEsIDIwMjUgYXQgNDoxNOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgQXZpbmVzaCwKPgo+ID4gRml4IGFuIG9idmlvdXMgbWlzdGFrZSBp
biB0aGUgdGVzdC4gSXQgcmVtYWluZWQgaGlkZGVuIGFzIHRlc3QgdXNlZAo+ID4gdG8gcnVuIHN1
Y2Nlc3NmdWxseSBhbmQgd2FzIG5ldmVyIGV4ZWN1dGluZyBpdC4KPiA+IE9uIGZhaWx1cmUsIGl0
IGNhdXNlcyB1bW91bnQgdG8gZmFpbCBhcyB3ZSBkbyBub3Qgc3dhcG9mZigpIGZvciB0aGUKPiA+
IGVkZ2UgY2FzZSBzd2FwZmlsZSwgYW5kIGFsc28gY2F1c2VzIGJyZWFrYWdlIGluIHN1YnNlcXVl
bnQgZmlsZXN5c3RlbXMKPiA+IGFzIHdlIHVzZSB0aGUgc2FtZSBsb29wIGRldmljZS4KPgo+IEdv
b2QgY2F0Y2gsIHRoYW5rIHlvdSEKPgoKQWJzb2x1dGVseSwgcGF0Y2ggbWVyZ2VkLgoKCi0tIApS
ZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
