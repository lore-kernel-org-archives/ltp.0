Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0886ECD343F
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 18:32:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBF553E6A70
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 20:32:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 060DA3CAD2E
 for <ltp@lists.linux.it>; Thu,  7 May 2026 20:32:33 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AC7BB60048D
 for <ltp@lists.linux.it>; Thu,  7 May 2026 20:32:32 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2f0d3e07e30so3047261eec.0
 for <ltp@lists.linux.it>; Thu, 07 May 2026 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778178751; x=1778783551; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kGN5XxGAztbWKpFhmrvsjuuC0FURguLCGr+iBms6jDg=;
 b=l0Qiqo0EH2pI7eMSQWAYqoEzQ7taLJCekFYds5TOSOyg/mJ0jgm0gsV1yqW76/ujay
 /ZZw3DoWqKmc/6dTMX6GOIMl7eoxIueG4I7gfsaGGm4Nd3CPrFJLQoQo2FXKINLoKeJ3
 KXdNA//WRArukP/hjc/Mxw7DJlUlYa6M3zTigWSmYWBKt8/r1EL0ppqd8T4AMwJP2Uae
 i5LH1OMiAWy+4lRZFTB5gGLBwfIafwOO/3rjBiRuBKMvTZODv8X4dSe1K94DSn5zZrI2
 a5UDiHFjOjlJvx6GadiZaC/bv8XEJ5cY+cb9NshsAUr6oTdezpQaVj4NQBFzAF5Auh/P
 mEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778178751; x=1778783551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kGN5XxGAztbWKpFhmrvsjuuC0FURguLCGr+iBms6jDg=;
 b=XKerqHRKT6KBl2o6d6sVUsHU+x5vtvFE84+M4z2H6+JCfBUzG4QnhYbYM3q5kJXlAo
 6zQzrxPJVm7FCbS6ts1ieXIAAccSDMyxC9PJsOvlY7gKvzDifYsi47AAPtSDGKxp6qFj
 jRz56v40uGePTMZve3o7jsLnCEiuAU+GdszQsvyOi2vRMFNW25VMvcwp9wxjDAV+7Dag
 tWn0hOw8fv2ReIiJNwGywzlKZGeG4exvZ7UZJC/eT5vKMkRFdZ8pDPO8QmNSZ88xgYJ0
 I2TIDJxFfyaouHYbQu+/d6fQGTf30ex1Ok9Zc2cKh6GXCdYGp5eLEgTevEZeVJ7y1zDa
 /EHg==
X-Gm-Message-State: AOJu0Yynuld1GPk1GvlC+UCzs+pqdfoBJ/7tkKrFIE/Cs3STaDa6x8wk
 nrhkEylvk6VLG/o8laoWAnChPGjOeumt3tBEOp1INx5s573MH2HF6KC/
X-Gm-Gg: Acq92OFr7Kta6X21ApJVxaWgnksq8Yc5DwsCRKT90PAULJVeC/xX83za5K5H/G2tnly
 Bz4jbY9omXNBJKZ4yapHdrZWPySAy3fF5pd5tzaekEIJa2YlcRg1rsQwqJvRaeOO+sitwyNbR6C
 rPnccPdlEEaDQqPKenjf1geVM8QACrNZajLu6n/Mhfb521pRNJFPZQqf2qNGUxNsbbiMEPU3jKl
 8kawZab1CFh1JRNFlBx7JgwrYCobytbz3Hab16Xe9DmOxDeyLm4pS3T7w/ZnrfZ+VxxdnbsESTp
 VkGXl9r6gtCgJN4hclACKhtml6hVK+gOdGCL65/zZ30OStGWX0Gm0GzWbTpz05YQ7Q0Kb9Niz8m
 l2mM1Bg2c22kHS3pAq5B2+IYaifzjW8reONuSLevCGlpGJUkhSmRa/G8SPFdtJ/a/c++jaCasFI
 VcQaqwDgt3f0Fw0JQPUVjBcmkrncqLG5bJo/+dgSkhAaOsxl1igFWbPMHVLTEVMQSRe+oM0LfR+
 XsVcYbwKs63Qa1AMFTulNk2OY82Qe96eWNVdd9T6e6yCLyoVio0
X-Received: by 2002:a05:7300:434b:b0:2f1:496c:94bf with SMTP id
 5a478bee46e88-2f54ac74875mr4149111eec.16.1778178750755; 
 Thu, 07 May 2026 11:32:30 -0700 (PDT)
Received: from
 runnervmeorf1.1dshg3pmcm0u5kp2on5g3fpz3a.dx.internal.cloudapp.net
 ([172.184.209.181]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f82eba9f4dsm114343eec.15.2026.05.07.11.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 11:32:30 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Ricardo Branco <rbranco@suse.de>
Date: Thu,  7 May 2026 18:32:27 +0000
Message-ID: <20260507183227.4098-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507181045.19489-1-rbranco@suse.de>
References: <20260507181045.19489-1-rbranco@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memfd_create: move sys_memfd_create() to lapi/memfd.h
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

SGkgUmljYXJkbywKCi0tLSBbUEFUQ0ggMS8yXSAtLS0KCk9uIDIwMjYtMDUtMDcsIFJpY2FyZG8g
QnJhbmNvIHdyb3RlOgo+IG1lbWZkX2NyZWF0ZTogbW92ZSBzeXNfbWVtZmRfY3JlYXRlKCkgdG8g
bGFwaS9tZW1mZC5oCj4KPiBBZGQgdGhlIHN0YXRpYyBpbmxpbmUgd3JhcHBlciB0byBpbmNsdWRl
L2xhcGkvbWVtZmQuaCBhbmQgaW5jbHVkZSB0aGUKPiByZXF1aXJlZCBoZWFkZXJzIHNvIG90aGVy
IHRlc3RzIGNhbiByZXVzZSBpdC4KPgo+IEFsc28gZml4IHNvbWUgbWlub3IgaXNzdWVzIGRldGVj
dGVkIGJ5IG1ha2UgY2hlY2suCgpUaGUgImFsc28gZml4IiBpbmRpY2F0ZXMgYSBzZWNvbmQgbG9n
aWNhbCBjaGFuZ2UgYnVuZGxlZCBpbi4gUGxlYXNlIHNwbGl0CnRoZSBtaW5vciBjbGVhbnVwIGZp
eGVzIChibGFuayBsaW5lIGluIG1lbWZkX2NyZWF0ZTAxLmMsIHRyYWlsaW5nIHNlbWljb2xvbgpp
biBDSEVDS19NRkRfSEFTX1NFQUxTKSBpbnRvIGEgc2VwYXJhdGUgY29tbWl0IHNvIGVhY2ggcGF0
Y2ggY29udGFpbnMKZXhhY3RseSBvbmUgbG9naWNhbCBjaGFuZ2UuCgo+IC0JY2hlY2tfbWZkX2hh
c19zZWFscyhfX0ZJTEVfXywgX19MSU5FX18sIChmZCksIChzZWFscykpOwo+ICsJY2hlY2tfbWZk
X2hhc19zZWFscyhfX0ZJTEVfXywgX19MSU5FX18sIChmZCksIChzZWFscykpCgpUaGlzIGZpeCBp
cyBpbmRlcGVuZGVudCBvZiB0aGUgc3lzX21lbWZkX2NyZWF0ZSgpIG1vdmUg4oCUIHNlcGFyYXRl
IGNvbW1pdC4KClByZS1leGlzdGluZyBpc3N1ZXMgbm90aWNlZCBpbiB0aGUgc3Vycm91bmRpbmcg
Y29kZSAobm90IGludHJvZHVjZWQKYnkgdGhpcyBwYXRjaCk6CgotIGluY2x1ZGUvbGFwaS9tZW1m
ZC5oIChwcmUtcGF0Y2gpIOKAlCBmaWxlIHJlbGllZCBvbiBjYWxsZXJzIHRvIHB1bGwgaW4KICB0
c3RfdGVzdC5oIGFuZCBsYXBpL3N5c2NhbGxzLmggdHJhbnNpdGl2ZWx5OyBub3cgY29ycmVjdGx5
IHNlbGYtY29udGFpbmVkLgoKLS0tCk5vdGU6CgpPdXIgYWdlbnQgY29tcGxldGVkIHRoZSByZXZp
ZXcgb2YgdGhlIHBhdGNoLiBUaGUgZnVsbCByZXZpZXcgY2FuIGJlCmZvdW5kIGF0OiBodHRwczov
L2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC1hZ2VudC9hY3Rpb25zL3J1bnMvMjU1
MTQyNjk4OTEKClRoZSBhZ2VudCBjYW4gc29tZXRpbWVzIHByb2R1Y2UgZmFsc2UgcG9zaXRpdmVz
IGFsdGhvdWdoIG9mdGVuIGl0cwpmaW5kaW5ncyBhcmUgZ2VudWluZS4gSWYgeW91IGZpbmQgaXNz
dWVzIHdpdGggdGhlIHJldmlldywgcGxlYXNlCmNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25vcmUg
dGhlIHN1Z2dlc3Rpb25zLgoKUmVnYXJkcywKTFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
