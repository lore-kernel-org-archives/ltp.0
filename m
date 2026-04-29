Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E4DCCFA13
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 15:20:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C85993E49D0
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 17:20:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AB473C66CA
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 17:20:09 +0200 (CEST)
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com
 [IPv6:2607:f8b0:4864:20::942])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3BFC41A00933
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 17:20:08 +0200 (CEST)
Received: by mail-ua1-x942.google.com with SMTP id
 a1e0cc1a2514c-94ac8cbf3feso7820507241.0
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777476006; x=1778080806; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZbBEEWtPLAojeh6ugLQSr+C+lNBdryV21kEmWZa5bB4=;
 b=mxE92Vlfr++moMweiDtMHrrkKia2nVtC0riupt6ajqESV2A+cvd0KoAoZQ8z38NzQQ
 XxKz4aknFw8PMaKFElpR+wLAdSSgwgs6as9SPJRVZsJE5Oi3XakDjsZsrem+Dfra4eUD
 pBdWKP5VhxX7pwDwScdQxmn64kqmpf7WZtM+1qBEmLYgNOwgcKZIOTr8FNvdhbbYgi92
 ZY4ERBxBaAJO3m+08Jzw1qYA/fnWBuZMQ28ZKvAZNpTjADgeXTHJOA2vAOCWpo0gQ2rp
 MV+i3Lfeh5MJmjNSxQttcKHqFcVelSUe3joaqxAovLWy3hgsUiGQ1Pl9BG9DD2VKCfeo
 oKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777476006; x=1778080806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZbBEEWtPLAojeh6ugLQSr+C+lNBdryV21kEmWZa5bB4=;
 b=YiZG4rsKy+Xcdn3gPLH/W/M9xIWIsLQFPGiwxm9/L0mLia9Wvh+HzdpR+yOM+hbx/J
 Sq48vqvCiFdFdBHnNvIwjrxCCUvhmiB+MZJiTWSx8kLZwtDzVmo3K9PKVdV0EtNX5nT5
 ptxF/2qTiQf7+wGnjFhsBJZ0hlx9NNHaVHAfD94ETPj5/dNr4hKpl0sOB/CZ/pzX/iOU
 6WeOMyW2YILLudEnfBmLRmzA1RqBW+LLWL+2hKeWtBvi82jnMIlVRSu5nxg8DXnwT8Mt
 Nx8UnRNaPN1nhDIgd8DSmpQEv2r9fUiVgPfpJmr1yL/MWgHw3gWj57ypo3yulUOvQf/c
 Mu2w==
X-Gm-Message-State: AOJu0YwAmgdmx+vLdTj8bRHaB7uD7QtiUuoH4s41oohnIWPfDmA1Um1C
 uHIrYBu4ppVv0GT533yY0jS+nIGYprroR5y1qes6sEAtSO0XopB55yiS
X-Gm-Gg: AeBDieu/ugV9xRv47USvbh29ZejZlhd49Me/HErTbfeMfsTVQEld4LvwzSaok44q+38
 pf56ES8yTRBqBOUvTNY0pRi8t0MgyHsMOfWBUNMLs2UGFtDZwpd/cHihCSkV65ckNWdciftna24
 ivO70VvR8DoMTm3a9DQ/BCiQid4sNEJ8PEsEz34+CJVWtIADcUDnQ9PUD1X06Dh3S0FVriF/Bzy
 LpYJjvkBdphQo3w0eimd4mSLo3PqpTH9yWld6FROhlr5P14YaiudLbhJ27/O3ELuS/hYg8kFE+V
 2Sod5RZzPFl16On/SMTJVAU0Sy+Q3dnBkprZ3GiE22eEUE6wtcBq8NRsH2MlWgkauY1nZdeSLW4
 SU1lB4r54rO+DadFBFP8/mxBtkL6xtsFDrnCnQVwPQW5kClRrZllS7n5+Nihy3qFqOBNZk1CcDV
 RaNA2WbfqS6FMwW5latzNfxnLsEcM/8dL8XBQqmhisdzwSqIrw4Ly+Snpp1B32wREgFMjsMgtol
 kC/N1BV/KWCQ1sIe7U5QlxQkQEXOjBz27z7IBF4EBHNgusJSE8G
X-Received: by 2002:a05:6102:6b01:b0:605:6089:674a with SMTP id
 ada2fe7eead31-629272e90b8mr2781194137.23.1777476006475; 
 Wed, 29 Apr 2026 08:20:06 -0700 (PDT)
Received: from
 runnervmeorf1.h3kajnb5sjwe3pjjo5i2acy55g.cx.internal.cloudapp.net
 ([135.119.238.193]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ef71b89fsm21162796d6.21.2026.04.29.08.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:20:06 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 29 Apr 2026 15:20:05 +0000
Message-ID: <20260429152005.3985-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429145314.79256-1-mdoucha@suse.cz>
References: <20260429145314.79256-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] aio_cancel: Fix incorrect strerror() usage
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

SGkgTWFydGluLAoKLS0tIFtQQVRDSCAyLzJdIC0tLQoKT24gV2VkLCAyOSBBcHIgMjAyNiAxNjo1
MzoxMiArMDIwMCwgTWFydGluIERvdWNoYSB3cm90ZToKPiBhaW9fY2FuY2VsXzYtMTogUmV3cml0
ZSB0ZXN0Cj4KPiBUaGUgdGVzdCBzY2hlZHVsZXMgbXVsdGlwbGUgYXN5bmMgd3JpdGVzIGludG8g
YSBmaWxlIGFuZCB0aGVuIGhvcGVzIHRoYXQKPiBhdCBsZWFzdCBvbmUgd2lsbCBibG9jayBsb25n
IGVub3VnaCB0aGF0IGFpb19jYW5jZWwoKSB3aWxsIGNhbmNlbCBpdC4KPiBbLi4uXQo+IFRoaXMg
Zml4ZXMgYSByYWNlIGNvbmRpdGlvbiB3aGVyZSBhaW9fY2FuY2VsKCkgY291bGQgYmUgY2FsbGVk
IGFmdGVyIHRoZQo+IHRhcmdldCB3cml0ZSBoYXMgYWxyZWFkeSBmaW5pc2hlZC4gWy4uLl0KPgo+
IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFAc3VzZS5jej4KClRoZSBjb21t
aXQgYm9keSBzYXlzIHRoaXMgZml4ZXMgYSByYWNlIGNvbmRpdGlvbiwgc28gYSBGaXhlczogdGFn
IGlzCnJlcXVpcmVkLiBQYXRjaCAxLzIgaW4gdGhpcyBzYW1lIHNlcmllcyBjb3JyZWN0bHkgdXNl
cyBGaXhlczogdGFncyBmb3IKYW5hbG9nb3VzIHJld3JpdGUtYXMtYnVnZml4IGNvbW1pdHMgdG8g
NS0xLmMgYW5kIDctMS5jLiBQbGVhc2UgYWRkIGEKRml4ZXM6IHJlZmVyZW5jaW5nIHRoZSBjb21t
aXQgdGhhdCBpbnRyb2R1Y2VkIHRoZSBvcmlnaW5hbCA2LTEuYy4KClByZS1leGlzdGluZyBpc3N1
ZXMgbm90aWNlZCBpbiB0aGUgc3Vycm91bmRpbmcgY29kZSAobm90IGludHJvZHVjZWQKYnkgdGhp
cyBwYXRjaCk6CgotIGFpb19jYW5jZWwvNS0xLmMg4oCUIFVzZXMgbmFub3NsZWVwKCkgaW4gYSBz
cGluLXdhaXQgbG9vcCBmb3IKICBzeW5jaHJvbml6YXRpb24uCgotLS0KTm90ZToKCk91ciBhZ2Vu
dCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guIFRoZSBmdWxsIHJldmlldyBjYW4g
YmUKZm91bmQgYXQ6IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9sdHAvbGlz
dC8/c2VyaWVzPTUwMjA4OAoKVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBw
b3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3Ug
ZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVtYWlsIG9y
IGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
