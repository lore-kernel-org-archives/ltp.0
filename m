Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF35C5475B
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 07:29:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB5C63CED31
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 08:29:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1ABF63CD103
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 08:29:10 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 763EB617E40
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 08:29:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709278148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l5++iNPOgbaxGH6+DqUikFlY69n/S0cV4dCXir7r8so=;
 b=hkrOp6vQ1w9eGgxBYHq7MEnNG6VpiWiyiIi1sleh2/smaYjA8F21sSQ+PahxhHJOChEleZ
 x6T92l/JFJJbvy8ZmT1vMweaDayxd3HeouRZyI9twbr8yUAKQPVbddqfZKOuJxfrJbdjkU
 5xLf8rGA5alLnaTrKDudrSHC1zZaWpc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-hBy7eR28MfaI4D__4WqBsg-1; Fri, 01 Mar 2024 02:29:05 -0500
X-MC-Unique: hBy7eR28MfaI4D__4WqBsg-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6e54421b20eso1327840b3a.2
 for <ltp@lists.linux.it>; Thu, 29 Feb 2024 23:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709278144; x=1709882944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l5++iNPOgbaxGH6+DqUikFlY69n/S0cV4dCXir7r8so=;
 b=ACIHB4RIst6SLoKigZi0D+EyOTUBO5Oq/e8ICQDtt14pkBj1TeM1tY7Vd1/9EArUcQ
 LLp5Hnlq/ry7r/FWqVYdXp1X0HzScx4uVxtwO3fkZwMkelsqHmkiRmxSiD1vigqC9ONY
 EruPgwgjCApF0OPqvW8WVKH2uEkhokZf+36Bk/aRYSOBPXMcB05QsKpIv1tKB+9LwaM0
 MiSxUWFElV6fP+CkNcEWqz0NmMGR4X8xW5oGHnM9JomrTFWi7zLTvZ4CGXCFNze1nFOx
 EsJT770Qp7aCutunTSJueZax2xNK7PgVSBp+wyLH/xMGIog+df7H+wEyQ0Rckf6+wqX1
 80sQ==
X-Gm-Message-State: AOJu0YwO5xi6Q3l35ndLHLDFFjU0RKR8J1pmQ0WaenP1yazeYBc/Ajp0
 Hr0tuuNh00eMANpddMIcI/nNVoMBLrYDvG+hCmni8Hp80RwAvkEmWo9xhw8733pzczC0ukTRw3C
 Ed7zC0rf6zu38QSaUlCUMuGzzKnvVbEPbghMUNSehAticHcaYXN8u3PPKaLWilfrTpjctE57QBF
 oHhO1hQCvp/Zx6lINwfxHHdFFSO2GydU0aHQ==
X-Received: by 2002:a05:6a00:9a0:b0:6e5:9698:7cbb with SMTP id
 u32-20020a056a0009a000b006e596987cbbmr1369294pfg.24.1709278143801; 
 Thu, 29 Feb 2024 23:29:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkM8XcR1MDJYUc7KbNhZ+fDA3yyFEbyUZZMc+BYIxR79UJnNn7cvozi2HCQ8QTKYibvF/w9ri48y34EtNJNrA=
X-Received: by 2002:a05:6a00:9a0:b0:6e5:9698:7cbb with SMTP id
 u32-20020a056a0009a000b006e596987cbbmr1369281pfg.24.1709278143462; Thu, 29
 Feb 2024 23:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20240221084256.32661-1-wegao@suse.com>
 <20240222031018.12281-1-wegao@suse.com>
 <20240222031018.12281-3-wegao@suse.com>
In-Reply-To: <20240222031018.12281-3-wegao@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Mar 2024 15:28:51 +0800
Message-ID: <CAEemH2deWNk7F_d+TPvX7M2gbCeiPsjdHKmHb06WtfpAp0OLBA@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v5 2/2] statx07.c: set umask to 0
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

T24gVGh1LCBGZWIgMjIsIDIwMjQgYXQgMTE6MTHigK9BTSBXZWkgR2FvIHZpYSBsdHAgPGx0cEBs
aXN0cy5saW51eC5pdD4gd3JvdGU6Cgo+IFdoZW4gc3lzdGVtJ3MgZGVmYXVsdCB1bWFzayBpcyAw
MDc3LCB0aGlzIHdpbGwgdHJpZ2dlciBmb2xsb3dpbmcgaXNzdWVzOgo+IHN0YXR4MDcuYzoxMDg6
IFRGQUlMOiBzdGF0eCgpIHdpdGggQVRfU1RBVFhfRE9OVF9TWU5DIGZvciBtb2RlIDY0NCA2MDAK
Pgo+IFNpZ25lZC1vZmYtYnk6IFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29tPgo+IC0tLQo+ICB0ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N0YXR4L3N0YXR4MDcuYyB8IDIgKysKPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvc3RhdHgvc3RhdHgwNy5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N0
YXR4L3N0YXR4MDcuYwo+IGluZGV4IDRkYmY4M2UxOC4uMjI3YzMzYzk2IDEwMDY0NAo+IC0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3RhdHgvc3RhdHgwNy5jCj4gKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9zdGF0eC9zdGF0eDA3LmMKPiBAQCAtMTE2LDYgKzExNiw4IEBA
IHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gICAgICAgICBpbnQgcmV0Owo+ICAgICAgICAgY2hh
ciBzZXJ2ZXJfcGF0aFtCVUZGX1NJWkVdOwo+Cj4gKyAgICAgICB1bWFzaygwKTsKPiArCj4gICAg
ICAgICBjd2QgPSB0c3RfZ2V0X3RtcGRpcigpOwo+Cj4gICAgICAgICBTQUZFX01LRElSKFNFUlZf
UEFUSCwgREVGQVVMVF9NT0RFKTsKPgoKQmV0dGVyIHRvIHJlc3RvcmUgdGhlIG9sZCBtYXNrIHJp
Z2h0IGFmdGVyLgoKT3RoZXJ3aXNlIGxvb2tzIGdvb2QuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
