Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8334C369B2
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 15:42:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CC3B3CB740
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 17:42:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 757393C6792
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 17:41:45 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2BA9D1400198
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 17:41:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B59D1F7AB;
 Mon, 14 Apr 2025 15:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744645303;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zsD3mu7BYw77JwOFGb5N1FKujLkUY3HuYOnuJJZjEGs=;
 b=X72EHLSsvEx1vPr7jGTN7PbP9QzAQwX0Szf+MOdTkmksBJopR9gC0z9/7GIQRVvaJy/NO8
 VPQna3aFumWIwsoC6e8JC3zsEaVmq5aeYMdS2Svsvofh96lIcHD4il35QqRT/sqgdpHvHv
 RijW06EqovAD9pGJnIv7HsXbkDf7O40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744645303;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zsD3mu7BYw77JwOFGb5N1FKujLkUY3HuYOnuJJZjEGs=;
 b=qre1Aq3l6DuWjZbWBpvUVDnMjOIQxdd4f4jHKnG084OLdZpYHmiGgWu/NlMLDwCTkPKYx8
 5ii/aZiNrW++YPDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X72EHLSs;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qre1Aq3l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744645303;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zsD3mu7BYw77JwOFGb5N1FKujLkUY3HuYOnuJJZjEGs=;
 b=X72EHLSsvEx1vPr7jGTN7PbP9QzAQwX0Szf+MOdTkmksBJopR9gC0z9/7GIQRVvaJy/NO8
 VPQna3aFumWIwsoC6e8JC3zsEaVmq5aeYMdS2Svsvofh96lIcHD4il35QqRT/sqgdpHvHv
 RijW06EqovAD9pGJnIv7HsXbkDf7O40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744645303;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zsD3mu7BYw77JwOFGb5N1FKujLkUY3HuYOnuJJZjEGs=;
 b=qre1Aq3l6DuWjZbWBpvUVDnMjOIQxdd4f4jHKnG084OLdZpYHmiGgWu/NlMLDwCTkPKYx8
 5ii/aZiNrW++YPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9714136A7;
 Mon, 14 Apr 2025 15:41:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Vp32N7Ys/WcYKAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 14 Apr 2025 15:41:42 +0000
Date: Mon, 14 Apr 2025 17:41:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250414154141.GC443040@pevik>
References: <20250411114326.526-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250411114326.526-1-andrea.cervesato@suse.de>
X-Rspamd-Queue-Id: 1B59D1F7AB
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 0/4] Support for Patchwork CI
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Add support for patch-series validation in the patchwork ML.
> We use Github to schedule a trigger every 30 minutes, checking for new
> patche-series in parchwork which has not been tested yet.

> The way we decide if a patch-series has been tested in patchwork, is
> by looking at its status (in particular, if it's "Needs Review / ACK"),
> as well as checking if test report has been uploaded to any of the
> series patches.

> All communication to Patchwrok is done via REST API, using curl and js
> tools.

> First, we create a script called patchwork-ci.sh that provides all the
> commands to read new untested patch-series, set their status and testing
> report. Then, we create a scheduled workflow in Gitlab, checking every
> 30 minutes if there are new untested patch-series. At the end, we
> trigger the main build workflow, used to validate LTP commits in our
> Github mainline. All the times we trigger the build workflow, we also
> provide the patch-series ID, that will be fetched and applied on the
> current branch before running the tests.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v4:
> - patchwork script is now a tool that can be used independently to ci

> Andrea Cervesato (4):
>   ci: install dependences for patchwork-ci script
>   ci: add patchwork communication script

Thanks a lot for this patchset!

We had some discussion about 3rd patch missing.
For these who want to see it, I suppose your branch is online on your LTP fork:
https://github.com/acerv/ltp/tree/refs/heads/b4/patchwork_ci

TL;DR
1) and 2) should be solved, the rest can be ignored.

1) Run only on single repo (IMPORTANT)

I was worried that the workflow from 3rd (missing) patch will cause to be run on
any fork which has this merged to master and indeed it does:

https://github.com/pevik/ltp/actions/workflows/ci-patchwork-trigger.yml

We should limit it to the repository we want to use it, e.g. for official LTP
it'd be:

if: ${{ github.repository == 'linux-test-project/ltp' }}

Sure, it will fail when run without patchwork token and even if token set on
more repos it will quit testing when status is already set, but still - why to
pollute all forks GitHub Actions and query patchwork from many forks? (FYI we
have 1041 forks, sure most of them don't have GitHub Actions enabled and many of
them will never get updated).

And yes, I'll later today remove it from my master branch.

2) Where to to run the CI
FYI ATM the testing is done at Andrea's fork (see many jobs with "Patchwork
checker"): https://github.com/acerv/ltp/actions

IMHO it'd be worth to create test repo in linux-test-project org on github
(independent on any of us), maybe name it ltp-ci or ltp-test with warning
in the description it's just a testing repo? Or would it be too confusing?

Why?
- Independent on any of us.
- It pollutes project GitHub Actions quite a lot, maybe it'd be better to not
use on linux-test-project/ltp ("Patchwork checker" actions from cron + actual
builds "Test building in various distros in Docker").

3) Testing on master branch
The reason, why jobs in https://github.com/acerv/ltp/actions are tested on
master branch (not on ci/452320 - where number would be number of the series) is
the GitHub Action limitation when using schedule:

https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows#schedule
"This event will only trigger a workflow run if the workflow file is on the default branch."
=> that should be solved by merge

"Scheduled workflows will only run on the default branch."
=> People suggest to use a reusable workflow
https://github.com/orgs/community/discussions/16107
https://docs.github.com/en/actions/sharing-automations/reusing-workflows#creating-a-reusable-workflow
But I'm perfectly ok with this state, unless you have energy to test it with

with:
    ref: ci

This should use 'ci' branch instead of the default 'master'.

4) Workflow just to push branch (different approach)
I originally had a different idea: with first workflow apply patches and push
them to some fork (not to the official repo, e.g. to linux-test-project/ci
repo), which would trigger CI build.

Pros
* Not having to download from patchwork and apply patches for each of our 16
builds. Our patchwork instance maintainers might appreciate if we try to
minimize the load :).
* Having non-default branch (e.g. not everything on master, solves 3).
* Having branch created for anybody who wants to test it (probably nobody will
not import remote with so many branches).

Cons
* Probably better would be to do some branch cleanup.

Maybe we could start using --volume to share stored data:

options: --volume /tmp/shared:/shared

5) Link to patchwork series in GitHub Actions job
Currently if you spot failure on GitHub Actions job, you will not be
able to find the code on patchwork (even series ID would be enough).

See:
https://github.com/acerv/ltp/actions/runs/14447250705
does not link to
https://patchwork.ozlabs.org/project/ltp/patch/20250415013944.173030-3-wegao@suse.com/

Some info in CI job about the patch would be helpful (more important due 4),
because with specific branches ci/452320 it'd be more obvious what is being tested).

One can dig the info from logs from "Apply Patchwork series":
+ curl -k https://patchwork.ozlabs.org/series/452267/mbox/

That can be enough.

But ideally there would be link to patchwork series, or at least "Test building
in various distros in Docker" title was extended to have also series ID.

6) Links in Patchwork contains job ID
It would be nice if links in the patchwork table contain also job to the specific distro, e.g.
https://github.com/acerv/ltp/actions/runs/14447250705/job/40510755305

Instead of plain
https://github.com/acerv/ltp/actions/runs/14447250705
for all jobs. No problem if not easily done.

Kind regards,
Petr

>   ci: add ci-patchwork-trigger workflow
>   ci: apply patchwork series in ci-docker-build workflow

>  .github/workflows/ci-docker-build.yml      |  39 +++-
>  .github/workflows/ci-patchwork-trigger.yml |  63 +++++++
>  ci/alpine-runtime.sh                       |   2 +
>  ci/alpine.sh                               |   2 +
>  ci/debian.i386.sh                          |   2 +
>  ci/debian.sh                               |  28 +--
>  ci/fedora.sh                               |   2 +
>  ci/tools/patchwork.sh                      | 197 +++++++++++++++++++++
>  ci/tumbleweed.sh                           |   2 +
>  9 files changed, 323 insertions(+), 14 deletions(-)
>  create mode 100644 .github/workflows/ci-patchwork-trigger.yml
>  create mode 100755 ci/tools/patchwork.sh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
