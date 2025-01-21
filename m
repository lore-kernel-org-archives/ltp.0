Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F38C02182
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 12:08:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FE0B3C2778
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 13:08:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BBFF83C1C95
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 13:07:55 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E7FDC1037B59
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 13:07:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737461273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fHioWFmAT3HUYphdlzMeJFk3mfVaujQulkJGksXsx4Y=;
 b=WYFg8Y207GQmSDC6b3rK2EryuY5DEO3mEM+kN51el5bvh27Izl9iI5omweYmMmro9Law2p
 4RHiFtFw7uPSpyFlb9LCEDMME5vNOeacnxeoz5xgfCw89mTt2Nnsb1okOy/kgubXh7yoqj
 2m2v8d61GvuwBugrApsfkLeEawa3ZK8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-HBgDouLpP0aueKQuiuI4hg-1; Tue, 21 Jan 2025 07:07:51 -0500
X-MC-Unique: HBgDouLpP0aueKQuiuI4hg-1
X-Mimecast-MFC-AGG-ID: HBgDouLpP0aueKQuiuI4hg
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ee5616e986so15979053a91.2
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 04:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737461270; x=1738066070;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fHioWFmAT3HUYphdlzMeJFk3mfVaujQulkJGksXsx4Y=;
 b=gw18J4Z+Y7iFoeUk17DqAS3Ves/3i48QTJjkNVflJCDBcV0HIH+SDHfAdcs+a7WHQ6
 NKK9UuPH7F1MpxRK4FcftU0LuDWhCoV3BL0H9+bi5q/8wvZvZmeBwzuWXpd52IJvSNTe
 4RckyLIlYrV9zIXeRU/e6LKBLJTh2evU0C7E3Hx3pxzDCF5BcH6WOYg8j/xtElfpkuEi
 rBhrzDHw+NQvpstLFyBCEcRxV7CQfsnhwwqcl6eO3+9CbUdg16W/wUqeTI9HlVpklXFA
 vwUyzpP7UTa7v+Af74GotKwLX8mMP3gAZt8Fg/CmPm8Q8ejNWX2/c7JLdRdU07J3mSoV
 +xjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG0INVtMfyjzt8ESheamJFU8WFpjjHIIEt1Xv5RbDQNpjRLy3MiNuN/PT4InfXDp4ZJTk=@lists.linux.it
X-Gm-Message-State: AOJu0YwmGo3HAxtTqxtSzShaHKzx2IlG6hfrTgzlvcwGX8HLTq4Q8IrR
 KiR9XeqZoXUmd+L9GJWrqrJ+Su5LLN4vFk3i0K2AIvqpU4/PzMiU5BWTEcHLQ6Eg+c0H6ggBaOn
 RW9HDoRdR0tO4VlUF8rym2f8DCukFdPphZ0CXYymo/AI1ktfE9Uha2cu/3LUR10j0IWhBQz4YJk
 kRrs/hSTh1tuIi8+06Q7cw65k=
X-Gm-Gg: ASbGncvZLby2aSudMeTrN0pC5b7iA+RsqCEaoFnMY5bRN9jvCp5aM3zG86DDnnb4t+v
 e3yWHBSp9YDk6HMskaQsi83143pZS4onQqQYQwdcvuvuZQOXgrhGV
X-Received: by 2002:a17:90b:524d:b0:2ee:b26c:1099 with SMTP id
 98e67ed59e1d1-2f782d99563mr22163074a91.34.1737461270335; 
 Tue, 21 Jan 2025 04:07:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsla6C156f+VGw4L1+eai7IdUmgBLFMWm8xFn5xtMe+0HXj5fDTJJbfzuaG6P+HqZAiUKO2x6FLGSEZJ9YsG8=
X-Received: by 2002:a17:90b:524d:b0:2ee:b26c:1099 with SMTP id
 98e67ed59e1d1-2f782d99563mr22163043a91.34.1737461269956; Tue, 21 Jan 2025
 04:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20250121111909.66487-1-acarmina@redhat.com>
In-Reply-To: <20250121111909.66487-1-acarmina@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Jan 2025 20:07:38 +0800
X-Gm-Features: AbW1kvY1o2thFrlvnoMiAlJCbnRap5vwE3EvumrFLIO459igg4pViWlxfjo-hQc
Message-ID: <CAEemH2ddReqpm0F=f82yd8RPo1JAXEErcJzdbJy4CYxMt3857g@mail.gmail.com>
To: Alessandro Carminati <acarmina@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vom5VCmouOUpH3xylvB1e9RD6vBWEJ8CItZBVrK4-04_1737461270
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] cfs-scheduler/starvation.c: Skip test on
 realtime kernels
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
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKYW4gMjEsIDIwMjUgYXQgNzoyMuKAr1BNIEFsZXNzYW5kcm8gQ2FybWluYXRpIDxh
Y2FybWluYUByZWRoYXQuY29tPgp3cm90ZToKCj4gVGhpcyBjb21taXQgaW50cm9kdWNlcyBhIGNo
ZWNrIGluIHRoZSBzdGFydmF0aW9uIHRlc3QgY2FzZSB0byBkZXRlY3QgYW5kCj4gc2tpcCBleGVj
dXRpb24gb24gcmVhbHRpbWUga2VybmVscy4gVGhlIHRlc3QgaXMgZGVzaWduZWQgZm9yIHVzZSB3
aXRoIHRoZQo+IENvbXBsZXRlbHkgRmFpciBTY2hlZHVsZXIgYW5kIHByb2R1Y2VzIG1lYW5pbmds
ZXNzIHJlc3VsdHMgd2hlbiBydW4gb24KPiByZWFsdGltZSBrZXJuZWxzLgo+Cj4gQnkgc2tpcHBp
bmcgdGhlIHRlc3Qgb24gcmVhbHRpbWUga2VybmVscywgd2UgYXZvaWQgY29uZnVzaW9uIGNhdXNl
ZCBieQo+IG1pc2xlYWRpbmcgcmVzdWx0cy4KPgo+IENoYW5nZXMgaW5jbHVkZToKPiAtIEFkZGVk
IGEgZGV0ZWN0aW9uIG1lY2hhbmlzbSBmb3IgcmVhbHRpbWUga2VybmVscy4KPiAtIExvZ2ljIHRv
IHNraXAgdGhlIHRlc3QgZXhlY3V0aW9uIGlmIHRoZSBrZXJuZWwgaXMgaWRlbnRpZmllZCBhcwo+
ICAgcmVhbHRpbWUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGVzc2FuZHJvIENhcm1pbmF0aSA8YWNh
cm1pbmFAcmVkaGF0LmNvbT4KPgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPgoKCgo+IC0tLQo+Cj4gVjE6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjUw
MTIwMDg1MDE3LjYzNDQyLTEtYWNhcm1pbmFAcmVkaGF0LmNvbS8KPgo+ICBpbmNsdWRlL3RzdF9r
ZXJuZWwuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDkgKysrKysrKysrCj4gIGxp
Yi90c3Rfa2VybmVsLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMCArKysr
KysrKysrCj4gIHRlc3RjYXNlcy9rZXJuZWwvc2NoZWQvY2ZzLXNjaGVkdWxlci9zdGFydmF0aW9u
LmMgfCAgMyArKysKPiAgMyBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspCj4KPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS90c3Rfa2VybmVsLmggYi9pbmNsdWRlL3RzdF9rZXJuZWwuaAo+IGlu
ZGV4IDVmNDk5NTJiNy4uNjNlY2IxOWE0IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdHN0X2tlcm5l
bC5oCj4gKysrIGIvaW5jbHVkZS90c3Rfa2VybmVsLmgKPiBAQCAtNTgsNCArNTgsMTMgQEAgaW50
IHRzdF9jaGVja19idWlsdGluX2RyaXZlcihjb25zdCBjaGFyICpkcml2ZXIpOwo+ICAgKi8KPiAg
aW50IHRzdF9jaGVja19kcml2ZXIoY29uc3QgY2hhciAqZHJpdmVyKTsKPgo+ICsvKioKPiArICog
dHN0X2NoZWNrX3ByZWVtcHRfcnQoKSAtIENoZWNrIGlmIHRoZSBydW5uaW5nIGtlcm5lbCBpcyBS
VC4KPiArICoKPiArICogQ2hlY2sgc3VwcG9ydCBmb3IgdGhlIGtlcm5lbCBtb2R1bGUgKGJvdGgg
YnVpbHQtaW4gYW5kIGxvYWRhYmxlKS4KPiArICoKPiArICogUmV0dXJuOiAtMSBpZiB0aGUga2Vy
bmVsIGlzIFJULCAwIG90aGVyd2lzZS4KPiArICovCj4gK2ludCB0c3RfY2hlY2tfcHJlZW1wdF9y
dCh2b2lkKTsKPiArCj4gICNlbmRpZiAvKiBUU1RfS0VSTkVMX0hfXyAqLwo+IGRpZmYgLS1naXQg
YS9saWIvdHN0X2tlcm5lbC5jIGIvbGliL3RzdF9rZXJuZWwuYwo+IGluZGV4IDhkYWJmZWJhMi4u
NzA4NDI4OWMzIDEwMDY0NAo+IC0tLSBhL2xpYi90c3Rfa2VybmVsLmMKPiArKysgYi9saWIvdHN0
X2tlcm5lbC5jCj4gQEAgLTIxNCwzICsyMTQsMTMgQEAgaW50IHRzdF9jaGVja19kcml2ZXIoY29u
c3QgY2hhciAqZHJpdmVyKQo+Cj4gICAgICAgICByZXR1cm4gLTE7Cj4gIH0KPiArCj4gK2ludCB0
c3RfY2hlY2tfcHJlZW1wdF9ydCh2b2lkKQo+ICt7Cj4gKyAgICAgICBzdHJ1Y3QgdXRzbmFtZSB1
dmFsOwo+ICsKPiArICAgICAgIHVuYW1lKCZ1dmFsKTsKPiArICAgICAgIGlmIChzdHJzdHIodXZh
bC52ZXJzaW9uLCAiUFJFRU1QVF9SVCIpKQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLTE7Cj4g
KyAgICAgICByZXR1cm4gMDsKPiArfQo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3Nj
aGVkL2Nmcy1zY2hlZHVsZXIvc3RhcnZhdGlvbi5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3NjaGVk
L2Nmcy1zY2hlZHVsZXIvc3RhcnZhdGlvbi5jCj4gaW5kZXggOTAxNTU2YTdiLi4yN2JmNzdmMzkg
MTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zY2hlZC9jZnMtc2NoZWR1bGVyL3N0YXJ2
YXRpb24uYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc2NoZWQvY2ZzLXNjaGVkdWxlci9zdGFy
dmF0aW9uLmMKPiBAQCAtODAsNiArODAsOSBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ICAg
ICAgICAgaW50IGNwdSA9IDA7Cj4gICAgICAgICBsb25nIG5jcHVzID0gdHN0X25jcHVzX2NvbmYo
KTsKPgo+ICsgICAgICAgaWYgKHRzdF9jaGVja19wcmVlbXB0X3J0KCkpCj4gKyAgICAgICAgICAg
ICAgIHRzdF9icmsoVENPTkYsICJUaGlzIHRlc3QgaXMgbm90IGRlc2lnbmVkIGZvciB0aGUgUlQK
PiBrZXJuZWwiKTsKPiArCj4gICAgICAgICBDUFVfWkVSTygmbWFzayk7Cj4KPiAgICAgICAgIC8q
IFJlc3RyaWN0IHRlc3QgdG8gYSBzaW5nbGUgY3B1ICovCj4gLS0KPiAyLjM0LjEKPgo+CgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
