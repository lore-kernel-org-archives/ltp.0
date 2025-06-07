Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA92C61CE8
	for <ltp@archiver.kernel.org>; Sat,  7 Jun 2025 03:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749266240; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0ocmTwYTHVUOB5wHn1KvUIXM1IAk1pB4nMUC74G+kt4=;
 b=i444Zbb5A9uDLYdWBF8aiWJl+YCjvWMnssEAS272K4Rws1V60iSmKVovAUTKPVpY6xpmJ
 ljkwKghhDAufwhvDKXxbOBids8MXygbU3c9TeK47WbL3+lR6GkKWj9QQVv+jtofCGfPIwzD
 QNJBrMnGY1jGA40vNzNPs0I+LbKq3No=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE9053CA658
	for <ltp@archiver.kernel.org>; Sat,  7 Jun 2025 05:17:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 809473C937F
 for <ltp@lists.linux.it>; Sat,  7 Jun 2025 05:16:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5B28B1A00243
 for <ltp@lists.linux.it>; Sat,  7 Jun 2025 05:16:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749266214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8eJ7V7vDST69bhKPyPOtPI/NhOvG+oIqI0aD1P7VI/s=;
 b=ijjMpCVjdhw3yi8ciTI/3gPcnONqRWKopXOfTw2waPJTiOLvEVBZtU3+cKWCMlzPmP6P3P
 qTdEfEBD56ZfecasX1kQ5deNj6fPZb8jx/HuOfXu27wWhV1u2aaMYn5YsGt2GY0RYHFPuS
 cjSYY1ktMA2b6yhay4SPbTkr688c+5Q=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-FjFLiRzXMlOvdYa_JV4zGQ-1; Fri, 06 Jun 2025 23:16:52 -0400
X-MC-Unique: FjFLiRzXMlOvdYa_JV4zGQ-1
X-Mimecast-MFC-AGG-ID: FjFLiRzXMlOvdYa_JV4zGQ_1749266211
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235c897d378so25664715ad.1
 for <ltp@lists.linux.it>; Fri, 06 Jun 2025 20:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749266211; x=1749871011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8eJ7V7vDST69bhKPyPOtPI/NhOvG+oIqI0aD1P7VI/s=;
 b=Ul6H83VeonTJzu5DTW8IlHLv7cqANUEv6QT0jZoF4vE5xIdUnBHVl3qKxXCXHjOIyq
 CG3ICDWf2Zi0xF5mFAVA5ItOb8Hbwo7nXWWxEKpc3rvvahopkf6lPczNmfouY7ih30nB
 HFrAtatlqez84vpibr/BBBMWv7vcAsulbM4H1OYB5EQCYVn/Dxh5t4hDlIoQphrwqKf7
 ptaAgN90xSeTmf1+cHw3wkssOUf+INJBMVoj3fpLuBsRETmSSs0+tvuyrLvPRHXEa1sx
 IrAM6X1eVZYMzTnxiiWG0LwpdwqrmsC6ssFIwWoLrTfcZrJ3IOFetp0za8UKHcXdgYVO
 qQ0A==
X-Gm-Message-State: AOJu0Yz1GtRjlEVCFILjRroS1WlpbT2ciHE2G/ucswYMQDvMAD9YBS19
 UfK7OHxfPXMHGnoXorqL97aMuYjXc8p067t+4vZn8pQjh8QWhryc6kSiplq2/jFNlkcpftCm9JL
 zbhm11YsQuBQr1r3RvFHgJULAAsWKArfVgW+ltUg/5CkDOD+047FUTE08EEXAGM1g/6gFC/xXR0
 7tDIDp8W3NUXBAv6GkJ7DurelJLt4=
X-Gm-Gg: ASbGnct6EO+A8HWbhr0BvbAEOkoM1RuqgQJwuycw8zTO8t/fTj+vQ11IoVc1+Mb21Lq
 KRbaAN6KNCHvx/IFKW6ZKJiu1jIYndv5lBSG4d3x4PoFLFYYcmqlAVMssvC/zfdYWHQM7MQ==
X-Received: by 2002:a17:903:22c6:b0:234:986c:66bf with SMTP id
 d9443c01a7336-23601e21e73mr87351225ad.11.1749266211311; 
 Fri, 06 Jun 2025 20:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9eiYw+2w58AZUC6TueR9dWJa5JDWOKKqDt2h8IGMvgrVaaKgDR8KomoY3MEPgCwjuIrZ0ci4Fb46vuTafCMU=
X-Received: by 2002:a17:903:22c6:b0:234:986c:66bf with SMTP id
 d9443c01a7336-23601e21e73mr87350935ad.11.1749266210866; Fri, 06 Jun 2025
 20:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250606110541.220472-1-liwang@redhat.com>
 <20250606143936.GC1312985@pevik>
In-Reply-To: <20250606143936.GC1312985@pevik>
Date: Sat, 7 Jun 2025 11:16:38 +0800
X-Gm-Features: AX0GCFvuy1YJZe_P-W4jSU5CMjlNhH65UtU4W_0Hq8KzhZRJ3FQYkfoPKGcNxN4
Message-ID: <CAEemH2dbCPKsBUiXKR=Lut1ONmjhjcwWxkjMzYe6B+HbYQUE8A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dyZiVXi-37wNVK_i2_86G8MyNptTzZh7Ux3rA6dtTck_1749266211
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/3] tst_atomic: drop legacy inline assembly
 and use __atomic or __sync builtins
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

T24gRnJpLCBKdW4gNiwgMjAyNSBhdCAxMDozOeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksIEN5cmlsLAo+Cj4gPiBSZWZhY3RvciB0c3RfYXRvbWljLmgg
dG8gcmVtb3ZlIGFsbCBsZWdhY3kgYXJjaGl0ZWN0dXJlLXNwZWNpZmljIGlubGluZQo+ID4gYXNz
ZW1ibHkgYW5kIGZhbGxiYWNrIGNvZGUgcGF0aHMuIFRoZSBuZXcgaW1wbGVtZW50YXRpb24gc3Vw
cG9ydHMgb25seQo+ID4gdHdvIHdlbGwtZGVmaW5lZCBpbnRlcmZhY2VzOiBfX2F0b21pY18qIGJ1
aWx0LWlucyAoR0NDIOKJpSA0LjcpIGFuZAo+IF9fc3luY18qCj4gPiBidWlsdC1pbnMgKEdDQyDi
iaUgNC4xKS4KPgo+ID4gVGhpcyBzaW1wbGlmaWNhdGlvbiBpbXByb3ZlcyBtYWludGFpbmFiaWxp
dHksIGNsYXJpdHksIGFuZCBwb3J0YWJpbGl0eQo+ID4gYWNyb3NzIHBsYXRmb3Jtcy4KPgo+ID4g
VGhlIG1lbW9yeSBvcmRlciBpcyBleHBsaWNpdGx5IHNldCB0byBfX0FUT01JQ19TRVFfQ1NUIHRv
IHByZXNlcnZlIHN0cmljdAo+ID4gc2VxdWVudGlhbCBjb25zaXN0ZW5jeSwgd2hpY2ggYWxpZ25z
IHdpdGggdGhlIEMrKzExIG1lbW9yeSBtb2RlbC4KPgo+ID4gUmVmZXJlbmNlOgo+IGh0dHBzOi8v
Z2NjLmdudS5vcmcvb25saW5lZG9jcy9nY2MvXzAwNWZfMDA1ZmF0b21pYy1CdWlsdGlucy5odG1s
Cj4gKzEKPgo+IFRoYW5rcyBmb3IgdGhlIHdvcmshCj4gUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwg
PHB2b3JlbEBzdXNlLmN6Pgo+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVk
aGF0LmNvbT4KPiA+IFN1Z2dlc3RlZC1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+
Cj4KPiA+ICsKPiA+ICsvKiBVc2UgX19hdG9taWMgYnVpbHQtaW5zIChHQ0MgPj0gNC43KSwgd2l0
aCBzZXF1ZW50aWFsIGNvbnNpc3RlbmN5LiAqLwo+Cj4gKzEgZm9yIGRvY3VtZW50aW5nIHRoaXMu
IEhvcGVmdWxseSB0aGVzZSBhcmUgb2xkIGVub3VnaCB0byBub3QgaGF2aW5nIHRvCj4gbWVudGlv
bgo+IGl0IGluIHRoZSBkb2NzLiBCdXQgaWYgeW91IHRoaW5rIGl0J3Mgbm90IHRoYXQgb2xkLCBp
dCBtaWdodCBiZSB3b3J0aAo+IGxhdGVyIHRvCj4gZG9jdW1lbnQgaXQgaW4gZG9jL3VzZXJzL3N1
cHBvcnRlZF9zeXN0ZW1zLnJzdC4KPgo+IGh0dHBzOi8vbGludXgtdGVzdC1wcm9qZWN0LnJlYWR0
aGVkb2NzLmlvL2VuL2xhdGVzdC91c2Vycy9zdXBwb3J0ZWRfc3lzdGVtcy5odG1sCj4KPiBJbiB0
aGF0IGNhc2UgbWluaW1hbCBjbGFuZyB2ZXJzaW9uIHNob3VsZCBiZSBub3RlZCBhcyB3ZWxsLgo+
Cj4gQlRXIEkgdHJpZWQgdG8gc2VhcmNoLCBzaG91bGQgaXQgYmUgY2xhbmcgMy41Pwo+IEkgdHJp
ZWQgdG8gc2VhcmNoIGJ1dCBub3QgZm91bmQuCj4gaHR0cHM6Ly9jbGFuZy5sbHZtLm9yZy9kb2Nz
L0xhbmd1YWdlRXh0ZW5zaW9ucy5odG1sI2MxMS1hdG9taWMtYnVpbHRpbnMKCgoKaHR0cHM6Ly9y
ZWxlYXNlcy5sbHZtLm9yZy8zLjEvZG9jcy9SZWxlYXNlTm90ZXMuaHRtbApGcm9tIHRoZSByZWxl
YXNlIG5vdGVzLCBDbGFuZyB3YXMgaW1wbGVtZW50ZWQgX19hdG9taWMgYnVpbHRpbnMgaW4gdjMu
MS4KCkFuZCB5b3UgbWFkZSBhIGdvb2QgcG9pbnQsIHdlIGFsc28gbmVlZCB0byBub3RlIHRoZSBt
aW5pbWFsIENsYW5nIHZlcnNpb24sClNvbWV0aGluZyBsaWtlOgoKICAvKiBVc2UgX19hdG9taWMg
YnVpbHQtaW5zIChHQ0MgPj0gNC43LCBDbGFuZyA+PSAzLjEpLCB3aXRoIHNlcXVlbnRpYWwKY29u
c2lzdGVuY3kuICovCgoKUC5zLgoKVGhlIHdvcnRoIHRvIG1lbnRpb24gZ2l0aHViIENJIGFsc28g
cGFzc2VkIHdpdGggcmVtb3ZlIF9fc3luYyBidWlsdC1pbnMsCmJ1dCB0byBiZSBvbiBzYWZlIHNp
ZGUsIEkgc3RpbGwga2VlcCB0aGVtIGluLCBtYXliZSBmb3Igc29tZW9uZSdzIHVzZSBvbgpvbGRl
cgpwbGF0Zm9ybS4KCmh0dHBzOi8vZ2l0aHViLmNvbS93YW5nbGk1NjY1L2x0cC9jb21taXQvM2Ix
YjgxZTY2MmM0OWIwNGI3OWMyYmRmODA3ZDgxODk4NGEyZGJkOQoKCi0tIApSZWdhcmRzLApMaSBX
YW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
