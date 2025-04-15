Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FCCC369B4
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 09:50:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 838CD3CB885
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 11:49:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43A533C2EFA
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 11:49:40 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7ADB21000DE5
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 11:49:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7BC01F387;
 Tue, 15 Apr 2025 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744710576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ULWqXaJoLoB52azPUOyRkcvPQLUAui+YQp9kjN6CWaU=;
 b=Jr25mr5yr/5vwyjk61eeFaRwsxK+9e2FBV4HUbrQYPubMkrGbY5LsWRJjKCFVBoK9uF2ut
 udb+60xH7mA/XXUL4YRrpBDF3wawunt5k7gG+//HoaTLN2MuXXtlUUl/i1TdiKA+FDIfzu
 L/17p4JcLUNFyYyPuixLMR6oxqElVzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744710576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ULWqXaJoLoB52azPUOyRkcvPQLUAui+YQp9kjN6CWaU=;
 b=kUbAr2Z/H9vhfwj29NGL/NIJkfIZ+O6EIpApSm47c+GCaai60uB0vT9WYuJy5SNrOc3Pzt
 0cMGsOzzh+AltZBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744710575;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ULWqXaJoLoB52azPUOyRkcvPQLUAui+YQp9kjN6CWaU=;
 b=QXvEsTpVESjLah8O4b8AM9O94f4IY7ZngQ+vZS0fxhmhQ3LtU9uWrXnQi6CF3K63w6PrGj
 eab7krLftPrq7lNns8y2JakqzWvKjnKCx6rA5WoGkPWG7kbmIA77aDqwp+JGFpBllP7+CJ
 mL9uGyWW+pNmel90n/f9rbgcJBx5muA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744710575;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ULWqXaJoLoB52azPUOyRkcvPQLUAui+YQp9kjN6CWaU=;
 b=2xX1TaSnpwyiRtdJSHlP/mOmlglwKFOcElFpBakNO1TnVAivLlrcpjDF4rfpM89cFrsmyC
 y5l7hqET1TCIwmDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 863D1139A1;
 Tue, 15 Apr 2025 09:49:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RsPlHq8r/mdUXgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 15 Apr 2025 09:49:35 +0000
Date: Tue, 15 Apr 2025 11:49:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250415094934.GB473949@pevik>
References: <20250411114326.526-1-andrea.cervesato@suse.de>
 <20250414154141.GC443040@pevik>
 <bcf4c112-75d7-4a4a-a9ba-0579455a9fa9@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bcf4c112-75d7-4a4a-a9ba-0579455a9fa9@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Hi Petr,

> some comments below.

> On 4/14/25 17:41, Petr Vorel wrote:
> > Hi Andrea,

> > > Add support for patch-series validation in the patchwork ML.
> > > We use Github to schedule a trigger every 30 minutes, checking for new
> > > patche-series in parchwork which has not been tested yet.
> > > The way we decide if a patch-series has been tested in patchwork, is
> > > by looking at its status (in particular, if it's "Needs Review / ACK"=
),
> > > as well as checking if test report has been uploaded to any of the
> > > series patches.
> > > All communication to Patchwrok is done via REST API, using curl and js
> > > tools.
> > > First, we create a script called patchwork-ci.sh that provides all the
> > > commands to read new untested patch-series, set their status and test=
ing
> > > report. Then, we create a scheduled workflow in Gitlab, checking every
> > > 30 minutes if there are new untested patch-series. At the end, we
> > > trigger the main build workflow, used to validate LTP commits in our
> > > Github mainline. All the times we trigger the build workflow, we also
> > > provide the patch-series ID, that will be fetched and applied on the
> > > current branch before running the tests.
> > > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > > ---
> > > Changes in v4:
> > > - patchwork script is now a tool that can be used independently to ci
> > > Andrea Cervesato (4):
> > >    ci: install dependences for patchwork-ci script
> > >    ci: add patchwork communication script
> > Thanks a lot for this patchset!

> > We had some discussion about 3rd patch missing.
> > For these who want to see it, I suppose your branch is online on your L=
TP fork:
> > https://github.com/acerv/ltp/tree/refs/heads/b4/patchwork_ci

> > TL;DR
> > 1) and 2) should be solved, the rest can be ignored.

> > 1) Run only on single repo (IMPORTANT)

> > I was worried that the workflow from 3rd (missing) patch will cause to =
be run on
> > any fork which has this merged to master and indeed it does:

> > https://github.com/pevik/ltp/actions/workflows/ci-patchwork-trigger.yml

> > We should limit it to the repository we want to use it, e.g. for offici=
al LTP
> > it'd be:

> > if: ${{ github.repository =3D=3D 'linux-test-project/ltp' }}

> > Sure, it will fail when run without patchwork token and even if token s=
et on
> > more repos it will quit testing when status is already set, but still -=
 why to
> > pollute all forks GitHub Actions and query patchwork from many forks? (=
FYI we
> > have 1041 forks, sure most of them don't have GitHub Actions enabled an=
d many of
> > them will never get updated).

> > And yes, I'll later today remove it from my master branch.
> The scheduling is indeed bugged at the moment. We need to restrict to
> linux-test-project user only. Thanks for pointing it out.

Great, thanks! (As I wrote this is the only thing which should be fixed).

> > 2) Where to to run the CI
> > FYI ATM the testing is done at Andrea's fork (see many jobs with "Patch=
work
> > checker"): https://github.com/acerv/ltp/actions

> > IMHO it'd be worth to create test repo in linux-test-project org on git=
hub
> > (independent on any of us), maybe name it ltp-ci or ltp-test with warni=
ng
> > in the description it's just a testing repo? Or would it be too confusi=
ng?

> > Why?
> > - Independent on any of us.
> > - It pollutes project GitHub Actions quite a lot, maybe it'd be better =
to not
> > use on linux-test-project/ltp ("Patchwork checker" actions from cron + =
actual
> > builds "Test building in various distros in Docker").
> Yes it "pollutes" the actions list, but actions list has a filter on the
> left exactly for this reason.
> We can also add a new repo "ltp-ci". The only "problem" is the sync. We n=
eed
> to mirror the main ltp repo to ltp-ci and I guess GitHub has a feature for
> this. I wouldn't do it in the scripts: less commands in the workflow, less
> chance to fail it.

Sure, let's keep it on the linux-test-project/ltp unless it shows there is =
some
problem.

> > 3) Testing on master branch
> > The reason, why jobs in https://github.com/acerv/ltp/actions are tested=
 on
> > master branch (not on ci/452320 - where number would be number of the s=
eries) is
> > the GitHub Action limitation when using schedule:

> > https://docs.github.com/en/actions/writing-workflows/choosing-when-your=
-workflow-runs/events-that-trigger-workflows#schedule
> > "This event will only trigger a workflow run if the workflow file is on=
 the default branch."
> > =3D> that should be solved by merge

> > "Scheduled workflows will only run on the default branch."
> > =3D> People suggest to use a reusable workflow
> > https://github.com/orgs/community/discussions/16107
> > https://docs.github.com/en/actions/sharing-automations/reusing-workflow=
s#creating-a-reusable-workflow
> > But I'm perfectly ok with this state, unless you have energy to test it=
 with

> > with:
> >      ref: ci

> > This should use 'ci' branch instead of the default 'master'.
> Same problem above: ci should be synced with master via GitHub. Less
> commands in the workflow, less chance to fail it.

Adding 'ref: whatever-branch-we-want-for-ci' does not seem to be too
complicated, but let's keep master now (I'll have look into it later, wheth=
er
it's working as expected, then we can reconsider it).

> > 4) Workflow just to push branch (different approach)
> > I originally had a different idea: with first workflow apply patches an=
d push
> > them to some fork (not to the official repo, e.g. to linux-test-project=
/ci
> > repo), which would trigger CI build.

> > Pros
> > * Not having to download from patchwork and apply patches for each of o=
ur 16
> > builds. Our patchwork instance maintainers might appreciate if we try to
> > minimize the load :).
> > * Having non-default branch (e.g. not everything on master, solves 3).
> > * Having branch created for anybody who wants to test it (probably nobo=
dy will
> > not import remote with so many branches).

> > Cons
> > * Probably better would be to do some branch cleanup.

> > Maybe we could start using --volume to share stored data:

> > options: --volume /tmp/shared:/shared

> > 5) Link to patchwork series in GitHub Actions job
> > Currently if you spot failure on GitHub Actions job, you will not be
> > able to find the code on patchwork (even series ID would be enough).

> > See:
> > https://github.com/acerv/ltp/actions/runs/14447250705
> > does not link to
> > https://patchwork.ozlabs.org/project/ltp/patch/20250415013944.173030-3-=
wegao@suse.com/

> > Some info in CI job about the patch would be helpful (more important du=
e 4),
> > because with specific branches ci/452320 it'd be more obvious what is b=
eing tested).

> > One can dig the info from logs from "Apply Patchwork series":
> > + curl -k https://patchwork.ozlabs.org/series/452267/mbox/

> > That can be enough.

> > But ideally there would be link to patchwork series, or at least "Test =
building
> > in various distros in Docker" title was extended to have also series ID.

> Same problem of above: we should simplify as much as possible instead of
> adding layers :-) we are currently running on master, but inside a
> container, so the real issue we have is to show on GiHub UI that we are
> testing a specific patch-series from Patchwork (I already tried but it's =
not
> easy to do it, like in Gitlab for instance..).=A0 The branching solution =
is
> interesting if we want to check from GitHub the applied commits, but we
> already have them in Patchwork. Also, we would need to cleanup branches,
> which means to loose them anyway one day or another.

> So I would just keep the actual solution because it's easier to maintain =
and
> it doesn't require more workflows, layers, commands, etc.

Sure, let's ignore it.

FYI I did not think to add another layer. It would be git push in
ci-patchwork-trigger.yml (more code, but OTOH ci-docker-build.yml would not=
 have
to be modified).

Also, you decide to trigger ci-docker-build.yml via ci-patchwork-trigger.ym=
l,
which ignores ci-sphinx-doc.yml. Therefore patches which modify just
documentation, e.g. even with this CI we can have changes which break
readthedocs.org.

I created a single job ci-sphinx-doc.yml because 1) it's easier to spot wha=
t got
broken 2) I consider building the doc in all distros as a waste of time. Sh=
ould
we reconsider it? I could move building of the doc to ci-sphinx-doc.yml and
remove ci-sphinx-doc.yml. Other option is that you trigger also ci-sphinx-d=
oc.yml
(nothing urgent, can be done later).

> > 6) Links in Patchwork contains job ID
> > It would be nice if links in the patchwork table contain also job to th=
e specific distro, e.g.
> > https://github.com/acerv/ltp/actions/runs/14447250705/job/40510755305
> It 's something I tried at the very beginning but I didn't find a solution
> to get that "40510755305" from /job . I need to read documentation again =
and
> to try a couple of solutions...it's just a really slow implementation
> process for a simple improvement, so I bothered more about stability and
> basic functionalities :-) We can add this improvement later if it's ok.
Sure, it can wait.

> There are still some things which are more important, like showing linting
> warnings in Patchwork due to "make check" command.

I don't consider this important until LTP is in the state when it's clean. =
ATM I
would do it only for new files. For modified files I would print warning on=
ly
when there are new warnings (compare count warning on master; comparing dif=
f of
warning on master vs. particular patchset will not work because line number
changes).

It should be warning only (not a failure).

I guess this will be separate workflow, right? Once anybody start on it, I =
guess
we should have script which takes input of changed files and generates outp=
ut
of make check-* commands.

> > Instead of plain
> > https://github.com/acerv/ltp/actions/runs/14447250705
> > for all jobs. No problem if not easily done.

> > Kind regards,
> > Petr

> > >    ci: add ci-patchwork-trigger workflow
> > >    ci: apply patchwork series in ci-docker-build workflow
> > >   .github/workflows/ci-docker-build.yml      |  39 +++-
> > >   .github/workflows/ci-patchwork-trigger.yml |  63 +++++++
> > >   ci/alpine-runtime.sh                       |   2 +
> > >   ci/alpine.sh                               |   2 +
> > >   ci/debian.i386.sh                          |   2 +
> > >   ci/debian.sh                               |  28 +--
> > >   ci/fedora.sh                               |   2 +
> > >   ci/tools/patchwork.sh                      | 197 ++++++++++++++++++=
+++
> > >   ci/tumbleweed.sh                           |   2 +
> > >   9 files changed, 323 insertions(+), 14 deletions(-)
> > >   create mode 100644 .github/workflows/ci-patchwork-trigger.yml
> > >   create mode 100755 ci/tools/patchwork.sh

> Let's fix the last things and send v6. Still, we will miss 3/4 but I will
> eventually redirect it on ML........

Thanks!

Kind regards,
Petr

> - Andrea


-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
