Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F00D64086
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 07:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765958332; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=bjcD2zzLzIHgI6tFTvbj2FfSuqCBPOSJ2/eI3jwPkyY=;
 b=WHspeSNws4eqk15NDoddjO6deo1rNH9Y3Zh3kBAUQRvpOROpJXIABWfQa9WHtMXzeZqCu
 OCZaws/U4Bffvswrhb2kEeHP1QtVbzxnzMXbGnRNy/WfWjjUk4/MCu3RdNuHCJ8KL4kq0tr
 k/G1k3zXgPKg8QX50HiQRWocQn6ERqQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14BAA3D039B
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 08:58:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40CD13D038E
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 08:58:29 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2D95B10005FB
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 08:58:24 +0100 (CET)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so1546815e9.1
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 23:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765958303; x=1766563103; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39g9fPiJQ+qZBZKOao+3Z0OZ/R4rAXBZazwFFMjLhQI=;
 b=IdGtnbTkWwbfTPf5j03PTwKIaHjGDD824s1s781oWty5qv5wsgx24XBtEY2913JEvx
 06FUwUOzZhXagkfbvWKeDj434Yuxs6W/rruxRca9UhBzF7qNhaoVZ70xZFzzdT7UyAzh
 HhMwfgiM9tO+rd/F4LgnUrmfHJHBQcgL9lHWWyZUpWWkyRUPSfNYs+zgnlxWshz9/hlH
 Q53HYJ+Yar2kzy693V0NGol7Yfm2JiwriCbaUTGJ676GN6P+DbxzGxclE4YwTopMPHY7
 76jhE6dc46pl6Z9LbK4Kiae3S+pk5CaHBHplYuaB/dP20kM7U6FSNGljDQk4vA6C0n2S
 EXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765958303; x=1766563103;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=39g9fPiJQ+qZBZKOao+3Z0OZ/R4rAXBZazwFFMjLhQI=;
 b=l4OUNAyprIjVve/Qgr0auADGlRO2Cbgj4eYFsBsk3driKmXpZGOW/iYazLQ2VqBUL1
 2XcWq4E42tzewmzBrQv24xpiDyr6YO4n8KjUDvTka+RDvXpxdxRDOv6/HnH76uRwHrGC
 FXhT7OHi8QbGIXylCTlcrphGYF1lBmP1AHzbFCsglSSbV98NPizatx9FoHOVPlFVRh01
 +wRbZHkIjlGUgZcdi3R4yT2T6VN0+A4obsB0CPE1LhsH8WZfwmW+v8CHivvanI74+GfY
 fevQOa6ppJU0i3ESWjR0o6rxeIF24fT7USuCpohac+WzibrOFzMXI/I8tUk6SkvPZ7kd
 3JRQ==
X-Gm-Message-State: AOJu0YyfoX1bB4jE8be8Rdg/Va1P+GGV20dP051xc23SqcyutPCqwSGW
 L0EyUlG7w2/ZDSFxXrAUnq1UwvUGiD1zJW2EzDvIFKTWnLzISUO+JXxME/f32mvqGS8=
X-Gm-Gg: AY/fxX4KVbJaBF5OMip1xpJSyQIYhPRxnrYoAukc5tsqG3XvAJCm2HsR0gA/g9cbiCO
 T4eM3cFePuXJdxICLPpNYH8AKTuD43aTTBXzaXmbEEshwk+K0Z8n1XMoY5KPkhgkFu6dc5BqeP2
 wyi4jJh/Ziay1rKwyfJshSZ0Op9BEyQaiIAZxxnGszfNsSgmUsEowH/tW+KOJIF/jof9fxHoHXJ
 CHc3KlfFIDUJLJWJNetZ98bdsI6rR4AAD3HqgFpkB9U/3UapSY0dztCAgdJ0NPAuHW6QL7eFj5B
 lNiK5QfQoXaS2EjlRsXzezhYlJDp9lRMpY9t17a7GuXZvVOhOd+iPcsNb9cwTrIBpkpwpiY4qwj
 NOeEPjeunqZ5SxBd2nX+FZXiy9Ws7qYAdZd7eTKKRUKI47XBoRAREKTv93IhwiqDlockPUxdCuF
 mhP0/rj7Sq+RWimZFGk6oXCI3nSb/s2vq2NQqxOXliVFmElb0eosYBZCqws3Y6xfPsD6LR
X-Google-Smtp-Source: AGHT+IH8hT79rgOjt3B4hf9L5K/ACsHI946TN0l6bsYQK0C5JRZoeJECO4divEc53afWIz/cpfzV1A==
X-Received: by 2002:a05:600c:4f48:b0:477:9fa0:7495 with SMTP id
 5b1f17b1804b1-47a8f2c3de3mr193490115e9.14.1765958303481; 
 Tue, 16 Dec 2025 23:58:23 -0800 (PST)
Received: from ?IPV6:2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333?
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bd8eb1f26sm30124075e9.0.2025.12.16.23.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 23:58:23 -0800 (PST)
Message-ID: <7d12c14f-4654-4248-b478-f57d721aba9a@suse.com>
Date: Wed, 17 Dec 2025 08:58:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chris Wailes <chriswailes@google.com>
References: <CAKfqHepUCKimv1xXxsAWw3bZRg=6VWBh7yyWOi=zuNaM5d9Eww@mail.gmail.com>
 <DEZNCTGEXSY9.1RY75URI3UEQW@suse.com>
 <CAKfqHeptLHymCgRyyUZ64UXoexoPEFsNHxSLa=aME9=U+dBywA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKfqHeptLHymCgRyyUZ64UXoexoPEFsNHxSLa=aME9=U+dBywA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] Update clone3 wrapper signature
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
From: Anrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Anrea Cervesato <andrea.cervesato@suse.com>
Cc: chrubis@suse.com, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ2hyaXMsCgpPbiAxMi8xNi8yNSA2OjUwIFBNLCBDaHJpcyBXYWlsZXMgd3JvdGU6Cj4gQW5k
cmVhLAo+Cj4gVGhhbmtzIGZvciByZXZpZXdpbmcgdGhlIGNoYW5nZS7CoCBXZSdyZSBjdXJyZW50
bHkgYWRkaW5nIGEgYGNsb25lM2AgCj4gd3JhcHBlciB0byBBbmRyb2lkJ3MgQklPTklDIGxpYmMg
aW1wbGVtZW50YXRpb24uIEFkZGl0aW9uYWxseSwgdGhpcyBpcyAKPiB0aGUgc2lnbmF0dXJlIHVz
ZWQgZm9yIGBnbGliY2AncyBgX19jbG9uZTNgIAo+IDxodHRwczovL2dpdGh1Yi5jb20vYm1pbm9y
L2dsaWJjL2Jsb2IvZGVkOWMxZTUyNWYyZDY5YTgxZTYxYzM0YzI5MDc3ZmVkN2RmNjU4Yy9pbmNs
dWRlL2Nsb25lX2ludGVybmFsLmg+Lgo+Cj4gLSBDaHJpcwoKQXQgdGhpcyBwb2ludCwgSSB0aGlu
ayB3ZSBzaG91bGQganVzdCBhZG9wdCB0c3RfY2xvbmUoKSBpbnN0ZWFkIG9mIApjbG9uZTMoKSBm
YWxsYmFjay4KCkBDeXJpbCBXRFlUPwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
