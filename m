Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F9CCD6E55
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 09:43:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5D7D3E619A
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 11:43:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D16B3E1D46
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 11:43:20 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2E22F1400444
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 11:43:20 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-91591f19c30so49512885a.1
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780479799; x=1781084599; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YIgy0m9WMm2kP3H1tIMr/FfZnwjn+/H2Qb3i5+aQdyk=;
 b=H8Xed6GE8uwmzoTiPhnUkqHcR2BwuRafl9G559aRBniih7jPBAVwG5eosT6RR30wOM
 eDuLWtGkLj8ISs8er0dg9wwTv5bOLe83rVQAHnbK36vtjhIZLrCvvZvmeu5IrWbHLmd+
 oEyhf2ZJc2jF0JlPWp/cpGDUkb+Nw0BJUpGHIDgXhODEXaQj1aFbF1HgPEvsnDPTJQTx
 9mm1IgkBXPnR8ne7PuzTgVY9yAzSAzZ9RKDO5KA+U1/u2048EFZ/VTtTQizwlzWW9JRq
 hap0WGwan80Fbh0W0NFb7vB4x5t+1JbheriS9tAo6uW2P0epBSG86PkHsbIr60GIsRuc
 MYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780479799; x=1781084599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YIgy0m9WMm2kP3H1tIMr/FfZnwjn+/H2Qb3i5+aQdyk=;
 b=OaWOYmN0AprUKK2ZmCuD+t/3LBPmXiXgku4YIZi0ZIuaAy85qC/ABRc6Hic5J1tHZA
 Ib7aah46NFT37euq+USutHgV+zUylR7afDBW8cN0XEysR9CiHf9/Z+91uWGZiPfoB5oJ
 E2V+UvcdMhrcjWhuM8HPKsn8VQlxnVvHUGVvVOTf+nyTjK5RlHjQZk06Kvs/3KX3mNhF
 aET7gv/9UKKuBLZE3XcJnPZO1gQ37ikGCq1rkSdOrEta6anJTJ8yZXBhe9/IsjmsmSfV
 v5bpgMC4OnNIOZJJrrf9iqvS/5mynSY9AMiQe3pmEPH/5sW139cVtwmBvwm+ofXjIGxV
 qIVg==
X-Gm-Message-State: AOJu0YxStCF+Hebn2RQgvDwB4MCtQZNBrOMjEVQ3p0X1qEl6Lfj1NEC3
 I5+xgtIqJPhk/0kCPvDK6gKpihYaVGlDwBhOZyFRVqH6ZAog0WPSozPI
X-Gm-Gg: Acq92OGyr1n47oId0jS3FL3gYiQZHvV3yr80Uu0KLqtB6s/QXt3f8BRBDPXXU35MvzA
 feUQi6jKY5W1e9OLYJYwYdYp2Kuh0XnpWgNCiH8AcUmFL3LFtCHPMvdydMDaEdkq3Il286EXunJ
 NTulMBvanqm8MCuJOO98nyqFrmD8/b/T2PGWGt2oaBD8pOPmbrk7EBUZWUR/gJVf88anRWwjoKT
 WyCWVyYQgD1gE56kfVMtwomUEKYSkj9ATT172p6Nak1B3v2mxvKjPkSj5OUGBJu9GnKzI2C6yL5
 VlYPcltQXAbvcPb+K17tK/t8auU4tcNuksHGWIgLSUzlK4wG5Q5FDCWnJpVQ9eAQl0NOl3ZxSlw
 R9p/UutOnUgfFoZeucvrnfvRpPqQjImQ78aUdz7VkPyR6RQmcINstyBGTAG6O4j8HxQoELRXi0e
 bVN1RFlhSx587/ExtpHbQfNcYPDPM1dY/K4YXxotMX3KKR1njfK7PjOKvVhAHgqnxdaJV2NXRcQ
 g9MJWETk9M8Z3EN+n4081GlYsRkmmrrmgfm0hX3iq+V0e6zxsBb
X-Received: by 2002:a05:620a:4506:b0:915:776d:52fe with SMTP id
 af79cd13be357-9158a8456a1mr428130985a.57.1780479798855; 
 Wed, 03 Jun 2026 02:43:18 -0700 (PDT)
Received: from
 runnervm3jyl0.1ggbedqapl0upmictiaqhio5ic.cx.internal.cloudapp.net
 ([145.132.101.198]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00afbcsm197825185a.9.2026.06.03.02.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 02:43:18 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Wed,  3 Jun 2026 09:43:17 +0000
Message-ID: <20260603094318.4334-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603065744.47106-2-sachinp@linux.ibm.com>
References: <20260603065744.47106-2-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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

SGkgU2FjaGluLAoKVGhhbmsgeW91IGZvciB0aGUgcGF0Y2hlcy4gVGhpcyBpcyBhIHdlbGNvbWUg
YWRkaXRpb24g4oCUIHJlcGxhY2luZyB0aGUgb2xkCnVubWFpbnRhaW5lZCBiYXNoIHNjcmlwdCB3
aXRoIGEgcHJvcGVyIHNldCBvZiBtb2R1bGFyIEMgdGVzdHMgd2l0aCBmdWxsIExUUApmcmFtZXdv
cmsgaW50ZWdyYXRpb24uIEJlbG93IGFyZSBteSByZXZpZXcgY29tbWVudHMuCgotLS0KCltQQVRD
SCAxLzhdIGZzL2FjbDogQWRkIEFDTF9VU0VSX09CSiBwZXJtaXNzaW9ucyB0ZXN0CgphY2xfbGli
Lmg6IENvcHlyaWdodCBoZWFkZXIKCiAgVGhlIC5jIGFuZCAuaCBmaWxlcyBhbGwgY2Fycnk6CiAg
ICAqIENvcHlyaWdodCAoYykgSUJNLCAyMDI2CgogIFRoZSBjb3JyZWN0IExUUCBjb252ZW50aW9u
IGlzOgogICAgKiBDb3B5cmlnaHQgKGMpIDIwMjYgSUJNCgogICh5ZWFyIGZpcnN0LCB0aGVuIGF1
dGhvciwgbm8gY29tbWEpLiBTYW1lIGFwcGxpZXMgdG8gYWxsIC5jLy5oIGZpbGVzCiAgaW4gdGhl
IHNlcmllcy4KCmFjbF91c2VyX29iajAxLmM6IFRoZSB0ZXN0IGxvZ2ljIGlzIGNvcnJlY3QuCgog
IFNBRkVfQ0hNT0QoVEVTVERJUiwgMDUwMCkgZm9sbG93ZWQgYnkgdHJ5X2NyZWF0ZV9hcygpIGV4
cGVjdGluZyBFQUNDRVMKICBpcyBzb3VuZC4gU2V0dGluZyBhIG1pbmltYWwgQUNMIChVU0VSX09C
SiwgR1JPVVBfT0JKLCBPVEhFUikgdmlhCiAgYWNsX3NldF9maWxlKCkgdXBkYXRlcyB0aGUgaW5v
ZGUgbW9kZSBiaXRzLCBzbyBVU0VSX09CSj1yd3ggbWFrZXMgdGhlCiAgc3Vic2VxdWVudCBjcmVh
dGlvbiBzdWNjZWVkLiBObyBpc3N1ZXMgaGVyZS4KCi0tLQoKW1BBVENIIDMvOF0gZnMvYWNsOiBB
ZGQgc3ltbGluayBBQ0wgb3BlcmF0aW9ucyB0ZXN0CgphY2xfbGluazAxLmM6IFRlc3QgZG9lcyBu
b3QgdmVyaWZ5IHdoYXQgaXQgY2xhaW1zCgogIFRoZSBjb21taXQgbWVzc2FnZSBzYXlzOgogICAg
ImFjbF9zZXRfZmlsZSgpIG9uIGEgc3ltbGluayBzZXRzIEFDTCBvbiB0aGUgdGFyZ2V0IGZpbGUi
CgogIEJ1dCB0aGUgdGVzdCBvbmx5IGNoZWNrcyB0aGUgcmV0dXJuIHZhbHVlIG9mIGFjbF9zZXRf
ZmlsZSgpIGFuZAogIGFjbF9nZXRfZmlsZSgpIHRocm91Z2ggdGhlIHN5bWxpbmsg4oCUIGl0IG5l
dmVyIHZlcmlmaWVzIHRoYXQgdGhlIEFDTAogIHdhcyBhY3R1YWxseSBzZXQgb24gVEVTVEZJTEUg
KHRoZSBzeW1saW5rIHRhcmdldCkuCgogIFRoZSByZXRyaWV2ZWQgQUNMIGlzIHJlYWQgdGhyb3Vn
aCB0aGUgc3ltbGluayBhbmQgdGhlbiBpbW1lZGlhdGVseQogIGZyZWVkIHdpdGhvdXQgaW5zcGVj
dGluZyBpdHMgY29udGVudHMgb3IgY29tcGFyaW5nIGl0IHdpdGggd2hhdCB3YXMKICBzZXQuIFNv
IHRoZSBjbGFpbSB0aGF0ICJBQ0wgb3BlcmF0aW9ucyBmb2xsb3cgc3ltbGlua3MgcmF0aGVyIHRo
YW4KICBvcGVyYXRpbmcgb24gdGhlIGxpbmsgaXRzZWxmIiBpcyBub3QgYWN0dWFsbHkgcHJvdmVu
LgoKICBUbyBwcm9wZXJseSB2ZXJpZnkgdGhpcywgYWxzbyBjYWxsIGFjbF9nZXRfZmlsZShURVNU
RklMRSwgLi4uKSBhbmQKICBjb25maXJtIHRoZSBleHBlY3RlZCBlbnRyaWVzIGFyZSBwcmVzZW50
LCBvciBhdCBtaW5pbXVtIGNvbXBhcmUgdGhlCiAgQUNMIHJldHJpZXZlZCB2aWEgdGhlIHN5bWxp
bmsgYWdhaW5zdCB0aGUgQUNMIHJldHJpZXZlZCB2aWEgdGhlCiAgZGlyZWN0IGZpbGUgcGF0aC4K
Ci0tLQoKW1BBVENIIDcvOF0gZnMvYWNsOiBBZGQgZXh0ZW5kZWQgYXR0cmlidXRlcyB0ZXN0CgpD
b21taXQgbWVzc2FnZSBib2R5IGNvbnRhaW5zIGZpbGUtY2hhbmdlIGJ1bGxldHM6CgogIFRoZSBs
YXN0IHR3byBidWxsZXQgcG9pbnRzIGluIHRoZSBjb21taXQgYm9keSBhcmU6CiAgICAtIFVwZGF0
ZSBydW50ZXN0L2ZzIHRvIGluY2x1ZGUgeGF0dHJfdGVzdDAxCiAgICAtIFVwZGF0ZSAuZ2l0aWdu
b3JlIGZvciBuZXcgdGVzdCBiaW5hcnkKCiAgVGhlc2UgZGVzY3JpYmUgZmlsZSBtb2RpZmljYXRp
b25zIHJhdGhlciB0aGFuIHRoZSB0ZXN0J3MgcHVycG9zZSBvcgogIHJhdGlvbmFsZS4gVGhlIGRp
ZmYgYWxyZWFkeSBzaG93cyB3aGF0IGZpbGVzIHdlcmUgbW9kaWZpZWQuIFJlbW92ZQogIHRoZXNl
IGJ1bGxldHMgZnJvbSB0aGUgY29tbWl0IG1lc3NhZ2UgYm9keTsga2VlcCBvbmx5IHRoZSBkZXNj
cmlwdGlvbgogIG9mIHdoYXQgdGhlIHRlc3QgdmFsaWRhdGVzLgoKLS0tCgpQcmUtZXhpc3Rpbmcg
aXNzdWVzIChpbmZvcm1hdGlvbmFsLCBub3QgYmxvY2tpbmcpOgoKICBOb25lIGlkZW50aWZpZWQu
CgotLS0KClZlcmRpY3Q6IE5lZWRzIHJldmlzaW9uCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
