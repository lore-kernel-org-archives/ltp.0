Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC746C433F5
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 15:58:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2F993C6E0F
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 16:58:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9ABA3C8982
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 23:20:56 +0100 (CET)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EA9EE1A00667
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 23:20:52 +0100 (CET)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id F04595C0216;
 Mon, 22 Nov 2021 17:20:49 -0500 (EST)
Received: from imap45 ([10.202.2.95])
 by compute5.internal (MEProxy); Mon, 22 Nov 2021 17:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm1; bh=FCiOZI9Dv20tAQ/7weQX2U+Lw8g5MWM
 QEAl+y42pkKY=; b=QeNEi/AvK+hUIh19j4A+w35hKQD6AvtNdPGl90BKWAdJZbi
 X0dlB5XmiTonKKlE3TfNxWUA8CnP8C4D3Koui8OWgTNn6cgpFdmjmxPVqWvXY02x
 eUv5KaGaRNAiDXPnZlqP5GV6z5t64Op5ijxfokgiWt+prR/83JcgUu1KmW4p6u4p
 JWrYxfBvURPXEk9/RcT3Wf4G5HJcfA4NmjpabgA2+JAD9CwuOe2LTy+LKjjO84Hf
 6dgD0noO2GJRdKgwZlxuBSIBEnp8ChH+YV1go5nPw1qeqQOiqOnk2m7OB//nGa+r
 i5Wy9GudkLvgQ858Yy1KHtLuJw6dgrELjCE7RlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FCiOZI
 9Dv20tAQ/7weQX2U+Lw8g5MWMQEAl+y42pkKY=; b=ewXBhaKwZLdmIj+sVkHsf9
 a0YSi9sP0qm9FmmmKZiGKfjGEJqBOI0PwYjRT/tm8wPlVyMQpaHenat9tthmfJNp
 hvhhMkVPyq9aBgnxPz7vG+NaGRlLAooKioTubxNhyzraHFL6zN0O0DAfN1GZWG3u
 oNc2JXxb4rwNDCXYigmtGzeO8OZZsWGUoR1PXsSygAO/6RVqSRZXMkhjAzPmOR4o
 AoWnsRjtL5HXh4BSry0m48O5ZyiUxmlQvE3YrzNCIQy3zKIE7blR9Ue/2e6bWgJd
 mWBHpKCQyrbMfufQXgNpdfSqdFgJTBs564Da0Xhkrhd6YyKbSUpNw9cdAoAvzxtg
 ==
X-ME-Sender: <xms:wRecYZdfCh09993z-RORgZjn0BOI_8kLoYaGF3jMOdIUfnPfmvsI8g>
 <xme:wRecYXN5dggdlACAyRkvZsUt6oqUnQoyl00nJRjjEt5w9bYXw5dkjLf34AjrdJpZR
 YmCfMH1KLoUNkLkxxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeggdduiedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdgkrggt
 khcuhggvihhnsggvrhhgfdcuoeiirggtkhesohiflhhfohhlihhordhorhhgqeenucggtf
 frrghtthgvrhhnpefhuefhveeuffetfffgjeetgfekkeehfedtfeelgfehffffveehkeel
 fefgheffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpeiirggtkhesohiflhhfohhlihhordhorhhg
X-ME-Proxy: <xmx:wRecYShg87In53jYFl4bkLTO_d4fVgJeFcvgzaVd7xtXrC2El82iwg>
 <xmx:wRecYS9Nx3NXMazQy4eNpUK3utqVVP3bE3-db4qGrhIhD0g_oDntPg>
 <xmx:wRecYVvby4ByQWrYB4nSaXRaL2-thVvNo16RHugYiavRR9uod8TCFQ>
 <xmx:wRecYdI655DXx77lkf7cprqbo_ioS7XxEV5dg57HePNcF6rLB4g8Og>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 5B74024A0079; Mon, 22 Nov 2021 17:20:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <c5993ee9-1b5d-4469-9c0e-8d4e0fbd575a@www.fastmail.com>
In-Reply-To: <YZvIlz7J6vOEY+Xu@yuki>
References: <YZvIlz7J6vOEY+Xu@yuki>
Date: Mon, 22 Nov 2021 22:19:59 +0000
From: "Zack Weinberg" <zack@owlfolio.org>
To: "Cyril Hrubis" <chrubis@suse.cz>, linux-kernel@vger.kernel.org
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 30 Nov 2021 16:58:40 +0100
Subject: Re: [LTP] [PATCH] uapi: Make __{u, s}64 match {u,
 }int64_t in userspace
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
Cc: linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
 libc-alpha@sourceware.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Nov 22, 2021, at 4:43 PM, Cyril Hrubis wrote:
> This changes the __u64 and __s64 in userspace on 64bit platforms from
> long long (unsigned) int to just long (unsigned) int in order to match
> the uint64_t and int64_t size in userspace.
...
> +
> +#include <asm/bitsperlong.h>
> +
>  /*
> - * int-ll64 is used everywhere now.
> + * int-ll64 is used everywhere in kernel now.
>   */
> -#include <asm-generic/int-ll64.h>
> +#if __BITS_PER_LONG == 64 && !defined(__KERNEL__)
> +# include <asm-generic/int-l64.h>
> +#else
> +# include <asm-generic/int-ll64.h>
> +#endif

I am all for matching __uN / __sN to uintN_t / intN_t in userspace, but may I suggest the technically simpler and guaranteed-to-be-accurate

 /*
- * int-ll64 is used everywhere now.
+ * int-ll64 is used everywhere in kernel now.
+ * In user space match <stdint.h>.
  */
+#ifdef __KERNEL__
 # include <asm-generic/int-ll64.h>
+#elif __has_include (<bits/types.h>)
+# include <bits/types.h>
+typedef __int8_t __s8;
+typedef __uint8_t __u8;
+typedef __int16_t __s16;
+typedef __uint16_t __u16;
+typedef __int32_t __s32;
+typedef __uint32_t __u32;
+typedef __int64_t __s64;
+typedef __uint64_t __u64;
+#else
+# include <stdint.h>
+typedef int8_t __s8;
+typedef uint8_t __u8;
+typedef int16_t __s16;
+typedef uint16_t __u16;
+typedef int32_t __s32;
+typedef uint32_t __u32;
+typedef int64_t __s64;
+typedef uint64_t __u64;
+#endif

The middle clause could be dropped if we are okay with all uapi headers potentially exposing the non-implementation-namespace names defined by <stdint.h>.  I do not know what the musl libc equivalent of <bits/types.h> is.

zw

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
