Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A8FCD5BD1
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 11:45:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0F383CFE82
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 13:45:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDF7F3CE52A
 for <ltp@lists.linux.it>; Thu, 28 May 2026 13:44:52 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 54FDC6007A6
 for <ltp@lists.linux.it>; Thu, 28 May 2026 13:44:52 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8cc0ef7c306so101675396d6.3
 for <ltp@lists.linux.it>; Thu, 28 May 2026 04:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779968691; x=1780573491; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VC6ogin1MqcTVD+0L+SiYIdoX3rQD+BZEgur0fLR5A=;
 b=s1AOHisFsjpZnD5NDUUnUK8kB0oRa6TWPNmuOCvDu2XPPItTpmywIsZOA6rihVPA79
 Bp37YbJwr9OKH0Cgiu5H07+yy3KP3/TNZVprQz/MdRac0kPcoEZc2xbOs/tA99LVXOsj
 HFLP0lnsE6FPKBC2oNmsTlncqJyOV2KSpGVvM9QnctPBZBgUB27vKWRGqJ+xGjXs/hY4
 EV1e6C9YjiF1bN8jWTWMGkUGJPVA+9ghlc0EnB4hhmMv7Fdneil0BmYWVtsnbkks+kSQ
 63pw3glwPTKpApU/K3ghlo2HLxxM8i4cEvKiHApM3TI1XGAx1uzYHpFmNfxoAgiFi3No
 kjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779968691; x=1780573491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7VC6ogin1MqcTVD+0L+SiYIdoX3rQD+BZEgur0fLR5A=;
 b=OSNmi2AIlm0JqCj2IkuwoJbloM1WTp+y8aGfePyKkl/EIGp2yOITdZLz2xaRka5mHF
 7c/51Z5Fc/CE7B2sPGJC0kxZcUkjyPmkRD1uYT8u7hcVvYEkfUlJHVZyXMZfgPC7wTYG
 GibqeaMuepeC+qxqe/WwT3AY4RfNUwZe75JdVDk7VdcxI1Uk/L3QqgOsuc5Vivh8feF9
 vpgl9y4z2NWJllYthfrncf4ptPba/YezkArtzFITV3447HEDaAT844TuEYiXrM6+BF4S
 c5fF1V5b6cPgj2eIOTt/a2l6pBf0P3c3BBsJRdVN9koKz2gtYiWepKjNFc2EjX126wAu
 rVvw==
X-Gm-Message-State: AOJu0YyZFfuAwi3VMb+ACL5anNxNN7sxjm7HpcrsXck4gJlQYe7+vFgc
 BYd7Zb0YotMAR911F5V7tajDQk5A49MW2rWMl9oia1abl4GZmYSLnvVg
X-Gm-Gg: Acq92OHckn3hZzQxE3bOAbBVfYIKjOS6ZqSDGtg8KB5NHUusmK5h/wD1IbP10Vkqepc
 iQi8hW7Fb2XRcj6EnyiXKFOEgLb0jzVJPjyXh/jXDrIVOEHZHPMaHM6PskBvWKcJAzKufejd02R
 ZOMp4N1fDTXz2ZYH7txiDXyoWPFlYyx3KSx5UUpSCo1nvqeRah5Ikq3ivMjGoxmooT77kw07Ca3
 WfCoYDuEIXOvokStICEHHE3hBSxMl1IZ9tb64/YE3lYy8dgdFvQvbcDXesG9/60wodDOSH9sq8g
 4ZVmtZlyjNH9coARApNuQQX5lNuYdvR25qaoVfKireobMr7ONGYkBamxO6lL3oPP8O+AkxPvJtV
 7Ya6OUet6NOMhdZGG3y9JJMcuI+Qfdj9Zv50yBjkUUQNaMvp9A7MM8I65rIxww2PpcUdLda92Ci
 SQQm1f3aTE+e03Td/1W88DxF9Q9UVI684RQmYtWfmLzcTexwqGYR4t4ISOD46tt1m2IKsk2OS0g
 yDz/1hf7WeuzKfDgMPtgrf/U2rC5LdJZ/CEy3omuY+62N6HXyI=
X-Received: by 2002:a05:620a:3199:b0:90d:b6b7:ca93 with SMTP id
 af79cd13be357-914b49a2dffmr3811298885a.47.1779968690832; 
 Thu, 28 May 2026 04:44:50 -0700 (PDT)
Received: from
 runnervm3jyl0.s5mtcvhmvgletc40ys4ohtsfre.bx.internal.cloudapp.net
 ([20.106.182.211]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f87d1b66sm799710985a.29.2026.05.28.04.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 04:44:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 May 2026 11:44:49 +0000
Message-ID: <20260528114449.3884-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528102757.398375-1-pvorel@suse.cz>
References: <20260528102757.398375-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] checkpatch: Disable more kernel specific checks
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

SGkgUGV0ciwKCk9uIFRodSwgMjggTWF5IDIwMjYgMTI6Mjc6NTcgKzAyMDAsIFBldHIgVm9yZWwg
d3JvdGU6Cj4gY2hlY2twYXRjaDogRGlzYWJsZSBtb3JlIGtlcm5lbCBzcGVjaWZpYyBjaGVja3MK
Cj4gLeKAk2lnbm9yZSBQUkVGRVJfS0VSTkVMX1RZUEVTLFNUUkNQWSxTVFJMQ1BZLFNUUk5DUFkK
PiAr4oCTaWdub3JlIFBSRUZFUl9LRVJORUxfVFlQRVMsU1RSQ1BZLFNUUkxDUFksU1RSTkNQWSxC
SVRfTUFDUk8sUFJFRkVSX0RFRklORURfQVRUUklCVVRFX01BQ1JPCgpCb3RoIEJJVF9NQUNSTyBh
bmQgUFJFRkVSX0RFRklORURfQVRUUklCVVRFX01BQ1JPIGFyZSBjb25maXJtZWQgcHJlc2VudCBp
bgpzY3JpcHRzL2NoZWNrcGF0Y2gucGwsIGFuZCB0aGUgcmF0aW9uYWxlIGZvciBlYWNoIGlzIGNs
ZWFybHkgZG9jdW1lbnRlZAppbiB0aGUgY29tbWl0IG1lc3NhZ2UuIEdvb2QgcGxhY2VtZW50IGlu
IHRoZSAia2VybmVsIHNwZWNpZmljIiBpZ25vcmUgZ3JvdXAuCgpBbGwgZ29vZC4gUmV2aWV3ZWQu
CgotLS0KTm90ZToKClRoZSBhZ2VudCBjYW4gc29tZXRpbWVzIHByb2R1Y2UgZmFsc2UgcG9zaXRp
dmVzIGFsdGhvdWdoIG9mdGVuIGl0cwpmaW5kaW5ncyBhcmUgZ2VudWluZS4gSWYgeW91IGZpbmQg
aXNzdWVzIHdpdGggdGhlIHJldmlldywgcGxlYXNlCmNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25v
cmUgdGhlIHN1Z2dlc3Rpb25zLgoKUmVnYXJkcywKTFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
