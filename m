Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B65EE80AA0
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 07:29:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 315513CDC4E
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 09:29:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 976343C9949
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 09:28:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D903F600D23
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 09:28:49 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D72DA2185A
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 07:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695799728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qNUgekBos/eoNBgCBHLpE85i9G6R9GYaBUwyXJkePdQ=;
 b=r/5g/OHY7SOtDy4WSj3uSJAGGNgLgARnxM9fCsQRhwzHnkDKLEfc4RHz30RsYRY8lGtxhJ
 2kCbVXaPk/M0OFhjesQW7p+dQY+7H/d3JzOO6xeoOvM3qVL/4z9cEGde/p6ai91R9hs1T+
 nR4Z+NUkg0uMmA5MlmzUieIVrz6Lz98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695799728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qNUgekBos/eoNBgCBHLpE85i9G6R9GYaBUwyXJkePdQ=;
 b=O17HG9DZ4ASnF1vMjQWMPXlJJ8EgDu5OPEL4A70M1294zGgBWq4cGB+Df+uzoxFrafPJ9u
 bYe78jVZAUMLrvDw==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8DCDF2C142;
 Wed, 27 Sep 2023 07:28:48 +0000 (UTC)
References: <20230926090101.7565-1-rpalethorpe@suse.com>
 <2307102.ElGaqSPkdT@linux-9lzf>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Marius Kittler <mkittler@suse.de>
Date: Wed, 27 Sep 2023 08:00:25 +0100
Organization: Linux Private Site
In-reply-to: <2307102.ElGaqSPkdT@linux-9lzf>
Message-ID: <87ttrgdqhc.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] Add simple Alpine container
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

Marius Kittler <mkittler@suse.de> writes:

> Am Dienstag, 26. September 2023, 11:01:01 CEST schrieb Richard Palethorpe via 
> ltp:
>> Can be built with `docker/podman build .`. Then run with `podman -it
>> run sh`. It contains Kirk in /opt/kirk. So `cd /opt/kirk && ./kirk -f
>> ltp --run-suite syscalls` will run some tests.
>> ---
>> 
>> Hello,
>> 
>> This builds and installs the LTP and Kirk inside an Alpine
>> container. The idea is to use a standard container workflow to build
>> and run the LTP from source. This helps with testing LTP itself and
>> running tests inside a container.
>> 
>> I'd like to add some container files to upstream to help with various
>> workflows.
>> 
>> The container has a number of problems:
>> 
>> 1. If the Git directory has build artifacts in it, these are copied
>>    into the container (.dockerignore may help)
>
> Doing an out-of-source-tree build might also help. Even just printing a 
> warning/error in case the repository has already been configured might be good 
> enough.

Good idea, perhaps check with Git that it is a clean
checkout. Especially because one could accidentally copy private files
into the container.

>
>> 3. Where should we put container files and how should we name them?
>
> Maybe just a subdirectory `container` and within that one subdirectory for 
> each container.
>
>> Also, for developing tests, it may be better to build the LTP outside
>> of a container then copy in the files.
>
> How would you do that? Relevant container-specific dependencies such as musl 
> are within the container. One had to expose the container's filesystem tree 
> somewhere in the regular filesystem and had to use that as prefix. That doesn't 
> seem like an easy way of doing things.
>
> By the way, to develop "[PATCH v1] Skip cgroup-related tests if `/sys/fs/
> cgroup` readonly" I simply started on a fresh Alpine container, invoked our CI 
> script for installing dependencies, followed the build instructions from the 
> README, committed the container for later use and then just continued 
> developing within the container as usual. (I was still using my editor from 
> outside the container. So the clangd integration still assumed glibc headers. 
> Maybe one could expose the container's filesystem on the host and change 
> include paths via `.clangd` to prefer musl headers from within the container.)

I'm not sure, you can export the LTP dir as a volume and use 'podman cp'
to copy the headers to somewhere on your host. This does feel hacky
though.

I suppose if clangd can run inside the container then it should be
possible to export its ports and connect to it from outside. However I
just have a checkout of the musl repo and manually search it.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
