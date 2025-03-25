Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EF5C35FFC
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 12:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742906920; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=CLZqabjYwmwRNQhr4gW8s806tY606eZKy8uW+ajUHB4=;
 b=nxxNOtfDhG8gxmhxy4NjKVg5bjWf2W3MChjDs5F2YUIiyfwDFowkSCJbYW6IHkL41ly6h
 U2IPxQFpm86SDbjtXkCa2DHqt6z2M89mFRxSyq4tGG8GkmqYOIGfxM3jIeQqtRti0UkhxAz
 wtch8DVhD3A2gO6t0mWSrcYuTE4oyC4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 616383C9991
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 13:48:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C06A73C2FB2
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 13:48:18 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B6E06200C82
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 13:48:17 +0100 (CET)
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so58588165e9.3
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 05:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742906897; x=1743511697; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kzsrupdjgIT456c2dTZoVj77+LBxNMKhjzHqPtGu0FQ=;
 b=JrvRLFOfH95j08i21bAf/w5+F+Hb3KBoU0abNBSm8qOFbkrWJe+mOMJU2EZMrKRQ8V
 MhVQVn0+eGscj5QRwPiAeLQe2XjK6GdlrWlVD4ApAgC/dqr9UXuk41W2p6V+iFxrL0rT
 i1bfjKuOrMbZNtJLDUDHO7NSXZQOPVD73KXSlTVc1GwM7WCsdYa5t1Qkn7XOwTwx6cAy
 5vOxWOwqs+0z7fNR25S2r1iWAgywvDLhhW5Xm+2lLoHMeJwv8MduWz4DPv/W2W+MHxQx
 JecyTQxlSYXjBFe/LG8t7uaT3dvOLyM0o+ZNVVkDWhB9pF8w4HJBMwV4oWOY2hZteiUJ
 x+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742906897; x=1743511697;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kzsrupdjgIT456c2dTZoVj77+LBxNMKhjzHqPtGu0FQ=;
 b=TSfWiIl9CKWxOHHN//W9QoMQZtd3/Hef/QVHKCe51JTxXv3eY84KBa/xV5juMyl7fD
 e7Je6d38cW/FcLrTltSxYiTgCAf0vYK/lUSQ8ZxLW9ajdYqZh+co+MXCBJtHMvzScSD/
 mz20x4KDS3uDE0udCRHNx6kEpyuQh8ugvz1SALm73DFS1Rfp2VX+7ODxHmVXNwJ5REuT
 Q8wWZ/cx5uurKNSLzMne0teFe3WrG7IvbthU+3EFPo3Paa2FmS4We+QsBsnlmJer8MGx
 jixc0xk9C5aoYmEBczY7Vfs3fUmJcB4kMEGWHoaK9/sPyBqd/FWhsq86ctwyyQP+y5Ja
 8JcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCJEbEEw59mtooh/DPlL6MreIxE6TCgxrTe5H+ENxOT0VAHS31uYPmF5LN1/2M9natDAQ=@lists.linux.it
X-Gm-Message-State: AOJu0Yy+AwV9hf6Oo7Kaw/3DUnKnPQwnnQ/a/8Xfkx8rvTVgzVAPnDis
 LRqgmUU1ely5BXOo8NWOUP7vzp5GuMGE+aCcGpY/0xrobZEDmvXHAhHHL0Sy3LQ=
X-Gm-Gg: ASbGncuV7heXjl4hLBw55VbsCfz4P04YYkdyD/iI+6JBF0rxD5glKSiblSn36MQdXWH
 2ZFdLeo8WGyPXns2PGx9d9JYyorykcTUwHe/oB7b2+I1R9tbrB4R+P+yqlw8eu00pigMIJlrV/p
 LdMqJ3C3BnuNcuMDLX+XrD99o7kNi+mO0cxkP5GQL0FgJCnufvxHkkF21hbTcoQR8xFcVL4QR28
 r6Xx2ILaQE2IbqEkV25I2CLXLGkcGGuqCb+Fi8mgWov2HLWLLeC/Dgmij0HCNeFCAL7CWulnPh0
 EesScRPioPWyIlam59/6q3H8xB9ixbKC1+PYy4U8C3pj7ayAc/zsOok=
X-Google-Smtp-Source: AGHT+IHoLsqsZ9NfEgIINoN8mzl1e3RzjdiIDogP5i/Fh56Oo7vkObqKdgKCktSOEUeXOBIxzVbmSw==
X-Received: by 2002:a05:600c:1d15:b0:43c:f1cd:3d78 with SMTP id
 5b1f17b1804b1-43d509ea2fcmr133215815e9.12.1742906897123; 
 Tue, 25 Mar 2025 05:48:17 -0700 (PDT)
Received: from [10.232.133.75] ([88.128.90.56])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f995a05sm13541627f8f.8.2025.03.25.05.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 05:48:16 -0700 (PDT)
Message-ID: <00679c5a-b926-4749-a25b-dc875814d717@suse.com>
Date: Tue, 25 Mar 2025 13:48:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250324-conversions-modify_ldt-v1-0-8d6d82f10768@suse.com>
 <20250324-conversions-modify_ldt-v1-1-8d6d82f10768@suse.com>
 <d2421a65-bdc8-4ccf-9614-c08afbda42f2@suse.com>
 <D8PCMU5WB2B5.29G4FBTXHX35I@suse.com>
Content-Language: en-US
In-Reply-To: <D8PCMU5WB2B5.29G4FBTXHX35I@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] modify_ldt: Add lapi/ldt.h
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

SGkgcmljYXJkbywKCk9uIDMvMjUvMjUgMTM6MzQsIFJpY2FyZG8gQi4gTWFybGnDqHJlIHdyb3Rl
Ogo+IFBhcmRvbiBteSBpZ25vcmFuY2UsIGJ1dCBpZiB3ZSByZW1vdmUgdGhpcyBsaW5lOgo+Cj4g
aHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvYmxvYi9hZTI4NDUzNjhh
Y2Q3OTY1MGNjNDgzYTk4NTdiOTI3MjVjMDE3NGQwL2NvbmZpZ3VyZS5hYyNMNDkKPgo+IFdvdWxk
IHdlIG5lZWQgdG8gZmluZCBhbmQgZml4IGFsbCBvY2N1cnJlbmNlcyBvZiBIQVZFX0FTTV9MRFRf
SCA/IFRoZQo+IGJ1aWxkIHN5c3RlbSBpcyBzdGlsbCBhIGJpdCBteXN0ZXJpb3VzIHRvIG1lLi4u
CgpZZXMsIHdlIHNob3VsZCByZW1vdmUgYWxsIHN0YXRlbWVudHMgdXNpbmcgaXQuCgpEb24ndCB3
b3JyeSwgYXV0b2NvbmYgaXMgYSBiaXQgb2JzY3VyZSBmb3IgbW9zdCBvZiB0aGUgcGVvcGxlLCBl
eGNlcHQgCmZvciB0aGUgYXV0b2NvbmYgZGV2ZWxvcGVycyAobWF5YmUpLCBidXQsIGluIGdlbmVy
YWwsIHRvdWNoaW5nIApjb25maWd1cmUuYWMgaXMgbm90IHRoYXQgZGlmZmljdWx0LiBBbGwgdGhl
IHRpbWVzIGF1dG9jb25mIHZlcmlmaWVzIGEgCmhlYWRlciB2aWEgQUNfQ0hFQ0tfSEVBREVSU19P
TkNFLCBhIGNvcnJlc3BvbmRpbmcgdmFyaWFibGUgaXMgY3JlYXRlZCAKaW5zaWRlICJjb25maWcu
aCIuIFRoYXQncyBtb3N0bHkgd2hhdCB5b3UgbmVlZCB0byBkZXZlbG9wIExUUC4KCkZvciB0aGUg
cmVzdDogCmh0dHBzOi8vd3d3LmdudS5vcmcvc29mdHdhcmUvYXV0b2NvbmYvbWFudWFsL2F1dG9j
b25mLTIuNjcvaHRtbF9ub2RlLwoKQW5kcmVhCgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
