Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7CCC77B7F
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 11:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750678969; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ZCPytoi8/bNhPq0OaK+yBdhqckKKVWIs5AWWOWQWuY4=;
 b=YXyunS0KA8ROrucgZMOKG1j+vJvBV8cbxZoT0yExhx7njT4mImW77xzxH0Zp8NzrncZ1t
 jdnvmFfXhfou/tj/xo3uY9uJAld3Tle9j44ftUfbRfQCwLCxLu4NbIYYuEvw8WuVyHrboKI
 ZTL+OIpaMBpHCM4CP1Ph4OXkGRD5rm4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FBFD3CC2BA
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 13:42:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60A363C0939
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 13:42:27 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C962F200073
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 13:42:26 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so1707504f8f.3
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 04:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750678946; x=1751283746; darn=lists.linux.it;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPlWmqzuvO954t8lkGufkiV3vBIS2JmMFdeihOhkbKc=;
 b=MDILdvQDV3GYIWOw+8GsXjbdLJO0mNcaQeVZ6naN+veG42uDbGlCj4sAt/YiED7FLV
 iA2FSX+U3kg049ohXRjVX2EeH9rNzleHjJ+dRJ98Mo2cIP0gEBrLJl4kB596wzT7SvYq
 E3c4qjtmto3XfU1z/0JbeIMeMCBlha+40vkByJvgZxT6QnssNnPQkUJiHlqddjMYHsPf
 fmR2Cl51D09hrBFT1jUZjgGGEATyEeRKH4WTtm9aFL/mGmR+zh3AxNDHxcbqcs6IWBjZ
 lnXEOmvHiSxQ0p8AnPs3VLoaEJXvdd0Ft5jiESmuiF9OwH+xeECV5ngfEzIsH5xKm4Lc
 yxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750678946; x=1751283746;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MPlWmqzuvO954t8lkGufkiV3vBIS2JmMFdeihOhkbKc=;
 b=VIlVKJ5FKcZEnDjVqyOrEJZf1xaMaez3oGiPwbBy7DIobo0TPd9dRqFwbqwkS8G/v1
 aRHjovgOZNl1ONFEATX9I/2w4WKjOPMq1kDEMN6u6Kk+yZTbAIvajqYn0OOv442i2d9I
 L9U5ZGzqXJZonnOgqmWTBVypEoarbMJw43UbTILWM/Rozq6pSMghufHXjle066ZkouWW
 0DUctaEahVV8SIOOv/WbGoWULf6h5nm1HKWFUosONBlE2Sd+69wPEBY/1IsBsv1NaIxE
 5Ew2c+5WoLmUMQgpvfBbJhTyvt8OMKnypMzNKbVmIyMcNPe+eLMvTb0ZH35Oq+cdjlEe
 fSWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ0/TnVUo3rMb3lui73EBrleZKMnZr/V/RcBXCJlN1wYbYKaXsFRz9ks84WFSv1NhN15s=@lists.linux.it
X-Gm-Message-State: AOJu0Yy/Y50/u2Po648/cIA2SVSuVFJa9SUmzhV60p7KrbpurxlnGEF9
 EWDkiA/KFoVQg72tqCUcaj+tfxO+H6hyW5CrhxXakMKKvquuOowxNLADO5IbQZWq5sxa9FvTCU2
 l6MPL
X-Gm-Gg: ASbGncuHDx8S15JLHYfZcTS4bHbCM5GvgHYVpECobaWwk74CxxzP9kSIljfYH4DFfBw
 BQOz6zWDXHFKazVqTZutZba+7T3ex43Xevueoc+vJFoqqzfktlUWdU5b32ARvwz1uNW6x4iKlfg
 2uHeiJGQ812pOtiBgPEvFv7FMPhsNiogxMT0WjbVicbtHCAarRWTAnZEGYaGKlfW/Z59T0LGK7X
 OvF3wS0JkheCRPYOMNvnz8SBoZ/DnNTqOxcbUsviJBaP8g4Fphl8tGi92HvLgmzo+FD7YwshSvD
 DyzPsrWDMdnvXnJKBc1lPzgNDutmB3OlWR91tjq+VBD5MGFQuA==
X-Google-Smtp-Source: AGHT+IG16z1/7Xj93pZy+HPmHO+ircnk/v9xWhoMFNDKTs935CDeHubZq5ND7bjBqF5PJje5TnPq+Q==
X-Received: by 2002:a05:6000:22c1:b0:3a4:de02:208 with SMTP id
 ffacd0b85a97d-3a6d12e5a26mr10591099f8f.25.1750678946185; 
 Mon, 23 Jun 2025 04:42:26 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-237d86ef88bsm82868285ad.219.2025.06.23.04.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 04:42:25 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 23 Jun 2025 08:42:20 -0300
Message-Id: <DATVW2FPAGKH.1RHSUJU61FFIW@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Linux Test
 Project" <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250620-conversions-shmt-v2-1-56cae20e184f@suse.com>
 <bc5821ea-f5bf-4366-bdfc-23817098eed1@suse.com>
In-Reply-To: <bc5821ea-f5bf-4366-bdfc-23817098eed1@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mem: Convert shmt02 to new API
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uIEp1biAyMywgMjAyNSBhdCA0OjUxIEFNIC0wMywgQW5kcmVhIENlcnZlc2F0byB3cm90
ZToKPiBIaSEKPgo+IE9uIDYvMjAvMjUgMTE6NDEgQU0sIFJpY2FyZG8gQi4gTWFybGnDqHJlIHZp
YSBsdHAgd3JvdGU6Cj4+IC0Ja2V5ID0gKGtleV90KSBnZXRwaWQoKTsKPj4gLQo+PiAtLyotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tKi8KPj4gLQo+PiAtCWlmICgoc2htaWQgPSBzaG1nZXQoa2V5LCAxNiAqIEtfMSwgSVBDX0NS
RUFUIHwgMDY2NikpIDwgMCkgewo+PiAtCQlwZXJyb3IoInNobWdldCIpOwo+PiAtCQl0c3RfYnJr
bShURkFJTCwgTlVMTCwKPj4gLQkJCSAic2htZ2V0IEZhaWxlZDogc2htaWQgPSAlZCwgZXJybm8g
PSAlZCIsCj4+IC0JCQkgc2htaWQsIGVycm5vKTsKPj4gLQl9Cj4+IC0KPj4gLQl0c3RfcmVzbShU
UEFTUywgInNobWdldCIpOwo+PiArCWtleSA9IChrZXlfdClnZXRwaWQoKTsKPj4gICAKPj4gLS8q
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLSovCj4+ICsJc2htaWQgPSBTQUZFX1NITUdFVChrZXksIFNITVNJWkUsIElQQ19DUkVB
VCB8IDA2NjYpOwo+Cj4gT25lIGxhc3QgdGhpbmcgSSBmb3Jnb3QgaW4gdGhlIHBhc3QgdjEgcmV2
aWV3OiBpdCdzIGJldHRlciB0byB1c2UgCj4gR0VUSVBDS0VZKCkgbWV0aG9kIGluc3RlYWQuIEFm
dGVyIHRoaXM6Cj4KPiBSZXZpZXdlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZl
c2F0b0BzdXNlLmNvbT4KCkFkZGVkLCB0aGFua3MgZm9yIHJldmlld2luZyEgSSdsbCBrZWVwIGEg
bm90ZSBmb3IgdGhlIHNobXQwNCByZXdyaXRlLgoKPgo+IC0gQW5kcmVhCgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
