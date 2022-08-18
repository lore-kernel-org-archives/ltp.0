Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE30C00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 10:29:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3DAC3CA1B9
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 12:29:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31AA33CA15B
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 12:28:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9DF491A006EA
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 12:28:52 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id F24AB2219E;
 Thu, 18 Aug 2022 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1660818527;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+lK3bWCN5ZmJJfM3tr+TJ26fz5iFwIDvH93BUOznihY=;
 b=h7jlTyone7c/xVChHGlabxeGzYx9AYXUJj4Ta3ogTGAHc/tZMyhLFQ5fhWR8qr+KUHdDmz
 ChI/ITlcbrwaxrMUjwVA1VsJ9cxcPewAumQMtJrsd4f9aG+fzU6yfG3xKP13F9KDLE5MkP
 41/aKUx3zeD4w/qzUGxgFkzmvZ92jZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1660818528;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+lK3bWCN5ZmJJfM3tr+TJ26fz5iFwIDvH93BUOznihY=;
 b=PSF4tH+o1FzJa9QH6QPC6BOr3/fFMlV73GGeaxt3UDWex1kNaqN7lSLvJGQtru0kH3JI4Q
 cAA+dargPRU3DMBg==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3E8592C184;
 Thu, 18 Aug 2022 10:28:43 +0000 (UTC)
References: <1659521981-2241-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1659521981-2241-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <87zggks3pe.fsf@suse.de>
 <031f32b2-70fd-8b6d-e2ec-f1d3d1bdcaa5@fujitsu.com>
 <87fshwlh5t.fsf@suse.de>
 <dd62e1fa-0b53-e45a-83fc-21a7a2105419@fujitsu.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Date: Thu, 18 Aug 2022 10:03:37 +0100
In-reply-to: <dd62e1fa-0b53-e45a-83fc-21a7a2105419@fujitsu.com>
Message-ID: <87edxdkfq8.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/3] tst_cgroup: Add safe_cg_open and
 safe_cg_fchown functions
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

OK, I see the new patches. However I just realised these tests are part
of test_cgcore. These are not related to memcontrol. They should go in
controllers/cgroup/core01.c.

Let's start at the beginning and look at the original selftest.

static int test_cgcore_lesser_euid_open(const char *root)
{
	const uid_t test_euid = 65534;	/* usually nobody, any !root is fine */
	int ret = KSFT_FAIL;
	char *cg_test_a = NULL, *cg_test_b = NULL;
	char *cg_test_a_procs = NULL, *cg_test_b_procs = NULL;
	int cg_test_b_procs_fd = -1;
	uid_t saved_uid;

	cg_test_a = cg_name(root, "cg_test_a");
	cg_test_b = cg_name(root, "cg_test_b");

	if (!cg_test_a || !cg_test_b)
		goto cleanup;

	cg_test_a_procs = cg_name(cg_test_a, "cgroup.procs");
	cg_test_b_procs = cg_name(cg_test_b, "cgroup.procs");

	if (!cg_test_a_procs || !cg_test_b_procs)
		goto cleanup;

	if (cg_create(cg_test_a) || cg_create(cg_test_b))
		goto cleanup;

So we create two subgroups this translates to

cg_child_a = tst_cg_group_mk(tst_cg, 'a');
cg_child_b = tst_cg_group_mk(tst_cg, 'b');


	if (cg_enter_current(cg_test_a))
		goto cleanup;

This writes "0" to the cgroup.procs file which I guess is a shortcut for
writing the current processes PID. We have to be careful here incase
this behaviour is different on V1. Probably this translates to

SAFE_CG_PRINT(cg_child_a, "cgroup.procs", "0");

It's not clear why the current PID is moved to this CG. It may be to
ensure we have permission to move to a sibling CGroup and to eliminate
other possible reasons for getting EACCES later on.

	if (chown(cg_test_a_procs, test_euid, -1) ||
	    chown(cg_test_b_procs, test_euid, -1))
		goto cleanup;

Then the procs files are chowned to nobody. I see no reason this
function can not be implemented in the same way safe_cg_printf is. We
don't need to check which controller the file belongs to, just chown all
of them.

	saved_uid = geteuid();
	if (seteuid(test_euid))
		goto cleanup;

Then the current procs effective uid is changed. We need to make sure to
set this back before doing cleanup (or fork like you did originally).

	cg_test_b_procs_fd = open(cg_test_b_procs, O_RDWR);

	if (seteuid(saved_uid))
		goto cleanup;

Then the file is opened and the euid set back

	if (cg_test_b_procs_fd < 0)
		goto cleanup;

	if (write(cg_test_b_procs_fd, "0", 1) >= 0 || errno != EACCES)
		goto cleanup;

Then we try to move to CG B and expect to get EACCES (because of the
permissions present when opening the file).

	ret = KSFT_PASS;
...


Probably we want to run this test on any controllers which are
available. Currently the API doesn't support that. We need some way of
specifying that the test will use any available controllers in
tst_cg_require and/or tst_test.

Then we need to handle setting the euid between open and writing which
stops us from using safe_cg_printf.

Probably the API shouldn't try to handle stuff this wierd. Instead we
can create a function like

int n = tst_cg_group_dirfds(int *dirfds)

which copies tst_cgroup_group.dirs[i].dir_fd into dirfds (which can be
statically allocated in the test code if we export CTRLS_MAX).

Then we can do

seteuid(nobody);

for (i = 0; i < n; i++) {
    procfds[i] = openat(dirfds[i], "cgroup.procs")
}

seteuid(saved_euid);

for (i = 0; i < n; i++) {
    ret = write(procfds[i], "0", 1);
    if (ret >= 0)
       tst_res(TFAIL...)
    ...

    close(procfds[i]);
}

and whatever else is required by tests which are doing something unusual
with the CG hierarchy.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
