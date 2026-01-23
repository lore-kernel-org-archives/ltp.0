Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F262D7236C
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 11:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769168105; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=IFfgjLgHd11WvFQDu5kQa7GCCwn5CKM90mlKM3A8yHg=;
 b=Krm++gX/Xsrr354rrWFc4NmXH7bXkBDxK+CuPI6DClw27C62qOUtmzJrd2XX/22frNh6P
 LI8zCGiVy5Sgkttwe+C8bAGAbXOhe+0KMGUreB6WGqv+uguyhbM1kfDrAp2Yi5pmnXUaBXy
 6qhD52vHKfAWemKarMSFhha2aFIlsMQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 891243CB5AA
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 12:35:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD7F53CAB67
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 12:34:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9B86B6008F3
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 12:34:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769168075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZC0DjaVPwx9nHuGzX/kpBemVk2yF7vEHu/ztp8GMNI=;
 b=Jy2rUeoDdVtKt1NUKWbPoQNQFOC4JtWjQDmuqMmRA0L/1FPVWIGxmhKQkrEyNMoO9N96dF
 gH7tWSv0R+mOFGBUkGOjiDfRh6YzVuFE0vw8T8MYTeoh3qg1bLzKQ59k6K8tMHwPWcuGev
 +WgmmsKLFeWDq29+jaa1XqCc5HXyRa8=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-Tq0bfViRN7SXEdiLeLY86A-1; Fri, 23 Jan 2026 06:34:34 -0500
X-MC-Unique: Tq0bfViRN7SXEdiLeLY86A-1
X-Mimecast-MFC-AGG-ID: Tq0bfViRN7SXEdiLeLY86A_1769168073
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b7155ca88cso1578691eec.1
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 03:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769168073; x=1769772873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eZC0DjaVPwx9nHuGzX/kpBemVk2yF7vEHu/ztp8GMNI=;
 b=SORZ/Ax6l/K0qMycLOPFtqoRKyz/iLFcTIInHZVRueSiPgAFoT+gvtB3M+5QWyl4iY
 kZ/5fmCrDNAsUNrLkPEVVOnURgSRg3OWygcwuBuwpsr3paL5qHGFQBTNObInltbUsf42
 Gzz9J+B8ogS44UJl987sAdfYN6LYH6iu5lbxwxhJDtFR+yk52lP/yF+bCnYEE32Rcqcc
 QUom+eLs9M4LkPMpmi8RH/1nvh784DPPtWuO7S6PUWXwPttbRWE+MuRRLzpbhhsUCv6O
 /f0eBGUQsa+hLnRvoQWWdS0RCKozfwGVIxCQjuFGKJxp4UesptAF2e4sQYwwpTkkFcYo
 o73Q==
X-Gm-Message-State: AOJu0YwQX9ldyolNEbIXqRdCSRFI0Xc622cEw9OvO3kZOp8ifqV11hIu
 qkKCNPlvsFdQYGzqybwbbwDa+Krb5KqcZuXX+Hw7Iap/K8yc+cQE7WBQiLo2PmenjTqOAZAeZKw
 zn2fF7rjOEBlmwNyuSW1Uhkc1uyzKIV2QTYtsI4g7H1iO5L3LbdV7cJsRzguhl/uCec0vC6am0C
 EZYV/yWyaYw+x65mWCbzPFSrfMj9M=
X-Gm-Gg: AZuq6aJPQm4F3CerNT12dDIpcUjRocs72h9Y6zLpTnJ6KeWk9SkvkIAGp+zU3ImVyLZ
 x5gmsaoycD37HONDF9hpKyrxG1pDMaIrTWMddIq+28LxUhUuHGxRNdJIf3qgeUPQ4IGh8hN7ccC
 sX24UYInFmVszBy62IgIrUHaSigPlkomM7ERyUW+HEJCzgABda3eVdZYpZfcj2gL7tWX8=
X-Received: by 2002:a05:7301:1696:b0:2a4:7b58:1a25 with SMTP id
 5a478bee46e88-2b739b7108amr1539567eec.27.1769168073338; 
 Fri, 23 Jan 2026 03:34:33 -0800 (PST)
X-Received: by 2002:a05:7301:1696:b0:2a4:7b58:1a25 with SMTP id
 5a478bee46e88-2b739b7108amr1539551eec.27.1769168072862; Fri, 23 Jan 2026
 03:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20260123054056.131992-1-liwang@redhat.com>
 <20260123094538.GA113458@pevik>
In-Reply-To: <20260123094538.GA113458@pevik>
Date: Fri, 23 Jan 2026 19:34:20 +0800
X-Gm-Features: AZwV_Qhjwii5y6UbEMQwZVIljnSxCm1w8lytYvavXbSG-FxYguE80n1Ozzo37Cg
Message-ID: <CAEemH2c2pzwLcr+70_67oQ4aTqsTE004MnrLEPZgfvk-G1B+pg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y6-qg3b_JIDd3kNoSqrCK_pQAOmYFAcIK5fNuzXEQNQ_1769168073
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd05: handle kernels rejecting WP
 feature in UFFDIO_API
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
Cc: Ricardo Branco <rbranco@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiA+ICAgICAgIGlmIChpb2N0bCh1ZmZkLCBVRkZESU9fQVBJLCAmdWZmZGlvX2FwaSkgPCAwKSB7
Cj4gPiAtICAgICAgICAgICAgIGlmICghKHVmZmRpb19hcGkuZmVhdHVyZXMgJiBVRkZEX0ZFQVRV
UkVfUEFHRUZBVUxUX0ZMQUdfV1ApKQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHRzdF9icmso
VENPTkYsICJVRkZEIHdyaXRlLXByb3RlY3QgdW5zdXBwb3J0ZWQiKTsKPiA+ICsgICAgICAgICAg
ICAgaW50IGVyciA9IGVycm5vOwo+ID4gKyAgICAgICAgICAgICBpZiAoZXJyID09IEVJTlZBTCkg
ewo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHVmZmRpb19hcGkuYXBpID0gVUZGRF9BUEk7Cj4g
PiArICAgICAgICAgICAgICAgICAgICAgdWZmZGlvX2FwaS5mZWF0dXJlcyA9IDA7Cj4gPiArCj4g
PiArICAgICAgICAgICAgICAgICAgICAgaWYgKGlvY3RsKHVmZmQsIFVGRkRJT19BUEksICZ1ZmZk
aW9fYXBpKSA9PSAwKQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHN0X2JyayhU
Q09ORiwgIlVGRkQgd3JpdGUtcHJvdGVjdCB1bnN1cHBvcnRlZCIpOwo+ID4gKyAgICAgICAgICAg
ICB9Cj4KPiBXb3VsZG4ndCBiZSBiZXR0ZXIgaW4gdGhpcyBjYXNlIHRvIGNoZWNrIGtjb25maWcg
Zm9yCj4gQ09ORklHX0hBVkVfQVJDSF9VU0VSRkFVTFRGRF9XUCAodW50ZXN0ZWQsIGJ1dCBpdCBz
aG91bGQgd29yawoKVGhhdCdzIHRydWUsIGl0IHdvdWxkIGJlIHNpbXBsZXIsIGxldCdzIGdvIHdp
dGggdGhpcyBtZXRob2QuCgo+IEJhY2sgdG8gb3VyIGRpc2N1c3Npb24gYWJvdXQgaG93IG9mdGVu
IHVzaW5nIGtjb25maWcgWzFdLiBXaGlsZSBJIHByZWZlciB0bwo+IGF2b2lkIHVzaW5nIGl0IGZv
ciB0cmlzdGF0ZSAoa2VybmVsIG1pZ2h0IGJlIGNvbmZpZ3VyZWQgYnV0IG1vZHVsZSBtaXNzaW5n
KSwgYnV0Cj4gaGVyZSBpcyBqdXN0IGEgZmVhdHVyZS4KCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2x0cC9DQUFTYUY2d09TdmkrMDdQcTVPNitmMUhrcnE2V1dNZ3BDYW9vSnhXck85dU92
Uk0zcHdAbWFpbC5nbWFpbC5jb20vCgpJIGRvbuKAmXQgdGhpbmsgdGhlcmUgaXMgYSBzaW5nbGUg
4oCcc3RhbmRhcmTigJ0gYW5zd2VyIGZvciBmZWF0dXJlIGRldGVjdGlvbjsKaXQgcmVhbGx5IGRl
cGVuZHMgb24gdGhlIHNwZWNpZmljIHNpdHVhdGlvbi4KCkZvciB0aGUgVUZGRC1XUCBmZWF0dXJl
IHRoZSBzaXR1YXRpb24gaXM6IHRoZXJlIGlzbuKAmXQgcmVhbGx5IGEgYm9vdApwYXJhbWV0ZXIg
b3IgcnVudGltZSBrbm9iIHRoYXQgZGlzYWJsZXMgVUZGRC1XUCBpbmRlcGVuZGVudGx5IG9uY2Ug
dGhlCmludGVyZmFjZSBpcyBwcmVzZW50LiBHaXZlbiB0aGF0LCBhIHNpbXBsZXIgYXBwcm9hY2gg
aXMgdG8gcmVseSBvbiBLY29uZmlnCmNoZWNrcy4KClRoaXMgaXMgZXNwZWNpYWxseSByZWxldmFu
dCBoZXJlIGJlY2F1c2UgZGlmZmVyZW50IGtlcm5lbHMgcmVwb3J0IOKAnFdQCnVuc3VwcG9ydGVk
4oCdIGRpZmZlcmVudGx5IChlLmcuIHJldHVybiAtMS9FSU5WQUwgdnMgcmV0dXJuIDAgd2l0aCBh
CmRpZmZlcmVudCBmZWF0dXJlIG1hc2spLCB3aGljaCBtYWtlcyBydW50aW1lLWJhc2VkIGRldGVj
dGlvbiBtb3JlCmNvbXBsaWNhdGVkLgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
