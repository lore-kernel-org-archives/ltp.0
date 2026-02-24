Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD928F4BB89
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 21:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771967034; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=V/Lxn1AagJHPGGlAusu8Ts30IW5WskrSj5o+4G1qJYI=;
 b=QeK4lIEEn+3miE+WLydkyLXiZTRHHNKtnQDOUzDF8DnTYKqGNe9KndHk2w9kqvxHAfIwO
 b896XxaUnJ6MN14FglJUrFRg/JyC4AyhcSV3nKC38IqOAM1y7snjYFV0QnFHDm93DxUVynN
 e36Gtz9d598d/3zXImbYg7Oj2DSUuBs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 360003CD81F
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 22:03:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A3BC3C54C1
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 22:03:30 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A82CE200B63
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 22:03:29 +0100 (CET)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b8871718b00so1002904266b.3
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 13:03:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771967009; cv=none;
 d=google.com; s=arc-20240605;
 b=aDIhlZeTyFdLQcaiq5becWGqxkpmZqSbOdQgNzYpgHW2sn7AOWX9uBh75QoPUNWux7
 YLe5j8TLC+O3EohrdazpOsdfZKJtnSQ5IEBq6AaT/agkISMoMpoMok1qI9q2aCmsy5u+
 S4nUub1altM41h0YlNNNtuLkL5jX672jN19t6skbChQw+DeiX4KXTOsFImv269XygPoY
 18F+XcN+rNB00Jy4uJ1JPpyiplSqyzLd9AGKbtse2/FHipe0ICcwQ3JGwg02xYXbl9ck
 hJW7zqXd9pG8A7aaQNHkHpQnSCGeVMpEci4gmvkPjj/NhHsPdafj1xm6uWAirktbt4X2
 ttAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IRpdZDe35Co4SZu86g9jBR9OWToftqc9EqOGHyCaEb0=;
 fh=bpgMwdhj2V5dFHhBya/LAx01zapCp12LRM5OHjvBEmU=;
 b=Cw8QBaPzEiPgfkBGn5sRWuiDZdr23kw72YJN6pIgGKF9QXZytPpUGKpeQRFSlm3+eq
 +eHFh4nmQVwDBI9n2JJ89qUWM1EnX+oLpf1QyLDZ3Gr/iWbAlzXKk0pY8yOs3SI5YTBr
 gmHyKxuQgKOHIeF0msM03YkcQ3wWfO6EPHeMBgDB6uMoy/lg35zuIsxSbBQ9jMd+9/Gk
 WXRcmIkSXTKoAyhP4cWzHQYOJ7Onvs4FRioYH/gPYnycFynGQvKJAbId4GJSIQZAjiUt
 d+Wz2EHMj0Tx4mdBLIUHcf6YM3EDMUVC+BmQPsWjaPXwPWUghmUJPJIbh8DBK7sZHoRa
 4XQg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1771967009; x=1772571809; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRpdZDe35Co4SZu86g9jBR9OWToftqc9EqOGHyCaEb0=;
 b=GVx4Q8Iqg3f+Dn3E55tIyi40/hXdwtS2WuR9q51d2kcoi7V2avB/UJUlNJrEB5Erm+
 tDXWSkEZVJqMbjBLMfPUVri9ww6LHWq1k7iZxyopNpuaKf5UzpJRDlZYsanmmBJ++vpk
 6P0myU4fTiffBGwSkqMnTivG69lzNCnHTifhXYURMJTaPIVUW2CZhTKKP4qgZDR4f80M
 ybhYwrj6f+vlS0UJnR+EmptG6AouQbJNXUk6o8lAU9xKcSqhbxqHdF9IUS0u6gNEHC1A
 AMg5BvSz6MGVqGDpeUIIUwvnMIsCG58vUqLQePgzvnmV6J+TudJAM4jR2BFuTqk8O6MQ
 q4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771967009; x=1772571809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IRpdZDe35Co4SZu86g9jBR9OWToftqc9EqOGHyCaEb0=;
 b=KVFD45xKqZ6blshvZGbIdt1Q+b05hAGXgvfQAuDfDsZtuWD3DzyMu9DgU9opu/j7Zz
 /hBdHT6DMi+T6m0QzT2syNQdoK6eW6ephBYtDpxvR4MqezI1pIp8USxXjEF7vgm/fnBx
 ALO9oE/7h4beLMLiKwBNvHs/8HaWrC89ih4bAwB9E1SsEYNBsNaXJmrV3I1VgPSgZzE5
 JPR1ZsrFH9u+MrjFTABSLbG/dolgb9vSadqELJKJulckgpAOnWkR2wdHheHEQIdh+sTm
 ZEHYSpiHuMSjeQgrKy9p3TWdq1GPCFE6X9LCvlD8Ryz1XEdGPllmXtTE+SEjmC7pbqLs
 RWZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4JY6I/+MaFs/rdmpU/dWW7IIhhGdw3JYJzuJ482kZLlzWeuMzkWptV4dm6BKUoSibE+Y=@lists.linux.it
X-Gm-Message-State: AOJu0YybIShjO3AvRkb4OVztbOj1A4ZF0V4LJIoOKCAZKzO2mtt8VBg3
 tBTsgJkmzh5jfHEBFjrXSvoOU1lnBMh2/u2ItHMM+Et/6aoWLMYU8+TAA+SXgle5uqcen+cBB2Q
 4zRpn0n4x3MvO0MUatoVzYc2Dq3ct2Ry6n++VMIk=
X-Gm-Gg: ATEYQzw1wWTMQF9tMBLwcoY8Laf6S1+zKTBCnsU2zx0PaKdErYkn472kYfjDmKju6bt
 fkFWycLaHD3PFe581fGT8aNPt6WnkxIH0yfEw8WP9AxUQFY8UQqIOSEjfKX73uheo0AuSSxNiX2
 nRWkeSakKgkkTBVNTgQYVYJVS4SZ+LDCPazLihJE242ONMcMmAyJaurBUoocOK76obzBpMVn3TS
 b/RN7c8gB4MeSf0sz/+aY5V2FXpUUjSqCtSGKw/YhDramx5Tvq1yWQDGpHB3MZnPFYarFrmAFVl
 h99vsCjPeslSpswyLq8/IRnG2zkGqaM9HTsA
X-Received: by 2002:a17:907:84b:b0:b87:701d:341a with SMTP id
 a640c23a62f3a-b9341bcd089mr3614466b.25.1771967008639; Tue, 24 Feb 2026
 13:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20260224104544.101292-1-japo@linux.ibm.com>
In-Reply-To: <20260224104544.101292-1-japo@linux.ibm.com>
Date: Tue, 24 Feb 2026 13:03:16 -0800
X-Gm-Features: AaiRm509ORQkGVsU3If4PPB-dIpfByRWpB4Vg43k6I7vpcXQiSztqHCnMd_5BVA
Message-ID: <CANDhNCrrZY=5bvRQGGJsigjwRNmDz8shbtM-Vtn5UkdRDGU_uA@mail.gmail.com>
To: Jan Polensky <japo@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] sched_football: harden kickoff
 synchronization on high-CPU systems
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
From: John Stultz via ltp <ltp@lists.linux.it>
Reply-To: John Stultz <jstultz@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBGZWIgMjQsIDIwMjYgYXQgMjo0NeKAr0FNIEphbiBQb2xlbnNreSA8amFwb0BsaW51
eC5pYm0uY29tPiB3cm90ZToKPgo+IFRoZSBzY2hlZF9mb290YmFsbCB0ZXN0IGhhcyBiZWVuIGlu
dGVybWl0dGVudGx5IGZhaWxpbmcsIG1vc3Qgbm90aWNlYWJseQo+IG9uIHN5c3RlbXMgd2l0aCBt
YW55IENQVXMgYW5kL29yIHVuZGVyIGxvYWQsIGR1ZSB0byBhIHN0YXJ0dXAgb3JkZXJpbmcKPiBo
b2xlIGFyb3VuZCBraWNrb2ZmLgo+CgpJJ3ZlIG5vdCBoYWQgdGltZSB0byBjbG9zZWx5IHJldmll
dyB5b3VyIHN1Z2dlc3Rpb24gaGVyZSwgYnV0IGl0CnNvdW5kcyByZWFzb25hYmxlLgoKVGhhdCBz
YWlkLCBJIHdhbnQgdG8gd2FybiB5b3UgYW5kIGVuc3VyZSB5b3UgYXJlIGF3YXJlOiB0aGUKUlRf
UFVTSF9JUEkgZmVhdHVyZSBpbiB0aGUgc2NoZWR1bGVyIGJyZWFrcyB0aGUgUlQgaW52YXJpYW50
CnNjaGVkX2Zvb3RiYWxsIGlzIHRlc3RpbmcuCgpJIHNlZSB0aGlzIGFzIGEgYnVnIHdpdGggdGhh
dCBmZWF0dXJlLCBidXQgdGhlIHNjYWxhYmlsaXR5IFJUX1BVU0hfSVBJCmFsbG93cyBmb3Igc2Vl
bXMgbW9yZSBpbXBvcnRhbnQgdG8gZm9sa3Mgd2hvIGFyZSBkb2luZyBSVCB3b3JrIHRoZW4KdGhl
IG1pcy1iZWhhdmlvci4gIFN0ZXZlbiBhbmQgSSB0YWxrZWQgYXdoaWxlIGJhY2sgYWJvdXQgc29t
ZSBpZGVhcyBvbgpob3cgd2UgbWlnaHQgYmUgYWJsZSB0byBkbyB0aGUgcHVsbCBpbiBhIG1vcmUg
ZWZmaWNpZW50IHdheSB3aGlsZQpzdGlsbCBob2xkaW5nIHRoZSBpbnZhcmlhbnQgdHJ1ZSwgYW5k
IEkgaGF2ZSBhIGJ1ZyB0byB0cmFjayBpdCwgYnV0Cml0cyBub3QgYmVlbiBoaWdoIGVub3VnaCBw
cmlvcml0eSB0byBnZXQgYmFuZHdpZHRoIHlldC4KClNvIHlvdSBtaWdodCB3YW50IHRvIG1ha2Ug
c3VyZSB5b3UgZGlzYWJsZSB0aGF0IGZlYXR1cmUgYmVmb3JlIHRlc3RpbmcgdmlhOgojIGVjaG8g
Tk9fUlRfUFVTSF9JUEkgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9zY2hlZC9mZWF0dXJlcwoKdGhhbmtz
Ci1qb2huCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
