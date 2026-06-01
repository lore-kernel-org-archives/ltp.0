Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221F6CD6E55
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 20:27:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E022A3E7251
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 22:27:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCCB03E23C9
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 22:26:47 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B8D0320006E
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 22:26:46 +0200 (CEST)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8cce22e029cso49648596d6.0
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 13:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780345605; x=1780950405; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ew5luajXAspYGT6K41LCRGIEIyyDNzELUhNBwK7X5Cc=;
 b=Ljpi6Lt2eJFWlbKIKT56wa982U7sQTNIaHG2Wn025dURsa9j4PLJ9askHiiDFouAQJ
 jXP2Pg2Ch8uiJO3N3inl4/Wb/o987K+K0H0KfXCHzFHTEGdOYYf/SxEx160z1z9It4Vr
 +L1Tazy3vRJU9zR+MfxdAE8Xg+0p8eX+Xs34KrQTJA2i/X8DO6sPiXSgPsa82N84pgjz
 zonmmcdWt2NYCQYLln3i0ymr+GTHnB8pK9j1MdK4Epnbg0HZFATTEv3DWlXhkrKMAI90
 diazbHnmCpDMDJIZFtImBpeBJ6WUBHU0/EeQh4eL5Z53HAomJ5sZIZw4Nfzh8K2weYLf
 cxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780345605; x=1780950405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ew5luajXAspYGT6K41LCRGIEIyyDNzELUhNBwK7X5Cc=;
 b=qf/3hgMKf842iuRckq4eFfNEZfQgJm8q2/H5NpVuB/+14TDrL+AuutMvwfoGT2Qr2j
 Tdi051uyOkhk4WhTZGOB1UuNE2k5DSz/ZT6cKZszgEWVIRM529giHUpVPsnFLGbA/p2i
 XyMzGAewNa5nDNAvaj2IaXC1/LH7goUA6KwOperA2Cn4fNzJwq4sbz6dP40EGINHYRlb
 afc6twjw7f6hJt0o+NyDQEIqTFR+iI+11+ocB5FZMAYSd71eH4hq+DgvDWR57rokmlY4
 h9UUOLFdKvRL0DsA6sIpTx+6k3GL/GnsyoyG55RzZrXfxrk3lFa4KFbnlPBQIjDksDNq
 evxg==
X-Gm-Message-State: AOJu0YxMG98L7me7pWQqOWfC1OPzZ9cbfL3VN1LCg0iZgSU49zvOnCC/
 abyijspSGwWJMNil9+oBLeR/hXeKV3Y13Ovl8XN9QstFs/zovZs2bDTl
X-Gm-Gg: Acq92OHIo2/A39F6vOWnw1KQlgp4NlN88pSzhKSHiJQXpsR+A0Rl5nIhywYuoNtoHgO
 Jm88Xhwd2tJyjA4uc9JZYigO3P4jve4l34poB/AZTg8ceiG0wjhMqlMCk+oKOvUSTsgh5ffM1dX
 Si5Edc/8NO8BylQ0bZjLLhpXtCqd9zz6OlBDERL6MGUNMQ/JEB+jY97j5OdxajaYcOGedTlMzzy
 8uhWpqBfjcnzTPw25oiNzwNDJLkUk7dD4muqN5+Pm2L8NgHEPfXkk1PQIK3qqOH9CiymhVvJAen
 D3g6A8DKpB+6HuwiD2Yw8DS5j5r23Mswe92S2yePZI8G6TYWOlAnm8WiR6ehXUDiCsOmNxYILmd
 z3SG9RXdfTqRuXhN+8b8J5EJJ8oa3kxsyCMcA2NFqQKI2+wlYwnKCB5Uwt+aDbL9cB692E6gj0e
 0pgnAdLyRiLFG99KJhvrkWD9WDWyCTBcjRbISYY2UoHpzn3sZedtfJQL70eX9Hl8HF/9dxMqRjA
 sHC6vxirL4eEFjLtZ14FlGEFQSoDM65K0JFjaAg3r8D3GDJ
X-Received: by 2002:ad4:5947:0:b0:8cc:f5b7:4e13 with SMTP id
 6a1803df08f44-8cebf53afdbmr19313766d6.24.1780345605525; 
 Mon, 01 Jun 2026 13:26:45 -0700 (PDT)
Received: from
 runnervm3jyl0.1bbneu23pjxupdn5p4axreckkf.ex.internal.cloudapp.net
 ([40.116.93.53]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea23e115sm101968556d6.42.2026.06.01.13.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 13:26:45 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Darren Chang <chihsheng@google.com>
Date: Mon,  1 Jun 2026 20:26:43 +0000
Message-ID: <20260601202643.3970-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601165331.4077251-1-chihsheng@google.com>
References: <20260601165331.4077251-1-chihsheng@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/xattr: Add runtime probe for socket xattr
 backports
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

SGkgRGFycmVuLAoKVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guIFRoZSBhcHByb2FjaCBpcyBzb3Vu
ZDogdXNpbmcgYSBydW50aW1lIHByb2JlIGluCnNldHVwKCkgdG8gZGV0ZWN0IGEgYmFja3BvcnRl
ZCBmZWF0dXJlIGlzIHRoZSBjb3JyZWN0IExUUCBwYXR0ZXJuIHdoZW4gYQp2ZXJzaW9uIGNoZWNr
IGFsb25lIGlzIGluc3VmZmljaWVudC4gT25lIGlzc3VlIG5lZWRzIGZpeGluZyBiZWZvcmUgbWVy
Z2luZy4KCi0tLQoKc3lzY2FsbHMveGF0dHI6IEFkZCBydW50aW1lIHByb2JlIGZvciBzb2NrZXQg
eGF0dHIgYmFja3BvcnRzCgpDb21taXQgbWVzc2FnZTogT0sKCj4gZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZnNldHhhdHRyL2ZzZXR4YXR0cjAyLmMgYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2ZzZXR4YXR0ci9mc2V0eGF0dHIwMi5jCgpMaW5lcyA4LTI2ICgvKlwg
ZGVzY3JpcHRpb24gY29tbWVudCwgbm90IGNoYW5nZWQgYnkgdGhlIHBhdGNoKToKCiAgLypcCiAg
ICogLi4uCiAgICogLSBTZXQgYXR0cmlidXRlIHRvIGEgVU5JWCBkb21haW4gc29ja2V0LCBmc2V0
eGF0dHIoMikgc2hvdWxkCiAgICogICByZXR1cm4gLTEgYW5kIHNldCBlcnJubyB0byBFUEVSTSBv
biBrZXJuZWxzIDwgNy4xLjAuCiAgICogICBPbiBrZXJuZWwgNy4xLjArIChkYzA4NzZiOTg0NmQg
InhhdHRyOiBzdXBwb3J0IGV4dGVuZGVkCiAgICogICBhdHRyaWJ1dGVzIG9uIHNvY2tldHMiKSwg
cmV0dXJucyAwIChzdWNjZXNzKSBhcyBzb2NrZXRzIG5vdwogICAqICAgc3VwcG9ydCB1c2VyLiog
eGF0dHJzLgogICAqLwoKVGhlIHBhdGNoIGNoYW5nZXMgdGhlIHNvY2tldCB0ZXN0LWNhc2UgYmVo
YXZpb3IgZm9yIGtlcm5lbHMgPCA3LjEuMCB3aXRoCnRoZSBiYWNrcG9ydCwgYnV0IGRvZXMgbm90
IHVwZGF0ZSB0aGlzIGRlc2NyaXB0aW9uLiBBZnRlciB0aGUgcGF0Y2ggdGhlcmUKYXJlIHRocmVl
IG91dGNvbWVzIGZvciB0aGUgc29ja2V0IGNhc2U6CgogIC0ga2VybmVsIDwgNy4xLjAsIG5vIGJh
Y2twb3J0ICAgICDihpIgRVBFUk0KICAtIGtlcm5lbCA8IDcuMS4wLCBiYWNrcG9ydCBwcmVzZW50
IOKGkiAwIChzdWNjZXNzLCBkZXRlY3RlZCBieSBwcm9iZSkKICAtIGtlcm5lbCA+PSA3LjEuMCAg
ICAgICAgICAgICAgICAgIOKGkiAwIChzdWNjZXNzKQoKVGhlIGNvbW1lbnQgY3VycmVudGx5IGRl
c2NyaWJlcyBvbmx5IHRoZSBmaXJzdCBhbmQgdGhpcmQgY2FzZS4gUGxlYXNlCnVwZGF0ZSBpdCB0
byBtZW50aW9uIHRoZSBydW50aW1lIHByb2JlIGZvciBiYWNrcG9ydGVkIGtlcm5lbHMuIEZvcgpl
eGFtcGxlOgoKICAqIC0gU2V0IGF0dHJpYnV0ZSB0byBhIFVOSVggZG9tYWluIHNvY2tldCwgZnNl
dHhhdHRyKDIpIHNob3VsZAogICogICByZXR1cm4gLTEgYW5kIHNldCBlcnJubyB0byBFUEVSTSBv
biBrZXJuZWxzIDwgNy4xLjAsIHVubGVzcyB0aGUKICAqICAgZmVhdHVyZSBpcyBkZXRlY3RlZCBh
dCBydW50aW1lIChlLmcuIGJhY2twb3J0KS4gT24ga2VybmVsIDcuMS4wKwogICogICAoZGMwODc2
Yjk4NDZkICJ4YXR0cjogc3VwcG9ydCBleHRlbmRlZCBhdHRyaWJ1dGVzIG9uIHNvY2tldHMiKSwK
ICAqICAgb3Igd2hlbiB0aGUgYmFja3BvcnQgaXMgcHJvYmVkIGluIHNldHVwKCksIHJldHVybnMg
MCAoc3VjY2VzcykuCgpOb3RlOiBzZXR4YXR0cjAyLmMgdXNlcyAiRVBFUk0vU1VDQ0VFRCIgaW4g
aXRzIGRlc2NyaXB0aW9uIHdoaWNoIGlzCmFscmVhZHkgb3Blbi1lbmRlZDsgbm8gY2hhbmdlIGlz
IG5lZWRlZCB0aGVyZS4KCj4gKyAgICAgICBpbnQgc29ja2V0X2lkeCA9IC0xOwo+IC4uLgo+ICsg
ICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh0Yyk7IGkrKykgewo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGlmICh0Y1tpXS5pc3NvY2tldCkgewo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc29ja2V0X2lkeCA9IGk7CgpOaXQ6IGBzb2NrZXRfaWR4YCBp
cyBgaW50YCBidXQgYXNzaWduZWQgZnJvbSBgc2l6ZV90IGlgLiBOb3QgYSBydW50aW1lCnByb2Js
ZW0gaGVyZSAoc21hbGwgYXJyYXkpLCBidXQgZGVjbGFyaW5nIGl0IGFzIGBzaXplX3Qgc29ja2V0
X2lkeGAgd2l0aApgQVJSQVlfU0laRSh0YylgIGFzIHRoZSAibm90IGZvdW5kIiBzZW50aW5lbCB3
b3VsZCBhdm9pZCB0aGUgaW1wbGljaXQKbmFycm93aW5nLiBJZiB5b3Uga2VlcCBgaW50YCwgdGhh
dCBpcyBhbHNvIGFjY2VwdGFibGUgZ2l2ZW4gdGhlIHRpbnkKYXJyYXkgc2l6ZS4KCj4gZGlmZiAt
LWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0eGF0dHIvc2V0eGF0dHIwMi5jIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXR4YXR0ci9zZXR4YXR0cjAyLmMKCk5ldyBwcm9i
ZSBjb2RlOiBPSy4gQ2xlYW4gYW5kIHN0cmFpZ2h0Zm9yd2FyZC4KCi0tLQoKVmVyZGljdDogTmVl
ZHMgcmV2aXNpb24g8J+UtAoKVGhlIGRlc2NyaXB0aW9uIGNvbW1lbnQgaW4gZnNldHhhdHRyMDIu
YyBtdXN0IGJlIHVwZGF0ZWQgdG8gcmVmbGVjdCB0aGUKdGhyZWUgcG9zc2libGUgb3V0Y29tZXMg
Zm9yIHRoZSBzb2NrZXQgdGVzdCBjYXNlLiBFdmVyeXRoaW5nIGVsc2UgaXMKY29ycmVjdC4KCkxU
UCBBSSBSZXZpZXdlcgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
