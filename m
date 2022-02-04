Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1199EC433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 06:37:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 996563C9AB9
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 07:37:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92A5E3C9736
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 07:37:17 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C186A1000650
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 07:37:16 +0100 (CET)
Received: from [192.168.178.40] (unknown [188.192.100.83])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 26D8A9F75F;
 Fri,  4 Feb 2022 06:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1643956635; bh=4JDo494rBv/HPB2Bv2uFDsmK7U6MvvQ8Jm7J04bZKtE=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=YxYvaO5s1ajAIYzBmIVv0uWdI9HEo3IgrL584YTPakYuw/YFnK/KUK7N30OqEXfuM
 XDSBwmbc8rkAFfJ9wlqIgYCdNKxyV/V3K2FP3/CZtUFKidlkK/KIlHffv0HzwSpfkQ
 s5cKJMCv+vp9EAyoIHcpVGZqm616dlROyIY2O90c=
Message-ID: <98b74837-379b-4fe5-e457-be9e8dcd35b2@jv-coder.de>
Date: Fri, 4 Feb 2022 07:37:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <YfwVcwpZU/lusVlC@pevik>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <YfwVcwpZU/lusVlC@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] SCTP testing
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
Cc: ltp@lists.linux.it, Joerg Vehlow <joerg.vehlow@aox-tech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Am 2/3/2022 um 6:48 PM schrieb Petr Vorel:
> Hi all,
> 
> we've been just discussing, which repository should be hosting SCTP tests [1].
> 
> Do you use these SCTP tests? If yes, do you use it from LTP [2] or the official
> SCTP kernel developers repository [3] ? If you use integrated to some testing
> framework, would it be a problem if repository changes?
We would run these tests, if our kernels would have SCTP enabled. I
don't think this will happen any time soon and I don't really see a
problem pulling sctp tests from another repo.

> 
> Also, do you use LTP network tests at all?
Yes we are trying to run as many ltp tests as possible.

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
