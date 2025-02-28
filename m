Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4F1C19776
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 07:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740728750; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=NFggX4G7EUsvRWE7uVbzBoam3hwUYGvJxeGYPWgglo0=;
 b=eOx5UXDSfI8dL3gYBRUNdMQiEct7Y8i+UyQx5WNXilr/5XK5QCuPmb34iSiGQPivTgZfD
 3wHGIvq4Y2ionxE6IiIU1W9He4OE3VHNlbbCw6czFVAZGuYpN/C9shit4pjhvgbYBkVR8rF
 yPWe2Yo1GSjC8q+qLmgmvfPtCMhmnXE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C51E3C9E12
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 08:45:50 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7024B3C280D
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 08:45:28 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4CF8C630F9D
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 08:45:27 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so12503885e9.0
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 23:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740728726; x=1741333526; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gVP+HouuuZ6/QzfWxlsc9qCK20ehfc6pdlzKbcw6xOE=;
 b=DFzhova1XUz4nNApP6q6qoILhsH8C0SJ2y/+ylseh8i3iFHErOWGLRuBozKiM6+q+0
 tSUKZn8MKrcgF+1BG6lZTyn5iVGgr6DfKjVzOWNw5FcT1ScZ+M2v860QEe2aFN9HJusl
 SfVuQgeS5s2E8HJ2eRDi2wBRidvjYtOZKw6en3MXbBLDTa9Rsh+9S1L1R06wcJVLrH5X
 H1vDRLfmwVnQiJTUD0IGfb/gJWxIQISSWk79XLmu2f50x8lghpC/o2q0XqmyrGh+VNoP
 59Tc87GzsvxQJYDnSTqXCBe19yWCVFB0u3J+kEdCPehvV3I8M7k6vOMxo7gHB4os4AkO
 m6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740728726; x=1741333526;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gVP+HouuuZ6/QzfWxlsc9qCK20ehfc6pdlzKbcw6xOE=;
 b=F+LtmQb3lhBeyam5/Sw5NSl0uiwklxoq0+pm3fA0s2XLNBVLgjjhOboLwYNRmePMr0
 N5rVBz0WQRWk/6OAAGsC4+Uef4bGSlrxrDKzo3Efp6JD+6wPQ4qrdz8sRH6x2n4PplsA
 SiwQ4oMZxq88x4l1pcoTz5MVXEK973jS4nqvKnQRrAER0pgV9w7m6QUEgrrOIbt6+U/6
 DLFtJ9cRxTdzVfJ8rlpbrKx1u3s50Ox60xIzBb3FGsMWQtbrvDGAieSFUsCYGbOrWp/s
 WZ6wTDZowxTItU6DVAfy9/ksqFG2Ch8GyzYn2iUCtYCsXt17I604FesnQ/WgsWZBBv6W
 2UPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzYC4hgKoeT3MdmWs3m3EXKznwK8ZUbf43bw9scJZqkaV0RRBFbU7+UqcNdC1a2Wo1UXU=@lists.linux.it
X-Gm-Message-State: AOJu0YyJ9D2fq7OOo44u/BpViiqqGtlk4tfBHuhX/FYYgbYawSWt7V1e
 CabqMdvcP0Qrec+dRIS3KuMKx/thbaY28JkqsbXO+4CdYL7dm4lmtC6LfgEY1/8=
X-Gm-Gg: ASbGncvQqVLqbl0DfY/w2Hv/SMWlMjoGpyit7WHVVzmK3966VJvXpd/f5PSWn7gYSph
 bx2MP17WtNTh3etzvD4MADQNhNKVJ97owLbWsg9QPjebzypjTgWjh0io0LTfQoledrQcz5UIEbY
 q0N8o9LvJWMd093qtr+Rkg0PIpawXwEYy482zw73mKbLX7h05+kGenYGcHfugF+E7/mb1Ui5tkF
 8jCPfmsh74nYAPkqnMiJfb0FtlDK6jwjePfkyEFLBlG7Po4aftxoCinZSvFT6PEe1nlimVJOe6C
 KWHXikj/bEvEktvHfnU4s2wCBNEpa4ImiqI=
X-Google-Smtp-Source: AGHT+IF7kHIrNSdJRNH2lY/ZS4OldfQ8Z0JbriIqPEr6YiRYRB9xjMTs1a7fBmK3ueKkazRpkc5cpg==
X-Received: by 2002:a05:600c:4ecf:b0:439:9a40:aa03 with SMTP id
 5b1f17b1804b1-43ba66da2b9mr15848625e9.2.1740728726612; 
 Thu, 27 Feb 2025 23:45:26 -0800 (PST)
Received: from [192.168.1.91] ([151.71.237.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52b947sm78969295e9.2.2025.02.27.23.45.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 23:45:26 -0800 (PST)
Message-ID: <54cd690b-dd2a-4285-8d53-5aef05be3d6c@suse.com>
Date: Fri, 28 Feb 2025 08:45:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwan@redhat.com>, Chunfu Wen <chwen@redhat.com>
References: <31878632-52fe-4aed-8018-8e30ebeae52d@suse.com>
 <20250224030743.1567840-1-chwen@redhat.com>
 <CAAA2g-1m5Hfq9nygiCnFFwt6Axgxjj3dO=2Ei_-cgSw3dT60Bg@mail.gmail.com>
 <CAEemH2cpdqSViHfDcRfFqsWtz4kkrkhU4DymfXW+5REPEMvYTw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2cpdqSViHfDcRfFqsWtz4kkrkhU4DymfXW+5REPEMvYTw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Add test case to cover the setting resource
 limit64 for process
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
Cc: Charles Shi <cheshi@redhat.com>, ltp@lists.linux.it,
 Irene Diez <idiez@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgp0aGFua3MgZm9yIGNoZWNraW5nLCBidXQgd2Ugc3RpbGwgbWlzc2VkIGEgY291cGxl
IG9mIHRoaW5ncyB0byBmaXgsIGxpa2UgCmluZmluaXRlIGxvb3AgdGhhdCBtaWdodCBjYXVzZSBz
b21lIGlzc3VlcyBhbmQgaXQgc2hvdWxkIGJlIHJlcGxhY2VkIAp3aXRoIGNoZWNrcG9pbnRzIGFz
IHBvaW50ZWQgb3V0IGJ5IFBldHIuCgpCZXN0IHJlZ2FyZHMsCkFuZHJlYSBDZXJ2ZXNhdG8KCk9u
IDIvMjgvMjUgMDQ6NDEsIExpIFdhbmcgd3JvdGU6Cj4gT24gV2VkLCBGZWIgMjYsIDIwMjUgYXQg
OToxNeKAr0FNIENodW5mdSBXZW4gPGNod2VuQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4+IEhlbGxv
IE1haW50YWluZXJzLAo+Pgo+PiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgbWUgcmV2aWV3IHRoZSBW
NCBwYXRjaCB3aGVuIHlvdSBoYXZlIHRpbWU/Cj4+Cj4gSSBoZWxwZWQgcmVzb2x2ZSB0aGUgY29k
ZSBjb25mbGljdCBhbmQgcHVzaGVkLCB0aGFua3MhCj4KPiBMaSBXYW5nCj4KCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
