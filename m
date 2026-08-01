Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2742CC55172
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 11:27:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A98853EA6B2
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 13:27:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C04963E9858
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 13:27:26 +0200 (CEST)
Received: from mail-yx2-x04.google.com (mail-yx2-x04.google.com
 [IPv6:2607:f8b0:4864:41::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2C59D6001E9
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 13:27:26 +0200 (CEST)
Received: by mail-yx2-x04.google.com with SMTP id
 956f58d0204a3-667d5749f90so1260299d50.1
 for <ltp@lists.linux.it>; Sat, 01 Aug 2026 04:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785583645; x=1786188445; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fm5qIp/RTC++Tq8npe2r6Fqe7km+d9InIBfXM6xFkLA=;
 b=bRPTFdp/ec4GwlG7fLr3MSMUk8Al1Kzk+eD7manFa0049cMsgtvlt5FQtIuWvJNi6f
 P4pi57CqKELMlYxghNhAYUP+GIVQtx7b4pKAzBdu4E4C8dgYUmE3Tch7vj4+B+cBj+0s
 ZmyePhsODfGnVfRbJS2WQ6C8dQjqSvfqns7mlYpP/1JJuBeNWq3b8LZi8JAGIEe1+qMy
 7eztW9qrOnFioEZE/SaAMVrm8cFbIrET2ExpHT36+6MuWsmbMy7+Uw5Pq8FpG5vEy3cN
 N2mi58j3xMErfBM3GhgKDUkmd97K24xvUb6Xl6dJy8DoXv1or3wSjUAPG5lo46rPpidd
 p2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785583645; x=1786188445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fm5qIp/RTC++Tq8npe2r6Fqe7km+d9InIBfXM6xFkLA=;
 b=CuFRJ52Hu87ygWf6cvh/1KW6/K7XLWkPu1Z72PQUYwtYS0kJsjYu/9VNOTLgGYccv2
 MZc9HXr46i1f34jQfHqPTfYx0mgSyFh+HVCH/PSzjYpjZ3vEKuwNa9iRFhWpGBEqaZZr
 rP9lWpaZe4QY4T0GBr9+Vr958jLDJh15Edtgj0vuKGvm9xDunqxB0Y52ky8mvUAkoBbX
 hIXOhQ1+u8eK0UelGnWFtlo+BwxQnOdRbt1VPi6ltpKQwRUbgmQm2hRWSx9u/uDyChaN
 a5JlnrPZ4vDeJPVEE1xqj8WLPNaTDpQb9t/6+aZPEV0odEKBjryad1EyxyBT1U3Qok3n
 1vpw==
X-Gm-Message-State: AOJu0Yydv7gvmQzY5zF5gbGPJsoF7O3HIf0/0LUL1nsCoVDSMC6G0Ehf
 3XqhkSQsjR8PMZHudiM5EdLdvKPDY8eUUPAYu209Sf/NOhssGIn7e9QF
X-Gm-Gg: AR+sD12ciRfajESdJ5lQSlKo6Gy63wHapVnvt5XhhQga8W8TEqY7r+GpNqEVvSMYQ6I
 Nc2trGPIckYBg27s7lLPH9ZbEevGRagk+JjEJJddvCTchzJkrJvP6u63jq115caXP28aMuwnk3Y
 AJutkDUBSUb5Ku0f0zTsgATCCQ7FrIph4uKYdNBAot55KwiTuajiQnZBAXdPD9dW2vwqC6GN4Ya
 YXRYiy39gUPqLM5y6ptvBW6hPyZ0zohDbTr2sp0B6EOfTrNLNktFZFWWYk5F8k9XbXB4ZhDk2bL
 sNC4YjO0y2uzPpYa9Is1bVz79hESOGfwnVfks7Cgu9uw6pSqrAZDl+c4qOUvnL4mBqJrx9fJ0d0
 l7t0P5RqVhRnASxZLxJrF1xrLa6Y6P5OQS79Yx2uFjmzwaXYRj02rpK4Q+DFHUzkFXK8aq68XMN
 csjtHJTWSkuDQO5dHwBX6aMzBg8yN+6Ico+Xk2tuYBu0QCThxRfZLvtJkh+ghrw/p02go0dnr87
 N+Ku8U1ofgAmw/akTrg6vjalem06YbRw5pMPp7Gh+g91x0OS0YhdeiiU3ffZ4gMJe17bU1m7vBP
 1UT4HrEeptff
X-Received: by 2002:a53:c24e:0:b0:668:7115:1b79 with SMTP id
 956f58d0204a3-6694effe0d2mr3693917d50.12.1785583644738; 
 Sat, 01 Aug 2026 04:27:24 -0700 (PDT)
Received: from
 runnervmvrwv9.xvc5d54zgiqe3i3qbzi5g12n0e.ex.internal.cloudapp.net
 ([64.236.134.52]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66949036561sm2203053d50.20.2026.08.01.04.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 04:27:24 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Sat,  1 Aug 2026 11:27:23 +0000
Message-ID: <20260801112723.9180-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260801-cve-ghostlock-v1-1-178f698f9702@suse.com>
References: <20260801-cve-ghostlock-v1-1-178f698f9702@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/prctl: add more fallback definitions
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

Hi Andrea,

On Aug 1, 2026, Andrea Cervesato wrote:
> lapi/prctl: add more fallback definitions

--- [PATCH 2/2] ---

> +	static const int try_sizes[] = {
> +		MAX_AUXV_QWORDS,
> +		MAX_AUXV_QWORDS - 4,
> +		MAX_AUXV_QWORDS - 8
> +	};
> [...]
> +		valid_auxv_size = try_sizes[i] * sizeof(uint64_t);

Could these sizes either use the native word size, or could the test be
restricted to the 64-bit architectures on which the reproducer works?

On i386, the smallest attempted size is 320 bytes, but the kernel's
saved_auxv is only 56 * sizeof(unsigned long), or 224 bytes.
prctl_set_mm_map() therefore rejects all three attempts, and setup reports
TBROK. With no supported_archs restriction, the cve runtest entry runs this
test on 32-bit x86.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
