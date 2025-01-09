Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D03E77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 09:49:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6C193C20AB
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 10:49:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F21503C189A
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 10:49:35 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ED5D5208D23
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 10:49:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F137D210F4;
 Thu,  9 Jan 2025 09:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736416174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8IbP8+ariiiZnkFcwm8IJXNc2N7FE8WDF/RoxLUlz0=;
 b=NLXdAD4GhP2XWeXsXfOLDaLgh+nfl1T9ZWfCbbMPmzTYuB2KY2YFtFlpanyEW4XzykJR1o
 5Fic8B1bqHMvSyutnCX55v1J0qqZ8fEE5D6Rs4HcLGkEqFHhm3UpYikZnu+QISQWUuuI/K
 PC7Endup3VdnvY7KpiTO+h5xcHO0Kpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736416174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8IbP8+ariiiZnkFcwm8IJXNc2N7FE8WDF/RoxLUlz0=;
 b=1vRapg1/pH1cZYmnTowks53jY11QRIwS0+e3vM4iO2/fxNSKjYhtB7kgMHWWDk2IL18XjH
 9Xv39zmRMswoKMBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OcBBXLfO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=agrQOxDh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736416173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8IbP8+ariiiZnkFcwm8IJXNc2N7FE8WDF/RoxLUlz0=;
 b=OcBBXLfODF9GEyuRqoBEh10h4GY8UnaEvxXuQ8zSIXPzusZdvx4MfOZNAkW8LhVksumTTQ
 tjKXow/XWayliXOzXy2dXWNEBj1yjFY/49961ipVTUWQsfjOGV3zPn9p22pz71kNpCGJgq
 7D31meAe2N+P119DKFqEZdTuTJNbN3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736416173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8IbP8+ariiiZnkFcwm8IJXNc2N7FE8WDF/RoxLUlz0=;
 b=agrQOxDhMqSM+YMkQasjUG9ujbdJdK05wPYORnc07fesG+6x6qSfh7gE9wwvEe7/yGW1+R
 pbAWK8ZW6+UGq3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2EF713876;
 Thu,  9 Jan 2025 09:49:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hwaAMa2bf2cNBQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 09 Jan 2025 09:49:33 +0000
Date: Thu, 9 Jan 2025 10:53:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Z3-cncvj-XaYcpsc@rei.lan>
References: <20250109045532.43017-1-liwang@redhat.com>
 <20250109045532.43017-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250109045532.43017-2-liwang@redhat.com>
X-Rspamd-Queue-Id: F137D210F4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] lib: redefine the overall timeout logic of
 test
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This patch revises the logic for managing test timeout and runtime
> limits, introducing a more structured approach. The key changes include
> renaming max_runtime to runtime for clarity and adding overall_time to
> represent the total time limit for a test. This ensures better separation
> of test phases (setup, execution, and cleanup) and clearer timeout management.
> 
> Key Concepts:
> 
>  timeout: Defines the maximum time allowed for the entire test, including
>           setup, execution, and cleanup, when no explicit runtime is set.
> 	  But if a runtime is explicitly defined and tst_remaining_runtime()
> 	  is used, the timeout applies only to the setup and cleanup phases,
> 	  as the runtime controls the test execution duration.
> 
>  runtime: The maximum runtime of the test's main execution loop, used
>           in tests that call tst_remaining_runtime(). It ensures the
> 	  main execution runs for a fixed duration, regardless of kernel
> 	  configuration (e.g., debug kernel).
> 
> Overall timeout is structured as follows:
> 
> | -- (default_30s + timeout) * timeout_mul -- | -- runtime * runtime_mul -- |
> 
> And, the TST_UNLIMITED_RUNTIME constant has been deprecated and replaced
> by TST_UNLIMITED_TIMEOUT. This change simplifies the handling of unlimited
> execution scenarios while aligning the terminology with the new timeout model.
> 
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Petr Vorel <pvorel@suse.cz>,
> Cc: Martin Doucha <martin.doucha@suse.com>,
> Cc: Jan Stancek <jstancek@redhat.com>
> Cc: Andrea Cervesato <andrea.cervesato@suse.com>
> Cc: Avinesh Kumar <akumar@suse.de>,
> ---
>  doc/old/C-Test-API.asciidoc                   | 36 ++++---
>  doc/users/setup_tests.rst                     |  6 +-
>  include/tst_test.h                            | 33 +++++--
>  lib/newlib_tests/shell/test_timeout.sh        | 10 +-
>  lib/newlib_tests/test_runtime01.c             |  2 +-
>  lib/newlib_tests/test_runtime02.c             |  2 +-
>  lib/newlib_tests/tst_fuzzy_sync01.c           |  2 +-
>  lib/newlib_tests/tst_fuzzy_sync02.c           |  2 +-
>  lib/newlib_tests/tst_fuzzy_sync03.c           |  2 +-
>  lib/tst_test.c                                | 95 +++++++++----------
>  lib/tst_timer_test.c                          |  2 +-
>  testcases/cve/cve-2014-0196.c                 |  2 +-
>  testcases/cve/cve-2015-3290.c                 |  2 +-
>  testcases/cve/cve-2016-7117.c                 |  2 +-
>  testcases/cve/cve-2017-2671.c                 |  2 +-
>  .../kernel/controllers/cgroup/cgroup_core03.c |  2 +-
>  testcases/kernel/crypto/af_alg02.c            |  2 +-
>  testcases/kernel/crypto/af_alg07.c            |  2 +-
>  testcases/kernel/crypto/pcrypt_aead01.c       |  2 +-
>  testcases/kernel/fs/fs_fill/fs_fill.c         |  2 +-
>  testcases/kernel/fs/fsplough/fsplough.c       |  2 +-
>  testcases/kernel/fs/fsx-linux/fsx-linux.c     |  2 +-
>  testcases/kernel/fs/read_all/read_all.c       |  4 +-
>  testcases/kernel/io/ltp-aiodio/aio-stress.c   |  2 +-
>  testcases/kernel/io/ltp-aiodio/aiocp.c        |  2 +-
>  .../kernel/io/ltp-aiodio/aiodio_append.c      |  2 +-
>  .../kernel/io/ltp-aiodio/aiodio_sparse.c      |  2 +-
>  testcases/kernel/io/ltp-aiodio/dio_append.c   |  2 +-
>  testcases/kernel/io/ltp-aiodio/dio_read.c     |  2 +-
>  testcases/kernel/io/ltp-aiodio/dio_sparse.c   |  2 +-
>  testcases/kernel/io/ltp-aiodio/dio_truncate.c |  2 +-
>  testcases/kernel/mem/ksm/ksm02.c              |  4 +-
>  testcases/kernel/mem/ksm/ksm04.c              |  4 +-
>  .../kernel/mem/mmapstress/mmapstress01.c      |  2 +-
>  testcases/kernel/mem/mtest01/mtest01.c        |  2 +-
>  testcases/kernel/mem/mtest06/mmap1.c          |  2 +-
>  testcases/kernel/mem/mtest06/mmap3.c          |  2 +-
>  testcases/kernel/mem/mtest07/mallocstress.c   |  2 +-
>  testcases/kernel/mem/oom/oom01.c              |  2 +-
>  testcases/kernel/mem/oom/oom02.c              |  2 +-
>  testcases/kernel/mem/oom/oom03.c              |  2 +-
>  testcases/kernel/mem/oom/oom04.c              |  2 +-
>  testcases/kernel/mem/oom/oom05.c              |  2 +-
>  testcases/kernel/mem/swapping/swapping01.c    |  2 +-
>  testcases/kernel/mem/thp/thp04.c              |  2 +-
>  .../kernel/mem/tunable/min_free_kbytes.c      |  2 +-
>  testcases/kernel/pty/pty03.c                  |  2 +-
>  testcases/kernel/pty/pty05.c                  |  2 +-
>  testcases/kernel/pty/pty06.c                  |  2 +-
>  testcases/kernel/pty/pty07.c                  |  2 +-
>  .../sched/cfs-scheduler/cfs_bandwidth01.c     |  2 +-
>  .../kernel/sched/cfs-scheduler/starvation.c   |  2 +-
>  .../security/dirtyc0w_shmem/dirtyc0w_shmem.c  |  2 +-
>  testcases/kernel/security/kallsyms/kallsyms.c |  2 +-
>  testcases/kernel/sound/snd_seq01.c            |  2 +-
>  testcases/kernel/sound/snd_timer01.c          |  2 +-
>  testcases/kernel/syscalls/bind/bind06.c       |  2 +-
>  .../copy_file_range/copy_file_range01.c       |  2 +-
>  .../kernel/syscalls/fallocate/fallocate06.c   |  2 +-
>  testcases/kernel/syscalls/fork/fork13.c       |  2 +-
>  testcases/kernel/syscalls/fsync/fsync02.c     |  2 +-
>  .../syscalls/gettimeofday/gettimeofday02.c    |  2 +-
>  testcases/kernel/syscalls/inotify/inotify06.c |  2 +-
>  testcases/kernel/syscalls/inotify/inotify09.c |  2 +-
>  testcases/kernel/syscalls/inotify/inotify12.c |  2 +-
>  testcases/kernel/syscalls/ioctl/ioctl_sg01.c  |  2 +-
>  .../syscalls/ipc/msgstress/msgstress01.c      |  2 +-
>  .../kernel/syscalls/ipc/semget/semget05.c     |  2 +-
>  .../kernel/syscalls/ipc/shmctl/shmctl05.c     |  2 +-
>  testcases/kernel/syscalls/keyctl/keyctl02.c   |  2 +-
>  .../kernel/syscalls/landlock/landlock04.c     |  2 +-
>  testcases/kernel/syscalls/madvise/madvise06.c |  2 +-
>  testcases/kernel/syscalls/madvise/madvise11.c |  2 +-
>  .../syscalls/migrate_pages/migrate_pages03.c  |  2 +-
>  .../kernel/syscalls/move_pages/move_pages12.c |  2 +-
>  testcases/kernel/syscalls/nice/nice05.c       |  2 +-
>  .../perf_event_open/perf_event_open02.c       |  2 +-
>  .../perf_event_open/perf_event_open03.c       |  2 +-
>  testcases/kernel/syscalls/preadv2/preadv203.c |  2 +-
>  .../kernel/syscalls/readahead/readahead02.c   |  8 +-
>  .../syscalls/request_key/request_key03.c      |  2 +-
>  .../kernel/syscalls/sendfile/sendfile09.c     |  2 +-
>  testcases/kernel/syscalls/sendmsg/sendmsg03.c |  2 +-
>  .../syscalls/set_mempolicy/set_mempolicy01.c  |  4 +-
>  .../kernel/syscalls/setsockopt/setsockopt06.c |  2 +-
>  .../kernel/syscalls/setsockopt/setsockopt07.c |  2 +-
>  testcases/kernel/syscalls/swapoff/swapoff01.c |  2 +-
>  testcases/kernel/syscalls/swapon/swapon01.c   |  2 +-
>  .../syscalls/timerfd/timerfd_settime02.c      |  2 +-
>  testcases/kernel/syscalls/writev/writev03.c   |  2 +-
>  testcases/network/can/cve/can_bcm01.c         |  2 +-
>  testcases/network/netstress/netstress.c       |  2 +-
>  .../network/nfs/nfs_stress/nfs05_make_tree.c  |  2 +-
>  testcases/network/packet/fanout01.c           |  2 +-
>  testcases/network/sockets/vsock01.c           |  2 +-
>  95 files changed, 196 insertions(+), 178 deletions(-)
> 
> diff --git a/doc/old/C-Test-API.asciidoc b/doc/old/C-Test-API.asciidoc
> index 36036039b..d4e0276e4 100644
> --- a/doc/old/C-Test-API.asciidoc
> +++ b/doc/old/C-Test-API.asciidoc
> @@ -95,25 +95,28 @@ in range of [0, '.tcnt' - 1].
>  IMPORTANT: Only one of '.test' and '.test_all' can be set at a time.
>  
>  Each test has a limit on how long it can run and the limit composes of two
> -parts max_runtime and timeout. The max_runtime is a limit for how long can the
> -'.test_all' or a set of '.test' functions take and the timeout is static part
> -that should cover the duration of test setup and cleanup plus some safety.
> +parts runtime and timeout. The runtime is a limit for how long can the
> +'.test_all' or a set of '.test' main functions take and the timeout is static
                       ^
		       As I pointed out the timeout applies per single
		       invocation of the test function.

We can discuss if it should be revisited but that's how the code was
initially written.

The timeout timer is also reset on each subsequent iteration with the
test -i parameter, variants or .all_filesystems.

> +part that should cover the duration of test setup and cleanup plus some safety.
> +If test without an explicit runtime, the timeout governs the entire test duration.
>  
>  Any test that runs for more than a second or two has to make sure to:
>  
> -- set the runtime either by setting the '.max_runtime' in tst_test or by
> -  calling 'tst_set_max_runtime()' in the test setup
>  
> -- monitor remaning runtime by regular calls to 'tst_remaining_runtime()' and
> -  exit when runtime has been used up
> +- set the runtime by setting '.runtime' in tst_test and calling 'tst_set_runtime()'
> +  to monitor the remaining runtime and ensure the test exits when the runtime
> +  limit is reached.
>  
> -Test is free to exit before max_runtime has been used up for example when
> +- set the timeout by setting '.timeout' in tst_test to limit the whole test
> +  run that does not use 'tst_remaining_runtime()'.
> +
> +Test is free to exit before runtime has been used up for example when
>  minimal number of iteration was finished.
>  
>  The limit is applied to a single call of the '.test_all' function that means
>  that for example when '.test_variants' or '.all_filesystems' is set the whole
> -test will be limited by 'variants * (max_runtime + timeout)' seconds and the
> -test runtime will be likely close to 'variants * max_runtime' seconds.
> +test will be limited by 'variants * (runtime + timeout)' seconds and the
> +test runtime will be likely close to 'variants * runtime' seconds.
>  
>  [source,c]
>  -------------------------------------------------------------------------------
> @@ -401,13 +404,16 @@ WARNING: This function is not thread safe.
>  
>  [source,c]
>  -------------------------------------------------------------------------------
> -void tst_set_max_runtime(int max_runtime);
> +void tst_set_runtime(int runtime);
>  -------------------------------------------------------------------------------
>  
> -Allows for setting max_runtime per test iteration dynamically in the test 'setup()',
> -the timeout is specified in seconds. There are a few testcases whose runtime
> -can vary arbitrarily, these can disable timeouts by setting it to
> -TST_UNLIMITED_RUNTIME.
> +Allows for setting the runtime per test iteration dynamically during the test 'setup()'.
> +The runtime is specified in seconds and represents the duration the test is allowed
> +to execute its main workload, excluding setup and teardown phases.
> +
> +This function is useful for tests where the duration of the main workload can be
> +controlled or needs to be adjusted dynamically. For example, tests that loop until
> +the runtime expires can use this function to define how long they should run.
>  
>  [source,c]
>  -------------------------------------------------------------------------------
> diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
> index 7f183ca51..721ec6bb5 100644
> --- a/doc/users/setup_tests.rst
> +++ b/doc/users/setup_tests.rst
> @@ -87,14 +87,14 @@ See :master:`testcases/network/README.md`.
>  Test execution time and timeout
>  -------------------------------
>  
> -The limit on how long a test can run does compose of two parts: ``max_runtime``
> +The limit on how long a test can run does compose of two parts: ``runtime``
>  and ``timeout``. The limit does apply to a single test variant. That means, for
>  example, that tests which run for all available filesystems will apply this
>  limit for a single filesystem only.
>  
> -The ``max_runtime`` is a cap on how long the ``run()`` function can take and for
> +The ``runtime`` is a cap on how long the ``run()`` function can take and for
>  most testcases this part is set to zero. For tests that do run for more than a
> -second or two the ``max_runtime`` has to be defined and the ``run()`` function
> +second or two the ``runtime`` has to be defined and the ``run()`` function
>  has to check actively how much runtime is left.
>  
>  Test runtime can be scaled up and down with ``LTP_RUNTIME_MUL`` environment
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 9da411a13..8df05b9bb 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -234,7 +234,7 @@ struct tst_tag {
>  
>  extern unsigned int tst_variant;
>  
> -#define TST_UNLIMITED_RUNTIME (-1)
> +#define TST_UNLIMITED_TIMEOUT (-1)
>  
>  /**
>   * struct tst_ulimit_val - An ulimit resource and value.
> @@ -435,13 +435,25 @@ struct tst_fs {
>   *            The directory is created by the library, the test must not create
>   *            it itself.
>   *
> - * @max_runtime: Maximal test runtime in seconds. Any test that runs for more
> - *               than a second or two should set this and also use
> - *               tst_remaining_runtime() to exit when runtime was used up.
> - *               Tests may finish sooner, for example if requested number of
> - *               iterations was reached before the runtime runs out. If test
> - *               runtime cannot be know in advance it should be set to
> - *               TST_UNLIMITED_RUNTIME.
> + * @timeout: Maximum allowable time in seconds for the entire duration of a test.
> + *           By default, the timeout limits the total time for setup, execution,
                                                                         ^
							single test function invocation

		We should make sure that it's clear that the timeout is
		reset in case of the different multipliers (the -i
		parameter, variants, all_filesytems...)

> + *           and cleanup phases. However, if `.runtime` is explicitly set and
> + *           tst_remaining_runtime() is used in the test's main loop, the timeout
> + *           then applies only to the setup and cleanup phases, as the runtime
> + *           separately limits the main test execution. This ensures the test
> + *           does not hang indefinitely, and if the setup or cleanup time cannot
                                               ^
					       in the rare case that the
					       test timeout cannot be
					       ...
> + *           be accurately determined, it can be set to a sufficiently large value
> + *           or TST_UNLIMITED_TIMEOUT to remove the limit.
> + *
> + * @runtime: Maximum runtime in seconds for the test's main execution loop.
> + *           This should be set for tests that are expected to run longer
> + *           than a few seconds and call tst_remaining_runtime() in their
> + *           main loop to exit gracefully when the runtime is exceeded.
> + *           Tests may finish sooner if their task completes (e.g., reaching
> + *           a requested number of iterations) before the runtime runs out.
> + *           The runtime is fixed and does not scale with timeout multipliers
> + *           (e.g., TIMEOUT_MUL), ensuring consistent test duration across
> + *           different environments (e.g., debug vs. stock kernels).

Good description, thanks!

>   * @setup: Setup callback is called once at the start of the test in order to
>   *         prepare the test environment.
> @@ -565,7 +577,8 @@ struct tst_fs {
>  
>  	const char *mntpoint;
>  
> -	int max_runtime;
> +	int timeout;
> +	int runtime;
>  
>  	void (*setup)(void);
>  	void (*cleanup)(void);
> @@ -676,7 +689,7 @@ unsigned int tst_remaining_runtime(void);
>  /*
>   * Sets maximal test runtime in seconds.
>   */
> -void tst_set_max_runtime(int max_runtime);
> +void tst_set_runtime(int runtime);
>  
>  /*
>   * Create and open a random file inside the given dir path.
> diff --git a/lib/newlib_tests/shell/test_timeout.sh b/lib/newlib_tests/shell/test_timeout.sh
> index c70e22f27..d666a54f2 100755
> --- a/lib/newlib_tests/shell/test_timeout.sh
> +++ b/lib/newlib_tests/shell/test_timeout.sh
> @@ -10,7 +10,7 @@ PATH="$(dirname $0):$(dirname $0)/../../../testcases/lib/:$PATH"
>  # file
>  # timeout_mul
>  # use_cat
> -# max_runtime
> +# runtime
>  # expected_exit_code
>  # expected passes
>  # expected failed
> @@ -114,8 +114,8 @@ for d in $CLEANED_DATA; do
>  	file=$(echo $d | cut -d'|' -f1 | xargs)
>  	timeout=$(echo $d | cut -d'|' -f2 | xargs)
>  	use_cat=$(echo $d | cut -d'|' -f3 | xargs)
> -	max_runtime=$(echo $d | cut -d'|' -f4 | xargs)
> -	max_runtime=${max_runtime:--1}
> +	runtime=$(echo $d | cut -d'|' -f4 | xargs)
> +	runtime=${runtime:--1}
>  	exp_exit=$(echo $d | cut -d'|' -f5 | xargs)
>  	exp_exit=${exp_exit:--1}
>  	exp_passed=$(echo $d | cut -d'|' -f6 | xargs)
> @@ -137,8 +137,8 @@ for d in $CLEANED_DATA; do
>  	echo "=== $test_nr/$test_max $description ==="
>  	run_test "$file" "$timeout" "$use_cat"
>  
> -	if [ $max_runtime -ne -1 ] && [ $test_duration -gt $max_runtime ]; then
> -		echo "FAILED (runtime: $test_duration, expected less than $max_runtime)"
> +	if [ $runtime -ne -1 ] && [ $test_duration -gt $runtime ]; then
> +		echo "FAILED (runtime: $test_duration, expected less than $runtime)"
>  		cur_fails=$((cur_fails + 1))
>  	fi

This seems to be unrelated, that's just a variable name we parse the
test description into. So I would keep the shell script as it is.

> diff --git a/lib/newlib_tests/test_runtime01.c b/lib/newlib_tests/test_runtime01.c
> index 5e027546d..169033850 100644
> --- a/lib/newlib_tests/test_runtime01.c
> +++ b/lib/newlib_tests/test_runtime01.c
> @@ -25,6 +25,6 @@ static void run(void)
>  
>  static struct tst_test test = {
>  	.test_all = run,
> -	.max_runtime = 4,
> +	.runtime = 4,
>  	.test_variants = 2,
>  };
> diff --git a/lib/newlib_tests/test_runtime02.c b/lib/newlib_tests/test_runtime02.c
> index 6d89cb531..dd8eaa4d3 100644
> --- a/lib/newlib_tests/test_runtime02.c
> +++ b/lib/newlib_tests/test_runtime02.c
> @@ -24,5 +24,5 @@ static void run(void)
>  
>  static struct tst_test test = {
>  	.test_all = run,
> -	.max_runtime = 5,
> +	.runtime = 5,
>  };
> diff --git a/lib/newlib_tests/tst_fuzzy_sync01.c b/lib/newlib_tests/tst_fuzzy_sync01.c
> index f0e55a97f..2d440df5b 100644
> --- a/lib/newlib_tests/tst_fuzzy_sync01.c
> +++ b/lib/newlib_tests/tst_fuzzy_sync01.c
> @@ -248,5 +248,5 @@ static struct tst_test test = {
>  	.test = run,
>  	.setup = setup,
>  	.cleanup = cleanup,
> -	.max_runtime = 150,
> +	.runtime = 150,
>  };
> diff --git a/lib/newlib_tests/tst_fuzzy_sync02.c b/lib/newlib_tests/tst_fuzzy_sync02.c
> index 25a6c2233..c81ebc7ea 100644
> --- a/lib/newlib_tests/tst_fuzzy_sync02.c
> +++ b/lib/newlib_tests/tst_fuzzy_sync02.c
> @@ -225,5 +225,5 @@ static struct tst_test test = {
>  	.test = run,
>  	.setup = setup,
>  	.cleanup = cleanup,
> -	.max_runtime = 150,
> +	.runtime = 150,
>  };
> diff --git a/lib/newlib_tests/tst_fuzzy_sync03.c b/lib/newlib_tests/tst_fuzzy_sync03.c
> index 47ce7675a..7468e79ea 100644
> --- a/lib/newlib_tests/tst_fuzzy_sync03.c
> +++ b/lib/newlib_tests/tst_fuzzy_sync03.c
> @@ -99,5 +99,5 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.test_all = run,
> -	.max_runtime = 150,
> +	.runtime = 150,
>  };
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index feffc9f86..486df6cd7 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -71,8 +71,8 @@ struct results {
>  	int failed;
>  	int warnings;
>  	int broken;
> -	unsigned int timeout;
> -	int max_runtime;
> +	unsigned int runtime;
> +	unsigned int overall_time;
>  };
>  
>  static struct results *results;
> @@ -546,16 +546,13 @@ static void parse_mul(float *mul, const char *env_name, float min, float max)
>  	}
>  }
>  
> -static int multiply_runtime(int max_runtime)
> +static int multiply_runtime(unsigned int runtime)
>  {
>  	static float runtime_mul = -1;
>  
> -	if (max_runtime <= 0)
> -		return max_runtime;
> -
>  	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);
>  
> -	return max_runtime * runtime_mul;
> +	return runtime * runtime_mul;
>  }
>  
>  static struct option {
> @@ -593,21 +590,21 @@ static void print_help(void)
>  	fprintf(stderr, "Timeout and runtime\n");
>  	fprintf(stderr, "-------------------\n");
>  
> -	if (tst_test->max_runtime) {
> -		runtime = multiply_runtime(tst_test->max_runtime);
> +	if (tst_test->timeout == TST_UNLIMITED_TIMEOUT) {
> +		fprintf(stderr, "Test timeout is not limited\n");
> +	} else {
> +		timeout = tst_multiply_timeout(DEFAULT_TIMEOUT + tst_test->timeout);
>  
> -		if (runtime == TST_UNLIMITED_RUNTIME) {
> -			fprintf(stderr, "Test iteration runtime is not limited\n");
> -		} else {
> -			fprintf(stderr, "Test iteration runtime cap %ih %im %is\n",
> -				runtime/3600, (runtime%3600)/60, runtime % 60);
> -		}
> +		fprintf(stderr, "Test timeout (not including runtime) %ih %im %is\n",
> +				timeout/3600, (timeout%3600)/60, timeout % 60);
>  	}
>  
> -	timeout = tst_multiply_timeout(DEFAULT_TIMEOUT);
> +	if (tst_test->runtime) {
> +		runtime = multiply_runtime(tst_test->runtime);
>  
> -	fprintf(stderr, "Test timeout (not including runtime) %ih %im %is\n",
> -		timeout/3600, (timeout%3600)/60, timeout % 60);
> +		fprintf(stderr, "Test iteration runtime cap %ih %im %is\n",
> +				runtime/3600, (runtime%3600)/60, runtime % 60);
> +	}
>  
>  	fprintf(stderr, "\n");
>  
> @@ -740,8 +737,8 @@ static void parse_opts(int argc, char *argv[])
>  			iterations = SAFE_STRTOL(optarg, 0, INT_MAX);
>  		break;
>  		case 'I':
> -			if (tst_test->max_runtime > 0)
> -				tst_test->max_runtime = SAFE_STRTOL(optarg, 1, INT_MAX);
> +			if (tst_test->runtime > 0)
> +				tst_test->runtime = SAFE_STRTOL(optarg, 1, INT_MAX);
>  			else
>  				duration = SAFE_STRTOF(optarg, 0.1, HUGE_VALF);
>  		break;
> @@ -1265,9 +1262,14 @@ static void do_setup(int argc, char *argv[])
>  	if (!tst_test)
>  		tst_brk(TBROK, "No tests to run");
>  
> -	if (tst_test->max_runtime < -1) {
> +	if (tst_test->timeout < -1) {
> +		tst_brk(TBROK, "Invalid timeout value %i",
> +			tst_test->timeout);
> +	}
> +
> +	if (tst_test->runtime < 0) {
>  		tst_brk(TBROK, "Invalid runtime value %i",
> -			results->max_runtime);
> +			results->runtime);
>  	}
>  
>  	if (tst_test->tconf_msg)
> @@ -1662,7 +1664,7 @@ static void alarm_handler(int sig LTP_ATTRIBUTE_UNUSED)
>  
>  static void heartbeat_handler(int sig LTP_ATTRIBUTE_UNUSED)
>  {
> -	alarm(results->timeout);
> +	alarm(results->overall_time);
>  	sigkill_retries = 0;
>  }
>  
> @@ -1679,18 +1681,15 @@ unsigned int tst_remaining_runtime(void)
>  	static struct timespec now;
>  	int elapsed;
>  
> -	if (results->max_runtime == TST_UNLIMITED_RUNTIME)
> -		return UINT_MAX;
> -
> -	if (results->max_runtime == 0)
> +	if (results->runtime == 0)
>  		tst_brk(TBROK, "Runtime not set!");
>  
>  	if (tst_clock_gettime(CLOCK_MONOTONIC, &now))
>  		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
>  
>  	elapsed = tst_timespec_diff_ms(now, tst_start_time) / 1000;
> -	if (results->max_runtime > elapsed)
> -		return results->max_runtime - elapsed;
> +	if (results->runtime > elapsed)
> +		return results->runtime - elapsed;
>  
>  	return 0;
>  }
> @@ -1709,33 +1708,33 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
>  	return timeout * timeout_mul;
>  }
>  
> -static void set_timeout(void)
> +static void set_overall_timeout(void)
>  {
> -	unsigned int timeout = DEFAULT_TIMEOUT;
> +	unsigned int timeout = DEFAULT_TIMEOUT + tst_test->timeout;
>  
> -	if (results->max_runtime == TST_UNLIMITED_RUNTIME) {
> +	if (tst_test->timeout == TST_UNLIMITED_TIMEOUT) {
>  		tst_res(TINFO, "Timeout per run is disabled");
>  		return;
>  	}
>  
> -	if (results->max_runtime < 0) {
> -		tst_brk(TBROK, "max_runtime must to be >= -1! (%d)",
> -			results->max_runtime);
> +	if (results->runtime < 0) {
> +		tst_brk(TBROK, "runtime must to be > 0! (%d)",
> +			results->runtime);
>  	}
>  
> -	results->timeout = tst_multiply_timeout(timeout) + results->max_runtime;
> +	results->overall_time = tst_multiply_timeout(timeout) + results->runtime;
>  
> -	tst_res(TINFO, "Timeout per run is %uh %02um %02us",
> -		results->timeout/3600, (results->timeout%3600)/60,
> -		results->timeout % 60);
> +	tst_res(TINFO, "Overall timeout per run is %uh %02um %02us",
> +		results->overall_time/3600, (results->overall_time%3600)/60,
> +		results->overall_time % 60);
>  }
>  
> -void tst_set_max_runtime(int max_runtime)
> +void tst_set_runtime(int runtime)
>  {
> -	results->max_runtime = multiply_runtime(max_runtime);
> -	tst_res(TINFO, "Updating max runtime to %uh %02um %02us",
> -		max_runtime/3600, (max_runtime%3600)/60, max_runtime % 60);
> -	set_timeout();
> +	results->runtime = multiply_runtime(runtime);
> +	tst_res(TINFO, "Updating runtime to %uh %02um %02us",
> +		runtime/3600, (runtime%3600)/60, runtime % 60);
> +	set_overall_timeout();
>  	heartbeat();
>  }
>  
> @@ -1746,7 +1745,7 @@ static int fork_testrun(void)
>  	SAFE_SIGNAL(SIGINT, sigint_handler);
>  	SAFE_SIGNAL(SIGTERM, sigint_handler);
>  
> -	alarm(results->timeout);
> +	alarm(results->overall_time);
>  
>  	show_failure_hints = 1;
>  
> @@ -1896,10 +1895,10 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>  	uname(&uval);
>  	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
>  
> -	if (tst_test->max_runtime)
> -		results->max_runtime = multiply_runtime(tst_test->max_runtime);
> +	if (tst_test->runtime)
> +		results->runtime = multiply_runtime(tst_test->runtime);
>  
> -	set_timeout();
> +	set_overall_timeout();
>  
>  	if (tst_test->test_variants)
>  		test_variants = tst_test->test_variants;
> diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
> index 512edc54b..b5a088a14 100644
> --- a/lib/tst_timer_test.c
> +++ b/lib/tst_timer_test.c
> @@ -454,7 +454,7 @@ static void parse_timer_opts(void)
>  			runtime_us += tcases[i].usec * tcases[i].samples;
>  	}
>  
> -	tst_set_max_runtime((runtime_us + runtime_us/10)/1000000);
> +	tst_set_runtime((runtime_us + runtime_us/10)/1000000);
>  }
>  

...

> diff --git a/testcases/kernel/fs/fsplough/fsplough.c b/testcases/kernel/fs/fsplough/fsplough.c
> index 900aaacab..e65dd9823 100644
> --- a/testcases/kernel/fs/fsplough/fsplough.c
> +++ b/testcases/kernel/fs/fsplough/fsplough.c
> @@ -190,7 +190,7 @@ static void setup(void)
>  		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>  	filedata = SAFE_MALLOC(filesize);
>  
> -	tst_set_max_runtime(bufsize * loop_count / (8 * 1024 * 1024));
> +	tst_set_runtime(bufsize * loop_count / (8 * 1024 * 1024));

This should be setting timeout similarily to the set_mempolicy01.c

>  }
>  
>  static void run(void)

...

> diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
> index 3707de95d..c4d78d7ed 100644
> --- a/testcases/kernel/mem/ksm/ksm02.c
> +++ b/testcases/kernel/mem/ksm/ksm02.c
> @@ -87,7 +87,7 @@ static void setup(void)
>  	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
>  
>  	if (opt_sizestr && size > DEFAULT_MEMSIZE)
> -		tst_set_max_runtime(32 * (size / DEFAULT_MEMSIZE));
> +		tst_set_runtime(32 * (size / DEFAULT_MEMSIZE));
>  }
>  
>  static struct tst_test test = {
> @@ -116,7 +116,7 @@ static struct tst_test test = {
>  		NULL
>  	},
>  	.test_all = verify_ksm,
> -	.max_runtime = 32,
> +	.runtime = 32,
>  	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
>  };

And here as well, this should set timeout and call tst_set_timeout()

> diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
> index f558b23be..aff61ff7a 100644
> --- a/testcases/kernel/mem/ksm/ksm04.c
> +++ b/testcases/kernel/mem/ksm/ksm04.c
> @@ -74,7 +74,7 @@ static void setup(void)
>  	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
>  
>  	if (opt_sizestr && size > DEFAULT_MEMSIZE)
> -		tst_set_max_runtime(32 * (size / DEFAULT_MEMSIZE));
> +		tst_set_runtime(32 * (size / DEFAULT_MEMSIZE));
>  }
>  
>  static struct tst_test test = {
> @@ -103,7 +103,7 @@ static struct tst_test test = {
>  		NULL
>  	},
>  	.test_all = verify_ksm,
> -	.max_runtime = 32,
> +	.runtime = 32,
>  	.needs_cgroup_ctrls = (const char *const []){
>  		"memory", "cpuset", NULL
>  	},

Here as well.


Apart from the few tests that I think need tst_set_timeout() instead of
tst_set_runtime() this looks good to me. Thanks a lot for doing this!

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
