Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A2FE9B245
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 09:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771926436; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=twFf+0OkdUIEIGWD8e95VlKra+Kq1m9kaN5DBH+rGc0=;
 b=lXl550JfLeutQ+3xh41e8EOlymFjCGTcuLjZLLjd8/U7WK6rr5hkmnHthx8DYITXSiZO4
 8qarGrevQpqeQN/8Q7vaBrnArLRFibPN6TDKHfCKlErMg/fgWYfY46ROoCOrbveRfa6kZ5x
 F7AS/mUeukSlXDdEiYIb/Q1hNnC48lo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B94D43D0F75
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 10:47:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 748533C8445
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 10:46:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 956041400455
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 10:46:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771926411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m/FXABcOY+8d/Mh0WMTnQarElPyYZYlqxoseGESanu8=;
 b=YwuU17gXb/3GTPxfL7G5kjQup3PW0SU1AeKrFb4VMSyR8QGQSznjSB8pwqUPn/PRz4opmX
 N9cQ4pZGN0XzN3cFd64ADLXmaAqCat1NaBJbEIm4p1KqmIi6fciw865gU+qnne74OTyeXq
 hi2pErBJhbsGvo5dsXz6nEFZSbHxqak=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-7PAni6kIMcOwQIoRaJzNmA-1; Tue, 24 Feb 2026 04:46:48 -0500
X-MC-Unique: 7PAni6kIMcOwQIoRaJzNmA-1
X-Mimecast-MFC-AGG-ID: 7PAni6kIMcOwQIoRaJzNmA_1771926408
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1249d001040so2967075c88.1
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 01:46:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771926408; x=1772531208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/FXABcOY+8d/Mh0WMTnQarElPyYZYlqxoseGESanu8=;
 b=J9ah8Rvw45lqJ6ppYLLJG6ODgX6TyxgRW810ejX9O2AGNMJ+jOUup+0Tqg5ShSGfdm
 0PB7o49wAQUEig/a7VyYMZaiTixaYcX7A25pLp5qoMtt5Xd0gWa6TfF8BjT69TvnIeIW
 NGAjMROScT915d7sSoaBson+QsT8C7lPx9V9q1F6bKZuTWVrTVKedqZ8LS0Tua9ZP22R
 WM+98M8uSTwNOAth9TgsMeLMZgdFhjIAJG0/9oBNftId9vy4pQxCqJrgstjXSkLcJVKy
 76JnLfLQHfPkuJDAgm5bBCX4kPQqulrI0bohGvdZX5/5CFTR49NrRu0IHPiJl4NQpHW+
 zU3A==
X-Gm-Message-State: AOJu0YxX5lgsgQ4h/e1lxl6aopOAcAqbcoAHmagmofaLJPBl5855+iT6
 WZQdxaf24je/m8gxFKqIHynMRbjaalK2RRvG1SH8GkvaccvU/d2US1H3PNhFEuqgtJ/E1V+3msO
 YEqVoL6Dam/LzBk2Qsuhypmg4gOwGP13xBanK0WuAlGlkHMRXiSqnu010PmB3IdOygnSdNimrcQ
 ZrlJn0v/hE9h2G5dUYAMa7h99hF+8=
X-Gm-Gg: AZuq6aI+UybepE+SOUrMezzX2AUFEyWu7uGaC543kxAgFJgrrPgMHWld4knnFsNHf1v
 oZ2ryAAI/nDO5par5xTzJTbm91YiYSyiWPNDBJdnx8uzg5w1jPxb3xZYAdU6kN3kCT0HYREf+wb
 6V94RC5yOcI00LQimOgUX/qA7ajiqg15PJI8g7us2zkvP7Z0qZAVzAy2kAV0TufnN7oO4IbHHtp
 /shvvw=
X-Received: by 2002:a05:7022:7a0:b0:11b:c86b:3870 with SMTP id
 a92af1059eb24-1276ab58303mr4689469c88.4.1771926407680; 
 Tue, 24 Feb 2026 01:46:47 -0800 (PST)
X-Received: by 2002:a05:7022:7a0:b0:11b:c86b:3870 with SMTP id
 a92af1059eb24-1276ab58303mr4689465c88.4.1771926407170; Tue, 24 Feb 2026
 01:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20260224-kirk_4-v1-1-6f706363fc4d@suse.com>
In-Reply-To: <20260224-kirk_4-v1-1-6f706363fc4d@suse.com>
Date: Tue, 24 Feb 2026 17:46:34 +0800
X-Gm-Features: AaiRm53n6enxMdbsGVWqlV5mJ3MaI40u6pwu5hgxhefatLREpIMhIxpyRXpYHEs
Message-ID: <CAEemH2eEkcA32v9piauX2GyefbkBDcDzjixEo8sptBzP5p06Dg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3AsGZRXDLbzyOanexk_Ln_AE8q1TaWyQqHhcOJxcY-E_1771926408
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] kirk: version 4.0.0
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBGZWIgMjQsIDIwMjYgYXQgMzo1M+KAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5kZT4Kd3JvdGU6Cgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFu
ZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KPiAtIFJlbW92ZSAtLWVudiBvcHRpb24KPiAtIHB5
cHJvamVjdDogaW5jbHVkZSBzdWItcGFja2FnZXMgaW4gcGlwIHBhY2thZ2UKPiAtIGxpYmtpcms6
IFByaW50IC9wcm9jL2NtZGxpbmUKPiAtIHVpOiBzaW1wbGlmeSByZXBvcgo+IC0gbWFueSBidWdz
IGZpeGVzIGFuZCBjb2RlIG9wdGltaXphdGlvbnMKPgo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYSBD
ZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KClJldmlld2VkLWJ5OiBMaSBX
YW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCkxpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10
ZXN0LXByb2plY3Qva2lyay9yZWxlYXNlcy90YWcvdjQuMC4wCj4gLS0tCj4gIHRvb2xzL2tpcmsv
a2lyay1zcmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2tpcmsva2lyay1zcmMgYi90b29scy9raXJr
L2tpcmstc3JjCj4gaW5kZXgKPiA2YWMyNjQ0ZTZlNDY5YjdiYzdkZGYzNWE2YjEwYmYxOTk0Y2Ew
OTI5Li42YjBmODdjNmRmOTBiODdhOGMzMjY0OGM5NDE2OWE4M2I0ZTU4MDI0Cj4gMTYwMDAwCj4g
LS0tIGEvdG9vbHMva2lyay9raXJrLXNyYwo+ICsrKyBiL3Rvb2xzL2tpcmsva2lyay1zcmMKPiBA
QCAtMSArMSBAQAo+IC1TdWJwcm9qZWN0IGNvbW1pdCA2YWMyNjQ0ZTZlNDY5YjdiYzdkZGYzNWE2
YjEwYmYxOTk0Y2EwOTI5Cj4gK1N1YnByb2plY3QgY29tbWl0IDZiMGY4N2M2ZGY5MGI4N2E4YzMy
NjQ4Yzk0MTY5YTgzYjRlNTgwMjQKPgo+IC0tLQo+IGJhc2UtY29tbWl0OiBmMDYyYjM0Nzg1ZGIx
MjFjODQxZjJmYWVkODIzM2IwOTQzY2RmZjI3Cj4gY2hhbmdlLWlkOiAyMDI2MDIyNC1raXJrXzQt
ZWI4YjdhMTRlOGMyCj4KPiBCZXN0IHJlZ2FyZHMsCj4gLS0KPiBBbmRyZWEgQ2VydmVzYXRvIDxh
bmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBX
YW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
