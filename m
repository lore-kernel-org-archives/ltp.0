Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E862AC433F5
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 14:27:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90BDE3C9536
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 15:27:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 940F23C8DA0
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 15:27:41 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F30C3200340
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 15:27:40 +0100 (CET)
Received: from [192.168.178.40] (unknown [188.192.100.83])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 95D339F7EC;
 Fri, 14 Jan 2022 14:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1642170459; bh=jHBAUIs0RjPwXeHkmbPxgQD4kcjXW69WjhxLK3tMdlU=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=XUya58LkNq3iY/ct/2Wf+qVf9MHhGE9nFC+ZQlvKrJhtTe5dr+PkPeXDaKfjPS/k4
 vvQB0gdbXMeyaaP0qQzbkdpBBJ+WBZ9ySQqElMCyupwo//54cTn7TKONO8Ez+BUJid
 N6h6fC4xed91yCtjXDYOKAmJBiNJuyIMnNouaTmU=
Message-ID: <f516568b-fa33-091c-3442-0316a78d96b1@jv-coder.de>
Date: Fri, 14 Jan 2022 15:27:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220114125513.895-1-pvorel@suse.cz> <YeGEunEuwPvNFxyS@yuki>
 <95394feb-6474-d1ca-13d8-3d1c35e781b9@jv-coder.de> <YeGHV+Gnmo59SXeL@yuki>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <YeGHV+Gnmo59SXeL@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] configure.ac: Fix summary for disabled
 metadata
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

Hi

Am 1/14/2022 um 3:23 PM schrieb Cyril Hrubis:
> The JSON metadata file is going to replace the runtest files some day,
> at least that is the longterm plan. Also the parser that extracts the
> metadata from the sources is rather fast, compared to the LTP build and
> it's self contained. There is really no reason to have a switch to
> disable the metadat extraction step.
> 
> The documentation build, on the other hand, is rather slow and requires
> asciidoc, which is the reason why there is a switch that can be used to
> disable that. The only problem here is that the name is a bit confusing
> now.
> 
Actually there is, that is where my interest in this flag comes from. We
don't use runtest files (at least not for execution), so we don't need
it and we had problems in out cross build environment, that were not
easily fixed. From looking at the source I am not sure what the problem
was and cannot spot it from looking at the source. But I know, that it
wasn't just fixed by setting the correct HOSTCC and HOST_CFLAGS. I have
a missing library in my head, but I can't see any.
All I know is that I gave up fixing the build and I don't give up easily
normally (a little easier if the functionality is not needed at all) :)

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
