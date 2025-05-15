Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E29EC2D0CD
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 09:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747300406; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=82fLOllLBmE/dHqiH1hNSxYLI1te91LEHgHkjxIvzVE=;
 b=LICFziDTz8harBNgzjmcc+mzPkjiAiVvjnHjaARm003h7c3BZiSuPNYXbGuP0vD6Tz2UI
 sXUCjq04oPHGzjAT+jWAZICp4RkIv5s7OxHwK6X82tsIBYq67aW0UkMa1KvDgziI23XDiBu
 SqOJA7/5V6w9/V6WoN/i1jy+9qGJu6Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 463B03CC4A0
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 11:13:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9AD83CC4A1
 for <ltp@lists.linux.it>; Thu, 15 May 2025 11:11:53 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2E462600A78
 for <ltp@lists.linux.it>; Thu, 15 May 2025 11:11:53 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-442ccf0e1b3so8438845e9.3
 for <ltp@lists.linux.it>; Thu, 15 May 2025 02:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747300312; x=1747905112; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X2SnJWKE2Ge3yYG2mdHxp+hxaWQaXqn5ON4MH9a1XaA=;
 b=FPwZYxiGJtiw8giMCtX0cXi9eu1jfrn8Z/8ijlDLfVQbqgO5rFTRSxG82I9kLT1IZW
 tkwG+a7sZz3WA5WBB5pP3U5an/K6HoleEDPu9n7boW39lcM+1to+TftMHTcDSpEgJXV1
 an7ARL8PwTYWJjZJSCCsl7SF2zPozcRsMtW8tYPhso6XHuwzl9Yf75Uh2jipJ28U7X98
 D8S9xtTqPAt+Odq6jVMZUe52dy/wUdq4vxUP6zOVymNJbNM0ICO7QilkUwxkTU9zg5KW
 Nx9bz1ZmJytUTxx6sSyLABptwUyE20yyeUqWV0ntW5inkAbAXry2BBH3sQ+bT7idGfRz
 PPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747300312; x=1747905112;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2SnJWKE2Ge3yYG2mdHxp+hxaWQaXqn5ON4MH9a1XaA=;
 b=TJKg6P9uoPJ+QRWiGCJP6ahfXw/W4wnBNMKHegX90uOWDItvq+Z1d+FYRB+vqT575b
 3I8F1aBq0UsDrWIwvwMyp5XgB6qdb6CIdDyh0KMZufCx+2NRpQBQtOH1GVRChNK/MgnI
 QmC9yU8MW5VByObff9Dye6Lh3fnzFnmg5LV5S/eZ8HVjN0I5X3ZFlr9u86CGJrE6vVyX
 NLJrU/E26oojHCPtBGOPbyJe8staooXD5YJKb8V2xNMCgLXzqCkMbBlVAkMGzPn7OH7e
 4PKhtAR22OyvA+LhD2tsvkuG+sP8HfpVZn4uscB9nDbn0qVRmLmId2PuHTWfASUzkk2N
 +5/A==
X-Gm-Message-State: AOJu0Yzbc8kALFF00rx2Bw99hHb8NChl3547QdXx+EyDt3Z93fmL0IJb
 z9vvAFpgmKYQo+RVz6EOxhDTDRL2aDnv1aeQqGhjnXsz5kKeKIkf57DMAcO5WgY28vOM1yFUWMc
 1
X-Gm-Gg: ASbGnctVmVME8DkcSu+EMDmdJqJAA8/uWCC2vN0EPPmQGmpfTp3udtSA+UAswGluDk1
 GOtWF2Cm8eT+IuFJzl8Ua+e6dfgzbLdkHQTr9XyWLRrZG9GNgJpkQmlMq8gFYN9HFJy2ZMnR8lY
 X3t7p4tC8qtCxxhWnoE8FrkAyg8/1MxeH0qWvn7+frNIKbprgwmbuitcP4rD3SSISoMKoJR8A1F
 xY1ITPvuI53xZol/24F6eK2M+tdhZN7MmgI7RFpifNfZJD9Dot968Efql/LK1FmVuHzlFz+4WzS
 jjGcqEZWC8J/t17l1BGX8ICTN94++gzJFZwxV4QM3hcoLMDVlQ==
X-Google-Smtp-Source: AGHT+IF3WTQlIlKbsh6G7TCaEjSzF7YTN8CBfdd+JD8+OslCR+oUgGnAMxGH3DmwZYta5NZRrtlS3Q==
X-Received: by 2002:a05:6000:2dc7:b0:39e:e438:8e4b with SMTP id
 ffacd0b85a97d-3a34994fad3mr5249346f8f.50.1747300312617; 
 Thu, 15 May 2025 02:11:52 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 ada2fe7eead31-4df9c01a312sm249284137.28.2025.05.15.02.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 02:11:51 -0700 (PDT)
Date: Thu, 15 May 2025 06:11:37 -0300
MIME-Version: 1.0
Message-Id: <20250515-conversions-kill-v2-3-431063e90b4f@suse.com>
References: <20250515-conversions-kill-v2-0-431063e90b4f@suse.com>
In-Reply-To: <20250515-conversions-kill-v2-0-431063e90b4f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=rbm@suse.com;
 h=from:subject:message-id; bh=GOuBknfIteMDzOpG1evSydS4B2iRlxyhTz7xlNRu4b0=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoJa/KtUGYOKc6XC82rm55832WMBOJ1lwmIApXa
 eS0LZ5i1IGJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaCWvygAKCRDJC4p8Y4ZY
 pkXoEACUeEsMSU1Drz3srxH3oXCSjBkQWCSH/PtqfpjIXuDUo7GEHY0DhB+IzvVK9/61mMT8trQ
 Xdpo/vh1H9ur9OPdqSaHkAwe1wqUCshZgB6jgOS9tmOa3n+rIAeOkBYiKmyiRY/kNgMOlYexKev
 aWUB3SnVd6r9GjOqYGt4p9FRy3j7JVEJvQS5yNhpf35NZlCo6ppKJcyRDsGi8Ok6+qpXAqGmiR4
 EJ2sK7jp+5VZ0QKzn1gqJ0pyyf8ssxtw2UT2F/TN9RmoD4v+BwZWHJj4OMo5TgaulC8GM8PreP2
 bmJXO8cgNu4+f9g+fl1hK2d/2fn3dHdl0I2YVs4SDt0inG+EtM4jPiAPra2lYoFdJnrF7n9JEoE
 5ArQMG65Fz1+r2YeIbbqGjbdh/yAIazKiQz1OXfY/nNwq620KbdS2881Y7k8500kfmWTegoTi50
 054vqrc1e0s1WtkKMErNpWfofDXoDDgIjAEBuzIiXWeX/EJIvn/qOYvV9YFuTrVsI+umHP8avkV
 0z5pgxcH+2bLkb9szcNgBJ3DvaOw0px90b1e4iJO8pdW3XEvC3RL8q7d7dMLzjSheHypGLDoi48
 CUHQ3ylpVXz9g025w+6ucyzB/di4Y508jk2ykfJ9cSmfi17OWHJJ70xnz5Iv5YxlVMetJegQVEn
 sjUmwG/TMfGv3aA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/5] syscalls/kill06: Fix test description metadata
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClJldmlld2VkLWJ5OiBM
aSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJs
acOocmUgPHJibUBzdXNlLmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tpbGwv
a2lsbDA2LmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2ls
bC9raWxsMDYuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2lsbC9raWxsMDYuYwppbmRl
eCA0MjAwM2E2ODRhZWNkOWFhZjk3NWZjM2Q3ZTY0N2VmZDRmNWI0ZWNiLi4xMzg2ZTFiNzczZGQx
YWE2MDllYmI3NDdjNjZiMzVlMGIwYWM4MGUzIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2tpbGwva2lsbDA2LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9r
aWxsL2tpbGwwNi5jCkBAIC0xLDEyICsxLDEyIEBACiAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMC1vci1sYXRlcgogLyoKICAqIENvcHlyaWdodCAoYykgSW50ZXJuYXRpb25hbCBC
dXNpbmVzcyBNYWNoaW5lcyAgQ29ycC4sIDIwMDEKLSAqCisgKgkwNy8yMDAxIFBvcnRlZCBieSBX
YXluZSBCb3llcgorICovCisKKy8qXAogICogVGVzdCBjYXNlIHRvIGNoZWNrIHRoZSBiYXNpYyBm
dW5jdGlvbmFsaXR5IG9mIGtpbGwoKSB3aGVuIGtpbGxpbmcgYW4KICAqIGVudGlyZSBwcm9jZXNz
IGdyb3VwIHdpdGggYSBuZWdhdGl2ZSBwaWQuCi0gKgotICogSElTVE9SWQotICoJMDcvMjAwMSBQ
b3J0ZWQgYnkgV2F5bmUgQm95ZXIKICAqLwogCiAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+CgotLSAK
Mi40OS4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
