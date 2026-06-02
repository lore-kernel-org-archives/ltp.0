Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5B4CD6E57
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 11:24:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7971F3E5610
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 13:24:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81B3B3E722D
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 13:23:38 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 122861A000A8
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 13:23:38 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-91550dfc11fso275447985a.1
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 04:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780399417; x=1781004217; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1zWaxMX2ylP+Ggro4HchG9EGramZloGGzdzJzBip08=;
 b=d2nv3P3vMKDgLKYkhtw+Zo/cB55jqp01hlOhFJ19OXPcLdZdZx1TxC44WNyZ+EEARX
 qx+1TAQln3Ina49brCsQWWNcD+Io6fzQDOaUeN4YO9gBSmUDzMYDzctXrgBos4+1OCyr
 0Vq54I9jyx/exO0gUoNTAVllxxte7+Wfy3pnC50ikM87A4cIFvnOfGpHdECUvlHqn5Pk
 cEdKPl0/4jpXuFoN/DCXuQ+abm1DuKrO+ZuZ+sblbS32KzviEQmzO56Vhfk5+xDUzihi
 wqg4fuuJbT9bog6yCxqySp90/JizM0rT2Ue3O+l8hbQRtEIwOkMHaUPb7pvm3Zs+W3cc
 geKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780399417; x=1781004217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W1zWaxMX2ylP+Ggro4HchG9EGramZloGGzdzJzBip08=;
 b=THz+qExKmRBoD+1bsPvYHbG3GaNfV+mLk2YXSq8oScelgVIMlH4LeU2VUeKG6POd62
 veZDMY7Wr6TcGBuZCroMgCtumJOz9jWOM7IAFgKBVZe4o5Nz5KMOBC9K8zjS4P97jssQ
 lBRipMoNSwjMi3plZb4g2X4ozh51eOnnVyRwbCJX6bIY84SgDwj93wn8s9OXqty/F1gv
 cF4cmZPs3zY8IwKeJlrmFLaxrzWcmHjuLb218hT4uqli2dE4qnty58tS4QKy/VF3d0qo
 M+t1k5q5pXhLDm0FXv2L6euv6JCGVehotB9xo4aG0jXwTC/v8/Aah9BWaKYAWoyGSOY0
 iYYg==
X-Gm-Message-State: AOJu0YzdHQ3VLYrMyAJPHFPw0bHeP7k700zPLUbYaqAXPhakFm49s6iw
 +Hjelw4bmJhrnMn9ircz+Wrpu0OchD475//uExPLRHG1h5YHDk/1DLkx
X-Gm-Gg: Acq92OHaI+6S842kUUo63k+pVGLcwbVWbwHvhaHS4fT4fVnUmATkUF0uYo6KmY5fG+h
 NomaFNyLoSJ3ADJL7u4tIFjii863CxNrZDzwXMX1r2zg4O4ox6Ss8RsH1iGBOhkng+bGTDlgh9s
 Gu4RTPOOZo2IlMILxDiv7tnLjgaACMM3FC5eFP636fIBjIcxqKqCPXFjwKBlYWRZjxXgKfkYjkd
 0bxEq+Sm+XuVAXMD7YJ2/QzDFQ4dvEp16eEx4M0aNFtyUyERBqDIpIvq3ellcjzhtEh4jHbglug
 NgIoRPOAVqMZtzYVIrae/vxqyoXNDNUW52d+R1HYelJ8wh1S3l5WSMs/+3DD+d/vUYPhO8+Z/Op
 1QPoqT8RX3eF0I9hdyGPfUKZp2rJZXY/9ADWaqhLT5zlJtgzzCum7B7PQ0ae/c7pW4jZrrhZmVO
 LkIfXTkCBgl4+ta4/S9dGffIwwVAuAPPmlD625aeiG4MpSIcnPNHJoVgg//yfYa5/QJdMrXoHXf
 cFoC/KlDQre7/8GjSbTRGrYLz6RH3wo391W+nzi1roAvsYx4A==
X-Received: by 2002:a05:620a:2996:b0:915:8502:f7f6 with SMTP id
 af79cd13be357-9158503248emr77975285a.35.1780399416647; 
 Tue, 02 Jun 2026 04:23:36 -0700 (PDT)
Received: from
 runnervm3jyl0.5hgevcz2ktnelnoq3fqwxyu51d.bx.internal.cloudapp.net
 ([172.208.13.57]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea1c30ecsm115764266d6.25.2026.06.02.04.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 04:23:36 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: XiaoLei Wu <wxl18715129466@gmail.com>
Date: Tue,  2 Jun 2026 11:23:35 +0000
Message-ID: <20260602112335.4032-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602064442.718507-1-wxl18715129466@gmail.com>
References: <20260602064442.718507-1-wxl18715129466@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/unlink09: report unsupported inode flags as TCONF
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

SGkgWGlhb0xlaSwKCk9uIFR1ZSwgSnVuIDAyLCAyMDI2IGF0IDAyOjQ0OjQyUE0gKzA4MDAsIFhp
YW9MZWkgV3Ugd3JvdGU6Cj4gc3lzY2FsbHMvdW5saW5rMDk6IHJlcG9ydCB1bnN1cHBvcnRlZCBp
bm9kZSBmbGFncyBhcyBUQ09ORgo+Cj4gSWYgRlNfSU9DX0dFVEZMQUdTIGZhaWxzIHdpdGggRU5P
VFRZLCB0aGUgZmlsZXN5c3RlbSBkb2VzIG5vdCBzdXBwb3J0Cj4gaW5vZGUgZmxhZ3MuIFRoaXMg
aXMgYW4gdW5zdXBwb3J0ZWQgdGVzdCBjb25maWd1cmF0aW9uIHJhdGhlciB0aGFuIGEKPiBicm9r
ZW4gdGVzdCBzZXR1cCwgc28gcmVwb3J0IFRDT05GIGluc3RlYWQgb2YgVEJST0suCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBYaWFvTGVpIFd1IDx3eGwxODcxNTEyOTQ2NkBnbWFpbC5jb20+CgpSZXZpZXdl
ZC1ieTogTFRQIEFJIFJldmlld2VyIDxsdHBAbGlzdHMubGludXguaXQ+CgpUaGUgZml4IGlzIGNv
cnJlY3QuIEVOT1RUWSBmcm9tIEZTX0lPQ19HRVRGTEFHUyBtZWFucyB0aGUgZmlsZXN5c3RlbQpk
b2VzIG5vdCBzdXBwb3J0IGlub2RlIGF0dHJpYnV0ZSBpb2N0bHMsIHdoaWNoIGlzIGEgbWlzc2lu
ZyBmZWF0dXJlLCBub3QKYSBicm9rZW4gdGVzdC4gVENPTkYgaXMgdGhlIHJpZ2h0IHJlc3VsdCBj
b2RlLCBhbmQgdGhpcyBpcyBjb25zaXN0ZW50CndpdGggaG93IHN0YXR4MDguYyBhbmQgc3RhdHgw
OS5jIGhhbmRsZSB0aGUgc2FtZSBpb2N0bCBmYWlsdXJlOgoKICB0c3RfYnJrKFRDT05GIHwgVEVS
Uk5PLCAiRlNfSU9DX0dFVEZMQUdTIG5vdCBzdXBwb3J0ZWQiKTsKClRoZSBwYXRjaCBpcyBhIG9u
ZS1saW5lIGNoYW5nZSBhbmQgdGhlIGNvbW1pdCBtZXNzYWdlIGFjY3VyYXRlbHkKZGVzY3JpYmVz
IGJvdGggd2hhdCBjaGFuZ2VkIGFuZCB3aHkuCgotLS0KClByZS1leGlzdGluZyBpc3N1ZXMgKG5v
dCBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gsIGluZm9ybWF0aW9uYWwgb25seSk6CgoxLiB0ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3VubGluay91bmxpbmswOS5jOiBBZnRlciB0aGUgRU5PVFRZ
IGJyYW5jaAogICBpbiBzZXR1cCgpIGNsb3NlcyBmZF9pbW11dGFibGUgYW5kIGNhbGxzIHRzdF9i
cmsoVENPTkYsIC4uLiksIHRoZQogICB2YXJpYWJsZSBmZF9pbW11dGFibGUgc3RpbGwgaG9sZHMg
dGhlIChub3ctY2xvc2VkKSBmaWxlIGRlc2NyaXB0b3IKICAgdmFsdWUg4oCUIGl0IGlzIG5ldmVy
IHJlc2V0IHRvIC0xLiBXaGVuIGNsZWFudXAoKSBsYXRlciBydW5zLCB0aGUKICAgZ3VhcmQgImlm
IChmZF9pbW11dGFibGUgIT0gLTEpIiBpcyB0cnVlLCBzbyBzZXR1cF9pbm9kZV9mbGFnKCkgaXMK
ICAgY2FsbGVkIG9uIHRoZSBhbHJlYWR5LWNsb3NlZCBmZCwgcHJvZHVjaW5nIGFuIEVCQURGIGVy
cm9yIHZpYQogICBTQUZFX0lPQ1RMLCBmb2xsb3dlZCBieSBhIHNlY29uZCBTQUZFX0NMT1NFIG9u
IHRoZSBzYW1lIGZkLiBCb3RoCiAgIHN0YXR4MDguYyBhbmQgc3RhdHgwOS5jIGF2b2lkIHRoaXMg
Ynkgbm90IGNhY2hpbmcgdGhlIGZkIGluIGEKICAgZ2xvYmFsIHVudGlsIGFmdGVyIHRoZSBGU19J
T0NfR0VURkxBR1MgcHJvYmUgc3VjY2VlZHMuCgpMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
