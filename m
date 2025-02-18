Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D70C02198
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 12:37:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C28163C9C92
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 13:37:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F25233C9C5A
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:37:14 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F06F1101E92C
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:37:13 +0100 (CET)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22100006bc8so54196485ad.0
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 04:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739882232; x=1740487032;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:dkim-signature:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vfqbn4Xbd+NVwfnB9oeyHbfyBdqCg25DpO/A8nuakYY=;
 b=A/gSgbr0Xwp9SAhIxinnlnLc4IVWS5psXvSmmNlEDlNcQUymwL4mnnCh006U72Hc5M
 iJ5IPQG6BoUJRYbWXa06gVCLFDTFI5jLlzb5J424dfIHKS/i2tBt0vgqCV3NxHgLaBTy
 Ql54dBxMvnn6S5cqjj9upe7boGdrlJ4er9qoe6jZnXoT7cDa0oDgCZ2SmP1vnAgorhJ0
 4h2S53j5jRTw1I6L2omVSWAA/GrMC40Z8/foujYzGADNMRiWPO8LyOzeT3WR/xG1pl9H
 1mqu9P+i5hHzvkGI2zlsz8u01jFYjOjtbnvkjLjYoZcbLDYQPnScXm0UwooXlvsBt8vT
 c28A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmiUCYJkDu9yvKiLxRCl880lPdMzRPfOntwASZFZTli+ZkBEvDTKrM49BT+Pd+hhtvuUk=@lists.linux.it
X-Gm-Message-State: AOJu0Yx10mv95Ikzo5n8SmkTQD25qgwYlEM86K6rBP8W+KV/UZypAuw0
 GBMxCO9AXVrV9ZN9NDdfCW/hzmL8233Np1nyQPuQXKMZ6tcphvOgkMh/ggWp
X-Gm-Gg: ASbGncvRZZdkdRH+43zHzC6pXa14c9MnT+gFsS7wlpWRgbiVDNrfLryGkZXdnOVG203
 zEh/kqZ96rZIBAgiw0HML8dht6br9P3ArmJR38fKMUCFySYy0vc7hhFqnnhn7QrjIHPKDJZ9vga
 68DrUvINhMwLhkdMb9erfD6PK21vgdaMPIHlaw0GabKnVsF4F/WksUJ+FYxMPfJf4+s5H3teKUJ
 77nDSv/poIwkXUIkWs5bSwDwjQknq23ejImmTv1g0Wfa8dOgAt+j0VTuHaAWOemVRxm5loNROPm
 jLpAQ11tMPzMRQG/nLp4toGvJsyVAtR4
X-Google-Smtp-Source: AGHT+IFnrbsKCrfqgOksp64Id6y3liOcQVjLSq+ZN2nLmqBQxS9Njc+8IKYvL063YvsPRbFjaQbtkQ==
X-Received: by 2002:a17:903:1c5:b0:21f:8099:72e4 with SMTP id
 d9443c01a7336-2210406aee5mr248791965ad.28.1739882231866; 
 Tue, 18 Feb 2025 04:37:11 -0800 (PST)
Received: from mail.marliere.net (marliere.net. [24.199.118.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d559088esm87093125ad.242.2025.02.18.04.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 04:37:11 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
 s=2025; t=1739882229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vfqbn4Xbd+NVwfnB9oeyHbfyBdqCg25DpO/A8nuakYY=;
 b=AcVxfja1Gmk53B2VY2z/WnWMiRFv11IZQWqtDcCFXswgnP1S6uXfsUa4fyuLEBjdEAy2gM
 H7zpQbo3TCaDRKvOhgZINtv1IDpWeE5YXlY6uQ1QkNMtGRf9F/T3NoRb032Nos9Ix5LI4u
 iePw+kzOP9fZ/fjvNpxrk2FN7kQbdhZAnoJHaSe7Qp9PlKgiNd8eS+jqExmACdeb8pE/27
 7/Zunrt3Bq3iicregi0+1XVn7+dk8fjtjM72LBs7pGFwntfsa6fagfQAS01hzpnlLt79KU
 q6gL4eFvAoYxTurPZQRhEkR/F7fERAVG7Ke1d5x8uODgY6CG6xqOx2V/xu1FoQ==
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Mime-Version: 1.0
Date: Tue, 18 Feb 2025 09:37:06 -0300
Message-Id: <D7VKRWFCN3KC.3BDC9ZUIWELUB@marliere.net>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>, "Linux Test Project"
 <ltp@lists.linux.it>
References: <20250217-conversions-pause-v1-0-be8be41cb154@marliere.net>
 <20250217-conversions-pause-v1-2-be8be41cb154@marliere.net>
 <4af38d4e-37b2-4730-824a-af137e95ff23@suse.com>
In-Reply-To: <4af38d4e-37b2-4730-824a-af137e95ff23@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/pause03: Refactor into new API
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhIQoKVGhhbmtzIGZvciB0aGUgcmV2aWV3LCBJJ2xsIHNlbmQgYSB2MiBhZGRyZXNz
aW5nIHlvdXIgcG9pbnRzIGxhdGVyLgoKT24gVHVlIEZlYiAxOCwgMjAyNSBhdCA5OjI2IEFNIC0w
MywgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPiBIaSEKPgo+IE9uIDIvMTcvMjUgMjM6MDEsIFJp
Y2FyZG8gQi4gTWFybGnDqHJlIHdyb3RlOgo+PiBTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1h
cmxpw6hyZSA8cmljYXJkb0BtYXJsaWVyZS5uZXQ+Cj4+IC0tLQo+PiAgIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvcGF1c2UvcGF1c2UwMy5jIHwgMTE0ICsrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA4OSBkZWxldGlv
bnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcGF1c2Uv
cGF1c2UwMy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wYXVzZS9wYXVzZTAzLmMKPj4g
aW5kZXggNDU5MjIyMDQ1YzA4ZGMxZmM0ODA0ZWZkMmVjZTAyMzE2ZmU1NWEwZS4uNjQxNjEwYTc4
MjkwZGUxZjI1YzFmODM4OGM3ZWM1MDIzZGQwMDE4MCAxMDA2NDQKPj4gLS0tIGEvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9wYXVzZS9wYXVzZTAzLmMKPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9wYXVzZS9wYXVzZTAzLmMKPj4gQEAgLTEsMTA0ICsxLDQwIEBACj4+ICsvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgo+PiAgIC8qCj4+ICAgICog
Q29weXJpZ2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzICBDb3JwLiwgMjAw
MQo+PiAtICogIDA3LzIwMDEgUG9ydGVkIGJ5IFdheW5lIEJveWVyCj4+IC0gKgo+PiAtICogVGhp
cyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7ICB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQv
b3IgbW9kaWZ5Cj4+IC0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQo+PiAtICogdGhlIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKPj4gLSAqIChhdCB5
b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCj4+IC0gKgo+PiAtICogVGhpcyBwcm9ncmFt
IGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCj4+IC0g
KiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7ICB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2Fy
cmFudHkgb2YKPj4gLSAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VM
QVIgUFVSUE9TRS4gIFNlZQo+PiAtICogdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZv
ciBtb3JlIGRldGFpbHMuCj4+IC0gKgo+PiAtICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEg
Y29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKPj4gLSAqIGFsb25nIHdpdGgg
dGhpcyBwcm9ncmFtOyAgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0
aW9uLAo+PiAtICogSW5jLiwgNTEgRnJhbmtsaW4gU3RyZWV0LCBGaWZ0aCBGbG9vciwgQm9zdG9u
LCBNQSAwMjExMC0xMzAxIFVTQQo+PiArICogQ29weXJpZ2h0IChjKSBMaW51eCBUZXN0IFByb2pl
Y3QsIDIwMjUKPj4gKyAqIDA3LzIwMDEgUG9ydGVkIGJ5IFdheW5lIEJveWVyCj4gSGVyZSB3ZSBh
cmUgbWlzc2luZyB0aGUgIkNvcHlyaWdodCAoYykgSW50ZXJuYXRpb25hbCBCdXNpbmVzcyBNYWNo
aW5lc8KgIAo+IENvcnAuLCAyMDAxIiBjb3B5cmlnaHQgc3RyaW5nIGJlZm9yZSBjcmVkaXQuIEFs
c28sIHRoZSAiUG9ydGVkIiBtZXNzYWdlIAo+IHNob3VsZCBiZSBhbGlnbmVkIHRvIHRoZSBjb3B5
cmlnaHQgd2l0aCBhIHRhYi4gWW91IGNhbiBhZGQgeW91ciBvd24gCj4gY3JlZGl0IGFzIHdlbGwg
bGlrZSBpbiB0aGUgcHJldmlvdXMgcGF0Y2guCj4+ICAgICovCj4+ICsKPj4gICAvKgo+IE1pc3Np
bmcgZG9jdW1lbnRhdGlvbiAvKlwgc3RyaW5nLgo+PiAtICogVGVzdCBEZXNjcmlwdGlvbjoKPj4g
LSAqICBwYXVzZSgpIGRvZXMgbm90IHJldHVybiBkdWUgdG8gcmVjZWlwdCBvZiBTSUdLSUxMIHNp
Z25hbCBhbmQgc3BlY2lmaWVkCj4+IC0gKiAgcHJvY2VzcyBzaG91bGQgYmUgdGVybWluYXRlZC4K
Pj4gKyAqIFRoaXMgdGVzdCB2ZXJpZmllcyB0aGF0IHBhdXNlKCkgZG9lcyBub3QgcmV0dXJuIGFm
dGVyIHJlY2VpdmluZyBhIFNJR0tJTEwKPj4gKyAqIHNpZ25hbCwgYXQgd2hpY2ggcG9pbnQgdGhl
IHByb2Nlc3Mgc2hvdWxkIGJlIHRlcm1pbmF0ZWQuCj4+ICAgICovCj4+IC0jaW5jbHVkZSA8dW5p
c3RkLmg+Cj4+IC0jaW5jbHVkZSA8ZXJybm8uaD4KPj4gLSNpbmNsdWRlIDxmY250bC5oPgo+PiAt
I2luY2x1ZGUgPHN5cy93YWl0Lmg+Cj4+IC0KPj4gLSNpbmNsdWRlICJ0ZXN0LmgiCj4+IC0jaW5j
bHVkZSAic2FmZV9tYWNyb3MuaCIKPj4gLQo+PiAtc3RhdGljIHBpZF90IGNwaWQ7Cj4+IC0KPj4g
LWNoYXIgKlRDSUQgPSAicGF1c2UwMyI7Cj4+IC1pbnQgVFNUX1RPVEFMID0gMTsKPj4gICAKPj4g
LXN0YXRpYyB2b2lkIGRvX2NoaWxkKHZvaWQpOwo+PiAtc3RhdGljIHZvaWQgc2V0dXAodm9pZCk7
Cj4+IC1zdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpOwo+PiArI2luY2x1ZGUgInRzdF90ZXN0Lmgi
Cj4+ICAgCj4+IC1pbnQgbWFpbihpbnQgYWMsIGNoYXIgKiphdikKPj4gK3ZvaWQgcnVuKHZvaWQp
Cj4+ICAgewo+PiAtCWludCBsYzsKPj4gICAJaW50IHN0YXR1czsKPj4gKwlwaWRfdCBwaWQ7Cj4+
ICAgCj4+IC0JdHN0X3BhcnNlX29wdHMoYWMsIGF2LCBOVUxMLCBOVUxMKTsKPj4gLQo+PiAtCXNl
dHVwKCk7Cj4+IC0KPj4gLQlmb3IgKGxjID0gMDsgVEVTVF9MT09QSU5HKGxjKTsgbGMrKykgewo+
PiAtCQl0c3RfY291bnQgPSAwOwo+PiAtCj4+IC0JCWlmICgoY3BpZCA9IHRzdF9mb3JrKCkpID09
IC0xKQo+PiAtCQkJdHN0X2Jya20oVEJST0sgfCBURVJSTk8sIE5VTEwsICJmb3JrKCkgZmFpbGVk
Iik7Cj4+IC0KPj4gLQkJaWYgKGNwaWQgPT0gMCkKPj4gLQkJCWRvX2NoaWxkKCk7Cj4+IC0KPj4g
LQkJVFNUX1BST0NFU1NfU1RBVEVfV0FJVChjbGVhbnVwLCBjcGlkLCAnUycpOwo+PiAtCj4+IC0J
CWtpbGwoY3BpZCwgU0lHS0lMTCk7Cj4+IC0KPj4gLQkJU0FGRV9XQUlUKE5VTEwsICZzdGF0dXMp
Owo+PiAtCj4+IC0JCWlmIChXSUZTSUdOQUxFRChzdGF0dXMpICYmIFdURVJNU0lHKHN0YXR1cykg
PT0gU0lHS0lMTCkgewo+PiAtCQkJdHN0X3Jlc20oVFBBU1MsICJwYXVzZSgpIGRpZCBub3QgcmV0
dXJuIGFmdGVyIFNJR0tJTEwiKTsKPj4gLQkJCWNvbnRpbnVlOwo+PiAtCQl9Cj4+IC0KPj4gLQkJ
aWYgKFdJRlNJR05BTEVEKHN0YXR1cykpIHsKPj4gLQkJCXRzdF9yZXNtKFRGQUlMLCAiY2hpbGQg
a2lsbGVkIGJ5ICVzIHVuZXhwZWN0ZWRseSIsCj4+IC0JCQkgICAgICAgICB0c3Rfc3Ryc2lnKFdU
RVJNU0lHKHN0YXR1cykpKTsKPj4gLQkJCWNvbnRpbnVlOwo+PiAtCQl9Cj4+IC0KPj4gLQkJdHN0
X3Jlc20oVEZBSUwsICJjaGlsZCBleGl0ZWQgd2l0aCAlaSIsIFdFWElUU1RBVFVTKHN0YXR1cykp
Owo+PiArCXBpZCA9IFNBRkVfRk9SSygpOwo+PiArCWlmICghcGlkKSB7Cj4+ICsJCXBhdXNlKCk7
Cj4+ICsJCXRzdF9yZXMoVEZBSUwsICJVbmV4cGVjdGVkIHJldHVybiBmcm9tIHBhdXNlKCkiKTsK
PiBXZSBjYW4gdXNlIFRTVF9FWFBfUEFTUyhwYXVzZSgpKQo+PiArCQlleGl0KDApOwo+PiAgIAl9
Cj4+ICAgCj4+IC0JY2xlYW51cCgpOwo+PiAtCXRzdF9leGl0KCk7Cj4+ICsJVFNUX1BST0NFU1Nf
U1RBVEVfV0FJVChwaWQsICdTJywgMTAwMDApOwo+PiArCWtpbGwocGlkLCBTSUdLSUxMKTsKPj4g
KwlTQUZFX1dBSVRQSUQocGlkLCAmc3RhdHVzLCAwKTsKPj4gICAKPj4gKwlpZiAoV0lGU0lHTkFM
RUQoc3RhdHVzKSAmJiBXVEVSTVNJRyhzdGF0dXMpID09IFNJR0tJTEwpCj4+ICsJCXRzdF9yZXMo
VFBBU1MsICJwYXVzZSgpIGRpZCBub3QgcmV0dXJuIGFmdGVyIFNJR0tJTEwiKTsKPj4gKwllbHNl
Cj4+ICsJCXRzdF9yZXMoVEZBSUwsICJDaGlsZCBleGl0ZWQgd2l0aCAlaSIsIFdFWElUU1RBVFVT
KHN0YXR1cykpOwo+PiAgIH0KPj4gICAKPj4gLXZvaWQgZG9fY2hpbGQodm9pZCkKPj4gLXsKPj4g
LQlURVNUKHBhdXNlKCkpOwo+PiAtCj4+IC0JdHN0X3Jlc20oVEZBSUwsICJVbmV4cGVjdGVkIHJl
dHVybiBmcm9tIHBhdXNlKCkiKTsKPj4gLQo+PiAtCWV4aXQoMCk7Cj4+IC19Cj4+IC0KPj4gLXZv
aWQgc2V0dXAodm9pZCkKPj4gLXsKPj4gLQl0c3Rfc2lnKEZPUkssIERFRl9IQU5ETEVSLCBjbGVh
bnVwKTsKPj4gLQo+PiAtCVRFU1RfUEFVU0U7Cj4+IC19Cj4+IC0KPj4gLQo+PiAtdm9pZCBjbGVh
bnVwKHZvaWQpCj4+IC17Cj4+IC0Ja2lsbChjcGlkLCBTSUdLSUxMKTsKPj4gLX0KPj4gK3N0YXRp
YyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPj4gKwkudGVzdF9hbGwgPSBydW4sCj4+ICsJLmZv
cmtzX2NoaWxkID0gMSwKPj4gK307Cj4gQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
