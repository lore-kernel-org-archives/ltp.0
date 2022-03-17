Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F26C433EF
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 07:33:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64FB23C93E9
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 08:33:52 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 299793C1B7F
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 08:33:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 90601607BB3
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 08:33:42 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 75496210FA;
 Thu, 17 Mar 2022 07:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647502421;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MeYSyqroY5LFca5DFiKTTas+YTEYLwVsraZ5hrFDqwo=;
 b=xrs15MbZYMuCzFRH0/sQG8BN051FuL08fI9hiMKnpV1Kxa74bp9KgFlutAAVXbbbOGjIBC
 zMD0bqx9IVCKEW9hsgnUGT81KlcTRxDl2hB77DX7jTOAz5VVghCgTZ9XjXnCfgoKQqoIXt
 +9cp1cjEE3asR5GJUhnfW3ycufS78t4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647502421;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MeYSyqroY5LFca5DFiKTTas+YTEYLwVsraZ5hrFDqwo=;
 b=WhEDSl1nVLnJraQ111bA0NFet0YOioV00i7oPtEZqzJ+MNtlpJofcIGaxv9obwGFQGK3ma
 Tslaesp+VdfhMGCw==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 300F7A3B92;
 Thu, 17 Mar 2022 07:33:41 +0000 (UTC)
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <baec527891fe83e75958f9db3634f1a0a828bf07.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <871qzeniu7.fsf@suse.de>
 <CADS1e3ff7dnQe8zByitszNhKViiOLOF-UfNtSbMsFkkSX5Sy7Q@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Thu, 17 Mar 2022 07:07:49 +0000
In-reply-to: <CADS1e3ff7dnQe8zByitszNhKViiOLOF-UfNtSbMsFkkSX5Sy7Q@mail.gmail.com>
Message-ID: <878rt958yz.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 04/16] API/cgroup: Implement tst_cg_load_config
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Luke,

>
> Thank you for pointing all these things out. I forgot about all the shenanigans that can happen when you don't sanity check string stuff :)
>
> A few solutions to creating the scanff format are:
> 1) pre-processor trick to concatenate defines into a string, something like this
> #define _tostr(str) #str
> #define tostr(str) _tostr(str)
> #define CONFIG_FORMAT "%" tostr(CTRL_NAME_MAX) "s\t%d\t%d\t%" tostr(PATH_MAX) "s\t%d\t%d\t%" tostr(NAME_MAX) "s"
>
> 2) just hardcode the lengths to avoid all of this nonsense above

I would have done 2 in this case, but you figured out 1, so feel free to
use that. In fact that would be a nice addition to LTP's standard macros
(but with TST_ prefix).

Just note that the maximum conversion length doesn't include
the null character. scanf will write the null character after the
maximum conversion length. Also I'm not sure the field length comes
after '%' or that you use 's' with a length; possibly it should be
'%c63' to scan a 64 byte null terminated string. However please double
check the man page.

>
> 3) just create the format at runtime

IIRC this is considered unsafe and will result in warnings and errors.

>
> I'm more or less asking what you think is best to avoid sending out all of the patches and then discussing this / if there is a better way. 
>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
