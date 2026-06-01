Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416C8CD6E4C
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 06:48:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 799113E48B9
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 08:48:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C0F73E483B
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 08:48:29 +0200 (CEST)
Received: from mail-dl1-x1243.google.com (mail-dl1-x1243.google.com
 [IPv6:2607:f8b0:4864:20::1243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F09391000196
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 08:48:28 +0200 (CEST)
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-13621cca8f5so6963226c88.0
 for <ltp@lists.linux.it>; Sun, 31 May 2026 23:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780296507; x=1780901307; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uj/tGBdbd7UGfpMf4grfzaJ8IDWVDtsgMhyEVsoZ98A=;
 b=cYnM7Qr+78YZ30Z3O4OVJ+E2xt+0nn59PCm/0mTzdxDXWrNEwCHRu7buwXdTKYUkRV
 TZP0nV/jLGZZgrn8pZ/Eia11MzabuEA8JxW94Wv+rqvlS8tTUlB5u5KVL2Hdl/jwmMYX
 y5Hryb/B3vpP4oHAHBSNXpLVdxNCu0a2/vwpS6+A1NhVC0NS04tknERMQAQyNA4EQdqd
 FsER7jwPj5BUeoiJY2On2+zeiQNCfHImhfGD0N54N1FQ5C4tJNj3HuJKV594zJwfTUp3
 g/hFU9dyFmrgoamx/eMud6ZJ5p3g2+DvgHoV4dy+9Dh/LRYb085YPG+9EPynrgQA566R
 cdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780296507; x=1780901307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uj/tGBdbd7UGfpMf4grfzaJ8IDWVDtsgMhyEVsoZ98A=;
 b=eeJ0Ku/CmC4pyJQoZ90MgHN6h31XMziiZffBvIjPP6WrG8451D21UMK+GfiTGiHeD4
 L9u9rbXoTqpirfuTmVz5ggfsOR4xfno4hWBwQuxoD2RlqPPZTQyPm99/XoU/D3bBpcoY
 46soNBcLfI7k2cTyb3qSBPpQ+OQxeoLUwMMvKVRd5Z0f3uM6lXqs5RjYHrqUb4kuyupD
 w86ww+TpD2YS5gP2jTIR1G0c3h+W40cJ/+91o5abjWsE/uP6vPTBV9JPM6Turgr67QB0
 Rg5ud9W3q6d3mvnvlBIwC86T8yXjS20fezc4E43MytrYfLKJgAMxqOkeqmYHV2I4p8NM
 liBw==
X-Gm-Message-State: AOJu0YwK2bPeKu8z6MVwL5AWNgfAsmTA5j8sVx7Dmf0OBUlshYQ9l75U
 P+8LBbNKQAPcnE/x9Rgld36aQDgffNO4W0I2kPZXIPjihPzFkTjcCnzq4FV9VUYg
X-Gm-Gg: Acq92OFps//7k1IyzmhORHIorASe8U1aWLH+ueDpuIRnYNeGSX/pRpBQLhRSVazI/eP
 JKvNl6b2nsvgZzDw4mjYH2f9y4RBlPVocmvr1vU6Al/eQdSv8M6MS/IdORVvOkfDSwPIl2LXmoL
 WiG71eur8X3hGu3d9QqQ00Tl7++GHWHHgoVGFnM5ccAHEiMr1kwPp/yj2NW+K9bo2EpJkQL5plB
 HV5gXvZdI4sB7GMoCITF8FOpQ7zGqoXiqDnNwo97Io4wT4Bo/SgzoisPam+dNBTr4GAd3GIC+vj
 bQ8njAsJggPY0NUZzsYvzPkjEcDj8Q/gAkpfjN8IUBhpzZT0xQoNZnt0z0xjeeTwyyg8wU2iSFq
 pWaJjSuk97stg3zIbhJxaCCDjlShUAb5kpAy7GvJvHZdE0DtdXmrhbH9/8GG86HTktpZ4cquYVm
 k/hvC9YKTj4j+9Nmpdfy1yjbUqWeiksTNHMv5J2liuxq1TMl2zEDg3RCzV8C+rY4QUWJ20R86YE
 uc/sWyCKWuJEzL26foUhv8oySWHQ/dIkMuP0MMYLFVdi3COUb5eGiosGl9Z/v8=
X-Received: by 2002:a05:693c:2c0e:b0:304:e450:67e0 with SMTP id
 5a478bee46e88-304fa4c81d5mr4411465eec.10.1780296506914; 
 Sun, 31 May 2026 23:48:26 -0700 (PDT)
Received: from
 runnervm3jyl0.dh3qtjx5f5oe1ftyai53w2ynke.dx.internal.cloudapp.net
 ([172.184.175.145]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c10c1sm7837766eec.1.2026.05.31.23.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 23:48:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Mon,  1 Jun 2026 06:48:24 +0000
Message-ID: <20260601064824.4235-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531124540.70788-2-sachinp@linux.ibm.com>
References: <20260531124540.70788-2-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fs/acl: Add ACL_USER_OBJ permissions test
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

SGkgU2FjaGluLAoKVGhhbmsgeW91IGZvciB0aGlzIHNlcmllcy4gQ29udmVydGluZyB0aGUgb2xk
IG1vbm9saXRoaWMgdGFjbF94YXR0ci5zaCB0bwptb2R1bGFyIEMgdGVzdHMgdXNpbmcgdGhlIG5l
dyBMVFAgQVBJIGlzIGEgY2xlYXIgaW1wcm92ZW1lbnQuIFRoZSBjb2RlCnN0cnVjdHVyZSwgaGVs
cGVyIGxpYnJhcnkgZGVzaWduLCBBQ0wgbG9naWMsIGFuZCB0ZXN0IGNvdmVyYWdlIGFyZSBhbGwg
c29saWQuCkkgZm91bmQgdHdvIGNvbW1pdC1tZXNzYWdlIGFjY3VyYWN5IGlzc3VlcyB0aGF0IG5l
ZWQgdG8gYmUgZml4ZWQgYmVmb3JlIHRoZQpzZXJpZXMgY2FuIGJlIGFwcGxpZWQuCgotLS0KCltQ
QVRDSCA3LzhdIGZzL2FjbDogQWRkIGV4dGVuZGVkIGF0dHJpYnV0ZXMgdGVzdAoKVGhlIGNvbW1p
dCBzdWJqZWN0IGFuZCBib2R5IGJvdGggZGVzY3JpYmUgNiB0ZXN0IGNhc2VzOgoKICBBZGQgeGF0
dHJfdGVzdDAxIHRlc3Qgd2l0aCA2IHRlc3QgY2FzZXMgdG8gdmFsaWRhdGUgZXh0ZW5kZWQKICBh
dHRyaWJ1dGUgb3BlcmF0aW9uczoKCiAgMS4gU2V0L2dldCB4YXR0ciBvbiBkaXJlY3RvcnkKICAy
LiBTZXQvZ2V0IHhhdHRyIG9uIHJlZ3VsYXIgZmlsZQogIDMuIExpc3QgeGF0dHJzIG9uIGRpcmVj
dG9yeQogIDQuIFJlbW92ZSB4YXR0ciBmcm9tIGZpbGUKICA1LiBCYWNrdXAgYW5kIHJlc3RvcmUg
eGF0dHJzCiAgNi4gVmVyaWZ5IHhhdHRyIG9wZXJhdGlvbnMgZm9sbG93IHN5bWxpbmtzIHRvIHRh
cmdldAoKQnV0IHRoZSBhY3R1YWwgaW1wbGVtZW50YXRpb24gaGFzIG9ubHkgMiBzdWItdGVzdHMg
KC50Y250ID0gMik6CgogIGNhc2UgMDogdGVzdF94YXR0cigpICAgICAgICAgIOKAlCBjb3ZlcnMg
aXRlbXMgMSwgMiwgNAogIGNhc2UgMTogdGVzdF94YXR0cl9iYWNrdXBfcmVzdG9yZSgpIOKAlCBj
b3ZlcnMgaXRlbSA1CgpJdGVtcyAzICgiTGlzdCB4YXR0cnMgb24gZGlyZWN0b3J5IikgYW5kIDYg
KCJWZXJpZnkgeGF0dHIgb3BlcmF0aW9ucwpmb2xsb3cgc3ltbGlua3MgdG8gdGFyZ2V0IikgYXJl
IGRlc2NyaWJlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgYnV0IGFyZQpub3QgaW1wbGVtZW50ZWQg
YW55d2hlcmUgaW4geGF0dHJfdGVzdDAxLmMuIFRoZXJlIGlzIG5vIGxpc3R4YXR0cigyKSBjYWxs
CmFuZCBubyBzeW1saW5rIGNyZWF0aW9uIG9yIHhhdHRyLXRocm91Z2gtc3ltbGluayB0ZXN0IGlu
IHRoZSBmaWxlLgoKVGhlIHRlc3QncyBvd24gZGVzY3JpcHRpb24gYmxvY2sgaXMgYWNjdXJhdGU6
CgogICogVGhpcyB0ZXN0IHZhbGlkYXRlczoKICAqICAtIEV4dGVuZGVkIGF0dHJpYnV0ZXMgc2V0
L2dldC9yZW1vdmUgb3BlcmF0aW9ucwogICogIC0gRXh0ZW5kZWQgYXR0cmlidXRlcyBiYWNrdXAg
YW5kIHJlc3RvcmUgb3BlcmF0aW9ucwoKUGxlYXNlIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2Ug
dG8gbWF0Y2ggdGhlIGFjdHVhbCBpbXBsZW1lbnRhdGlvbi4KRWl0aGVyIGRyb3AgdGhlIHVuaW1w
bGVtZW50ZWQgaXRlbXMgZnJvbSB0aGUgbGlzdCAoYW5kIHNheSAiMiB0ZXN0IGNhc2VzIiksCm9y
IGltcGxlbWVudCB0aGUgbWlzc2luZyBjYXNlcy4KCi0tLQoKW1BBVENIIDgvOF0gZnMvYWNsOiBS
ZW1vdmUgb2xkIHNoZWxsLWJhc2VkIEFDTCB0ZXN0CgpUaGUgcmVwbGFjZW1lbnQgdGVzdCBzdW1t
YXJ5IGluIHRoaXMgY29tbWl0IGlzIGNvcGllZCBmcm9tIChvciByZWZlcnMgdG8pCnRoZSBpbmFj
Y3VyYXRlIGNvdW50IGFib3ZlOgoKICAtIHhhdHRyX3Rlc3QwMTogRXh0ZW5kZWQgYXR0cmlidXRl
cyAoNiB0ZXN0cykKCnhhdHRyX3Rlc3QwMSBoYXMgLnRjbnQgPSAyLCBub3QgNi4gVXBkYXRlIHRo
aXMgbGluZSB0bzoKCiAgLSB4YXR0cl90ZXN0MDE6IEV4dGVuZGVkIGF0dHJpYnV0ZXMgKDIgdGVz
dHMpCgotLS0KClZlcmRpY3Q6IE5lZWRzIHJldmlzaW9uCgotLS0KCkNvZGUgcmV2aWV3IG5vdGVz
IChubyBhY3Rpb24gcmVxdWlyZWQpOgoKLSBhY2xfbGliLmggaXMgY2xlYW46IHRoZSBzdGF0aWMt
aW5saW5lIGhlbHBlciBkZXNpZ24sIFNBRkVfRk9SSy8KICBTQUZFX1dBSVRQSUQgdXNhZ2UsIHNl
dGdyb3VwcygwLE5VTEwpK3NldGdpZCtzZXR1aWQgb3JkZXJpbmcsIGFuZAogIF9leGl0KGVycm5v
KSB0aHJvdWdoIFdFWElUU1RBVFVTIGFyZSBhbGwgY29ycmVjdC4KCi0gQWxsIHRzdF90ZXN0IHN0
cnVjdHMgY29ycmVjdGx5IHNldCBuZWVkc19yb290PTEsIG1vdW50X2RldmljZT0xLAogIGZvcmtz
X2NoaWxkPTEsIGFuZCBsaXN0IGFwcHJvcHJpYXRlIEFDTC1jYXBhYmxlIGZpbGVzeXN0ZW1zLiBU
aGUKICBuZWVkc19jbWRzIGd1YXJkIGZvciB1c2VyYWRkL3VzZXJkZWwgaXMgYSBuaWNlIHRvdWNo
LgoKLSBBQ0wgc2VtYW50aWNzIGluIGV2ZXJ5IHN1Yi10ZXN0IGFyZSBjb3JyZWN0OiBBQ0xfVVNF
Ul9PQkogaXMgdW5hZmZlY3RlZAogIGJ5IEFDTF9NQVNLOyBBQ0xfT1RIRVIgaXMgbGlrZXdpc2Ug
bWFzay1leGVtcHQ7IEFDTF9VU0VSL0FDTF9HUk9VUC8KICBBQ0xfR1JPVVBfT0JKIGFyZSBjb3Jy
ZWN0bHkgcmVzdHJpY3RlZCBieSB0aGUgbWFzay4gVGhlIGFjbF9pbmhlcml0MDEKICB1bWFzaz0w
ICsgbW9kZT0wNjY2IOKGkiAwNDQ0IHBhdGggbWF0Y2hlcyBQT1NJWCBBQ0wgaW5oZXJpdGFuY2Ug
cnVsZXMuCgotIFRoZSBNYWtlZmlsZSB3aWxkY2FyZCBidWlsZCBhbmQgcnVudGVzdC9mcyBlbnRy
aWVzIGFyZSBhbGwgY29uc2lzdGVudC4KICBUaGUgb2xkIHRhY2xfeGF0dHIuc2ggaGFkIG5vIHJ1
bnRlc3QgZW50cnksIHNvIG5vIHJ1bnRlc3QgcmVtb3ZhbCBpcwogIG5lZWRlZC4KClRoYW5rcywK
TFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
