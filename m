Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBD6C61D92
	for <ltp@archiver.kernel.org>; Tue, 21 Nov 2023 10:32:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F30053CE115
	for <ltp@archiver.kernel.org>; Tue, 21 Nov 2023 11:32:06 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 282FB3C81F3
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 11:31:56 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7A559600864
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 11:31:55 +0100 (CET)
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41cc56255e3so32951371cf.3
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 02:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700562714; x=1701167514; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uz2VtlxjMo+c0buPqQcgbnBSbefsRadbNLCrnLDR+oQ=;
 b=bWAonLBJiruaF4EJe2iY2Ne4dJ5/Ps5YIkrazlzIaDioNdHbFeDv/sRURkzIP8is0s
 CR9Ruvl3OZ532BZVB6gY6eAA56Bbsy+qKVMTSGZPsWHaBpyMFywsUdS1zN3BhM/3nUJp
 kX7eC2nXMnKvng2Dv7U2vScrtzsc8ULlqgA/NwrTpWuKaOHPsNjDjgjk3RfI534qhxDX
 JRb0P6xHwntR1bQmCkZlUj+iY6hqiKXAlFDtjziHzQvsJyIlCbc+d5AypI+VpJdl2Hs3
 VSjHLH25eHpUX+bWyLBltpPCS3+QB2EsXQlOjDtrU0V1hqiEWaOd1/emdeZ1BSG9sPAy
 qPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700562714; x=1701167514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uz2VtlxjMo+c0buPqQcgbnBSbefsRadbNLCrnLDR+oQ=;
 b=w5v3gJJfQUAWX0niOeKsbw1D3RM/GZd0Hat8Hqc5eaWjB8YCewGknNTOCSoFabAlQ3
 UUZk2JeN+3LEKHYlmpHJyro2zbWnVRk1kechv/nZk0Aop/XWoEDul4TnRXqhHpoaRIMk
 +VVtmGQ7xMKtUX+xOKKU/ytQYsx+73etZ5lv8NJ/6i/yF47mQLLNhe6QKlUzR4ny2Odo
 8AuG+tqBn0lHVgdTql8s0JGq1TMnpEe5Q0bwOkJW7snfqAJmmTuMLuMPyg/5Rv9F8ffI
 AkkfUmDB1UfDTa6C1wmBlRGgffAP4esBVQ8sq9hSsCbUGAEwGAgq0cfeH5GvqVpUlNZS
 RbmQ==
X-Gm-Message-State: AOJu0Yz6l2SFOudK+oVhk2pVtIDRYj0POKf0S4YO/86bOT2MvEIEcx4t
 M0B7pZ1DfAHoDvYnN9bRFzOxi/FMhsgGgv4CWnuyjAPe
X-Google-Smtp-Source: AGHT+IEzfePZTS2E6Cwl8nz6X3t7dok10DkD7RXWHSms2bhf+mdVt7TFv0vRlDvrBE8i4PKyHVGr5rsXrgUgOwg5nPo=
X-Received: by 2002:a05:622a:4243:b0:423:756c:93f0 with SMTP id
 cq3-20020a05622a424300b00423756c93f0mr225841qtb.67.1700562714204; Tue, 21 Nov
 2023 02:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20231114072338.1669277-1-amir73il@gmail.com>
 <20231114072338.1669277-3-amir73il@gmail.com>
 <20231114105719.GB2325395@pevik> <20231121095946.GA88938@pevik>
In-Reply-To: <20231121095946.GA88938@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Nov 2023 12:31:42 +0200
Message-ID: <CAOQ4uxi0=aAGeHpGFQxeGD=+mmEu7wRxxSVcrbQ2GEuKnHNCQw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] fanotify13: Test watching overlayfs with
 FAN_REPORT_FID
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
Cc: Jan Kara <jack@suse.cz>, linux-unionfs@vger.kernel.org, ltp@lists.linux.it,
 Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBOb3YgMjEsIDIwMjMgYXQgMTE6NTnigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiBIaSBBbWlyLAo+Cj4gPiBIaSBBbWlyLAo+Cj4gPiBSZXZpZXdlZC1i
eTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gPiBGZXcgbm90ZXMgYmVsb3cuCj4KPiA+
ID4gUnVuIHRlc3QgdmFyaWFudHMgd2F0Y2hpbmcgb3ZlcmxheWZzIChvdmVyIGFsbCBzdXBwb3J0
ZWQgZnMpCj4gPiA+IGFuZCByZXBvcnRpbmcgZXZlbnRzIHdpdGggZmlkLgo+Cj4gPiA+IFRoaXMg
cmVxdWlyZXMgb3ZlcmxheWZzIHN1cHBvcnQgZm9yIEFUX0hBTkRMRV9GSUQgKGtlcm5lbCA2LjYp
IGFuZAo+ID4gPiBldmVuIHdpdGggQVRfSEFORExFX0ZJRCBmaWxlIGhhbmRsZXMsIG9ubHkgaW5v
ZGUgbWFya3MgYXJlIHN1cHBvcnRlZC4KPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRz
dGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgo+ID4gPiAtLS0KPiA+ID4gIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkuaCB8IDI4ICsrKysrKysrKysrKy0tLS0tCj4g
PiA+ICAuLi4va2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MTMuYyAgICAgfCAzMSAr
KysrKysrKysrKysrKysrLS0tCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMo
KyksIDEyIGRlbGV0aW9ucygtKQo+Cj4gPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5LmggYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2Zhbm90aWZ5L2Zhbm90aWZ5LmgKPiA+ID4gaW5kZXggNzg0MjRhMzUwLi5hOGFlYzY1OTcgMTAw
NjQ0Cj4gPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3Rp
ZnkuaAo+ID4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90
aWZ5LmgKPiA+ID4gQEAgLTc5LDggKzc5LDExIEBAIHN0YXRpYyBpbmxpbmUgaW50IHNhZmVfZmFu
b3RpZnlfbWFyayhjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLAo+ID4gPiAgLyoK
PiA+ID4gICAqIEhlbHBlciBmdW5jdGlvbiB1c2VkIHRvIG9idGFpbiBmc2lkIGFuZCBmaWxlX2hh
bmRsZSBmb3IgYSBnaXZlbiBwYXRoLgo+ID4gPiAgICogVXNlZCBieSB0ZXN0IGZpbGVzIGNvcnJl
bGF0ZWQgdG8gRkFOX1JFUE9SVF9GSUQgZnVuY3Rpb25hbGl0eS4KPiA+ID4gKyAqCj4gPiA+ICsg
KiBSZXR1cm5zIDAgaWYgbm9ybWFsIE5GUyBmaWxlIGhhbmRsZXMgYXJlIHN1cHBvcnRlZC4KPiA+
ID4gKyAqIFJldHVybnMgQVRfSEFORExFX0ZJRCwgb2Ygb25seSBub24tZGVjb2RlYWJsZSBmaWxl
IGhhbmRsZXMgYXJlIHN1cHBvcnRlZC4KPiA+IHMvIG9mIC8gaWYgLwo+ID4gSSBjYW4gZml4IHRo
aXMgYmVmb3JlIG1lcmdlLgo+Cj4gSSBkYXJlZCB0byBmaXggdGhpcyBhbmQgcy9BVF9IQUROTEVf
RklEL0FUX0hBTkRMRV9GSUQvIGFuZCBtZXJnZS4KPgoKVGhhdCdzIGdyZWF0IQoKPiA+IEFsc28g
SSBub3RpY2VkIChub3QgcmVsYXRlZCB0byB0aGlzIGNoYW5nZSkgdGhhdCAjZGVmaW5lIEFUX0hB
TkRMRV9GSUQgMHgyMDAKPiA+IGFkZGVkIGluIGRjN2IxMzMyYWIgaW50byB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5Lmggc2hvdWxkCj4gPiBoYXZlIGJlZW4gaW4g
aW5jbHVkZS9sYXBpL2Zhbm90aWZ5LmggKHRoaXMgZmlsZSBpcyBmb3IgZmFsbGJhY2sgZGVmaW5p
dGlvbnMpLgo+ID4gVGlueSBkZXRhaWwsIHdoaWNoIHNob3VsZCBiZSBmaXhlZCBhZnRlcndhcmRz
Lgo+Cj4gSSBhbHNvIG1lcmdlZCBhIGNsZWFudXAgb2YgdGhlIGZhbGxiYWNrIGRlZmluaXRpb25z
Lgo+Cj4gVGhhbmtzIGZvciBtYWludGFpbmluZyBmYW5vdGlmeSB0ZXN0cyEKPgoKVGhhbmsgeW91
IQpBbWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
