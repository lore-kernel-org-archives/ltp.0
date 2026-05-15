Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA91CD343F
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 15:16:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC39E3E2C1B
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 17:16:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 550303E18AD
 for <ltp@lists.linux.it>; Fri, 15 May 2026 17:16:32 +0200 (CEST)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com
 [IPv6:2607:f8b0:4864:20::1242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 14A6B1000DAD
 for <ltp@lists.linux.it>; Fri, 15 May 2026 17:16:32 +0200 (CEST)
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-133466cf955so6280719c88.0
 for <ltp@lists.linux.it>; Fri, 15 May 2026 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778858190; x=1779462990; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldlmmC5AK4CsG/UD/0Rc4bykoh0ziWbPiYBn+ybn/WU=;
 b=GcRuEJSHOKsvMpMiaEqS5IIaDZx6UlxSS4D1dpzBYpWZYwN0vLRH4sRLtCex9ESvgL
 jij8GRd5KdZEMe0RFDeuwK3SjFXXETxjIF0fZbc2wCbFNkYYq9SxpugY68gdbWz2ibAT
 8nU9MbGeX1k/kHvYYTQtoYoJIPHQoLJlM6ds+uPd0wYjJo4RS0Jdh8kgWWJxWqAueFvx
 JTzILgyuRWYImYRA/AiLVojsOxseZKWjNQSQ3vCwRA8l7NVifUWplwZ1y3fE/Vn8jZ/7
 CoL7mHFvq5L5YhP8ewIrN47mi8MMKm/piSo22moQa+n643wDTrcDe7EnbavkHAQo0S8v
 YFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778858190; x=1779462990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ldlmmC5AK4CsG/UD/0Rc4bykoh0ziWbPiYBn+ybn/WU=;
 b=CKoTSZmtxFAq02rvO/+OJpi9cJTDTAuO8oenTwIu0u2k8ORM35j9PAp0W8Mt0p/Uty
 JG4DgTlJrpi2CrC++C6GSGz1SlWyLnb5y5nxvb3Zwo7xq6ycT6qgFIDgDmw6Y45xsdpg
 sQ+JD8Lq33HGPpzKvNxVDQ6m8/KrzVOhyg/MEZJw93Zx2yWTl/e+knN4IPpPLoh4l9C/
 ecHoA4RmPolqGpJLypfqp35gZrfPxhySaA8i91loQLBFJr+dh7a9ixd4BXLBprOEAnuS
 6ieBLRZ7SlEAb+dI/e+qGO7GsCySUF/4mKL7qEnJYWpUUlvS3GXG5pkLFqTZB3LnqLrO
 6EVA==
X-Gm-Message-State: AOJu0YxUY45nWB5492tlTSntKbh3+EL9+dR7lHBw6mg4ufO7W1QqDu9Z
 mS01kKZF8RV2rZzOPb9JEEwIJPPiH+E6ZmcE5+gb1PImvOF9ySGu5RMd
X-Gm-Gg: Acq92OFC8D1GZhnJQao1jthkijHMCrT6Eo1sdZh8OmOkhhBRmjsDLB0/0XIR3WlFc3e
 DCl2kwkSQEWODpTla5gqP8rJnezfIX4UmGiy/mnKlM5Tc7tJCdVAoOe6sv3/S9/n/aNgxsX9Qez
 2AUQ5HZv8RpQWySHRqbrVCS9IoLTsD6wXkecZQysWcL94DOGklBJ+d7Ou6XHQwaHZKbqV/7Pm62
 1fAkZzCqrUXCLEKMJW4yBteD1YpesegIdD8nuNFT232Cej+rXCnYiq4fLJB+VbCQcMzU7190lvn
 sxYESt9KHCDIbyhYVXI5Fn5lg7fEB4uGoAN/tYCzXcNJgkYlWlwhvpgY3IshTM0DMa1eUWRhzPD
 h6NwtEWaCAwlrwtrLqZZ2omDkCA6GcY0+orvBXCwIaHhlaZFYXeC9Rk/AYO63XAV8F+TgjKa3pA
 7nAU7Gt0+z/zcLCfTCWI7yWmt4/ZXsM6iL0fNl0fyU9SN+tAtK7RaKdRghDeuCNbQa2xCQ/lGTf
 K6b8qdtcg9CDV1E9+Ect8/pfhSfdl95RdI7xPUj
X-Received: by 2002:a05:7022:40c:b0:12d:b205:c737 with SMTP id
 a92af1059eb24-1350451e639mr2006643c88.17.1778858190353; 
 Fri, 15 May 2026 08:16:30 -0700 (PDT)
Received: from
 runnervmrw5os.pexe2arhy53e1kmc0kdex5vwzc.dx.internal.cloudapp.net
 ([52.159.247.147]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc33a618sm10206293c88.12.2026.05.15.08.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 08:16:30 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 May 2026 15:16:28 +0000
Message-ID: <20260515151628.3875-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515133613.31249-1-pvorel@suse.cz>
References: <20260515133613.31249-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_net.sh: tst_rhost_run(): Go to LTP temporary
 directory first
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIEZyaSwgMTUgTWF5IDIwMjYgMTU6MzY6MTMgKzAyMDAsIFBldHIgVm9yZWwg
d3JvdGU6Cj4gdHN0X25ldC5zaDogdHN0X3Job3N0X3J1bigpOiBHbyB0byBMVFAgdGVtcG9yYXJ5
IGRpcmVjdG9yeSBmaXJzdAoKPiArCVsgIiRUU1RfVE1QRElSX1JIT1NUIiA9IDEgXSAmJiBjbWQ9
ImNkICRUU1RfVE1QRElSOyAkY21kIgoKUmV2aWV3ZWQtYnk6IExUUCBBSSBSZXZpZXdlciA8bHRw
LWFpQG5vcmVwbHkuZ2l0aHViLmNvbT4KClByZS1leGlzdGluZyBpc3N1ZXMgbm90aWNlZCBpbiB0
aGUgc3Vycm91bmRpbmcgY29kZSAobm90IGludHJvZHVjZWQKYnkgdGhpcyBwYXRjaCk6CgotIHRl
c3RjYXNlcy9saWIvdHN0X25ldC5zaDoxMjE2IOKAlCAid29ya2Fyb3VuZCIga2V5d29yZCBpbiB0
c3RfcmVzXyBUSU5GTwogIG1lc3NhZ2U7IG5vdCBhIEcxIHZpb2xhdGlvbiBidXQgd29ydGggYSBu
b3RlIGlmIGV2ZXIgcmV2aXNpdGluZyB0aGF0IHBhdGguCgotLS0KTm90ZToKCk91ciBhZ2VudCBj
b21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guIFRoZSBhZ2VudCBjYW4gc29tZXRpbWVz
CnByb2R1Y2UgZmFsc2UgcG9zaXRpdmVzIGFsdGhvdWdoIG9mdGVuIGl0cyBmaW5kaW5ncyBhcmUg
Z2VudWluZS4gSWYgeW91CmZpbmQgaXNzdWVzIHdpdGggdGhlIHJldmlldywgcGxlYXNlIGNvbW1l
bnQgdGhpcyBlbWFpbCBvciBpZ25vcmUgdGhlCnN1Z2dlc3Rpb25zLgoKUmVnYXJkcywKTFRQIEFJ
IFJldmlld2VyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
