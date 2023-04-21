Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE85FC77B75
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 07:33:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AD583CBEC9
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 09:33:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82C933CB332
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 09:33:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 499521000A3D
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 09:33:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682062412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJUkE1qms+p8AmKiMCUH3/SOAqF6j3DvMxumUDRwzOI=;
 b=Vn2K3t7ocveWjE0axsS7teUN9myZ+leT4ASF4dR//Y2MYdE4/SFzYhuMYXMLqD2VX1GUgm
 NzJYido7qRzmXD5LyFYee9X85z28OLW/QyzbXOvx7wDe1sPQFd4t5M38mluWZDfhxKv5vr
 0JuOInPjb+lAvtGgpKDa6fObFBbYO0k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-jbjWL2jyPA27lkwwbYC_Uw-1; Fri, 21 Apr 2023 03:33:29 -0400
X-MC-Unique: jbjWL2jyPA27lkwwbYC_Uw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-2f6632b85fcso440950f8f.1
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 00:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682062409; x=1684654409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJUkE1qms+p8AmKiMCUH3/SOAqF6j3DvMxumUDRwzOI=;
 b=gFgUlCOGSv6BFskRdRO7LYAFZcXYc2YvrJ5JH2yYbto06qG2dHy2KdwZXQZH5VsIui
 QRJSRDLCR2s7jBZxpaOLl0dKrJhxCc4bHdMnvedEHbkCfxnAIWX9UTwXgFVOo8EWEQ7B
 G854M1/J/HV6Ox+4favbb9azAiJ5z/rj8kvMaLVhuAjSCVjyIbhYiVjTG827z2qk03le
 /LiBorqRTnzstVjhZDnO672fICT10U3zio4nlqsAKlIVz2X+BS+/JJEd/xeR3f8iil8Z
 ZmcJ5zDBYGRRJRLh/jTYTyfiN06lnlElZs6r15bpHZVEIq1SrovzKWlLesTlZhMEt2AV
 Y/qA==
X-Gm-Message-State: AAQBX9eg8OsK9ws7krd2770NhYkgHab/4UFOgFb8YfNrOzIKxopuRKTW
 QyinCP7UM1JU/VqcPuiQ6U172OeKuZSWkK0n8UQ9GCWe8gT9CbOCknF0uMU3wTqnejPuSEFwqZg
 PvvZ6MQjcoX3ZVmHOVevZ9es3coo=
X-Received: by 2002:a5d:640a:0:b0:2ee:d53b:d9ef with SMTP id
 z10-20020a5d640a000000b002eed53bd9efmr3021620wru.55.1682062408831; 
 Fri, 21 Apr 2023 00:33:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZnvC0fSXd52I9jmdQLDuL4FqVy8q+d3ELwrQvAjbpPvXk6uXWZKQ8WJmF/xFWEh8YH1vB/Y+fWYVCOx3EogBE=
X-Received: by 2002:a5d:640a:0:b0:2ee:d53b:d9ef with SMTP id
 z10-20020a5d640a000000b002eed53bd9efmr3021608wru.55.1682062408488; Fri, 21
 Apr 2023 00:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230413111434.2103422-1-pvorel@suse.cz>
 <CAEemH2fZU=b60mSD8PoZoQiJ7WQ+rhWiOqPO4XGyhS9aB2QDcA@mail.gmail.com>
 <CAEemH2eu2LCyM3g+2BcD2ZFaGSZ2R+V7-zbYc3Kg4kb=vqtiDA@mail.gmail.com>
 <20230419095939.GA2577418@pevik>
 <CAEemH2fAojMkcK2xEw+aM5oh9Csed-eOtHAs98OCydVRfyCzGQ@mail.gmail.com>
 <20230420145315.GA2694798@pevik>
In-Reply-To: <20230420145315.GA2694798@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 21 Apr 2023 15:33:17 +0800
Message-ID: <CAEemH2fm9CFvxRBm9iiHiaS3-UqcVec7k3kXaYJP8J=CbJju6Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] tst_tmpdir: Remove possible double/trailing
 slashes from TMPDIR
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

T24gVGh1LCBBcHIgMjAsIDIwMjMgYXQgMTA6NTPigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+IEhpIExpLAo+IC4uLgo+ID4gPiA+ID4+ICsrKyBiL2xpYi90c3RfdG1w
ZGlyLmMKPiA+ID4gPiA+PiBAQCAtMTI0LDE2ICsxMjQsMjggQEAgY2hhciAqdHN0X2dldF90bXBk
aXIodm9pZCkKPgo+ID4gPiA+ID4+ICBjb25zdCBjaGFyICp0c3RfZ2V0X3RtcGRpcl9yb290KHZv
aWQpCj4gPiA+ID4gPj4gIHsKPiA+ID4gPiA+PiAtICAgICAgIGNvbnN0IGNoYXIgKmVudl90bXBk
aXIgPSBnZXRlbnYoIlRNUERJUiIpOwo+ID4gPiA+ID4+ICsgICAgICAgY2hhciAqZW52X3RtcGRp
ciA9IGdldGVudigiVE1QRElSIik7Cj4KPgo+ID4gPiA+ID4gSXQgc2VlbXMgdGhhdCBtb2RpZnlp
bmcgdGhlIGVudmlyb25tZW50IHZhcmlhYmxlcyBpcyBnZW5lcmFsbHkKPiA+ID4gPiA+IG5vdCBh
IGdvb2QgcHJhY3RpY2UuCj4KPiA+ID4gPiA+IFRoZSBnZXRlbnYoKSBmdW5jdGlvbiByZXR1cm5z
IGEgcG9pbnRlciB0byB0aGUgdmFsdWUgb2YgYW4KPiA+ID4gPiA+IGVudmlyb25tZW50IHZhcmlh
YmxlLCB3aGljaCBpcyBzdG9yZWQgaW4gdGhlIG1lbW9yeSBtYW5hZ2VkCj4gPiA+ID4gPiBieSB0
aGUgc3lzdGVtLiBBbnkgYXR0ZW1wdCB0byBtb2RpZnkgdGhpcyBtZW1vcnkgZGlyZWN0bHkgY2Fu
Cj4gPiA+ID4gPiBjYXVzZSB1bmV4cGVjdGVkIGJlaGF2aW9yIG9yIGV2ZW4gY3Jhc2ggdGhlIHBy
b2dyYW0uCj4KPiA+ID4gPiA+IEluc3RlYWQgb2YgbW9kaWZ5aW5nIHRoZSByZXR1cm4gdmFsdWUg
b2YgZ2V0ZW52KCksIGl0IGlzCj4gcmVjb21tZW5kZWQKPiA+ID4gPiA+IHRvIGNyZWF0ZSBhIGNv
cHkgb2YgdGhlIHZhbHVlIGFuZCBtb2RpZnkgdGhlIGNvcHkgaW5zdGVhZC4KPgo+ID4gPiBEbyB5
b3UgbWVhbiB0byB1c2Ugc3RyZHVwKCk/Cj4KPgo+ID4gWWVhaCwgc29tZXRoaW5nIGxpa2UgdGhh
dCwgb3Igd2UgZGVjbGFyZSBhIGJ1ZmZlciwgYW5kIHVzZSBzdHJjcHkoKQo+ID4gdG8gY29weSB0
aGUgc3RyaW5nIHBvaW50ZWQgdG8gYnkgdGhlIHJldHVybiB2YWx1ZSBvZiBnZXRlbnYoKSBpbnRv
IHRoZQo+ID4gYnVmZmVyIHRoYXQgd2UgY2FuIHNhZmVseSBtb2RpZnkuCj4KPiA+IEkgcHJlZmVy
IGl0IGluIHRoaXMgd2F5Lgo+Cj4KPiBTdXJlLCBJJ2xsIHBvc3QgbmV3IHZlcnNpb24gd2l0aCB0
aGlzLiBVbnRpbCB0aGVuIEkga2VlcCB0aGlzIHBhdGNoIG9wZW4gaWYKPiBhbnlib2R5IHdhbnRz
IHRvIGNvbW1lbnQgaXQuCj4KPiA+ID4gQWxzbyBtYW4gZ2V0ZW52KDMpIHNheXM6Cj4KPiA+ID4g
ICAgICAgIEFzIHR5cGljYWxseSBpbXBsZW1lbnRlZCwgZ2V0ZW52KCkgcmV0dXJucyBhIHBvaW50
ZXIgdG8gYSBzdHJpbmcKPiA+ID4gICAgICAgIHdpdGhpbiB0aGUgZW52aXJvbm1lbnQgbGlzdC4g
IFRoZSBjYWxsZXIgbXVzdCB0YWtlIGNhcmUgbm90IHRvCj4gPiA+ICAgICAgICBtb2RpZnkgdGhp
cyBzdHJpbmcsIHNpbmNlIHRoYXQgd291bGQgY2hhbmdlIHRoZSBlbnZpcm9ubWVudCBvZgo+ID4g
PiAgICAgICAgdGhlIHByb2Nlc3MuCj4KPiA+ID4gPT4gSSB3b3VsZCBub3QgbWluZCAkVE1QRElS
IGdvdCB1cGRhdGVkIGluIHRoZSBlbnZpcm9ubWVudC4KPgo+ID4gPiA+IEJ0dywgdGhlIHdpc2Ug
bWV0aG9kIGlzIHRvIHVzZSBzZXRlbnYoKSBmdW5jdGlvbiB0byByZXNldAo+ID4gPiA+IGVudmly
b25tZW50IHZhcmlhYmxlcyBpZiByZWFsbHkgbmVlZGVkLgo+Cj4gPiA+IFdlbGwsIEkgZG9uJ3Qg
a25vdyBhbnkgQyB0ZXN0IHdoaWNoIG5lZWRzIGl0IChvbmx5IE5GUyB0ZXN0cyB3aGljaCBhcmUK
PiA+ID4gc2hlbGwKPiA+ID4gdGVzdHMpLiBCdXQgSSB3YW50ZWQgdG8gaGF2ZSB0aGUgc2FtZSBi
ZWhhdmlvciBpbiBib3RoIEFQSXMuCj4KPiA+ID4gPiBUaGlzIGlzIGEgZGlmZmVyZW50IHBhcnQg
b2Ygc2hlbGwgQVBJIEkgaGF2ZSB0byBzYXkuCj4KPiA+ID4gWWVzLCB0aGUgYmVoYXZpb3IgaXMg
c2xpZ2h0bHkgZGlmZmVyZW50IGZyb20gc2hlbGwgQVBJIFsxXSwKPiA+ID4gd2hlcmUgaXQgbW9k
aWZpZXMgJFRTVF9UTVBESVIgKGtlZXAgJFRNUERJUiB1bnRvdWNoZWQpLgo+Cj4KPiA+ID4gPiA+
IE9yLCB0aGUgc2ltcGxlc3Qgd2F5IEkgZ3Vlc3MgaXMganVzdCBUQlJPSyBhbmQgdGVsbCB1c2Vy
cyB3aHkKPiA+ID4gPiA+IHRoaXMgVE1QRElSIGlzIHVudXNhYmxlLgo+Cj4gPiA+IElmIHlvdSBw
cmVmZXIgaXQncyBiZXR0ZXIgdG8gVEJST0sgb246Cj4gPiA+ICogZG91YmxlIHNsYXNoZXMKPiA+
ID4gKiB0cmFpbGluZyBzbGFzaAo+Cj4gPiA+IEkgY2FuIGRvIHRoYXQuIEJ1dCBhdCBsZWFzdCBv
biB0cmFpbGluZyBzbGFzaCBsb29rcyB0byBtZSBxdWl0ZSBzdHJpY3QuCj4KPgo+ID4gLTEsIHRy
YWlsaW5nIGFuZCBkb3VibGUgc2xhc2ggYWxsIGFjY2VwdGVkIGJ5IHNoZWxsIGluIGNvbW1hbmQg
bGluZSwKPiA+IG1heWJlIHdlIHNob3VsZG4ndCBzZXQgYSBtb3JlIHN0cmljdCBwb2xpY3kgdGhh
biB0aGF0Lgo+Cj4gQWdyZWUsIEkganVzdCBkaWRuJ3QgdW5kZXJzdGFuZCBiZWZvcmUgeW91ciBj
b25jZXJuICh5b3UgbW9zdGx5IG9iamVjdGVkCj4gdGhlIEMKPiBjb2RlLCBub3QgdGhlIGZhY3Qg
dGhhdCB0aGUgcmVzdWx0ZWQgcGF0aCBpcyBtb2RpZmllZCkuCj4KClllYWgsIEkganVzdCBkb3Vi
dGVkIHRoZSBpbmNvcnJlY3Qgd2F5IG9mIGRvaW5nIHRoYXQuCihpbiBDIHByb2dyYW1taW5nKQoK
U29ycnkgZm9yIHRoZSB1bmNsZWFyIGRlc2NyaXB0aW9uLCBJJ20gYWx3YXlzIGRpc3RyZXNzZWQg
YnkgbXkgRW5nbGlzaApzcGVsbGluZyBsZXZlbCA6LSguCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
