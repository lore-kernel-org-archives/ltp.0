Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4007ACAC5A5
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 07:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758614233; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=uyERDpWaF4fWYQkiofcumhGpxTFrbbZz0xuGFk6YGz8=;
 b=EO2rFnxtMIml4XBbmkybLD3OVAHlraQdLAiVAWnA9KrSb38oD1XbywRv5o5QorYiIzktk
 IOJpXsQbYzrRKPGCLs9HFdfm0jczHPLuX8bDlCRsKUPSv/7L9L/e3oVXXEYF/aTSpeQdZod
 E8ji/ivN9hOqFwrf6PswCxp1twDLqiE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DAA63CDE83
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 09:57:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D6993C4F80
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 09:56:52 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 27FEF1A0009C
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 09:56:51 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45f2c9799a3so38954525e9.0
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 00:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758614210; x=1759219010; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M74eFr/A9KblmqWL2IdODxwYMbATubvDExjJ4g+RlG0=;
 b=SjnFZLYBaYPeY1dCN2xEQ0pba4i/t8DcycT5IB1Hfpii5qLy1fUNQDvQPaRub4K/Sq
 Zy499lyEysyoZtrScZ1yuxhm65VCL15K6aSpVp1LNtF385MB8jKHmESdTJP8g5hmzBJf
 dg6n2YPDeS3oT1ATjJdXKhz1C9gUrTRVVMNgDwLL/pscyVmK5DbPTp0IabxsqNEnmWOK
 5bHr54qGOI/6yVf3oeC++uAiZJAoDQhoaiZXq20F+ueHwEwLrnKs9AESgUrquogeQLHu
 3q1nFNdbi+ppiY+/JzbU42cnDVMop0G4XRTd+opDdxUoA5dWC3NQcc1Oj9T0KCV3G0kW
 KLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758614210; x=1759219010;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M74eFr/A9KblmqWL2IdODxwYMbATubvDExjJ4g+RlG0=;
 b=QUj6GrxDGPNimx3zZOAN+cbJ1ap6zMTXTRDV9QARhpXrC0yRLEsQNG5Qg9iOA+wQKM
 R79n3KSXak5vSWaN7z6DUI3vAQ9kCuXV3DqpyXpu1B1UMctSmsIJnKFNQKUElHakAGDN
 yIIhwuRIzaJoVeREpI0c/F3KvXAmj7cx9D8ZUTCnA31/yE4wLcjVs8QwT76X9wr3Tb0x
 cXwjnDm5ga8yM3arSIPUl+y6frgWilNqQNvKD0Xn4ccM4Pydnz4dko/k++0G6XcARX4Z
 BtZ70OUKYVCCVbqKb/LQNbUuZa/vqMe88tONmX9BSAB4tUunTLh6TF889nop+CMIG6nW
 XRhw==
X-Gm-Message-State: AOJu0YxbaQji2Cf3VNZ3cB8FDaDRBP6MVHfBtfYxY2Jr7ZdebI6CHwPd
 UUc2/JrEY1vPrVtZYHYciCC1z+2tUthQiquZtGf9CqVlNo2eQNKL5x2pBv29wSlk+2w=
X-Gm-Gg: ASbGnctugtJz+tZ+AnYiJ/q1tr4WTBxiCYEtDVC2khmAcGI5p/7lWS7S3FETWA0+oT/
 nJcFFlojEZpHE33HeTLUwIHEOuWdgYfiUq8AkWoagGxuyoJca9eVLktbzZ/45igmJ5Cghez0Hru
 YdFocZbjxbT/Oat+j8btRmX76ZV//HPXOpVYNEv4I7o6c0JFg1Fubx43g4c6XUnrLQoUn39yGiI
 LadB8yMQ7EGNiDEbLJU17PO8214Zp3PZ2ZZgA51sP5ObOuM3nikFBZEu869irRopgMuZ9rxzaVg
 x1DXUuUwIDdp/v6/+BGvkiknIK67GgF/YtrbXo8UGLfcoaQOE0yIjGMQE+0jTRaPOPJq/8dQarI
 ToM8ZrMFfm7vN/Evmy4VjgOuYM+02zc3VPNg0Y8zZUFlibOIf7QfnXbPE4XtKTKvbUv7n2dR34t
 YUe6Lb9va4QEIFra1LJX6vrvP+ncwDGE1RnfidyG8hM86Lmg4rULx9+SUglCl9dUc=
X-Google-Smtp-Source: AGHT+IF7IFFv8BnJ7rZA2jrTueWa0MKMH/eshB/8yuQgootUj7KSZt0nIzgShhV02AtXsR9TK/g0lQ==
X-Received: by 2002:a05:600c:198f:b0:468:9e79:bee0 with SMTP id
 5b1f17b1804b1-46e1d90cda6mr12981655e9.0.1758614210268; 
 Tue, 23 Sep 2025 00:56:50 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f17:6d00:961b:d261:4569:b9c8?
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46d7a566a27sm65379295e9.20.2025.09.23.00.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 00:56:50 -0700 (PDT)
Message-ID: <4721ff31-7d9f-42a2-8217-6d1d4006f661@suse.com>
Date: Tue, 23 Sep 2025 09:56:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250922-cve-2025-21756-v1-1-074da211288a@suse.com>
 <aNFd7UYkgVk3xgU_@yuki.lan>
Content-Language: en-US
In-Reply-To: <aNFd7UYkgVk3xgU_@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] cve: add test reproducer for cve-2025-21756
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiA5LzIyLzI1IDQ6MzIgUE0sIEN5cmlsIEhydWJpcyB3cm90ZToKPiBIaSEKPj4gKy8q
XAo+PiArICogVGVzdCBmb3IgQ1ZFLTIwMjUtMjE3NTYgZml4ZWQgaW4ga2VybmVsIHY2LjE0Ogo+
PiArICogZmNkZDIyNDJjMDIzIHZzb2NrOiBLZWVwIHRoZSBiaW5kaW5nIHVudGlsIHNvY2tldCBk
ZXN0cnVjdGlvbgo+PiArICoKPj4gKyAqIFJlcHJvZHVjZXIgYmFzZWQgb246Cj4+ICsgKmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDEyOC12c29jay10cmFuc3BvcnQtdnMtYXV0b2Jp
bmQtdjMtNS0xY2Y1NzA2NWI3NzBAcmJveC5jby8KPj4gKyAqCj4+ICsgKiBCZXdhcmUsIHRoaXMg
dGVzdCB3aWxsIGNyYXNoIHRoZSBzeXN0ZW0uCj4+ICsgKi8KPj4gKwo+PiArI2luY2x1ZGUgInRz
dF90ZXN0LmgiCj4+ICsKPj4gKyNpZiBIQVZFX0xJTlVYX1ZNX1NPQ0tFVFNfSAo+PiArCj4+ICsj
aW5jbHVkZSAibGFwaS92bV9zb2NrZXRzLmgiCj4gRG8gd2UgbmVlZCB0aGUgI2lmIEhBVkVfTElO
VVhfVk1fU09DS0VUU19IIGlmIHdlIGluY2x1ZGUgbGFwaS8gZmFsbGJhY2s/ClllcyB3ZSBkbyBu
ZWVkIGEgc3RydWN0IHNvY2thZGRyX3ZtIGZhbGxiYWNrIGRlZmluaXRpb24gaW4gTFRQLgo+Cj4+
ICsjZGVmaW5lIE1BWF9QT1JUX1JFVFJJRVMJMjQKPj4gKyNkZWZpbmUgVk1BRERSX0NJRF9OT05F
WElTVElORwk0Mgo+PiArCj4+ICtzdGF0aWMgaW50IHZzb2NrX2JpbmQodW5zaWduZWQgaW50IGNp
ZCwgdW5zaWduZWQgaW50IHBvcnQsIGludCB0eXBlKQo+PiArewo+PiArCWludCBzb2NrOwo+PiAr
Cj4+ICsJc3RydWN0IHNvY2thZGRyX3ZtIHNhID0gewo+PiArCQkuc3ZtX2ZhbWlseSA9IEFGX1ZT
T0NLLAo+PiArCQkuc3ZtX2NpZCA9IGNpZCwKPj4gKwkJLnN2bV9wb3J0ID0gcG9ydCwKPj4gKwl9
Owo+PiArCj4+ICsJc29jayA9IFNBRkVfU09DS0VUKEFGX1ZTT0NLLCB0eXBlLCAwKTsKPj4gKwlT
QUZFX0JJTkQoc29jaywgKHN0cnVjdCBzb2NrYWRkciAqKSZzYSwgc2l6ZW9mKHNhKSk7Cj4gSSBn
dWVzcyB0aGF0IHdpdGggdGhlIGxhcGkgZmFsbGJhY2sgd2Ugc2hvdWxkIFRDT05GIGhlcmUgb24g
RU5PU1lTCj4gaW5zdGVhZCBhbmQgZHJvcCB0aGUgI2lmIGF0IHRoZSB0b3AuCj4KPiBPdGhlciB0
aGFuIHRoYXQgdGhlIHJlc3QgbG9va3MgZ29vZC4KPgo+IC0tIEN5cmlsIEhydWJpcyBjaHJ1Ymlz
QHN1c2UuY3oKSSBqdXN0IHJlYWxpemVkIHRoYXQgdGhlIHRlc3QgaXMgbm90IGFsd2F5cyBwcm9k
dWNpbmcgYSBzeXN0ZW0gY3Jhc2guIEkgCnRlc3RlZCB0aGUgY3ZlIGluc2lkZSBhIFZNIGFuZCBv
YnRhaW5lZCBhIGNyYXNoIF9idXRfIHRoZSBmb2xsb3dpbmcgCmRtZXNnIGVycm9yOgoKW8KgIMKg
IDEuMjgyOTg0XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0KW8KgIMKgIDEu
MjgzNTA5XSByZWZjb3VudF90OiB1bmRlcmZsb3c7IHVzZS1hZnRlci1mcmVlLgpbwqAgwqAgMS4y
ODQwNDldIFdBUk5JTkc6IENQVTogNCBQSUQ6IDIwNSBhdCBsaWIvcmVmY291bnQuYzoyOCAKcmVm
Y291bnRfd2Fybl9zYXR1cmF0ZSsweGQwLzB4MTMwClvCoCDCoCAxLjI4NDk0NF0gTW9kdWxlcyBs
aW5rZWQgaW46ClvCoCDCoCAxLjI4NTI4Ml0gQ1BVOiA0IFVJRDogMCBQSUQ6IDIwNSBDb21tOiBj
dmUtMjAyNS0yMTc1NiBUYWludGVkOiBHwqAgwqAgCiDCoCDCoCBXwqAgwqAgwqAgwqAgwqAgNi4x
My4wLXZpcnRtZSAjNDMKW8KgIMKgIDEuMjg2MjUxXSBUYWludGVkOiBbV109V0FSTgpbwqAgwqAg
MS4yODY1OTNdIEhhcmR3YXJlIG5hbWU6IEJvY2hzIEJvY2hzLCBCSU9TIEJvY2hzIDAxLzAxLzIw
MTEKW8KgIMKgIDEuMjg3MTg3XSBSSVA6IDAwMTA6cmVmY291bnRfd2Fybl9zYXR1cmF0ZSsweGQw
LzB4MTMwClvCoCDCoCAxLjI4Nzc1MV0gQ29kZTogMGIgOTAgOTAgZTkgNjIgNzYgNzUgMDAgODAg
M2QgMTAgNTQgNDQgMDEgMDAgMGYgODUgCjc1IGZmIGZmIGZmIGM2IDA1IDAzIDU0IDQ0IDAxIDAx
IDkwIDQ4IGM3IGM3IDgwIGMxIGNhIGFjIGU4IDExIGJlIGI4IGZmIAo5MCA8MGY+IDBiIDkwIDkw
IGU5IDM3IDc2IDc1IDAwIDgwIDNkIGU2IDUzIDQ0IDAxIDAwIDBmIDg1IDRhIGZmIGZmIGZmClvC
oCDCoCAxLjI4OTY4Ml0gUlNQOiAwMDE4OmZmZmZiMmZlYzA1MWZlNjAgRUZMQUdTOiAwMDAxMDI4
MgpbwqAgwqAgMS4yOTAyMjhdIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZmZmY5MGY0Yzdl
NTAwMDAgUkNYOiAKMDAwMDAwMDAwMDAwMDAwMApbwqAgwqAgMS4yOTA5ODddIFJEWDogMDAwMDAw
MDAwMDAwMDAwMCBSU0k6IGZmZmZiMmZlYzA1MWZkMDAgUkRJOiAKMDAwMDAwMDAwMDAwMDAwMQpb
wqAgwqAgMS4yOTE3NDFdIFJCUDogZmZmZjkwZjRjN2U1MDAwMCBSMDg6IDAwMDAwMDAwZmZmZmRm
ZmYgUjA5OiAKMDAwMDAwMDAwMDAwMDAwMQpbwqAgwqAgMS4yOTI1MDFdIFIxMDogMDAwMDAwMDBm
ZmZmZGZmZiBSMTE6IGZmZmZmZmZmYWQwNzZiMjAgUjEyOiAKZmZmZmZmZmZhYzk0ODNjMApbwqAg
wqAgMS4yOTMyNDldIFIxMzogMDAwMDAwMDAwMDAwMDAwMCBSMTQ6IGZmZmY5MGY0YzkyNWNmMDAg
UjE1OiAKMDAwMDAwMDAwMDAwMDAwMApbwqAgwqAgMS4yOTQwMTddIEZTOsKgIDAwMDA3ZjI2YmVi
NmE3NDAoMDAwMCkgR1M6ZmZmZjkwZjRmZWIwMDAwMCgwMDAwKSAKa25sR1M6MDAwMDAwMDAwMDAw
MDAwMApbwqAgwqAgMS4yOTQ4NjNdIENTOsKgIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAw
MDAwMDAwMDgwMDUwMDMzClvCoCDCoCAxLjI5NTQ3OV0gQ1IyOiAwMDAwMDAwMDAwNDM5MTkwIENS
MzogMDAwMDAwMDAwN2Q5MjAwMCBDUjQ6IAowMDAwMDAwMDAwMzUwZWYwClvCoCDCoCAxLjI5NjIx
Nl0gQ2FsbCBUcmFjZToKW8KgIMKgIDEuMjk2NTAxXcKgIDxUQVNLPgpbwqAgwqAgMS4yOTY3MzRd
wqAgPyByZWZjb3VudF93YXJuX3NhdHVyYXRlKzB4ZDAvMHgxMzAKW8KgIMKgIDEuMjk3MjIxXcKg
ID8gX193YXJuLmNvbGQrMHhiMC8weDEwYwpbwqAgwqAgMS4yOTc2MzRdwqAgPyByZWZjb3VudF93
YXJuX3NhdHVyYXRlKzB4ZDAvMHgxMzAKW8KgIMKgIDEuMjk4MTE4XcKgID8gcmVwb3J0X2J1Zysw
eGQ4LzB4MTUwClvCoCDCoCAxLjI5ODUzNl3CoCA/IGhhbmRsZV9idWcrMHg1NC8weDkwClvCoCDC
oCAxLjI5ODk1OV3CoCA/IGV4Y19pbnZhbGlkX29wKzB4MTcvMHg3MApbwqAgwqAgMS4yOTk1MzFd
wqAgPyBhc21fZXhjX2ludmFsaWRfb3ArMHgxYS8weDIwClvCoCDCoCAxLjI5OTk3OF3CoCA/IHJl
ZmNvdW50X3dhcm5fc2F0dXJhdGUrMHhkMC8weDEzMApbwqAgwqAgMS4zMDA1MjNdwqAgdnNvY2tf
cmVtb3ZlX2JvdW5kKzB4OTIvMHhhMApbwqAgwqAgMS4zMDA5NTVdwqAgX192c29ja19yZWxlYXNl
KzB4MTlhLzB4MWMwClvCoCDCoCAxLjMwMTQwNV3CoCB2c29ja19yZWxlYXNlKzB4MzIvMHg1MApb
wqAgwqAgMS4zMDE3OThdwqAgX19zb2NrX3JlbGVhc2UrMHgzZC8weGIwClvCoCDCoCAxLjMwMjE5
N13CoCBzb2NrX2Nsb3NlKzB4MTUvMHgyMApbwqAgwqAgMS4zMDI1ODRdwqAgX19mcHV0KzB4ZDkv
MHgyOTAKW8KgIMKgIDEuMzAyOTExXcKgIF9feDY0X3N5c19jbG9zZSsweDNjLzB4ODAKW8KgIMKg
IDEuMzAzMzE3XcKgIGRvX3N5c2NhbGxfNjQrMHg5ZS8weDFhMApbwqAgwqAgMS4zMDM3MjZdwqAg
ZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzcvMHg3ZgpbwqAgwqAgMS4zMDQyNTVd
IFJJUDogMDAzMzoweDdmMjZiZWMwNTAzYQpbwqAgwqAgMS4zMDQ2NTVdIENvZGU6IDA4IDAzIDAw
IDAwIDU5IDVlIDQ4IDgzIGY4IGZjIDc1IDFlIDgzIGUyIDM5IDgzIGZhIAowOCA3NSAxNiBlOCAx
NSBmZiBmZiBmZiAwZiAxZiA4MCAwMCAwMCAwMCAwMCA0OSA4OSBjYSA0OCA4YiA0NCAyNCAyMCAw
ZiAKMDUgPDQ4PiA4MyBjNCAxOCBjMyA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5MCA5
MCA5MCA5MCA5MCBmMyAwZgpbwqAgwqAgMS4zMDc4MDBdIFJTUDogMDAyYjowMDAwN2ZmZTJmNjJl
NGUwIEVGTEFHUzogMDAwMDAyMDIgT1JJR19SQVg6IAowMDAwMDAwMDAwMDAwMDAzClvCoCDCoCAx
LjMwODYxOF0gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDdmZmUyZjYyZTVlYyBSQ1g6
IAowMDAwN2YyNmJlYzA1MDNhClvCoCDCoCAxLjMwOTM4OV0gUkRYOiAwMDAwMDAwMDAwMDAwMDAw
IFJTSTogMDAwMDAwMDAwMDAwMDAwMCBSREk6IAowMDAwMDAwMDAwMDAwMDAzClvCoCDCoCAxLjMx
MDE0M10gUkJQOiAwMDAwMDAwMDAwMDAwMDAzIFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IAow
MDAwMDAwMDAwMDAwMDAwClvCoCDCoCAxLjMxMDkwM10gUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIx
MTogMDAwMDAwMDAwMDAwMDIwMiBSMTI6IAowMDAwMDAwMDAwNDI0MDM4ClvCoCDCoCAxLjMxMTY4
Ml0gUjEzOiAwMDAwMDAwMDAwMDAwMDRjIFIxNDogMDAwMDAwMDAwMDAwMDAwMCBSMTU6IAowMDAw
MDAwMDAwMDAwMDAwClvCoCDCoCAxLjMxMjQ2Ml3CoCA8L1RBU0s+CgpbwqAgwqAgMS4zMTI3MDhd
IC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQoKSSBndWVzcyB3ZSBuZWVkIHRv
IHZlcmlmeSB0aGF0LCBpZiBzeXN0ZW0gaXMgbm90IGNyYXNoZWQsIHdlIHNob3VsZCAKY2hlY2sg
a2VybmVsIG1lc3NhZ2VzIGluIG9yZGVyIHRvIGZpbmQgYW55IGVycm9yLiBJcyB0aGVyZSBhIHNt
YXJ0IHdheSAKdG8gZG8gaXQ/IEkgY291bGQgcGFyc2UgZGF0YSB2aWEgRklMRV9MSU5FU19TQ0FO
RigpIG1hY3JvLCBidXQgdGhhdCAKd291bGQgcmVxdWlyZSBtdWx0aXBsZSBpdGVyYXRpb25zLiBU
aGUgYWx0ZXJuYXRpdmUgaXMganVzdCB0byBwYXJzZSB0aGUgCmVudGlyZSAvZGV2L2ttc2cgdmlh
IHJlYWQoKSBhbmQgdG8gZmluZDoKCjEuIHVzZS1hZnRlci1mcmVlIG1lc3NhZ2UKMi4gdGVzdCBu
YW1lIGFmdGVyIGl0CjMuIGZhaWxpbmcgc3lzY2FsbCB2c29ja19yZWxlYXNlCgpXRFlUPyBNYXli
ZSB0aGVyZSBhcmUgYmV0dGVyIHdheXMgdG8gZG8gaXQuCgotIEFuZHJlYQoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
