Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350F5D44C69
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 15:34:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3AEB3C9FDB
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 16:34:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01FAD3C9FA9
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 16:33:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 365011400E75
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 16:33:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0A96433740;
 Thu, 15 Jan 2026 15:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768491210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xsm6ymFUTXXtkGmzPIa6oeIzlwK+p6QrpdH1LAmzPZ4=;
 b=uDCVniZX9hfyL52i6POvwyVMTs2bsG6bHDmjkUydAdt8CcaHkkHQ6oTyrvZ1ODWLi7TF1B
 qqa8cUsk5wNFjNTrCSvPWf5bGpfs2RQIsrnJMYOiD+v4+3YgIPGMvcpdXQIJJGfTqY3nU5
 s7c2ybblGBGuTwckSjIPgOuszJLgMX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768491210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xsm6ymFUTXXtkGmzPIa6oeIzlwK+p6QrpdH1LAmzPZ4=;
 b=zrWLDo7Q7oSjjIn0UdJzzmxWWDXwlNm5ZNhu8vUyItIMfL3TQ4FF1ZSUzwVwoWqk7Jyko2
 TfoDnT7szD+g4/BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uDCVniZX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zrWLDo7Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768491210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xsm6ymFUTXXtkGmzPIa6oeIzlwK+p6QrpdH1LAmzPZ4=;
 b=uDCVniZX9hfyL52i6POvwyVMTs2bsG6bHDmjkUydAdt8CcaHkkHQ6oTyrvZ1ODWLi7TF1B
 qqa8cUsk5wNFjNTrCSvPWf5bGpfs2RQIsrnJMYOiD+v4+3YgIPGMvcpdXQIJJGfTqY3nU5
 s7c2ybblGBGuTwckSjIPgOuszJLgMX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768491210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xsm6ymFUTXXtkGmzPIa6oeIzlwK+p6QrpdH1LAmzPZ4=;
 b=zrWLDo7Q7oSjjIn0UdJzzmxWWDXwlNm5ZNhu8vUyItIMfL3TQ4FF1ZSUzwVwoWqk7Jyko2
 TfoDnT7szD+g4/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA61C3EA63;
 Thu, 15 Jan 2026 15:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id t2dKOMkIaWlpJgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 15 Jan 2026 15:33:29 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 15 Jan 2026 16:34:37 +0100
Message-ID: <20260115153439.13337-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115153439.13337-1-chrubis@suse.cz>
References: <20260115153439.13337-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 0A96433740
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] doc: Add ground rules page
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
Content-Type: multipart/mixed; boundary="===============1501964457=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1501964457==
Content-Type: text/plain; charset=u
Content-Transfer-Encoding: 8bit

This is a continued effort to write down the unwritten rules we have in
the project. Feel free to suggest more topics for the page.

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/developers/ground_rules.rst | 176 ++++++++++++++++++++++++++++++++
 doc/index.rst                   |   1 +
 2 files changed, 177 insertions(+)
 create mode 100644 doc/developers/ground_rules.rst

diff --git a/doc/developers/ground_rules.rst b/doc/developers/ground_rules.rst
new file mode 100644
index 000000000..9bb4ec66c
--- /dev/null
+++ b/doc/developers/ground_rules.rst
@@ -0,0 +1,176 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Ground Rules
+============
+
+Do not work around kernel bugs
+------------------------------
+
+We have decided that we will not work around bugs in upstream LTP sources. If a
+test fails on your system for a good reason, e.g. patch wasn't backported and
+the bug is present, work around for this will not be accepted upstream. The
+main reason for this decision is that this masks the failure for everyone else.
+
+
+Do not synchronize by sleep
+---------------------------
+
+Why is sleep in tests bad then?
+```````````````````````````````
+
+The first problem is that it will likely introduce very rare test failures,
+that means somebody has to spend time looking into these, which is a wasted
+effort. Nobody likes tests that will fail rarely for no good reason. Even more
+so you cannot run such tests with a background load to ensure that everything
+works correctly on a busy system, because that will increase the likehood of a
+failure.
+
+The second problem is that this wastes resources and slows down a test run. If
+you think that adding a sleep to a test is not a big deal, lets have a look at
+the bigger perspective. There are about 1600 syscall tests in Linux Test
+Project, if 7.5% of them would sleep just for one second, we would end up with
+two minutes of wasted time per testrun. In practice most of the tests, that
+historically misused sleep for synchronization, waited for much longer just to
+be sure that things will works even on slower hardware. With sleeps between 2
+and 5 seconds that puts us somewhere between 4 and 10 minutes which is between
+13% and 33% of the syscall runtime on an outdated thinkpad, where the run
+finishes in a bit less than half an hour. It's even worse on newer hardware,
+because this slowdown will not change no matter how fast your machine is, which
+is maybe the reason why this was acceptable twenty years ago but it's not now.
+
+
+What to do instead?
+```````````````````
+
+Use proper synchronization.
+
+There are different problems and different solutions. Most often test needs to
+synchronize between child and parent process.
+
+The easiest case is when parent needs to wait for a child to finish, that can
+be fixed just be adding a :manpage:`waitpid(2)` in the parent which ensures that child
+has finished before parent runs.
+
+Commonly child has to execute certain piece of code before parent can continue.
+For that LTP library implements checkpoints with simple
+:c:func:`TST_CHECKPOINT_WAIT()` and :c:func:`TST_CHECKPOINT_WAKE()` functions based
+on futexes on a piece of shared memory set up by the test library.
+
+Another common case is when a child must sleep in a syscall before parent can
+continue, for which we have a :c:func:`TST_PROCESS_STATE_WAIT()` helper that
+polls `/proc/$PID/stat`.
+
+Less often test needs to wait for an action that is done asynchronously, or for
+a kernel resource deallocation that is deferred to a later time. In such cases
+the best we can do is to poll. In LTP we ended up with a macro that polls by
+calling a piece of code in a loop with exponentially increasing sleeps between
+retries until it succeeds. Which means that instead of sleeping for a maximal
+time event can possibly take the sleep is capped by twice of the optimal
+sleeping time while we avoid polling too aggressively.
+
+
+Use runtime checks for kernel features
+--------------------------------------
+
+What is and what isn't supported by kernel is determined by the version and
+configuration of the kernel the system is currently running on.  That
+especially means that any checks done during the compilation cannot be used to
+assume features supported by the kernel the tests end up running on. The
+compile time checks, done by :master:`configure.ac` script, are only useful for
+enabling fallback kernel API definitions when missing, as we do in
+:master:`include/lapi/` directory.
+
+
+Don’t require root unless it’s essential
+----------------------------------------
+
+If root/caps are needed, say why in the test doc comment. Drop privileges for
+the part that doesn’t need them and avoid running the whole test as root
+“because it’s easier”.
+
+
+Always clean up, even on failure
+--------------------------------
+
+Every test should leave the system as it found it: unmount, restore sysctls,
+delete temp files/dirs, kill spawned processes, remove cgroups/namespaces,
+detach loop devices, restore ulimits, etc. Cleanup must run on early-exit
+paths too.
+
+The test library can simplify cleanup greatly as there are various helpers such as:
+
+- :c:type:`tst_test.needs_tmpdir <tst_test>` that creates and deletes a temporary directory for the test
+- :c:type:`tst_test.save_restore <tst_test>` that saves and restores /sys/ and /proc/ files
+- :c:type:`tst_test.needs_device <tst_test>` sets up and tears down a block device for the test
+- :c:type:`tst_test.restore_wallclock <tst_test>` that restores wall clock after the test
+- :c:type:`tst_test.needs_cgroup_ctrls <tst_test>` sets up and cleans up cgroups for the test
+- ...
+
+
+Write portable code
+-------------------
+
+Avoid nonstandard libc APIs when a portable equivalent exists; don’t assume
+64-bit, page size, endianness, or particular tool versions.
+
+If the test is specific to a certain architecture, make sure that it at least
+compiles at the rest of architectures and set the
+:c:type:`tst_test.supported_archs <tst_test>`.
+
+This also applies to shell code where it's easy to use bash features that are
+not available on other shell implementations, e.g. dash or busybox. Make sure
+to stick to portable POSIX shell whenever possible.
+
+You can check for common mistakes, not only in portability, with our
+'make check' tooling.
+
+
+Split changed into well defined chunks
+--------------------------------------
+
+When submitting patches make sure to split the work into small well-defined
+chunks. Patches that touch many files or mix unrelated changes and features are
+difficuilt to review and are likely to be detalyed or even ignored.
+
+Aim for a single logical change per patch. Split more complex works into a
+patch series where each patch:
+
+  - builds/compiles successfully.
+  - keeps tests and tooling functional.
+  - does not introduce intermediate breakage.
+  - has a clear commit message to explain the change.
+  - Significant changes need to be detailed in the cover letter.
+
+
+Be careful when using AI tools
+------------------------------
+
+AI tools can be useful for executing, summarizing, or suggesting approaches,
+but they can also be confidently wrong and give an illusion of correctness.
+Treat AI output as untrusted: verify claims against the code, documentation,
+and actual behavior on a reproducer.
+
+Do not send AI-generated changes as raw patches. AI-generated diffs often
+contain irrelevant churn, incorrect assumptions, inconsistent style, or subtle
+bugs, which creates additional burden for maintainers to review and fix.
+
+Best practice is to write your own patches and have them reviewed by AI before
+submitting them, which helps add beneficial improvements to your work.
+
+
+Kernel features and RCs
+-----------------------
+
+LTP tests or fixes for kernel changes that have not yet been released may be
+posted to the LTP list for a review but they will not be be accepted until
+respective kernel changes are released. Review of such changes is also
+considered to be lower priority than rest of the changes. This is because
+kernel changes especially in the early RC phase are volatile and could be
+changed or reverted.
+
+These patchses should also add a [STAGING] keyword into the patch subject, e.g.
+"Subject: [PATCH v1][STAGING] fanotify: add test for <feature> (requires v6.19-rc3)"
+
+In a case that a test for unrelased kernel is really needed to be merged we do
+not add it to the list of test executed by default and keep it in
+:master:`runtest/staging` file until the kernel code is finalized.
diff --git a/doc/index.rst b/doc/index.rst
index f78e7a448..496a12f80 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -19,6 +19,7 @@
    :hidden:
    :caption: For developers
 
+   developers/ground_rules
    developers/setup_mailinglist
    developers/writing_tests
    developers/test_case_tutorial
-- 
2.52.0


--===============1501964457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1501964457==--
