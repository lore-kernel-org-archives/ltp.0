Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4175FC5B56A
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 16:58:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C30F3D066D
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 18:58:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A056D3CFF65
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:57:51 +0200 (CEST)
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2185D600673
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:57:51 +0200 (CEST)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-ca696c4b152so879534a12.1
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786381069; x=1786985869; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G3fJXTNdg3e82dA/gxmTYBnlL4NkHXkWyRpoi7qBS24=;
 b=OUl+WHocpt20qKoOWyGcwGl8tYqVYo0xjecQ5J0uSTuO0IniWe6z/+yIpD0ajknnoe
 LoF/llPyuA6vI7iWgYl+iykmRSsNwvwxxfAO7W2TzFPZqrRohkyCehn1twa3GlELcpF6
 ZRY+Rs7aLNUVOeuYd6UrvzcSwUTL8yIAEmW5NsJhpb4Q2A1h1sE5/43MZmLPsxba8kHL
 To125MTlliKgVOoejCw72w+N78JaU23rjfDXgQYoCHucT05/g3FnjCSC9qGPSzDYmAoQ
 oYR8FgQOv/6UhxsoengwwIPgpXbLUIqkklaBqh2UvwgXYLBm2BdMu156FRyBTFEPej3W
 2UTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786381069; x=1786985869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=G3fJXTNdg3e82dA/gxmTYBnlL4NkHXkWyRpoi7qBS24=;
 b=RmrNWve7cz/W81yHYB6O2eA9ykYBWoJVdx19fZ/zKEZL6FHTugFrw6iDBtk0P6xjLu
 SqmVRMdMCWZZ8Dg5opa4O31IB5xtLU7tOsAMbyQ0qnNU60oxOokyT9hLq0bux7SP0ops
 G/3SpxRKWUVeitLPFHUC2KWAeQCEoOTP7xh4wr2t80vHHEtpMlZoVtMutH9A7Jyv3C6e
 BbJsDFgpvDcNNWuCkiLrjzZJUmYU7R6yXjubvmNJbNhDK1UdniLlSaNCkl/vmTrJXfqY
 fMKYKjS76j1STNXUHCx7soR4aQCgWyePH9BJTtuAXkcJ6a+3Z5SQXiejNNLL0zrdOOFi
 Pbkw==
X-Gm-Message-State: AOJu0YwDLVqPAaoLJ4BDKmAXE/avGWTu7co0xIqcHDk+x3ABTozdGkxr
 jUSRvtWVtQoHYaS/XJBEMJ+gEbvnbwAVcYwBjLZ39Lmljwt+9O5/soSR
X-Gm-Gg: AR+sD10kKd/VCMhAdjGrlj66KbjbIuNh+wDmTrNEbYiK4ebnu6YyEFOXc3ErdRBbLJa
 +aLa43jBq5M8tjNVBGdX+387IBnTwfXNgG1HeXiaOpXKfnYsD7MPi2eLfhM7kM2fIUsvL/mYi4B
 tw2ZNtRBXX0zIxjgvYVNDCKDEyIgd7CJRFATHuISpFU1wUEr0NbFvz9cFILVOgvaGXBggLdhxE/
 YAjLrWTEFFdaDKYKCOGnEzfSvFH6y/Mu5eNyAADh6ZpKJcfH5yLFs0m9O0EUZN0RctgVPOo/WBU
 0UGH+S6juOy/zUXIg6uE8g5ofFBJKOxZBfKf+wavvDJpWRF4zAfYPdMrW9sJ4rNVjJMAXc7g8ya
 1WutVbq2kCKtHZzmkgIaQF6XKGmFe2jw23JTHjFb/hV7NlmgHxi+p0Ibs5suYxvY/cBWCbJA895
 CMWk8ek4+TwxoBAjOGKzkGup1+NjwGe2dSKZ97maa/QwVG5/oyTfUobCc8ibnywOefTitV3vIHK
 Qk2+e+vruiYz3QqEOX3ZzliDYtxuIySJB7Hvwg9snfp7Iq3GECzv77R76GtsBKN0rFP9I8zJibB
 VtXHUCpn
X-Received: by 2002:a05:6a00:3a29:b0:847:84a1:9782 with SMTP id
 d2e1a72fcca58-84f696c217dmr21448465b3a.26.1786381069096; 
 Mon, 10 Aug 2026 09:57:49 -0700 (PDT)
Received: from
 runnervmvrwv9.4y430nl00ooexjpdoumriazz4c.xx.internal.cloudapp.net
 ([20.3.166.82]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a797697sm4287447b3a.61.2026.08.10.09.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 09:57:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Aug 2026 16:57:48 +0000
Message-ID: <20260810165748.9096-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810-sctphantom-v1-1-f8e9ee72a648@suse.com>
References: <20260810-sctphantom-v1-1-f8e9ee72a648@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sctp: add lapi fallback definitions
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

On Mon, Aug 10, 2026, Andrea Cervesato wrote:
> sctp: add lapi fallback definitions

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
