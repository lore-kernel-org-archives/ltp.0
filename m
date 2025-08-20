Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0CBCA0EE6
	for <ltp@archiver.kernel.org>; Wed, 20 Aug 2025 02:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755656271; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=pHgNUC8WHMfa5gBbUxPQOW0ETIAbQlYkip1qkHJr9O0=;
 b=rGYSsOg50jrqoMN7MvrwsotaoSFmZyj71+72ZW5WtTC3TIAtvAl0wwEvgEa9fZra28tjp
 JxaBELXnLhCDboZkI/1q3pAqTHUvLKiyLbZShQlE/ltcFq7r5mgRdQLZwiaP4BwdazV9fLM
 gHI1teg1DCHGzdLbFYCr+FTADVQiARY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 355773CCA73
	for <ltp@archiver.kernel.org>; Wed, 20 Aug 2025 04:17:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0AD63C9B1F
 for <ltp@lists.linux.it>; Wed, 20 Aug 2025 04:17:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 148796008DC
 for <ltp@lists.linux.it>; Wed, 20 Aug 2025 04:17:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755656246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SUhGov3JW+L2wt7swjogirDy40fuqLZxz5j0O3bjBaM=;
 b=EkJDIRFRHyulvZrv8hBtauBplDbs4/EBLqPinYuuMnyoblE6nhVG0cSp/vlzOszgCjHVnv
 UhIp65/MKFCrF4wmaPL4iyiRlHCcS6yj1hzKOh5v6DgXDZCjYsdncdoh7YgN+8fp3hC77r
 Ah+aNR+9u8HEELaP2A0Doq1qbGiucwg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-BeJDUqbyNB2pDBhQdoUTlA-1; Tue, 19 Aug 2025 22:17:24 -0400
X-MC-Unique: BeJDUqbyNB2pDBhQdoUTlA-1
X-Mimecast-MFC-AGG-ID: BeJDUqbyNB2pDBhQdoUTlA_1755656243
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2445827ab71so53979915ad.3
 for <ltp@lists.linux.it>; Tue, 19 Aug 2025 19:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755656243; x=1756261043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SUhGov3JW+L2wt7swjogirDy40fuqLZxz5j0O3bjBaM=;
 b=YVGlo96sB9IUm7FJ7NIy2V+zjE0EohW0VHbIqO91/RdRNDogffzsbRLioTLQEr6qiL
 82QtgfEZJyITDfukZSDi3Yh3xQEo8zetTQe1qYjcO/U4mAYkiiHY+dz5IrYeHM9jXfwc
 +oTxmVpqiB3DEmjgcHkToDddJqbic5SmzbAMDTd3O2EM/0I5rXbHujaZFdEGfvUzjYu+
 1qTHzTpWSOtrWFuhDp5tU4NwO9aPqOddkwIksapg8qvtN5t9PXBi0rtk3xkHgU8HgE8L
 rG2DlvaxRivs1kwIKWSKCj9jQObbBuChxW47vYKnIxehKYy4XKVU2hUPYrGNargwSJbq
 NbRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1x6LLvL+uldHEXtJ+HM8u8mEgH1yqCnlBHQhcgaMqDUH6SN7YA/empt6NHXRHdEdfsbs=@lists.linux.it
X-Gm-Message-State: AOJu0Yzv4mbV03Cr62nDk1u5RqsHpdiEC7Gqgd06WUkIEyF7xHSS9JrJ
 D+RjhTM/tJLTgmmRENfV1T9bpL8btXLJ3O981dJONjzM4GbaRa9HuuENqJka+4LsMHjxRkIoabo
 OfIbErIAejSqSQych9VNLFFoy2f7yl/DP1vpvjJ5FdFwW8Be44p0KQ5uVUStqaHJy9ETR7x/zdT
 hpVBBZGE4On2sNVG3P72nlBjE3N/k=
X-Gm-Gg: ASbGncsDiUXHRTUIjLktiG5N/PTEwQQ/ZLWtGybE/o+aB5MDFqcajE+4KmZtBskUYFJ
 m7b87SrjZR7YYt3yv9BheuHk/f1pHhkoF9rcZroRmW9zZhtDD7pEFkNpRnfSK52uv3u2PWaOVB6
 BTECs2Kss+Ubra2nTx7f/kdg==
X-Received: by 2002:a17:903:18a:b0:224:10a2:cae7 with SMTP id
 d9443c01a7336-245ef25dc0fmr15702145ad.40.1755656243262; 
 Tue, 19 Aug 2025 19:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhbaD9hL9U0VpVojFfjfnnUOcpv6SFIQ7TyS00qaz+lu4yH6mNmhU/lV19bOWxCvmSrxZ4L2SXEhDZyO1djeg=
X-Received: by 2002:a17:903:18a:b0:224:10a2:cae7 with SMTP id
 d9443c01a7336-245ef25dc0fmr15701775ad.40.1755656242704; Tue, 19 Aug 2025
 19:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250819154957.79325-1-mdoucha@suse.cz>
 <20250819170930.GA230380@pevik>
In-Reply-To: <20250819170930.GA230380@pevik>
Date: Wed, 20 Aug 2025 10:17:09 +0800
X-Gm-Features: Ac12FXzCfmP5v4vLgit2h2pU7qZOlvj9dn6Ob6vgiLLx-BneX1OL1yQPFtPsmWU
Message-ID: <CAEemH2e7JK1SN-PdN-A_XbxPK4FfNeGoAF_iS+zEcT_tMZbrSw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HwTuXbO2mJt9xt5UVr6kIKZC0M4o32gOa9ktkFqEJTk_1755656243
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] Makefile: Fix module dirs search
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

T24gV2VkLCBBdWcgMjAsIDIwMjUgYXQgMToxMOKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTWFydGluLAo+Cj4gWyBDYyBBbmRyZWEgdG8gbWVyZ2UgdjIgZml4
IF0KPgo+ID4gTW9kdWxlIGRpcnMgc2VhcmNoIHJ1bnMgcmVsYXRpdmUgdG8gY3VycmVudCB3b3Jr
aW5nIGRpcmVjdG9yeSBpbnN0ZWFkCj4gPiBvZiB0aGUgc291cmNlIGRpcmVjdG9yeS4gSW4gYW4g
b3V0LW9mLXRyZWUgYnVpbGQsIHRoZSBzZWFyY2ggZm9yCj4gbWFrZWZpbGVzCj4gPiB3aWxsIGNv
bWUgdXAgZW1wdHkgYW5kIGdyZXAgd2lsbCB0cnkgdG8gcmVhZCBmcm9tIHN0YW5kYXJkIGlucHV0
LAo+IGJsb2NraW5nCj4gPiBpbmRlZmluaXRlbHkuIFNlYXJjaCBmb3IgbWFrZWZpbGVzIHJlbGF0
aXZlIHRvIHRoZSBzb3VyY2UgZGlyZWN0b3J5IHRvCj4gZml4Cj4gPiB0aGUgaXNzdWUuCj4KPiA+
IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFAc3VzZS5jej4KPiA+IC0tLQo+
ID4gIE1ha2VmaWxlIHwgMiArLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+Cj4gPiBkaWZmIC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmlsZQo+ID4g
aW5kZXggNzcyNzBiYzdjLi43ZjBiYTVlODYgMTAwNjQ0Cj4gPiAtLS0gYS9NYWtlZmlsZQo+ID4g
KysrIGIvTWFrZWZpbGUKPiA+IEBAIC0yMTMsNyArMjEzLDcgQEAgdGVzdC1tZXRhZGF0YTogbWV0
YWRhdGEtYWxsCj4gPiAgICAgICAkKE1BS0UpIC1DICQoYWJzX3NyY2RpcikvbWV0YWRhdGEgdGVz
dAo+Cj4gPiAgTU9EVUxFX0RJUlMgOj0gICQoc2hlbGwgXAo+ID4gLSAgICAgZGlybmFtZSAkJChn
cmVwIC1sICdpbmNsdWRlLiptb2R1bGVcLm1rJyAkJChmaW5kIHRlc3RjYXNlcy8gLXR5cGUKPiBm
IC1uYW1lICdNYWtlZmlsZScpKSkKPiA+ICsgICAgIGRpcm5hbWUgJCQoZ3JlcCAtbCAnaW5jbHVk
ZS4qbW9kdWxlXC5taycgJCQoZmluZAo+ICQoYWJzX3NyY2RpcikvdGVzdGNhc2VzLyAtdHlwZSBm
IC1uYW1lICdNYWtlZmlsZScpKSkKPgo+IEp1c3QgaGF2aW5nIGEgcXVpY2sgbG9vazogdjIgd2ls
bCBiZSBuZWVkZWQgYXMgcGF0aCBpcyBhZGRlZCB0d2ljZS4gOigKPgo+IEJ1aWxkIC9ob21lL2Zv
by9sdHAvdGVzdGNhc2VzL2NvbW1hbmRzL2luc21vZAo+IG1ha2VbMV06IEVudGVyaW5nIGRpcmVj
dG9yeSAnL2hvbWUvcGV2aWsvaW5zdGFsbC9zcmMvbHRwLmdpdCcKPiBtYWtlWzFdOiAqKiogL2hv
bWUvZm9vL2x0cC8vaG9tZS9mb28vbHRwL3Rlc3RjYXNlcy9jb21tYW5kcy9pbnNtb2Q6IE5vCj4g
c3VjaCBmaWxlIG9yIGRpcmVjdG9yeS4gIFN0b3AuCj4gbWFrZVsxXTogTGVhdmluZyBkaXJlY3Rv
cnkgJy9ob21lL3BldmlrL2luc3RhbGwvc3JjL2x0cC5naXQnCj4gbWFrZTogKioqIFtNYWtlZmls
ZToyMjE6IG1vZHVsZXNdIEVycm9yIDIKPgo+IEkgZ3Vlc3MgcmVtb3ZpbmcgIiQoYWJzX3NyY2Rp
cikvIiB3aWxsIGJlIG5lZWRlZCB3aGVuIHlvdSBhZGQgaXQgdG8gZmluZC4KPgoKR29vZCBjYXRj
aCEKClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCgo+ICsgcGxlYXNl
IGFkZDoKPiBGaXhlczogZTNlMWZhMGU3OCAoIk1ha2VmaWxlOiBBZGQga2VybmVsIG1vZHVsZXMg
cmVsYXRlZCBtYWtlIHRhcmdldHMiKQo+Cj4gV2l0aCB0aGUgY2hhbmdlIGFib3ZlIHlvdSBtYXkg
YWRkIG15IFJCVAo+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgo+
IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiBkaWZmIC0tZ2l0IE1ha2VmaWxlIE1ha2VmaWxlCj4g
aW5kZXggN2YwYmE1ZTg2OS4uZDQ3YjI1MjhlOSAxMDA2NDQKPiAtLS0gTWFrZWZpbGUKPiArKysg
TWFrZWZpbGUKPiBAQCAtMjIwLDE3ICsyMjAsMTcgQEAgTU9EVUxFX0RJUlMgOj0gICQoc2hlbGwg
XAo+ICBtb2R1bGVzOgo+ICAgICAgICAgQCQoZm9yZWFjaCBkaXIsJChNT0RVTEVfRElSUyksXAo+
ICAgICAgICAgICAgICAgICBlY2hvICJCdWlsZCAkKGRpcikiO1wKPiAtICAgICAgICAgICAgICAg
JChNQUtFKSAtQyAkKGFic19zcmNkaXIpLyQoZGlyKSB8fCBleGl0ICQkPzsgXAo+ICsgICAgICAg
ICAgICAgICAkKE1BS0UpIC1DICQoZGlyKSB8fCBleGl0ICQkPzsgXAo+ICApCj4gIG1vZHVsZXMt
Y2xlYW46Cj4gICAgICAgICBAJChmb3JlYWNoIGRpciwkKE1PRFVMRV9ESVJTKSxcCj4gICAgICAg
ICAgICAgICAgIGVjaG8gIkJ1aWxkICQoZGlyKSI7XAo+IC0gICAgICAgICAgICAgICAkKE1BS0Up
IC1DICQoYWJzX3NyY2RpcikvJChkaXIpIGNsZWFuIHx8IGV4aXQgJCQ/OyBcCj4gKyAgICAgICAg
ICAgICAgICQoTUFLRSkgLUMgJChkaXIpIGNsZWFuIHx8IGV4aXQgJCQ/OyBcCj4gICkKPiAgbW9k
dWxlcy1pbnN0YWxsOiBtb2R1bGVzCj4gICAgICAgICBAJChmb3JlYWNoIGRpciwkKE1PRFVMRV9E
SVJTKSxcCj4gICAgICAgICAgICAgICAgIGVjaG8gIkJ1aWxkICQoZGlyKSI7XAo+IC0gICAgICAg
ICAgICAgICAkKE1BS0UpIC1DICQoYWJzX3NyY2RpcikvJChkaXIpIGluc3RhbGwgfHwgZXhpdCAk
JD87IFwKPiArICAgICAgICAgICAgICAgJChNQUtFKSAtQyAkKGRpcikgaW5zdGFsbCB8fCBleGl0
ICQkPzsgXAo+ICApCj4KPiAgIyMgSGVscAo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2Fu
ZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
