Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD24C36005
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 12:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742905898; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=o1EalKqIStgUQISgTES2721DMuZYN6e50fsfE7rohkA=;
 b=Wo+y1tCygLg7M8cGDQDFqUA1+j5wr+3R2cNLfoh/EaA9wkfqFp5hcuA15lr5zXkxVwbcH
 XNAjeP1fBLxZQFdXxv0UmjYEasAkWg/ObmEKgXcmpXKNP1zvNyYDXBp9Ia+zPOIAIa7eLsO
 vrKMmMWNHm5HplYQ//lgfOYxZMU2ITs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D2763C99CC
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 13:31:38 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C28143C2FB2
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 13:31:16 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4C128200912
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 13:31:16 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so53178915e9.1
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 05:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742905876; x=1743510676; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9P1nvO+ErOQ9+O10nzz7KzTyngdd8hEv6nzbBXv2pr4=;
 b=DpGkGFuSqbrhKZgul4aGDvaQ229q57QlQg8ehcggtKHdDsPReRYw5YV92DVmTyfOXh
 2QZnIo1HfJBUncJRreMj1r/mw8JCURpp8coOjFm9iR41VJPfYu7JIr5VPBuAaORVHDSA
 RbrRe2wdtaffEIEIO2qCvLZE1DM6TiGfvv6uIJ1GsuzeEGzS9HVSIpPdtSnj5LMvPY94
 NHGYaJ6sMTy+o5jeum/hdZBxzHkoDuoSyQSCmLsypNKP65K4YaixdsTecQWRQQlRc1ju
 9FNeeURtJrsRbMsBwEV3TZYg6X837C9cZzpqdjj0a+j4wsJzDLbCyC+OSJiGn0LB9h3D
 dEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742905876; x=1743510676;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9P1nvO+ErOQ9+O10nzz7KzTyngdd8hEv6nzbBXv2pr4=;
 b=em0cfpM3bKSWAlG1Kp06nGZ7JgLGLrb0ZvbvyhTUP4XKKiSJ2pXW8vtJ+GK1GzxpWx
 TBjk3VLY066U3YOECwSL8OSpTqTCwWC5bDVYd69Ke5hpVmYdkcY7+F6GELqzeLWCk3r4
 zcQHi5ylrbes05RA/SEH1XX6voZd8O441BbHLKUTHSODN7+hs+aPxNTFZVpZwiySVirW
 drsu0ExuDxvhzpqa5JuO/0rawIef9f90vOwTMBh+0TTPdJd6hWEEpTTmdD4OfjXX9hpr
 i7U6bUlpQ+oHL9HweKdcQloJ+AWf98Qm9k+EouqJ6+kgcXLORIMO/379YRGdyxwWBFHU
 jKIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPFu7YjX3sN4G6qW19h0YFWpttBTiYjewKcAUeWrPUWnj2qVJn8bxDLG2RZicJEzgKhXg=@lists.linux.it
X-Gm-Message-State: AOJu0YzCJVr+22iDrvJohnWbTfxRUmIfYbZa2fDuu5412N5gZ3Ldl2qR
 0vhPnRuUBEyXJHaJxAk/kW4hmo7Cvx/L16jPR6jjx7835ulbZFrlieIE4TUulz7KL0tSZul3uGl
 4JFbl+A==
X-Gm-Gg: ASbGncvnITJzBxwBqpE3jezQUKvr2IsmH5zScWaTzn1qfj3YDYveqPNT/SOaHfj9YkS
 NnIwopcpmlPLRSamcCOQ6yggI3ScoZu77KiMzoYUwPOuXbaT6D/18cwgEi117faYW+3CVVv8Zw/
 nYWLXuqkA1rydZK5hCDAG4r01ATk0j5bS6CZyc3DkSK3tr0PVtcpp7RLcA4ViFftCV4WE7IU5ei
 4k11xMxCQ/ESfu80IQ/kO55oc7VMIM+Ma8MrRvoTUI55gEHupGWGbA2HcHPaBDu2bBZc1eb2IHS
 uEpzq2AvTIPxjqi3BHSbSIgK9rQWgEe18LZnA19APuN7Cc3Jyl0eTvg=
X-Google-Smtp-Source: AGHT+IEYtUEINBqpzlFnHox1m45oegt8pYohFte/G6awA9p9gPiW501ajFRG7pEE3SoMWbi7Qv3JxQ==
X-Received: by 2002:a5d:648e:0:b0:390:ff25:79c8 with SMTP id
 ffacd0b85a97d-3997f90990fmr17432114f8f.20.1742905875722; 
 Tue, 25 Mar 2025 05:31:15 -0700 (PDT)
Received: from [10.232.133.75] ([88.128.90.56])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e65d5sm13828204f8f.64.2025.03.25.05.31.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 05:31:15 -0700 (PDT)
Message-ID: <5920a215-fc11-460d-b917-d57b8cf3f60e@suse.com>
Date: Tue, 25 Mar 2025 13:31:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250324-conversions-modify_ldt-v1-0-8d6d82f10768@suse.com>
 <20250324-conversions-modify_ldt-v1-4-8d6d82f10768@suse.com>
 <fac3d9dd-f960-4c63-be05-45f4d0fbe5e2@suse.com>
 <D8PCII25DLZQ.1K8JXES1P964F@suse.com>
Content-Language: en-US
In-Reply-To: <D8PCII25DLZQ.1K8JXES1P964F@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] syscalls/modify_ldt: Refactor modify_ldt01
 into new API
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgcmljYXJkbywKCk9uIDMvMjUvMjUgMTM6MjgsIFJpY2FyZG8gQi4gTWFybGnDqHJlIHdyb3Rl
Ogo+IEhpIEFuZHJlYSwKPgo+IE9uIFR1ZSBNYXIgMjUsIDIwMjUgYXQgNzoxMCBBTSAtMDMsIEFu
ZHJlYSBDZXJ2ZXNhdG8gd3JvdGU6Cj4+IEhpIQo+Pgo+PiBTbyB0aGlzIGlzIGEgdGVzdCB3aGlj
aCBpcyB0ZXN0aW5nIGlmIG1vZGlmeV9sZHQgc3lzY2FsbCBpcyBwcm9kdWNpbmcKPj4gdGhlIHJp
Z2h0IGVycm9ycyBhY2NvcmRpbmcgdG8gaW52YWxpZCBpbnB1dHMuIEl0J3MgYSBwcmV0dHkgY29t
bW9uIHR5cGUKPj4gb2YgdGVzdCBpbiBMVFAgYW5kIHdlIGNhbiBleHRlbmQgaXQgdG8gYWxsIHRo
ZSBvdGhlciBlcnJvcnMgYXMgd2VsbAo+PiBCYXNpY2FsbHksIHdlIG5lZWQgdG8gbWVyZ2Ugc2lt
cGxlIHRlc3RzIGNoZWNraW5nIGZvciBlcnJvcnMgaW50byBhCj4+IHNpbmdsZSBvbmUgdXNpbmcg
dGVzdCBjYXNlcy4KPiBTbywgYmFzaWNhbGx5IGtlZXAgMDEgYW5kIGV4dGVuZCBpdCBpbnN0ZWFk
IG9mIHNwbGl0dGluZyBpdCBpbnRvIG5ldwo+IHRlc3RzIHN1Y2ggYXMgMDQgYW5kIDA1PwoKRXhh
Y3RseSwgaW4gdGhpcyB3YXkgd2UgY2FuIHVzZSB0ZXN0IGNhc2VzIGFuZCByZWR1Y2UgY29kZSBk
dXBsaWNhdGlvbi4KCkFuZHJlYQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
