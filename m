Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0649C7113B
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 09:04:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1D173CC48F
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 11:04:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2BD43CC48F
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 11:04:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7D39960065E
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 11:04:27 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7D3BC22D22;
 Thu, 24 Aug 2023 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692867867;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X5A2ueNdRWVNnpuwCuhqcrWFox2oJ1tXTF2lR/QYTE0=;
 b=tNmNSBjLomWgIXiEdAfkBpYXqp/1YLUkp111E+Z5W0sMH6ZtgjzMOBtzWUXSAchZZBFILO
 wibzfRjzllLokyoLAPI4zIUfWHxbZUm8coJXceFYz4/5mkHoNJuqxb5sKATPi0m67Sb1rz
 B1yVw4jxeQ/AsbppO6f0rIk1eTaHCwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692867867;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X5A2ueNdRWVNnpuwCuhqcrWFox2oJ1tXTF2lR/QYTE0=;
 b=BIHB3B5TfQDlz7zuII/LrO5lgTGSsMWiYnU0wZAUZIF1VdGOFjC6mTtopw7EWGMd0kug1q
 3O+BHtkxxG9/BEAg==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 507072C239;
 Thu, 24 Aug 2023 08:50:40 +0000 (UTC)
References: <20230822101333.16993-1-rpalethorpe@suse.com>
 <ZOXZarakyIoZeqQ-@yuki> <87pm3deutt.fsf@anais.suse.cz>
 <ZOYPNYnSqc2geOmR@yuki>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 24 Aug 2023 09:13:31 +0100
Organization: Linux Private Site
In-reply-to: <ZOYPNYnSqc2geOmR@yuki>
Message-ID: <87zg2gddsx.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add goals of patch review and tips
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
>> >> +The following are examples and may not be appropriate for all tests.
>> >> +
>> >> +* Merge the patch. It should apply cleanly to master.
>> 
>> As a newbie with LTP I am still struggling to understand some things
>> like this one. How is possible to merge to master in order to review?
>
> Obviously you do that to your local git tree. This is basics of git
> development nothing specific to LTP here.

I suppose it would not hurt to add "to your local copy of the master
branch". It's only a few more words that would clean it up (IMO). If
that doesn't make sense then you will have to do a search or ask someone
because this document can't be too long.

>
>> >> +## How to get patches merged
>> 
>> Again from my POV the description is more about what you should do as a
>> reviewer than how to get a patch merged.
>
> Isn't that the same? If you know what are developers doing in order to
> catch common mistakes you can as well avoid doing them...
>

Perhaps we are not doing a good job of marketing patch review in this
document, but it is probably also outside the scope of this document.

>> >> +Once you think a patch is good enough you should add your Reviewed-by
>> >> +and/or Tested-by tags. This means you will get some credit for getting
>> >> +the patch merged. Also some blame if there are problems.
>> >> +
>> >> +If you ran the test you can add the Tested-by tag. If you read the
>> >> +code or used static analysis tools on it, you can add the Reviewed-by
>> >> +tag.
>> >> +
>> >> +In addition you can expect others to review your patches and add their
>> >> +tags. This will speed up the process of getting your patches merged.
>> >> +
>> >> +## Maintainers Checklist
>> >
>> > Looks very nice, thanks for writing this out.
>> >
>> > Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>> >
>> > -- 
>> > Cyril Hrubis
>> > chrubis@suse.cz
>> 
>> I feel that this is more an overview and reminder of already
>> contributors. Not sure how helpful is it for new comers like myself
>
> I think that there are different levels of newcommers. I do not think
> that the documment is supposed to help newcommers that are already
> familiar with how git based development works and only highlights
> things that are specific to LTP.

Yup, there is a long tutorial which explains in depth a lot of stuff and
this could be expanded, but I don't have time for that right now.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
