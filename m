Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2496C36017
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 05:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743397578; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Vjo6yk6gfu55w0t9B1PpqqqKS7bYktwfk/bag0YkfXY=;
 b=lb5MNZNN5+lXQabyu0X9qQrlG9tr0Scy16w/yqgQD4dPXYWYnwZPmk3TkwVfc/uBhaJmc
 9B3EpVWE7w8h7Kq+VbYMR04n4jIVk/fEITJAR3OAwd13ESft9Qhtl9hKpyFTn9i8FJ/jWkW
 PjOKBkWd+jaZNjbkJuI5+v8KJwilbKI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6E3D3CA825
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 07:06:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 406E63C073D
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 07:05:56 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1ECC3100045B
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 07:05:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743397553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sm+29RBtolMMrs+AIropWiXZmp1J8Ka2Ry+om+YeEiM=;
 b=ie8QyAPyqzTMqmMfE0xC4tqxu4FZs0ycu2Xc5phkX0IJ6Ez20tasUlNRc8a+EtyEW9CfUD
 +EaXO6pKoicBPVUgpv0fpp8eKxsSJSqpDzEATZfMsWc2YHn8EknSHAh7uDb59kXiQ0qdDk
 SbrDGBQ4byQ8kYLDqGGoAs0nV+rqHKk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-pDKm0OpzOxKKxHuFnLavzw-1; Mon, 31 Mar 2025 01:05:51 -0400
X-MC-Unique: pDKm0OpzOxKKxHuFnLavzw-1
X-Mimecast-MFC-AGG-ID: pDKm0OpzOxKKxHuFnLavzw_1743397551
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff68033070so6561493a91.2
 for <ltp@lists.linux.it>; Sun, 30 Mar 2025 22:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743397550; x=1744002350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sm+29RBtolMMrs+AIropWiXZmp1J8Ka2Ry+om+YeEiM=;
 b=xKeNLshLoP3PGAmmCyBWuDBNHBNgOGhiRykWv/D9HGYUiSZAYEKxKaKSMUGXofkWy2
 2/DDnIMxbda0tlC0FaxJd/nH8kPZtL/AXLrAB9s8doUreeJ6SZkfv3ISp5esc+YVTeu3
 JxtDdK6oNvMVZgZtTy8nXyu1CqCCnrGsj3/OFWmBuDyLY+d75Ruy+Ov7OdKtKOhMupQv
 uotCTJv+50sdpN8pOfW3rdHQhbFMl6bpmqnq4oz+dvI9r1yyUwqJQ9M3Xw+VrunREjdi
 DBsYjt+qPc/f2JYbuMDHduziEK69aCB5A6Upu6WttjBRVd8FjtpG5Zeps99cCL5bwDeK
 caIw==
X-Gm-Message-State: AOJu0YwLtkArLPsaLx26Jh/PoOPgcziTRJd23pvSy5i2Nfclrq8zzUnD
 sijfKdYpOH725hQ3s2PQUBSYXD8MrscpbHmQNNedpsdOQAGZEDAKDPTTSPd1ArlY3h0T5NKrRZ4
 cNcmH0yEfQpr0tCquZ52Uo6aSg6dFi+CD6Eh7mu9/8YX5lJW3y0Iu8jl5rkiqqhwP5JsuWxAS6D
 e/PLjKbSfOdJGvBe8E5DveuK6UAlyiNwNA9n/L
X-Gm-Gg: ASbGncucj3LtFJYXFZzTTuV23HzYBdoiUdPoq7S3PTRdaeHzPDnbWlGrtB4Iul2P8cF
 okZ5VHqtkzDvPpms9WfWXCRFuImk4MQURRsoWwo6LPVINoUAf59+OBknkRjinRLPeHKXoZQ4kTA
 ==
X-Received: by 2002:a17:90b:380e:b0:2f9:c139:b61f with SMTP id
 98e67ed59e1d1-30531fa6bf9mr15598519a91.14.1743397550115; 
 Sun, 30 Mar 2025 22:05:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXm6yeSBAm5yLM6Thf9UzIHdGph8hJpLlM8XAGWowuqYjkG61iA1yLt56lGXXyHYOl7r6YG0ys5Ty+vXRYDg4=
X-Received: by 2002:a17:90b:380e:b0:2f9:c139:b61f with SMTP id
 98e67ed59e1d1-30531fa6bf9mr15598501a91.14.1743397549805; Sun, 30 Mar 2025
 22:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250328075958.7616-1-wegao@suse.com>
 <20250331031945.5948-1-wegao@suse.com>
 <20250331031945.5948-2-wegao@suse.com>
In-Reply-To: <20250331031945.5948-2-wegao@suse.com>
Date: Mon, 31 Mar 2025 13:05:38 +0800
X-Gm-Features: AQ5f1JptnJK5HJQOKGjWb7Zszc0L3o3hMof3qtAr9KQ_YxLTSc97vjb-ZvwH_6o
Message-ID: <CAEemH2c2WA87RcfeX1VYXYebHBcQpSP2y8umbDEnrWnaKDcApg@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _js2D_cVQqIcLo9H-2cHfJg7LpnrVKQrEgxBFn5Wkqg_1743397551
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v9 1/2] cpuset02: Convert the test6 from
 cpuset_memory_testset.sh to C code
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

T24gTW9uLCBNYXIgMzEsIDIwMjUgYXQgMTE6MjDigK9BTSBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNv
bT4gd3JvdGU6Cgo+IEltcHJvdmVtZW50cyBjb21wYXJlIHdpdGggdGVzdDYgc2hlbGwgdGVzdDoK
PiAqIFJlbW92ZSAvYmluL2VjaG8gJGxvYWRfYmFsYW5jZSA+ICRwYXRoL2NwdXNldC5zY2hlZF9s
b2FkX2JhbGFuY2UKPiBzaW5jZSB0ZXN0IGZvY3VzIG9uIHZlcmlmeSBodWdlIHBhZ2UgaXMgcmVh
bGx5IGFsbG9jYXRlZCBpbiB0aGUgY29ycmVjdAo+IG5vZGUsIHRhc2sgbm8gbmVlZCBiaW5kIHRv
IHNwZWNpZmljIGNwdXNldC4KPiAqIERpcmVjdGx5IGtlZXAgMSBocGFnZSByZXNlcnZlZCBpbiBl
YWNoIG5vZGUgb3RoZXJ3aXNlIHRlc3QgY2FzZSBoYXMKPiBjaGFuY2UgdG8gZmFpbCwgc2luY2Ug
YGVjaG8gMSA+IC9wcm9jL3N5cy92bS9ucl9odWdlcGFnZXNgIHdpbGwgdHJ5IHRvCj4gcmVzZXJ2
ZSAxIHBhZ2VzIGZyb20gYSBOVU1BIG5vZGUgcmFuZG9tbHkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBX
ZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4KPiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVs
QHN1c2UuY3o+Cj4gU3VnZ2VzdGVkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KPgoK
UmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKCj4gK3N0YXRpYyB2b2lk
IGNoaWxkKHZvaWQpCj4gK3sKPiArICAgICAgIGNoYXIgKnA7Cj4gKyAgICAgICBpbnQgZmRfaHVn
ZXBhZ2U7Cj4gKwo+ICsgICAgICAgZmRfaHVnZXBhZ2UgPSBTQUZFX09QRU4oSFVHRV9QQUdFX0ZJ
TEUsIE9fQ1JFQVQgfCBPX1JEV1IsIDA3NTUpOwo+CgoKPiArVFNUX0VYUF9QQVNTX1NJTEVOVChz
eXN0ZW0oImNhdCAvcHJvYy9tZW1pbmZvIikpOwo+CgpUaGlzIGxpbmUgaXMgZm9yIGRlYnVnZ2lu
ZyBwdXJwb3NlcywgSSBndWVzcywgYW5kIGl0IHNob3VsZCBiZSByZW1vdmVkIGluCnRoZSBmb3Jt
YWwgcGF0Y2guCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
