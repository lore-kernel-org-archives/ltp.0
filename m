Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC418C6FD1D
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 07:31:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E91863CD233
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 08:30:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D83D53C0214
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 08:30:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1154E200ADA
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 08:30:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1392C5BF35;
 Thu, 23 Mar 2023 07:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679556648;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6PZec/EPDkrBuTmTin8MJ2FgO8YKv4NcAdgtWVBEfjs=;
 b=llny95H8wRP01QvAxeVMyMKB1499sJfZVI5/yqcaIHpV/53940MnYSLN0XiuU9fc5ifYQ+
 jB/+eadNqnBKTJdUi3RrZ53D4CTJGoOi2Zax97nLw0NlXQzNAPvVCpAPo0P/H8SbDhKSx/
 eITj18O4IAGRX0774NABxm15nBxgW/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679556648;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6PZec/EPDkrBuTmTin8MJ2FgO8YKv4NcAdgtWVBEfjs=;
 b=btLAKR9L3QhXNz/BFfOmVbS+/E6ChcA50oXgr94YRxQksGWjoYBL/lSZKPROJRVN2JRjab
 kPvATE8PJXQCQQDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2420132C2;
 Thu, 23 Mar 2023 07:30:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GCmRMScAHGRoAwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Mar 2023 07:30:47 +0000
Date: Thu, 23 Mar 2023 08:30:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20230323073046.GD381848@pevik>
References: <20221209141002.15551-1-pvorel@suse.cz> <87bko7sinw.fsf@suse.de>
 <Y5jQDt7A/VmUZp9G@pevik> <87359hqahb.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87359hqahb.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Aleks L <aleksandrosansan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie, Cyril,

> Hello,

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi Richie,

> > first, thank you for your review!

> >> Hello,

> >> Petr Vorel <pvorel@suse.cz> writes:

> >> > GitHub Actions git push hook generates metadata HTML and push it
> >> > to LTP homepage.

> >> > Hook pushes only if there are actual changes in generated doc.

> >> IIUC we have to do most of the work to generate the meta data, but then
> >> don't push it if there is no diff?

> >> What are we saving with this optimisation?

> > This saves number of commits which will change nothing.
> > Because the page itself has also other changes for the web page itself,
> > which will be buried with these changes.
> > But sure, I'll remove this check, if considered useless.

> I think the root of the problem is that we are publishing to a branch
> which makes sense if we write the HTML by hand.

> However we are generating it from multiples sources. So this doesn't
> work well with Git.

> Why not use the upload assets method?:

> https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site#creating-a-custom-github-actions-workflow-to-publish-your-site

Thanks for a hint, actions/checkout [1] looks useful.

@Cyril We currently have github pages uploaded within separate repository [2],
we'd need to convert it to Publishing with a custom GitHub Actions workflow [3].
That would include to migrate the necessary content (index.html and assets
directory) to ltp repository (put into new web directory) and create new GitHub
Actions workflow (examples [4] [5]).

This would help that 1) we'd not need Personal Access Token (everything is in
single repository) 2) only a real sources would be stored in git, not generated
files. It's not a high priority for me, but I'm willing to implement everything,
if I got ack from you.

> > If your comment is about to do the detection earlier,
> > I'd have to do some smart 'git diff'. Could be done with:
> > git diff $old_commit testcases/ | grep '^+ \* '
> > in step "Check metadata need to be updated"
> > (i.e. after both checkouts).


> >> > NOTE: this change requires to add:

> >> > 1) Personal Access Token (PAT) to any developer which has write access
> >> > to homepage git repository [3]. In Developer settings -> Personal access
> >> > tokens -> Tokens (classic) [4]), where set:
> >> > Note: GH_PERSONAL_ACCESS_TOKEN
> >> > Select scopes: public_repo (minimal permission)
> >> > Expiration: either never or regularly renew.

> >> > 2) Allow PAT in LTP organisation (I dared to already set it)
> >> > Iin linux-test-project group -> Settings -> Third-party Access -> Personal
> >> > access tokens -> Settings [5]
> >> > select:
> >> > Allow access via personal access tokens (classic)
> >> > API and Git access will be allowed using an organization member's personal access token (classic)

> >> > 3) Add repository action secret to ltp repository
> >> > IN Settings -> Actions -> New repository secret [6]:
> >> > name: GH_PERSONAL_ACCESS_TOKEN
> >> > value: the value of previously created token.

> >> > Because using token, default permission is just read.

> >> This seems like a very convoluted process. Can't we just put the
> >> metadata generation in the docs build and upload the assets as usual?
> >> I've never had to use a PAT to deploy a github page.

> > Do you mean to have this Action in linux-test-project.github.com git repo?
> > What would trigger the build? Some kind of cron behavior?
> > Using PAT is a weak point thus I'm really open to other solutions.

> I guess a github action can be triggered by multiple sources, including
> other actions and the assets from one action should be available in the
> next.

> I'm more familiar with GitLab, but this is basic build pipeline stuff,
> so GitHub should support it.

FYI I find hint to use workflow_dispatch [6], but doc states [7] that for
triggering a workflow from a workflow (our case) secrets.GITHUB_TOKEN (IMHO
within repository) cannot be used. Instead, personal access token must be set
(in one of the developers account), store it in your repo or orgs secrets and
reference that instead. i.e. the same approach I already implemented.  Maybe
this reversed approach would be cleaner, but as they both require PATH, from the
security point they are the same.

=> Using actions/checkout is better solution for us anyway. But it's good to
know, that any actions between repos requires Personal access token (fortunately
we will never need to some triggering between subprojects). I'm not sure gitlab
would be easier on this, but we're not going to migrate to gitlab anyway.

Kind regards,
Petr

[1] https://github.com/actions/upload-pages-artifact
[2] https://github.com/linux-test-project/linux-test-project.github.com
[3] https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site#publishing-with-a-custom-github-actions-workflow
[4] https://github.com/jendrikseipp/rednotebook/blob/master/.github/workflows/web.yml
[5] https://github.com/conda/conda-package-streaming/blob/main/.github/workflows/sphinx.yml
[6] https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#workflow_dispatch
[7] https://docs.github.com/en/actions/using-workflows/triggering-a-workflow#triggering-a-workflow-from-a-workflow

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
