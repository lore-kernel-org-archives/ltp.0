Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39502EC01A1
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 07:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774252100; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=q0rxJdI7+xVE3VMzZ4erG8l14rmabE1vOcQ8uPEqWHs=;
 b=lbmXY2xE+gIH13Z/l9SLJ6o14okmu0MZFB60cmvZeVOMOlQH8kiwcYxUmg4P66fS67Tdh
 ufMaGm8NVYIGcQ6z8zgqus1wD44GtyLYCoV9n7dqki4sEI6iuKyGXhc+z/jawwbwJ8lQOWK
 JL+yYk5/y2CEcHEUfJfm+jsKkkpCGBU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C599B3E2267
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 08:48:20 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B26083C6147
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 08:47:55 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F174C1400C76
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 08:47:54 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-486b96760easo41613015e9.2
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 00:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774252074; x=1774856874; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hsI9Qze4L8YuT+RBV3sV6t29LaOQ4keOW+JZWOgj7Is=;
 b=BER2TdCQE93klHD+6cRNA46Ybb3/cJwBlr5v3PXm3AlvwDQlB8CvWZrsBy8vARHfHz
 3erT8OmwPsuJTCS28WJMpILydlPliX6K4/qx9eG1OTx2UxjTNq01u2nIezbU6g4g0PXv
 +/BhPMm+roY/Vq97cqlGuUp2B7jJNqOA/BUC5uQbmCmiXoPySgOZ0a3ETcXvLMNp77lo
 0U9nVH+I8SPOIW/E9HIv/JsHSL3KkkCK98riDedeopoNovI4x24h5bM4uqMc9wROikpZ
 LhwSdkcGdnV78agEjKWWe0/DzbEtK4G3liWo0TdlH3855faryzWwoDRVFUvs7GV/7IsI
 d83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774252074; x=1774856874;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hsI9Qze4L8YuT+RBV3sV6t29LaOQ4keOW+JZWOgj7Is=;
 b=sa3OVcHG4efpRkHHfMBlbA8Oh5UNacXXJuiGonJ/LH1yze3dm3DJaVgYwWNqJtxNPH
 h08i6OWH3QxKMTPxxypAREzEAhyMc9qC0t5Z3TSIZWcSR0YoADQlaJ+pg1nLxCoy5P14
 FwIR/dB32S1bt7JnlXVW8W7OX6lpUAdnBJQMHwyCD1qajts/IXndbvBHTOmFR10eexwG
 usedgqWc3qXRNkSGw8wS22TUV0/jmkqDSb8WWWNTy7NdD6URTgixHXb1xAGgGp8dTxgg
 kBPd/bvixJon20pZGcqjfG3l/4qdrjfCq9l/JBejWpBzkPpMdSqvQpI4So2ehNlWQ+Nm
 SMnw==
X-Gm-Message-State: AOJu0Yxe+kZRUq30AjiLwtKPGj7WYGxhPiLNStUTpT3IGMa9jKJQ1xyD
 AyU26jXQMx26AMvE2AUBRdSY0Fa9uP9XkuPwUp7DMbUvnqb42O5mweTeSRFpXESZq8rbyCTq96Z
 JVQ595pY=
X-Gm-Gg: ATEYQzy0RY1d0u3gRwQGTYldwgMG3ZPApFlavgRoiL3KDhgOoDLVugliCmmXAHM2RZ9
 Y7xbHioeiKWcRgcDuDDTpjtk7gILBBAvfCZmBoo3V9eTnWgADoctkBnWW0UUFCMyv7VANbooTQb
 j2lQVax160xAlsX/AIZD9cUPzyw35ZyY6YsTowqy6qzTJdyywKoYjN9rH2gSRHiVjIjFMwbfAFO
 GThm7DfX3jb5TE8BD5qz7nJzZW+8qpV/pnEIHeF34okm9WfwpAhJq9EPoqNzatkx+0vQLMaJ/ND
 e4XIziR4hWsPyAFQJ3y+xhc6gNYAGJzfLhpSLD75SGOMeinh0bwDfPn/Boi6L9M/d9FcZ1zfCG/
 Jeqi3onrZ5R4cMKR2zr+wScrlA0P8CfrhusAaeT4InAWcSZZ2pJslIAR04jSxIAZcdowJKJr8Ol
 gc9YYP4DfY4BxMqxwXYdZ4HW79YElxX5BLltf5pBRMioA=
X-Received: by 2002:a05:600c:8b31:b0:485:9a50:3369 with SMTP id
 5b1f17b1804b1-486fee304c4mr157980695e9.29.1774252074252; 
 Mon, 23 Mar 2026 00:47:54 -0700 (PDT)
Received: from localhost.localdomain ([37.160.201.221])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8ba4baesm512665195e9.13.2026.03.23.00.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 00:47:53 -0700 (PDT)
Message-ID: <69c0f029.050a0220.a284a.7ad8@mx.google.com>
To: Pavithra <pavrampu@linux.ibm.com>
In-Reply-To: <20260312055531.359885-1-pavrampu@linux.ibm.com>
Date: Mon, 23 Mar 2026 07:47:49 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [PATCH v5] Migrating the
 libhugetlbfs/testcases/truncate_above_4GB.c test
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
Cc: pavrampu@linux.ibm.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGF2aXRocmEsCgpUaGUgZm9sbG93aW5nIGlzIGp1c3QgYSBjb2Rpbmcgc3R5bGUvY29udmVu
dGlvbnMgcmV2aWV3LCBub3QgYSBsb2dpYwpyZXZpZXcuIEkgd2lsbCBsZWF2ZSB0aGF0IGZvciBw
ZW9wbGUgd2hvIHdvcmtlZCBvbiBodWdlIGZpbGVzLgoKLS0tLS0tLS0tCgpUaGUgc3ViamVjdCBs
aW5lIHNob3VsZCBmb2xsb3cgTFRQIGNvbnZlbnRpb25zOgoKICBodWdlbW1hcDogQWRkIHRlc3Qg
Zm9yIGh1Z2VwYWdlIHRydW5jYXRpb24gYWJvdmUgNEdCCgo+IENoYW5nZXMgaW4gdjU6Cj4gLSBN
b2RpZmllZCBjb2RlIHRvIHVzZSBGT1VSR0lHIGluc3RlYWQgb2YgdHJ1bmNhdGVfcG9pbnQuCgpT
YW1lIGlzc3VlIGFzIG5vdGVkIG9uIHlvdXIgcHJldmlvdXMgcGF0Y2g6IHRoZSBjb21taXQgYm9k
eSBzaG91bGQKZXhwbGFpbiAqd2h5KiB0aGUgdGVzdCBpcyBiZWluZyBhZGRlZCDigJQgd2hhdCBr
ZXJuZWwgYnVnIGl0IGd1YXJkcwphZ2FpbnN0LCB3aGF0IGl0IHZlcmlmaWVzLiBDaGFuZ2Vsb2cg
ZW50cmllcyBiZWxvbmcgYmVsb3cgdGhlIC0tLQpzZXBhcmF0b3IgaW4gdGhlIHBhdGNoIGVtYWls
LCBub3QgaW4gdGhlIGNvbW1pdCBib2R5LgoKPiArICpbRGVzY3JpcGl0b25dCgpNaXNzaW5nIHNw
YWNlIGFmdGVyICosICJEZXNjcmlwaXRvbiIgaXMgbWlzc3BlbGxlZCwgYW5kIFtEZXNjcmlwdGlv
bl0KaXMgYSBkZXByZWNhdGVkIGxhYmVsIGluIExUUCBkb2MgY29tbWVudHMuIERyb3AgdGhlIGxh
YmVsIGVudGlyZWx5IOKAlAp0aGUgZXhpc3RpbmcgZGVzY3JpcHRpb24gdGV4dCBiZWxvdyBpdCBp
cyBmaW5lIG9uIGl0cyBvd246CgogIC8qXAogICAqIEF0IG9uZSBzdGFnZSwgYSBtaXNjb252ZXJz
aW9uIG9mIGh1Z2V0bGJfdm10cnVuY2F0ZV9saXN0IHRvIGEKICAgKiAuLi4KCj4gK3N0YXRpYyB2
b2lkIHNpZ2J1c19oYW5kbGVyX2ZhaWwoaW50IHNpZ251bSwgc2lnaW5mb190ICpzaSwgdm9pZCAq
dWMpCj4gK3sKPiArCXNpZ2xvbmdqbXAoc2lnX2VzY2FwZSwgMTcpOwo+ICt9Cj4gKwo+ICtzdGF0
aWMgdm9pZCBzaWdidXNfaGFuZGxlcl9wYXNzKGludCBzaWdudW0sIHNpZ2luZm9fdCAqc2ksIHZv
aWQgKnVjKQoKQWxsIHRocmVlIHBhcmFtZXRlcnMgYXJlIHVudXNlZCBpbiBib3RoIGhhbmRsZXJz
LCBwcm9kdWNpbmcgYSBjb21waWxlcgp3YXJuaW5nIGZvciAndWMnLiBNYXJrIHRoZW0gd2l0aCBM
VFBfQVRUUklCVVRFX1VOVVNFRDoKCiAgc3RhdGljIHZvaWQgc2lnYnVzX2hhbmRsZXJfZmFpbChp
bnQgc2lnbnVtIExUUF9BVFRSSUJVVEVfVU5VU0VELAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2lnaW5mb190ICpzaSBMVFBfQVRUUklCVVRFX1VOVVNFRCwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKnVjIExUUF9BVFRSSUJVVEVfVU5VU0VEKQoKQXBw
bHkgdGhlIHNhbWUgdG8gc2lnYnVzX2hhbmRsZXJfcGFzcy4KCj4gKwlzdGF0aWMgbG9uZyBsb25n
IGJ1Z2d5X29mZnNldDsKPiArCS4uLgo+ICsJYnVnZ3lfb2Zmc2V0ID0gRk9VUkdJRyAvIChocGFn
ZV9zaXplIC8gcGFnZV9zaXplKTsKPiArCWJ1Z2d5X29mZnNldCA9IChsb25nIGxvbmcpUEFMSUdO
KGJ1Z2d5X29mZnNldCwgaHBhZ2Vfc2l6ZSk7CgpidWdneV9vZmZzZXQgaXMgcmVjb21wdXRlZCBm
cm9tIGdsb2JhbCBzdGF0aWNzLCBtYWtlIGl0IHB1YmxpYyBpbnN0ZWFkLgoKPiArY2xlYW51cDoK
PiArCVNBRkVfTVVOTUFQKHEsIDMqaHBhZ2Vfc2l6ZSk7Cj4gKwlTQUZFX01VTk1BUChwLCBocGFn
ZV9zaXplKTsKCnAgPT0gcSArIDIqaHBhZ2Vfc2l6ZSwgd2hpY2ggZmFsbHMgd2l0aGluIFtxLCBx
ICsgMypocGFnZV9zaXplKS4gVGhlCmZpcnN0IFNBRkVfTVVOTUFQIGFscmVhZHkgY292ZXJzIHAn
cyByZWdpb24sIHNvIHRoZSBzZWNvbmQgY2FsbCBpcyBhCnJlZHVuZGFudCBkb3VibGUtdW5tYXAu
CgpSZWdhcmRzLAotLQpBbmRyZWEgQ2VydmVzYXRvClNVU0UgUUUgQXV0b21hdGlvbiBFbmdpbmVl
ciBMaW51eAphbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
