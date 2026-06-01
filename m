Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7520CD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 13:19:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEA553E571B
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 15:19:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AAC53E483B
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:19:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 59F0B1000745
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:19:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 318BE6759C;
 Mon,  1 Jun 2026 13:19:36 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1216779A7;
 Mon,  1 Jun 2026 13:19:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jv4ZLeaGHWr2OQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 01 Jun 2026 13:19:34 +0000
Date: Mon, 1 Jun 2026 15:19:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260601131929.GB3383916@pevik>
References: <20260601-doc_add_missing_headers-v1-0-6f1ee31945df@suse.com>
 <20260601-doc_add_missing_headers-v1-2-6f1ee31945df@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260601-doc_add_missing_headers-v1-2-6f1ee31945df@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 318BE6759C
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] doc: Complete struct tst_test table and shell
 API docs
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, Cyril, Li,

@Andrea I'd say you mixed 2 APIs: tst_test.sh API (used to be "the new API" but
now deprecated by shell loader) and shell loader API. And here come problems.

> Fix incorrect field names in the C/Shell API comparison table in
> writing_tests.rst:

> - .max_runtime -> .runtime (renamed in a6a369c5eeb4)
> - .tst_hugepage -> .hugepages (actual field name)
> - .dev_extra_opts, .dev_fs_opts, .dev_fs_type are shell-only variables,
>   not C struct fields; move them to the 'not applicable' section

This part which fixes tst_test.c renames I'd merge right now.

But the rest which is in api_shell_tests.rst it's IMHO wrong because they are
for tst_test.sh. 


The problem is that since  3c82316c53 ("doc: Add basic shell test description")
we consider doc/developers/api_shell_tests.html home for shell loader. See
Cyril's feedback to not put there tst_test.sh doc [1]. That's why I rejected my
older patch converting tst_test.sh doc to the old file.

but that approach in 3c82316c53 wasn't consistent, because other doc still
consider as shell API tst_test.sh:
* doc/developers/ltp_library.rst (mentions tst_test.sh, tst_security.sh and
  tst_net.sh)
* doc/users/setup_tests.rst (comparison table)
* testcases/network/README.md (git source only, not part of readthedocs)
* Old github doc in doc/old/

@All We should fix it. So what are we going to do with tst_test.sh doc?
Maybe admit tst_test.sh etc exists in doc/developers/ltp_library.rst,
but document that shell loader is way to go?

And I wonder if the comparison table in doc/developers/api_shell_tests.rst
should be deleted or we should put a note that this API is deprecated and
users should use shell loader (clickable link to
doc/developers/api_shell_tests.html).

And yes, we should probably convert lib/README.md and
testcases/network/README.md to sphinx doc, but that's a completely different
problem.

[1] https://lore.kernel.org/ltp/aRSlUmoktYACJRV6@yuki.lan/
[2] https://lore.kernel.org/ltp/20251014145020.178840-2-pvorel@suse.cz/

> Add 10 missing struct tst_test fields to the table: .filesystems,
> .forks_child, .min_runtime, .needs_abi_bits, .needs_cgroup_nsdelegate,
> .needs_cgroup_ver, .needs_hugetlbfs, .runs_script, and fix the
> alphabetical ordering of .mnt_flags and .min_swap_avail.

> Add a shell API variables reference section to api_shell_tests.rst
> documenting all public TST_* input/output variables, checkpoint
> functions, and retry helpers.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  doc/developers/api_shell_tests.rst | 163 +++++++++++++++++++++++++++++++++++++
>  doc/developers/writing_tests.rst   |  28 ++++++-
>  2 files changed, 189 insertions(+), 2 deletions(-)

> diff --git a/doc/developers/api_shell_tests.rst b/doc/developers/api_shell_tests.rst
> index 937ffee2ea468552e5160775153990f13ea10f88..168e6c122730b4e9ace07a1f9d8554f8d8f9a290 100644
> --- a/doc/developers/api_shell_tests.rst
> +++ b/doc/developers/api_shell_tests.rst

FYI given the above this doc is for a shell loader....

> @@ -93,3 +93,166 @@ interrupted by :ref:`tst_brk`.

>     .. literalinclude:: ../../testcases/lib/tests/shell_loader_setup_cleanup.sh
>        :language: shell
> +
> +Shell API variables
> +-------------------
> +
> +The following variables are available to shell tests. Variables marked
> +*input* are set by the test before sourcing ``tst_run.sh``; variables
nit: could you please use clickable link to sources?

:shell_lib:`tst_run.sh` (Cyril preferred it over :master:`testcases/lib/tst_run.sh`).

I dared to merge more rename now:
016134bf31 ("doc: Use shell_lib prefix to shorten printed file path")

> +marked *output* are set by the library for tests to read.
> +
> +Test definition (input)
> +~~~~~~~~~~~~~~~~~~~~~~~
nit: I'd remove "(input(". I did not get what you mean.

... which means many of these below aren't (yet) supported in shell loader.
ATM we support only TST_SETUP and TST_CLEANUP. Test function must be named
tst_test().

And my WIP "shell loader fixes + du01.sh rewrite"

[3] https://patchwork.ozlabs.org/project/ltp/list/?series=495792&state=*

> +
> +``TST_TESTFUNC``
> +    Name of the test function (required).
> +
> +``TST_CNT``
> +    Number of test cases. When set the test function is called
> +    ``TST_CNT`` times with a counter argument.
> +
> +``TST_SETUP``
> +    Name of the setup function (called once before tests).
> +
> +``TST_CLEANUP``
> +    Name of the cleanup function (called once after tests or on
> +    ``tst_brk``).
> +
> +``TST_OPTS``
> +    Extra getopts option string.
> +
> +``TST_PARSE_ARGS``
> +    Name of a function to parse extra options from ``TST_OPTS``.
> +
> +``TST_USAGE``
> +    Name of a function printing extra usage information.
> +
> +``TST_POS_ARGS``
> +    Number of expected positional arguments.
> +
> +``TST_TEST_DATA``
> +    Space-separated data passed as a second argument to the test
> +    function.
> +
> +``TST_TEST_DATA_IFS``
> +    Custom delimiter for ``TST_TEST_DATA`` (default: space).

To be honest, if 
> +
> +Requirements (input)
> +~~~~~~~~~~~~~~~~~~~~
> +
> +``TST_NEEDS_ROOT``
> +    Set to 1 to require root privileges.
> +
> +``TST_NEEDS_TMPDIR``
> +    Set to 1 to create a temporary directory.
> +
> +``TST_NEEDS_DEVICE``
> +    Set to 1 to prepare a block device.
> +
> +``TST_NEEDS_CMDS``
> +    Space-separated list of required commands.
> +
> +``TST_NEEDS_MODULE``
> +    Kernel module name that must be loadable.
> +
> +``TST_NEEDS_DRIVERS``
> +    Space-separated list of required kernel drivers.
> +
> +``TST_NEEDS_KCONFIGS``
> +    Space-separated list of required kernel config options
> +    (e.g. ``CONFIG_NUMA=y``).
> +
> +``TST_NEEDS_KCONFIGS_IFS``
> +    Custom delimiter for ``TST_NEEDS_KCONFIGS`` (default: comma).
> +
> +``TST_NEEDS_CHECKPOINTS``
> +    Set to 1 to enable checkpoint support.
> +
> +``TST_MIN_KVER``
> +    Minimum kernel version string (e.g. ``4.18``).
> +
> +Device and filesystem (input)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +``TST_FORMAT_DEVICE``
> +    Set to 1 to format ``TST_DEVICE`` before the test.
> +
> +``TST_MOUNT_DEVICE``
> +    Set to 1 to mount ``TST_DEVICE`` at ``TST_MNTPOINT``.
> +
> +``TST_DEV_EXTRA_OPTS``
> +    Extra options passed to ``mkfs``.
> +
> +``TST_DEV_FS_OPTS``
> +    Extra filesystem-specific ``mkfs`` options.
> +
> +``TST_FS_TYPE``
> +    Filesystem type for formatting (default: ``ext2``).
> +
> +``TST_DEVICE_SIZE``
> +    Device size in MB.
> +
> +``TST_ALL_FILESYSTEMS``
> +    Set to 1 to repeat the test for each supported filesystem.
> +
> +``TST_SKIP_FILESYSTEMS``
> +    Space-separated list of filesystems to skip.
> +
> +``TST_MNT_PARAMS``
> +    Mount flags/options string.
> +
> +Miscellaneous (input)
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +``TST_SKIP_IN_LOCKDOWN``
> +    Set to 1 to skip when kernel lockdown is active.
> +
> +``TST_SKIP_IN_SECUREBOOT``
> +    Set to 1 to skip when Secure Boot is enabled.
> +
> +``TST_TIMEOUT``
> +    Test timeout in seconds.
> +
> +Output variables
> +~~~~~~~~~~~~~~~~
> +
> +``TST_TMPDIR``
> +    Path to the temporary directory (when ``TST_NEEDS_TMPDIR=1``).
> +
> +``TST_STARTWD``
> +    Original working directory before ``chdir`` to ``TST_TMPDIR``.
> +
> +``TST_DEVICE``
> +    Block device path (when ``TST_NEEDS_DEVICE=1``).
> +
> +``TST_MNTPOINT``
> +    Mount point path.
> +
> +``TST_MODPATH``
> +    Path to the loaded kernel module.
> +
> +Checkpoint functions
> +~~~~~~~~~~~~~~~~~~~~
> +
> +``TST_CHECKPOINT_WAIT``
> +    Wait on checkpoint (argument: checkpoint id).
> +
> +``TST_CHECKPOINT_WAKE``
> +    Wake one waiter on checkpoint (argument: checkpoint id).
> +
> +``TST_CHECKPOINT_WAKE2``
> +    Wake multiple waiters (arguments: checkpoint id, count).
> +
> +``TST_CHECKPOINT_WAKE_AND_WAIT``
> +    Wake one waiter and then wait (argument: checkpoint id).
> +
> +Retry helpers
> +~~~~~~~~~~~~~
> +
> +``TST_RETRY_FUNC``
> +    Retry a function until it succeeds or times out
> +    (arguments: function, expected value).
> +
> +``TST_RETRY_FN_EXP_BACKOFF``
> +    Like ``TST_RETRY_FUNC`` with exponential backoff
> +    (arguments: function, expected value, max delay).

To be honest if we want to document tst_test.sh, I'd prefer the examples in my
original patch [2].

> diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
> index dc40324b16d40c4d210fe0dfa6b311b5b3337c7a..2d7950be6d6b70afc69f96d99314effdd2e985da 100644
> --- a/doc/developers/writing_tests.rst
> +++ b/doc/developers/writing_tests.rst
> @@ -382,6 +382,12 @@ LTP C And Shell Test API Comparison
>      * - .dev_min_size
>        - TST_DEVICE_SIZE

> +    * - .filesystems
> +      - \-
> +
> +    * - .forks_child
> +      - not applicable
> +
>      * - .format_device
>        - TST_FORMAT_DEVICE

> @@ -399,12 +405,15 @@ LTP C And Shell Test API Comparison
>      * - .min_mem_avail
>        - not applicable

> -    * - .mnt_flags
> -      - TST_MNT_PARAMS
> +    * - .min_runtime
> +      - \-

>      * - .min_swap_avail
>        - not applicable

> +    * - .mnt_flags
> +      - TST_MNT_PARAMS
> +
>      * - .mntpoint | .mnt_data
>        - TST_MNTPOINT

> @@ -414,6 +423,12 @@ LTP C And Shell Test API Comparison
>      * - .needs_cgroup_ctrls
>        - \-

> +    * - .needs_cgroup_nsdelegate
> +      - \-
> +
> +    * - .needs_cgroup_ver
> +      - \-
> +
>      * - .needs_checkpoints
>        - TST_NEEDS_CHECKPOINTS

> @@ -426,6 +441,9 @@ LTP C And Shell Test API Comparison
>      * - .needs_device
>        - TST_NEEDS_DEVICE

> +    * - .needs_hugetlbfs
> +      - \-
> +
>      * - removed
>        - TST_NEEDS_DRIVERS

> @@ -438,6 +456,9 @@ LTP C And Shell Test API Comparison
>      * - .needs_rofs
>        - \-

> +    * - .needs_abi_bits
> +      - not applicable
> +
>      * - .needs_root
>        - TST_NEEDS_ROOT

> @@ -453,6 +474,9 @@ LTP C And Shell Test API Comparison
>      * - .restore_wallclock
>        - not applicable

> +    * - .runs_script
> +      - not applicable
> +
>      * - .sample
>        - \-

And until we decide, I'm ok to update writing_tests.rst (i.e. merge
writing_tests.rst part).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
