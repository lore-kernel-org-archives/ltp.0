Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9155FC433EF
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 10:51:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C1E03C944B
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 11:51:52 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FBCF3C6FD5
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 11:51:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DE245600078
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 11:51:40 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 08B3221110
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 10:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647514300;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xNHpKComFRi5abogeWlnkkU+L7BakYEuzTlCZ1U584=;
 b=YfY/OX3wsZkNt5vieH4R6XsZmcDmc9pgB35jhI/SsfnEZLFjfad0021hjfG1Q1k03dozaw
 Rnyi3sQZFKYifzvGN5s6q9BfZA2nGDBQAaRY+3czKwBMdWjSwtrXOrdxE2Y8m/Rt6zLCWF
 50OKe/4ORnrohrBjYGJHswwxQlM9Qw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647514300;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xNHpKComFRi5abogeWlnkkU+L7BakYEuzTlCZ1U584=;
 b=1g4E/6/sDWyoX9XgzeofXyYPzeNb1rnQGGLY2NqyeCOrOWG3fagvjOHBZVBHkc5u6Xpf6Q
 dltfA5GluSOlNuCA==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id CEA3FA3B88;
 Thu, 17 Mar 2022 10:51:39 +0000 (UTC)
References: <20220309164954.23751-1-mdoucha@suse.cz> <87k0cv5ij5.fsf@suse.de>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 17 Mar 2022 10:42:39 +0000
In-reply-to: <87k0cv5ij5.fsf@suse.de>
Message-ID: <87pmmk4zt6.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] KVM test infrastructure
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

Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hi Martin,
>
> Martin Doucha <mdoucha@suse.cz> writes:
>
>> Implement LTP infrastructure for tests which require executing a special
>> program inside KVM virtual machine. The infrastructure is split into two parts:
>> the host library and the guest library.
>>
>> The host library provides functions for setting up and running virtual machines
>> with test payload built from test sources.
>>
>> The guest library provides CPU bootstrap code and basic implementation of
>> some C and LTP library functions as well as functions for accessing low-level
>> arch features like special registers, interrupt tables or memory mapping tables.
>>
>> The test sources will contain both guest-side payload code and host-side setup
>> code separated by preprocessor switch. The files get compiled twice with
>> different compiler options. Once to build the VM payload, once to build
>> the main program that will create the VM and execute the payload
>> inside it.
>
> This is great!
>
> Due to its size I'll just comment as I get chance to read it.

The rest looks good. I only put minimal effort into understanding the
assembly and linking, but it looks clean.

I also tested with nested virt and compiling with Clang.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
