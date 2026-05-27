Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D86DCD6E41
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 13:07:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0ACD03CAFF3
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 15:07:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A81803C036C
 for <ltp@lists.linux.it>; Wed, 27 May 2026 15:06:55 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5919B1A009A4
 for <ltp@lists.linux.it>; Wed, 27 May 2026 15:06:55 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-3044857f09aso7275281eec.1
 for <ltp@lists.linux.it>; Wed, 27 May 2026 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779887214; x=1780492014; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+91VXetjBB+8nHe3HdRfNcbjAHodcu7CBxu/179brBY=;
 b=cj1EtqcJHwfEyxpayPiZvHD5CBKtNMUeWTHMZ4xSGInrx5NPEO4Z8sbE+Y85nyJddH
 ohYw4YzSi5MfLCx/Vfgp9JypLED0ZYiYlSuOii8H/lsYHk8Cg3eWeswhbljxsAc9APwN
 EBi4QRz/5khda+Qm09ZPLHSmXIF/0MgFff8SqWGFkzjGgUuyANdv//eFG0n18QTek7x8
 +7nhsQ0j22eM5eMHE4eC5bf1yl1322aZSe3VvhQ55syhZfg+AQFGthEnNlbYOZv0HsNr
 l9UHYGJbNczM6/QU1aTqpmIznyzUqg7+A0hINPlovs2ItIml8NTPeFzZzfENIOf9YwjQ
 /lBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779887214; x=1780492014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+91VXetjBB+8nHe3HdRfNcbjAHodcu7CBxu/179brBY=;
 b=KcqrGkOB1bMFoJHUlW2z0MWvznTXVYXFCckHFIY/oY3vzYu6VBTD//N8AToKiQKLwN
 2MBGgpWEKsyz5E9sPbYSbxGDtIhqsOJJFRad13lcvsq/5MG7jt9ECq39sAMZF93A9i28
 yzQO8daBdcBvi4ximHtE+GXd3RKubgwZKG3aIjwgU9cuN8SmpafcbenQ84qfw56GeWp1
 oWKKMKbjpf3jpyEpjlolzRgzq4+Gy/hlAI74wwGiPI8C4RsQsSPFQ5IVRkOpxJYiSwBg
 3o44dFj9r/WoN/iWgLjny03FoTVXd73aYi80qeRxcm5Uzkdq1S3dyPgyXU9Jibkx+w0d
 tXEA==
X-Gm-Message-State: AOJu0YzKGWbSpuxx8/FwjRSX0lIhvxfBEZeKBeoTu6hWq6NwGwcxQaRy
 61UEcRGtAYT6r+BUiWd6WNNtJww1r6IfFRGee1JS8tfO4SPZtua3iRcTSNAp7VtLtoo=
X-Gm-Gg: Acq92OEPqDh6TOSKCQaMGInf8mQ8KaqKYwtweaqjac4i4EU9+pst53a1sQDnMjDIZ3a
 ZUuWAcOdTVQRV38KqqnlkdANfTdCva2MpELXnMWABnFzU/caEftx0xhbwBlYlJQOx+ITOiBBvmc
 3QjVi9fJwE2MRYdMcLRhpr6kkHWXCDFTyHvDufbqGTICnc05gRk4uizLUCcQULVuDGz9b9BQ/yw
 iL3H77wdUfaCS+vaHWOvJBKqtsZYf8OBiWD5BJJdWK2gmqRj+U3SqIYp9rCVkz8EQOiokBE7NIP
 eREKDVwBAUOZs5tuwgOsZoELathld9pQzvqEoAj3k/6SfqP3JYUa+7DfdMkUOjtBTCxouH58m4B
 +HhNjvcfAtnHLqMPXmsDwIwrQ4gLgw1YUBpGvRm+3nJVK7vlaxFaLebTtIut9EXHbDvaj0CtCxx
 CVSMFm+oF254Xz9OJWcouVjaZIXZGmtsbZoCPPinmvI0iGtn69jOM/4dVmhKzQuNlmvxsKrG+yH
 ZPFkghb5cRXvp3sMRXJrvkHGluil83rUzkGl0nVa1T8+pzAarnHlYJy3Bc=
X-Received: by 2002:a05:7300:2382:b0:304:c572:18b0 with SMTP id
 5a478bee46e88-304c5721e05mr822933eec.31.1779887213669; 
 Wed, 27 May 2026 06:06:53 -0700 (PDT)
Received: from
 runnervmg397c.ji1a2uz2t1tupgawfdyie1rgtd.dx.internal.cloudapp.net
 ([13.83.216.98]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045225b7b6sm17219783eec.25.2026.05.27.06.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 06:06:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 May 2026 13:06:52 +0000
Message-ID: <20260527130652.4138-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527103756.448843-1-chrubis@suse.cz>
References: <20260527103756.448843-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/madvise06: Fix sporadic not enough RAM TCONFs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On Wed, 27 May 2026 12:37:56 +0200, Cyril Hrubis wrote:
> syscalls/madvise06: Fix sporadic not enough RAM TCONFs

> On systems with <= 2GB RAM the test produced sporadic TCONFs. That is
> because even if the test setup does sync() and drops caches the system
> starts fauting in pages immediatelly after caches were dropped. It may
> easily happen that system may fault in a few hundred of MBs of memory
> betwen the write to drop_caches and the time sysinfo() syscall returns.

Three typos in the commit body: "fauting" -> "faulting", "immediatelly"
-> "immediately", "betwen" -> "between".

> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Duplicate Reviewed-by tag.

[...]

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
