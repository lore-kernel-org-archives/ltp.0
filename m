Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BECAC61CE8
	for <ltp@archiver.kernel.org>; Thu, 12 Jun 2025 03:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749700036; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=W7y6wTV+ASOr9DbbEJm29wqHJUp+Q+Xqk+qCA+voJ7s=;
 b=XUEBsBnH9buRsUHydg1gja2JeeMTjpWDfMtpErl29eAqpxLNUJ4tarmRWyH+Ce3n098qx
 k+kTpGDzgLF9NRkhSLyK1dt4izISVv+QVoVwesqJeT9JEkHM0vyDTG0xVhEteBdKFp/lNvE
 MAGx77DBOV7uG8+7HZQdVul/hjtNkt4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14E6C3CB285
	for <ltp@archiver.kernel.org>; Thu, 12 Jun 2025 05:47:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9ADEE3C0F3C
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 05:46:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 804DD100037F
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 05:46:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749700012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UIiOFLBNivp98hbtHmPm1nbD1NbMOI8kW90W+xlwVBM=;
 b=OM6tUT3YEcp95JeGHkSo/8wI4p7h4cswKCYzuACDVao65DD+CARRvvnw7A8/81XQW0HTjo
 XJDmfGjd5JZmnW62xS4q8cDr8+syo2pFjul907z+wLnWVnGA1qYdY+le6EZsLWQIIaKxnu
 2Yif0pssCrEi09OmrzymW1EmPvcG0Fc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-F7oKmaH-P-66-UopO6MrnQ-1; Wed, 11 Jun 2025 23:46:50 -0400
X-MC-Unique: F7oKmaH-P-66-UopO6MrnQ-1
X-Mimecast-MFC-AGG-ID: F7oKmaH-P-66-UopO6MrnQ_1749700010
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3138c50d2a0so732928a91.2
 for <ltp@lists.linux.it>; Wed, 11 Jun 2025 20:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749700008; x=1750304808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UIiOFLBNivp98hbtHmPm1nbD1NbMOI8kW90W+xlwVBM=;
 b=nepnp3dY2j3/203AtiQplE5T5EXbU3g5IJUYrrf6mX4hq41J5utLRUgPDQvfi0lOx9
 sZ6ES7VwGQg747wbyDJ41jtaeyJXHjREbuadApFGKfUZqtULsPPUfo4MeKfRX5E5ZPU5
 PGmKhhIceQj2PNfcFvWIc/0MNye8UggFEyCPicjfp52tWcLhhNMJiOpNP4l9TA+5BJWt
 PhwwFkKriEPIbKE5slq0Q+vjqUVPViK4rjrpR1AKhgYE9OSfnNDA0RPDfc+1UQyjnm3R
 BAEN/sTL4gWURecwHQIJTUZ3JdWilcblHC9fKexYTyzcsGjDX+ig3lHy4Z+UJUkh/OlQ
 OV4Q==
X-Gm-Message-State: AOJu0YzLmDz9XVzd3eiD/TtYtURKk4l6QOBQSHNmC5fBCrkHTX7thx07
 qZEEJMlYs/ZAEPCNH7H1miE5RRTkXAlKmLZPjQycp3zt5mHcniO3UQAoxvMRXDHtAyD6zDLapML
 qUFDQXfnS75NrVxOrKJV+fnOJPQkSBVY3ZxKui//LDezCZw/4/OKB+xiwixI+9LPJfdpBg3NTHh
 WAyX8xfqXGvijMKwiM800pymPkS+4mLhn2Qjpgjg==
X-Gm-Gg: ASbGncsVmXwjMmoPySofBTRn98Fxxcp0V6C6JUrfic7pftwefr9gHRp2dWqZBiSf5+l
 A4tYpWZtP3RMAcqI2yS9BP9gTMpK0U6NEUYxWxCJWmPDFyL4fkfx2aKvR5VJef9B6AAd38VI4Js
 6ivN1+
X-Received: by 2002:a17:90b:48d0:b0:313:23ed:701 with SMTP id
 98e67ed59e1d1-313af0fd26fmr8314891a91.4.1749700008268; 
 Wed, 11 Jun 2025 20:46:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFurhn+BbsVTFXQrFV1Yr4BMPGon6qsQvj2KBc6Hjkh11tnI89j/soXxyq2a9Xgh9ViyqrP3FP1ISEu07K4RCc=
X-Received: by 2002:a17:90b:48d0:b0:313:23ed:701 with SMTP id
 98e67ed59e1d1-313af0fd26fmr8314869a91.4.1749700007810; Wed, 11 Jun 2025
 20:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250609124506.1454420-1-pvorel@suse.cz>
 <20250609124506.1454420-2-pvorel@suse.cz>
In-Reply-To: <20250609124506.1454420-2-pvorel@suse.cz>
Date: Thu, 12 Jun 2025 11:46:35 +0800
X-Gm-Features: AX0GCFtjJA6B2IdKWzgO964c2NMyyFvHNWusd4C9lZPs_ZjetJvbgUygZS_H2tc
Message-ID: <CAEemH2frAdZDx_-TNPOD91VqP3qr0khOoN5JL8UJ0AEKJNXFMA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0wLDYqL-qgq20BcVXfaLc3WZ-6GW7KrVkD45f5qmIP0_1749700010
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/4] shell lib: Add support for test cleanup
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

T24gTW9uLCBKdW4gOSwgMjAyNSBhdCA4OjQ24oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBGcm9tOiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPgo+IFNp
Z25lZC1vZmYtYnk6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+IFNpZ25lZC1vZmYt
Ynk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8
bGl3YW5nQHJlZGhhdC5jb20+CgotLS0KPiBUaGUgc2FtZSBhcyBpbiB2Mi4KPgo+ICB0ZXN0Y2Fz
ZXMvbGliL3J1bl90ZXN0cy5zaCAgICAgICAgICAgICAgICAgICAgfCAgNCArKystCj4gIC4uLi9s
aWIvdGVzdHMvc2hlbGxfbG9hZGVyX2Jya19jbGVhbnVwLnNoICAgICB8IDIwICsrKysrKysrKysr
KysrKysrKysKPiAgdGVzdGNhc2VzL2xpYi90ZXN0cy9zaGVsbF9sb2FkZXJfY2xlYW51cC5zaCAg
IHwgMjAgKysrKysrKysrKysrKysrKysrKwo+ICB0ZXN0Y2FzZXMvbGliL3RzdF9lbnYuc2ggICAg
ICAgICAgICAgICAgICAgICAgfCAgNCArKysrCj4gIDQgZmlsZXMgY2hhbmdlZCwgNDcgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdGNhc2VzL2xp
Yi90ZXN0cy9zaGVsbF9sb2FkZXJfYnJrX2NsZWFudXAuc2gKPiAgY3JlYXRlIG1vZGUgMTAwNzU1
IHRlc3RjYXNlcy9saWIvdGVzdHMvc2hlbGxfbG9hZGVyX2NsZWFudXAuc2gKPgo+IGRpZmYgLS1n
aXQgYS90ZXN0Y2FzZXMvbGliL3J1bl90ZXN0cy5zaCBiL3Rlc3RjYXNlcy9saWIvcnVuX3Rlc3Rz
LnNoCj4gaW5kZXggMzIxZjc0ZTVmZS4uMTI4Y2VlMzM3NyAxMDA3NTUKPiAtLS0gYS90ZXN0Y2Fz
ZXMvbGliL3J1bl90ZXN0cy5zaAo+ICsrKyBiL3Rlc3RjYXNlcy9saWIvcnVuX3Rlc3RzLnNoCj4g
QEAgLTksNiArOSw3IEBAIHNoZWxsX2xvYWRlcl9maWxlc3lzdGVtcy5zaAo+ICBzaGVsbF9sb2Fk
ZXJfa2NvbmZpZ3Muc2gKPiAgc2hlbGxfbG9hZGVyX3N1cHBvcnRlZF9hcmNocy5zaAo+ICBzaGVs
bF9sb2FkZXJfdGNudC5zaAo+ICtzaGVsbF9sb2FkZXJfY2xlYW51cC5zaAo+ICBzaGVsbF90ZXN0
MDEKPiAgc2hlbGxfdGVzdDAyCj4gIHNoZWxsX3Rlc3QwMwo+IEBAIC0yMSw3ICsyMiw4IEBAIFRF
U1RTX1RCUk9LPSIKPiAgc2hlbGxfbG9hZGVyX2ludmFsaWRfYmxvY2suc2gKPiAgc2hlbGxfbG9h
ZGVyX2ludmFsaWRfbWV0YWRhdGEuc2gKPiAgc2hlbGxfbG9hZGVyX25vX21ldGFkYXRhLnNoCj4g
LXNoZWxsX2xvYWRlcl93cm9uZ19tZXRhZGF0YS5zaCIKPiArc2hlbGxfbG9hZGVyX3dyb25nX21l
dGFkYXRhLnNoCj4gK3NoZWxsX2xvYWRlcl9icmtfY2xlYW51cC5zaCIKPgo+ICBURVNUU19UQ09O
Rj0ic2hlbGxfdGVzdDA2Igo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9saWIvdGVzdHMvc2hl
bGxfbG9hZGVyX2Jya19jbGVhbnVwLnNoCj4gYi90ZXN0Y2FzZXMvbGliL3Rlc3RzL3NoZWxsX2xv
YWRlcl9icmtfY2xlYW51cC5zaAo+IG5ldyBmaWxlIG1vZGUgMTAwNzU1Cj4gaW5kZXggMDAwMDAw
MDAwMC4uOGM3MDRhNTQwNgo+IC0tLSAvZGV2L251bGwKPiArKysgYi90ZXN0Y2FzZXMvbGliL3Rl
c3RzL3NoZWxsX2xvYWRlcl9icmtfY2xlYW51cC5zaAo+IEBAIC0wLDAgKzEsMjAgQEAKPiArIyEv
YmluL3NoCj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiAr
IyBDb3B5cmlnaHQgKGMpIDIwMjQtMjAyNSBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4K
PiArIwo+ICsjIC0tLQo+ICsjIGVudgo+ICsjIHsKPiArIyB9Cj4gKyMgLS0tCj4gKwo+ICtUU1Rf
Q0xFQU5VUD1jbGVhbnVwCj4gKwo+ICsuIHRzdF9sb2FkZXIuc2gKPiArCj4gK2NsZWFudXAoKQo+
ICt7Cj4gKyAgICAgICB0c3RfcmVzIFRJTkZPICJDbGVhbnVwIHJ1bnMiCj4gK30KPiArCj4gK3Rz
dF9icmsgVEJST0sgIlRlc3QgZXhpdHMiCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9saWIvdGVz
dHMvc2hlbGxfbG9hZGVyX2NsZWFudXAuc2gKPiBiL3Rlc3RjYXNlcy9saWIvdGVzdHMvc2hlbGxf
bG9hZGVyX2NsZWFudXAuc2gKPiBuZXcgZmlsZSBtb2RlIDEwMDc1NQo+IGluZGV4IDAwMDAwMDAw
MDAuLmZiN2JiZGY1YTkKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvdGVzdGNhc2VzL2xpYi90ZXN0
cy9zaGVsbF9sb2FkZXJfY2xlYW51cC5zaAo+IEBAIC0wLDAgKzEsMjAgQEAKPiArIyEvYmluL3No
Cj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiArIyBDb3B5
cmlnaHQgKGMpIDIwMjQtMjAyNSBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiArIwo+
ICsjIC0tLQo+ICsjIGVudgo+ICsjIHsKPiArIyB9Cj4gKyMgLS0tCj4gKwo+ICtUU1RfQ0xFQU5V
UD1kb19jbGVhbnVwCj4gKwo+ICsuIHRzdF9sb2FkZXIuc2gKPiArCj4gK2RvX2NsZWFudXAoKQo+
ICt7Cj4gKyAgICAgICB0c3RfcmVzIFRJTkZPICJDbGVhbnVwIGV4ZWN1dGVkIgo+ICt9Cj4gKwo+
ICt0c3RfcmVzIFRQQVNTICJUZXN0IGlzIGV4ZWN1dGVkIgo+IGRpZmYgLS1naXQgYS90ZXN0Y2Fz
ZXMvbGliL3RzdF9lbnYuc2ggYi90ZXN0Y2FzZXMvbGliL3RzdF9lbnYuc2gKPiBpbmRleCA2OGY5
YTBkYWE5Li5iMTNiYWIzN2MzIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9saWIvdHN0X2Vudi5z
aAo+ICsrKyBiL3Rlc3RjYXNlcy9saWIvdHN0X2Vudi5zaAo+IEBAIC0zNSwzICszNSw3IEBAIHRz
dF9icmtfKCkKPgo+ICBhbGlhcyB0c3RfcmVzPSJ0c3RfcmVzXyAkdHN0X3NjcmlwdF9uYW1lIFwk
TElORU5PIgo+ICBhbGlhcyB0c3RfYnJrPSJ0c3RfYnJrXyAkdHN0X3NjcmlwdF9uYW1lIFwkTElO
RU5PIgo+ICsKPiAraWYgWyAtbiAiJFRTVF9DTEVBTlVQIiBdOyB0aGVuCj4gKyAgICAgICB0cmFw
ICRUU1RfQ0xFQU5VUCBFWElUCj4gK2ZpCj4gLS0KPiAyLjQ5LjAKPgo+Cj4gLS0KPiBNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
