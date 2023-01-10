Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D027C46467
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 09:57:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A99A53CCB2C
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 10:57:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A30743CB575
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 10:57:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B65E9200074
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 10:57:04 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D90E268048
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 09:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673344623;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rBFdyyF/PkPijAWxHGG/CsCuw3/ts2uejxUB64Cinyc=;
 b=0gPq3CWDEJ4oZu+Dni/jUX80yEEeUjLWJ9+FVrzYX6hTrlpWCxvlaVVzje/Dvc3ZhstRS5
 N+JXa4G9Z/naJSNO8p4IrcwflKbzyE3jLGBauNnmhJV8WihD9fpojUNFeyod5TBtv0k2Vg
 IACf0ePuMTH0ZBpVn8TsV3JBEGjXoFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673344623;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rBFdyyF/PkPijAWxHGG/CsCuw3/ts2uejxUB64Cinyc=;
 b=PfjLSfDuzrQk9G3KZI/REuK/mAmXxxftEDzyAY2QiQI/K7VOgnAoU22m8ncopi5rGk3EHJ
 BkM5guLm5zOZxoAA==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 986A42C141;
 Tue, 10 Jan 2023 09:57:03 +0000 (UTC)
References: <20230104100730.20425-1-pvorel@suse.cz>
 <2226132.28uSQYClPH@localhost>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Tue, 10 Jan 2023 09:56:42 +0000
Organization: Linux Private Site
In-reply-to: <2226132.28uSQYClPH@localhost>
Message-ID: <874jsyiufl.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] github: Improve pull request template
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

Please merge.

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

Avinesh Kumar <akumar@suse.de> writes:

> Hi,
>
> Reviewed-by: Avinesh Kumar <akumar@suse.de>
>
> On Wednesday, January 4, 2023 3:37:30 PM IST Petr Vorel wrote:
>> * Signed-off-by
>> * code style
>> * links to wiki (API, maintainer checklist, ...)
>> * wrap text in html comments (instructions will not be visible)
>> 
>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>> ---
>>  .github/pull_request_template.md | 20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
>> 
>> diff --git a/.github/pull_request_template.md b/.github/pull_request_template.md
>> index 477f49c6bc..1082bcdd88 100644
>> --- a/.github/pull_request_template.md
>> +++ b/.github/pull_request_template.md
>> @@ -1,8 +1,22 @@
>>  [ type description here; PLEASE REMOVE THIS LINE AND THE LINES BELOW BEFORE SUBMITTING THIS PULL REQUEST ]
>>  
>> -Although we *occasionally* also accept GitHub pull requests, the *preferred* way is sending patches to our mailing list: https://lore.kernel.org/ltp/
>> -
>> +<!--
>> +* Although we *occasionally* also accept GitHub pull requests, the *preferred* way is sending patches to our mailing list: https://lore.kernel.org/ltp/
>>  There is an example how to use it:
>> https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial#7-submitting-the-test-for-review
>> (using git format-patch and git send-email).
>> -
>>  LTP mailing list is archived at: https://lore.kernel.org/ltp/.
>>  We also have a patchwork instance: https://patchwork.ozlabs.org/project/ltp/list/.
>> +
>> +* Commits should be signed: Signed-off-by: Your Name <me@example.org>, see
>> +https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
>> +
>> +* New code should follow Linux kernel coding style, see
>> +https://www.kernel.org/doc/html/latest/process/coding-style.html.
>> +You can run 'make check' or 'make check-foo' in the folder with modified code to check style and common errors.
>> +
>> +* For more tips check
>> +https://github.com/linux-test-project/ltp/wiki/Maintainer-Patch-Review-Checklist
>> +https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
>> +https://github.com/linux-test-project/ltp/wiki/C-Test-API
>> +https://github.com/linux-test-project/ltp/wiki/Shell-Test-API
>> +https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
>> +-->
>> 
>
> Regards,
> Avinesh


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
