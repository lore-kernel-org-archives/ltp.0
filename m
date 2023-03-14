Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194BCC6FD1F
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 08:52:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A93C23CD4DE
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 09:52:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 366F63CACD8
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 09:52:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E0EA3200340
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 09:52:28 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 2DD851F894;
 Tue, 14 Mar 2023 08:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678783948;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F7r3OBJ0pfpdiSu//LuXAQ4BcDRarbtTlKOpryWU8iM=;
 b=oWwkKnfGJQrLf5zp/JG9Xifw4spk9nUM43jJkiWHdrhTSwYLqgRvha9PGryXl2jhswAJqK
 HPUOFb2zXKypKh7v2WpBIYV52oOeKhw11aIjDbaoORt8QPPG/mGo4mKWEVHyD79z4oE0z3
 zh26eOuqDWN7CQ73gAvVOnDTGzrW3ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678783948;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F7r3OBJ0pfpdiSu//LuXAQ4BcDRarbtTlKOpryWU8iM=;
 b=0McT6nCtb6w0a03zTWlFj1N01ErUCYpEAuFXoXkLWH2fetN2ugb2fmfTi9bF3/zXhKb3R3
 ox+rNTg/qJlz/aCA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 6CDAC2C141;
 Tue, 14 Mar 2023 08:52:27 +0000 (UTC)
References: <20230311023343.25177-1-wegao@suse.com>
 <20230312004420.16457-1-wegao@suse.com> <ZA7qq15aeKS+ZeJR@yuki>
 <20230313122100.GA12608@localhost> <ZA8Y+O7QFfVB0/62@yuki>
 <20230313134624.GA9783@localhost> <ZA8t7hVYRmF+I9k0@yuki>
 <20230314053151.GA22202@localhost> <ZBAtCbeSVH0/l137@rei>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Mar 2023 08:49:18 +0000
Organization: Linux Private Site
In-reply-to: <ZBAtCbeSVH0/l137@rei>
Message-ID: <87pm9b67gc.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] madvise11.c:Check loadable module before rmmod
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> This is caused by "_" and "-", current search function not do this tricky translate part.
>> Input parameter is hwpoison_inject but actually string in modules.xxx is hwpoison-inject
>> 
>> /lib/modules/5.14.21-150400.24.41-default/modules.dep | grep hwpo
>> kernel/mm/hwpoison-inject.ko.zst:
>> 
>> Other info just FYI:
>> //modprobe can accept both "-" and "_"
>> localhost:/home/ltp # modprobe hwpoison-inject
>> localhost:/home/ltp # modprobe hwpoison_inject
>> 
>> //get info from lsmod and /proc use "_"
>> localhost:/home/ltp # lsmod | grep hwpo
>> hwpoison_inject        16384  0
>> localhost:/home/ltp # cat /proc/modules | grep hwp
>> hwpoison_inject 16384 0 - Live 0xffffffffc09d6000
>
> Sounds like a bug that shoudl be fixed, we probably need to create two
> search strings, one with dashes and one with underscores and try to
> strstr() both.

Could we not check kconfig for builtin modules?

I suppose this would require an extension to tst_kconfig, but the
information is there already.

>
> -- 
> Cyril Hrubis
> chrubis@suse.cz


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
