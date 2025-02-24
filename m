Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852CCC021BC
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 18:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740423295; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1UK/SqunQrP5aX4DN9PNnHjB2Y4t4tBinGoQraLbDPE=;
 b=NY2i/CuSRwGy9juaOJw57WFv4txrrqkqIMsltWRy9v1yf0zMpwZkKhVdF09nySlkhLHiX
 z4EAxLroQvSdrtToVsLYS0AZhmVOf7o17Y3AaDJNANfIUaC6n+bAr/2GDO+WA7rHHnZeF67
 qvAcH6MOUnCtrCtc8gYa4l+I8xkCWVw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDDBE3C99F4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 19:54:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A8AA3C9A5B
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 19:53:26 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AC8E41BC6082
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 19:53:25 +0100 (CET)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-abb7a6ee2deso733965966b.0
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 10:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740423205; x=1741028005; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VB77WbieVMrOXWeUA8oIKRF/XNo8czGSt3zxBh9O9aw=;
 b=TsGzfdMdoXf4Py96QAFEaqfliviMT+q7pl9rZ7LTjPUMBt1BFAuPD3XPaJaM2tfXxa
 lYEyXhSBUGTegR+GMctJ1lFlyI1+mAvgd2wXLJCgWwOX2FNIxNFpNIO+ThCPRtcuHQXR
 mCiszLrSEsf+M68Ru8H+rAmKYjY7ACddbsjrnuhVrVU4LGDXk4uJRrUR2DB/HLa/nQAU
 3s4kzu07om1gyRZkGbPUlN2sVQ/5Nn8B0b60N1yC0yTwpn0o6f2tKike4jWQGh/h8NZA
 k/fjuEaED96bZdATI8IF5yewmEEbNmJu9Fx/PjSQsB2oqV1jyQ4L+6us0luHU6x/YKif
 A6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740423205; x=1741028005;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VB77WbieVMrOXWeUA8oIKRF/XNo8czGSt3zxBh9O9aw=;
 b=JOBtIL6RSaUEXTbsCFEMmxOBs/Y2ICYhS3S64ctCFIxI8NJnrBwgLepTrRyl67iOX9
 H915g9sGs8ivYjZ/6YlYBWOaBS7MSxmf0Xee4XffQ5AYzD7N9wOZA7YBrR7uH0LBBHg2
 6UV5enpBiGmNDvqWMVfAOQTOLLBybvWVvFe3Hor5rF9itUcVQYvJHPUFkEG5UZUff82w
 aGaLzQ99a6bWs3kHr+57r6On7irs0YgqJc8PaTb9Lejg0PH3sRBatYFv2vuyxxxvdd94
 YQ0s1rwUBdGCKDgGkr/5fRRTTCyah87anU9rdU3jy5HXokDba6LL4ywdvncnuQJlHC63
 AdMA==
X-Gm-Message-State: AOJu0YxNNjO/H7KTbzLQSqD7ZbucLfrxsp7nRNk4aw6v4KY7beSc8ZoT
 7QNRvJWN2crWWmI8+kIyK3XtI58/7E8zuaN75IJJJTRpoyMDAXuX//KwgQtMz3xh8d14n3/0ov9
 z
X-Gm-Gg: ASbGncuROP1+QIhJQ/IIkZCqY524cB6jV3j8oa/gZsLibRfO66LG0X5cCVvi5u0dv+b
 VMP89h4/ZOmlOYWeP82v7CKZ/MHcCiz/iOZ0jrm83jr3T4JoJwwUWWcDy7bNkDMG0y50doYm1jf
 eLq5l80iq2nFNY+T2Ld+AkE8ldu7wp0asbWdXCt0FGJzQjf9z7ukerSZvWuR2cWxeIeYkU3gfuy
 VKqvu1ZkHSOHsNaEwelkRQLUicebTaXDdElnmd1mGtaO9lGnV3+lONec+Z/y1tVhbB6Rmsz+d/W
 bn7FTd+e8t+x6uY=
X-Google-Smtp-Source: AGHT+IEwlOpC8yNEC0Bjn3HmlUPEtDp6IAIZNNCzhj47KJ4LmZVgTg5Zc8XuTTEMKqVbe3guch6HsA==
X-Received: by 2002:a17:906:30d4:b0:ab7:f2da:8122 with SMTP id
 a640c23a62f3a-abc099f0b31mr1352810966b.3.1740423204980; 
 Mon, 24 Feb 2025 10:53:24 -0800 (PST)
Received: from localhost ([179.228.215.131])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-220d53490absm184610805ad.41.2025.02.24.10.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:53:24 -0800 (PST)
Date: Mon, 24 Feb 2025 15:53:04 -0300
MIME-Version: 1.0
Message-Id: <20250224-conversions-pause-v3-3-5e3989d37f1d@suse.com>
References: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
In-Reply-To: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4418; i=rbm@suse.com;
 h=from:subject:message-id; bh=TiLL4gAtGs28YmoY9JUci86sWgLtUFphG+Wdk2BZr3M=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnvMARyz4xBXzag7c0sVlyCvmKzHLdkFaOSRR7Q
 dEe/sHQTqiJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ7zAEQAKCRDJC4p8Y4ZY
 psEPD/9vepMf9kybW37pj7kd3kRZ4pImfswKhnQ99Jb7dj0qQS6OeZjP+Rinbl4Bj+pzI7lXYLC
 5Cj9Ywz3HhvVvXlxUUQuJ1gk42J28B4tTweQQLTk/1sgnDt1wLOkNy+wju5PUwIdNZCwKqi9xWK
 tf+RaYem+1gl6h26rdv1BGg+zBYKOp1VGk77BB5hgOjjuvaFpbEyShRkl+iUCSKmsePKZ66/fAJ
 HIcqVgfxVJY70HhDBbgtVTKARYWm3dhWXSheb2QfBsAPOU4Obc80DxPqj4qXWZB6oRtu8yZIBYD
 jVnS/g2inwRjhqaewelSkhdJlxusbH8IdsVWeJggcRpdhPW2TH7Sb6v7B3dcyt3vU7rVOVLoVYR
 yOENkk/Ifru/lKVqiwno8+cObRRYihs1/H/qsSkAKL4n4UM3M58d2mJwZzX6xI/YWieqE6oZWq0
 uxQBfhlrBuvvZVDqPNvTxDN+1moIG1x/9UhJZu5QOqjwJrBHdJSRKuJwqGNBQ7d2BFiOErQQTar
 x9UVNL9BPJiO4sYeBP6biAMXgkXKgdnCbex1RuEMSYugOSBCaroxyIBbaLcK2MsJTfpXX3iSCpH
 A6pafBnC+7OLRX2pxzy7iD9V/wWhNNEJoaM+cSKQRmH9va91ithp0MdH20Lfl+4H+NiS+w87dvF
 oXXNRxe+QFJAzbg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/5] syscalls/pause02: Delete duplicated test
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRoaXMgdGVzdCBpcyB2
ZXJ5IHNpbWlsYXIgdG8gcGF1c2UwMSwgdGhlcmVmb3JlIGRlbGV0ZSBpdC4KClNpZ25lZC1vZmYt
Ynk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogcnVudGVzdC9zeXNj
YWxscyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgLQogdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9wYXVzZS9wYXVzZTAyLmMgfCAxNDcgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCiAyIGZpbGVzIGNoYW5nZWQsIDE0OCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ydW50
ZXN0L3N5c2NhbGxzIGIvcnVudGVzdC9zeXNjYWxscwppbmRleCA0YWI4NDM2ZDMwY2E1ZmZlZTUy
ZDk3Nzc3MjllYzFlYzA5ZDBiZjFkLi42NmViZjIwZDJhYTlkZmEzNmNhOWJjNWU1NTUzNmY1YTlk
YzBlODNmIDEwMDY0NAotLS0gYS9ydW50ZXN0L3N5c2NhbGxzCisrKyBiL3J1bnRlc3Qvc3lzY2Fs
bHMKQEAgLTEwMTAsNyArMTAxMCw2IEBAIHBhdGhjb25mMDEgcGF0aGNvbmYwMQogcGF0aGNvbmYw
MiBwYXRoY29uZjAyCiAKIHBhdXNlMDEgcGF1c2UwMQotcGF1c2UwMiBwYXVzZTAyCiBwYXVzZTAz
IHBhdXNlMDMKIAogcGVyc29uYWxpdHkwMSBwZXJzb25hbGl0eTAxCmRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3BhdXNlL3BhdXNlMDIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvcGF1c2UvcGF1c2UwMi5jCmRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAw
ODUzMjMyZmQwN2IyYzYyNzgwNDlkZDQ0NzJhMWVlOGU3YWI3NjQ2Li4wMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwCi0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
cGF1c2UvcGF1c2UwMi5jCisrKyAvZGV2L251bGwKQEAgLTEsMTQ3ICswLDAgQEAKLS8qCi0gKiBD
b3B5cmlnaHQgKGMpIEludGVybmF0aW9uYWwgQnVzaW5lc3MgTWFjaGluZXMgIENvcnAuLCAyMDAx
Ci0gKiBDb3B5cmlnaHQgKGMpIDIwMTIgQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+Ci0g
KgotICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7ICB5b3UgY2FuIHJlZGlzdHJpYnV0
ZSBpdCBhbmQvb3IgbW9kaWZ5Ci0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5l
cmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQotICogdGhlIEZyZWUgU29mdHdhcmUg
Rm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKLSAqIChhdCB5
b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCi0gKgotICogVGhpcyBwcm9ncmFtIGlzIGRp
c3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCi0gKiBidXQgV0lU
SE9VVCBBTlkgV0FSUkFOVFk7ICB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YK
LSAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4g
IFNlZQotICogdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMu
Ci0gKgotICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UKLSAqIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyAgaWYgbm90LCB3
cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQotICogRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmts
aW4gU3RyZWV0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAwMjExMC0xMzAxIFVTQQotICovCi0K
LS8qCi0gKiBWZXJpZnkgdGhhdCwgcGF1c2UoKSByZXR1cm5zIC0xIGFuZCBzZXRzIGVycm5vIHRv
IEVJTlRSIGFmdGVyIHJlY2VpcHQgb2YgYQotICogc2lnbmFsIHdoaWNoIGlzIGNhdWdodCBieSB0
aGUgY2FsbGluZyBwcm9jZXNzLiBBbHNvLCB2ZXJpZnkgdGhhdCB0aGUgY2FsbGluZwotICogcHJv
Y2VzcyB3aWxsIHJlc3VtZSBleGVjdXRpb24gZnJvbSB0aGUgcG9pbnQgb2Ygc3VzcGVuc2lvbi4K
LSAqLwotCi0jaW5jbHVkZSA8dW5pc3RkLmg+Ci0jaW5jbHVkZSA8ZXJybm8uaD4KLSNpbmNsdWRl
IDxmY250bC5oPgotI2luY2x1ZGUgPHN5cy93YWl0Lmg+Ci0KLSNpbmNsdWRlICJ0ZXN0LmgiCi0K
LWNoYXIgKlRDSUQgPSAicGF1c2UwMiI7Ci1pbnQgVFNUX1RPVEFMID0gMTsKLXN0YXRpYyBwaWRf
dCBjcGlkOwotCi1zdGF0aWMgdm9pZCBkb19jaGlsZCh2b2lkKTsKLXN0YXRpYyB2b2lkIHNldHVw
KHZvaWQpOwotc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKTsKLQotaW50IG1haW4oaW50IGFjLCBj
aGFyICoqYXYpCi17Ci0JaW50IGxjOwotCWludCBzdGF0dXM7Ci0KLQl0c3RfcGFyc2Vfb3B0cyhh
YywgYXYsIE5VTEwsIE5VTEwpOwotCi0Jc2V0dXAoKTsKLQotCWZvciAobGMgPSAwOyBURVNUX0xP
T1BJTkcobGMpOyBsYysrKSB7Ci0JCXRzdF9jb3VudCA9IDA7Ci0KLQkJY3BpZCA9IHRzdF9mb3Jr
KCk7Ci0JCXN3aXRjaCAoY3BpZCkgewotCQljYXNlIC0xOgotCQkJdHN0X2Jya20oVEJST0ssIGNs
ZWFudXAsICJmb3JrKCkgZmFpbGVkIik7Ci0JCWJyZWFrOwotCQljYXNlIDA6Ci0JCQlkb19jaGls
ZCgpOwotCQlicmVhazsKLQkJZGVmYXVsdDoKLQkJYnJlYWs7Ci0JCX0KLQotCQkvKgotCQkgKiBX
YWl0IGZvciBjaGlsZCB0byBlbnRlciBwYXVzZSgpLgotCQkgKi8KLQkJVFNUX1BST0NFU1NfU1RB
VEVfV0FJVChjbGVhbnVwLCBjcGlkLCAnUycpOwotCi0JCS8qCi0JCSAqIFNlbmQgdGhlIFNJR0lO
VCBzaWduYWwgbm93LCBzbyB0aGF0IGNoaWxkCi0JCSAqIHJldHVybnMgZnJvbSBwYXVzZSBhbmQg
cmVzdW1lcyBleGVjdXRpb24uCi0JCSAqLwotCQlraWxsKGNwaWQsIFNJR0lOVCk7Ci0KLQkJd2Fp
dCgmc3RhdHVzKTsKLQotCQlpZiAoV0lGRVhJVEVEKHN0YXR1cykpIHsKLQkJCWlmIChXRVhJVFNU
QVRVUyhzdGF0dXMpID09IDApCi0JCQkJdHN0X3Jlc20oVFBBU1MsICJwYXVzZSB3YXMgaW50ZXJy
dXB0ZWQgY29ycmVjdGx5Iik7Ci0JCQllbHNlCi0JCQkJdHN0X3Jlc20oVEZBSUwsICJwYXVzZSB3
YXMgaW50ZXJydXB0ZWQgYnV0IHRoZSAiCi0JCQkJICAgICAgICAgICAgICAgICJyZXR2YWwgYW5k
L29yIGVycm5vIHdhcyB3cm9uZyIpOwotCQkJY29udGludWU7Ci0JCX0KLQotCQlpZiAoV0lGU0lH
TkFMRUQoc3RhdHVzKSkgewotCQkJc3dpdGNoIChXVEVSTVNJRyhzdGF0dXMpKSB7Ci0JCQljYXNl
IFNJR0FMUk06Ci0JCQkJdHN0X3Jlc20oVEZBSUwsICJUaW1lb3V0OiBTSUdJTlQgd2Fzbid0IHJl
Y2VpdmVkIGJ5IGNoaWxkIik7Ci0JCQlicmVhazsKLQkJCWRlZmF1bHQ6Ci0JCQkJdHN0X3Jlc20o
VEZBSUwsICJDaGlsZCBraWxsZWQgYnkgc2lnbmFsIik7Ci0JCQl9Ci0KLQkJCWNvbnRpbnVlOwot
CQl9Ci0KLQkJdHN0X3Jlc20oVEZBSUwsICJQYXVzZSB3YXMgbm90IGludGVycnVwdGVkIik7Ci0J
fQotCi0JY2xlYW51cCgpOwotCXRzdF9leGl0KCk7Ci19Ci0KLXN0YXRpYyB2b2lkIHNpZ19oYW5k
bGUoaW50IHNpZykKLXsKLX0KLQotc3RhdGljIHZvaWQgZG9fY2hpbGQodm9pZCkKLXsKLQkvKiBh
dm9pZCBMVFAgZnJhbWV3b3JrIHRvIGRvIHdoYXRldmVyIGl0IGxpa2VzICovCi0Jc2lnbmFsKFNJ
R0FMUk0sIFNJR19ERkwpOwotCi0JaWYgKHNpZ25hbChTSUdJTlQsIHNpZ19oYW5kbGUpID09IFNJ
R19FUlIpIHsKLQkJZnByaW50ZihzdGRlcnIsICJDaGlsZDogRmFpbGVkIHRvIHNldHVwIHNpZ25h
bCBoYW5kbGVyXG4iKTsKLQkJZXhpdCgxKTsKLQl9Ci0KLQkvKiBDb21taXQgc3VpY2lkZSBhZnRl
ciAxMCBzZWNvbmRzICovCi0JYWxhcm0oMTApOwotCi0JVEVTVChwYXVzZSgpKTsKLQotCWlmIChU
RVNUX1JFVFVSTiA9PSAtMSkgewotCQlpZiAoVEVTVF9FUlJOTyA9PSBFSU5UUikKLQkJCWV4aXQo
MCk7Ci0KLQkJZnByaW50ZihzdGRlcnIsICJDaGlsZDogUGF1c2UgcmV0dXJuZWQgLTEgYnV0IGVy
cm5vIGlzICVkICglcylcbiIsCi0JCSAgICAgICAgVEVTVF9FUlJOTywgc3RyZXJyb3IoVEVTVF9F
UlJOTykpOwotCQlleGl0KDEpOwotCX0KLQotCWZwcmludGYoc3RkZXJyLCAiQ2hpbGQ6IFBhdXNl
IHJldHVybmVkICVsZFxuIiwgVEVTVF9SRVRVUk4pOwotCWV4aXQoMSk7Ci19Ci0KLXN0YXRpYyB2
b2lkIHNldHVwKHZvaWQpCi17Ci0JdHN0X3NpZyhGT1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7
Ci0KLQlURVNUX1BBVVNFOwotfQotCi1zdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCi17Ci19Cgot
LSAKMi40OC4xCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
