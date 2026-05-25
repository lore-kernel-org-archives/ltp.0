Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A9CCD5BC8
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 10:08:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCCAF3E5293
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 12:08:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A97E3C5730
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:08:13 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 55F91140013E
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:08:13 +0200 (CEST)
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-512f09ecc67so65241041cf.3
 for <ltp@lists.linux.it>; Mon, 25 May 2026 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779703692; x=1780308492; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HV5eoUQwcQiKXM38GgnlmoDF8FlGRigGJd3POxhjy7o=;
 b=AU9T9k2fwmZy2v8B7Ps/7iXczMA2it/mrWp4WEr7WV4BptHjZDsrL2Ap1olROGXC35
 AfiSGfHel2wOMhzOMYWzNOKQwCfufJhxMdeROHWtcZHwMMj5FFJLuwHa9+tnMsjpZN90
 wbn+Ajzx572FZQy9lV/YsnqRQU0NgUHLwUEw1Qkq48h9yqcrbj5WwuiRpqmQ2+ySEXM1
 w+Mm12gKElDOzvoI8tvQbKaFVioVKXOIzrSlFzdsElkG4OwEhUeAkCClxvdN9xIL1hhT
 CG0RTuRV/E7TtBwNmfIi5qtnVdt8grpXbB61C14L4eprnbHZu7kW08H6C46N5353tnF8
 rHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779703692; x=1780308492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HV5eoUQwcQiKXM38GgnlmoDF8FlGRigGJd3POxhjy7o=;
 b=bE6hSW8o/eb38IKQsADr6xHy1r/H9ugVgseZYvTGzKnYrm6lyqTRVgP+IFuKycsQWt
 oI3EpHU54i1eRt9AFgYQ92p1yNfnzLolw7IUjayqQA84NANQdT8YF9PgJ5A9ONb0wtsJ
 F/nA5Z3ngHcR12v6/GyNQQrODUM3I8cjau6UgmyIX7meddsOP4RztOHpJtZ8BlfT5Ayz
 QD2Ihw7mYlWE7O6d7EkEYX93xm2DEXDWC7r/rCZeT3mvko1OzOHwkhhW2kVez94xl9uy
 Xz0ABmotpYfx7+nXDymKdwYf1BROj5gyq5sutn1s15lBgBEy2JedK7BQkKXwOd42fwHU
 YssQ==
X-Gm-Message-State: AOJu0YxyrH4A/P6H6H8qtpqFZn7Df8+CXVvUbr//5o/73wDsrerh8eLB
 q1WjUOqNZTXiCxVnzOlBZdOmyomE8hYFtZ2U1ZRqkSJMo3yrvLq0UvrgpJA9rd82arM=
X-Gm-Gg: Acq92OGheWIypeFtZj4x7C5CANFnl2NJmdo1WPFPZxuVNqparlmJvr8SUE5TBmHswaH
 CJsPfHwJboVKIsVr4aYOpk5D1JAFKm6D1v1abOzbxZVZKll3rnF5KO19ihifgXd/4+JDu2KbUGp
 t56MjKeQhhKpsWW+iImq3sjl7Sn5/6SnBQnQdSfCB9AXBprc5VobVGLY5k7fBgXVnJzee2zpb9Y
 QKS7YuGzsOi5BzMt2chtsb8oHcDzYvEBxjt+B5qFPcAqxHVu7rrOCu4VnXWRhPeE4oPTctVyXdC
 NMd08tgZHxdFEaHFCfOQTjFU8Xs9dpaXXDP91PZWN4+mrSoyWdv2ha5axmmyYUYunQPD86O/hfo
 9bmZT1t6+1XiIS16Zcbz207utmyUDQMUhLV32MsW+PV4OmIAaFYQ0I8oIzD6z47fc4id0Vym4YM
 Vkv86D/Rk+r+0+C5cdb4znm0kNB98zItUnf9V3HuTdTCisIXfDIHeV7Z5tXrjo9mXAzz9z4fhPw
 vMYv16sJMG96yKoJA9tsRsy/mJ+TN9yoILzPxV+
X-Received: by 2002:a05:622a:8588:b0:50d:97e8:939b with SMTP id
 d75a77b69052e-516d436b32dmr148894101cf.36.1779703691960; 
 Mon, 25 May 2026 03:08:11 -0700 (PDT)
Received: from
 runnervmg397c.jtyotg1xir1uzgkp5buz1jakqf.bx.internal.cloudapp.net
 ([52.186.174.179]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516d8b0012bsm92694691cf.4.2026.05.25.03.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 03:08:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 May 2026 10:08:10 +0000
Message-ID: <20260525100811.3803-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525073921.172426-1-pvorel@suse.cz>
References: <20260525073921.172426-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] min_free_kbytes: TCONF on errno ENOMEM, add break
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

SGkgUGV0ciwKCk9uIE1vbiwgMjUgTWF5IDIwMjYgMDk6Mzk6MjEgKzAyMDAsIFBldHIgVm9yZWwg
d3JvdGU6Cj4gbWluX2ZyZWVfa2J5dGVzOiBUQ09ORiBvbiBlcnJubyBFTk9NRU0sIGFkZCBicmVh
awo+Cj4gT24gbWFjaGluZSB3aXRoIDE2IEdNIFJBTSBhbmQgfjYgR0Igc3dhcCBmb3JrKCkgZmFp
bHMgb24gRU5PTUVNLgoKVHlwbzogIkdNIiDihpIgIkdCIi4KCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgImZvcmsiKTsKPiArICAgICAgICAgICAgICAg
ICAgICAgICB0c3RfYnJrKChlcnJubyA9PSBFTk9NRU0gPyBUQ09ORiA6IFRCUk9LKSB8IFRFUlJO
TywgImZvcmsiKTsKPiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKClRoZSBUQ09ORiBo
YW5kbGluZyBpcyBjb3JyZWN0LiBOb3RlIHRoYXQgYHRzdF9icmsoKWAgaXMgYF9fYXR0cmlidXRl
X18oKG5vcmV0dXJuKSlgLCBzbyB0aGUgYGJyZWFrYCBpcyB1bnJlYWNoYWJsZS4gSXQncyBzdGls
bCBmaW5lIHRvIGFkZCBmb3Igc3RhdGljLWFuYWx5c2lzIHRvb2xzIGFuZCByZWFkYWJpbGl0eSwg
YnV0IHRoZSBjb21taXQgbWVzc2FnZSBjYWxsaW5nIGl0IGEgIm1pc3NpbmciIGJyZWFrIGlzIGEg
c3RyZXRjaCDigJQgaXQgd2FzIG5ldmVyIGZ1bmN0aW9uYWxseSBhYnNlbnQuCgpbLi4uXQoKLS0t
Ck5vdGU6CgpPdXIgYWdlbnQgY29tcGxldGVkIHRoZSByZXZpZXcgb2YgdGhlIHBhdGNoLiBUaGUg
ZnVsbCByZXZpZXcgY2FuIGJlCmZvdW5kIGF0OiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVz
dC1wcm9qZWN0L2x0cC9hY3Rpb25zCgpUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcyBwcm9kdWNlIGZh
bHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMKZmluZGluZ3MgYXJlIGdlbnVpbmUuIElm
IHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQpjb21tZW50IHRoaXMgZW1h
aWwgb3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMsCkxUUCBBSSBSZXZpZXdlcgoK
LS0tCgoqKlZlcmRpY3Q6IE5lZWRzIHJldmlzaW9uKiog4oCUIGZpeCB0aGUgIkdNIiDihpIgIkdC
IiB0eXBvIGluIHRoZSBjb21taXQgYm9keS4gVGhlIGNvZGUgY2hhbmdlIGl0c2VsZiBpcyBjb3Jy
ZWN0LgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
