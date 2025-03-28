Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76096C36011
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 17:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743183921; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=cWOk7KTflY0H/xH6RGyYHhI4pwMvT6tUyY/NR0rx3Sw=;
 b=cGrcxMtx02L0kzYvk/nwGtf7Pov88Q9jqwmCM1Hw4tGJjeDH6woSqbSJ99Dic66eu0zFG
 NRTRP5H5QWnPA1f2R5qZuNfR/AzjjjhTcbvo9xLNvEbFqEG4f4+NxkL40Y8aYDo1Q1E0m02
 1TWvkFj29g6/KYkNzX6pV9mCBu/JviY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5D9F3CA4A0
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 18:45:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D3E63C9A39
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 18:44:59 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4CFF1600C82
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 18:44:58 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394a823036so24035565e9.0
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743183897; x=1743788697; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=crQxYzPxNw5tv0Yp62zX1ylRUnUiJOx2PuDlf5MBm38=;
 b=Ut0WT9nOIqWTDPkrjW9/PV4K47a1t9Af+FCzeuG0zIP8coHu9DTx6iqMY3dDB1dd/r
 rQWkxxcid5kT0m7m1dPTT9oBmVruQMVXW315odoa8wVd9TBfka8Ytnm1prs0/+zD+0vH
 I5rN5ZbVX+qP9RNwZsum482bOkPQhFbxurB8lERZlAzC/XvC3NxmnuGM/Yft7aHQLcnj
 2SSQb4TWPuVC9mmgBsuBpb19hNt14Bw+V6iU299UlVbRIypmRRUplczcYFLT1OGwBd5Q
 AtFDF9z9BwKtHlhK7Rm9sxQy0gQ9UJw/U6avtn1fbUxOwi7ZbuEbq2bKRlSdtyDksji3
 hiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743183897; x=1743788697;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=crQxYzPxNw5tv0Yp62zX1ylRUnUiJOx2PuDlf5MBm38=;
 b=l44fw/nQwSWwHg7wdt2x6aw8cagDHdiuu/yZedDSmqivIaBdPKGwoQ5atSNpmsKqj3
 AipBB5K47jIJX45C6SxxTaaN2K8J6GqlNjLAuIxcbh6E1THsk2dnRqRVw9cO6OeTL4Mp
 Z2v3S9IT4HzBFWi6mIqeIlcAubhxHf+hcxwWO+xRbSj8LLedQpjZQmPPRqJme6clOoqv
 QxvtZ+CPezj94TrKZw1Cv5cuHmz4YgmzN3oy2I17hSVvOk+SQcbyrrGAd6pFt5JTxg6N
 WIvJPFperfJ09dty1tXg+QJnT0Ej3DNCudaU7eUtHb3Ne92iOHHbHufaeNIHJNX2+7im
 DiIg==
X-Gm-Message-State: AOJu0YyVh+gQnsO3IkZZ8HIsELqcXGElEHDOrWIP8DzanPNNZBe7Pk4M
 V5uY53H3v9s1Cjr53y//cCMt3xl2v/HLyokEtzMfiwE6DQpU5ZwL00gcy3NSGSqnHQ6NParhCGm
 w
X-Gm-Gg: ASbGncthHB47XagxGqpyljaHi2IErwTDHb2EJjvd47DmXbf7/uWeZHfC3brTVIpT98g
 q7ycmLVAPoCJDGzfGqg7i3a0lqrB1EuTZIhJ1VaXjIieWLAJ1bZE9Y8ksWNSQgfh7SIc5o3k9Vv
 s0UOKgVnT+emyjbNrDtcFnwjENxjhHOhgB0uMCvGIR1nwMBm+ckQK9hTjOxzpn8oyyAvr0cJvvL
 Zp9bQkR9JRKhkw5WVgekSytHLbRi3JHp81SJ9dt33sCTYywlGkd3F2jSJi/pOWwPts8LgWgOsyK
 i264yQKmUVKwA72kSn19J8szkbpxxjXRJg==
X-Google-Smtp-Source: AGHT+IHEqtunZrUPYwtJQrrItLF/gXyZh5i8joUc3XkcKPF+xDrNVkLSm1e1IOySMZCcG1NFaL/FZQ==
X-Received: by 2002:a5d:64ee:0:b0:391:2fe4:de0a with SMTP id
 ffacd0b85a97d-39c120ccabfmr46022f8f.2.1743183897588; 
 Fri, 28 Mar 2025 10:44:57 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2291f1dfbbfsm21057695ad.207.2025.03.28.10.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 10:44:56 -0700 (PDT)
Date: Fri, 28 Mar 2025 14:44:52 -0300
Message-Id: <20250328-conversions-modify_ldt-v3-0-f6b6ee1c9144@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABTg5mcC/4WOQQ6CMBREr0K6tqZ8sIAr72GMKe1Hmgg1/dhIC
 He3ZcXGuJzkzZtZGKG3SOycLcxjsGTdGENxyJju1fhAbk3MDAScRAEl124M6BNGfHDGdvP9aSZ
 e57KABqDoJLJYfnns7GcTX28xt4qQt16Nuk+6QdGEPoG9pcn5eTsQ8oT/3Qo5F7w20tTQ5aKS9
 YXehEftBpamAuwt1U8LRAs0ojKlia+12FnWdf0Cq1pvnhoBAAA=
X-Change-ID: 20250324-conversions-modify_ldt-816329223f6e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1857; i=rbm@suse.com;
 h=from:subject:message-id; bh=LgqWUvILTMX0GWfHGo5hKnxPYnFwPJSmK1VL6p97bqI=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn5uAU/gY5KjZ29v3pz7Ri+gI8sJHByr/50qGcj
 0Y8vylH8FmJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ+bgFAAKCRDJC4p8Y4ZY
 pu3GD/9GzagAj7sImuM4xmwLyU4kfRGpqGUqI+4AUuz66aKyvgttICUdFHWC64fxVy6pnagj5Pu
 Mfc4OKEZZAcwEMkEfZatQoRd7eDCkSd2C2WBwkP7t2mQDBozUVlN6ceVW7JqMJhW0ZkOPQzwfCV
 ahV/rQaajoNqDP/SQtiszGljPOqWAP6qXwExFB4UNUSKwSZ3Nst+Nm9xNSk9Ic6kfnSKred9Kaf
 pkA+nMcsWPKrbjS1Jwo/UzxvzmErLIwCsFFROiId1V73KSFFWAsYm8Z26CWVoHlW7cqBfty/8Cg
 shwGezWgcuH0BGy8hIo9xuKScKTnNWS/0qnxO9scqQeoJGgGOP57rajY6pZIOQ1BQPL1huJu+gq
 zsSEithQWrBZotx7GD/XwbzhhDRNCdQjCE5RKAI8vMDQyqDrbm+/7zzTWQkhjJfJioKvo3ZfX0Z
 /z1PWPUEg5wpjK25kRI4nvQ2ErmdOgLmcyD4U5bWqEPew01k9FaeV4/EDhEczNvuKrcpYdhRiRe
 nrk2Xu31Xo20EAWm6kstS/U5lbWdHLVk51kitGIX7mGxsXjXwqNv1Le61mTw/UPxOVDoeAodTuH
 7z03ZkSbjRpnxp4BII2AxQZ51cK/2C2PN5aIu+ZZynGdpYHuHiFSKciBpoB4R7KhF3RzSzb7fzq
 FiU3JeN8Q6qdVcQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] syscalls/modify_ldt: Refactor into new API
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: rbm@suse.com
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KLS0tCkNo
YW5nZXMgaW4gdjM6Ci0gRHJvcHBlZCB0aGUgc2V0X3RocmVhZF9hcmVhMDEgcGF0Y2ggZm9yIGEg
bGF0ZXIgc2VyaWVzCi0gU3F1YXNoZWQgbW9kaWZ5X2xkdDAzIGNvbW1pdCBpbnRvIG1vZGlmeV9s
ZHQwMQotIFJlbmFtZWQgc3RydWN0IHRzdF9jYXNlIHRvIHRjYXNlCi0gUmVtb3ZlZCBmYWxsYmFj
ayBkZWZpbml0aW9uIG9mIHN0cnVjdCB1c2VyX2Rlc2MKLSBMaW5rIHRvIHYyOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9yLzIwMjUwMzI3LWNvbnZlcnNpb25zLW1vZGlmeV9sZHQtdjItMC0yOTA3
ZDRkM2Y2YzBAc3VzZS5jb20KCkNoYW5nZXMgaW4gdjI6Ci0gQWxzbyByZWZhY3RvcmVkIHNldF90
aHJlYWRfYXJlYTAxCi0gTWVyZ2VkIHNpbXBsZSB0ZXN0cyAoaW5jbHVkaW5nIHRoZSBleGlzdGlu
ZyBtb2RpZnlfbGR0MDMpIGludG8KbW9kaWZ5X2xkdDAxIGluc3RlYWQgb2Ygc3BsaXR0aW5nIGl0
Ci0gQWRkZWQgU0FGRV9NT0RJRllfTERUKCkgbWFjcm8KLSBSZW1vdmVkIGNoZWNrIHRvIGFzbS9s
ZHQuaCBpbiBjb25maWd1cmUuYWMKLSBVc2VkIHRzdF9zeXNjYWxsKCkgaW5zdGVhZCBvZiBzeXNj
YWxsKCkgaW4gbW9kaWZ5X2xkdCgpIEAgbGFwaS9sZHQuaAotIExpbmsgdG8gdjE6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3IvMjAyNTAzMjQtY29udmVyc2lvbnMtbW9kaWZ5X2xkdC12MS0wLThk
NmQ4MmYxMDc2OEBzdXNlLmNvbQoKLS0tClJpY2FyZG8gQi4gTWFybGnDqHJlICgzKToKICAgICAg
c3lzY2FsbHMvbW9kaWZ5X2xkdDogQWRkIGxhcGkvbGR0LmgKICAgICAgc3lzY2FsbHMvbW9kaWZ5
X2xkdDAyOiBSZWZhY3RvciBpbnRvIG5ldyBBUEkKICAgICAgc3lzY2FsbHMvbW9kaWZ5X2xkdDAx
OiBSZWZhY3RvciBpbnRvIG5ldyBBUEkKCiBjb25maWd1cmUuYWMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMSAtCiBpbmNsdWRlL2xhcGkvbGR0LmggICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAzNyArKysKIHRlc3RjYXNlcy9jdmUvY3ZlLTIwMTUt
MzI5MC5jICAgICAgICAgICAgICAgICAgICAgIHwgIDM1ICstLQogdGVzdGNhc2VzL2N2ZS9jdmUt
MjAxNy0xNzA1My5jICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKy0KIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZm9yay9mb3JrMDUuYyAgICAgICAgICAgIHwgICA1ICstCiB0ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL21vZGlmeV9sZHQvLmdpdGlnbm9yZSAgICB8ICAgNSArLQogdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0L2NvbW1vbi5oICAgICAgfCAgMzAgKysrCiAu
Li4va2VybmVsL3N5c2NhbGxzL21vZGlmeV9sZHQvbW9kaWZ5X2xkdDAxLmMgICAgICB8IDI1OCAr
KysrLS0tLS0tLS0tLS0tLS0tLS0KIC4uLi9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9tb2Rp
ZnlfbGR0MDIuYyAgICAgIHwgMjIyICsrKystLS0tLS0tLS0tLS0tLQogLi4uL2tlcm5lbC9zeXNj
YWxscy9tb2RpZnlfbGR0L21vZGlmeV9sZHQwMy5jICAgICAgfCAxMDUgLS0tLS0tLS0tCiAxMCBm
aWxlcyBjaGFuZ2VkLCAxNzcgaW5zZXJ0aW9ucygrKSwgNTMxIGRlbGV0aW9ucygtKQotLS0KYmFz
ZS1jb21taXQ6IGUzYWVmNTY5ZjBkMGU3MDc5YmRiNjQ2OTY1YWZhZjQxOTAzNWVhYTUKY2hhbmdl
LWlkOiAyMDI1MDMyNC1jb252ZXJzaW9ucy1tb2RpZnlfbGR0LTgxNjMyOTIyM2Y2ZQoKQmVzdCBy
ZWdhcmRzLAotLSAKUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
