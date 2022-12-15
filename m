Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696EAC4332F
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 09:31:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4C233CBCAA
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 10:31:43 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9B643CBC7E
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 10:31:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 138B41A006EB
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 10:31:32 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 014201FE0E;
 Thu, 15 Dec 2022 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1671096692;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a7co0tmv/+0alDtQEd5daiHW2LR9pN90iRWqO2EQYqY=;
 b=FpFP/rr5zqrwCYu5mZjZK9yYzrdx1raGBH07wtJKyiScXtIorr9YBeBIOHwmY5UfcvdcJ9
 5NWmhdKVJ2tlm3e/hqmV2fXIZW64HK3x5LP4crg4PoEyAjKYw4lk9xxGgmRYfbLxXmo0G/
 B+XSEgV23aXuYkECwTHIUAz1hk6IBmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1671096692;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a7co0tmv/+0alDtQEd5daiHW2LR9pN90iRWqO2EQYqY=;
 b=nA1CTyUbRIZ8RCSfhaxEy+BH5wndCInWsHjKQYdYjVp9LZXqdHraRGxmXH3RDv7S8GEAr0
 DPnHTAFFS6ridwCQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 89B612C141;
 Thu, 15 Dec 2022 09:31:31 +0000 (UTC)
References: <20221209141002.15551-1-pvorel@suse.cz> <87bko7sinw.fsf@suse.de>
 <Y5jQDt7A/VmUZp9G@pevik>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Dec 2022 08:45:05 +0000
Organization: Linux Private Site
In-reply-to: <Y5jQDt7A/VmUZp9G@pevik>
Message-ID: <87359hqahb.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] ci: Add hook to mirror docparse to homepage
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
Cc: ltp@lists.linux.it, Aleks L <aleksandrosansan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
> first, thank you for your review!
>
>> Hello,
>
>> Petr Vorel <pvorel@suse.cz> writes:
>
>> > GitHub Actions git push hook generates metadata HTML and push it
>> > to LTP homepage.
>
>> > Hook pushes only if there are actual changes in generated doc.
>
>> IIUC we have to do most of the work to generate the meta data, but then
>> don't push it if there is no diff?
>
>> What are we saving with this optimisation?
>
> This saves number of commits which will change nothing.
> Because the page itself has also other changes for the web page itself,
> which will be buried with these changes.
> But sure, I'll remove this check, if considered useless.

I think the root of the problem is that we are publishing to a branch
which makes sense if we write the HTML by hand.

However we are generating it from multiples sources. So this doesn't
work well with Git.

Why not use the upload assets method?:

https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site#creating-a-custom-github-actions-workflow-to-publish-your-site

>
> If your comment is about to do the detection earlier,
> I'd have to do some smart 'git diff'. Could be done with:
> git diff $old_commit testcases/ | grep '^+ \* '
> in step "Check metadata need to be updated"
> (i.e. after both checkouts).
>
>
>> > NOTE: this change requires to add:
>
>> > 1) Personal Access Token (PAT) to any developer which has write access
>> > to homepage git repository [3]. In Developer settings -> Personal access
>> > tokens -> Tokens (classic) [4]), where set:
>> > Note: GH_PERSONAL_ACCESS_TOKEN
>> > Select scopes: public_repo (minimal permission)
>> > Expiration: either never or regularly renew.
>
>> > 2) Allow PAT in LTP organisation (I dared to already set it)
>> > Iin linux-test-project group -> Settings -> Third-party Access -> Personal
>> > access tokens -> Settings [5]
>> > select:
>> > Allow access via personal access tokens (classic)
>> > API and Git access will be allowed using an organization member's personal access token (classic)
>
>> > 3) Add repository action secret to ltp repository
>> > IN Settings -> Actions -> New repository secret [6]:
>> > name: GH_PERSONAL_ACCESS_TOKEN
>> > value: the value of previously created token.
>
>> > Because using token, default permission is just read.
>
>> This seems like a very convoluted process. Can't we just put the
>> metadata generation in the docs build and upload the assets as usual?
>> I've never had to use a PAT to deploy a github page.
>
> Do you mean to have this Action in linux-test-project.github.com git repo?
> What would trigger the build? Some kind of cron behavior?
> Using PAT is a weak point thus I'm really open to other solutions.

I guess a github action can be triggered by multiple sources, including
other actions and the assets from one action should be available in the
next.

I'm more familiar with GitLab, but this is basic build pipeline stuff,
so GitHub should support it.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
