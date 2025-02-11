Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54499C0219B
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 22:32:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0F333C9991
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 23:32:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F10243C2B2C
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 23:32:04 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 91CA01025AFE
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 23:32:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 373A733827;
 Tue, 11 Feb 2025 22:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739313121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XDed6mwtNf1isf1445SX+te/kg/QRdRu/BNhuMJmw/8=;
 b=SwQ9eSS+wViY9NiZt32oN2HHqDihvEvV7EiEt/tnDr4EazN7VKpoRz5Aglm9Ch0CqvviFJ
 mKA1MNyoh9VVjPrVX7ih4AOfNHUpPx5shMJLp2sU0KafK6XZ333LTL7earxBmsrHm16qms
 4Y/YSNyrPVQyP9rKdU2YkdmrSfeBqqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739313121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XDed6mwtNf1isf1445SX+te/kg/QRdRu/BNhuMJmw/8=;
 b=LAPaCXIAsdJSxXr+ziPFuJWOwqgvhIpJpg30ykKNkCNwr9wV270QYuQ8Gr0t/64nB+ceB/
 JeGMLjo70aV7s/CA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SwQ9eSS+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LAPaCXIA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739313121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XDed6mwtNf1isf1445SX+te/kg/QRdRu/BNhuMJmw/8=;
 b=SwQ9eSS+wViY9NiZt32oN2HHqDihvEvV7EiEt/tnDr4EazN7VKpoRz5Aglm9Ch0CqvviFJ
 mKA1MNyoh9VVjPrVX7ih4AOfNHUpPx5shMJLp2sU0KafK6XZ333LTL7earxBmsrHm16qms
 4Y/YSNyrPVQyP9rKdU2YkdmrSfeBqqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739313121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XDed6mwtNf1isf1445SX+te/kg/QRdRu/BNhuMJmw/8=;
 b=LAPaCXIAsdJSxXr+ziPFuJWOwqgvhIpJpg30ykKNkCNwr9wV270QYuQ8Gr0t/64nB+ceB/
 JeGMLjo70aV7s/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5545713715;
 Tue, 11 Feb 2025 22:32:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wl2sE+DPq2eZZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Feb 2025 22:32:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 11 Feb 2025 23:31:56 +0100
Message-ID: <20250211223156.1974651-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 373A733827
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,sourceware.org:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc: Remove [Description] title
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It does not add any information value (it's obvious that the text
description follows), removing it makes the test catalog page shorter.

Removed with:
for i in $(git grep -l ' \* \[Description\]'); do sed -Ezr 's:[ ]*\* \[Description\]\n( \*\n)*::g' -i $i; done

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/developers/test_case_tutorial.rst                           | 1 -
 doc/old/C-Test-API.asciidoc                                     | 1 -
 include/tst_cgroup.h                                            | 2 --
 lib/newlib_tests/tst_fuzzy_sync01.c                             | 2 --
 lib/newlib_tests/tst_fuzzy_sync02.c                             | 2 --
 testcases/cve/cve-2014-0196.c                                   | 2 --
 testcases/cve/cve-2016-10044.c                                  | 2 --
 testcases/cve/cve-2016-7042.c                                   | 2 --
 testcases/cve/cve-2016-7117.c                                   | 2 --
 testcases/cve/cve-2017-16939.c                                  | 2 --
 testcases/cve/cve-2017-17052.c                                  | 2 --
 testcases/cve/cve-2017-17053.c                                  | 2 --
 testcases/cve/cve-2017-2618.c                                   | 2 --
 testcases/cve/cve-2017-2671.c                                   | 2 --
 testcases/cve/cve-2022-4378.c                                   | 2 --
 testcases/cve/icmp_rate_limit01.c                               | 2 --
 testcases/cve/meltdown.c                                        | 2 --
 testcases/cve/stack_clash.c                                     | 2 --
 testcases/cve/tcindex01.c                                       | 2 --
 testcases/kernel/containers/mountns/mountns01.c                 | 2 --
 testcases/kernel/containers/mountns/mountns02.c                 | 2 --
 testcases/kernel/containers/mountns/mountns03.c                 | 2 --
 testcases/kernel/containers/mountns/mountns04.c                 | 2 --
 testcases/kernel/containers/mqns/mqns_01.c                      | 2 --
 testcases/kernel/containers/mqns/mqns_02.c                      | 2 --
 testcases/kernel/containers/mqns/mqns_03.c                      | 2 --
 testcases/kernel/containers/mqns/mqns_04.c                      | 2 --
 testcases/kernel/containers/netns/netns_netlink.c               | 2 --
 testcases/kernel/containers/pidns/pidns01.c                     | 2 --
 testcases/kernel/containers/pidns/pidns02.c                     | 2 --
 testcases/kernel/containers/pidns/pidns03.c                     | 2 --
 testcases/kernel/containers/pidns/pidns04.c                     | 2 --
 testcases/kernel/containers/pidns/pidns05.c                     | 2 --
 testcases/kernel/containers/pidns/pidns06.c                     | 2 --
 testcases/kernel/containers/pidns/pidns10.c                     | 2 --
 testcases/kernel/containers/pidns/pidns12.c                     | 2 --
 testcases/kernel/containers/pidns/pidns13.c                     | 2 --
 testcases/kernel/containers/pidns/pidns16.c                     | 2 --
 testcases/kernel/containers/pidns/pidns17.c                     | 2 --
 testcases/kernel/containers/pidns/pidns20.c                     | 2 --
 testcases/kernel/containers/pidns/pidns30.c                     | 2 --
 testcases/kernel/containers/pidns/pidns31.c                     | 2 --
 testcases/kernel/containers/pidns/pidns32.c                     | 2 --
 testcases/kernel/containers/sysvipc/mesgq_nstest.c              | 2 --
 testcases/kernel/containers/sysvipc/msg_comm.c                  | 2 --
 testcases/kernel/containers/sysvipc/sem_comm.c                  | 2 --
 testcases/kernel/containers/sysvipc/sem_nstest.c                | 2 --
 testcases/kernel/containers/sysvipc/semtest_2ns.c               | 2 --
 testcases/kernel/containers/sysvipc/shm_comm.c                  | 2 --
 testcases/kernel/containers/sysvipc/shmem_2nstest.c             | 2 --
 testcases/kernel/containers/sysvipc/shmnstest.c                 | 2 --
 testcases/kernel/containers/userns/userns01.c                   | 2 --
 testcases/kernel/containers/userns/userns02.c                   | 2 --
 testcases/kernel/containers/userns/userns03.c                   | 2 --
 testcases/kernel/containers/userns/userns04.c                   | 2 --
 testcases/kernel/containers/userns/userns05.c                   | 2 --
 testcases/kernel/containers/userns/userns06.c                   | 2 --
 testcases/kernel/containers/userns/userns07.c                   | 2 --
 testcases/kernel/containers/userns/userns08.c                   | 2 --
 testcases/kernel/containers/utsname/utsname01.c                 | 2 --
 testcases/kernel/containers/utsname/utsname02.c                 | 2 --
 testcases/kernel/containers/utsname/utsname03.c                 | 2 --
 testcases/kernel/containers/utsname/utsname04.c                 | 2 --
 testcases/kernel/controllers/cgroup/cgroup_core01.c             | 2 --
 testcases/kernel/controllers/cgroup/cgroup_core02.c             | 2 --
 testcases/kernel/controllers/cgroup/cgroup_core03.c             | 2 --
 testcases/kernel/controllers/io/io_control01.c                  | 2 --
 testcases/kernel/controllers/memcg/memcontrol01.c               | 2 --
 testcases/kernel/controllers/memcg/memcontrol02.c               | 2 --
 testcases/kernel/controllers/memcg/memcontrol03.c               | 2 --
 testcases/kernel/controllers/memcg/memcontrol04.c               | 2 --
 .../kernel/device-drivers/block/block_dev_user/block_dev.c      | 2 --
 testcases/kernel/device-drivers/rtc/rtc02.c                     | 2 --
 testcases/kernel/device-drivers/zram/zram03.c                   | 2 --
 testcases/kernel/fs/fsplough/fsplough.c                         | 2 --
 testcases/kernel/fs/fsx-linux/fsx-linux.c                       | 2 --
 testcases/kernel/fs/squashfs/squashfs01.c                       | 2 --
 testcases/kernel/input/input01.c                                | 2 --
 testcases/kernel/input/input02.c                                | 2 --
 testcases/kernel/input/input03.c                                | 2 --
 testcases/kernel/input/input04.c                                | 2 --
 testcases/kernel/input/input05.c                                | 2 --
 testcases/kernel/input/input06.c                                | 2 --
 testcases/kernel/io/ltp-aiodio/aio-stress.c                     | 2 --
 testcases/kernel/io/ltp-aiodio/aiocp.c                          | 2 --
 testcases/kernel/io/ltp-aiodio/aiodio_append.c                  | 2 --
 testcases/kernel/io/ltp-aiodio/aiodio_sparse.c                  | 2 --
 testcases/kernel/io/ltp-aiodio/dio_append.c                     | 2 --
 testcases/kernel/io/ltp-aiodio/dio_read.c                       | 2 --
 testcases/kernel/io/ltp-aiodio/dio_sparse.c                     | 2 --
 testcases/kernel/io/ltp-aiodio/dio_truncate.c                   | 2 --
 testcases/kernel/irq/irqbalance01.c                             | 2 --
 testcases/kernel/kvm/kvm_svm04.c                                | 2 --
 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c    | 2 --
 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c    | 2 --
 testcases/kernel/mem/hugetlb/hugefork/hugefork01.c              | 2 --
 testcases/kernel/mem/hugetlb/hugefork/hugefork02.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c              | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c              | 2 --
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c              | 2 --
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c          | 2 --
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c          | 2 --
 testcases/kernel/mem/ksm/ksm04.c                                | 2 --
 testcases/kernel/mem/ksm/ksm06.c                                | 2 --
 testcases/kernel/mem/ksm/ksm07.c                                | 2 --
 testcases/kernel/mem/mmapstress/mmapstress01.c                  | 1 -
 testcases/kernel/mem/oom/oom01.c                                | 2 --
 testcases/kernel/mem/oom/oom02.c                                | 2 --
 testcases/kernel/mem/oom/oom03.c                                | 2 --
 testcases/kernel/mem/oom/oom04.c                                | 2 --
 testcases/kernel/mem/oom/oom05.c                                | 2 --
 testcases/kernel/mem/swapping/swapping01.c                      | 2 --
 testcases/kernel/mem/thp/thp01.c                                | 2 --
 testcases/kernel/mem/thp/thp02.c                                | 2 --
 testcases/kernel/pty/ptem01.c                                   | 2 --
 testcases/kernel/pty/ptem02.c                                   | 2 --
 testcases/kernel/pty/ptem03.c                                   | 2 --
 testcases/kernel/pty/ptem04.c                                   | 2 --
 testcases/kernel/pty/ptem05.c                                   | 2 --
 testcases/kernel/pty/ptem06.c                                   | 2 --
 testcases/kernel/pty/pty01.c                                    | 2 --
 testcases/kernel/pty/pty03.c                                    | 2 --
 testcases/kernel/pty/pty06.c                                    | 2 --
 testcases/kernel/pty/pty07.c                                    | 2 --
 testcases/kernel/pty/pty08.c                                    | 2 --
 testcases/kernel/pty/pty09.c                                    | 2 --
 testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c          | 2 --
 testcases/kernel/sched/cfs-scheduler/starvation.c               | 2 --
 testcases/kernel/sched/sysctl/proc_sched_rt01.c                 | 2 --
 testcases/kernel/security/aslr/aslr01.c                         | 2 --
 testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c       | 2 --
 testcases/kernel/security/dirtypipe/dirtypipe.c                 | 2 --
 testcases/kernel/security/kallsyms/kallsyms.c                   | 2 --
 testcases/kernel/syscalls/abort/abort01.c                       | 2 --
 testcases/kernel/syscalls/accept/accept01.c                     | 1 -
 testcases/kernel/syscalls/accept/accept02.c                     | 2 --
 testcases/kernel/syscalls/accept/accept03.c                     | 2 --
 testcases/kernel/syscalls/access/access01.c                     | 2 --
 testcases/kernel/syscalls/access/access02.c                     | 2 --
 testcases/kernel/syscalls/access/access03.c                     | 2 --
 testcases/kernel/syscalls/access/access04.c                     | 2 --
 testcases/kernel/syscalls/acct/acct01.c                         | 2 --
 testcases/kernel/syscalls/acct/acct02.c                         | 2 --
 testcases/kernel/syscalls/adjtimex/adjtimex02.c                 | 2 --
 testcases/kernel/syscalls/adjtimex/adjtimex03.c                 | 2 --
 testcases/kernel/syscalls/alarm/alarm02.c                       | 2 --
 testcases/kernel/syscalls/alarm/alarm03.c                       | 2 --
 testcases/kernel/syscalls/alarm/alarm05.c                       | 2 --
 testcases/kernel/syscalls/alarm/alarm06.c                       | 2 --
 testcases/kernel/syscalls/alarm/alarm07.c                       | 2 --
 testcases/kernel/syscalls/arch_prctl/arch_prctl01.c             | 2 --
 testcases/kernel/syscalls/bind/bind02.c                         | 2 --
 testcases/kernel/syscalls/bpf/bpf_map01.c                       | 2 --
 testcases/kernel/syscalls/bpf/bpf_prog01.c                      | 2 --
 testcases/kernel/syscalls/bpf/bpf_prog02.c                      | 2 --
 testcases/kernel/syscalls/bpf/bpf_prog03.c                      | 2 --
 testcases/kernel/syscalls/bpf/bpf_prog04.c                      | 2 --
 testcases/kernel/syscalls/bpf/bpf_prog05.c                      | 2 --
 testcases/kernel/syscalls/bpf/bpf_prog06.c                      | 2 --
 testcases/kernel/syscalls/bpf/bpf_prog07.c                      | 2 --
 testcases/kernel/syscalls/brk/brk02.c                           | 2 --
 testcases/kernel/syscalls/cachestat/cachestat01.c               | 2 --
 testcases/kernel/syscalls/cachestat/cachestat02.c               | 2 --
 testcases/kernel/syscalls/cachestat/cachestat03.c               | 2 --
 testcases/kernel/syscalls/cachestat/cachestat04.c               | 2 --
 testcases/kernel/syscalls/capset/capset01.c                     | 2 --
 testcases/kernel/syscalls/capset/capset02.c                     | 1 -
 testcases/kernel/syscalls/capset/capset03.c                     | 2 --
 testcases/kernel/syscalls/capset/capset04.c                     | 2 --
 testcases/kernel/syscalls/chdir/chdir04.c                       | 2 --
 testcases/kernel/syscalls/chmod/chmod01.c                       | 2 --
 testcases/kernel/syscalls/chmod/chmod03.c                       | 2 --
 testcases/kernel/syscalls/chmod/chmod06.c                       | 2 --
 testcases/kernel/syscalls/chmod/chmod08.c                       | 2 --
 testcases/kernel/syscalls/chmod/chmod09.c                       | 2 --
 testcases/kernel/syscalls/chown/chown01.c                       | 2 --
 testcases/kernel/syscalls/chown/chown02.c                       | 2 --
 testcases/kernel/syscalls/chown/chown03.c                       | 2 --
 testcases/kernel/syscalls/chown/chown04.c                       | 2 --
 testcases/kernel/syscalls/chown/chown05.c                       | 2 --
 testcases/kernel/syscalls/chroot/chroot01.c                     | 2 --
 testcases/kernel/syscalls/chroot/chroot02.c                     | 2 --
 testcases/kernel/syscalls/chroot/chroot03.c                     | 2 --
 testcases/kernel/syscalls/chroot/chroot04.c                     | 2 --
 testcases/kernel/syscalls/clock_gettime/clock_gettime03.c       | 2 --
 testcases/kernel/syscalls/clock_gettime/clock_gettime04.c       | 2 --
 testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c   | 2 --
 testcases/kernel/syscalls/clone/clone01.c                       | 2 --
 testcases/kernel/syscalls/clone/clone03.c                       | 2 --
 testcases/kernel/syscalls/clone/clone04.c                       | 2 --
 testcases/kernel/syscalls/clone/clone05.c                       | 2 --
 testcases/kernel/syscalls/clone/clone06.c                       | 2 --
 testcases/kernel/syscalls/clone/clone07.c                       | 2 --
 testcases/kernel/syscalls/clone3/clone301.c                     | 2 --
 testcases/kernel/syscalls/clone3/clone302.c                     | 2 --
 testcases/kernel/syscalls/clone3/clone303.c                     | 2 --
 testcases/kernel/syscalls/close/close01.c                       | 2 --
 testcases/kernel/syscalls/close/close02.c                       | 2 --
 testcases/kernel/syscalls/close_range/close_range01.c           | 2 --
 testcases/kernel/syscalls/close_range/close_range02.c           | 2 --
 testcases/kernel/syscalls/cma/process_vm01.c                    | 2 --
 testcases/kernel/syscalls/cma/process_vm_readv02.c              | 2 --
 testcases/kernel/syscalls/cma/process_vm_readv03.c              | 2 --
 testcases/kernel/syscalls/cma/process_vm_writev02.c             | 2 --
 testcases/kernel/syscalls/confstr/confstr01.c                   | 2 --
 testcases/kernel/syscalls/creat/creat08.c                       | 2 --
 testcases/kernel/syscalls/creat/creat09.c                       | 2 --
 testcases/kernel/syscalls/delete_module/delete_module01.c       | 2 --
 testcases/kernel/syscalls/dup/dup01.c                           | 2 --
 testcases/kernel/syscalls/dup/dup02.c                           | 2 --
 testcases/kernel/syscalls/dup/dup03.c                           | 2 --
 testcases/kernel/syscalls/dup/dup04.c                           | 2 --
 testcases/kernel/syscalls/dup/dup05.c                           | 2 --
 testcases/kernel/syscalls/dup/dup06.c                           | 2 --
 testcases/kernel/syscalls/dup/dup07.c                           | 2 --
 testcases/kernel/syscalls/dup2/dup201.c                         | 2 --
 testcases/kernel/syscalls/dup2/dup202.c                         | 2 --
 testcases/kernel/syscalls/dup2/dup203.c                         | 2 --
 testcases/kernel/syscalls/dup2/dup204.c                         | 2 --
 testcases/kernel/syscalls/dup2/dup205.c                         | 2 --
 testcases/kernel/syscalls/dup2/dup206.c                         | 2 --
 testcases/kernel/syscalls/dup2/dup207.c                         | 2 --
 testcases/kernel/syscalls/dup3/dup3_01.c                        | 2 --
 testcases/kernel/syscalls/dup3/dup3_02.c                        | 2 --
 testcases/kernel/syscalls/epoll_create/epoll_create01.c         | 2 --
 testcases/kernel/syscalls/epoll_create/epoll_create02.c         | 2 --
 testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c      | 2 --
 testcases/kernel/syscalls/epoll_create1/epoll_create1_02.c      | 2 --
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c               | 2 --
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c               | 2 --
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c               | 2 --
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c               | 2 --
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl05.c               | 2 --
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c           | 2 --
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c           | 2 --
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c           | 2 --
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c           | 2 --
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c           | 2 --
 testcases/kernel/syscalls/epoll_wait/epoll_wait01.c             | 2 --
 testcases/kernel/syscalls/epoll_wait/epoll_wait02.c             | 2 --
 testcases/kernel/syscalls/epoll_wait/epoll_wait03.c             | 2 --
 testcases/kernel/syscalls/epoll_wait/epoll_wait04.c             | 2 --
 testcases/kernel/syscalls/epoll_wait/epoll_wait05.c             | 2 --
 testcases/kernel/syscalls/epoll_wait/epoll_wait06.c             | 2 --
 testcases/kernel/syscalls/epoll_wait/epoll_wait07.c             | 2 --
 testcases/kernel/syscalls/eventfd/eventfd01.c                   | 2 --
 testcases/kernel/syscalls/eventfd/eventfd02.c                   | 2 --
 testcases/kernel/syscalls/eventfd/eventfd03.c                   | 2 --
 testcases/kernel/syscalls/eventfd/eventfd04.c                   | 2 --
 testcases/kernel/syscalls/eventfd/eventfd05.c                   | 2 --
 testcases/kernel/syscalls/eventfd/eventfd06.c                   | 2 --
 testcases/kernel/syscalls/eventfd2/eventfd2_01.c                | 2 --
 testcases/kernel/syscalls/eventfd2/eventfd2_02.c                | 2 --
 testcases/kernel/syscalls/eventfd2/eventfd2_03.c                | 2 --
 testcases/kernel/syscalls/execve/execve04.c                     | 2 --
 testcases/kernel/syscalls/execve/execve05.c                     | 2 --
 testcases/kernel/syscalls/execve/execve06.c                     | 2 --
 testcases/kernel/syscalls/exit_group/exit_group01.c             | 2 --
 testcases/kernel/syscalls/faccessat/faccessat01.c               | 2 --
 testcases/kernel/syscalls/faccessat/faccessat02.c               | 2 --
 testcases/kernel/syscalls/faccessat2/faccessat201.c             | 2 --
 testcases/kernel/syscalls/faccessat2/faccessat202.c             | 2 --
 testcases/kernel/syscalls/fallocate/fallocate03.c               | 1 -
 testcases/kernel/syscalls/fallocate/fallocate06.c               | 2 --
 testcases/kernel/syscalls/fanotify/fanotify01.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify02.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify03.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify04.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify05.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify06.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify07.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify08.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify09.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify10.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify11.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify12.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify13.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify14.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify15.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify16.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify17.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify18.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify19.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify20.c                 | 2 --
 testcases/kernel/syscalls/fanotify/fanotify21.c                 | 2 --
 testcases/kernel/syscalls/fanotify/fanotify22.c                 | 1 -
 testcases/kernel/syscalls/fanotify/fanotify23.c                 | 1 -
 testcases/kernel/syscalls/fchmod/fchmod01.c                     | 2 --
 testcases/kernel/syscalls/fchmod/fchmod02.c                     | 2 --
 testcases/kernel/syscalls/fchmod/fchmod03.c                     | 2 --
 testcases/kernel/syscalls/fchmod/fchmod04.c                     | 2 --
 testcases/kernel/syscalls/fchmod/fchmod05.c                     | 2 --
 testcases/kernel/syscalls/fchmodat/fchmodat01.c                 | 2 --
 testcases/kernel/syscalls/fchmodat/fchmodat02.c                 | 2 --
 testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c              | 2 --
 testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c              | 2 --
 testcases/kernel/syscalls/fchown/fchown01.c                     | 2 --
 testcases/kernel/syscalls/fchown/fchown02.c                     | 2 --
 testcases/kernel/syscalls/fchown/fchown03.c                     | 2 --
 testcases/kernel/syscalls/fchown/fchown04.c                     | 2 --
 testcases/kernel/syscalls/fchown/fchown05.c                     | 2 --
 testcases/kernel/syscalls/fchownat/fchownat01.c                 | 2 --
 testcases/kernel/syscalls/fchownat/fchownat02.c                 | 2 --
 testcases/kernel/syscalls/fchownat/fchownat03.c                 | 2 --
 testcases/kernel/syscalls/fcntl/fcntl05.c                       | 2 --
 testcases/kernel/syscalls/fcntl/fcntl08.c                       | 2 --
 testcases/kernel/syscalls/fcntl/fcntl12.c                       | 2 --
 testcases/kernel/syscalls/fcntl/fcntl13.c                       | 2 --
 testcases/kernel/syscalls/fcntl/fcntl14.c                       | 2 --
 testcases/kernel/syscalls/fcntl/fcntl15.c                       | 2 --
 testcases/kernel/syscalls/fcntl/fcntl27.c                       | 2 --
 testcases/kernel/syscalls/fcntl/fcntl29.c                       | 2 --
 testcases/kernel/syscalls/fcntl/fcntl30.c                       | 2 --
 testcases/kernel/syscalls/fcntl/fcntl39.c                       | 2 --
 testcases/kernel/syscalls/finit_module/finit_module01.c         | 2 --
 testcases/kernel/syscalls/finit_module/finit_module02.c         | 2 --
 testcases/kernel/syscalls/flock/flock01.c                       | 2 --
 testcases/kernel/syscalls/flock/flock02.c                       | 2 --
 testcases/kernel/syscalls/flock/flock03.c                       | 2 --
 testcases/kernel/syscalls/flock/flock04.c                       | 2 --
 testcases/kernel/syscalls/flock/flock06.c                       | 2 --
 testcases/kernel/syscalls/flock/flock07.c                       | 2 --
 testcases/kernel/syscalls/fork/fork05.c                         | 2 --
 testcases/kernel/syscalls/fork/fork07.c                         | 2 --
 testcases/kernel/syscalls/fork/fork08.c                         | 2 --
 testcases/kernel/syscalls/fork/fork10.c                         | 2 --
 testcases/kernel/syscalls/fork/fork13.c                         | 2 --
 testcases/kernel/syscalls/fork/fork14.c                         | 2 --
 testcases/kernel/syscalls/fpathconf/fpathconf01.c               | 2 --
 testcases/kernel/syscalls/fsconfig/fsconfig03.c                 | 2 --
 testcases/kernel/syscalls/fsetxattr/fsetxattr02.c               | 2 --
 testcases/kernel/syscalls/fstat/fstat02.c                       | 2 --
 testcases/kernel/syscalls/fstatfs/fstatfs01.c                   | 2 --
 testcases/kernel/syscalls/fstatfs/fstatfs02.c                   | 2 --
 testcases/kernel/syscalls/ftruncate/ftruncate01.c               | 2 --
 testcases/kernel/syscalls/ftruncate/ftruncate03.c               | 2 --
 testcases/kernel/syscalls/futex/futex_cmp_requeue01.c           | 2 --
 testcases/kernel/syscalls/futex/futex_waitv01.c                 | 2 --
 testcases/kernel/syscalls/futex/futex_waitv02.c                 | 2 --
 testcases/kernel/syscalls/futex/futex_waitv03.c                 | 2 --
 testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c       | 2 --
 testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c       | 2 --
 testcases/kernel/syscalls/getcontext/getcontext01.c             | 2 --
 testcases/kernel/syscalls/getcpu/getcpu01.c                     | 2 --
 testcases/kernel/syscalls/getcpu/getcpu02.c                     | 2 --
 testcases/kernel/syscalls/getcwd/getcwd02.c                     | 2 --
 testcases/kernel/syscalls/getcwd/getcwd03.c                     | 2 --
 testcases/kernel/syscalls/getdents/getdents01.c                 | 2 --
 testcases/kernel/syscalls/getdents/getdents02.c                 | 2 --
 testcases/kernel/syscalls/getdomainname/getdomainname01.c       | 2 --
 testcases/kernel/syscalls/getegid/getegid01.c                   | 2 --
 testcases/kernel/syscalls/getegid/getegid02.c                   | 2 --
 testcases/kernel/syscalls/getgid/getgid01.c                     | 2 --
 testcases/kernel/syscalls/getgid/getgid03.c                     | 1 -
 testcases/kernel/syscalls/gethostbyname_r/gethostbyname_r01.c   | 2 --
 testcases/kernel/syscalls/gethostid/gethostid01.c               | 2 --
 testcases/kernel/syscalls/gethostname/gethostname01.c           | 2 --
 testcases/kernel/syscalls/gethostname/gethostname02.c           | 2 --
 testcases/kernel/syscalls/getitimer/getitimer01.c               | 2 --
 testcases/kernel/syscalls/getitimer/getitimer02.c               | 2 --
 testcases/kernel/syscalls/getpagesize/getpagesize01.c           | 2 --
 testcases/kernel/syscalls/getpeername/getpeername01.c           | 2 --
 testcases/kernel/syscalls/getpgid/getpgid01.c                   | 2 --
 testcases/kernel/syscalls/getpgid/getpgid02.c                   | 2 --
 testcases/kernel/syscalls/getpgrp/getpgrp01.c                   | 2 --
 testcases/kernel/syscalls/getpid/getpid01.c                     | 2 --
 testcases/kernel/syscalls/getpid/getpid02.c                     | 2 --
 testcases/kernel/syscalls/getppid/getppid01.c                   | 2 --
 testcases/kernel/syscalls/getppid/getppid02.c                   | 2 --
 testcases/kernel/syscalls/getrandom/getrandom05.c               | 2 --
 testcases/kernel/syscalls/getrlimit/getrlimit01.c               | 2 --
 testcases/kernel/syscalls/getrlimit/getrlimit02.c               | 2 --
 testcases/kernel/syscalls/getrusage/getrusage01.c               | 2 --
 testcases/kernel/syscalls/getrusage/getrusage02.c               | 2 --
 testcases/kernel/syscalls/getrusage/getrusage03.c               | 2 --
 testcases/kernel/syscalls/getrusage/getrusage03_child.c         | 2 --
 testcases/kernel/syscalls/getsid/getsid01.c                     | 2 --
 testcases/kernel/syscalls/getsid/getsid02.c                     | 2 --
 testcases/kernel/syscalls/getsockname/getsockname01.c           | 1 -
 testcases/kernel/syscalls/getsockopt/getsockopt01.c             | 1 -
 testcases/kernel/syscalls/getsockopt/getsockopt02.c             | 2 --
 testcases/kernel/syscalls/gettid/gettid01.c                     | 2 --
 testcases/kernel/syscalls/gettid/gettid02.c                     | 2 --
 testcases/kernel/syscalls/gettimeofday/gettimeofday01.c         | 2 --
 testcases/kernel/syscalls/gettimeofday/gettimeofday02.c         | 2 --
 testcases/kernel/syscalls/getuid/getuid01.c                     | 2 --
 testcases/kernel/syscalls/getuid/getuid03.c                     | 2 --
 testcases/kernel/syscalls/getxattr/getxattr01.c                 | 2 --
 testcases/kernel/syscalls/getxattr/getxattr02.c                 | 2 --
 testcases/kernel/syscalls/getxattr/getxattr03.c                 | 2 --
 testcases/kernel/syscalls/getxattr/getxattr04.c                 | 2 --
 testcases/kernel/syscalls/getxattr/getxattr05.c                 | 2 --
 testcases/kernel/syscalls/init_module/init_module01.c           | 2 --
 testcases/kernel/syscalls/init_module/init_module02.c           | 2 --
 testcases/kernel/syscalls/inotify/inotify01.c                   | 2 --
 testcases/kernel/syscalls/inotify/inotify02.c                   | 2 --
 testcases/kernel/syscalls/inotify/inotify03.c                   | 2 --
 testcases/kernel/syscalls/inotify/inotify04.c                   | 2 --
 testcases/kernel/syscalls/inotify/inotify05.c                   | 2 --
 testcases/kernel/syscalls/inotify/inotify06.c                   | 2 --
 testcases/kernel/syscalls/inotify/inotify07.c                   | 2 --
 testcases/kernel/syscalls/inotify/inotify08.c                   | 2 --
 testcases/kernel/syscalls/inotify/inotify09.c                   | 2 --
 testcases/kernel/syscalls/inotify/inotify10.c                   | 2 --
 testcases/kernel/syscalls/inotify/inotify11.c                   | 2 --
 testcases/kernel/syscalls/inotify/inotify12.c                   | 2 --
 testcases/kernel/syscalls/inotify_init/inotify_init1_01.c       | 2 --
 testcases/kernel/syscalls/inotify_init/inotify_init1_02.c       | 2 --
 testcases/kernel/syscalls/io_cancel/io_cancel01.c               | 2 --
 testcases/kernel/syscalls/io_cancel/io_cancel02.c               | 2 --
 testcases/kernel/syscalls/io_destroy/io_destroy01.c             | 2 --
 testcases/kernel/syscalls/io_destroy/io_destroy02.c             | 2 --
 testcases/kernel/syscalls/io_getevents/io_getevents01.c         | 2 --
 testcases/kernel/syscalls/io_getevents/io_getevents02.c         | 2 --
 testcases/kernel/syscalls/io_setup/io_setup01.c                 | 2 --
 testcases/kernel/syscalls/io_setup/io_setup02.c                 | 2 --
 testcases/kernel/syscalls/io_submit/io_submit01.c               | 2 --
 testcases/kernel/syscalls/io_submit/io_submit02.c               | 2 --
 testcases/kernel/syscalls/io_submit/io_submit03.c               | 2 --
 testcases/kernel/syscalls/ioctl/ioctl01.c                       | 2 --
 testcases/kernel/syscalls/ioctl/ioctl02.c                       | 2 --
 testcases/kernel/syscalls/ioctl/ioctl03.c                       | 2 --
 testcases/kernel/syscalls/ioctl/ioctl04.c                       | 2 --
 testcases/kernel/syscalls/ioctl/ioctl05.c                       | 2 --
 testcases/kernel/syscalls/ioctl/ioctl06.c                       | 2 --
 testcases/kernel/syscalls/ioctl/ioctl07.c                       | 2 --
 testcases/kernel/syscalls/ioctl/ioctl08.c                       | 2 --
 testcases/kernel/syscalls/ioctl/ioctl09.c                       | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c               | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c               | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c               | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c               | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c          | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c          | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_loop01.c                  | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_loop02.c                  | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_loop03.c                  | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_loop04.c                  | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_loop05.c                  | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_loop06.c                  | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_loop07.c                  | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_ns01.c                    | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_ns02.c                    | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_ns03.c                    | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_ns04.c                    | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_ns05.c                    | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_ns06.c                    | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_ns07.c                    | 2 --
 testcases/kernel/syscalls/ioctl/ioctl_sg01.c                    | 2 --
 testcases/kernel/syscalls/iopl/iopl01.c                         | 2 --
 testcases/kernel/syscalls/iopl/iopl02.c                         | 2 --
 testcases/kernel/syscalls/ioprio/ioprio_get01.c                 | 2 --
 testcases/kernel/syscalls/ioprio/ioprio_set01.c                 | 2 --
 testcases/kernel/syscalls/ioprio/ioprio_set02.c                 | 2 --
 testcases/kernel/syscalls/ioprio/ioprio_set03.c                 | 2 --
 testcases/kernel/syscalls/ipc/msgctl/msgctl05.c                 | 2 --
 testcases/kernel/syscalls/ipc/msgctl/msgctl06.c                 | 2 --
 testcases/kernel/syscalls/ipc/msgget/msgget01.c                 | 2 --
 testcases/kernel/syscalls/ipc/msgget/msgget02.c                 | 2 --
 testcases/kernel/syscalls/ipc/msgget/msgget03.c                 | 2 --
 testcases/kernel/syscalls/ipc/msgget/msgget04.c                 | 2 --
 testcases/kernel/syscalls/ipc/msgget/msgget05.c                 | 2 --
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c                 | 2 --
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c                 | 2 --
 testcases/kernel/syscalls/ipc/msgstress/msgstress01.c           | 2 --
 testcases/kernel/syscalls/ipc/semctl/semctl01.c                 | 2 --
 testcases/kernel/syscalls/ipc/semctl/semctl02.c                 | 2 --
 testcases/kernel/syscalls/ipc/semctl/semctl03.c                 | 2 --
 testcases/kernel/syscalls/ipc/semctl/semctl04.c                 | 2 --
 testcases/kernel/syscalls/ipc/semctl/semctl05.c                 | 2 --
 testcases/kernel/syscalls/ipc/semctl/semctl07.c                 | 2 --
 testcases/kernel/syscalls/ipc/semctl/semctl08.c                 | 2 --
 testcases/kernel/syscalls/ipc/semctl/semctl09.c                 | 2 --
 testcases/kernel/syscalls/ipc/semget/semget01.c                 | 2 --
 testcases/kernel/syscalls/ipc/semget/semget02.c                 | 2 --
 testcases/kernel/syscalls/ipc/semget/semget05.c                 | 2 --
 testcases/kernel/syscalls/ipc/semop/semop04.c                   | 2 --
 testcases/kernel/syscalls/ipc/shmat/shmat04.c                   | 2 --
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c                 | 2 --
 testcases/kernel/syscalls/ipc/shmctl/shmctl02.c                 | 2 --
 testcases/kernel/syscalls/ipc/shmctl/shmctl03.c                 | 2 --
 testcases/kernel/syscalls/ipc/shmctl/shmctl04.c                 | 2 --
 testcases/kernel/syscalls/ipc/shmctl/shmctl05.c                 | 2 --
 testcases/kernel/syscalls/ipc/shmctl/shmctl06.c                 | 2 --
 testcases/kernel/syscalls/ipc/shmctl/shmctl07.c                 | 2 --
 testcases/kernel/syscalls/ipc/shmctl/shmctl08.c                 | 2 --
 testcases/kernel/syscalls/ipc/shmdt/shmdt01.c                   | 2 --
 testcases/kernel/syscalls/ipc/shmdt/shmdt02.c                   | 2 --
 testcases/kernel/syscalls/ipc/shmget/shmget02.c                 | 2 --
 testcases/kernel/syscalls/ipc/shmget/shmget03.c                 | 2 --
 testcases/kernel/syscalls/ipc/shmget/shmget04.c                 | 2 --
 testcases/kernel/syscalls/ipc/shmget/shmget05.c                 | 2 --
 testcases/kernel/syscalls/ipc/shmget/shmget06.c                 | 2 --
 testcases/kernel/syscalls/kcmp/kcmp01.c                         | 2 --
 testcases/kernel/syscalls/kcmp/kcmp02.c                         | 2 --
 testcases/kernel/syscalls/kcmp/kcmp03.c                         | 2 --
 testcases/kernel/syscalls/keyctl/keyctl01.c                     | 2 --
 testcases/kernel/syscalls/keyctl/keyctl02.c                     | 2 --
 testcases/kernel/syscalls/keyctl/keyctl03.c                     | 2 --
 testcases/kernel/syscalls/keyctl/keyctl04.c                     | 2 --
 testcases/kernel/syscalls/keyctl/keyctl05.c                     | 2 --
 testcases/kernel/syscalls/keyctl/keyctl06.c                     | 2 --
 testcases/kernel/syscalls/keyctl/keyctl07.c                     | 2 --
 testcases/kernel/syscalls/keyctl/keyctl08.c                     | 2 --
 testcases/kernel/syscalls/keyctl/keyctl09.c                     | 2 --
 testcases/kernel/syscalls/kill/kill13.c                         | 2 --
 testcases/kernel/syscalls/landlock/landlock01.c                 | 2 --
 testcases/kernel/syscalls/landlock/landlock02.c                 | 2 --
 testcases/kernel/syscalls/landlock/landlock03.c                 | 2 --
 testcases/kernel/syscalls/landlock/landlock04.c                 | 2 --
 testcases/kernel/syscalls/landlock/landlock05.c                 | 2 --
 testcases/kernel/syscalls/landlock/landlock06.c                 | 2 --
 testcases/kernel/syscalls/landlock/landlock07.c                 | 2 --
 testcases/kernel/syscalls/landlock/landlock08.c                 | 2 --
 testcases/kernel/syscalls/lgetxattr/lgetxattr01.c               | 2 --
 testcases/kernel/syscalls/lgetxattr/lgetxattr02.c               | 2 --
 testcases/kernel/syscalls/link/link02.c                         | 2 --
 testcases/kernel/syscalls/link/link04.c                         | 2 --
 testcases/kernel/syscalls/link/link05.c                         | 2 --
 testcases/kernel/syscalls/link/link08.c                         | 2 --
 testcases/kernel/syscalls/listmount/listmount01.c               | 2 --
 testcases/kernel/syscalls/listmount/listmount02.c               | 2 --
 testcases/kernel/syscalls/listmount/listmount03.c               | 2 --
 testcases/kernel/syscalls/listmount/listmount04.c               | 2 --
 testcases/kernel/syscalls/listxattr/listxattr01.c               | 2 --
 testcases/kernel/syscalls/listxattr/listxattr02.c               | 2 --
 testcases/kernel/syscalls/listxattr/listxattr03.c               | 2 --
 testcases/kernel/syscalls/llistxattr/llistxattr01.c             | 2 --
 testcases/kernel/syscalls/llistxattr/llistxattr02.c             | 2 --
 testcases/kernel/syscalls/llistxattr/llistxattr03.c             | 2 --
 testcases/kernel/syscalls/lremovexattr/lremovexattr01.c         | 2 --
 testcases/kernel/syscalls/lstat/lstat03.c                       | 2 --
 testcases/kernel/syscalls/madvise/madvise03.c                   | 2 --
 testcases/kernel/syscalls/madvise/madvise06.c                   | 2 --
 testcases/kernel/syscalls/madvise/madvise11.c                   | 2 --
 testcases/kernel/syscalls/madvise/madvise12.c                   | 2 --
 testcases/kernel/syscalls/mallinfo/mallinfo01.c                 | 2 --
 testcases/kernel/syscalls/mallinfo/mallinfo02.c                 | 2 --
 testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c              | 2 --
 testcases/kernel/syscalls/mallopt/mallopt01.c                   | 2 --
 testcases/kernel/syscalls/memcmp/memcmp01.c                     | 2 --
 testcases/kernel/syscalls/memcpy/memcpy01.c                     | 2 --
 testcases/kernel/syscalls/memfd_create/memfd_create04.c         | 2 --
 testcases/kernel/syscalls/memset/memset01.c                     | 2 --
 testcases/kernel/syscalls/mincore/mincore02.c                   | 2 --
 testcases/kernel/syscalls/mkdir/mkdir02.c                       | 2 --
 testcases/kernel/syscalls/mkdir/mkdir03.c                       | 2 --
 testcases/kernel/syscalls/mkdir/mkdir09.c                       | 2 --
 testcases/kernel/syscalls/mknod/mknod01.c                       | 2 --
 testcases/kernel/syscalls/mknod/mknod02.c                       | 2 --
 testcases/kernel/syscalls/mknod/mknod09.c                       | 2 --
 testcases/kernel/syscalls/mlock/mlock01.c                       | 2 --
 testcases/kernel/syscalls/mlock/mlock02.c                       | 2 --
 testcases/kernel/syscalls/mlock/mlock03.c                       | 2 --
 testcases/kernel/syscalls/mlock/mlock04.c                       | 2 --
 testcases/kernel/syscalls/mlock/mlock05.c                       | 2 --
 testcases/kernel/syscalls/mmap/mmap01.c                         | 2 --
 testcases/kernel/syscalls/mmap/mmap02.c                         | 2 --
 testcases/kernel/syscalls/mmap/mmap04.c                         | 2 --
 testcases/kernel/syscalls/mmap/mmap05.c                         | 2 --
 testcases/kernel/syscalls/mmap/mmap06.c                         | 2 --
 testcases/kernel/syscalls/mmap/mmap08.c                         | 2 --
 testcases/kernel/syscalls/mmap/mmap09.c                         | 2 --
 testcases/kernel/syscalls/mmap/mmap13.c                         | 2 --
 testcases/kernel/syscalls/mmap/mmap14.c                         | 2 --
 testcases/kernel/syscalls/mmap/mmap15.c                         | 2 --
 testcases/kernel/syscalls/mmap/mmap16.c                         | 2 --
 testcases/kernel/syscalls/mmap/mmap19.c                         | 2 --
 testcases/kernel/syscalls/mmap/mmap20.c                         | 2 --
 testcases/kernel/syscalls/mount/mount01.c                       | 2 --
 testcases/kernel/syscalls/mount/mount02.c                       | 2 --
 testcases/kernel/syscalls/mount/mount03.c                       | 2 --
 testcases/kernel/syscalls/mount/mount04.c                       | 2 --
 testcases/kernel/syscalls/mount/mount05.c                       | 2 --
 testcases/kernel/syscalls/mount/mount06.c                       | 2 --
 testcases/kernel/syscalls/mount/mount07.c                       | 2 --
 testcases/kernel/syscalls/mount_setattr/mount_setattr01.c       | 2 --
 testcases/kernel/syscalls/move_pages/move_pages04.c             | 2 --
 testcases/kernel/syscalls/move_pages/move_pages12.c             | 2 --
 testcases/kernel/syscalls/mprotect/mprotect05.c                 | 2 --
 testcases/kernel/syscalls/mq_notify/mq_notify02.c               | 2 --
 testcases/kernel/syscalls/mq_notify/mq_notify03.c               | 2 --
 testcases/kernel/syscalls/mremap/mremap06.c                     | 2 --
 testcases/kernel/syscalls/mseal/mseal01.c                       | 2 --
 testcases/kernel/syscalls/mseal/mseal02.c                       | 2 --
 testcases/kernel/syscalls/msync/msync04.c                       | 2 --
 testcases/kernel/syscalls/munlock/munlock01.c                   | 2 --
 testcases/kernel/syscalls/munlock/munlock02.c                   | 2 --
 testcases/kernel/syscalls/munlockall/munlockall01.c             | 2 --
 .../kernel/syscalls/name_to_handle_at/name_to_handle_at01.c     | 2 --
 .../kernel/syscalls/name_to_handle_at/name_to_handle_at02.c     | 2 --
 testcases/kernel/syscalls/nanosleep/nanosleep01.c               | 2 --
 testcases/kernel/syscalls/nanosleep/nanosleep04.c               | 2 --
 testcases/kernel/syscalls/nice/nice01.c                         | 2 --
 testcases/kernel/syscalls/nice/nice02.c                         | 2 --
 testcases/kernel/syscalls/nice/nice03.c                         | 2 --
 testcases/kernel/syscalls/nice/nice04.c                         | 2 --
 testcases/kernel/syscalls/nice/nice05.c                         | 2 --
 testcases/kernel/syscalls/open/open02.c                         | 2 --
 testcases/kernel/syscalls/open/open03.c                         | 2 --
 testcases/kernel/syscalls/open/open04.c                         | 2 --
 testcases/kernel/syscalls/open/open06.c                         | 2 --
 testcases/kernel/syscalls/open/open07.c                         | 2 --
 testcases/kernel/syscalls/open/open08.c                         | 2 --
 testcases/kernel/syscalls/open/open09.c                         | 2 --
 testcases/kernel/syscalls/open/open10.c                         | 2 --
 testcases/kernel/syscalls/open/open11.c                         | 2 --
 testcases/kernel/syscalls/open/open15.c                         | 2 --
 .../kernel/syscalls/open_by_handle_at/open_by_handle_at01.c     | 2 --
 .../kernel/syscalls/open_by_handle_at/open_by_handle_at02.c     | 2 --
 testcases/kernel/syscalls/openat/openat01.c                     | 2 --
 testcases/kernel/syscalls/openat/openat04.c                     | 2 --
 testcases/kernel/syscalls/pathconf/pathconf01.c                 | 2 --
 testcases/kernel/syscalls/pathconf/pathconf02.c                 | 2 --
 testcases/kernel/syscalls/personality/personality01.c           | 2 --
 testcases/kernel/syscalls/personality/personality02.c           | 2 --
 testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c           | 2 --
 testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c           | 2 --
 testcases/kernel/syscalls/pidfd_open/pidfd_open01.c             | 2 --
 testcases/kernel/syscalls/pidfd_open/pidfd_open02.c             | 2 --
 testcases/kernel/syscalls/pidfd_open/pidfd_open03.c             | 2 --
 testcases/kernel/syscalls/pidfd_open/pidfd_open04.c             | 2 --
 .../kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c     | 2 --
 .../kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c     | 2 --
 .../kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c     | 2 --
 testcases/kernel/syscalls/pipe/pipe03.c                         | 2 --
 testcases/kernel/syscalls/pipe/pipe06.c                         | 2 --
 testcases/kernel/syscalls/pipe/pipe07.c                         | 2 --
 testcases/kernel/syscalls/pipe/pipe08.c                         | 2 --
 testcases/kernel/syscalls/pipe/pipe10.c                         | 2 --
 testcases/kernel/syscalls/pipe/pipe14.c                         | 2 --
 testcases/kernel/syscalls/pipe/pipe15.c                         | 2 --
 testcases/kernel/syscalls/pkeys/pkey01.c                        | 2 --
 testcases/kernel/syscalls/prctl/prctl01.c                       | 2 --
 testcases/kernel/syscalls/prctl/prctl02.c                       | 2 --
 testcases/kernel/syscalls/prctl/prctl03.c                       | 2 --
 testcases/kernel/syscalls/prctl/prctl05.c                       | 2 --
 testcases/kernel/syscalls/prctl/prctl06.c                       | 2 --
 testcases/kernel/syscalls/prctl/prctl07.c                       | 2 --
 testcases/kernel/syscalls/prctl/prctl08.c                       | 2 --
 testcases/kernel/syscalls/prctl/prctl09.c                       | 2 --
 testcases/kernel/syscalls/prctl/prctl10.c                       | 2 --
 testcases/kernel/syscalls/pread/pread01.c                       | 2 --
 testcases/kernel/syscalls/pread/pread02.c                       | 2 --
 testcases/kernel/syscalls/preadv/preadv01.c                     | 2 --
 testcases/kernel/syscalls/preadv/preadv02.c                     | 2 --
 testcases/kernel/syscalls/preadv/preadv03.c                     | 2 --
 testcases/kernel/syscalls/preadv2/preadv201.c                   | 2 --
 testcases/kernel/syscalls/preadv2/preadv202.c                   | 2 --
 testcases/kernel/syscalls/process_madvise/process_madvise01.c   | 2 --
 testcases/kernel/syscalls/pselect/pselect02.c                   | 2 --
 testcases/kernel/syscalls/ptrace/ptrace05.c                     | 2 --
 testcases/kernel/syscalls/ptrace/ptrace06.c                     | 2 --
 testcases/kernel/syscalls/ptrace/ptrace11.c                     | 2 --
 testcases/kernel/syscalls/pwrite/pwrite01.c                     | 2 --
 testcases/kernel/syscalls/pwrite/pwrite02.c                     | 2 --
 testcases/kernel/syscalls/pwrite/pwrite03.c                     | 2 --
 testcases/kernel/syscalls/pwrite/pwrite04.c                     | 2 --
 testcases/kernel/syscalls/pwritev/pwritev01.c                   | 2 --
 testcases/kernel/syscalls/pwritev/pwritev02.c                   | 2 --
 testcases/kernel/syscalls/pwritev/pwritev03.c                   | 2 --
 testcases/kernel/syscalls/pwritev2/pwritev201.c                 | 2 --
 testcases/kernel/syscalls/pwritev2/pwritev202.c                 | 2 --
 testcases/kernel/syscalls/quotactl/quotactl01.c                 | 1 -
 testcases/kernel/syscalls/quotactl/quotactl02.c                 | 2 --
 testcases/kernel/syscalls/quotactl/quotactl03.c                 | 2 --
 testcases/kernel/syscalls/quotactl/quotactl04.c                 | 2 --
 testcases/kernel/syscalls/quotactl/quotactl05.c                 | 2 --
 testcases/kernel/syscalls/quotactl/quotactl06.c                 | 2 --
 testcases/kernel/syscalls/quotactl/quotactl07.c                 | 2 --
 testcases/kernel/syscalls/quotactl/quotactl08.c                 | 1 -
 testcases/kernel/syscalls/quotactl/quotactl09.c                 | 2 --
 testcases/kernel/syscalls/read/read03.c                         | 2 --
 testcases/kernel/syscalls/read/read04.c                         | 2 --
 testcases/kernel/syscalls/readahead/readahead01.c               | 2 --
 testcases/kernel/syscalls/readdir/readdir01.c                   | 2 --
 testcases/kernel/syscalls/readdir/readdir21.c                   | 2 --
 testcases/kernel/syscalls/readlink/readlink01.c                 | 2 --
 testcases/kernel/syscalls/readlink/readlink03.c                 | 2 --
 testcases/kernel/syscalls/readlinkat/readlinkat01.c             | 2 --
 testcases/kernel/syscalls/readlinkat/readlinkat02.c             | 2 --
 testcases/kernel/syscalls/readv/readv02.c                       | 2 --
 testcases/kernel/syscalls/realpath/realpath01.c                 | 2 --
 testcases/kernel/syscalls/reboot/reboot01.c                     | 2 --
 testcases/kernel/syscalls/reboot/reboot02.c                     | 1 -
 testcases/kernel/syscalls/recvmsg/recvmsg01.c                   | 2 --
 testcases/kernel/syscalls/rename/rename01.c                     | 2 --
 testcases/kernel/syscalls/rename/rename03.c                     | 2 --
 testcases/kernel/syscalls/rename/rename04.c                     | 2 --
 testcases/kernel/syscalls/rename/rename05.c                     | 2 --
 testcases/kernel/syscalls/rename/rename06.c                     | 2 --
 testcases/kernel/syscalls/rename/rename07.c                     | 2 --
 testcases/kernel/syscalls/rename/rename08.c                     | 2 --
 testcases/kernel/syscalls/rename/rename09.c                     | 2 --
 testcases/kernel/syscalls/rename/rename10.c                     | 2 --
 testcases/kernel/syscalls/rename/rename12.c                     | 2 --
 testcases/kernel/syscalls/rename/rename13.c                     | 2 --
 testcases/kernel/syscalls/rename/rename15.c                     | 2 --
 testcases/kernel/syscalls/request_key/request_key01.c           | 2 --
 testcases/kernel/syscalls/request_key/request_key02.c           | 2 --
 testcases/kernel/syscalls/request_key/request_key03.c           | 2 --
 testcases/kernel/syscalls/request_key/request_key04.c           | 2 --
 testcases/kernel/syscalls/request_key/request_key05.c           | 2 --
 testcases/kernel/syscalls/request_key/request_key06.c           | 2 --
 testcases/kernel/syscalls/rmdir/rmdir02.c                       | 2 --
 testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo02.c   | 2 --
 testcases/kernel/syscalls/sbrk/sbrk01.c                         | 2 --
 testcases/kernel/syscalls/sbrk/sbrk02.c                         | 2 --
 testcases/kernel/syscalls/sbrk/sbrk03.c                         | 2 --
 .../syscalls/sched_get_priority_max/sched_get_priority_max01.c  | 2 --
 .../syscalls/sched_get_priority_max/sched_get_priority_max02.c  | 2 --
 .../syscalls/sched_get_priority_min/sched_get_priority_min01.c  | 2 --
 .../syscalls/sched_get_priority_min/sched_get_priority_min02.c  | 2 --
 testcases/kernel/syscalls/sched_getattr/sched_getattr02.c       | 2 --
 testcases/kernel/syscalls/sched_getparam/sched_getparam01.c     | 2 --
 testcases/kernel/syscalls/sched_getparam/sched_getparam03.c     | 2 --
 .../kernel/syscalls/sched_getscheduler/sched_getscheduler01.c   | 2 --
 .../kernel/syscalls/sched_getscheduler/sched_getscheduler02.c   | 2 --
 .../syscalls/sched_rr_get_interval/sched_rr_get_interval01.c    | 2 --
 .../syscalls/sched_rr_get_interval/sched_rr_get_interval02.c    | 2 --
 .../syscalls/sched_rr_get_interval/sched_rr_get_interval03.c    | 2 --
 .../kernel/syscalls/sched_setaffinity/sched_setaffinity01.c     | 2 --
 testcases/kernel/syscalls/sched_setparam/sched_setparam01.c     | 2 --
 testcases/kernel/syscalls/sched_setparam/sched_setparam02.c     | 2 --
 testcases/kernel/syscalls/sched_setparam/sched_setparam03.c     | 2 --
 testcases/kernel/syscalls/sched_setparam/sched_setparam04.c     | 2 --
 testcases/kernel/syscalls/sched_setparam/sched_setparam05.c     | 2 --
 .../kernel/syscalls/sched_setscheduler/sched_setscheduler01.c   | 2 --
 .../kernel/syscalls/sched_setscheduler/sched_setscheduler02.c   | 2 --
 .../kernel/syscalls/sched_setscheduler/sched_setscheduler04.c   | 2 --
 testcases/kernel/syscalls/seccomp/seccomp01.c                   | 2 --
 testcases/kernel/syscalls/select/select04.c                     | 2 --
 testcases/kernel/syscalls/send/send02.c                         | 2 --
 testcases/kernel/syscalls/sendfile/sendfile02.c                 | 2 --
 testcases/kernel/syscalls/sendfile/sendfile03.c                 | 2 --
 testcases/kernel/syscalls/sendfile/sendfile04.c                 | 2 --
 testcases/kernel/syscalls/sendfile/sendfile05.c                 | 2 --
 testcases/kernel/syscalls/sendfile/sendfile06.c                 | 2 --
 testcases/kernel/syscalls/sendfile/sendfile07.c                 | 2 --
 testcases/kernel/syscalls/sendfile/sendfile08.c                 | 2 --
 testcases/kernel/syscalls/sendfile/sendfile09.c                 | 2 --
 testcases/kernel/syscalls/sendmsg/sendmsg03.c                   | 2 --
 testcases/kernel/syscalls/sendto/sendto02.c                     | 2 --
 testcases/kernel/syscalls/sendto/sendto03.c                     | 2 --
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c       | 2 --
 testcases/kernel/syscalls/set_tid_address/set_tid_address01.c   | 2 --
 testcases/kernel/syscalls/setegid/setegid01.c                   | 2 --
 testcases/kernel/syscalls/setegid/setegid02.c                   | 2 --
 testcases/kernel/syscalls/setfsgid/setfsgid01.c                 | 2 --
 testcases/kernel/syscalls/setfsgid/setfsgid02.c                 | 2 --
 testcases/kernel/syscalls/setfsuid/setfsuid01.c                 | 2 --
 testcases/kernel/syscalls/setfsuid/setfsuid02.c                 | 2 --
 testcases/kernel/syscalls/setfsuid/setfsuid03.c                 | 2 --
 testcases/kernel/syscalls/setgid/setgid01.c                     | 2 --
 testcases/kernel/syscalls/setgid/setgid02.c                     | 2 --
 testcases/kernel/syscalls/setgroups/setgroups01.c               | 2 --
 testcases/kernel/syscalls/setgroups/setgroups02.c               | 2 --
 testcases/kernel/syscalls/setgroups/setgroups03.c               | 2 --
 testcases/kernel/syscalls/setitimer/setitimer01.c               | 2 --
 testcases/kernel/syscalls/setitimer/setitimer02.c               | 2 --
 testcases/kernel/syscalls/setpgid/setpgid01.c                   | 2 --
 testcases/kernel/syscalls/setpgid/setpgid02.c                   | 2 --
 testcases/kernel/syscalls/setpgid/setpgid03.c                   | 2 --
 testcases/kernel/syscalls/setpgrp/setpgrp02.c                   | 2 --
 testcases/kernel/syscalls/setregid/setregid01.c                 | 2 --
 testcases/kernel/syscalls/setresgid/setresgid01.c               | 2 --
 testcases/kernel/syscalls/setresgid/setresgid02.c               | 2 --
 testcases/kernel/syscalls/setresgid/setresgid03.c               | 2 --
 testcases/kernel/syscalls/setresgid/setresgid04.c               | 2 --
 testcases/kernel/syscalls/setresuid/setresuid01.c               | 2 --
 testcases/kernel/syscalls/setresuid/setresuid02.c               | 2 --
 testcases/kernel/syscalls/setresuid/setresuid03.c               | 2 --
 testcases/kernel/syscalls/setresuid/setresuid04.c               | 2 --
 testcases/kernel/syscalls/setresuid/setresuid05.c               | 2 --
 testcases/kernel/syscalls/setreuid/setreuid01.c                 | 2 --
 testcases/kernel/syscalls/setreuid/setreuid02.c                 | 2 --
 testcases/kernel/syscalls/setreuid/setreuid03.c                 | 2 --
 testcases/kernel/syscalls/setreuid/setreuid04.c                 | 2 --
 testcases/kernel/syscalls/setreuid/setreuid05.c                 | 2 --
 testcases/kernel/syscalls/setreuid/setreuid06.c                 | 2 --
 testcases/kernel/syscalls/setreuid/setreuid07.c                 | 2 --
 testcases/kernel/syscalls/setsockopt/setsockopt01.c             | 2 --
 testcases/kernel/syscalls/setsockopt/setsockopt02.c             | 2 --
 testcases/kernel/syscalls/setsockopt/setsockopt03.c             | 2 --
 testcases/kernel/syscalls/setsockopt/setsockopt04.c             | 2 --
 testcases/kernel/syscalls/setsockopt/setsockopt05.c             | 2 --
 testcases/kernel/syscalls/setsockopt/setsockopt06.c             | 2 --
 testcases/kernel/syscalls/setsockopt/setsockopt07.c             | 2 --
 testcases/kernel/syscalls/setsockopt/setsockopt08.c             | 2 --
 testcases/kernel/syscalls/setsockopt/setsockopt09.c             | 2 --
 testcases/kernel/syscalls/setsockopt/setsockopt10.c             | 2 --
 testcases/kernel/syscalls/settimeofday/settimeofday01.c         | 2 --
 testcases/kernel/syscalls/settimeofday/settimeofday02.c         | 2 --
 testcases/kernel/syscalls/setuid/setuid01.c                     | 2 --
 testcases/kernel/syscalls/setuid/setuid03.c                     | 2 --
 testcases/kernel/syscalls/setxattr/setxattr01.c                 | 2 --
 testcases/kernel/syscalls/setxattr/setxattr02.c                 | 2 --
 testcases/kernel/syscalls/setxattr/setxattr03.c                 | 2 --
 testcases/kernel/syscalls/shutdown/shutdown01.c                 | 2 --
 testcases/kernel/syscalls/shutdown/shutdown02.c                 | 2 --
 testcases/kernel/syscalls/sigaltstack/sigaltstack02.c           | 2 --
 testcases/kernel/syscalls/sighold/sighold02.c                   | 2 --
 testcases/kernel/syscalls/signal/signal01.c                     | 2 --
 testcases/kernel/syscalls/signal/signal02.c                     | 2 --
 testcases/kernel/syscalls/signal/signal03.c                     | 2 --
 testcases/kernel/syscalls/signal/signal04.c                     | 2 --
 testcases/kernel/syscalls/signal/signal05.c                     | 2 --
 testcases/kernel/syscalls/signalfd/signalfd01.c                 | 2 --
 testcases/kernel/syscalls/signalfd/signalfd02.c                 | 2 --
 testcases/kernel/syscalls/sigsuspend/sigsuspend01.c             | 2 --
 testcases/kernel/syscalls/sigsuspend/sigsuspend02.c             | 2 --
 testcases/kernel/syscalls/socket/socket01.c                     | 2 --
 testcases/kernel/syscalls/socket/socket02.c                     | 2 --
 testcases/kernel/syscalls/socketcall/socketcall01.c             | 2 --
 testcases/kernel/syscalls/socketpair/socketpair01.c             | 2 --
 testcases/kernel/syscalls/socketpair/socketpair02.c             | 2 --
 testcases/kernel/syscalls/splice/splice02.c                     | 1 -
 testcases/kernel/syscalls/splice/splice03.c                     | 2 --
 testcases/kernel/syscalls/splice/splice06.c                     | 2 --
 testcases/kernel/syscalls/splice/splice07.c                     | 2 --
 testcases/kernel/syscalls/splice/splice08.c                     | 2 --
 testcases/kernel/syscalls/splice/splice09.c                     | 2 --
 testcases/kernel/syscalls/stat/stat01.c                         | 2 --
 testcases/kernel/syscalls/stat/stat03.c                         | 2 --
 testcases/kernel/syscalls/stat/stat04.c                         | 2 --
 testcases/kernel/syscalls/statfs/statfs01.c                     | 2 --
 testcases/kernel/syscalls/statfs/statfs02.c                     | 2 --
 testcases/kernel/syscalls/statfs/statfs03.c                     | 2 --
 testcases/kernel/syscalls/statmount/statmount01.c               | 2 --
 testcases/kernel/syscalls/statmount/statmount02.c               | 2 --
 testcases/kernel/syscalls/statmount/statmount03.c               | 2 --
 testcases/kernel/syscalls/statmount/statmount04.c               | 2 --
 testcases/kernel/syscalls/statmount/statmount05.c               | 2 --
 testcases/kernel/syscalls/statmount/statmount06.c               | 2 --
 testcases/kernel/syscalls/statmount/statmount07.c               | 2 --
 testcases/kernel/syscalls/statmount/statmount08.c               | 2 --
 testcases/kernel/syscalls/statvfs/statvfs01.c                   | 2 --
 testcases/kernel/syscalls/statvfs/statvfs02.c                   | 2 --
 testcases/kernel/syscalls/statx/statx01.c                       | 2 --
 testcases/kernel/syscalls/statx/statx02.c                       | 2 --
 testcases/kernel/syscalls/statx/statx03.c                       | 2 --
 testcases/kernel/syscalls/statx/statx04.c                       | 2 --
 testcases/kernel/syscalls/statx/statx05.c                       | 2 --
 testcases/kernel/syscalls/statx/statx06.c                       | 2 --
 testcases/kernel/syscalls/statx/statx07.c                       | 2 --
 testcases/kernel/syscalls/statx/statx08.c                       | 2 --
 testcases/kernel/syscalls/statx/statx09.c                       | 2 --
 testcases/kernel/syscalls/statx/statx10.c                       | 2 --
 testcases/kernel/syscalls/statx/statx11.c                       | 2 --
 testcases/kernel/syscalls/statx/statx12.c                       | 2 --
 testcases/kernel/syscalls/swapoff/swapoff01.c                   | 2 --
 testcases/kernel/syscalls/swapoff/swapoff02.c                   | 2 --
 testcases/kernel/syscalls/swapon/swapon01.c                     | 2 --
 testcases/kernel/syscalls/swapon/swapon02.c                     | 2 --
 testcases/kernel/syscalls/swapon/swapon03.c                     | 2 --
 testcases/kernel/syscalls/symlink/symlink02.c                   | 2 --
 testcases/kernel/syscalls/symlink/symlink04.c                   | 2 --
 testcases/kernel/syscalls/sync_file_range/sync_file_range01.c   | 2 --
 testcases/kernel/syscalls/sync_file_range/sync_file_range02.c   | 2 --
 testcases/kernel/syscalls/syscall/syscall01.c                   | 2 --
 testcases/kernel/syscalls/sysfs/sysfs01.c                       | 2 --
 testcases/kernel/syscalls/sysfs/sysfs02.c                       | 2 --
 testcases/kernel/syscalls/sysfs/sysfs03.c                       | 2 --
 testcases/kernel/syscalls/sysfs/sysfs04.c                       | 2 --
 testcases/kernel/syscalls/sysfs/sysfs05.c                       | 2 --
 testcases/kernel/syscalls/syslog/syslog11.c                     | 2 --
 testcases/kernel/syscalls/syslog/syslog12.c                     | 2 --
 testcases/kernel/syscalls/tee/tee02.c                           | 2 --
 testcases/kernel/syscalls/time/time01.c                         | 1 -
 testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c | 2 --
 testcases/kernel/syscalls/timerfd/timerfd02.c                   | 2 --
 testcases/kernel/syscalls/timerfd/timerfd_create01.c            | 2 --
 testcases/kernel/syscalls/times/times01.c                       | 2 --
 testcases/kernel/syscalls/tkill/tkill01.c                       | 2 --
 testcases/kernel/syscalls/tkill/tkill02.c                       | 2 --
 testcases/kernel/syscalls/truncate/truncate02.c                 | 2 --
 testcases/kernel/syscalls/truncate/truncate03.c                 | 2 --
 testcases/kernel/syscalls/umount/umount01.c                     | 2 --
 testcases/kernel/syscalls/umount/umount02.c                     | 2 --
 testcases/kernel/syscalls/umount/umount03.c                     | 2 --
 testcases/kernel/syscalls/umount2/umount2_02.c                  | 2 --
 testcases/kernel/syscalls/unlink/unlink05.c                     | 2 --
 testcases/kernel/syscalls/unlink/unlink07.c                     | 2 --
 testcases/kernel/syscalls/unlink/unlink08.c                     | 2 --
 testcases/kernel/syscalls/unlink/unlink09.c                     | 2 --
 testcases/kernel/syscalls/unlink/unlink10.c                     | 2 --
 testcases/kernel/syscalls/unlinkat/unlinkat01.c                 | 1 -
 testcases/kernel/syscalls/unshare/unshare01.c                   | 2 --
 testcases/kernel/syscalls/unshare/unshare02.c                   | 2 --
 testcases/kernel/syscalls/utime/utime01.c                       | 2 --
 testcases/kernel/syscalls/utime/utime02.c                       | 2 --
 testcases/kernel/syscalls/utime/utime03.c                       | 2 --
 testcases/kernel/syscalls/utime/utime04.c                       | 2 --
 testcases/kernel/syscalls/utime/utime05.c                       | 2 --
 testcases/kernel/syscalls/utime/utime06.c                       | 2 --
 testcases/kernel/syscalls/utime/utime07.c                       | 2 --
 testcases/kernel/syscalls/utimensat/utimensat01.c               | 2 --
 testcases/kernel/syscalls/utimes/utimes01.c                     | 2 --
 testcases/kernel/syscalls/vmsplice/vmsplice02.c                 | 2 --
 testcases/kernel/syscalls/wait/wait01.c                         | 2 --
 testcases/kernel/syscalls/wait/wait02.c                         | 2 --
 testcases/kernel/syscalls/wait4/wait402.c                       | 2 --
 testcases/kernel/syscalls/wait4/wait403.c                       | 2 --
 testcases/kernel/syscalls/waitid/waitid01.c                     | 2 --
 testcases/kernel/syscalls/waitid/waitid02.c                     | 2 --
 testcases/kernel/syscalls/waitid/waitid03.c                     | 2 --
 testcases/kernel/syscalls/waitid/waitid04.c                     | 2 --
 testcases/kernel/syscalls/waitid/waitid05.c                     | 2 --
 testcases/kernel/syscalls/waitid/waitid06.c                     | 2 --
 testcases/kernel/syscalls/waitid/waitid07.c                     | 2 --
 testcases/kernel/syscalls/waitid/waitid08.c                     | 2 --
 testcases/kernel/syscalls/waitid/waitid09.c                     | 2 --
 testcases/kernel/syscalls/waitid/waitid10.c                     | 2 --
 testcases/kernel/syscalls/waitid/waitid11.c                     | 2 --
 testcases/kernel/syscalls/waitpid/waitpid01.c                   | 2 --
 testcases/kernel/syscalls/waitpid/waitpid03.c                   | 2 --
 testcases/kernel/syscalls/waitpid/waitpid04.c                   | 2 --
 testcases/kernel/syscalls/write/write02.c                       | 2 --
 testcases/kernel/syscalls/write/write04.c                       | 2 --
 testcases/kernel/syscalls/write/write05.c                       | 2 --
 testcases/kernel/syscalls/write/write06.c                       | 2 --
 testcases/kernel/syscalls/writev/writev03.c                     | 2 --
 testcases/kernel/syscalls/writev/writev07.c                     | 2 --
 testcases/kernel/uevents/uevent01.c                             | 1 -
 testcases/kernel/uevents/uevent02.c                             | 2 --
 testcases/kernel/uevents/uevent03.c                             | 1 -
 testcases/kernel/watchqueue/wqueue01.c                          | 2 --
 testcases/kernel/watchqueue/wqueue02.c                          | 2 --
 testcases/kernel/watchqueue/wqueue03.c                          | 2 --
 testcases/kernel/watchqueue/wqueue04.c                          | 2 --
 testcases/kernel/watchqueue/wqueue05.c                          | 2 --
 testcases/kernel/watchqueue/wqueue06.c                          | 2 --
 testcases/kernel/watchqueue/wqueue07.c                          | 2 --
 testcases/kernel/watchqueue/wqueue08.c                          | 2 --
 testcases/kernel/watchqueue/wqueue09.c                          | 2 --
 testcases/lib/tst_ns_create.c                                   | 2 --
 testcases/lib/tst_ns_exec.c                                     | 2 --
 testcases/lib/tst_ns_ifmove.c                                   | 2 --
 testcases/network/can/cve/can_bcm01.c                           | 2 --
 testcases/network/iptables/nft02.c                              | 2 --
 testcases/network/lib6/asapi_02.c                               | 2 --
 testcases/network/lib6/getaddrinfo_01.c                         | 2 --
 testcases/network/lib6/in6_01.c                                 | 2 --
 testcases/network/lib6/in6_02.c                                 | 2 --
 testcases/network/nfs/nfslock01/nfs_flock.c                     | 2 --
 testcases/network/nfs/nfslock01/nfs_flock_dgen.c                | 2 --
 testcases/network/sctp/sctp_big_chunk.c                         | 2 --
 testcases/network/sockets/vsock01.c                             | 2 --
 testcases/realtime/func/matrix_mult/matrix_mult.c               | 2 --
 testcases/realtime/func/sched_football/sched_football.c         | 2 --
 973 files changed, 1907 deletions(-)

diff --git a/doc/developers/test_case_tutorial.rst b/doc/developers/test_case_tutorial.rst
index 1464f50d70..04820f2223 100644
--- a/doc/developers/test_case_tutorial.rst
+++ b/doc/developers/test_case_tutorial.rst
@@ -111,7 +111,6 @@ kernel version if necessary. I will explain what the code does below.
      */
 
     /*\
-     * [Description]
      *
      * All tests should start with a description of _what_ we are testing.
      * Non-trivial explanations of _how_ the code works should also go here.
diff --git a/doc/old/C-Test-API.asciidoc b/doc/old/C-Test-API.asciidoc
index 8a531ccb0f..3fe9cd1d9e 100644
--- a/doc/old/C-Test-API.asciidoc
+++ b/doc/old/C-Test-API.asciidoc
@@ -17,7 +17,6 @@ Let's start with an example, following code is a simple test for a 'getenv()'.
 [source,c]
 -------------------------------------------------------------------------------
 /*\
- * [Description]
  * Tests basic functionality of getenv().
  *
  *  - create an env variable and verify that getenv() can get it
diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index d23a8e652b..3f4d30fa7c 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -5,8 +5,6 @@
  * Copyright (c) 2020-2021 SUSE LLC <rpalethorpe@suse.com>
  */
 /*\
- * [Description]
- *
  * The LTP CGroups API tries to present a consistent interface to the
  * many possible CGroup configurations a system could have.
  *
diff --git a/lib/newlib_tests/tst_fuzzy_sync01.c b/lib/newlib_tests/tst_fuzzy_sync01.c
index 2d440df5b0..6c361e8cc3 100644
--- a/lib/newlib_tests/tst_fuzzy_sync01.c
+++ b/lib/newlib_tests/tst_fuzzy_sync01.c
@@ -3,8 +3,6 @@
  * Copyright (c) 2021 Richard Palethorpe <rpalethorpe@suse.com>
  */
 /*
- * [Description]
- *
  * This verifies Fuzzy Sync's basic ability to reproduce a particular
  * outcome to a data race when the critical sections are not aligned.
  *
diff --git a/lib/newlib_tests/tst_fuzzy_sync02.c b/lib/newlib_tests/tst_fuzzy_sync02.c
index c81ebc7eaa..0a595b1e2b 100644
--- a/lib/newlib_tests/tst_fuzzy_sync02.c
+++ b/lib/newlib_tests/tst_fuzzy_sync02.c
@@ -3,8 +3,6 @@
  * Copyright (c) 2021 Richard Palethorpe <rpalethorpe@suse.com>
  */
 /*
- * [Description]
- *
  * This verifies Fuzzy Sync's ability to reproduce a particular
  * outcome to a data race when multiple races are present.
  *
diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
index cd68e596cf..5e5b55e071 100644
--- a/testcases/cve/cve-2014-0196.c
+++ b/testcases/cve/cve-2014-0196.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2014-0196, which was fixed in kernel v3.15:
  * 4291086b1f08 ("n_tty: Fix n_tty_write crash when echoing in raw mode").
  *
diff --git a/testcases/cve/cve-2016-10044.c b/testcases/cve/cve-2016-10044.c
index 31c73f5347..d8d3598bbc 100644
--- a/testcases/cve/cve-2016-10044.c
+++ b/testcases/cve/cve-2016-10044.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2016-10044, which was fixed in kernel v4.8:
  * 22f6b4d34fcf ("aio: mark AIO pseudo-fs noexec").
  *
diff --git a/testcases/cve/cve-2016-7042.c b/testcases/cve/cve-2016-7042.c
index 7611f6638e..881f891d94 100644
--- a/testcases/cve/cve-2016-7042.c
+++ b/testcases/cve/cve-2016-7042.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2016-7042, this regression test can crash the buggy kernel
  * when the stack-protector is enabled, and the bug was fixed in kernel v4.9:
  * 03dab869b7b2 ("KEYS: Fix short sprintf buffer in /proc/keys show function").
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index 119eb2f9a9..dbec2b28bc 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2016-7117, which was fixed in kernel v4.6:
  * 34b88a68f26a ("net: Fix use after free in the recvmmsg exit path").
  *
diff --git a/testcases/cve/cve-2017-16939.c b/testcases/cve/cve-2017-16939.c
index ec23f10c64..098a868411 100644
--- a/testcases/cve/cve-2017-16939.c
+++ b/testcases/cve/cve-2017-16939.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2017-16939, which was fixed in kernel v4.14:
  * 1137b5e2529a ("ipsec: Fix aborted xfrm policy dump crash").
  *
diff --git a/testcases/cve/cve-2017-17052.c b/testcases/cve/cve-2017-17052.c
index 598cd9b52f..700eb782e1 100644
--- a/testcases/cve/cve-2017-17052.c
+++ b/testcases/cve/cve-2017-17052.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2017-17052, which was fixed in kernel v4.13:
  * 2b7e8665b4ff ("fork: fix incorrect fput of ->exe_file causing use-after-free").
  *
diff --git a/testcases/cve/cve-2017-17053.c b/testcases/cve/cve-2017-17053.c
index a6cf2551e4..fe7b6d694d 100644
--- a/testcases/cve/cve-2017-17053.c
+++ b/testcases/cve/cve-2017-17053.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2017-17053, which was fixed in kernel 4.13:
  * ccd5b3235180 ("x86/mm: Fix use-after-free of ldt_struct").
  *
diff --git a/testcases/cve/cve-2017-2618.c b/testcases/cve/cve-2017-2618.c
index 7d1aca15c2..98a998415e 100644
--- a/testcases/cve/cve-2017-2618.c
+++ b/testcases/cve/cve-2017-2618.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2017-2618, which was fixed in kernel v4.10:
  * 0c461cb727d1 ("selinux: fix off-by-one in setprocattr").
  *
diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index 3c28317e2e..5d84252488 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2017-2671 faulty locking on ping socket fixed in kernel v4.11:
  * 43a6684519ab ("ping: implement proper locking").
  *
diff --git a/testcases/cve/cve-2022-4378.c b/testcases/cve/cve-2022-4378.c
index 95c0fa5170..e7e2b9af33 100644
--- a/testcases/cve/cve-2022-4378.c
+++ b/testcases/cve/cve-2022-4378.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2022-4378 fixed in kernel v6.1:
  * bce9332220bd ("proc: proc_skip_spaces() shouldn't think it is working on C strings").
  *
diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
index f71be0e081..0305ad0954 100644
--- a/testcases/cve/icmp_rate_limit01.c
+++ b/testcases/cve/icmp_rate_limit01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2020-25705 fixed in kernel v5.10:
  * b38e7819cae9 ("icmp: randomize the global rate limiter").
  *
diff --git a/testcases/cve/meltdown.c b/testcases/cve/meltdown.c
index c2145291d0..d2c40c1220 100644
--- a/testcases/cve/meltdown.c
+++ b/testcases/cve/meltdown.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2017-5754 (Meltdown).
  *
  * https://meltdownattack.com/
diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
index 8cc2c20b5b..8471e0638f 100644
--- a/testcases/cve/stack_clash.c
+++ b/testcases/cve/stack_clash.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This is a regression test of the Stack Clash [1] vulnerability. This tests
  * that there is at least 256 PAGE_SIZE of stack guard gap which is considered
  * hard to hop above. Code adapted from the Novell's bugzilla [2].
diff --git a/testcases/cve/tcindex01.c b/testcases/cve/tcindex01.c
index 4e4a62fdbd..370d7de495 100644
--- a/testcases/cve/tcindex01.c
+++ b/testcases/cve/tcindex01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * CVE-2023-1829
  *
  * Test for use-after-free after removing tcindex traffic filter with certain
diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
index 2205eb9689..2c1c978fdb 100644
--- a/testcases/kernel/containers/mountns/mountns01.c
+++ b/testcases/kernel/containers/mountns/mountns01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests a shared mount: shared mount can be replicated to as many
  * mountpoints and all the replicas continue to be exactly same.
  *
diff --git a/testcases/kernel/containers/mountns/mountns02.c b/testcases/kernel/containers/mountns/mountns02.c
index 56b1b4b6a2..cdc36068da 100644
--- a/testcases/kernel/containers/mountns/mountns02.c
+++ b/testcases/kernel/containers/mountns/mountns02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests a private mount: private mount does not forward or receive
  * propagation.
  *
diff --git a/testcases/kernel/containers/mountns/mountns03.c b/testcases/kernel/containers/mountns/mountns03.c
index cdceb00d05..2debfd1047 100644
--- a/testcases/kernel/containers/mountns/mountns03.c
+++ b/testcases/kernel/containers/mountns/mountns03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests a slave mount: slave mount is like a shared mount except that
  * mount and umount events only propagate towards it.
  *
diff --git a/testcases/kernel/containers/mountns/mountns04.c b/testcases/kernel/containers/mountns/mountns04.c
index 752d899205..b87fc8550d 100644
--- a/testcases/kernel/containers/mountns/mountns04.c
+++ b/testcases/kernel/containers/mountns/mountns04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests an unbindable mount: unbindable mount is an unbindable
  * private mount.
  *
diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kernel/containers/mqns/mqns_01.c
index d9f6e6c18a..30e06edf43 100644
--- a/testcases/kernel/containers/mqns/mqns_01.c
+++ b/testcases/kernel/containers/mqns/mqns_01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Create a mqueue inside the parent and check if it can be accessed from
  * the child namespace. Isolated and unshared process can't access to parent,
  * but plain process can.
diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/kernel/containers/mqns/mqns_02.c
index aef83a23a6..dc1b215ddb 100644
--- a/testcases/kernel/containers/mqns/mqns_02.c
+++ b/testcases/kernel/containers/mqns/mqns_02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Create a mqueue with the same name in both parent and isolated/forked child,
  * then check namespace isolation.
  */
diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
index 4a0399ddbc..4d3bfc52fb 100644
--- a/testcases/kernel/containers/mqns/mqns_03.c
+++ b/testcases/kernel/containers/mqns/mqns_03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test mqueuefs from an isolated/forked process namespace.
  *
  * [Algorithm]
diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
index 2d943e1b68..d28c330c4d 100644
--- a/testcases/kernel/containers/mqns/mqns_04.c
+++ b/testcases/kernel/containers/mqns/mqns_04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test mqueuefs manipulation from child/parent namespaces.
  *
  * [Algorithm]
diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/kernel/containers/netns/netns_netlink.c
index ba55ec70ad..5246b066b9 100644
--- a/testcases/kernel/containers/netns/netns_netlink.c
+++ b/testcases/kernel/containers/netns/netns_netlink.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests a netlink interface inside a new network namespace.
  *
  * - Unshares a network namespace (so network related actions
diff --git a/testcases/kernel/containers/pidns/pidns01.c b/testcases/kernel/containers/pidns/pidns01.c
index 8b856ec90b..94b8f16d82 100644
--- a/testcases/kernel/containers/pidns/pidns01.c
+++ b/testcases/kernel/containers/pidns/pidns01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone a process with CLONE_NEWPID flag and check:
  *
  * - child process ID must be 1
diff --git a/testcases/kernel/containers/pidns/pidns02.c b/testcases/kernel/containers/pidns/pidns02.c
index f23178cb60..b5e2d607de 100644
--- a/testcases/kernel/containers/pidns/pidns02.c
+++ b/testcases/kernel/containers/pidns/pidns02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone a process with CLONE_NEWPID flag and check:
  *
  * - child session ID must be 1
diff --git a/testcases/kernel/containers/pidns/pidns03.c b/testcases/kernel/containers/pidns/pidns03.c
index d2a6178b9b..31fdb3e4e7 100644
--- a/testcases/kernel/containers/pidns/pidns03.c
+++ b/testcases/kernel/containers/pidns/pidns03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone a process with CLONE_NEWPID flag and check if procfs mounted folder
  * belongs to the new pid namespace by looking at /proc/self .
  */
diff --git a/testcases/kernel/containers/pidns/pidns04.c b/testcases/kernel/containers/pidns/pidns04.c
index fdd532653e..ff106780ad 100644
--- a/testcases/kernel/containers/pidns/pidns04.c
+++ b/testcases/kernel/containers/pidns/pidns04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone a process with CLONE_NEWPID flag and check that child container does
  * not get kill itself with SIGKILL.
  */
diff --git a/testcases/kernel/containers/pidns/pidns05.c b/testcases/kernel/containers/pidns/pidns05.c
index 7843fe7a97..b1666f233a 100644
--- a/testcases/kernel/containers/pidns/pidns05.c
+++ b/testcases/kernel/containers/pidns/pidns05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone a process with CLONE_NEWPID flag and create many levels of child
  * containers. Then kill container init process from parent and check if all
  * containers have been killed.
diff --git a/testcases/kernel/containers/pidns/pidns06.c b/testcases/kernel/containers/pidns/pidns06.c
index a71c844a39..b79a5d4010 100644
--- a/testcases/kernel/containers/pidns/pidns06.c
+++ b/testcases/kernel/containers/pidns/pidns06.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone a process with CLONE_NEWPID flag and check that parent process can't
  * be killed from child namespace.
  */
diff --git a/testcases/kernel/containers/pidns/pidns10.c b/testcases/kernel/containers/pidns/pidns10.c
index 7e798420ef..ab6a7a4acf 100644
--- a/testcases/kernel/containers/pidns/pidns10.c
+++ b/testcases/kernel/containers/pidns/pidns10.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone a process with CLONE_NEWPID flag and check that killing subprocesses
  * from child namespace will raise ESRCH error.
  */
diff --git a/testcases/kernel/containers/pidns/pidns12.c b/testcases/kernel/containers/pidns/pidns12.c
index 1811dbc36b..4de4e3d101 100644
--- a/testcases/kernel/containers/pidns/pidns12.c
+++ b/testcases/kernel/containers/pidns/pidns12.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone a process with CLONE_NEWPID flag and verifies that siginfo->si_pid is
  * set to 0 if sender (parent process) is not in the receiver's namespace.
  */
diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel/containers/pidns/pidns13.c
index 65fcc4443d..5b836c01f4 100644
--- a/testcases/kernel/containers/pidns/pidns13.c
+++ b/testcases/kernel/containers/pidns/pidns13.c
@@ -9,8 +9,6 @@
  */
 
 /*\
- * [Description]
- *
  * The pidns13.c testcase checks container init, for async I/O
  * triggered by peer namespace process.
  *
diff --git a/testcases/kernel/containers/pidns/pidns16.c b/testcases/kernel/containers/pidns/pidns16.c
index 313b0a097b..8867a132b5 100644
--- a/testcases/kernel/containers/pidns/pidns16.c
+++ b/testcases/kernel/containers/pidns/pidns16.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone a process with CLONE_NEWPID flag and verifies that siginfo->si_pid is
  * set to 0 if sender (parent process) sent the signal. Then send signal from
  * container itself and check if siginfo->si_pid is set to 1.
diff --git a/testcases/kernel/containers/pidns/pidns17.c b/testcases/kernel/containers/pidns/pidns17.c
index 4633ec14b4..3a85d96725 100644
--- a/testcases/kernel/containers/pidns/pidns17.c
+++ b/testcases/kernel/containers/pidns/pidns17.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone a process with CLONE_NEWPID flag and spawn many children inside the
  * container. Then terminate all children and check if they were signaled.
  */
diff --git a/testcases/kernel/containers/pidns/pidns20.c b/testcases/kernel/containers/pidns/pidns20.c
index 9148208659..aa00800003 100644
--- a/testcases/kernel/containers/pidns/pidns20.c
+++ b/testcases/kernel/containers/pidns/pidns20.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone a process with CLONE_NEWPID flag, block SIGUSR1 signal before sending
  * it from parent and check if it's received once SIGUSR1 signal is unblocked.
  */
diff --git a/testcases/kernel/containers/pidns/pidns30.c b/testcases/kernel/containers/pidns/pidns30.c
index 4a8bc5e2b8..409b37ec18 100644
--- a/testcases/kernel/containers/pidns/pidns30.c
+++ b/testcases/kernel/containers/pidns/pidns30.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone a process with CLONE_NEWPID flag, register notification on a posix
  * mqueue and send a mqueue message from the parent. Then check if signal
  * notification contains si_pid of the parent.
diff --git a/testcases/kernel/containers/pidns/pidns31.c b/testcases/kernel/containers/pidns/pidns31.c
index 7312f8bdcb..a8d737091d 100644
--- a/testcases/kernel/containers/pidns/pidns31.c
+++ b/testcases/kernel/containers/pidns/pidns31.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone a process with CLONE_NEWPID flag, register notification on a posix
  * mqueue and send a mqueue message from the child. Then check if signal
  * notification contains si_pid of the child.
diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel/containers/pidns/pidns32.c
index 0738369b1d..3798f798be 100644
--- a/testcases/kernel/containers/pidns/pidns32.c
+++ b/testcases/kernel/containers/pidns/pidns32.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone a process with CLONE_NEWPID flag and check for the maxium amount of
  * nested containers.
  */
diff --git a/testcases/kernel/containers/sysvipc/mesgq_nstest.c b/testcases/kernel/containers/sysvipc/mesgq_nstest.c
index 4b12c1ce1d..6c65c5500c 100644
--- a/testcases/kernel/containers/sysvipc/mesgq_nstest.c
+++ b/testcases/kernel/containers/sysvipc/mesgq_nstest.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test SysV IPC message passing through different namespaces.
  *
  * [Algorithm]
diff --git a/testcases/kernel/containers/sysvipc/msg_comm.c b/testcases/kernel/containers/sysvipc/msg_comm.c
index 3762adb02a..81bd096303 100644
--- a/testcases/kernel/containers/sysvipc/msg_comm.c
+++ b/testcases/kernel/containers/sysvipc/msg_comm.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test SysV IPC message passing through different processes.
  *
  * [Algorithm]
diff --git a/testcases/kernel/containers/sysvipc/sem_comm.c b/testcases/kernel/containers/sysvipc/sem_comm.c
index d8f0956a7a..ec67526215 100644
--- a/testcases/kernel/containers/sysvipc/sem_comm.c
+++ b/testcases/kernel/containers/sysvipc/sem_comm.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test SysV IPC semaphore usage between cloned processes.
  *
  * [Algorithm]
diff --git a/testcases/kernel/containers/sysvipc/sem_nstest.c b/testcases/kernel/containers/sysvipc/sem_nstest.c
index 35d55cbac3..133795f067 100644
--- a/testcases/kernel/containers/sysvipc/sem_nstest.c
+++ b/testcases/kernel/containers/sysvipc/sem_nstest.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test SysV IPC semaphore usage between namespaces.
  *
  * [Algorithm]
diff --git a/testcases/kernel/containers/sysvipc/semtest_2ns.c b/testcases/kernel/containers/sysvipc/semtest_2ns.c
index f03b18f72b..8c26dfd5ce 100644
--- a/testcases/kernel/containers/sysvipc/semtest_2ns.c
+++ b/testcases/kernel/containers/sysvipc/semtest_2ns.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test SysV IPC semaphore usage between namespaces and processes.
  *
  * [Algorithm]
diff --git a/testcases/kernel/containers/sysvipc/shm_comm.c b/testcases/kernel/containers/sysvipc/shm_comm.c
index e7ba8c8deb..30916deddc 100644
--- a/testcases/kernel/containers/sysvipc/shm_comm.c
+++ b/testcases/kernel/containers/sysvipc/shm_comm.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test if SysV IPC shared memory is properly working between two different
  * namespaces.
  *
diff --git a/testcases/kernel/containers/sysvipc/shmem_2nstest.c b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
index a184cfcb4d..c984ee7269 100644
--- a/testcases/kernel/containers/sysvipc/shmem_2nstest.c
+++ b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test if SysV IPC shared memory is properly used between two namespaces.
  *
  * [Algorithm]
diff --git a/testcases/kernel/containers/sysvipc/shmnstest.c b/testcases/kernel/containers/sysvipc/shmnstest.c
index 63ae62aa6d..aa576eb086 100644
--- a/testcases/kernel/containers/sysvipc/shmnstest.c
+++ b/testcases/kernel/containers/sysvipc/shmnstest.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test if SysV IPC shared memory with a specific key is shared between
  * processes and namespaces.
  */
diff --git a/testcases/kernel/containers/userns/userns01.c b/testcases/kernel/containers/userns/userns01.c
index 6fe0cd6372..6ee9fa7d0c 100644
--- a/testcases/kernel/containers/userns/userns01.c
+++ b/testcases/kernel/containers/userns/userns01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that if a user ID has no mapping inside the namespace, user ID and
  * group ID will be the value defined in the file /proc/sys/kernel/overflowuid
  * (defaults to 65534) and /proc/sys/kernel/overflowgid (defaults to 65534). A
diff --git a/testcases/kernel/containers/userns/userns02.c b/testcases/kernel/containers/userns/userns02.c
index 3c8ce2133c..d71c5397ff 100644
--- a/testcases/kernel/containers/userns/userns02.c
+++ b/testcases/kernel/containers/userns/userns02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that the user ID and group ID, which are inside a container,
  * can be modified by its parent process.
  */
diff --git a/testcases/kernel/containers/userns/userns03.c b/testcases/kernel/containers/userns/userns03.c
index fca858702b..8fdad59517 100644
--- a/testcases/kernel/containers/userns/userns03.c
+++ b/testcases/kernel/containers/userns/userns03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that /proc/PID/uid_map and /proc/PID/gid_map contains three values
  * separated by white space:
  *
diff --git a/testcases/kernel/containers/userns/userns04.c b/testcases/kernel/containers/userns/userns04.c
index d20041f062..1ca7bf6e3e 100644
--- a/testcases/kernel/containers/userns/userns04.c
+++ b/testcases/kernel/containers/userns/userns04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that if a namespace isn't another namespace's ancestor, the process in
  * first namespace does not have the CAP_SYS_ADMIN capability in the second
  * namespace and the setns() call fails.
diff --git a/testcases/kernel/containers/userns/userns05.c b/testcases/kernel/containers/userns/userns05.c
index e7a00af182..f94e7116c2 100644
--- a/testcases/kernel/containers/userns/userns05.c
+++ b/testcases/kernel/containers/userns/userns05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that if a process created via fork(2) or clone(2) without the
  * CLONE_NEWUSER flag is a member of the same user namespace as its parent.
  *
diff --git a/testcases/kernel/containers/userns/userns06.c b/testcases/kernel/containers/userns/userns06.c
index a270dafdcf..3a1909ce98 100644
--- a/testcases/kernel/containers/userns/userns06.c
+++ b/testcases/kernel/containers/userns/userns06.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that when a process with non-zero user IDs performs an execve(),
  * the process's capability sets are cleared.
  * When a process with zero user IDs performs an execve(), the process's
diff --git a/testcases/kernel/containers/userns/userns07.c b/testcases/kernel/containers/userns/userns07.c
index 2217a5ed03..9e34a3d9bb 100644
--- a/testcases/kernel/containers/userns/userns07.c
+++ b/testcases/kernel/containers/userns/userns07.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that the kernel allows at least 32 nested levels of user namespaces.
  */
 
diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
index 72d7f8d12d..fbe51c8a57 100644
--- a/testcases/kernel/containers/userns/userns08.c
+++ b/testcases/kernel/containers/userns/userns08.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Reproducer of CVE-2018-18955; broken uid/gid mapping for nested
  * user namespaces with >5 ranges
  *
diff --git a/testcases/kernel/containers/utsname/utsname01.c b/testcases/kernel/containers/utsname/utsname01.c
index fc5c1a271a..a72ad1c33c 100644
--- a/testcases/kernel/containers/utsname/utsname01.c
+++ b/testcases/kernel/containers/utsname/utsname01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone two plain processes and check if both read the same hostname.
  */
 
diff --git a/testcases/kernel/containers/utsname/utsname02.c b/testcases/kernel/containers/utsname/utsname02.c
index aa90596d43..b100d212cc 100644
--- a/testcases/kernel/containers/utsname/utsname02.c
+++ b/testcases/kernel/containers/utsname/utsname02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone two plain processes, change hostname in the first one then check if
  * hostaname has changed inside the second one as well.
  */
diff --git a/testcases/kernel/containers/utsname/utsname03.c b/testcases/kernel/containers/utsname/utsname03.c
index e5a4a56dc3..0680058e79 100644
--- a/testcases/kernel/containers/utsname/utsname03.c
+++ b/testcases/kernel/containers/utsname/utsname03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Clone two processes using CLONE_NEWUTS, change hostname from the first
  * container and check if hostname didn't change inside the second one.
  */
diff --git a/testcases/kernel/containers/utsname/utsname04.c b/testcases/kernel/containers/utsname/utsname04.c
index bf97880ba9..2bcf61156d 100644
--- a/testcases/kernel/containers/utsname/utsname04.c
+++ b/testcases/kernel/containers/utsname/utsname04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Drop root privileges, create a container with CLONE_NEWUTS and verify that
  * we receive a permission error.
  */
diff --git a/testcases/kernel/controllers/cgroup/cgroup_core01.c b/testcases/kernel/controllers/cgroup/cgroup_core01.c
index 2e695deed7..11231fbf71 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core01.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * When a task is writing to an fd opened by a different task, the perm check
  * should use the credentials of the latter task.
  *
diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c b/testcases/kernel/controllers/cgroup/cgroup_core02.c
index b19bf2e58d..aba387197a 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core02.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * When a task is writing to an fd opened by a different task, the perm check
  * should use the cgroup namespace of the latter task.
  *
diff --git a/testcases/kernel/controllers/cgroup/cgroup_core03.c b/testcases/kernel/controllers/cgroup/cgroup_core03.c
index c0c3485e66..49b8eff404 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core03.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test is copied from kselftest
  * tools/testing/selftests/cgroup/test_kill.c.
  *
diff --git a/testcases/kernel/controllers/io/io_control01.c b/testcases/kernel/controllers/io/io_control01.c
index 8b20737c97..93e6aed87e 100644
--- a/testcases/kernel/controllers/io/io_control01.c
+++ b/testcases/kernel/controllers/io/io_control01.c
@@ -3,8 +3,6 @@
  * Copyright (c) 2022 SUSE LLC <rpalethorpe@suse.com>
  */
 /*\
- *
- * [Description]
  *
  * Perform some I/O on a file and check if at least some of it is
  * recorded by the I/O controller.
diff --git a/testcases/kernel/controllers/memcg/memcontrol01.c b/testcases/kernel/controllers/memcg/memcontrol01.c
index f4fadacddd..f1f5a9df44 100644
--- a/testcases/kernel/controllers/memcg/memcontrol01.c
+++ b/testcases/kernel/controllers/memcg/memcontrol01.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*\
- *
- * [Description]
  *
  * Conversion of the first kself test in cgroup/test_memcontrol.c.
  * This test creates two nested cgroups with and without enabling the
diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
index aed6410841..2d47e50427 100644
--- a/testcases/kernel/controllers/memcg/memcontrol02.c
+++ b/testcases/kernel/controllers/memcg/memcontrol02.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*\
- *
- * [Description]
  *
  * Conversion of second kself test in cgroup/test_memcontrol.c.
  *
diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
index 6d9c490b58..b5bbb99545 100644
--- a/testcases/kernel/controllers/memcg/memcontrol03.c
+++ b/testcases/kernel/controllers/memcg/memcontrol03.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*\
- *
- * [Description]
  *
  * Conversion of the third kself test in cgroup/test_memcontrol.c.
  *
diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c b/testcases/kernel/controllers/memcg/memcontrol04.c
index 1b8d115f8c..1b5425faaa 100644
--- a/testcases/kernel/controllers/memcg/memcontrol04.c
+++ b/testcases/kernel/controllers/memcg/memcontrol04.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*\
- *
- * [Description]
  *
  * Conversion of the forth kself test in cgroup/test_memcontrol.c.
  *
diff --git a/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
index 38ec1d6d61..cd900d8074 100644
--- a/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
+++ b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test checks block device kernel API.
  */
 
diff --git a/testcases/kernel/device-drivers/rtc/rtc02.c b/testcases/kernel/device-drivers/rtc/rtc02.c
index dbac11b853..34509abc13 100644
--- a/testcases/kernel/device-drivers/rtc/rtc02.c
+++ b/testcases/kernel/device-drivers/rtc/rtc02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * RTC device set time function test.
  *
  * [Algorithm]
diff --git a/testcases/kernel/device-drivers/zram/zram03.c b/testcases/kernel/device-drivers/zram/zram03.c
index 1df3325ec1..8cf26de4c6 100644
--- a/testcases/kernel/device-drivers/zram/zram03.c
+++ b/testcases/kernel/device-drivers/zram/zram03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * zram: generic RAM based compressed R/W block devices
  * http://lkml.org/lkml/2010/8/9/227
  *
diff --git a/testcases/kernel/fs/fsplough/fsplough.c b/testcases/kernel/fs/fsplough/fsplough.c
index f18a2df1b4..65db3738ea 100644
--- a/testcases/kernel/fs/fsplough/fsplough.c
+++ b/testcases/kernel/fs/fsplough/fsplough.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Write data into a test file using various methods and verify that file
  * contents match what was written.
  */
diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
index ac3b06ff77..2e0f17a5ec 100644
--- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
+++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
@@ -13,8 +13,6 @@
  */
 
 /*\
- * [Description]
- *
  * This is a complete rewrite of the old fsx-linux tool, created by
  * NeXT Computer, Inc. and Apple Computer, Inc. between 1991 and 2001,
  * then adapted for LTP. Test is actually a file system exerciser: we bring a
diff --git a/testcases/kernel/fs/squashfs/squashfs01.c b/testcases/kernel/fs/squashfs/squashfs01.c
index 502de419df..fbcb765826 100644
--- a/testcases/kernel/fs/squashfs/squashfs01.c
+++ b/testcases/kernel/fs/squashfs/squashfs01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Kernel commits
  *
  * - f37aa4c7366 (squashfs: add more sanity checks in id lookup)
diff --git a/testcases/kernel/input/input01.c b/testcases/kernel/input/input01.c
index 5e85133028..e57b041e22 100644
--- a/testcases/kernel/input/input01.c
+++ b/testcases/kernel/input/input01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that /dev/input/eventX receive events sent from a virtual device,
  * that in our case is a mouse.
  */
diff --git a/testcases/kernel/input/input02.c b/testcases/kernel/input/input02.c
index 8e48f12d9a..f4f6543a1d 100644
--- a/testcases/kernel/input/input02.c
+++ b/testcases/kernel/input/input02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that /dev/input/eventX won't receive any event sent from a virtual
  * device, that in our case is a mouse, when the event device has been grabbed
  * by an another process.
diff --git a/testcases/kernel/input/input03.c b/testcases/kernel/input/input03.c
index 2e6161beef..5229379cf0 100644
--- a/testcases/kernel/input/input03.c
+++ b/testcases/kernel/input/input03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that /dev/input/mice receive events sent from a virtual device,
  * that in our case is a mouse. The events are a sequence of mouse right click.
  */
diff --git a/testcases/kernel/input/input04.c b/testcases/kernel/input/input04.c
index fb13500fe6..0f05404c47 100644
--- a/testcases/kernel/input/input04.c
+++ b/testcases/kernel/input/input04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that /dev/input/eventX doesn't receive any event sent from a virtual
  * device, that in our case is a mouse, when relative move is (0, 0)
  */
diff --git a/testcases/kernel/input/input05.c b/testcases/kernel/input/input05.c
index fa37ac7acb..19cf8f1c15 100644
--- a/testcases/kernel/input/input05.c
+++ b/testcases/kernel/input/input05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that /dev/input/eventX doesn't receive any event sent from a virtual
  * device, that in our case is a mouse, when events not advertised in the input
  * device bits are filtered.
diff --git a/testcases/kernel/input/input06.c b/testcases/kernel/input/input06.c
index d3584a2b0b..969c90f636 100644
--- a/testcases/kernel/input/input06.c
+++ b/testcases/kernel/input/input06.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that auto-repeat is working on a virtual device, that in our case
  * it's a keyboard.
  */
diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
index e84308d1d0..469769d5a1 100644
--- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test creates a series of files and start AIO operations on them.
  * AIO is done in a rotating loop: first file1.bin gets 8 requests, then
  * file2.bin, then file3.bin etc. As each file finishes writing, test switches
diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
index c201505ae9..2a4afe1102 100644
--- a/testcases/kernel/io/ltp-aiodio/aiocp.c
+++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Copy file by using an async I/O state machine.
  *
  * - Start read request
diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_append.c b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
index e6280d3e8a..f1e7025fe0 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Append zeroed data to a file using libaio while other processes are doing
  * buffered reads and check if the buffer reads always see zero.
  */
diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
index 8f41fdbe1e..c4878f2762 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
@@ -10,8 +10,6 @@
  */
 
 /*\
- * [Description]
- *
  * Create a sparse file and write zeroes to it using libaio while other
  * processes are doing buffered reads and check if the buffer reads always see
  * zero.
diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
index 16bed5db2b..1febafb8e1 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Appends zeroed data to a file using O_DIRECT while a child processes are
  * doing buffered reads after seeking to the end of the file and checks if the
  * buffer reads always see zero.
diff --git a/testcases/kernel/io/ltp-aiodio/dio_read.c b/testcases/kernel/io/ltp-aiodio/dio_read.c
index e6d1b74383..f9587ef3de 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_read.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_read.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Create a file using buffered writes while other processes are doing
  * O_DIRECT reads and check if the buffer reads always see zero.
  */
diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 755668220b..c87e5ab1ac 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -11,8 +11,6 @@
  */
 
 /*\
- * [Description]
- *
  * Create a sparse file using O_DIRECT while other processes are doing
  * buffered reads and check if the buffer reads always see zero.
  */
diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
index 69799e6a21..d4e7d9ea0e 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test is mixing direct I/O and truncate operations checking if they can
  * be used together at the same time. Multiple children are spawned to read a
  * file that is written to using direct I/O and truncated in a loop.
diff --git a/testcases/kernel/irq/irqbalance01.c b/testcases/kernel/irq/irqbalance01.c
index 96bbec6a8f..f7c6b02785 100644
--- a/testcases/kernel/irq/irqbalance01.c
+++ b/testcases/kernel/irq/irqbalance01.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /* Copyright (c) 2021 SUSE LLC <rpalethorpe@suse.com> */
 /*\
- * [Description]
- *
  * Check that something (e.g. irqbalance daemon) is performing IRQ
  * load balancing.
  *
diff --git a/testcases/kernel/kvm/kvm_svm04.c b/testcases/kernel/kvm/kvm_svm04.c
index e69f0d4be9..75fcbfdcfc 100644
--- a/testcases/kernel/kvm/kvm_svm04.c
+++ b/testcases/kernel/kvm/kvm_svm04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Functional test for VMSAVE/VMLOAD instructions in KVM environment. Verify
  * that both instructions save/load the CPU state according to CPU
  * documentation.
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
index b7ab4e035f..53fef3ddb1 100644
--- a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * It tests alignment of fallocate arguments. fallocate will take non-huge
  * page aligned offsets and addresses.  However, operations are only
  * performed on huge pages.  This is different that than fallocate
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
index d03f43d670..1f7c4dcc69 100644
--- a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * It tests basic fallocate functionality in hugetlbfs. Preallocate huge
  * pages to a file in hugetlbfs, and then remove the pages via hole punch.
  */
diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
index 2404ffad12..54603b98b7 100644
--- a/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
+++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This checks copy-on-write semantics, specifically the semantics of a
  * MAP_PRIVATE mapping across a fork().  Some versions of the powerpc
  * kernel had a bug in huge_ptep_set_wrprotect() which would fail to
diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
index de495f0872..cafeaa242f 100644
--- a/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
+++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test shared memory behavior when multiple threads are attached to a
  * segment. A segment is created and then children are spawned which
  * attach, write, read (verify), and detach from the shared memory segment.
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
index 5032e05eca..1ac989487d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
@@ -9,8 +9,6 @@
  */
 
 /*\
- * [Description]
- *
  * There is a race condition if we map a same file on different processes.
  * Region tracking is protected by mmap_sem and hugetlb_instantiation_mutex.
  * When we do mmap, we don't grab a hugetlb_instantiation_mutex, but only
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
index 663d925f4b..5a965e1828 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Certain kernels have a bug where brk() does not perform the same
  * checks that a MAP_FIXED mmap() will, allowing brk() to create a
  * normal page VMA in a hugepage only address region. This can lead
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
index e3dd430879..b9d61dd660 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Some kernel versions after hugepage demand allocation was added used a
  * dubious heuristic to check if there was enough hugepage space available
  * for a given mapping.  The number of not-already-instantiated pages in
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
index 2a80edca93..10f64674da 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test sanity of cow optimization on page cache. If a page in page cache
  * has only 1 ref count, it is mapped for a private mapping directly and
  * is overwritten freely, so next time we access the page, we can see
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index f918d5e2e6..e1795153db 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This Test perform mmap, munmap and write operation on hugetlb file
  * based mapping. Mapping can be shared or private. and it checks for
  * Hugetlb counter (Total, Free, Reserve, Surplus) in /proc/meminfo and
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
index a98594af67..087e8c6914 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This Test perform Direct Write/Read from/To hugetlbfs file
  * which is mapped to process address space. The test is checking if it
  * succeeds and data written or read is not corrupted.
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
index 848986ceaa..523ea90253 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * fadvise() on some kernels can cause the reservation counter to get
  * corrupted. The problem is that the patches are allocated for the
  * reservation but not faulted in at the time of allocation. The counters
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
index 06b5f8e080..ab57da546e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * On some old ppc64 kernel, when hpage is mmaped on 32 bit boundary and
  * normal page below it, it triggers the bug caused by off-by-one error.
  *
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
index d262b65b20..2447d6782e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
@@ -5,7 +5,6 @@
  */
 
 /*\
- * [Description]
  * On some old ppc64 kernel, when huge page is mapped at below touching
  * 32 bit boundary (4GB - hpage_size), and normal page is mmaped
  * at just above it, it triggers a bug caused by off-by-one error.
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
index ecfd51d0c1..f9fd226940 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Older ppc64 kernels don't properly flush dcache to icache before
  * giving a cleared page to userspace.  With some exceedingly
  * hairy code, this attempts to test for this bug.
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
index e0238636bb..bd5fae5c99 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * madvise() on some kernels can cause the reservation counter to get
  * corrupted. The problem is that the patches are allocated
  * for the reservation but not faulted in at the time of allocation. The
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
index afd7ad3f77..45796decd4 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Just as normal mmap()s can't have an address, length or offset which
  * is not page aligned, so hugepage mmap()s can't have an address, length
  * or offset with is not hugepage aligned.
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
index 3d3a958669..313efb4bc9 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * The test checks that mlocking hugetlb areas works with all combinations
  * of MAP_PRIVATE and MAP_SHARED with and without MAP_LOCKED specified.
  */
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
index faebbd228d..3792cff89c 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests copy-on-write semantics of large pages where a number of threads
  * map the same file with the MAP_PRIVATE flag. The threads then write
  * into their copy of the mapping and recheck the contents to ensure they
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
index d9be8113ec..78e4a3bf99 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This baseline test validates that a mapping of a certain size can be
  * created, correctly. Once created, all the pages are filled with a
  * pattern and rechecked to test for corruption. The mapping is then
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
index 3bcba0580b..86157d262b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test uses mprotect to change protection of hugepage mapping and
  * perform read/write operation. It checks if the operation results in
  * expected behaviour as per the protection.
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
index ab6a3310ac..0de44d58ad 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Kernel has bug in mremap for some architecture. mremap() can cause
  * crashes on architectures with holes in the address space (like ia64)
  * and on powerpc with it's distict page size slices.
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
index 1ad8a41418..7d9fd0b603 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * The kernel has bug for mremap() on some architecture. mremap() can
  * cause crashes on architectures with holes in the address space
  * (like ia64) and on powerpc with it's distinct page size "slices".
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
index 21be2d376b..cd60d74035 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test Description: The kernel has bug for mremap() on some architecture.
  * mremap() can cause crashes on architectures with holes in the address
  * space (like ia64) and on powerpc with it's distinct page size "slices".
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
index bafae1ca86..f79258da6d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test to preserve a reserved page against no-reserved mapping. If all
  * hugepages are reserved, access to no-reserved shared mapping cause a
  * process die, instead of stealing a hugepage which is reserved for other
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
index 660c93953a..48cedd158c 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test to correct handling for reserve count. If no reserved mapping is
  * created to reserved file region, it should be considered as reserve
  * mapping. Otherwise, reserve count will be overflowed.
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
index 67857615a0..f049745006 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * The test do mmap() with shared mapping and write. It matches the data
  * with private mmap() and then change it with other data. It checks
  * shared mapping data if data is not contaiminated by private mapping.
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
index 61b28c781d..a624f4a262 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * readahead() on some kernels can cause the reservation counter to get
  * corrupted. The problem is that the pages are allocated for the
  * reservation but not faulted in at the time of allocation. The
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
index 171dbb0700..57367b6419 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test is basic shared mapping test. Two shared mappings are created
  * with same offset on a file. It checks if writing to one mapping can be
  * seen to other mapping or not?
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
index d27e5b8b2d..188ee2176b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Before kernel version 5.10-rc7, there was a bug that resulted in a "Bad Page
  * State" error when freeing gigantic hugepages. This happened because the
  * struct page entry compound_nr, which overlapped with page->mapping in the
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
index 3b92c95654..bf2b356426 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * On PowerPC, the address space is divided into segments.  These segments can
  * contain either huge pages or normal pages, but not both.  All segments are
  * initially set up to map normal pages.  When a huge page mapping is created
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index 04325ce104..bd4437b130 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test the IPC_STAT, IPC_SET and IPC_RMID commands used by shmctl().
  */
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
index 998b85e9ce..ca93ae6d81 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This testcase creates shared memory segments backed by hugepages,
  * writes specific patterns to each segment, verifies pattern,
  * and detaches a shared memory segments in a loop.
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 7b478c46db..35bbe3d720 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Prerequisites:
  *
  * ksm and ksmtuned daemons need to be disabled. Otherwise, it could
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 80fdf1e472..cd07605a20 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -3,8 +3,6 @@
  * Copyright (C) 2013-2017  Red Hat, Inc.
  */
 /*\
- * [Description]
- *
  * The case is designed to test sysfs boolean knob
  * /sys/kernel/mm/ksm/merge_across_nodes.
  *
diff --git a/testcases/kernel/mem/ksm/ksm07.c b/testcases/kernel/mem/ksm/ksm07.c
index 619bd7b559..92b8b504ea 100644
--- a/testcases/kernel/mem/ksm/ksm07.c
+++ b/testcases/kernel/mem/ksm/ksm07.c
@@ -3,8 +3,6 @@
  * Copyright (C) 2023  Red Hat, Inc.
  */
 /*\
- * [Description]
- *
  * Kernel Samepage Merging (KSM) for smart scan feature
  *
  * Test allocates a page and fills it with 'a' characters. It captures the
diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 5ba09208d6..a0ef9a6b58 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -6,7 +6,6 @@
  * 10/03/2022	Refactor to LTP framework	edliaw@google.com
  */
 /*\
- * [Description]
  * This test stresses mmaps, without dealing with fragments or anything!
  * It forks a specified number of children,
  * all of whom mmap the same file, make a given number of accesses
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index ddb9044598..bc1e25159f 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -4,8 +4,6 @@
  * Copyright (c) Linux Test Project, 2011-2023
  */
 /*\
- * [Description]
- *
  * Out Of Memory (OOM) test
  */
 
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 50b514cb4a..96c51d90a4 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -4,8 +4,6 @@
  * Copyright (c) Linux Test Project, 2011-2023
  */
 /*\
- * [Description]
- *
  * Out Of Memory (OOM) test for mempolicy - need NUMA system support
  */
 
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 873a6d84c5..89984b86f8 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -4,8 +4,6 @@
  * Copyright (c) Linux Test Project, 2011-2023
  */
 /*\
- * [Description]
- *
  * Out Of Memory (OOM) test for Memory Resource Controller
  */
 
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 94e70f3c54..54efd7592f 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -4,8 +4,6 @@
  * Copyright (c) Linux Test Project, 2011-2023
  */
 /*\
- * [Description]
- *
  * Out Of Memory (OOM) test for CPUSET
  */
 
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 16e4018cf7..1a1b571608 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -4,8 +4,6 @@
  * Copyright (c) Linux Test Project, 2014-2023
  */
 /*\
- * [Description]
- *
  * Out Of Memory (OOM) test for MEMCG and CPUSET
  */
 
diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index df1dcdf56d..d3bdda5669 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Detect heavy swapping during first time swap use.
  *
  * This case is used for testing kernel commit:
diff --git a/testcases/kernel/mem/thp/thp01.c b/testcases/kernel/mem/thp/thp01.c
index 69825b0f99..ce36aa9774 100644
--- a/testcases/kernel/mem/thp/thp01.c
+++ b/testcases/kernel/mem/thp/thp01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This is a reproducer of CVE-2011-0999, which fixed by mainline commit
  * a7d6e4ecdb76 ("thp: prevent hugepages during args/env copying into the user stack")
  *
diff --git a/testcases/kernel/mem/thp/thp02.c b/testcases/kernel/mem/thp/thp02.c
index 56568d1d18..7ae053f35a 100644
--- a/testcases/kernel/mem/thp/thp02.c
+++ b/testcases/kernel/mem/thp/thp02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for detecting mremap bug when THP is enabled.
  *
  * There was a bug in mremap THP support, sometimes causing crash
diff --git a/testcases/kernel/pty/ptem01.c b/testcases/kernel/pty/ptem01.c
index 6040ee9bc3..3c364b24ae 100644
--- a/testcases/kernel/pty/ptem01.c
+++ b/testcases/kernel/pty/ptem01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that it's possible to open a pseudo-terminal via /dev/ptmx, obtain a
  * slave device and configure termos/termios ioctls.
  */
diff --git a/testcases/kernel/pty/ptem02.c b/testcases/kernel/pty/ptem02.c
index 0fc69aa1d8..ee02d20ed4 100644
--- a/testcases/kernel/pty/ptem02.c
+++ b/testcases/kernel/pty/ptem02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that it's possible to open a pseudo-terminal via /dev/ptmx, obtain a
  * slave device and set/get window size.
  */
diff --git a/testcases/kernel/pty/ptem03.c b/testcases/kernel/pty/ptem03.c
index fb0fdf6612..d284371f80 100644
--- a/testcases/kernel/pty/ptem03.c
+++ b/testcases/kernel/pty/ptem03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that it's possible to open a pseudo-terminal via /dev/ptmx, obtain a
  * slave device and to send a break to both master and slave.
  */
diff --git a/testcases/kernel/pty/ptem04.c b/testcases/kernel/pty/ptem04.c
index 675e6b816d..14249448f4 100644
--- a/testcases/kernel/pty/ptem04.c
+++ b/testcases/kernel/pty/ptem04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that it's possible to open a pseudo-terminal via /dev/ptmx, obtain a
  * slave device and to check if it's possible to open it multiple times.
  */
diff --git a/testcases/kernel/pty/ptem05.c b/testcases/kernel/pty/ptem05.c
index 9357c469ca..7c4377c372 100644
--- a/testcases/kernel/pty/ptem05.c
+++ b/testcases/kernel/pty/ptem05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that it's possible to open a pseudo-terminal via /dev/ptmx, to obtain
  * a master + slave pair and to open them multiple times.
  */
diff --git a/testcases/kernel/pty/ptem06.c b/testcases/kernel/pty/ptem06.c
index 810b7c1d6a..6845b88fe1 100644
--- a/testcases/kernel/pty/ptem06.c
+++ b/testcases/kernel/pty/ptem06.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that it's possible to open a pseudo-terminal via /dev/ptmx, to obtain
  * a slave device and to set baudrate to B0 (which means hang up).
  */
diff --git a/testcases/kernel/pty/pty01.c b/testcases/kernel/pty/pty01.c
index d804a8d635..99f8d32d3d 100644
--- a/testcases/kernel/pty/pty01.c
+++ b/testcases/kernel/pty/pty01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that write/read is properly working when master and slave
  * pseudo terminals communicate with each other.
  */
diff --git a/testcases/kernel/pty/pty03.c b/testcases/kernel/pty/pty03.c
index 883a539d53..229aa13934 100644
--- a/testcases/kernel/pty/pty03.c
+++ b/testcases/kernel/pty/pty03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test based on Syzkaller reproducer:
  * https://syzkaller.appspot.com/bug?id=680c24ff647dd7241998e19da52e8136d2fd3523
  *
diff --git a/testcases/kernel/pty/pty06.c b/testcases/kernel/pty/pty06.c
index 4309163550..00cc6a9848 100644
--- a/testcases/kernel/pty/pty06.c
+++ b/testcases/kernel/pty/pty06.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test based on Syzkaller reproducer:
  * https://syzkaller.appspot.com/bug?extid=522643ab5729b0421998
  *
diff --git a/testcases/kernel/pty/pty07.c b/testcases/kernel/pty/pty07.c
index ebd5b16077..1a1c5871b7 100644
--- a/testcases/kernel/pty/pty07.c
+++ b/testcases/kernel/pty/pty07.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * The VT_DISALLOCATE ioctl can free a virtual console while VT_RESIZEX ioctl is
  * still running, causing a use-after-free in vt_ioctl(). Because VT_RESIZEX ioctl
  * have not make sure vc_cons[i].d is not NULL after grabbing console_lock().
diff --git a/testcases/kernel/pty/pty08.c b/testcases/kernel/pty/pty08.c
index 45e99d18ba..2b8f7152e2 100644
--- a/testcases/kernel/pty/pty08.c
+++ b/testcases/kernel/pty/pty08.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that slave pseudo-terminal fails reading/writing if master has been
  * closed.
  */
diff --git a/testcases/kernel/pty/pty09.c b/testcases/kernel/pty/pty09.c
index 1e477869b0..f3ade23818 100644
--- a/testcases/kernel/pty/pty09.c
+++ b/testcases/kernel/pty/pty09.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that slave pseudo-terminal can be opened multiple times in parallel.
  */
 
diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
index aa137eb67d..e52858f8e2 100644
--- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
+++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Creates a multi-level CGroup hierarchy with the cpu controller
  * enabled. The leaf groups are populated with "busy" processes which
  * simulate intermittent cpu load. They spin for some time then sleep
diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index 27bf77f393..045254ba41 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -2,8 +2,6 @@
 /* Copyright 2023 Mike Galbraith <efault-AT-gmx.de> */
 /* Copyright 2023 Wei Gao <wegao@suse.com> */
 /*\
- *
- * [Description]
  *
  * Thread starvation test. On fauluty kernel the test timeouts.
  *
diff --git a/testcases/kernel/sched/sysctl/proc_sched_rt01.c b/testcases/kernel/sched/sysctl/proc_sched_rt01.c
index 7c1aaccd96..df57ebcde9 100644
--- a/testcases/kernel/sched/sysctl/proc_sched_rt01.c
+++ b/testcases/kernel/sched/sysctl/proc_sched_rt01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Sanity tests for the /proc/sys/kernel/sched_r* files.
  *
  * - The sched_rt_period_us range is 1 to INT_MAX
diff --git a/testcases/kernel/security/aslr/aslr01.c b/testcases/kernel/security/aslr/aslr01.c
index 4d3c9bcdd4..6a396e29de 100644
--- a/testcases/kernel/security/aslr/aslr01.c
+++ b/testcases/kernel/security/aslr/aslr01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test that address space layout randomization (ASLR) is sufficiently random.
  * A bug in dynamic library mmapping may reduce ASLR randomness if the library
  * file is larger than hugepage size. In 32bit compat mode, this may
diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
index deb43aa6ac..64b187b35f 100644
--- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
+++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This is a regression test for a write race that allowed unprivileged programs
  * to change readonly files located on tmpfs/shmem on the system using
  * userfaultfd "minor fault handling" (CVE-2022-2590).
diff --git a/testcases/kernel/security/dirtypipe/dirtypipe.c b/testcases/kernel/security/dirtypipe/dirtypipe.c
index bc9197a903..981793e64d 100644
--- a/testcases/kernel/security/dirtypipe/dirtypipe.c
+++ b/testcases/kernel/security/dirtypipe/dirtypipe.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Proof-of-concept exploit for the Dirty Pipe
  * vulnerability (CVE-2022-0847) caused by an uninitialized
  * "pipe_buffer.flags" variable.  It demonstrates how to overwrite any
diff --git a/testcases/kernel/security/kallsyms/kallsyms.c b/testcases/kernel/security/kallsyms/kallsyms.c
index cf1390fb4d..45b3e18d4a 100644
--- a/testcases/kernel/security/kallsyms/kallsyms.c
+++ b/testcases/kernel/security/kallsyms/kallsyms.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Utilize kernel's symbol table for unauthorized address access.
  *
  * Access the system symbols with root permission to test whether it's
diff --git a/testcases/kernel/syscalls/abort/abort01.c b/testcases/kernel/syscalls/abort/abort01.c
index aa9ca3a2d8..05a92204e5 100644
--- a/testcases/kernel/syscalls/abort/abort01.c
+++ b/testcases/kernel/syscalls/abort/abort01.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Checks that process which called abort() gets killed by SIGIOT and dumps core.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/accept/accept01.c b/testcases/kernel/syscalls/accept/accept01.c
index e5db1dfecd..943af84242 100644
--- a/testcases/kernel/syscalls/accept/accept01.c
+++ b/testcases/kernel/syscalls/accept/accept01.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Verify that accept() returns the proper errno for various failure cases.
  */
 
diff --git a/testcases/kernel/syscalls/accept/accept02.c b/testcases/kernel/syscalls/accept/accept02.c
index 7cb3d69700..e50d2e7815 100644
--- a/testcases/kernel/syscalls/accept/accept02.c
+++ b/testcases/kernel/syscalls/accept/accept02.c
@@ -4,8 +4,6 @@
  * Author: Christian Amann <camann@suse.com>
  */
 /*\
- * [Description]
- *
  * Test for CVE-2017-8890
  *
  * In Kernels up to 4.10.15 missing commit 657831ff the multicast
diff --git a/testcases/kernel/syscalls/accept/accept03.c b/testcases/kernel/syscalls/accept/accept03.c
index b85ec0d9b5..bc472397dd 100644
--- a/testcases/kernel/syscalls/accept/accept03.c
+++ b/testcases/kernel/syscalls/accept/accept03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that accept() returns ENOTSOCK or EBADF for non-socket file
  * descriptors. The EBADF is returned in the case that the file descriptor has
  * not a file associated with it, which is for example in the case of O_PATH
diff --git a/testcases/kernel/syscalls/access/access01.c b/testcases/kernel/syscalls/access/access01.c
index 1c32c6d046..1da949b567 100644
--- a/testcases/kernel/syscalls/access/access01.c
+++ b/testcases/kernel/syscalls/access/access01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for access(2) using F_OK, R_OK, W_OK and X_OK
  */
 
diff --git a/testcases/kernel/syscalls/access/access02.c b/testcases/kernel/syscalls/access/access02.c
index c8fe0d0dca..67d7b70e3d 100644
--- a/testcases/kernel/syscalls/access/access02.c
+++ b/testcases/kernel/syscalls/access/access02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test access(2) syscall
  *
  * - check the existence or read/write/execute permissions on a file (mode argument: F_OK/R_OK/W_OK/X_OK)
diff --git a/testcases/kernel/syscalls/access/access03.c b/testcases/kernel/syscalls/access/access03.c
index 7cae1ec2ef..c42c062494 100644
--- a/testcases/kernel/syscalls/access/access03.c
+++ b/testcases/kernel/syscalls/access/access03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * access(2) test for errno(s) EFAULT as root and nobody respectively.
  */
 
diff --git a/testcases/kernel/syscalls/access/access04.c b/testcases/kernel/syscalls/access/access04.c
index b5764a5ddb..8a9ac5c36a 100644
--- a/testcases/kernel/syscalls/access/access04.c
+++ b/testcases/kernel/syscalls/access/access04.c
@@ -9,8 +9,6 @@
  */
 
 /*\
- * [Description]
- *
  * -  access() fails with -1 return value and sets errno to EINVAL
  *    if the specified access mode argument is invalid.
  * -  access() fails with -1 return value and sets errno to ENOENT
diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index 781d62261f..6249f6e2b8 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that acct() returns proper errno on failure.
  */
 
diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index 74019f4304..90555db9bf 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -5,8 +5,6 @@
  * Author: Christian Amann <camann@suse.com>
  */
 /*\
- * [Description]
- *
  * This tests if the kernel writes correct data to the
  * process accounting file.
  *
diff --git a/testcases/kernel/syscalls/adjtimex/adjtimex02.c b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
index 7f7fb643e5..836d49faf4 100644
--- a/testcases/kernel/syscalls/adjtimex/adjtimex02.c
+++ b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests for adjtimex() error conditions:
  *
  * - EPERM with SET_MODE as nobody
diff --git a/testcases/kernel/syscalls/adjtimex/adjtimex03.c b/testcases/kernel/syscalls/adjtimex/adjtimex03.c
index 9d34235e49..5521e4a3c3 100644
--- a/testcases/kernel/syscalls/adjtimex/adjtimex03.c
+++ b/testcases/kernel/syscalls/adjtimex/adjtimex03.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * CVE-2018-11508: Test 4-byte kernel data leak via adjtimex.
  *
  * On calling the adjtimex() function call with invalid mode (let's say
diff --git a/testcases/kernel/syscalls/alarm/alarm02.c b/testcases/kernel/syscalls/alarm/alarm02.c
index fcf70c5f32..4f012bb228 100644
--- a/testcases/kernel/syscalls/alarm/alarm02.c
+++ b/testcases/kernel/syscalls/alarm/alarm02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that alarm() returns:
  *
  * - zero when there was no previously scheduled alarm
diff --git a/testcases/kernel/syscalls/alarm/alarm03.c b/testcases/kernel/syscalls/alarm/alarm03.c
index b010e75401..7c98db070f 100644
--- a/testcases/kernel/syscalls/alarm/alarm03.c
+++ b/testcases/kernel/syscalls/alarm/alarm03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that alarms created by alarm() are not inherited by children
  * created via fork.
  */
diff --git a/testcases/kernel/syscalls/alarm/alarm05.c b/testcases/kernel/syscalls/alarm/alarm05.c
index 82bff69cbf..f8f6269171 100644
--- a/testcases/kernel/syscalls/alarm/alarm05.c
+++ b/testcases/kernel/syscalls/alarm/alarm05.c
@@ -9,8 +9,6 @@
  */
 
 /*\
- * [Description]
- *
  *  The return value of the alarm system call should be equal to the
  *  amount previously remaining in the alarm clock.
  *  A SIGALRM signal should be received after the specified amount of
diff --git a/testcases/kernel/syscalls/alarm/alarm06.c b/testcases/kernel/syscalls/alarm/alarm06.c
index 2cfa262076..76f4226f4f 100644
--- a/testcases/kernel/syscalls/alarm/alarm06.c
+++ b/testcases/kernel/syscalls/alarm/alarm06.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that any pending alarm() is canceled when seconds is zero.
  */
 
diff --git a/testcases/kernel/syscalls/alarm/alarm07.c b/testcases/kernel/syscalls/alarm/alarm07.c
index c04745f9df..8a1e500d1f 100644
--- a/testcases/kernel/syscalls/alarm/alarm07.c
+++ b/testcases/kernel/syscalls/alarm/alarm07.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that SIGALRM signal scheduled by alarm() in the parent process
  * is not delivered to the child process.
  */
diff --git a/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c b/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
index b98ef99d28..8ce905c6ce 100644
--- a/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
+++ b/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Simple test on arch_prctl to set and get cpuid instruction of test thread.
  */
 
diff --git a/testcases/kernel/syscalls/bind/bind02.c b/testcases/kernel/syscalls/bind/bind02.c
index 9f5f940e95..73ebd4aa12 100644
--- a/testcases/kernel/syscalls/bind/bind02.c
+++ b/testcases/kernel/syscalls/bind/bind02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Make sure bind() of privileged port gives EACCESS error for non-root users.
  */
 
diff --git a/testcases/kernel/syscalls/bpf/bpf_map01.c b/testcases/kernel/syscalls/bpf/bpf_map01.c
index 7f2264bf52..7fcf8e00fe 100644
--- a/testcases/kernel/syscalls/bpf/bpf_map01.c
+++ b/testcases/kernel/syscalls/bpf/bpf_map01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Trivial Extended Berkeley Packet Filter (eBPF) test.
  *
  * Sanity check creating and updating maps.
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog01.c b/testcases/kernel/syscalls/bpf/bpf_prog01.c
index b3846cb62c..44ee8c1c44 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog01.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Trivial Extended Berkeley Packet Filter (eBPF) test.
  *
  * Sanity check loading and running bytecode.
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog02.c b/testcases/kernel/syscalls/bpf/bpf_prog02.c
index 69314aea7f..8bc7996f5c 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog02.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check if eBPF can do arithmetic with 64bits. This targets a specific
  * regression which only effects unprivileged users who are subject to extra
  * pointer arithmetic checks during verification.
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog03.c b/testcases/kernel/syscalls/bpf/bpf_prog03.c
index 62432cc3fc..f37560c3b8 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog03.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * CVE-2017-16995
  *
  * Test for the bug fixed by kernel commit
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog04.c b/testcases/kernel/syscalls/bpf/bpf_prog04.c
index 5c61d34b4a..35ad8dd5f7 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog04.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * CVE 2018-18445
  *
  * Check that eBPF verifier correctly handles 32-bit arithmetic, in particular
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog05.c b/testcases/kernel/syscalls/bpf/bpf_prog05.c
index 0500817128..05cb34e13d 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog05.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog05.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Compare the effects of 32-bit div/mod by zero with the "expected"
  * behaviour.
  *
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog06.c b/testcases/kernel/syscalls/bpf/bpf_prog06.c
index 87fdd80603..f701e95990 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog06.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog06.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * ringbuf_submit takes a pointer to a ringbuf record, but not the
  * size of this record. The verifier only validates offset ptrs[1] passed
  * to functions if the function has a size parameter. So we can
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog07.c b/testcases/kernel/syscalls/bpf/bpf_prog07.c
index 29dfbf2cae..81435348aa 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog07.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog07.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * The verifier did not properly restrict some *_OR_NULL pointer
  * types. Including RET_PTR_TO_ALLOC_MEM_OR_NULL which is returned by
  * ringbuf_reserve. Somehow this means they can be used to perform
diff --git a/testcases/kernel/syscalls/brk/brk02.c b/testcases/kernel/syscalls/brk/brk02.c
index 64931bc809..201664e806 100644
--- a/testcases/kernel/syscalls/brk/brk02.c
+++ b/testcases/kernel/syscalls/brk/brk02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Expand brk() by at least 2 pages to ensure there is a newly created VMA
  * and not expanding the original due to multiple anon pages.  mprotect() that
  * new VMA then brk() back to the original address therefore causing a munmap of
diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
index 22f0071d1e..e218747d92 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat01.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that cachestat() syscall is properly counting cached pages
  * written inside a file. If storage device synchronization is requested, test
  * will check if the number of dirty pages is zero.
diff --git a/testcases/kernel/syscalls/cachestat/cachestat02.c b/testcases/kernel/syscalls/cachestat/cachestat02.c
index e168de5a53..72428ee839 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat02.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that cachestat() syscall is properly counting cached pages
  * written inside a shared memory.
  *
diff --git a/testcases/kernel/syscalls/cachestat/cachestat03.c b/testcases/kernel/syscalls/cachestat/cachestat03.c
index 139745c349..7c3abb3a0f 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat03.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that cachestat() syscall is properly failing with relative
  * error codes according to input parameters.
  *
diff --git a/testcases/kernel/syscalls/cachestat/cachestat04.c b/testcases/kernel/syscalls/cachestat/cachestat04.c
index 7cef9897d4..d33769bfcd 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat04.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies cachestat() for all the possible file descriptors,
  * checking that cache statistics are always zero, except for unsupported file
  * descriptors which cause EBADF to be raised.
diff --git a/testcases/kernel/syscalls/capset/capset01.c b/testcases/kernel/syscalls/capset/capset01.c
index 029fe7f3d5..a529ca9908 100644
--- a/testcases/kernel/syscalls/capset/capset01.c
+++ b/testcases/kernel/syscalls/capset/capset01.c
@@ -10,8 +10,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test capset() with with LINUX_CAPABILITY_VERSION_{1,2,3}.
  */
 
diff --git a/testcases/kernel/syscalls/capset/capset02.c b/testcases/kernel/syscalls/capset/capset02.c
index 989f3e4ce1..36d7996639 100644
--- a/testcases/kernel/syscalls/capset/capset02.c
+++ b/testcases/kernel/syscalls/capset/capset02.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Tests basic error handling of the capset syscall.
  *
  * 1. capset() fails with errno set to EFAULT if an invalid address
diff --git a/testcases/kernel/syscalls/capset/capset03.c b/testcases/kernel/syscalls/capset/capset03.c
index 2b83e6ce91..a75807ff49 100644
--- a/testcases/kernel/syscalls/capset/capset03.c
+++ b/testcases/kernel/syscalls/capset/capset03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * capset() fails with errno set or EPERM if the new_Inheritable is
  * not a subset of old_Inheritable and old_Permitted without CAP_SETPCAP.
  */
diff --git a/testcases/kernel/syscalls/capset/capset04.c b/testcases/kernel/syscalls/capset/capset04.c
index 13477a4a98..abe6f8fed8 100644
--- a/testcases/kernel/syscalls/capset/capset04.c
+++ b/testcases/kernel/syscalls/capset/capset04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test whether capset() can be used to modify the capabilities of a thread
  * other than itself. Now, most linux distributions with kernel supporting
  * VFS capabilities, this should be never permitted.
diff --git a/testcases/kernel/syscalls/chdir/chdir04.c b/testcases/kernel/syscalls/chdir/chdir04.c
index cdbb29668c..6e53b7fef1 100644
--- a/testcases/kernel/syscalls/chdir/chdir04.c
+++ b/testcases/kernel/syscalls/chdir/chdir04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to test whether chdir(2) sets errno correctly.
  */
 
diff --git a/testcases/kernel/syscalls/chmod/chmod01.c b/testcases/kernel/syscalls/chmod/chmod01.c
index b3b828ac32..8598acf1a9 100644
--- a/testcases/kernel/syscalls/chmod/chmod01.c
+++ b/testcases/kernel/syscalls/chmod/chmod01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that chmod(2) succeeds when used to change the mode permissions
  * of a file or directory.
  */
diff --git a/testcases/kernel/syscalls/chmod/chmod03.c b/testcases/kernel/syscalls/chmod/chmod03.c
index 3ceeae261a..d4056ac8cb 100644
--- a/testcases/kernel/syscalls/chmod/chmod03.c
+++ b/testcases/kernel/syscalls/chmod/chmod03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, chmod(2) will succeed to change the mode of a file or directory
  * and set the sticky bit on it if invoked by non-root (uid != 0)
  * process with the following constraints:
diff --git a/testcases/kernel/syscalls/chmod/chmod06.c b/testcases/kernel/syscalls/chmod/chmod06.c
index 93dd924c8e..7055f0da09 100644
--- a/testcases/kernel/syscalls/chmod/chmod06.c
+++ b/testcases/kernel/syscalls/chmod/chmod06.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, chmod(2) returns -1 and sets errno to
  *
  * 1. EPERM if the effective user id of process does not match the owner of the
diff --git a/testcases/kernel/syscalls/chmod/chmod08.c b/testcases/kernel/syscalls/chmod/chmod08.c
index ec448b4094..ab80e02fc4 100644
--- a/testcases/kernel/syscalls/chmod/chmod08.c
+++ b/testcases/kernel/syscalls/chmod/chmod08.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test verifies that chmod() is working correctly on symlink()
  * generated files.
  */
diff --git a/testcases/kernel/syscalls/chmod/chmod09.c b/testcases/kernel/syscalls/chmod/chmod09.c
index 898922513a..990600886e 100644
--- a/testcases/kernel/syscalls/chmod/chmod09.c
+++ b/testcases/kernel/syscalls/chmod/chmod09.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for kernel commit
  * 5d1f903f75a8 ("attr: block mode changes of symlinks")
  */
diff --git a/testcases/kernel/syscalls/chown/chown01.c b/testcases/kernel/syscalls/chown/chown01.c
index 0301309378..18406cf16a 100644
--- a/testcases/kernel/syscalls/chown/chown01.c
+++ b/testcases/kernel/syscalls/chown/chown01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for chown(). Calls chown() on a file and expects it to pass.
  */
 
diff --git a/testcases/kernel/syscalls/chown/chown02.c b/testcases/kernel/syscalls/chown/chown02.c
index 467185831c..000433da2d 100644
--- a/testcases/kernel/syscalls/chown/chown02.c
+++ b/testcases/kernel/syscalls/chown/chown02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that chown(2) invoked by super-user:
  *
  *  - clears setuid and setgid bits set on an executable file
diff --git a/testcases/kernel/syscalls/chown/chown03.c b/testcases/kernel/syscalls/chown/chown03.c
index b4ca3af732..dd0c9dd0f4 100644
--- a/testcases/kernel/syscalls/chown/chown03.c
+++ b/testcases/kernel/syscalls/chown/chown03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, chown(2) succeeds to change the group of a file specified
  * by path when called by non-root user with the following constraints:
  *
diff --git a/testcases/kernel/syscalls/chown/chown04.c b/testcases/kernel/syscalls/chown/chown04.c
index 4e91885674..f7a1513356 100644
--- a/testcases/kernel/syscalls/chown/chown04.c
+++ b/testcases/kernel/syscalls/chown/chown04.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that:
  *
  * 1. Chown() returns -1 and sets errno to EPERM if the effective user id
diff --git a/testcases/kernel/syscalls/chown/chown05.c b/testcases/kernel/syscalls/chown/chown05.c
index 44abdc7502..612d6c1ea7 100644
--- a/testcases/kernel/syscalls/chown/chown05.c
+++ b/testcases/kernel/syscalls/chown/chown05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, chown(2) succeeds to change the owner and group of a file
  * specified by path to any numeric owner(uid)/group(gid) values when invoked
  * by super-user.
diff --git a/testcases/kernel/syscalls/chroot/chroot01.c b/testcases/kernel/syscalls/chroot/chroot01.c
index 60f3f609c6..fa5172de51 100644
--- a/testcases/kernel/syscalls/chroot/chroot01.c
+++ b/testcases/kernel/syscalls/chroot/chroot01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to check the whether chroot sets errno to EPERM.
  *
  * As a non-root user attempt to perform chroot() to a directory. The
diff --git a/testcases/kernel/syscalls/chroot/chroot02.c b/testcases/kernel/syscalls/chroot/chroot02.c
index b01a876604..1b4fa2f4f1 100644
--- a/testcases/kernel/syscalls/chroot/chroot02.c
+++ b/testcases/kernel/syscalls/chroot/chroot02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic chroot() functionality test.
  *
  * - Create a file in the temporary directory
diff --git a/testcases/kernel/syscalls/chroot/chroot03.c b/testcases/kernel/syscalls/chroot/chroot03.c
index 87faec3162..4fe06ec1a8 100644
--- a/testcases/kernel/syscalls/chroot/chroot03.c
+++ b/testcases/kernel/syscalls/chroot/chroot03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to test whether chroot(2) sets errno correctly.
  *
  * - to test whether chroot() is setting ENAMETOOLONG if the
diff --git a/testcases/kernel/syscalls/chroot/chroot04.c b/testcases/kernel/syscalls/chroot/chroot04.c
index ed0f66323e..c0e7afce60 100644
--- a/testcases/kernel/syscalls/chroot/chroot04.c
+++ b/testcases/kernel/syscalls/chroot/chroot04.c
@@ -7,8 +7,6 @@
   */
 
 /*\
- * [Description]
- *
  * Testcase to check that chroot sets errno to EACCES.
  *
  * As a non-root user attempt to perform chroot() to a directory that the user
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
index b02d22a142..a4b231e693 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
@@ -4,8 +4,6 @@
  */
 
 /*
- * [Description]
- *
  * After a call to unshare(CLONE_NEWTIME) a new timer namespace is created, the
  * process that has called the unshare() can adjust offsets for CLOCK_MONOTONIC
  * and CLOCK_BOOTTIME for its children by writing to the '/proc/self/timens_offsets'.
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
index c279da79e0..5dce24c7a7 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check time difference between successive readings and report a bug if
  * difference found to be over 5 ms.
  *
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
index dfc5222789..1b097a60fc 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test that clock_nanosleep() adds correctly an offset with absolute timeout
  * and CLOCK_MONOTONIC inside of a timer namespace.
  *
diff --git a/testcases/kernel/syscalls/clone/clone01.c b/testcases/kernel/syscalls/clone/clone01.c
index 7e3f15671b..cbe646e676 100644
--- a/testcases/kernel/syscalls/clone/clone01.c
+++ b/testcases/kernel/syscalls/clone/clone01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic clone() test.
  *
  * Use clone() to create a child process, and wait for the child process to exit,
diff --git a/testcases/kernel/syscalls/clone/clone03.c b/testcases/kernel/syscalls/clone/clone03.c
index 2c912b9dc6..8c343b2cc5 100644
--- a/testcases/kernel/syscalls/clone/clone03.c
+++ b/testcases/kernel/syscalls/clone/clone03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check for equality of getpid() from a child and return value of clone(2)
  */
 
diff --git a/testcases/kernel/syscalls/clone/clone04.c b/testcases/kernel/syscalls/clone/clone04.c
index 74347e2b47..30edeaeb0d 100644
--- a/testcases/kernel/syscalls/clone/clone04.c
+++ b/testcases/kernel/syscalls/clone/clone04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that clone(2) fails with
  *
  * - EINVAL if child stack is set to NULL
diff --git a/testcases/kernel/syscalls/clone/clone05.c b/testcases/kernel/syscalls/clone/clone05.c
index 892a848bed..56d2f8bbad 100644
--- a/testcases/kernel/syscalls/clone/clone05.c
+++ b/testcases/kernel/syscalls/clone/clone05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Call clone() with CLONE_VFORK flag set. verify that
  * execution of parent is suspended until child finishes
  */
diff --git a/testcases/kernel/syscalls/clone/clone06.c b/testcases/kernel/syscalls/clone/clone06.c
index b32f17d93f..412ebb7a34 100644
--- a/testcases/kernel/syscalls/clone/clone06.c
+++ b/testcases/kernel/syscalls/clone/clone06.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test to verify inheritance of environment variables by child.
  */
 
diff --git a/testcases/kernel/syscalls/clone/clone07.c b/testcases/kernel/syscalls/clone/clone07.c
index 8848b2b444..9ff53658ae 100644
--- a/testcases/kernel/syscalls/clone/clone07.c
+++ b/testcases/kernel/syscalls/clone/clone07.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for a libc bug where exiting child function by returning from
  * it caused SIGSEGV.
  */
diff --git a/testcases/kernel/syscalls/clone3/clone301.c b/testcases/kernel/syscalls/clone3/clone301.c
index d0fadbc5d0..deed30b9f0 100644
--- a/testcases/kernel/syscalls/clone3/clone301.c
+++ b/testcases/kernel/syscalls/clone3/clone301.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic clone3() test.
  */
 
diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel/syscalls/clone3/clone302.c
index 48b831554c..9e98f19545 100644
--- a/testcases/kernel/syscalls/clone3/clone302.c
+++ b/testcases/kernel/syscalls/clone3/clone302.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic clone3() test to check various failures.
  */
 
diff --git a/testcases/kernel/syscalls/clone3/clone303.c b/testcases/kernel/syscalls/clone3/clone303.c
index 04c41942a0..7e5f3adb3c 100644
--- a/testcases/kernel/syscalls/clone3/clone303.c
+++ b/testcases/kernel/syscalls/clone3/clone303.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test case check clone3 CLONE_INTO_CGROUP flag
  *
  */
diff --git a/testcases/kernel/syscalls/close/close01.c b/testcases/kernel/syscalls/close/close01.c
index f2d30a693a..4e4f107ef9 100644
--- a/testcases/kernel/syscalls/close/close01.c
+++ b/testcases/kernel/syscalls/close/close01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test that closing a file/pipe/socket works correctly.
  */
 
diff --git a/testcases/kernel/syscalls/close/close02.c b/testcases/kernel/syscalls/close/close02.c
index d317cc63b6..2016453f8a 100644
--- a/testcases/kernel/syscalls/close/close02.c
+++ b/testcases/kernel/syscalls/close/close02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Call close(-1) and expects it to return EBADF.
  */
 
diff --git a/testcases/kernel/syscalls/close_range/close_range01.c b/testcases/kernel/syscalls/close_range/close_range01.c
index 941f3e4038..60e63325b6 100644
--- a/testcases/kernel/syscalls/close_range/close_range01.c
+++ b/testcases/kernel/syscalls/close_range/close_range01.c
@@ -10,8 +10,6 @@
  * Copyright (c) 2021 SUSE LLC, other copyrights may apply.
  */
 /*\
- * [Description]
- *
  * We check that close_range()
  *
  * - closes FDs
diff --git a/testcases/kernel/syscalls/close_range/close_range02.c b/testcases/kernel/syscalls/close_range/close_range02.c
index 48d9a31df4..f9b0cc5a0f 100644
--- a/testcases/kernel/syscalls/close_range/close_range02.c
+++ b/testcases/kernel/syscalls/close_range/close_range02.c
@@ -3,8 +3,6 @@
  * Copyright (c) 2021 SUSE LLC
  */
 /*\
- * [Description]
- *
  * - First check close_range works on a valid range.
  * - Then check close_range does not accept invalid paramters.
  * - Then check it accepts a large lower fd.
diff --git a/testcases/kernel/syscalls/cma/process_vm01.c b/testcases/kernel/syscalls/cma/process_vm01.c
index 014fd6fffe..730ae67e7c 100644
--- a/testcases/kernel/syscalls/cma/process_vm01.c
+++ b/testcases/kernel/syscalls/cma/process_vm01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test errno codes in process_vm_readv and process_vm_writev syscalls.
  */
 
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index 2bd66a49fd..1e2ac38fac 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Fork two children, one child allocates memory and initializes it;
  * then the other one calls process_vm_readv and reads from the same
  * memory location, it then verifies if process_vm_readv returns
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index 4caafe8670..95d35c4226 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Fork two children, one child mallocs randomly sized trunks of memory
  * and initializes them; the other child calls process_vm_readv with
  * the remote iovecs initialized to the original process memory
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index 991110d24a..aaf4c0b186 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Fork two children, the first one allocates a chunk of memory and the
  * other one call process_vm_writev to write known data into the first
  * child. Then first child verifies that the data is as expected.
diff --git a/testcases/kernel/syscalls/confstr/confstr01.c b/testcases/kernel/syscalls/confstr/confstr01.c
index d5cb5a4776..103b852655 100644
--- a/testcases/kernel/syscalls/confstr/confstr01.c
+++ b/testcases/kernel/syscalls/confstr/confstr01.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test confstr(3) 700 (X/Open 7) functionality -- POSIX 2008.
  */
 
diff --git a/testcases/kernel/syscalls/creat/creat08.c b/testcases/kernel/syscalls/creat/creat08.c
index 011753ac5c..ab537de986 100644
--- a/testcases/kernel/syscalls/creat/creat08.c
+++ b/testcases/kernel/syscalls/creat/creat08.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that the group ID and setgid bit are set correctly when a new file
  * is created.
  */
diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
index d181657728..ac46c940c7 100644
--- a/testcases/kernel/syscalls/creat/creat09.c
+++ b/testcases/kernel/syscalls/creat/creat09.c
@@ -3,8 +3,6 @@
  * Copyright (c) 2021 SUSE LLC <mdoucha@suse.cz>
  */
 /*\
- * [Description]
- *
  * CVE-2018-13405
  *
  * Check for possible privilege escalation through creating files with setgid
diff --git a/testcases/kernel/syscalls/delete_module/delete_module01.c b/testcases/kernel/syscalls/delete_module/delete_module01.c
index bcaa0763de..a64c1b63e8 100644
--- a/testcases/kernel/syscalls/delete_module/delete_module01.c
+++ b/testcases/kernel/syscalls/delete_module/delete_module01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for delete_module(2).
  *
  * Install dummy_del_mod.ko and delete it with delete_module(2).
diff --git a/testcases/kernel/syscalls/dup/dup01.c b/testcases/kernel/syscalls/dup/dup01.c
index f5cd058e8b..7a1da27247 100644
--- a/testcases/kernel/syscalls/dup/dup01.c
+++ b/testcases/kernel/syscalls/dup/dup01.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that dup(2) syscall executes successfully and allocates
  * a new file descriptor which refers to the same open file as oldfd.
  */
diff --git a/testcases/kernel/syscalls/dup/dup02.c b/testcases/kernel/syscalls/dup/dup02.c
index 5391738a44..b6e270ab77 100644
--- a/testcases/kernel/syscalls/dup/dup02.c
+++ b/testcases/kernel/syscalls/dup/dup02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that dup(2) syscall fails with errno EBADF when called with
  * invalid value for oldfd argument.
  */
diff --git a/testcases/kernel/syscalls/dup/dup03.c b/testcases/kernel/syscalls/dup/dup03.c
index d59e61f2b1..1d9919ebf8 100644
--- a/testcases/kernel/syscalls/dup/dup03.c
+++ b/testcases/kernel/syscalls/dup/dup03.c
@@ -5,8 +5,6 @@
  *
  */
 /*\
- * [Description]
- *
  * Verify that dup(2) syscall fails with errno EMFILE when the per-process
  * limit on the number of open file descriptors has been reached.
  */
diff --git a/testcases/kernel/syscalls/dup/dup04.c b/testcases/kernel/syscalls/dup/dup04.c
index 053fb40c21..4869f43714 100644
--- a/testcases/kernel/syscalls/dup/dup04.c
+++ b/testcases/kernel/syscalls/dup/dup04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for dup(2) of a system pipe descriptor.
  */
 
diff --git a/testcases/kernel/syscalls/dup/dup05.c b/testcases/kernel/syscalls/dup/dup05.c
index 619b4861ea..e2bc9a4a3a 100644
--- a/testcases/kernel/syscalls/dup/dup05.c
+++ b/testcases/kernel/syscalls/dup/dup05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for dup(2) of a named pipe descriptor.
  */
 
diff --git a/testcases/kernel/syscalls/dup/dup06.c b/testcases/kernel/syscalls/dup/dup06.c
index cd4cb35137..accc32d605 100644
--- a/testcases/kernel/syscalls/dup/dup06.c
+++ b/testcases/kernel/syscalls/dup/dup06.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for dup(2) syscall with max open file descriptors.
  */
 
diff --git a/testcases/kernel/syscalls/dup/dup07.c b/testcases/kernel/syscalls/dup/dup07.c
index 688ee19896..aa91d5d55a 100644
--- a/testcases/kernel/syscalls/dup/dup07.c
+++ b/testcases/kernel/syscalls/dup/dup07.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that the file descriptor created by dup(2) syscall has the same
  * access mode as the old one.
  */
diff --git a/testcases/kernel/syscalls/dup2/dup201.c b/testcases/kernel/syscalls/dup2/dup201.c
index d851eea78f..9d2c7eb3fc 100644
--- a/testcases/kernel/syscalls/dup2/dup201.c
+++ b/testcases/kernel/syscalls/dup2/dup201.c
@@ -5,8 +5,6 @@
  * 01/2002 Removed EMFILE test - Paul Larson
  */
 /*\
- * [Description]
- *
  * Negative tests for dup2() with bad fd (EBADF).
  *
  * - First fd argument is less than 0
diff --git a/testcases/kernel/syscalls/dup2/dup202.c b/testcases/kernel/syscalls/dup2/dup202.c
index 659f3a4ecd..b4dcd19510 100644
--- a/testcases/kernel/syscalls/dup2/dup202.c
+++ b/testcases/kernel/syscalls/dup2/dup202.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test whether the access mode are the same for both file descriptors.
  *
  * Create file with mode, dup2, [change mode], check mode
diff --git a/testcases/kernel/syscalls/dup2/dup203.c b/testcases/kernel/syscalls/dup2/dup203.c
index c8d1095f38..384662eee1 100644
--- a/testcases/kernel/syscalls/dup2/dup203.c
+++ b/testcases/kernel/syscalls/dup2/dup203.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to check the basic functionality of dup2().
  *
  * - Attempt to dup2() on an open file descriptor.
diff --git a/testcases/kernel/syscalls/dup2/dup204.c b/testcases/kernel/syscalls/dup2/dup204.c
index 112ce0c9da..dbb0233a85 100644
--- a/testcases/kernel/syscalls/dup2/dup204.c
+++ b/testcases/kernel/syscalls/dup2/dup204.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test whether the inode number are the same for both file descriptors.
  */
 
diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
index fa7b27d96c..b95a9212bc 100644
--- a/testcases/kernel/syscalls/dup2/dup205.c
+++ b/testcases/kernel/syscalls/dup2/dup205.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Negative test for dup2() with max open file descriptors.
  */
 
diff --git a/testcases/kernel/syscalls/dup2/dup206.c b/testcases/kernel/syscalls/dup2/dup206.c
index 17d527a1ec..549d3a9fdb 100644
--- a/testcases/kernel/syscalls/dup2/dup206.c
+++ b/testcases/kernel/syscalls/dup2/dup206.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * If oldfd is a valid file descriptor, and newfd has the same value as oldfd,
  * then dup2() does nothing, and returns newfd.
  */
diff --git a/testcases/kernel/syscalls/dup2/dup207.c b/testcases/kernel/syscalls/dup2/dup207.c
index f1b184f5b2..c6c6cb480f 100644
--- a/testcases/kernel/syscalls/dup2/dup207.c
+++ b/testcases/kernel/syscalls/dup2/dup207.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test whether the file offset are the same for both file descriptors.
  */
 
diff --git a/testcases/kernel/syscalls/dup3/dup3_01.c b/testcases/kernel/syscalls/dup3/dup3_01.c
index 517491d44e..3f27b1c7ef 100644
--- a/testcases/kernel/syscalls/dup3/dup3_01.c
+++ b/testcases/kernel/syscalls/dup3/dup3_01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to check whether dup3() supports O_CLOEXEC flag.
  */
 
diff --git a/testcases/kernel/syscalls/dup3/dup3_02.c b/testcases/kernel/syscalls/dup3/dup3_02.c
index 009b0037df..a618b3e98b 100644
--- a/testcases/kernel/syscalls/dup3/dup3_02.c
+++ b/testcases/kernel/syscalls/dup3/dup3_02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for various EINVAL error.
  *
  * - oldfd is equal to newfd without using O_CLOEXEC flag
diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create01.c b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
index 443554fe09..2e8e813d76 100644
--- a/testcases/kernel/syscalls/epoll_create/epoll_create01.c
+++ b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that epoll_create return a nonnegative file descriptor on success.
  *
  * The size argument informed the kernel of the number of file descriptors
diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create02.c b/testcases/kernel/syscalls/epoll_create/epoll_create02.c
index 942d7afd35..2ec8e925c6 100644
--- a/testcases/kernel/syscalls/epoll_create/epoll_create02.c
+++ b/testcases/kernel/syscalls/epoll_create/epoll_create02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that epoll_create returns -1 and set errno to EINVAL if size is not
  * greater than zero.
  */
diff --git a/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c b/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
index 6d2bf2a30d..9e43f4d4ec 100644
--- a/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
+++ b/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that epoll_create1 sets the close-on-exec flag for the returned
  * file descriptor with EPOLL_CLOEXEC.
  */
diff --git a/testcases/kernel/syscalls/epoll_create1/epoll_create1_02.c b/testcases/kernel/syscalls/epoll_create1/epoll_create1_02.c
index 74c311694f..3a2ac988af 100644
--- a/testcases/kernel/syscalls/epoll_create1/epoll_create1_02.c
+++ b/testcases/kernel/syscalls/epoll_create1/epoll_create1_02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that epoll_create1 returns -1 and set errno to EINVAL with an invalid
  * value specified in flags.
  */
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
index 298ed89cb2..bd0a2260f8 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check the basic functionality of the epoll_ctl:
  *
  * - When epoll_ctl succeeds to register fd on the epoll instance and associates
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
index dcf74bf770..a17148f174 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that epoll_ctl() fails with:
  *
  * - EBADF if epfd is an invalid fd.
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c
index f617295cc1..e8d3d5f369 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that epoll_ctl returns zero with different combinations of events on
  * success.
  */
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c
index bc015c01bc..955959b6b2 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that the maximum number of nesting allowed inside epoll sets is 5,
  * otherwise epoll_ctl fails with EINVAL.
  */
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl05.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl05.c
index 71e300daa2..fc59ef2563 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl05.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that epoll_ctl() fails with ELOOP if fd refers to an epoll instance
  * and this EPOLL_CTL_ADD operation would result in a circular loop of epoll
  * instances monitoring one another.
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
index f3ca894fb1..954e773149 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for epoll_pwait() and epoll_pwait2().
  *
  * - With a sigmask a signal is ignored and the syscall safely waits until
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
index 3341a2b09b..069620c5d8 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for epoll_pwait and epoll_pwait2. Checks if data avaiable in a
  * file descriptor are reported correctly in the syscall return value.
  */
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
index 94b785b1a5..8217f9f800 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that epoll_pwait and epoll_pwait2 timeouts correctly.
  */
 
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
index a75751db93..cc1d04e6ba 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, epoll_pwait() and epoll_pwait2() return -1 and set errno to
  * EFAULT with a sigmask points outside user's accessible address space.
  */
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c
index b75a995396..9ac5e82604 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, epoll_pwait2() return -1 and set errno to EINVAL with an
  * invalid timespec.
  */
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
index 4f84384880..2485be513f 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for epoll_wait. Check that epoll_wait works for EPOLLOUT and
  * EPOLLIN events on an epoll instance and that struct epoll_event is set
  * correctly.
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
index 93ada1cf3e..9b6e932bba 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that epoll_wait(2) timeouts correctly.
  */
 
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait03.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait03.c
index d31e498644..e55d65ca88 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait03.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for epoll_wait:
  *
  * - epoll_wait fails with EBADF if epfd is not a valid file descriptor.
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
index bd8baca220..5c4a545471 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that a timeout equal to zero causes epoll_wait() to return immediately.
  */
 
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
index d06a024ffc..33d08c0c7f 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that epoll receives EPOLLRDHUP event when we hang a reading
  * half-socket we are polling on.
  */
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
index f35e0423ae..0bf8a29dad 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that edge triggering is correctly handled by epoll, for both EPOLLIN
  * and EPOLLOUT.
  *
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
index dfabd0d878..329bf2a5cf 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait07.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that EPOLLONESHOT is correctly handled by epoll_wait.
  * We open a channel, write in it two times and verify that EPOLLIN has been
  * received only once.
diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
index b66d6a55c4..4fe209a139 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd01.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify read operation for eventfd fail with:
  *
  * - EAGAIN when counter is zero on non blocking fd
diff --git a/testcases/kernel/syscalls/eventfd/eventfd02.c b/testcases/kernel/syscalls/eventfd/eventfd02.c
index f028961c73..7691b165ad 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd02.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify write operation for eventfd fail with:
  *
  * - EAGAIN when counter is zero on non blocking fd
diff --git a/testcases/kernel/syscalls/eventfd/eventfd03.c b/testcases/kernel/syscalls/eventfd/eventfd03.c
index 452264cad2..31761a4499 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd03.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd03.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test whether readfd is set by select() when eventfd() counter value is
  * non-zero, then check if readfd is not set when eventfd() counter value is
  * zero.
diff --git a/testcases/kernel/syscalls/eventfd/eventfd04.c b/testcases/kernel/syscalls/eventfd/eventfd04.c
index c7186ae64f..4ee67d308a 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd04.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd04.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test whether writefd is set by select() when eventfd() counter value is
  * not the maximum value, then check if writefd is not set when eventfd()
  * counter value is maximum value.
diff --git a/testcases/kernel/syscalls/eventfd/eventfd05.c b/testcases/kernel/syscalls/eventfd/eventfd05.c
index 6ea2c4138a..76806c6b53 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd05.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd05.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test whether eventfd() counter update in child is reflected in the parent.
  */
 
diff --git a/testcases/kernel/syscalls/eventfd/eventfd06.c b/testcases/kernel/syscalls/eventfd/eventfd06.c
index 46d7f73d3a..0ac48b2c84 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd06.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd06.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test whether counter overflow is detected and handled correctly.
  *
  * It is not possible to directly overflow the counter using the
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
index 3a80379a39..9c63891cb4 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that eventfd2 correctly set FD_CLOEXEC flag on file when
  * EFD_CLOEXEC flag is used.
  */
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
index 430cdb33cc..4d837804da 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that eventfd2 correctly set O_NONBLOCK flag on file when
  * EFD_NONBLOCK flag is used.
  */
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
index e1949fd323..058e5734fb 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that eventfd2 semaphore-like support is properly working.
  */
 
diff --git a/testcases/kernel/syscalls/execve/execve04.c b/testcases/kernel/syscalls/execve/execve04.c
index 7bbfece859..7b475dd1af 100644
--- a/testcases/kernel/syscalls/execve/execve04.c
+++ b/testcases/kernel/syscalls/execve/execve04.c
@@ -9,8 +9,6 @@
  */
 
 /*\
- * [Description]
- *
  * Attempt to execve(2) a file which is being opened by another process for
  * writing fails with ETXTBSY.
  */
diff --git a/testcases/kernel/syscalls/execve/execve05.c b/testcases/kernel/syscalls/execve/execve05.c
index 530c7cc890..ec0fc102a3 100644
--- a/testcases/kernel/syscalls/execve/execve05.c
+++ b/testcases/kernel/syscalls/execve/execve05.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * This tests the functionality of the execve(2) system call by spawning
  * a few children, each of which would execute "execve_child" simultaneously,
  * and finally the parent ensures that they terminated correctly.
diff --git a/testcases/kernel/syscalls/execve/execve06.c b/testcases/kernel/syscalls/execve/execve06.c
index a000892655..f0ce990d6f 100644
--- a/testcases/kernel/syscalls/execve/execve06.c
+++ b/testcases/kernel/syscalls/execve/execve06.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test that kernel adds dummy argv[0] if empty argument list was passed to
  * execve(). This fixes at least one CVE where userspace programs start to
  * process argument list blindly from argv[1] such as polkit pkexec
diff --git a/testcases/kernel/syscalls/exit_group/exit_group01.c b/testcases/kernel/syscalls/exit_group/exit_group01.c
index 6407a20e8f..585bb7cdb4 100644
--- a/testcases/kernel/syscalls/exit_group/exit_group01.c
+++ b/testcases/kernel/syscalls/exit_group/exit_group01.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test checks if exit_group() correctly ends a spawned child and all its
  * running threads.
  */
diff --git a/testcases/kernel/syscalls/faccessat/faccessat01.c b/testcases/kernel/syscalls/faccessat/faccessat01.c
index 6be2b4bb73..2c54fe2bd1 100644
--- a/testcases/kernel/syscalls/faccessat/faccessat01.c
+++ b/testcases/kernel/syscalls/faccessat/faccessat01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check the basic functionality of the faccessat() system call.
  *
  * - faccessat() passes if dir_fd is file descriptor to the directory
diff --git a/testcases/kernel/syscalls/faccessat/faccessat02.c b/testcases/kernel/syscalls/faccessat/faccessat02.c
index 1add695c1f..3f79a25948 100644
--- a/testcases/kernel/syscalls/faccessat/faccessat02.c
+++ b/testcases/kernel/syscalls/faccessat/faccessat02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * - faccessat() fails with ENOTDIR if dir_fd is file descriptor to the file
  *   and pathname is relative path of the file.
  *
diff --git a/testcases/kernel/syscalls/faccessat2/faccessat201.c b/testcases/kernel/syscalls/faccessat2/faccessat201.c
index 1be6e9aa06..0fa807e394 100644
--- a/testcases/kernel/syscalls/faccessat2/faccessat201.c
+++ b/testcases/kernel/syscalls/faccessat2/faccessat201.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check the basic functionality of faccessat2().
  *
  * Minimum Linux version required is v5.8.
diff --git a/testcases/kernel/syscalls/faccessat2/faccessat202.c b/testcases/kernel/syscalls/faccessat2/faccessat202.c
index a60db2bf81..0878457eb7 100644
--- a/testcases/kernel/syscalls/faccessat2/faccessat202.c
+++ b/testcases/kernel/syscalls/faccessat2/faccessat202.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test basic error handling of faccessat2 syscall:
  *
  * - faccessat2() fails with EFAULT if pathname is a bad pathname point.
diff --git a/testcases/kernel/syscalls/fallocate/fallocate03.c b/testcases/kernel/syscalls/fallocate/fallocate03.c
index b3e6b38172..dc15b8764e 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate03.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate03.c
@@ -8,7 +8,6 @@
  */
 
 /*\
- * [Description]
  * Test fallocate() on sparse file for different offsets, with a total of 8 test cases
  */
 
diff --git a/testcases/kernel/syscalls/fallocate/fallocate06.c b/testcases/kernel/syscalls/fallocate/fallocate06.c
index 0e1509ace6..3730bddc0b 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate06.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate06.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests misaligned fallocate()
  *
  * Test scenario:
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index c7e759166d..fa0d5e84ad 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Check that fanotify work for a file.
  */
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
index 19854064a6..34c77967f7 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify02.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Check that fanotify work for children of a directory.
  */
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 64c933c190..6a0042fd42 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Check that fanotify permission events work.
  */
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
index 378bc57c0d..9625e6f9be 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify04.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Check various fanotify special flags.
  */
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index f43332fedf..5eddb5d77d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Check that fanotify overflow event is properly generated.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index b4992afa0f..2e93840f0f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Check that fanotify properly merges ignore mask of an inode and mountpoint.
  */
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index 34aa810c7d..7734b1858d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Check that fanotify permission events are handled properly on instance destruction.
  */
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify08.c b/testcases/kernel/syscalls/fanotify/fanotify08.c
index 405965f7f7..abbf0b8a75 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify08.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify08.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Sanity check fanotify_init flag FAN_CLOEXEC by fcntl.
  */
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 45303c31e7..2ed3d1eb7b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Check that fanotify handles events on children correctly when both parent and
  * subdir or mountpoint marks exist.
  */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 23e9554b39..ccb4f55df3 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -8,7 +8,6 @@
  */
 
 /*\
- * [Description]
  * Check that fanotify properly merges ignore mask of a mount mark
  * with a mask of an inode mark on the same group.  Unlike the
  * prototype test fanotify06, do not use FAN_MODIFY event for the
diff --git a/testcases/kernel/syscalls/fanotify/fanotify11.c b/testcases/kernel/syscalls/fanotify/fanotify11.c
index ce46913b17..594d5f9daf 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify11.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify11.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * After fanotify_init adds flags FAN_REPORT_TID,
  * check whether the program can accurately identify which thread id
  * in the multithreaded program triggered the event.
diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
index 60ba27e168..e5624835a8 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify12.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Validate that the newly introduced FAN_OPEN_EXEC mask functions as expected.
  * The idea is to generate a sequence of open related actions to ensure that
  * the correct event flags are being set depending on what event mask was
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 840018fa7f..32b2b8238b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Validate that the values returned within an event when FAN_REPORT_FID is
  * specified matches those that are obtained via explicit invocation to system
  * calls statfs(2) and name_to_handle_at(2).
diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index b17bffd184..a00ca9758d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -7,7 +7,6 @@
  */
 
 /*\
- * [Description]
  * This test file has been designed to ensure that the fanotify
  * system calls fanotify_init(2) and fanotify_mark(2) return the
  * correct error code to the calling process when an invalid flag or
diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index bacf05049f..2218dd6669 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -7,7 +7,6 @@
  */
 
 /*\
- * [Description]
  * Test file that has been purposely designed to verify FAN_REPORT_FID
  * functionality while using newly defined dirent events.
  */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index 6ab3609849..d4ad65bceb 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Check fanotify directory entry modification events, events on child and
  * on self with group init flags:
  *
diff --git a/testcases/kernel/syscalls/fanotify/fanotify17.c b/testcases/kernel/syscalls/fanotify/fanotify17.c
index 3ecb31b6e7..f6e282e7fc 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify17.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify17.c
@@ -8,7 +8,6 @@
  */
 
 /*\
- * [Description]
  * Check that fanotify groups and marks limits are enforced correctly.
  * If user ns is supported, verify that global limit and per user ns
  * limits are both enforced.
diff --git a/testcases/kernel/syscalls/fanotify/fanotify18.c b/testcases/kernel/syscalls/fanotify/fanotify18.c
index 07b064b921..4fd9974601 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify18.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify18.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * This set of tests is to ensure that the unprivileged listener feature of
  * fanotify is functioning as expected. The objective this test case file
  * is to validate whether any forbidden flags that are passed by an
diff --git a/testcases/kernel/syscalls/fanotify/fanotify19.c b/testcases/kernel/syscalls/fanotify/fanotify19.c
index 63fc4ee0c0..80790955f1 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify19.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify19.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * This set of tests is to ensure that the unprivileged listener feature of
  * fanotify is functioning as expected. The objective of this test file is
  * to generate a sequence of events and ensure that the returned events
diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index 1d249ac9cf..82d2049255 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * This source file contains a test case which ensures that the fanotify API
  * returns an expected error code when provided an invalid initialization flag
  * alongside FAN_REPORT_PIDFD. Additionally, it checks that the operability with
diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 8765767f20..c95895c93a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * A test which verifies whether the returned struct
  * fanotify_event_info_pidfd in FAN_REPORT_PIDFD mode contains the
  * expected set of information.
diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index 1c72101369..2fbb6fa404 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -7,7 +7,6 @@
  */
 
 /*\
- * [Description]
  * Check fanotify FAN_ERROR_FS events triggered by intentionally
  * corrupted filesystems:
  *
diff --git a/testcases/kernel/syscalls/fanotify/fanotify23.c b/testcases/kernel/syscalls/fanotify/fanotify23.c
index 957eba19a5..896a8a850a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify23.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify23.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Check evictable fanotify inode marks.
  */
 
diff --git a/testcases/kernel/syscalls/fchmod/fchmod01.c b/testcases/kernel/syscalls/fchmod/fchmod01.c
index 417ea0a70c..e23dcded89 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod01.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that fchmod() can succeed to change the mode permissions of a file specified
  * by file descriptor.
  */
diff --git a/testcases/kernel/syscalls/fchmod/fchmod02.c b/testcases/kernel/syscalls/fchmod/fchmod02.c
index d6abeffce8..e25739bcf6 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod02.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, fchmod(2) will succeed to change the mode of a file/directory
  * set the sticky bit on it if invoked by root (uid = 0) process with
  * the following constraints:
diff --git a/testcases/kernel/syscalls/fchmod/fchmod03.c b/testcases/kernel/syscalls/fchmod/fchmod03.c
index bdd720c37b..028ec15575 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod03.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, fchmod(2) will succeed to change the mode of a file
  * and set the sticky bit on it if invoked by non-root (uid != 0)
  * process with the following constraints:
diff --git a/testcases/kernel/syscalls/fchmod/fchmod04.c b/testcases/kernel/syscalls/fchmod/fchmod04.c
index 4fa69e2270..5276870250 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod04.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, fchmod(2) will succeed to change the mode of a directory
  * and set the sticky bit on it if invoked by non-root (uid != 0) process
  * with the following constraints:
diff --git a/testcases/kernel/syscalls/fchmod/fchmod05.c b/testcases/kernel/syscalls/fchmod/fchmod05.c
index 9b29cea20b..0489cb6a89 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod05.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, fchmod(2) will succeed to change the mode of a directory
  * but fails to set the setgid bit on it if invoked by non-root (uid != 0)
  * process with the following constraints:
diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index 7ca65648fd..672fbff5f4 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check the basic functionality of the fchmodat() system call.
  *
  * - fchmodat() passes if dir_fd is file descriptor to the directory
diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat02.c b/testcases/kernel/syscalls/fchmodat/fchmodat02.c
index 117865a8f9..b871546301 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat02.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests basic error handling of the fchmodat() syscall.
  *
  * - fchmodat() fails with ENOTDIR if dir_fd is file descriptor
diff --git a/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
index e58be31c42..dcf67cd5ef 100644
--- a/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
+++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that fchmodat2() syscall is properly working with
  * regular files, symbolic links and directories. AT_SYMLINK_NOFOLLOW is a
  * special feature that is blocked by VFS since 5d1f903f75a8 and any of its
diff --git a/testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c b/testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c
index f8497d8a84..0da65f40a2 100644
--- a/testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c
+++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that fchmodat2() syscall properly raises errors with
  * invalid values.
  */
diff --git a/testcases/kernel/syscalls/fchown/fchown01.c b/testcases/kernel/syscalls/fchown/fchown01.c
index 4ab5a2f38a..946cff0c9d 100644
--- a/testcases/kernel/syscalls/fchown/fchown01.c
+++ b/testcases/kernel/syscalls/fchown/fchown01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for fchown(). Call fchown() on a fd and expect it to pass.
  */
 
diff --git a/testcases/kernel/syscalls/fchown/fchown02.c b/testcases/kernel/syscalls/fchown/fchown02.c
index bd1baf3bb7..6d6c4c170a 100644
--- a/testcases/kernel/syscalls/fchown/fchown02.c
+++ b/testcases/kernel/syscalls/fchown/fchown02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that fchown(2) invoked by super-user:
  *
  *  - clears setuid and setgid bits set on an executable file
diff --git a/testcases/kernel/syscalls/fchown/fchown03.c b/testcases/kernel/syscalls/fchown/fchown03.c
index 97d6c9d342..cda3234f9d 100644
--- a/testcases/kernel/syscalls/fchown/fchown03.c
+++ b/testcases/kernel/syscalls/fchown/fchown03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, fchown(2) succeeds to change the group of a file specified
  * by path when called by non-root user with the following constraints:
  *
diff --git a/testcases/kernel/syscalls/fchown/fchown04.c b/testcases/kernel/syscalls/fchown/fchown04.c
index a7af3aae7f..56b91304df 100644
--- a/testcases/kernel/syscalls/fchown/fchown04.c
+++ b/testcases/kernel/syscalls/fchown/fchown04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that:
  *
  * 1. fchown() returns -1 and sets errno to EPERM if the effective user id
diff --git a/testcases/kernel/syscalls/fchown/fchown05.c b/testcases/kernel/syscalls/fchown/fchown05.c
index 47ee171222..97992565fc 100644
--- a/testcases/kernel/syscalls/fchown/fchown05.c
+++ b/testcases/kernel/syscalls/fchown/fchown05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, fchown() succeeds to change the owner and group of a file
  * specified by file descriptor to any numeric owner(uid)/group(gid) values
  * when invoked by super-user.
diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
index fedcb8ab2f..5c0aa1a8e3 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat01.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that fchownat() succeeds to change file's ownership if the file
  * descriptor is AT_FDCWD or set by opening a directory.
  */
diff --git a/testcases/kernel/syscalls/fchownat/fchownat02.c b/testcases/kernel/syscalls/fchownat/fchownat02.c
index 10b4f5e3c0..e2e4c3765e 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat02.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that fchownat() will operate on symbolic links when
  * AT_SYMLINK_NOFOLLOW is used.
  */
diff --git a/testcases/kernel/syscalls/fchownat/fchownat03.c b/testcases/kernel/syscalls/fchownat/fchownat03.c
index 06928490bb..5219ca655d 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat03.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that,
  * - fchownat() returns -1 and sets errno to EACCES if there is no permission
      to access to the file.
diff --git a/testcases/kernel/syscalls/fcntl/fcntl05.c b/testcases/kernel/syscalls/fcntl/fcntl05.c
index 7835d1e356..29cb20f4ab 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl05.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl05.c
@@ -15,8 +15,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for fcntl(2) using F_GETLK argument.
  *
  * If the lock could be placed, fcntl() does not actually place it, but
diff --git a/testcases/kernel/syscalls/fcntl/fcntl08.c b/testcases/kernel/syscalls/fcntl/fcntl08.c
index ea7602d9ee..5061974827 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl08.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl08.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for fcntl(2) using F_SETFL with flags O_NDELAY | O_APPEND | O_NONBLOCK.
  */
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl12.c b/testcases/kernel/syscalls/fcntl/fcntl12.c
index ccd57da903..93b861e040 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl12.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl12.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests basic error handling of the fcntl syscall.
  *
  * - EMFILE when cmd is F_DUPFD and the per-process limit on the number of open
diff --git a/testcases/kernel/syscalls/fcntl/fcntl13.c b/testcases/kernel/syscalls/fcntl/fcntl13.c
index 1bc414cca3..6935e3906f 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl13.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl13.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests basic error handling of the fcntl syscall.
  *
  * - EFAULT when lock is outside your accessible address space
diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c b/testcases/kernel/syscalls/fcntl/fcntl14.c
index 21dbede5c3..c2f2e28232 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl14.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl14.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test is checking fcntl() syscall locking mechanism between two
  * processes.
  * The test sets a random starting position on file using lseek(), it randomly
diff --git a/testcases/kernel/syscalls/fcntl/fcntl15.c b/testcases/kernel/syscalls/fcntl/fcntl15.c
index 8c17144fb2..79184e0c1e 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl15.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl15.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that file locks are removed when a file descriptor is closed, three
  * different tests are implemented.
  *
diff --git a/testcases/kernel/syscalls/fcntl/fcntl27.c b/testcases/kernel/syscalls/fcntl/fcntl27.c
index 6dbf58feb1..07a63ebc09 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl27.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl27.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for fcntl(2) using F_SETLEASE and F_RDLCK argument,
  * testing O_RDWR and O_WRONLY.
  */
diff --git a/testcases/kernel/syscalls/fcntl/fcntl29.c b/testcases/kernel/syscalls/fcntl/fcntl29.c
index 24d3983edf..836ca30e92 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl29.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl29.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for fcntl(2) using F_DUPFD_CLOEXEC and getting FD_CLOEXEC.
  */
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl30.c b/testcases/kernel/syscalls/fcntl/fcntl30.c
index 725385b39a..4d1b7e627a 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl30.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl30.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, fetching and changing the capacity of a pipe works as
  * expected with fcntl(2) syscall using F_GETPIPE_SZ, F_SETPIPE_SZ arguments.
  */
diff --git a/testcases/kernel/syscalls/fcntl/fcntl39.c b/testcases/kernel/syscalls/fcntl/fcntl39.c
index 30aada2aa1..1142e1a684 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl39.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl39.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that dnotify DN_RENAME event is reported only on rename inside same parent.
  */
 
diff --git a/testcases/kernel/syscalls/finit_module/finit_module01.c b/testcases/kernel/syscalls/finit_module/finit_module01.c
index ea00e48356..397d5a1ae4 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module01.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic finit_module() tests.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
index e16164ee25..78dc741008 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module02.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic finit_module() failure tests.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/flock/flock01.c b/testcases/kernel/syscalls/flock/flock01.c
index 4c37e07f97..c8e5aac1ec 100644
--- a/testcases/kernel/syscalls/flock/flock01.c
+++ b/testcases/kernel/syscalls/flock/flock01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for flock(2), uses LOCK_SH, LOCK_UN, LOCK_EX locks.
  */
 
diff --git a/testcases/kernel/syscalls/flock/flock02.c b/testcases/kernel/syscalls/flock/flock02.c
index 5c27c81a25..a8ca7c88ad 100644
--- a/testcases/kernel/syscalls/flock/flock02.c
+++ b/testcases/kernel/syscalls/flock/flock02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify flock(2) returns -1 and set proper errno:
  *
  * - EBADF if the file descriptor is invalid
diff --git a/testcases/kernel/syscalls/flock/flock03.c b/testcases/kernel/syscalls/flock/flock03.c
index dec6e73440..be6475f134 100644
--- a/testcases/kernel/syscalls/flock/flock03.c
+++ b/testcases/kernel/syscalls/flock/flock03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that flock(2) cannot unlock a file locked by another task.
  *
  * Fork a child processes. The parent flocks a file with LOCK_EX. Child waits
diff --git a/testcases/kernel/syscalls/flock/flock04.c b/testcases/kernel/syscalls/flock/flock04.c
index 1649b45c2e..da354a653b 100644
--- a/testcases/kernel/syscalls/flock/flock04.c
+++ b/testcases/kernel/syscalls/flock/flock04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test verifies that flock() behavior with different locking combinations along
  * with LOCK_SH and LOCK_EX:
  *
diff --git a/testcases/kernel/syscalls/flock/flock06.c b/testcases/kernel/syscalls/flock/flock06.c
index 7e9da8acdd..363dc5bf78 100644
--- a/testcases/kernel/syscalls/flock/flock06.c
+++ b/testcases/kernel/syscalls/flock/flock06.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test verifies that flock locks held on one file descriptor conflict with
  * flock locks held on a different file descriptor.
  *
diff --git a/testcases/kernel/syscalls/flock/flock07.c b/testcases/kernel/syscalls/flock/flock07.c
index 368147370c..6b6848b91c 100644
--- a/testcases/kernel/syscalls/flock/flock07.c
+++ b/testcases/kernel/syscalls/flock/flock07.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that flock(2) fails with errno EINTR when waiting to acquire a lock,
  * and the call is interrupted by a signal.
  */
diff --git a/testcases/kernel/syscalls/fork/fork05.c b/testcases/kernel/syscalls/fork/fork05.c
index b5146d27b9..22edefc368 100644
--- a/testcases/kernel/syscalls/fork/fork05.c
+++ b/testcases/kernel/syscalls/fork/fork05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that LDT is propagated correctly from parent process to
  * the child process.
  *
diff --git a/testcases/kernel/syscalls/fork/fork07.c b/testcases/kernel/syscalls/fork/fork07.c
index 43b92c8057..266f0ffbc4 100644
--- a/testcases/kernel/syscalls/fork/fork07.c
+++ b/testcases/kernel/syscalls/fork/fork07.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that all children inherit parent's file descriptor.
  *
  * Parent opens a file and forks children. Each child reads a byte and checks
diff --git a/testcases/kernel/syscalls/fork/fork08.c b/testcases/kernel/syscalls/fork/fork08.c
index 34af476fc7..6a56cda70a 100644
--- a/testcases/kernel/syscalls/fork/fork08.c
+++ b/testcases/kernel/syscalls/fork/fork08.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that the parent's file descriptors will not be affected by being
  * closed in the child.
  */
diff --git a/testcases/kernel/syscalls/fork/fork10.c b/testcases/kernel/syscalls/fork/fork10.c
index 790e7b386e..d6dc05d46a 100644
--- a/testcases/kernel/syscalls/fork/fork10.c
+++ b/testcases/kernel/syscalls/fork/fork10.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies inheritance of file descriptors from parent to child
  * process. We open a file from parent, then we check if file offset changes
  * accordingly with file descriptor usage.
diff --git a/testcases/kernel/syscalls/fork/fork13.c b/testcases/kernel/syscalls/fork/fork13.c
index 3e96d0d420..3da698e33d 100644
--- a/testcases/kernel/syscalls/fork/fork13.c
+++ b/testcases/kernel/syscalls/fork/fork13.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * A race in pid generation that causes pids to be reused immediately
  *
  * From the mainline commit 5fdee8c4a5e1800489ce61963208f8cc55e42ea1:
diff --git a/testcases/kernel/syscalls/fork/fork14.c b/testcases/kernel/syscalls/fork/fork14.c
index d61864b529..ad3c0a9e76 100644
--- a/testcases/kernel/syscalls/fork/fork14.c
+++ b/testcases/kernel/syscalls/fork/fork14.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test is a reproducer for kernel 3.5:
  * 7edc8b0ac16c ("mm/fork: fix overflow in vma length when copying mmap on clone")
  *
diff --git a/testcases/kernel/syscalls/fpathconf/fpathconf01.c b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
index a328f972fc..d3654dd352 100644
--- a/testcases/kernel/syscalls/fpathconf/fpathconf01.c
+++ b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check the basic functionality of the fpathconf(2) system call.
  */
 
diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
index 5037536360..add54769e0 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig03.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2022-0185.
  *
  * References links:
diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
index 39265af366..18490a8658 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify basic fsetxattr(2) syscall functionality:
  *
  * - Set attribute to a regular file, fsetxattr(2) should succeed.
diff --git a/testcases/kernel/syscalls/fstat/fstat02.c b/testcases/kernel/syscalls/fstat/fstat02.c
index 2768317575..68cbe82f0e 100644
--- a/testcases/kernel/syscalls/fstat/fstat02.c
+++ b/testcases/kernel/syscalls/fstat/fstat02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests if fstat() returns correctly and reports correct file information
  * using the stat structure.
  */
diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs01.c b/testcases/kernel/syscalls/fstatfs/fstatfs01.c
index 044ab65488..d952388998 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs01.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that fstatfs() syscall executes successfully for all
  * available filesystems.
  */
diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs02.c b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
index f801c9f5fa..dcb9589eb9 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs02.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to check if fstatfs() sets errno correctly.
  */
 
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate01.c b/testcases/kernel/syscalls/ftruncate/ftruncate01.c
index ea97edb1da..13f915bee1 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate01.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, ftruncate() succeeds to truncate a file to a certain length,
  * if the file previously is smaller than the truncated size, ftruncate()
  * shall increase the size of the file.
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate03.c b/testcases/kernel/syscalls/ftruncate/ftruncate03.c
index f2fa96dce5..368186e26a 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate03.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that ftruncate(2) system call returns appropriate error number:
  *
  * 1. EINVAL -- the file is a socket
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
index bf4c3813a8..946e4e949e 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify the basic functionality of futex(FUTEX_CMP_REQUEUE).
  *
  * futex(FUTEX_CMP_REQUEUE) can wake up the number of waiters specified
diff --git a/testcases/kernel/syscalls/futex/futex_waitv01.c b/testcases/kernel/syscalls/futex/futex_waitv01.c
index 17b96738cd..bbea664823 100644
--- a/testcases/kernel/syscalls/futex/futex_waitv01.c
+++ b/testcases/kernel/syscalls/futex/futex_waitv01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies EINVAL for futex_waitv syscall.
  */
 
diff --git a/testcases/kernel/syscalls/futex/futex_waitv02.c b/testcases/kernel/syscalls/futex/futex_waitv02.c
index ccea5eb5e7..6b210d38d2 100644
--- a/testcases/kernel/syscalls/futex/futex_waitv02.c
+++ b/testcases/kernel/syscalls/futex/futex_waitv02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies futex_waitv syscall using private data.
  */
 
diff --git a/testcases/kernel/syscalls/futex/futex_waitv03.c b/testcases/kernel/syscalls/futex/futex_waitv03.c
index c674f52d8d..1d367ed001 100644
--- a/testcases/kernel/syscalls/futex/futex_waitv03.c
+++ b/testcases/kernel/syscalls/futex/futex_waitv03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies futex_waitv syscall using shared data.
  */
 
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index 23f62091a3..3c854d1096 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -12,8 +12,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that get_mempolicy() returns a proper return value and errno for various cases.
  */
 
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
index 4a855596d9..79ff5d94f8 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
@@ -12,8 +12,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that get_mempolicy() returns a proper return errno for failure cases.
  */
 
diff --git a/testcases/kernel/syscalls/getcontext/getcontext01.c b/testcases/kernel/syscalls/getcontext/getcontext01.c
index 5896c38004..0d8955e321 100644
--- a/testcases/kernel/syscalls/getcontext/getcontext01.c
+++ b/testcases/kernel/syscalls/getcontext/getcontext01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for getcontext().
  *
  * Calls a getcontext() then jumps back with a setcontext().
diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
index 152f91d32b..19d8c9d813 100644
--- a/testcases/kernel/syscalls/getcpu/getcpu01.c
+++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * The test process is affined to a CPU. It then calls getcpu and
  * checks that the CPU and node (if supported) match the expected
  * values.
diff --git a/testcases/kernel/syscalls/getcpu/getcpu02.c b/testcases/kernel/syscalls/getcpu/getcpu02.c
index 048758b3d0..954151c048 100644
--- a/testcases/kernel/syscalls/getcpu/getcpu02.c
+++ b/testcases/kernel/syscalls/getcpu/getcpu02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that getcpu(2) fails with EFAULT if cpu_id or node_id points outside
  * the calling process address space.
  */
diff --git a/testcases/kernel/syscalls/getcwd/getcwd02.c b/testcases/kernel/syscalls/getcwd/getcwd02.c
index e3df22ceb8..4950c2d25c 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd02.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to check the basic functionality of the getcwd(2) system call.
  *
  * 1. getcwd(2) works fine if buf and size are valid.
diff --git a/testcases/kernel/syscalls/getcwd/getcwd03.c b/testcases/kernel/syscalls/getcwd/getcwd03.c
index 9e3828a93f..4ea4e3ad1b 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd03.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to check the basic functionality of the getcwd(2)
  * system call on a symbolic link.
  *
diff --git a/testcases/kernel/syscalls/getdents/getdents01.c b/testcases/kernel/syscalls/getdents/getdents01.c
index d6c4b49792..6a88e305af 100644
--- a/testcases/kernel/syscalls/getdents/getdents01.c
+++ b/testcases/kernel/syscalls/getdents/getdents01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- *
- * [Description]
  *
  * Basic getdents() test that checks if directory listing is correct and
  * complete.
diff --git a/testcases/kernel/syscalls/getdents/getdents02.c b/testcases/kernel/syscalls/getdents/getdents02.c
index 71c3332f47..98254e12fb 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that:
  *
  *   - getdents() fails with EBADF if file descriptor fd is invalid
diff --git a/testcases/kernel/syscalls/getdomainname/getdomainname01.c b/testcases/kernel/syscalls/getdomainname/getdomainname01.c
index 17a9392e55..34c5526445 100644
--- a/testcases/kernel/syscalls/getdomainname/getdomainname01.c
+++ b/testcases/kernel/syscalls/getdomainname/getdomainname01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for getdomainname(2)
  *
  * This is a Phase I test for the getdomainname(2) system call.
diff --git a/testcases/kernel/syscalls/getegid/getegid01.c b/testcases/kernel/syscalls/getegid/getegid01.c
index 46cdc680bf..429991960d 100644
--- a/testcases/kernel/syscalls/getegid/getegid01.c
+++ b/testcases/kernel/syscalls/getegid/getegid01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test checks if getegid() returns the effective group id.
  */
 
diff --git a/testcases/kernel/syscalls/getegid/getegid02.c b/testcases/kernel/syscalls/getegid/getegid02.c
index 2f64bd8697..32635e83d3 100644
--- a/testcases/kernel/syscalls/getegid/getegid02.c
+++ b/testcases/kernel/syscalls/getegid/getegid02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test checks if getegid() returns the same effective group given by
  * passwd entry via getpwuid().
  */
diff --git a/testcases/kernel/syscalls/getgid/getgid01.c b/testcases/kernel/syscalls/getgid/getgid01.c
index 3d914f73fa..2481b14989 100644
--- a/testcases/kernel/syscalls/getgid/getgid01.c
+++ b/testcases/kernel/syscalls/getgid/getgid01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Call getgid() and expects that the gid returned correctly.
  */
 
diff --git a/testcases/kernel/syscalls/getgid/getgid03.c b/testcases/kernel/syscalls/getgid/getgid03.c
index eb302ad329..3e406ce64e 100644
--- a/testcases/kernel/syscalls/getgid/getgid03.c
+++ b/testcases/kernel/syscalls/getgid/getgid03.c
@@ -5,7 +5,6 @@
  */
 
 /*\
- * [Description]
  * Testcase to check the basic functionality of getgid().
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/gethostbyname_r/gethostbyname_r01.c b/testcases/kernel/syscalls/gethostbyname_r/gethostbyname_r01.c
index 6059753070..e4c0cb716e 100644
--- a/testcases/kernel/syscalls/gethostbyname_r/gethostbyname_r01.c
+++ b/testcases/kernel/syscalls/gethostbyname_r/gethostbyname_r01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for GHOST: glibc vulnerability (CVE-2015-0235).
  *
  * https://www.qualys.com/research/security-advisories/GHOST-CVE-2015-0235.txt
diff --git a/testcases/kernel/syscalls/gethostid/gethostid01.c b/testcases/kernel/syscalls/gethostid/gethostid01.c
index 3fc280327a..e5cf201abb 100644
--- a/testcases/kernel/syscalls/gethostid/gethostid01.c
+++ b/testcases/kernel/syscalls/gethostid/gethostid01.c
@@ -19,8 +19,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test the basic functionality of the sethostid() and gethostid() system call.
  */
 
diff --git a/testcases/kernel/syscalls/gethostname/gethostname01.c b/testcases/kernel/syscalls/gethostname/gethostname01.c
index 5d882514a1..6ef8a634a5 100644
--- a/testcases/kernel/syscalls/gethostname/gethostname01.c
+++ b/testcases/kernel/syscalls/gethostname/gethostname01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test is checking that gethostname() succeeds.
  */
 
diff --git a/testcases/kernel/syscalls/gethostname/gethostname02.c b/testcases/kernel/syscalls/gethostname/gethostname02.c
index f792371ed5..c56fcb800a 100644
--- a/testcases/kernel/syscalls/gethostname/gethostname02.c
+++ b/testcases/kernel/syscalls/gethostname/gethostname02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that gethostname(2) fails with
  *
  * - ENAMETOOLONG when len is smaller than the actual size
diff --git a/testcases/kernel/syscalls/getitimer/getitimer01.c b/testcases/kernel/syscalls/getitimer/getitimer01.c
index 6b0cfba1c2..a32a2860be 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer01.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that a correct call to getitimer() succeeds.
  */
 
diff --git a/testcases/kernel/syscalls/getitimer/getitimer02.c b/testcases/kernel/syscalls/getitimer/getitimer02.c
index 8ddbaec427..8bf8453eac 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer02.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that getitimer() call fails:
  *
  * 1. EFAULT with invalid itimerval pointer
diff --git a/testcases/kernel/syscalls/getpagesize/getpagesize01.c b/testcases/kernel/syscalls/getpagesize/getpagesize01.c
index c88071ba44..3e810978bd 100644
--- a/testcases/kernel/syscalls/getpagesize/getpagesize01.c
+++ b/testcases/kernel/syscalls/getpagesize/getpagesize01.c
@@ -10,8 +10,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that getpagesize(2) returns the number of bytes in a
  * memory page as expected.
  */
diff --git a/testcases/kernel/syscalls/getpeername/getpeername01.c b/testcases/kernel/syscalls/getpeername/getpeername01.c
index 0f2600beed..945b83d2b2 100644
--- a/testcases/kernel/syscalls/getpeername/getpeername01.c
+++ b/testcases/kernel/syscalls/getpeername/getpeername01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that getpeername() returns the proper errno for various failure cases:
  *
  * - EBADF on invalid address.
diff --git a/testcases/kernel/syscalls/getpgid/getpgid01.c b/testcases/kernel/syscalls/getpgid/getpgid01.c
index 4c614e0b94..169ea3d642 100644
--- a/testcases/kernel/syscalls/getpgid/getpgid01.c
+++ b/testcases/kernel/syscalls/getpgid/getpgid01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify the basic functionality of getpgid(2) syscall.
  */
 
diff --git a/testcases/kernel/syscalls/getpgid/getpgid02.c b/testcases/kernel/syscalls/getpgid/getpgid02.c
index 30d0129bc2..2836160d0e 100644
--- a/testcases/kernel/syscalls/getpgid/getpgid02.c
+++ b/testcases/kernel/syscalls/getpgid/getpgid02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that getpgid(2) fails with errno ESRCH when
  * pid does not match any process.
  */
diff --git a/testcases/kernel/syscalls/getpgrp/getpgrp01.c b/testcases/kernel/syscalls/getpgrp/getpgrp01.c
index fe2e0c5825..06a6e0ae36 100644
--- a/testcases/kernel/syscalls/getpgrp/getpgrp01.c
+++ b/testcases/kernel/syscalls/getpgrp/getpgrp01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that getpgrp(2) syscall executes successfully.
  */
 
diff --git a/testcases/kernel/syscalls/getpid/getpid01.c b/testcases/kernel/syscalls/getpid/getpid01.c
index 314c45d094..d9ba0953c9 100644
--- a/testcases/kernel/syscalls/getpid/getpid01.c
+++ b/testcases/kernel/syscalls/getpid/getpid01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that getpid() system call returns process ID in range <2, PID_MAX>.
  */
 
diff --git a/testcases/kernel/syscalls/getpid/getpid02.c b/testcases/kernel/syscalls/getpid/getpid02.c
index 86ad5a29f5..3da853d48b 100644
--- a/testcases/kernel/syscalls/getpid/getpid02.c
+++ b/testcases/kernel/syscalls/getpid/getpid02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that:
  *
  * - fork() in parent returns the same pid as getpid() in child
diff --git a/testcases/kernel/syscalls/getppid/getppid01.c b/testcases/kernel/syscalls/getppid/getppid01.c
index 614eea9fdd..3f05aed37c 100644
--- a/testcases/kernel/syscalls/getppid/getppid01.c
+++ b/testcases/kernel/syscalls/getppid/getppid01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test whether parent process id that getppid() returns is out of range.
  */
 
diff --git a/testcases/kernel/syscalls/getppid/getppid02.c b/testcases/kernel/syscalls/getppid/getppid02.c
index cbc7ae76c9..7497eba12e 100644
--- a/testcases/kernel/syscalls/getppid/getppid02.c
+++ b/testcases/kernel/syscalls/getppid/getppid02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that getppid() in child returns the same pid as getpid() in parent.
  */
 
diff --git a/testcases/kernel/syscalls/getrandom/getrandom05.c b/testcases/kernel/syscalls/getrandom/getrandom05.c
index c4886b886f..f05a4fa807 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom05.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that getrandom(2) fails with
  *
  * - EFAULT when buf address is outside the accessible address space
diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit01.c b/testcases/kernel/syscalls/getrlimit/getrlimit01.c
index f14c8e6aa7..589b14880c 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit01.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that getrlimit(2) call will be successful for all possible resource
  * types.
  */
diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit02.c b/testcases/kernel/syscalls/getrlimit/getrlimit02.c
index 9f5b2bf9cd..20c247a0e0 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit02.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for checking error conditions for getrlimit(2):
  *
  * 1. getrlimit(2) returns -1 and sets errno to EFAULT if an invalid
diff --git a/testcases/kernel/syscalls/getrusage/getrusage01.c b/testcases/kernel/syscalls/getrusage/getrusage01.c
index 83275dd34b..78b8e57a03 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage01.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test that getrusage() with RUSAGE_SELF and RUSAGE_CHILDREN succeeds.
  */
 
diff --git a/testcases/kernel/syscalls/getrusage/getrusage02.c b/testcases/kernel/syscalls/getrusage/getrusage02.c
index 7676630903..5138d96e03 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage02.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that getrusage() fails with:
  *
  * - EINVAL with invalid who
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index c8e974567c..bc196c15ee 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test ru_maxrss behaviors in struct rusage.
  *
  * This test program is backported from upstream commit: 1f10206cf8e9, which
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03_child.c b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
index 18627a98cb..1c6a19e32f 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03_child.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Child program executed by getrusage03.
  */
 
diff --git a/testcases/kernel/syscalls/getsid/getsid01.c b/testcases/kernel/syscalls/getsid/getsid01.c
index 89f6a72915..e0201d4fc1 100644
--- a/testcases/kernel/syscalls/getsid/getsid01.c
+++ b/testcases/kernel/syscalls/getsid/getsid01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that session IDs returned by getsid() (with argument pid=0)
  * are same in parent and child process.
  */
diff --git a/testcases/kernel/syscalls/getsid/getsid02.c b/testcases/kernel/syscalls/getsid/getsid02.c
index 14b634727f..8a25dcafda 100644
--- a/testcases/kernel/syscalls/getsid/getsid02.c
+++ b/testcases/kernel/syscalls/getsid/getsid02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that getsid(2) fails with ESRCH errno when there is no
  * process found with process ID pid.
  */
diff --git a/testcases/kernel/syscalls/getsockname/getsockname01.c b/testcases/kernel/syscalls/getsockname/getsockname01.c
index becd7133ae..108d7fe1a4 100644
--- a/testcases/kernel/syscalls/getsockname/getsockname01.c
+++ b/testcases/kernel/syscalls/getsockname/getsockname01.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Verify that getsockname() returns the proper errno for various failure cases:
  *
  * - EBADF on a not open file
diff --git a/testcases/kernel/syscalls/getsockopt/getsockopt01.c b/testcases/kernel/syscalls/getsockopt/getsockopt01.c
index 9effbf30ca..2c1d371f2f 100644
--- a/testcases/kernel/syscalls/getsockopt/getsockopt01.c
+++ b/testcases/kernel/syscalls/getsockopt/getsockopt01.c
@@ -7,7 +7,6 @@
  */
 
 /*\
- * [Description]
  * Verify that getsockopt() returns the proper errno for various failure cases:
  *
  * - EBADF on a not open file
diff --git a/testcases/kernel/syscalls/getsockopt/getsockopt02.c b/testcases/kernel/syscalls/getsockopt/getsockopt02.c
index d24e9b693d..68575799ae 100644
--- a/testcases/kernel/syscalls/getsockopt/getsockopt02.c
+++ b/testcases/kernel/syscalls/getsockopt/getsockopt02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test getsockopt(2) for retrieving peer credentials (SO_PEERCRED).
  */
 
diff --git a/testcases/kernel/syscalls/gettid/gettid01.c b/testcases/kernel/syscalls/gettid/gettid01.c
index 22ba15016c..108b8266e6 100644
--- a/testcases/kernel/syscalls/gettid/gettid01.c
+++ b/testcases/kernel/syscalls/gettid/gettid01.c
@@ -4,8 +4,6 @@
  * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 /*\
- * [Description]
- *
  * This test checks if parent pid is equal to tid in single-threaded
  * application.
  */
diff --git a/testcases/kernel/syscalls/gettid/gettid02.c b/testcases/kernel/syscalls/gettid/gettid02.c
index ef44761c41..88505068b8 100644
--- a/testcases/kernel/syscalls/gettid/gettid02.c
+++ b/testcases/kernel/syscalls/gettid/gettid02.c
@@ -3,8 +3,6 @@
  * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 /*\
- * [Description]
- *
  * This test spawns multiple threads, then check for each one of them if the
  * parent ID is different AND if the thread ID is different from all the other
  * spwaned threads.
diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
index 887a366886..645cc6d3cb 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for gettimeofday error.
  *
  * - EFAULT: tv pointed outside the accessible address space
diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
index a58a3cb4f2..1e0c957324 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check if gettimeofday() is monotonous during 10s:
  *
  * - Call gettimeofday() to get a t1 (fist value)
diff --git a/testcases/kernel/syscalls/getuid/getuid01.c b/testcases/kernel/syscalls/getuid/getuid01.c
index 206ca0c529..a25eb8d86b 100644
--- a/testcases/kernel/syscalls/getuid/getuid01.c
+++ b/testcases/kernel/syscalls/getuid/getuid01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check the basic functionality of the getuid() system call.
  */
 
diff --git a/testcases/kernel/syscalls/getuid/getuid03.c b/testcases/kernel/syscalls/getuid/getuid03.c
index a5deebf2b9..1de03d4ea3 100644
--- a/testcases/kernel/syscalls/getuid/getuid03.c
+++ b/testcases/kernel/syscalls/getuid/getuid03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that getuid() return value matches value from /proc/self/status.
  */
 
diff --git a/testcases/kernel/syscalls/getxattr/getxattr01.c b/testcases/kernel/syscalls/getxattr/getxattr01.c
index 50b00c0a57..241cc1eabd 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr01.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic tests for getxattr(2) and make sure getxattr(2) handles error
  * conditions correctly.
  *
diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c b/testcases/kernel/syscalls/getxattr/getxattr02.c
index 593ad7b8c7..7bc3bf22ad 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr02.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * In the user.* namespace, only regular files and directories can
  * have extended attributes. Otherwise getxattr(2) will return -1
  * and set errno to ENODATA.
diff --git a/testcases/kernel/syscalls/getxattr/getxattr03.c b/testcases/kernel/syscalls/getxattr/getxattr03.c
index 85f26402af..e1f7bb6aae 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr03.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * An empty buffer of size zero can be passed into getxattr(2) to
  * return the current size of the named extended attribute.
  */
diff --git a/testcases/kernel/syscalls/getxattr/getxattr04.c b/testcases/kernel/syscalls/getxattr/getxattr04.c
index 27059fef09..1fb5928823 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr04.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This is a regression test for the race between getting an existing
  * xattr and setting/removing a large xattr.  This bug leads to that
  * getxattr() fails to get an existing xattr and returns ENOATTR in xfs
diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
index d9717a6950..5f0aac51d0 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr05.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that:
  *
  * - Without a user namespace, getxattr(2) should get same data when
diff --git a/testcases/kernel/syscalls/init_module/init_module01.c b/testcases/kernel/syscalls/init_module/init_module01.c
index 850f826e62..a0d4792c95 100644
--- a/testcases/kernel/syscalls/init_module/init_module01.c
+++ b/testcases/kernel/syscalls/init_module/init_module01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic init_module() tests.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/init_module/init_module02.c b/testcases/kernel/syscalls/init_module/init_module02.c
index c3979c08aa..3fb1e87158 100644
--- a/testcases/kernel/syscalls/init_module/init_module02.c
+++ b/testcases/kernel/syscalls/init_module/init_module02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic init_module() failure tests.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index e0fa0ba50d..4f7fa70e9e 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for inotify events on file.
  */
 
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index d75395baee..709a928308 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for inotify events on directory.
  */
 
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index 4ee5e94613..9bb95addbc 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that inotify get IN_UNMOUNT event and don't block the umount command.
  */
 
diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
index 120e73b916..1db38ddf28 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for inotify IN_DELETE_SELF event.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/inotify/inotify05.c b/testcases/kernel/syscalls/inotify/inotify05.c
index 38b30878c1..d9bfb05f1d 100644
--- a/testcases/kernel/syscalls/inotify/inotify05.c
+++ b/testcases/kernel/syscalls/inotify/inotify05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that inotify overflow event is properly generated.
  */
 
diff --git a/testcases/kernel/syscalls/inotify/inotify06.c b/testcases/kernel/syscalls/inotify/inotify06.c
index b0eb8cafbb..42837ea093 100644
--- a/testcases/kernel/syscalls/inotify/inotify06.c
+++ b/testcases/kernel/syscalls/inotify/inotify06.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for inotify mark destruction race.
  *
  * Kernels prior to 4.2 have a race when inode is being deleted while
diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index bcfc569a8d..66a2f4d372 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that inotify work for an overlayfs directory after copy up and
  * drop caches.
  *
diff --git a/testcases/kernel/syscalls/inotify/inotify08.c b/testcases/kernel/syscalls/inotify/inotify08.c
index 149a0a1f81..4cbb16ce0d 100644
--- a/testcases/kernel/syscalls/inotify/inotify08.c
+++ b/testcases/kernel/syscalls/inotify/inotify08.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that inotify work for an overlayfs file after copy up and
  * drop caches.
  *
diff --git a/testcases/kernel/syscalls/inotify/inotify09.c b/testcases/kernel/syscalls/inotify/inotify09.c
index e999dac39d..5c9ff3a3ba 100644
--- a/testcases/kernel/syscalls/inotify/inotify09.c
+++ b/testcases/kernel/syscalls/inotify/inotify09.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for inotify mark connector destruction race.
  *
  * Kernels prior to 4.17 have a race when the last fsnotify mark on the inode
diff --git a/testcases/kernel/syscalls/inotify/inotify10.c b/testcases/kernel/syscalls/inotify/inotify10.c
index 6a9a0a4368..a78572dff3 100644
--- a/testcases/kernel/syscalls/inotify/inotify10.c
+++ b/testcases/kernel/syscalls/inotify/inotify10.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that event is reported to watching parent and watching child
  * based on their interest.
  *
diff --git a/testcases/kernel/syscalls/inotify/inotify11.c b/testcases/kernel/syscalls/inotify/inotify11.c
index 2e571f3a0c..5af9cdb9bf 100644
--- a/testcases/kernel/syscalls/inotify/inotify11.c
+++ b/testcases/kernel/syscalls/inotify/inotify11.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test opening files after receiving IN_DELETE.
  *
  * Kernel v5.13 has a regression allowing files to be open after IN_DELETE.
diff --git a/testcases/kernel/syscalls/inotify/inotify12.c b/testcases/kernel/syscalls/inotify/inotify12.c
index 208263b178..5390b4c0ec 100644
--- a/testcases/kernel/syscalls/inotify/inotify12.c
+++ b/testcases/kernel/syscalls/inotify/inotify12.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test special inotify mask flags.
  *
  * Regression test for kernel commit:
diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
index b2f582f8ef..04c66be547 100644
--- a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
+++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that inotify_init1() returns a file descriptor and sets
  * the close-on-exec (FD_CLOEXEC) flag on the new file descriptor
  * only when called with IN_CLOEXEC.
diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
index 3baf35e754..4c8d883a69 100644
--- a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
+++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that inotify_init1() returns a file descriptor and sets the
  * O_NONBLOCK file status flag on the open file description referred
  * to by the new file descriptor only when called with IN_NONBLOCK.
diff --git a/testcases/kernel/syscalls/io_cancel/io_cancel01.c b/testcases/kernel/syscalls/io_cancel/io_cancel01.c
index f7e8bd061e..699eb2a68a 100644
--- a/testcases/kernel/syscalls/io_cancel/io_cancel01.c
+++ b/testcases/kernel/syscalls/io_cancel/io_cancel01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test io_cancel invoked via syscall(2) with one of pointers set to invalid
  * address and expects it to return EFAULT.
  */
diff --git a/testcases/kernel/syscalls/io_cancel/io_cancel02.c b/testcases/kernel/syscalls/io_cancel/io_cancel02.c
index 92ec651192..0394e308d4 100644
--- a/testcases/kernel/syscalls/io_cancel/io_cancel02.c
+++ b/testcases/kernel/syscalls/io_cancel/io_cancel02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test io_cancel invoked via libaio with one of the data structures points
  * to invalid data and expects it to return -EFAULT.
  */
diff --git a/testcases/kernel/syscalls/io_destroy/io_destroy01.c b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
index 79c685faab..ce4158c260 100644
--- a/testcases/kernel/syscalls/io_destroy/io_destroy01.c
+++ b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test io_destroy invoked via libaio with invalid ctx and expects it to
  * return -EINVAL.
  */
diff --git a/testcases/kernel/syscalls/io_destroy/io_destroy02.c b/testcases/kernel/syscalls/io_destroy/io_destroy02.c
index c8cc63818b..84868f3111 100644
--- a/testcases/kernel/syscalls/io_destroy/io_destroy02.c
+++ b/testcases/kernel/syscalls/io_destroy/io_destroy02.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test io_destroy invoked via syscall(2) with an invalid ctx and expects
  * it to return EINVAL.
  */
diff --git a/testcases/kernel/syscalls/io_getevents/io_getevents01.c b/testcases/kernel/syscalls/io_getevents/io_getevents01.c
index e8a426ab6a..0806ea9120 100644
--- a/testcases/kernel/syscalls/io_getevents/io_getevents01.c
+++ b/testcases/kernel/syscalls/io_getevents/io_getevents01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test io_getevents invoked via syscall(2) with invalid ctx and expects it to
  * return EINVAL.
  */
diff --git a/testcases/kernel/syscalls/io_getevents/io_getevents02.c b/testcases/kernel/syscalls/io_getevents/io_getevents02.c
index 09eedd4f61..6257ca82e8 100644
--- a/testcases/kernel/syscalls/io_getevents/io_getevents02.c
+++ b/testcases/kernel/syscalls/io_getevents/io_getevents02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test io_getevents invoked via libaio with invalid ctx and expects it to
  * return -EINVAL.
  */
diff --git a/testcases/kernel/syscalls/io_setup/io_setup01.c b/testcases/kernel/syscalls/io_setup/io_setup01.c
index ed99f38799..3536b068f6 100644
--- a/testcases/kernel/syscalls/io_setup/io_setup01.c
+++ b/testcases/kernel/syscalls/io_setup/io_setup01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test io_setup invoked via libaio:
  *
  * - io_setup succeeds if both nr_events and ctxp are valid.
diff --git a/testcases/kernel/syscalls/io_setup/io_setup02.c b/testcases/kernel/syscalls/io_setup/io_setup02.c
index f297979209..14a89d6020 100644
--- a/testcases/kernel/syscalls/io_setup/io_setup02.c
+++ b/testcases/kernel/syscalls/io_setup/io_setup02.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test io_setup invoked via syscall(2):
  *
  * - io_setup fails and returns EFAULT if ctxp is NULL.
diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
index 616380b93e..a76a5b3249 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit01.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test io_submit() invoked via libaio:
  *
  * - io_submit fails and returns -EINVAL if ctx is invalid.
diff --git a/testcases/kernel/syscalls/io_submit/io_submit02.c b/testcases/kernel/syscalls/io_submit/io_submit02.c
index 6ba4d99a5d..36e9c29f93 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit02.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test io_submit invoked via syscall(2):
  *
  * 1. io_submit() returns the number of iocbs submitted.
diff --git a/testcases/kernel/syscalls/io_submit/io_submit03.c b/testcases/kernel/syscalls/io_submit/io_submit03.c
index 90780c0e44..45903107d7 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit03.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit03.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test io_submit invoked via syscall(2):
  *
  * 1. io_submit fails and returns EINVAL if ctx is invalid.
diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index d7886f3586..42b93ac9b3 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to check the errnos set by the ioctl(2) system call.
  *
  * - EBADF: Pass an invalid fd to ioctl(fd, ...) and expect EBADF
diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index 9337da384a..7ef55af681 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test TCGETA/TCGETS and TCSETA/TCSETS ioctl implementations for tty driver.
  *
  * In this test, the parent and child open the parentty and the childtty
diff --git a/testcases/kernel/syscalls/ioctl/ioctl03.c b/testcases/kernel/syscalls/ioctl/ioctl03.c
index 890238f7d5..8a868a98e6 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl03.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test whether all the valid IFF flags are returned properly by implementation
  * of TUNGETFEATURES ioctl.
  */
diff --git a/testcases/kernel/syscalls/ioctl/ioctl04.c b/testcases/kernel/syscalls/ioctl/ioctl04.c
index f96b22f0ce..952450ba99 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for the BLKROSET and BLKROGET ioctls.
  *
  * - Set the device read only, read the value back.
diff --git a/testcases/kernel/syscalls/ioctl/ioctl05.c b/testcases/kernel/syscalls/ioctl/ioctl05.c
index 8e3abf14fe..586322e026 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl05.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for the BLKGETSIZE and BLKGETSIZE64 ioctls.
  *
  * - BLKGETSIZE returns size in 512 byte blocks BLKGETSIZE64 in bytes
diff --git a/testcases/kernel/syscalls/ioctl/ioctl06.c b/testcases/kernel/syscalls/ioctl/ioctl06.c
index 754d4acfc5..4e4177ca41 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl06.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for the BLKRASET and BLKRAGET ioctls.
  *
  * Sets device read-ahead, reads it back and compares the values.
diff --git a/testcases/kernel/syscalls/ioctl/ioctl07.c b/testcases/kernel/syscalls/ioctl/ioctl07.c
index ea88cf73bc..59ef893da5 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl07.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl07.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Very basic test for the RND* ioctls.
  *
  * Reads the entropy available from both /proc and the ioctl and compares
diff --git a/testcases/kernel/syscalls/ioctl/ioctl08.c b/testcases/kernel/syscalls/ioctl/ioctl08.c
index 14f9354c9b..115ad33235 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl08.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests the ioctl functionality to deduplicate fileranges using
  * btrfs filesystem.
  *
diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
index 0d1f1072d3..4e61f3bc9b 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl09.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for the BLKRRPART ioctl, it is the same as blockdev
  * --rereadpt command.
  */
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
index 2574bb6a26..a30fa92290 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that ioctl() FICLONE feature clones file content from
  * one file to an another.
  *
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
index e5d4be96f7..76a6bb8a20 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that ioctl() FICLONE/FICLONERANGE feature correctly raises
  * EOPNOTSUPP when an unsupported filesystem is used. In particular, filesystems
  * which don't support copy-on-write.
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
index b0a0f8d63f..6a9d270d9f 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that ioctl() FICLONE/FICLONERANGE feature correctly raises
  * exceptions when it's supposed to.
  */
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c
index 1dcf4f05c1..96f9d5831c 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that ioctl() FICLONE/FICLONERANGE feature raises the right
  * error according with bad file descriptors.
  */
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
index 7072707651..5b51f1d120 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that ioctl() FICLONERANGE feature clones file content from
  * one file to an another.
  *
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
index cc1d0e0319..6c93d8dc3b 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that ioctl() FICLONERANGE feature correctly raises
  * EINVAL when:
  * - filesystem does not support overlapping reflink ranges in the same file
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index c3fb9f583f..c9137bf1e7 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests ioctl() on loopdevice with LO_FLAGS_AUTOCLEAR and LO_FLAGS_PARTSCAN flags.
  *
  * For LO_FLAGS_AUTOCLEAR flag, only checks autoclear field value in sysfs
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
index dc983ac5f6..6026af1e26 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests ioctl() on loopdevice with LO_FLAGS_READ_ONLY (similar as losetup -r) and
  * LOOP_CHANGE_FD flags.
  *
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop03.c b/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
index a7b0230e1f..dc39dbbb63 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests ioctl() on loopdevice with LOOP_CHANGE_FD flag.
  *
  * Tests whether LOOP_CHANGE_FD can not succeed (get EINVAL error)
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop04.c b/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
index f1021cc77d..839648f265 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests ioctl() on loopdevice with LOOP_SET_CAPACITY flag.
  *
  * Tests whether LOOP_SET_CAPACITY can update a live
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
index 184462464b..0ced7eda12 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests ioctl() on loopdevice with LOOP_SET_DIRECT_IO flag.
  *
  * Tests whether LOOP_SET_DIRECT_IO can update a live loop device dio mode.
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
index 317f693a04..573871bc12 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests invalid block size of loopdevice by using ioctl() with
  * LOOP_SET_BLOCK_SIZE and LOOP_CONFIGURE flags.
  */
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop07.c b/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
index 68db79558f..be136fe0d4 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests ioctl() on loopdevice with LOOP_SET_STATUS64 and LOOP_GET_STATUS64 flags.
  *
  * Tests lo_sizelimit field. If lo_sizelimit is 0, it means max
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
index 06c81ba1b6..c2c9567368 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test ioctl_ns with NS_GET_PARENT request.
  *
  * Parent process tries to get parent of initial namespace, which should
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns02.c b/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
index 3c958c14af..c6849b53fe 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test ioctl_ns with NS_GET_PARENT request.
  *
  * Test tries to get namespace parent for UTS namespace, which
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns03.c b/testcases/kernel/syscalls/ioctl/ioctl_ns03.c
index bdd80585ac..395423b061 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test ioctl_ns with NS_GET_OWNER_UID request.
  *
  * Calls ioctl for a UTS namespace, which isn't a user namespace.
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns04.c b/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
index 8c5c9f961b..4385b6e344 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test ioctl_ns with NS_GET_USERNS request.
  *
  * Owning user namespace of process calling ioctl is out of scope,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
index 36e41c468c..e84af38b67 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test ioctl_ns with NS_GET_PARENT request.
  *
  * Child cloned with the CLONE_NEWPID flag is created in a new pid namespace.
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
index 45fc01ce72..a37ad6273b 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test ioctl_ns with NS_GET_USERNS request.
  *
  * After the call to clone with the CLONE_NEWUSER flag,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns07.c b/testcases/kernel/syscalls/ioctl/ioctl_ns07.c
index 9cfa57fb1b..b0a5d0b1c2 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns07.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns07.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test ioctl_ns with NS_GET_* request for file descriptors
  * that aren't namespaces.
  *
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
index 1c5039cf0f..fba3816c34 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * CVE-2018-1000204
  *
  * Test ioctl(SG_IO) and check that kernel doesn't leak data. Requires
diff --git a/testcases/kernel/syscalls/iopl/iopl01.c b/testcases/kernel/syscalls/iopl/iopl01.c
index 0b7e8823f2..227344aa4e 100644
--- a/testcases/kernel/syscalls/iopl/iopl01.c
+++ b/testcases/kernel/syscalls/iopl/iopl01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This is a basic test for iopl(2) system call.
  *
  * Test the system call for possible privilege levels.
diff --git a/testcases/kernel/syscalls/iopl/iopl02.c b/testcases/kernel/syscalls/iopl/iopl02.c
index 1a588590e9..bf3e0206dd 100644
--- a/testcases/kernel/syscalls/iopl/iopl02.c
+++ b/testcases/kernel/syscalls/iopl/iopl02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for iopl(2) system call error.
  *
  * - iopl(2) fail with EINVAL when privilege level greater than 3.
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_get01.c b/testcases/kernel/syscalls/ioprio/ioprio_get01.c
index f1325be31f..a0c919e23d 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio_get01.c
+++ b/testcases/kernel/syscalls/ioprio/ioprio_get01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic ioprio_get() test. Gets the current process I/O priority and
  * checks that the values are sane.
  */
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set01.c b/testcases/kernel/syscalls/ioprio/ioprio_set01.c
index 0868cea7c8..a69b28ec5a 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio_set01.c
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic ioprio_set() test. Gets the current process I/O priority and
  * bumps it up one notch, then down two notches and checks that the
  * new priority is reported back correctly.
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set02.c b/testcases/kernel/syscalls/ioprio/ioprio_set02.c
index 37db7bf429..39ef38a86f 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio_set02.c
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Extended ioprio_set() test.
  * Tests to set all 8 priority levels for best effort priority, then
  * switches to test all 8 priority levels for idle priority.
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set03.c b/testcases/kernel/syscalls/ioprio/ioprio_set03.c
index 6efcacc1ce..6a072c6c70 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio_set03.c
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Negative ioprio_set() test. Test some non-working priorities to make
  * sure they don't work.
  */
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
index 721b08c587..7e059d7f0d 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Cross verify the _high fields being set to 0 by the kernel.
  */
 #include <sys/msg.h>
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
index c1264b71e0..2e22f37fe0 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
@@ -4,8 +4,6 @@
  * Author: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
  */
 /*\
- * [Description]
- *
  * Call msgctl() with MSG_INFO flag and check that:
  *
  * * The returned index points to a valid MSG by calling MSG_STAT_ANY
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget01.c b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
index 2ab34ff9db..dd5a5ad73c 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget01.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Create a message queue, write a message to it and
  * read it back.
  */
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget02.c b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
index 1885599d16..ef9ab34b89 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget02.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for EEXIST, ENOENT, EACCES errors.
  *
  * -  msgget(2) fails if a message queue exists for key and msgflg
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
index 9e6c66cb49..bd06539737 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for ENOSPC error.
  *
  * ENOSPC -  All possible message queues have been taken (MSGMNI)
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget04.c b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
index a01ecea85e..28cbb3352b 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget04.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * It is a basic test for msg_next_id.
  * msg_next_id specifies desired id for next allocated IPC message. By
  * default it's equal to -1, which means generic allocation logic.
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget05.c b/testcases/kernel/syscalls/ipc/msgget/msgget05.c
index 817c8486e8..edcb307c65 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget05.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * It is a basic test for msg_next_id.
  * When the message queue identifier that msg_next_id stored is already in use,
  * call msgget with different key just use another unused value in range
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
index e6b659f155..60936be8a3 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that msgsnd(2) enqueues a message correctly.
  */
 
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
index 13db01c8a1..887bfdef2a 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that msgsnd(2) fails and sets correct errno:
  *
  * - EAGAIN if the message can't be sent due to the msg_qbytes limit for the
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 2ceea58465..ae637e5d7a 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Stress test for SysV IPC. We send multiple messages at the same time,
  * checking that we are not loosing any byte once we receive the messages
  * from multiple children.
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl01.c b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
index ff691adf86..92a36bff07 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
@@ -3,8 +3,6 @@
  * Copyright (c) International Business Machines  Corp., 2001
  */
 /*\
- * [Description]
- *
  * Test the 13 possible semctl() commands
  */
 
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl02.c b/testcases/kernel/syscalls/ipc/semctl/semctl02.c
index 3134dde576..6ca63472c2 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl02.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl02.c
@@ -5,8 +5,6 @@
  *	03/2001 - Written by Wayne Boyer
  */
 /*\
- * [Description]
- *
  * Test for semctl() EACCES error.
  */
 
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl03.c b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
index f9f335e4a8..11530b2013 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl03.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
@@ -6,8 +6,6 @@
  *	03/2001 - Written by Wayne Boyer
  */
 /*\
- * [Description]
- *
  * Test for semctl() EINVAL and EFAULT errors
  */
 
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl04.c b/testcases/kernel/syscalls/ipc/semctl/semctl04.c
index 015850a3bf..f6fa361b27 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl04.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl04.c
@@ -6,8 +6,6 @@
  *	03/2001 - Written by Wayne Boyer
  */
 /*\
- * [Description]
- *
  * Test for semctl() EPERM error
  *
  * Runs IPC_SET and IPC_RMID from unprivileged child process.
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl05.c b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
index 69df087502..5feee00821 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl05.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
@@ -7,8 +7,6 @@
  *	03/2001 - Written by Wayne Boyer
  */
 /*\
- * [Description]
- *
  * Test for semctl() ERANGE error
  */
 
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl07.c b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
index 1b203ef5e9..588fb2436c 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl07.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
@@ -10,8 +10,6 @@
  *	  to conflict with other instances of the same test.
  */
 /*\
- * [Description]
- *
  * Basic tests for semctl().
  *
  * - semctl() with IPC_STAT where we check the semid_ds buf content
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl08.c b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
index aefa83da9c..f4549adf43 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl08.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Cross verify the _high fields being set to 0 by the kernel.
  */
 
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl09.c b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
index efbc67f33d..32b411efd9 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl09.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
@@ -4,8 +4,6 @@
  * Author: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
  */
 /*\
- * [Description]
- *
  * Call semctl() with SEM_INFO flag and check that:
  *
  * * The returned index points to a valid SEM by calling SEM_STAT_ANY
diff --git a/testcases/kernel/syscalls/ipc/semget/semget01.c b/testcases/kernel/syscalls/ipc/semget/semget01.c
index 872acabd32..3c05517e45 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget01.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This case checks that semget() correclty creates a semaphore set.
  */
 
diff --git a/testcases/kernel/syscalls/ipc/semget/semget02.c b/testcases/kernel/syscalls/ipc/semget/semget02.c
index 4273c84c74..d381bbd69f 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget02.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This basic error handing of the semget syscall.
  *
  * - EACCES - a semaphore set exists for key, but the calling process does not
diff --git a/testcases/kernel/syscalls/ipc/semget/semget05.c b/testcases/kernel/syscalls/ipc/semget/semget05.c
index b49e5653c7..0e41a15280 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget05.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget05.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for ENOSPC error.
  *
  * ENOSPC - a semaphore set exceed the maximum number of semaphore sets(SEMMNI)
diff --git a/testcases/kernel/syscalls/ipc/semop/semop04.c b/testcases/kernel/syscalls/ipc/semop/semop04.c
index 1f49e77408..f1fa549e89 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop04.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop04.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Creates a semaphore and two processes.  The processes
  * each go through a loop where they semdown, delay for a
  * random amount of time, and semup, so they will almost
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat04.c b/testcases/kernel/syscalls/ipc/shmat/shmat04.c
index 9dda5c77a7..7b7b802cbc 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat04.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * When debugging issues with a workload using SysV shmem, Michal Hocko has
  * come up with a reproducer that shows how a series of mprotect()
  * operations can result in an elevated shm_nattch and thus leak of the
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index e631b7b217..1eec079893 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that shmctl() IPC_STAT and SHM_STAT reports correct data.
  *
  * The shm_nattach is excercised by:
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
index 5c6dc5333a..0b12944ce8 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
@@ -9,8 +9,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for EACCES, EFAULT and EINVAL errors.
  *
  * * EACCES - segment has no read or write permissions
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
index 199ee41052..a3291c37f1 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Call shmctl() with IPC_INFO flag and check that the data are consistent with
  * /proc/sys/kernel/shm*.
  */
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
index b244026ce3..da73863dd6 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Call shmctl() with SHM_INFO flag and check that:
  *
  * * The returned index points to a valid SHM by calling SHM_STAT_ANY
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index 6d9a53b9b9..84d512cfde 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Regression test for commit
  * 3f05317d9889 (ipc/shm: fix use-after-free of shm file via remap_file_pages()).
  *
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
index 92aaa38e26..63e7f843d4 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Cross verify the _high fields being set to 0 by the kernel.
  */
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
index 15af7b4526..1cc07ead21 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for a SHM_LOCK and SHM_UNLOCK.
  */
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
index bb2abca4c9..f72f9f9e5e 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for a SHM_SET.
  *
  * The test clears the group and others bits from the shm_perm.mode and checks
diff --git a/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c b/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
index 551daac9cc..0a6d4096c8 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
+++ b/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This case check whether we get SIGSEGV when write a value to a detached
  * shared memory resource.
  */
diff --git a/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c b/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
index 782c6f4882..a3b20f8ff4 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
+++ b/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests basic error handing of the shmdt syscall.
  *
  * -EINVAL there is no shared memory segment attached at shmaddr.
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
index 10b8c92925..8a0961b04c 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for ENOENT, EEXIST, EINVAL, EACCES, EPERM errors.
  *
  * - ENOENT - No segment exists for the given key and IPC_CREAT was not specified.
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
index 8b157e4397..092f2170e5 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for ENOSPC error.
  *
  * ENOSPC -  All possible shared memory segments have been taken (SHMMNI).
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget04.c b/testcases/kernel/syscalls/ipc/shmget/shmget04.c
index 0e48b09542..2a6a676cd6 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget04.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for EACCES error.
  *
  * Create a shared memory segment without read or write permissions under
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget05.c b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
index 42a115474a..d96a98546d 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget05.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * It is a basic test for shm_next_id.
  *
  * shm_next_id specifies desired id for next allocated IPC shared memory. By
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget06.c b/testcases/kernel/syscalls/ipc/shmget/shmget06.c
index d91b7b6354..f4bd61bca0 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget06.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget06.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * It is a basic test for shm_next_id.
  *
  * When the shared memory segment identifier that shm_next_id stored is already
diff --git a/testcases/kernel/syscalls/kcmp/kcmp01.c b/testcases/kernel/syscalls/kcmp/kcmp01.c
index c8fd48466d..50544f46e2 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp01.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that
  *
  * 1. kcmp() returns 0 with two process and two file descriptors refering to the
diff --git a/testcases/kernel/syscalls/kcmp/kcmp02.c b/testcases/kernel/syscalls/kcmp/kcmp02.c
index d5696b70c3..cf76e2cc82 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp02.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, kcmp() returns -1 and sets errno to
  *
  * 1. ESRCH if pid does not exist
diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
index 37d5118d55..a3133335c9 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp03.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, kcmp() returns 0 if the processes
  *
  * 1. share the same file system information
diff --git a/testcases/kernel/syscalls/keyctl/keyctl01.c b/testcases/kernel/syscalls/keyctl/keyctl01.c
index 674094eec7..181e37dd10 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl01.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl01.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests the keyctl(2) syscall.
  *
  * Manipulate the kernel's key management facility.
diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index 788e9657cd..3c5a2501e6 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl02.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Regression test for the race between keyctl_read() and
  * keyctl_revoke(), if the revoke happens between keyctl_read()
  * checking the validity of a key and the key's semaphore being taken,
diff --git a/testcases/kernel/syscalls/keyctl/keyctl03.c b/testcases/kernel/syscalls/keyctl/keyctl03.c
index 563ee96a96..da97b24c2f 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl03.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Regression test for commit
  * f05819df10d7 ("KEYS: Fix crash when attempt to garbage collect an uninstantiated keyring")
  */
diff --git a/testcases/kernel/syscalls/keyctl/keyctl04.c b/testcases/kernel/syscalls/keyctl/keyctl04.c
index 50c9244deb..aff95a576c 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl04.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Regression test for commit c9f838d104fe ("KEYS: fix
  * keyctl_set_reqkey_keyring() to not leak thread keyrings"), a.k.a.
  * CVE-2017-7472.  This bug could be used to exhaust kernel memory, though it
diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
index 0ad106774c..cd738fb3c0 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl05.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Regression test for commit 63a0b0509e70 ("KEYS: fix freeing uninitialized
  * memory in key_update()").  Try to reproduce the crash in two different ways:
  *
diff --git a/testcases/kernel/syscalls/keyctl/keyctl06.c b/testcases/kernel/syscalls/keyctl/keyctl06.c
index 4564601d1c..3e23e91425 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl06.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl06.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Regression test for commit:
  *
  * e645016abc80 ("KEYS: fix writing past end of user-supplied buffer in keyring_read()")
diff --git a/testcases/kernel/syscalls/keyctl/keyctl07.c b/testcases/kernel/syscalls/keyctl/keyctl07.c
index 8b10ee8033..e4e0ff570f 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl07.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl07.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Regression test for commit 37863c43b2c6 ("KEYS: prevent KEYCTL_READ on
  * negative key").  This is CVE-2017-12192.
  */
diff --git a/testcases/kernel/syscalls/keyctl/keyctl08.c b/testcases/kernel/syscalls/keyctl/keyctl08.c
index 30e077c50a..e038123ef5 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl08.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl08.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2016-9604, checks that keys beginning with "." are disallowed.
  *
  * See commit
diff --git a/testcases/kernel/syscalls/keyctl/keyctl09.c b/testcases/kernel/syscalls/keyctl/keyctl09.c
index 1f24f804a3..00ff61dafb 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl09.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test that encrypted keys can be instantiated using user-provided decrypted
  * data that is hex-ascii encoded.
  */
diff --git a/testcases/kernel/syscalls/kill/kill13.c b/testcases/kernel/syscalls/kill/kill13.c
index 66ae37bc0f..ca281ca6c9 100644
--- a/testcases/kernel/syscalls/kill/kill13.c
+++ b/testcases/kernel/syscalls/kill/kill13.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Reproducer of CVE-2018-10124; INT_MIN negation.
  *
  * On most two's complement CPUs negation of INT_MIN will result in
diff --git a/testcases/kernel/syscalls/landlock/landlock01.c b/testcases/kernel/syscalls/landlock/landlock01.c
index d0d68c8e4d..bf206dae77 100644
--- a/testcases/kernel/syscalls/landlock/landlock01.c
+++ b/testcases/kernel/syscalls/landlock/landlock01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that landlock_create_ruleset syscall fails with the right
  * error codes:
  *
diff --git a/testcases/kernel/syscalls/landlock/landlock02.c b/testcases/kernel/syscalls/landlock/landlock02.c
index e1e3228b54..60010f554b 100644
--- a/testcases/kernel/syscalls/landlock/landlock02.c
+++ b/testcases/kernel/syscalls/landlock/landlock02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that landlock_add_rule syscall fails with the right
  * error codes:
  *
diff --git a/testcases/kernel/syscalls/landlock/landlock03.c b/testcases/kernel/syscalls/landlock/landlock03.c
index 150c8cc4e5..3c0cd56b0a 100644
--- a/testcases/kernel/syscalls/landlock/landlock03.c
+++ b/testcases/kernel/syscalls/landlock/landlock03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that landlock_restrict_self syscall fails with the right
  * error codes:
  *
diff --git a/testcases/kernel/syscalls/landlock/landlock04.c b/testcases/kernel/syscalls/landlock/landlock04.c
index 2faba7a2b8..737fdbf244 100644
--- a/testcases/kernel/syscalls/landlock/landlock04.c
+++ b/testcases/kernel/syscalls/landlock/landlock04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that all landlock filesystem rules are working properly.
  * The way we do it is to verify that all disabled syscalls are not working but
  * the one we enabled via specifc landlock rules.
diff --git a/testcases/kernel/syscalls/landlock/landlock05.c b/testcases/kernel/syscalls/landlock/landlock05.c
index 3d5048f0ab..ad5e932b07 100644
--- a/testcases/kernel/syscalls/landlock/landlock05.c
+++ b/testcases/kernel/syscalls/landlock/landlock05.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies LANDLOCK_ACCESS_FS_REFER access in the
  * landlock sandbox.
  *
diff --git a/testcases/kernel/syscalls/landlock/landlock06.c b/testcases/kernel/syscalls/landlock/landlock06.c
index 74237d1165..c2ac20d593 100644
--- a/testcases/kernel/syscalls/landlock/landlock06.c
+++ b/testcases/kernel/syscalls/landlock/landlock06.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies LANDLOCK_ACCESS_FS_IOCTL_DEV access in the
  * landlock sandbox by creating a pipe and testing that ioctl() can be executed
  * on it. The test is also verifying that some of the I/O operations can be
diff --git a/testcases/kernel/syscalls/landlock/landlock07.c b/testcases/kernel/syscalls/landlock/landlock07.c
index 8ee6148563..7ef0f756ac 100644
--- a/testcases/kernel/syscalls/landlock/landlock07.c
+++ b/testcases/kernel/syscalls/landlock/landlock07.c
@@ -4,8 +4,6 @@
  */
 
 /**
- * [Description]
- *
  * CVE-2024-42318
  *
  * Test to check if system is affected by Landlock Houdini bug:
diff --git a/testcases/kernel/syscalls/landlock/landlock08.c b/testcases/kernel/syscalls/landlock/landlock08.c
index c3c320c340..7c498e6d58 100644
--- a/testcases/kernel/syscalls/landlock/landlock08.c
+++ b/testcases/kernel/syscalls/landlock/landlock08.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify the landlock support for bind()/connect() syscalls in IPV4 and IPV6
  * protocols. In particular, check that bind() is assigning the address only on
  * the TCP port enforced by LANDLOCK_ACCESS_NET_BIND_TCP and check that
diff --git a/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c b/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
index 221f9157a4..f98d11d8f0 100644
--- a/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
+++ b/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check the basic functionality of the lgetxattr(2).
  *
  * In the case of a symbolic link, lgetxattr(2) only gets the value of the
diff --git a/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c b/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
index db94890c4b..459c1bf7a7 100644
--- a/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
+++ b/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, lgetxattr(2) returns -1 and sets errno to
  *
  * 1. ENODATA if the named attribute does not exist.
diff --git a/testcases/kernel/syscalls/link/link02.c b/testcases/kernel/syscalls/link/link02.c
index 3d265d6eb1..248e2c5b3b 100644
--- a/testcases/kernel/syscalls/link/link02.c
+++ b/testcases/kernel/syscalls/link/link02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests that link(2) succeeds.
  */
 
diff --git a/testcases/kernel/syscalls/link/link04.c b/testcases/kernel/syscalls/link/link04.c
index 9940ac665c..1647785be2 100644
--- a/testcases/kernel/syscalls/link/link04.c
+++ b/testcases/kernel/syscalls/link/link04.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Negative test cases for link(2).
  *
  * This test program should contain test cases where link will fail regardless
diff --git a/testcases/kernel/syscalls/link/link05.c b/testcases/kernel/syscalls/link/link05.c
index b6c49bccaa..f3f282377a 100644
--- a/testcases/kernel/syscalls/link/link05.c
+++ b/testcases/kernel/syscalls/link/link05.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests that link(2) succeeds with creating 1000 links.
  */
 
diff --git a/testcases/kernel/syscalls/link/link08.c b/testcases/kernel/syscalls/link/link08.c
index 92d5074890..713001a33e 100644
--- a/testcases/kernel/syscalls/link/link08.c
+++ b/testcases/kernel/syscalls/link/link08.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that:
  *
  * - link() fails with EPERM if the old path is a directory.
diff --git a/testcases/kernel/syscalls/listmount/listmount01.c b/testcases/kernel/syscalls/listmount/listmount01.c
index 604e5ce926..5090ae7bcf 100644
--- a/testcases/kernel/syscalls/listmount/listmount01.c
+++ b/testcases/kernel/syscalls/listmount/listmount01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that listmount() is properly recognizing a mounted
  * root directory using LSMT_ROOT flag.
  *
diff --git a/testcases/kernel/syscalls/listmount/listmount02.c b/testcases/kernel/syscalls/listmount/listmount02.c
index 4b831b615b..a8ee037ff3 100644
--- a/testcases/kernel/syscalls/listmount/listmount02.c
+++ b/testcases/kernel/syscalls/listmount/listmount02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that listmount() is properly reading groups of mount IDs,
  * checking that both oneshoot and iterator API for listmount() return the same
  * array.
diff --git a/testcases/kernel/syscalls/listmount/listmount03.c b/testcases/kernel/syscalls/listmount/listmount03.c
index befe0edaf4..dfbf2bdd25 100644
--- a/testcases/kernel/syscalls/listmount/listmount03.c
+++ b/testcases/kernel/syscalls/listmount/listmount03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that listmount() raises EPERM when mount point is not accessible.
  */
 
diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
index d38408d2c2..503346de8d 100644
--- a/testcases/kernel/syscalls/listmount/listmount04.c
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that listmount() raises the correct errors according with
  * invalid data:
  *
diff --git a/testcases/kernel/syscalls/listxattr/listxattr01.c b/testcases/kernel/syscalls/listxattr/listxattr01.c
index d3c3794cd7..73489a7701 100644
--- a/testcases/kernel/syscalls/listxattr/listxattr01.c
+++ b/testcases/kernel/syscalls/listxattr/listxattr01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for listxattr(2) system call.
  *
  * listxattr(2) retrieves the list of extended attribute names
diff --git a/testcases/kernel/syscalls/listxattr/listxattr02.c b/testcases/kernel/syscalls/listxattr/listxattr02.c
index 0dc83cb404..78b48821d1 100644
--- a/testcases/kernel/syscalls/listxattr/listxattr02.c
+++ b/testcases/kernel/syscalls/listxattr/listxattr02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for listxattr error.
  *
  * - ERANGE - the size of the list buffer is too small to hold the result.
diff --git a/testcases/kernel/syscalls/listxattr/listxattr03.c b/testcases/kernel/syscalls/listxattr/listxattr03.c
index 31125e8cd0..0fe072b8bb 100644
--- a/testcases/kernel/syscalls/listxattr/listxattr03.c
+++ b/testcases/kernel/syscalls/listxattr/listxattr03.c
@@ -6,8 +6,6 @@
  */
 
 /*
- * [Description]
- *
  * Test for returning the current size of the list of extended attribute names,
  * with size specified as zero.
  */
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr01.c b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
index 5002fe96fb..e36f244c94 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr01.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for llistxattr(2), retrieves the list of extended attribute names
  * associated with the link itself in the filesystem.
  */
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr02.c b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
index c91d05f359..6d7f716e5d 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr02.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify llistxattr(2) returns -1 and set proper errno:
  *
  * - ERANGE if the size of the list buffer is too small to hold the result
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr03.c b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
index cbf8da026b..11b3243cd5 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr03.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that llistxattr(2) call with zero size returns the current size of the
  * list of extended attribute names, which can be used to determine the size of
  * the buffer that should be supplied in a subsequent llistxattr(2) call.
diff --git a/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c b/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
index ec27bbbc78..5761b1429a 100644
--- a/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
+++ b/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * lremovexattr(2) removes the extended attribute identified by a name and
  * associated with a given path in the filesystem. Unlike removexattr(2),
  * lremovexattr(2) removes the attribute from the symbolic link only, and not
diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
index d48af180b0..a0ff4dc9b5 100644
--- a/testcases/kernel/syscalls/lstat/lstat03.c
+++ b/testcases/kernel/syscalls/lstat/lstat03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that lstat() provides correct information according
  * with device, access time, block size, ownership, etc.
  * The implementation provides a set of tests which are specific for each one
diff --git a/testcases/kernel/syscalls/madvise/madvise03.c b/testcases/kernel/syscalls/madvise/madvise03.c
index cd63affc14..d27bc7cb29 100644
--- a/testcases/kernel/syscalls/madvise/madvise03.c
+++ b/testcases/kernel/syscalls/madvise/madvise03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that successful madvise(2) MADV_DONTNEED operation will result in
  * zero-fill-on-demand pages for anonymous private mappings.
  */
diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 9cc64ceb58..51861a5daa 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Page fault occurs in spite that madvise(WILLNEED) system call is called
  * to prefetch the page. This issue is reproduced by running a program
  * which sequentially accesses to a shared memory and calls madvise(WILLNEED)
diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index cfe9d7f170..fd721ecad2 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Stress a possible race condition between memory pages allocation
  * and soft-offline of unrelated pages as explained in the commit:
  *   d4ae9916ea29 (mm: soft-offline: close the race against page allocation)
diff --git a/testcases/kernel/syscalls/madvise/madvise12.c b/testcases/kernel/syscalls/madvise/madvise12.c
index 19f9f9d10b..8a8be5f1da 100644
--- a/testcases/kernel/syscalls/madvise/madvise12.c
+++ b/testcases/kernel/syscalls/madvise/madvise12.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that MADV_GUARD_INSTALL is causing SIGSEGV when someone is accessing
  * memory advised with it.
  *
diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo01.c b/testcases/kernel/syscalls/mallinfo/mallinfo01.c
index 48fce0132f..c5c7d406f7 100644
--- a/testcases/kernel/syscalls/mallinfo/mallinfo01.c
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic mallinfo() test. Refer to glibc test mallinfo2 test
  * https://sourceware.org/git/?p=glibc.git;a=blob;f=malloc/tst-mallinfo2.c
  */
diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo02.c b/testcases/kernel/syscalls/mallinfo/mallinfo02.c
index 6012b4e223..867079a3dd 100644
--- a/testcases/kernel/syscalls/mallinfo/mallinfo02.c
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic mallinfo() test for malloc() using sbrk or mmap.
  * It size > MMAP_THRESHOLD, it will use mmap. Otherwise, use sbrk.
  */
diff --git a/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c b/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c
index 51783fc22b..60e0e8af75 100644
--- a/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c
+++ b/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic mallinfo2() test.
  *
  * Test hblkhd member of struct mallinfo2 whether overflow when setting 2G size.
diff --git a/testcases/kernel/syscalls/mallopt/mallopt01.c b/testcases/kernel/syscalls/mallopt/mallopt01.c
index 8ff4649e3d..77cd18a704 100644
--- a/testcases/kernel/syscalls/mallopt/mallopt01.c
+++ b/testcases/kernel/syscalls/mallopt/mallopt01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic mallinfo() and mallopt() testing.
  */
 
diff --git a/testcases/kernel/syscalls/memcmp/memcmp01.c b/testcases/kernel/syscalls/memcmp/memcmp01.c
index 836cf4043e..38f121bdbb 100644
--- a/testcases/kernel/syscalls/memcmp/memcmp01.c
+++ b/testcases/kernel/syscalls/memcmp/memcmp01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * The testcase for buffer comparison by check boundary conditions.
  */
 
diff --git a/testcases/kernel/syscalls/memcpy/memcpy01.c b/testcases/kernel/syscalls/memcpy/memcpy01.c
index 0b64d70e66..b19f4145e7 100644
--- a/testcases/kernel/syscalls/memcpy/memcpy01.c
+++ b/testcases/kernel/syscalls/memcpy/memcpy01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * The testcase for buffer copy by check boundary conditions.
  */
 
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create04.c b/testcases/kernel/syscalls/memfd_create/memfd_create04.c
index 585f17e161..8a12a72ff3 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create04.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Validating memfd_create() with MFD_HUGETLB and MFD_HUGE_x flags.
  *
  * Attempt to create files in the hugetlbfs filesystem using different huge page
diff --git a/testcases/kernel/syscalls/memset/memset01.c b/testcases/kernel/syscalls/memset/memset01.c
index 17ae42c017..5a34eb40c6 100644
--- a/testcases/kernel/syscalls/memset/memset01.c
+++ b/testcases/kernel/syscalls/memset/memset01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * The testcase for test setting of buffer by check boundary conditions.
  */
 
diff --git a/testcases/kernel/syscalls/mincore/mincore02.c b/testcases/kernel/syscalls/mincore/mincore02.c
index 1918d6c083..af3549ac3d 100644
--- a/testcases/kernel/syscalls/mincore/mincore02.c
+++ b/testcases/kernel/syscalls/mincore/mincore02.c
@@ -9,8 +9,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test case provides a functional validation for mincore system call.
  * We mmap a file of known size (multiple of page size) and lock it in
  * memory. Then we obtain page location information via mincore and compare
diff --git a/testcases/kernel/syscalls/mkdir/mkdir02.c b/testcases/kernel/syscalls/mkdir/mkdir02.c
index 7fa055b8df..519c243ec7 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir02.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that new directory created by mkdir(2) inherites the group ID from
  * the parent directory and S_ISGID bit, if the S_ISGID bit is set in the
  * parent directory.
diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
index 85d46801eb..7bbb76e9e5 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir03.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check mkdir() with various error conditions that should produce
  * EFAULT, ENAMETOOLONG, EEXIST, ENOENT, ENOTDIR, ELOOP and EROFS.
  *
diff --git a/testcases/kernel/syscalls/mkdir/mkdir09.c b/testcases/kernel/syscalls/mkdir/mkdir09.c
index 44a2348be8..8f995c9699 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir09.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir09.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Create multiple processes which create subdirectories in the
  * same directory multiple times within test time.
  */
diff --git a/testcases/kernel/syscalls/mknod/mknod01.c b/testcases/kernel/syscalls/mknod/mknod01.c
index f800b996da..fe0a1cfa6a 100644
--- a/testcases/kernel/syscalls/mknod/mknod01.c
+++ b/testcases/kernel/syscalls/mknod/mknod01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that mknod(2) successfully creates a filesystem node with
  * various modes.
  */
diff --git a/testcases/kernel/syscalls/mknod/mknod02.c b/testcases/kernel/syscalls/mknod/mknod02.c
index b1885fed13..89dd1d8740 100644
--- a/testcases/kernel/syscalls/mknod/mknod02.c
+++ b/testcases/kernel/syscalls/mknod/mknod02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that if mknod(2) creates a filesystem node in a directory which
  * does not have the set-group-ID bit set, new node will not inherit the
  * group ownership from its parent directory and its group ID will be the
diff --git a/testcases/kernel/syscalls/mknod/mknod09.c b/testcases/kernel/syscalls/mknod/mknod09.c
index e3b5dceae1..bb6e58a93d 100644
--- a/testcases/kernel/syscalls/mknod/mknod09.c
+++ b/testcases/kernel/syscalls/mknod/mknod09.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that mknod() fails with -1 and sets errno to EINVAL if the mode is
  * different than a normal file, device special file or FIFO.
  */
diff --git a/testcases/kernel/syscalls/mlock/mlock01.c b/testcases/kernel/syscalls/mlock/mlock01.c
index 0b079f8be8..007cffa2e7 100644
--- a/testcases/kernel/syscalls/mlock/mlock01.c
+++ b/testcases/kernel/syscalls/mlock/mlock01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test mlock with various valid addresses and lengths.
  */
 
diff --git a/testcases/kernel/syscalls/mlock/mlock02.c b/testcases/kernel/syscalls/mlock/mlock02.c
index 921ddeeae7..799a2276b5 100644
--- a/testcases/kernel/syscalls/mlock/mlock02.c
+++ b/testcases/kernel/syscalls/mlock/mlock02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for ENOMEM, EPERM errors.
  *
  * 1) mlock(2) fails with ENOMEM if some of the specified address range
diff --git a/testcases/kernel/syscalls/mlock/mlock03.c b/testcases/kernel/syscalls/mlock/mlock03.c
index 602bb65d8a..0ac5112d92 100644
--- a/testcases/kernel/syscalls/mlock/mlock03.c
+++ b/testcases/kernel/syscalls/mlock/mlock03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This case is a regression test on old RHEL5.
  *
  * Stack size mapping is decreased through mlock/munlock call.
diff --git a/testcases/kernel/syscalls/mlock/mlock04.c b/testcases/kernel/syscalls/mlock/mlock04.c
index 64f1bc5a03..226c4e2559 100644
--- a/testcases/kernel/syscalls/mlock/mlock04.c
+++ b/testcases/kernel/syscalls/mlock/mlock04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This is a reproducer copied from one of LKML patch submission
  * which subject is
  *
diff --git a/testcases/kernel/syscalls/mlock/mlock05.c b/testcases/kernel/syscalls/mlock/mlock05.c
index 8e805736dc..4e432fc8db 100644
--- a/testcases/kernel/syscalls/mlock/mlock05.c
+++ b/testcases/kernel/syscalls/mlock/mlock05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify mlock() causes pre-faulting of PTEs and prevent memory to be swapped out.
  *
  * Find the new mapping in /proc/$pid/smaps and check Rss and Locked fields after
diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
index 05802bceba..9a0c01aa6b 100644
--- a/testcases/kernel/syscalls/mmap/mmap01.c
+++ b/testcases/kernel/syscalls/mmap/mmap01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that mmap() succeeds when used to map a file where size of the
  * file is not a multiple of the page size, the memory area beyond the end
  * of the file to the end of the page is accessible. Also, verify that
diff --git a/testcases/kernel/syscalls/mmap/mmap02.c b/testcases/kernel/syscalls/mmap/mmap02.c
index 7ffe61fa38..21cac4b444 100644
--- a/testcases/kernel/syscalls/mmap/mmap02.c
+++ b/testcases/kernel/syscalls/mmap/mmap02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, mmap() call with PROT_READ and a file descriptor which is
  * open for read only, succeeds to map a file creating mapped memory with
  * read access.
diff --git a/testcases/kernel/syscalls/mmap/mmap04.c b/testcases/kernel/syscalls/mmap/mmap04.c
index fa85deed12..4a050b7b50 100644
--- a/testcases/kernel/syscalls/mmap/mmap04.c
+++ b/testcases/kernel/syscalls/mmap/mmap04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, after a successful mmap() call, permission bits of the new
  * mapping in /proc/pid/maps file matches the prot and flags arguments in
  * mmap() call.
diff --git a/testcases/kernel/syscalls/mmap/mmap05.c b/testcases/kernel/syscalls/mmap/mmap05.c
index 7abddaa9e4..445b5a33e7 100644
--- a/testcases/kernel/syscalls/mmap/mmap05.c
+++ b/testcases/kernel/syscalls/mmap/mmap05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, mmap() call with 'PROT_NONE' and a file descriptor which is
  * open for read and write, succeeds to map the file creating mapped memory,
  * but any attempt to access the contents of the mapped region causes the
diff --git a/testcases/kernel/syscalls/mmap/mmap06.c b/testcases/kernel/syscalls/mmap/mmap06.c
index 9d983250c8..3c2ca0d056 100644
--- a/testcases/kernel/syscalls/mmap/mmap06.c
+++ b/testcases/kernel/syscalls/mmap/mmap06.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, mmap() call fails with errno:
  *
  * - EACCES, when a file mapping is requested but the file descriptor is not open for reading.
diff --git a/testcases/kernel/syscalls/mmap/mmap08.c b/testcases/kernel/syscalls/mmap/mmap08.c
index 18db0b46f7..4cb9a46f9a 100644
--- a/testcases/kernel/syscalls/mmap/mmap08.c
+++ b/testcases/kernel/syscalls/mmap/mmap08.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, mmap() calls fails with errno EBADF when a file mapping
  * is requested but the fd is not a valid file descriptor.
  */
diff --git a/testcases/kernel/syscalls/mmap/mmap09.c b/testcases/kernel/syscalls/mmap/mmap09.c
index 16634dc302..8c6b514ab8 100644
--- a/testcases/kernel/syscalls/mmap/mmap09.c
+++ b/testcases/kernel/syscalls/mmap/mmap09.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that truncating a mmaped file works correctly.
  *
  * Use ftruncate to:
diff --git a/testcases/kernel/syscalls/mmap/mmap13.c b/testcases/kernel/syscalls/mmap/mmap13.c
index 7298f5de53..34ac1a5329 100644
--- a/testcases/kernel/syscalls/mmap/mmap13.c
+++ b/testcases/kernel/syscalls/mmap/mmap13.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, mmap() call succeeds to create a file mapping with length
  * argument greater than the file size but any attempt to reference the
  * memory region which does not correspond to the file causes SIGBUS signal.
diff --git a/testcases/kernel/syscalls/mmap/mmap14.c b/testcases/kernel/syscalls/mmap/mmap14.c
index de35982f91..7bded88cc7 100644
--- a/testcases/kernel/syscalls/mmap/mmap14.c
+++ b/testcases/kernel/syscalls/mmap/mmap14.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify basic functionality of mmap(2) with MAP_LOCKED.
  *
  * mmap(2) should succeed returning the address of the mapped region,
diff --git a/testcases/kernel/syscalls/mmap/mmap15.c b/testcases/kernel/syscalls/mmap/mmap15.c
index 2128e0b57e..6681617a32 100644
--- a/testcases/kernel/syscalls/mmap/mmap15.c
+++ b/testcases/kernel/syscalls/mmap/mmap15.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, a normal page cannot be mapped into a high memory region,
  * and mmap() call fails with either ENOMEM or EINVAL errno.
  */
diff --git a/testcases/kernel/syscalls/mmap/mmap16.c b/testcases/kernel/syscalls/mmap/mmap16.c
index 6b1708dff9..2b8b36c5bc 100644
--- a/testcases/kernel/syscalls/mmap/mmap16.c
+++ b/testcases/kernel/syscalls/mmap/mmap16.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This is a regression test for a silent data corruption for a mmaped file
  * when filesystem gets out of space.
  *
diff --git a/testcases/kernel/syscalls/mmap/mmap19.c b/testcases/kernel/syscalls/mmap/mmap19.c
index 90b3f45b1f..e622539c32 100644
--- a/testcases/kernel/syscalls/mmap/mmap19.c
+++ b/testcases/kernel/syscalls/mmap/mmap19.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * If the kernel fails to correctly flush the TLB entry, the second mmap
  * will not show the correct data.
  *
diff --git a/testcases/kernel/syscalls/mmap/mmap20.c b/testcases/kernel/syscalls/mmap/mmap20.c
index 02d150e457..09dea8c41d 100644
--- a/testcases/kernel/syscalls/mmap/mmap20.c
+++ b/testcases/kernel/syscalls/mmap/mmap20.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test mmap(2) with MAP_SHARED_VALIDATE flag.
  *
  * Test expected EOPNOTSUPP errno when testing mmap(2) with MAP_SHARED_VALIDATE
diff --git a/testcases/kernel/syscalls/mount/mount01.c b/testcases/kernel/syscalls/mount/mount01.c
index 588e7c5673..a513e0fba7 100644
--- a/testcases/kernel/syscalls/mount/mount01.c
+++ b/testcases/kernel/syscalls/mount/mount01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test that checks mount() syscall works on multiple filesystems.
  */
 
diff --git a/testcases/kernel/syscalls/mount/mount02.c b/testcases/kernel/syscalls/mount/mount02.c
index ae3884f98c..734c93b77c 100644
--- a/testcases/kernel/syscalls/mount/mount02.c
+++ b/testcases/kernel/syscalls/mount/mount02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check for basic errors returned by mount(2) system call.
  *
  * - ENODEV if filesystem type not configured
diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index c3202574fc..98be3dc0a6 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check mount(2) system call with various flags.
  *
  * Verify that mount(2) syscall passes for each flag setting and validate
diff --git a/testcases/kernel/syscalls/mount/mount04.c b/testcases/kernel/syscalls/mount/mount04.c
index 5eb5ee11bf..fe0ceaef44 100644
--- a/testcases/kernel/syscalls/mount/mount04.c
+++ b/testcases/kernel/syscalls/mount/mount04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that mount(2) returns -1 and sets errno to EPERM if the user
  * is not root.
  */
diff --git a/testcases/kernel/syscalls/mount/mount05.c b/testcases/kernel/syscalls/mount/mount05.c
index 616eeee79d..66e102a322 100644
--- a/testcases/kernel/syscalls/mount/mount05.c
+++ b/testcases/kernel/syscalls/mount/mount05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for feature MS_BIND of mount, which performs a bind mount, making a file
  * or a directory subtree visible at another point within a file system.
  */
diff --git a/testcases/kernel/syscalls/mount/mount06.c b/testcases/kernel/syscalls/mount/mount06.c
index 05d6fdf868..1e06cd5808 100644
--- a/testcases/kernel/syscalls/mount/mount06.c
+++ b/testcases/kernel/syscalls/mount/mount06.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for feature MS_MOVE of mount, which moves an existing mount point to
  * a new location.
  */
diff --git a/testcases/kernel/syscalls/mount/mount07.c b/testcases/kernel/syscalls/mount/mount07.c
index 8994d0f347..30fd308059 100644
--- a/testcases/kernel/syscalls/mount/mount07.c
+++ b/testcases/kernel/syscalls/mount/mount07.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * It is a basic test for MS_NOSYMFOLLOW mount option and is copied
  * from kernel selftests nosymfollow-test.c.
  *
diff --git a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
index e500df28e9..eb32cd91a7 100644
--- a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
+++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic mount_setattr() test.
  * Test whether the basic mount attributes are set correctly.
  *
diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index cde1f3120e..e1ee733f0d 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that move_pages() properly reports failures when the memory area is
  * not valid, no page is mapped yet or the shared zero page is mapped.
  *
diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 78f17f99b0..879a89b6fd 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * *Test 1*
  *
  * This is a regression test for the race condition between move_pages()
diff --git a/testcases/kernel/syscalls/mprotect/mprotect05.c b/testcases/kernel/syscalls/mprotect/mprotect05.c
index 2b15f5bebb..cd6d81a0d6 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect05.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to check the mprotect(2) system call split and merge.
  *
  * https://bugzilla.kernel.org/show_bug.cgi?id=217061
diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify02.c b/testcases/kernel/syscalls/mq_notify/mq_notify02.c
index d979a4e9d7..5192494324 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify02.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that mq_notify() fails with EINVAL when invalid input
  * arguments are given.
  */
diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify03.c b/testcases/kernel/syscalls/mq_notify/mq_notify03.c
index bf6898cd80..30e94ab14d 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify03.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for NULL pointer dereference in mq_notify(CVE-2021-38604)
  *
  * References links:
diff --git a/testcases/kernel/syscalls/mremap/mremap06.c b/testcases/kernel/syscalls/mremap/mremap06.c
index d18da199b6..5820ad75fd 100644
--- a/testcases/kernel/syscalls/mremap/mremap06.c
+++ b/testcases/kernel/syscalls/mremap/mremap06.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Bug reproducer for 7e7757876f25 ("mm/mremap: fix vm_pgoff in vma_merge() case 3")
  */
 
diff --git a/testcases/kernel/syscalls/mseal/mseal01.c b/testcases/kernel/syscalls/mseal/mseal01.c
index 00454a766f..1b3e4c94a0 100644
--- a/testcases/kernel/syscalls/mseal/mseal01.c
+++ b/testcases/kernel/syscalls/mseal/mseal01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This is a smoke test that verifies if mseal() protects specific VMA portions
  * of a process. According to documentation, the syscall should protect memory
  * from the following actions:
diff --git a/testcases/kernel/syscalls/mseal/mseal02.c b/testcases/kernel/syscalls/mseal/mseal02.c
index 62eeb25b21..e11d7dbf40 100644
--- a/testcases/kernel/syscalls/mseal/mseal02.c
+++ b/testcases/kernel/syscalls/mseal/mseal02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check various errnos for mseal(2).
  *
  * - mseal() fails with EINVAL if flags is invalid.
diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
index 1af781a978..781a49ddb0 100644
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify msync() after writing into mmap()-ed file works.
  *
  * Write to mapped region and sync the memory back with file. Check the page
diff --git a/testcases/kernel/syscalls/munlock/munlock01.c b/testcases/kernel/syscalls/munlock/munlock01.c
index 65a49d7ee3..1ffa8c0a83 100644
--- a/testcases/kernel/syscalls/munlock/munlock01.c
+++ b/testcases/kernel/syscalls/munlock/munlock01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test munlock with various valid addresses and lengths.
  */
 
diff --git a/testcases/kernel/syscalls/munlock/munlock02.c b/testcases/kernel/syscalls/munlock/munlock02.c
index 55e313c95f..3380ab9bee 100644
--- a/testcases/kernel/syscalls/munlock/munlock02.c
+++ b/testcases/kernel/syscalls/munlock/munlock02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for ENOMEM error.
  *
  * munlock(2) fails with ENOMEM if some of the specified address range
diff --git a/testcases/kernel/syscalls/munlockall/munlockall01.c b/testcases/kernel/syscalls/munlockall/munlockall01.c
index 86469107e7..6ec028d2e9 100644
--- a/testcases/kernel/syscalls/munlockall/munlockall01.c
+++ b/testcases/kernel/syscalls/munlockall/munlockall01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that munlockall(2) unlocks all previously locked memory.
  */
 
diff --git a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
index 6535fdf5c0..db6951e1a0 100644
--- a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
+++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic name_to_handle_at() tests.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
index afd9cd0662..53e26f2ace 100644
--- a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
+++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Failure tests for name_to_handle_at().
  */
 
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep01.c b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
index bd9ae0caa6..d3c29db9f4 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep01.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that nanosleep() should return with value 0 and the process should be
  * suspended for time specified by timespec structure.
  */
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep04.c b/testcases/kernel/syscalls/nanosleep/nanosleep04.c
index 3582a3fb23..9308621b40 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep04.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep04.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that nanosleep() returns -1 and sets errno to EINVAL when failing to suspend the
  * execution of a process if the specified pause time is invalid.
  */
diff --git a/testcases/kernel/syscalls/nice/nice01.c b/testcases/kernel/syscalls/nice/nice01.c
index bc58ad14c7..94f25f3bb4 100644
--- a/testcases/kernel/syscalls/nice/nice01.c
+++ b/testcases/kernel/syscalls/nice/nice01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that root can provide a negative value to nice() system call and hence
  * root can decrease the nice value of the process using nice().
  */
diff --git a/testcases/kernel/syscalls/nice/nice02.c b/testcases/kernel/syscalls/nice/nice02.c
index b08e1d751e..0196169006 100644
--- a/testcases/kernel/syscalls/nice/nice02.c
+++ b/testcases/kernel/syscalls/nice/nice02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that any user can successfully increase the nice value of
  * the process by passing a higher increment value (> max. applicable limits)
  * to nice() system call.
diff --git a/testcases/kernel/syscalls/nice/nice03.c b/testcases/kernel/syscalls/nice/nice03.c
index 061592e6c3..7f642e0b97 100644
--- a/testcases/kernel/syscalls/nice/nice03.c
+++ b/testcases/kernel/syscalls/nice/nice03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that any user can successfully increase the nice value of
  * the process by passing an increment value (< max. applicable limits) to
  * nice() system call.
diff --git a/testcases/kernel/syscalls/nice/nice04.c b/testcases/kernel/syscalls/nice/nice04.c
index ac156008e5..052eed8d7e 100644
--- a/testcases/kernel/syscalls/nice/nice04.c
+++ b/testcases/kernel/syscalls/nice/nice04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, nice(2) fails when, a non-root user attempts to increase
  * the priority of a process by specifying a negative increment value.
  */
diff --git a/testcases/kernel/syscalls/nice/nice05.c b/testcases/kernel/syscalls/nice/nice05.c
index 2701713171..b4d8965575 100644
--- a/testcases/kernel/syscalls/nice/nice05.c
+++ b/testcases/kernel/syscalls/nice/nice05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * 1. Create a high nice thread and a low nice thread, the main
  *    thread wake them at the same time
  * 2. Both threads run on the same CPU
diff --git a/testcases/kernel/syscalls/open/open02.c b/testcases/kernel/syscalls/open/open02.c
index 3c9cc7e171..72f02d9495 100644
--- a/testcases/kernel/syscalls/open/open02.c
+++ b/testcases/kernel/syscalls/open/open02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * 1. open a new file without O_CREAT, ENOENT should be returned.
  * 2. open a file with O_RDONLY | O_NOATIME and the caller was not
  * privileged, EPERM should be returned.
diff --git a/testcases/kernel/syscalls/open/open03.c b/testcases/kernel/syscalls/open/open03.c
index 5521dfef26..275ca84f09 100644
--- a/testcases/kernel/syscalls/open/open03.c
+++ b/testcases/kernel/syscalls/open/open03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to check open() with O_RDWR | O_CREAT.
  */
 
diff --git a/testcases/kernel/syscalls/open/open04.c b/testcases/kernel/syscalls/open/open04.c
index 24ef52a29a..3dc3486d3b 100644
--- a/testcases/kernel/syscalls/open/open04.c
+++ b/testcases/kernel/syscalls/open/open04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that open(2) fails with EMFILE when per-process limit on the number
  * of open file descriptors has been reached.
  */
diff --git a/testcases/kernel/syscalls/open/open06.c b/testcases/kernel/syscalls/open/open06.c
index e167c2b6b9..7b5bd62495 100644
--- a/testcases/kernel/syscalls/open/open06.c
+++ b/testcases/kernel/syscalls/open/open06.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that open(2) fails with ENXIO when
  * O_NONBLOCK | O_WRONLY is set, the named file is a FIFO,
  * and no process has the FIFO open for reading.
diff --git a/testcases/kernel/syscalls/open/open07.c b/testcases/kernel/syscalls/open/open07.c
index 0c53798e37..a03d751178 100644
--- a/testcases/kernel/syscalls/open/open07.c
+++ b/testcases/kernel/syscalls/open/open07.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test functionality and error conditions of open(O_NOFOLLOW) system call.
  */
 
diff --git a/testcases/kernel/syscalls/open/open08.c b/testcases/kernel/syscalls/open/open08.c
index 0af455b556..ad868b0ecc 100644
--- a/testcases/kernel/syscalls/open/open08.c
+++ b/testcases/kernel/syscalls/open/open08.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that open() fails with:
  *
  * - EEXIST when pathname already exists and O_CREAT and O_EXCL were used
diff --git a/testcases/kernel/syscalls/open/open09.c b/testcases/kernel/syscalls/open/open09.c
index 0e89a87f85..36158b3c1d 100644
--- a/testcases/kernel/syscalls/open/open09.c
+++ b/testcases/kernel/syscalls/open/open09.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that a file opened with O_RDONLY can't be writable
  * and it verifies that a file opened with O_WRONLY can't be readable.
  */
diff --git a/testcases/kernel/syscalls/open/open10.c b/testcases/kernel/syscalls/open/open10.c
index 916357158a..5e27a75dd9 100644
--- a/testcases/kernel/syscalls/open/open10.c
+++ b/testcases/kernel/syscalls/open/open10.c
@@ -4,8 +4,6 @@
  * Copyright (c) 2021 SUSE LLC <mdoucha@suse.cz>
  */
 /*\
- * [Description]
- *
  * Verify that the group ID and setgid bit are set correctly when a new file
  * is created.
  */
diff --git a/testcases/kernel/syscalls/open/open11.c b/testcases/kernel/syscalls/open/open11.c
index 3431efc2ca..6f89d558dc 100644
--- a/testcases/kernel/syscalls/open/open11.c
+++ b/testcases/kernel/syscalls/open/open11.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic tests for open(2) and make sure open(2) works and handles error
  * conditions correctly.
  *
diff --git a/testcases/kernel/syscalls/open/open15.c b/testcases/kernel/syscalls/open/open15.c
index 4fa243e94e..4917937adf 100644
--- a/testcases/kernel/syscalls/open/open15.c
+++ b/testcases/kernel/syscalls/open/open15.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that open() is working correctly on symlink()
  * generated files. We generate a file via symlink, then we read both from file
  * and symlink, comparing that data has been correctly written.
diff --git a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
index 6171229f0b..29a0d83c38 100644
--- a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
+++ b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic open_by_handle_at() tests.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c
index a505deeb10..b445f1adc0 100644
--- a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c
+++ b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Failure tests for open_by_handle_at().
  */
 #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/openat/openat01.c b/testcases/kernel/syscalls/openat/openat01.c
index ad400b47fa..2e63bc2b9d 100644
--- a/testcases/kernel/syscalls/openat/openat01.c
+++ b/testcases/kernel/syscalls/openat/openat01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test case will verify basic function of openat.
  *
  * - pathname is relative, then it is interpreted relative to the directory
diff --git a/testcases/kernel/syscalls/openat/openat04.c b/testcases/kernel/syscalls/openat/openat04.c
index df5956cd84..d3f840ec4b 100644
--- a/testcases/kernel/syscalls/openat/openat04.c
+++ b/testcases/kernel/syscalls/openat/openat04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check setgid strip logic whether works correctly when creating tmpfile under
  * filesystem without POSIX ACL supported(by using noacl mount option). Test it
  * with umask S_IXGRP and also check file mode whether has filtered S_IXGRP.
diff --git a/testcases/kernel/syscalls/pathconf/pathconf01.c b/testcases/kernel/syscalls/pathconf/pathconf01.c
index 280709a910..5af45e4176 100644
--- a/testcases/kernel/syscalls/pathconf/pathconf01.c
+++ b/testcases/kernel/syscalls/pathconf/pathconf01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check the basic functionality of the pathconf(2) system call.
  */
 
diff --git a/testcases/kernel/syscalls/pathconf/pathconf02.c b/testcases/kernel/syscalls/pathconf/pathconf02.c
index a7af980ec6..8c4bf578fa 100644
--- a/testcases/kernel/syscalls/pathconf/pathconf02.c
+++ b/testcases/kernel/syscalls/pathconf/pathconf02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that,
  *
  * - pathconf() fails with ENOTDIR if a component used as a directory
diff --git a/testcases/kernel/syscalls/personality/personality01.c b/testcases/kernel/syscalls/personality/personality01.c
index 47fb66256a..05a0e17f89 100644
--- a/testcases/kernel/syscalls/personality/personality01.c
+++ b/testcases/kernel/syscalls/personality/personality01.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tries to set different personalities.
  *
  * We set the personality in a child process since it's not guaranteed that we
diff --git a/testcases/kernel/syscalls/personality/personality02.c b/testcases/kernel/syscalls/personality/personality02.c
index e080284f49..7c718dba35 100644
--- a/testcases/kernel/syscalls/personality/personality02.c
+++ b/testcases/kernel/syscalls/personality/personality02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test checks if select() timeout is not updated when personality with
  * STICKY_TIMEOUTS is used.
  */
diff --git a/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c
index 60cf6702d1..57e96405cd 100644
--- a/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c
+++ b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic pidfd_getfd() test:
  *
  * - the close-on-exec flag is set on the file descriptor returned by
diff --git a/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c
index 3431a0930e..a1ede7a929 100644
--- a/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c
+++ b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests basic error handling of the pidfd_open syscall.
  *
  * - EBADF pidfd is not a valid PID file descriptor
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
index ce07e6717a..a07259d173 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic pidfd_open() test:
  *
  * - Fetch the PID of the current process and try to get its file descriptor.
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
index 9d6c9321dd..9c382260fb 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests basic error handling of the pidfd_open syscall.
  *
  * - ESRCH the process specified by pid does not exist
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
index 16a8442f59..2a09de00c7 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This program opens the PID file descriptor of the child process created with
  * fork(). It then uses poll to monitor the file descriptor for process exit, as
  * indicated by an EPOLLIN event.
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
index 0e8ab69562..7e106ab5ed 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that the PIDFD_NONBLOCK flag works with pidfd_open() and
  * that waitid() with a non-blocking pidfd returns EAGAIN.
  */
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
index 4715850258..ab2990dbfc 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests if the pidfd_send_signal syscall behaves
  * like rt_sigqueueinfo when a pointer to a siginfo_t
  * struct is passed.
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
index a3bf994f92..31e8a1129b 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests basic error handling of the pidfd_send_signal
  * system call.
  *
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
index 20d96b1182..e1b1372746 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test checks if the pidfd_send_signal syscall wrongfully sends
  * a signal to a new process which inherited the PID of the actual
  * target process.
diff --git a/testcases/kernel/syscalls/pipe/pipe03.c b/testcases/kernel/syscalls/pipe/pipe03.c
index d20867b2bf..50f49b8e1e 100644
--- a/testcases/kernel/syscalls/pipe/pipe03.c
+++ b/testcases/kernel/syscalls/pipe/pipe03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, an attempt to write to the read end of a pipe fails with EBADF
  * and an attempt to read from the write end of a pipe also fails with EBADF.
  */
diff --git a/testcases/kernel/syscalls/pipe/pipe06.c b/testcases/kernel/syscalls/pipe/pipe06.c
index 0c6bc03bd6..29dbbdbd78 100644
--- a/testcases/kernel/syscalls/pipe/pipe06.c
+++ b/testcases/kernel/syscalls/pipe/pipe06.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, pipe(2) syscall fails with errno EMFILE when
  * limit on the number of open file descriptors has been reached.
  */
diff --git a/testcases/kernel/syscalls/pipe/pipe07.c b/testcases/kernel/syscalls/pipe/pipe07.c
index 8098007c29..d179020217 100644
--- a/testcases/kernel/syscalls/pipe/pipe07.c
+++ b/testcases/kernel/syscalls/pipe/pipe07.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, pipe(2) syscall can open the maximum number of
  * file descriptors permitted.
  */
diff --git a/testcases/kernel/syscalls/pipe/pipe08.c b/testcases/kernel/syscalls/pipe/pipe08.c
index 28088cf618..f86774d5ec 100644
--- a/testcases/kernel/syscalls/pipe/pipe08.c
+++ b/testcases/kernel/syscalls/pipe/pipe08.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, on any attempt to write to a pipe which is closed for
  * reading will generate a SIGPIPE signal and write will fail with
  * EPIPE errno.
diff --git a/testcases/kernel/syscalls/pipe/pipe10.c b/testcases/kernel/syscalls/pipe/pipe10.c
index 018e653daf..30cd983b26 100644
--- a/testcases/kernel/syscalls/pipe/pipe10.c
+++ b/testcases/kernel/syscalls/pipe/pipe10.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, when a parent process opens a pipe, a child process can
  * read from it.
  */
diff --git a/testcases/kernel/syscalls/pipe/pipe14.c b/testcases/kernel/syscalls/pipe/pipe14.c
index 2d2969d820..66d94cffaf 100644
--- a/testcases/kernel/syscalls/pipe/pipe14.c
+++ b/testcases/kernel/syscalls/pipe/pipe14.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, if the write end of a pipe is closed, then a process reading
  * from the pipe will see end-of-file (i.e., read() returns 0) once it has
  * read all remaining data in the pipe.
diff --git a/testcases/kernel/syscalls/pipe/pipe15.c b/testcases/kernel/syscalls/pipe/pipe15.c
index ebdb195b36..94b0cb1010 100644
--- a/testcases/kernel/syscalls/pipe/pipe15.c
+++ b/testcases/kernel/syscalls/pipe/pipe15.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This is a regression test for hangup on pipe operations. See
  * https://www.spinics.net/lists/linux-api/msg49762.html for
  * additional context. It tests that pipe operations do not block
diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
index 444799670e..8cbe2d6b5a 100644
--- a/testcases/kernel/syscalls/pkeys/pkey01.c
+++ b/testcases/kernel/syscalls/pkeys/pkey01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Memory Protection Keys for Userspace (PKU aka PKEYs) is a Skylake-SP
  * server feature that provides a mechanism for enforcing page-based
  * protections, but without requiring modification of the page tables
diff --git a/testcases/kernel/syscalls/prctl/prctl01.c b/testcases/kernel/syscalls/prctl/prctl01.c
index 939ca38c09..ca3f39a6b1 100644
--- a/testcases/kernel/syscalls/prctl/prctl01.c
+++ b/testcases/kernel/syscalls/prctl/prctl01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for PR_SET_PDEATHSIG/PR_GET_PDEATHSIG
  *
  * Use PR_SET_PDEATHSIG to set SIGUSR2 signal and PR_GET_PDEATHSIG should
diff --git a/testcases/kernel/syscalls/prctl/prctl02.c b/testcases/kernel/syscalls/prctl/prctl02.c
index 1cd33f88ca..8d865fb067 100644
--- a/testcases/kernel/syscalls/prctl/prctl02.c
+++ b/testcases/kernel/syscalls/prctl/prctl02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * - EINVAL when an invalid value is given for option
  * - EINVAL when option is PR_SET_PDEATHSIG & arg2 is not zero or a valid
  *   signal number
diff --git a/testcases/kernel/syscalls/prctl/prctl03.c b/testcases/kernel/syscalls/prctl/prctl03.c
index bac918e890..cd70c39a43 100644
--- a/testcases/kernel/syscalls/prctl/prctl03.c
+++ b/testcases/kernel/syscalls/prctl/prctl03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test PR_SET_CHILD_SUBREAPER and PR_GET_CHILD_SUBREAPER of prctl(2).
  *
  * - If PR_SET_CHILD_SUBREAPER marks a process as a child subreaper, it
diff --git a/testcases/kernel/syscalls/prctl/prctl05.c b/testcases/kernel/syscalls/prctl/prctl05.c
index dd596630e5..a014ba89e9 100644
--- a/testcases/kernel/syscalls/prctl/prctl05.c
+++ b/testcases/kernel/syscalls/prctl/prctl05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test PR_GET_NAME and PR_SET_NAME of prctl(2).
  *
  * - Set the name of the calling thread, the name can be up to 16 bytes
diff --git a/testcases/kernel/syscalls/prctl/prctl06.c b/testcases/kernel/syscalls/prctl/prctl06.c
index a9b35b2464..087b2935ee 100644
--- a/testcases/kernel/syscalls/prctl/prctl06.c
+++ b/testcases/kernel/syscalls/prctl/prctl06.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test PR_GET_NO_NEW_PRIVS and PR_SET_NO_NEW_PRIVS of prctl(2).
  *
  * - Return the value of the no_new_privs bit for the calling thread.
diff --git a/testcases/kernel/syscalls/prctl/prctl07.c b/testcases/kernel/syscalls/prctl/prctl07.c
index dd1d2c0641..e7f3f94815 100644
--- a/testcases/kernel/syscalls/prctl/prctl07.c
+++ b/testcases/kernel/syscalls/prctl/prctl07.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test the PR_CAP_AMBIENT of prctl(2).
  *
  * Reads or changes the ambient capability set of the calling thread,
diff --git a/testcases/kernel/syscalls/prctl/prctl08.c b/testcases/kernel/syscalls/prctl/prctl08.c
index f090623b21..8c27df3894 100644
--- a/testcases/kernel/syscalls/prctl/prctl08.c
+++ b/testcases/kernel/syscalls/prctl/prctl08.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test PR_GET_TIMERSLACK and PR_SET_TIMERSLACK of prctl(2).
  *
  * - Each thread has two associated timer slack values: a "default"
diff --git a/testcases/kernel/syscalls/prctl/prctl09.c b/testcases/kernel/syscalls/prctl/prctl09.c
index c0696fcd81..5c962318f7 100644
--- a/testcases/kernel/syscalls/prctl/prctl09.c
+++ b/testcases/kernel/syscalls/prctl/prctl09.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This is a timer sample test that timer slack is 200us.
  */
 
diff --git a/testcases/kernel/syscalls/prctl/prctl10.c b/testcases/kernel/syscalls/prctl/prctl10.c
index b77268c02a..d7868f13ae 100644
--- a/testcases/kernel/syscalls/prctl/prctl10.c
+++ b/testcases/kernel/syscalls/prctl/prctl10.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test to test behaviour of PR_GET_TSC and PR_SET_TSC.
  *
  * Set the state of the flag determining whether the timestamp counter can
diff --git a/testcases/kernel/syscalls/pread/pread01.c b/testcases/kernel/syscalls/pread/pread01.c
index d11ca58f83..36a93a3f99 100644
--- a/testcases/kernel/syscalls/pread/pread01.c
+++ b/testcases/kernel/syscalls/pread/pread01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify the functionality of pread() by writing known data using pwrite()
  * to the file at various specified offsets and later read from the file from
  * various specified offsets, comparing the data read against the data written.
diff --git a/testcases/kernel/syscalls/pread/pread02.c b/testcases/kernel/syscalls/pread/pread02.c
index 04c7d0371a..d38daa4c87 100644
--- a/testcases/kernel/syscalls/pread/pread02.c
+++ b/testcases/kernel/syscalls/pread/pread02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests basic error handling of the pread syscall.
  *
  * - ESPIPE when attempted to read from an unnamed pipe
diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
index d5e5bd95f1..68e8d28c39 100644
--- a/testcases/kernel/syscalls/preadv/preadv01.c
+++ b/testcases/kernel/syscalls/preadv/preadv01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to check the basic functionality of the preadv(2).
  *
  * Preadv(2) should succeed to read the expected content of data
diff --git a/testcases/kernel/syscalls/preadv/preadv02.c b/testcases/kernel/syscalls/preadv/preadv02.c
index 19b194314b..0dc16f4a84 100644
--- a/testcases/kernel/syscalls/preadv/preadv02.c
+++ b/testcases/kernel/syscalls/preadv/preadv02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * - EINVAL when iov_len is invalid.
  * - EINVAL when the vector count iovcnt is less than zero.
  * - EINVAL when offset is negative.
diff --git a/testcases/kernel/syscalls/preadv/preadv03.c b/testcases/kernel/syscalls/preadv/preadv03.c
index 997e7a07c2..b6ec0a6080 100644
--- a/testcases/kernel/syscalls/preadv/preadv03.c
+++ b/testcases/kernel/syscalls/preadv/preadv03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check the basic functionality of the preadv(2) for the file
  * opened with O_DIRECT in all filesystem.
  *
diff --git a/testcases/kernel/syscalls/preadv2/preadv201.c b/testcases/kernel/syscalls/preadv2/preadv201.c
index 32ed7862a2..6065112833 100644
--- a/testcases/kernel/syscalls/preadv2/preadv201.c
+++ b/testcases/kernel/syscalls/preadv2/preadv201.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify the basic functionality of the preadv2(2):
  *
  * 1. If the file offset argument is not -1, preadv2() should succeed
diff --git a/testcases/kernel/syscalls/preadv2/preadv202.c b/testcases/kernel/syscalls/preadv2/preadv202.c
index f7279e0adf..c0e3f13a50 100644
--- a/testcases/kernel/syscalls/preadv2/preadv202.c
+++ b/testcases/kernel/syscalls/preadv2/preadv202.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, preadv2(2) fails and sets errno to
  *
  * 1. EINVAL if iov_len is invalid.
diff --git a/testcases/kernel/syscalls/process_madvise/process_madvise01.c b/testcases/kernel/syscalls/process_madvise/process_madvise01.c
index ca314c4da4..14ab1d8332 100644
--- a/testcases/kernel/syscalls/process_madvise/process_madvise01.c
+++ b/testcases/kernel/syscalls/process_madvise/process_madvise01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Allocate anonymous memory pages inside child and reclaim it with
  * MADV_PAGEOUT. Then check if memory pages have been swapped out by looking
  * at smaps information.
diff --git a/testcases/kernel/syscalls/pselect/pselect02.c b/testcases/kernel/syscalls/pselect/pselect02.c
index 391a31bb17..e5396077d8 100644
--- a/testcases/kernel/syscalls/pselect/pselect02.c
+++ b/testcases/kernel/syscalls/pselect/pselect02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  *  Verify that pselect() fails with:
  *
  *  - EBADF if a file descriptor that was already closed
diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
index 276faa77be..a44eb417c8 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace05.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test ptraces itself as per arbitrarily specified signals,
  * over 0 to SIGRTMAX range.
  */
diff --git a/testcases/kernel/syscalls/ptrace/ptrace06.c b/testcases/kernel/syscalls/ptrace/ptrace06.c
index fa3f07fa10..573a957992 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace06.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace06.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check out-of-bound/unaligned addresses given to
  *
  *  - {PEEK,POKE}{DATA,TEXT,USER}
diff --git a/testcases/kernel/syscalls/ptrace/ptrace11.c b/testcases/kernel/syscalls/ptrace/ptrace11.c
index 90154852f8..7f08aa996a 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace11.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace11.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Before kernel 2.6.26 we could not trace init(1) process and ptrace() would
  * fail with EPERM. This case just checks whether we can trace init(1) process
  * successfully.
diff --git a/testcases/kernel/syscalls/pwrite/pwrite01.c b/testcases/kernel/syscalls/pwrite/pwrite01.c
index 8f7ad2fb84..0c3689ce0e 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite01.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify the functionality of pwrite() by writing known data using pwrite()
  * to the file at various specified offsets and later read from the file from
  * various specified offsets, comparing the data written aganist the data
diff --git a/testcases/kernel/syscalls/pwrite/pwrite02.c b/testcases/kernel/syscalls/pwrite/pwrite02.c
index 9a40eddc87..d9ffac4886 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite02.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test basic error handling of the pwrite syscall.
  *
  * - ESPIPE when attempted to write to an unnamed pipe
diff --git a/testcases/kernel/syscalls/pwrite/pwrite03.c b/testcases/kernel/syscalls/pwrite/pwrite03.c
index ae572c1e9e..406c59d2c6 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite03.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests for a special case NULL buffer with size 0 is expected to return 0.
  */
 
diff --git a/testcases/kernel/syscalls/pwrite/pwrite04.c b/testcases/kernel/syscalls/pwrite/pwrite04.c
index 859955394b..c22e444f7d 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite04.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test the pwrite() system call with O_APPEND.
  *
  * Writing 2k data to the file, close it and reopen it with O_APPEND.
diff --git a/testcases/kernel/syscalls/pwritev/pwritev01.c b/testcases/kernel/syscalls/pwritev/pwritev01.c
index 1a4f672bf9..0aa5cb47a2 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev01.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to check the basic functionality of the pwritev(2).
  *
  * pwritev(2) should succeed to write the expected content of data
diff --git a/testcases/kernel/syscalls/pwritev/pwritev02.c b/testcases/kernel/syscalls/pwritev/pwritev02.c
index 25eb242f53..b1ba423505 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev02.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * - EINVAL when iov_len is invalid.
  * - EINVAL when the vector count iovcnt is less than zero.
  * - EINVAL when offset is negative.
diff --git a/testcases/kernel/syscalls/pwritev/pwritev03.c b/testcases/kernel/syscalls/pwritev/pwritev03.c
index 81ccee9be2..2655697dd4 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev03.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check the basic functionality of the pwritev(2) for the file
  * opened with O_DIRECT in all filesystem.
  *
diff --git a/testcases/kernel/syscalls/pwritev2/pwritev201.c b/testcases/kernel/syscalls/pwritev2/pwritev201.c
index ae9047cdd7..b74bf9186a 100644
--- a/testcases/kernel/syscalls/pwritev2/pwritev201.c
+++ b/testcases/kernel/syscalls/pwritev2/pwritev201.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to check the basic functionality of the pwritev2(2).
  *
  * - If the file offset argument is not -1, pwritev2() should succeed
diff --git a/testcases/kernel/syscalls/pwritev2/pwritev202.c b/testcases/kernel/syscalls/pwritev2/pwritev202.c
index e4d80070d2..b17d840676 100644
--- a/testcases/kernel/syscalls/pwritev2/pwritev202.c
+++ b/testcases/kernel/syscalls/pwritev2/pwritev202.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check various errnos for pwritev2(2).
  *
  * - pwritev2() fails and sets errno to EINVAL if iov_len is invalid.
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 7b7fb63604..9dcf74ceb2 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -7,7 +7,6 @@
  */
 
 /*\
- * [Description]
  * This testcases checks that quotactl(2) on ext4 filesystem succeeds to:
  *
  * - turn on quota with Q_QUOTAON flag for user
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index f837165568..d6f54708b3 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This testcases checks that quotactl(2) on xfs filesystem succeeds to:
  *
  * - turn off xfs quota and get xfs quota off status for user
diff --git a/testcases/kernel/syscalls/quotactl/quotactl03.c b/testcases/kernel/syscalls/quotactl/quotactl03.c
index 78d9a5458e..3ee15289c6 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl03.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * quotactl(2) with XGETNEXTQUOTA looks for the next active quota for an user
  * equal or higher to a given ID, in this test the ID is specified to a value
  * close to UINT_MAX(max value of unsigned int). When reaching the upper limit
diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index 91f15eb5dd..d2d7b3f3e4 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This testcase checks that quotactl(2) on ext4 filesystem succeeds to:
  *
  * - turn on quota with Q_QUOTAON flag for project
diff --git a/testcases/kernel/syscalls/quotactl/quotactl05.c b/testcases/kernel/syscalls/quotactl/quotactl05.c
index d19c729f85..e9f99d96f3 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl05.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This testcases checks that quotactl(2) on xfs filesystem succeeds to:
  *
  * - turn off xfs quota and get xfs quota off status for project
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 86b0d95d2e..110a3aa9bf 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests basic error handling of the quotactl syscall with visible quota files
  * (cover two formats, vfsv0 and vfsv1):
  *
diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
index c6e44b0a71..66505a308f 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl07.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This is not only a functional test but also a error test for Q_XQUOTARM.
  *
  * It is a regresstion test for kernel commit 3dd4d40b4208
diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
index 85a2f47316..63087345fe 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl08.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
@@ -5,7 +5,6 @@
  */
 
 /*\
- * [Description]
  * This testcases checks that quotactl(2) on ext4 filesystem succeeds to:
  *
  * - turn on quota with Q_QUOTAON flag for user
diff --git a/testcases/kernel/syscalls/quotactl/quotactl09.c b/testcases/kernel/syscalls/quotactl/quotactl09.c
index 4ddcbd659f..673666347a 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl09.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests basic error handling of the quotactl syscall without visible quota files
  * (use quotactl and quotactl_fd syscall):
  *
diff --git a/testcases/kernel/syscalls/read/read03.c b/testcases/kernel/syscalls/read/read03.c
index ee92a329e6..bb2fc5223c 100644
--- a/testcases/kernel/syscalls/read/read03.c
+++ b/testcases/kernel/syscalls/read/read03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to check if read() successfully sets errno to EAGAIN when read from
  * a pipe (fifo, opened in O_NONBLOCK mode) without writing to it.
  */
diff --git a/testcases/kernel/syscalls/read/read04.c b/testcases/kernel/syscalls/read/read04.c
index 154cbf47df..f7d9a65daa 100644
--- a/testcases/kernel/syscalls/read/read04.c
+++ b/testcases/kernel/syscalls/read/read04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to check if read() returns the number of bytes read correctly.
  */
 
diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
index aed8e7f310..fdf1bb0440 100644
--- a/testcases/kernel/syscalls/readahead/readahead01.c
+++ b/testcases/kernel/syscalls/readahead/readahead01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that readahead() syscall fails with:
  *
  * - EBADF when fd is not a valid file descriptor or is not open for reading.
diff --git a/testcases/kernel/syscalls/readdir/readdir01.c b/testcases/kernel/syscalls/readdir/readdir01.c
index 2dc8f916d3..96db689923 100644
--- a/testcases/kernel/syscalls/readdir/readdir01.c
+++ b/testcases/kernel/syscalls/readdir/readdir01.c
@@ -14,8 +14,6 @@
  */
 
 /*\
- * [Description]
- *
  * The test for the readdir(2) system call.
  * Create n files and check that readdir() finds n files
  */
diff --git a/testcases/kernel/syscalls/readdir/readdir21.c b/testcases/kernel/syscalls/readdir/readdir21.c
index 7b747dbd3b..bb508a4b0a 100644
--- a/testcases/kernel/syscalls/readdir/readdir21.c
+++ b/testcases/kernel/syscalls/readdir/readdir21.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that readdir will fail with:
  *
  * - ENOENT when passed a fd to a deleted directory
diff --git a/testcases/kernel/syscalls/readlink/readlink01.c b/testcases/kernel/syscalls/readlink/readlink01.c
index 8165547d49..a721436e2c 100644
--- a/testcases/kernel/syscalls/readlink/readlink01.c
+++ b/testcases/kernel/syscalls/readlink/readlink01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests basic functionality of readlink(2).
  *
  * - readlink() will succeed to read the contents of the symbolic link
diff --git a/testcases/kernel/syscalls/readlink/readlink03.c b/testcases/kernel/syscalls/readlink/readlink03.c
index dce6366643..8348387378 100644
--- a/testcases/kernel/syscalls/readlink/readlink03.c
+++ b/testcases/kernel/syscalls/readlink/readlink03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, readlink(2) returns -1 and sets errno to
  *
  * 1. EACCES if search/write permission is denied in the directory where the
diff --git a/testcases/kernel/syscalls/readlinkat/readlinkat01.c b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
index 9f238ff0ac..c3ff8f9b6b 100644
--- a/testcases/kernel/syscalls/readlinkat/readlinkat01.c
+++ b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check the basic functionality of the readlinkat() system call.
  *
  * - readlinkat() passes if dirfd is directory file descriptor
diff --git a/testcases/kernel/syscalls/readlinkat/readlinkat02.c b/testcases/kernel/syscalls/readlinkat/readlinkat02.c
index 64afb898f3..e2eaaed7be 100644
--- a/testcases/kernel/syscalls/readlinkat/readlinkat02.c
+++ b/testcases/kernel/syscalls/readlinkat/readlinkat02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * - readlinkat() fails with EINVAL if the bufsiz is 0.
  *
  * - readlinkat() fails with EINVAL if the named file is not a symbolic link.
diff --git a/testcases/kernel/syscalls/readv/readv02.c b/testcases/kernel/syscalls/readv/readv02.c
index c09e69bc8e..2ba23d4c60 100644
--- a/testcases/kernel/syscalls/readv/readv02.c
+++ b/testcases/kernel/syscalls/readv/readv02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests readv() failures:
  *
  * - EINVAL the sum of the iov_len values overflows an ssize_t value
diff --git a/testcases/kernel/syscalls/realpath/realpath01.c b/testcases/kernel/syscalls/realpath/realpath01.c
index e65debd58e..9c8e85a906 100644
--- a/testcases/kernel/syscalls/realpath/realpath01.c
+++ b/testcases/kernel/syscalls/realpath/realpath01.c
@@ -9,8 +9,6 @@
  */
 
 /*\
- * [Description]
- *
  * CVE-2018-1000001 realpath buffer underflow.
  *
  * Based on glibc test io/tst-getcwd-abspath.c:
diff --git a/testcases/kernel/syscalls/reboot/reboot01.c b/testcases/kernel/syscalls/reboot/reboot01.c
index 098b287b6a..28fae8bb0c 100644
--- a/testcases/kernel/syscalls/reboot/reboot01.c
+++ b/testcases/kernel/syscalls/reboot/reboot01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test of libc wrapper of reboot(2) system call.
  *
  * Test LINUX_REBOOT_CMD_CAD_ON, LINUX_REBOOT_CMD_CAD_OFF commands,
diff --git a/testcases/kernel/syscalls/reboot/reboot02.c b/testcases/kernel/syscalls/reboot/reboot02.c
index 2e95fd0635..5682b78e06 100644
--- a/testcases/kernel/syscalls/reboot/reboot02.c
+++ b/testcases/kernel/syscalls/reboot/reboot02.c
@@ -6,7 +6,6 @@
  */
 
 /*\
- * [Description]
  * Test whether libc wrapper of reboot(2) system call returns appropriate
  * error number for invalid cmd parameter or invalid user.
  */
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index a265bc3bd7..378be8ca21 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that recvmsg() returns the proper errno for various failure cases.
  */
 
diff --git a/testcases/kernel/syscalls/rename/rename01.c b/testcases/kernel/syscalls/rename/rename01.c
index 159341d095..2bbb70b2cc 100644
--- a/testcases/kernel/syscalls/rename/rename01.c
+++ b/testcases/kernel/syscalls/rename/rename01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify rename() when the newpath file or directory does not exist.
  */
 
diff --git a/testcases/kernel/syscalls/rename/rename03.c b/testcases/kernel/syscalls/rename/rename03.c
index 652fa3bdb3..f0c277cbe2 100644
--- a/testcases/kernel/syscalls/rename/rename03.c
+++ b/testcases/kernel/syscalls/rename/rename03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify rename(2) functions correctly when the newpath
  * file or directory (empty) exists.
  */
diff --git a/testcases/kernel/syscalls/rename/rename04.c b/testcases/kernel/syscalls/rename/rename04.c
index 598ecd6fe2..44b4d37d24 100644
--- a/testcases/kernel/syscalls/rename/rename04.c
+++ b/testcases/kernel/syscalls/rename/rename04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that rename() fails with EEXIST or ENOTEMPTY when
  * newpath is a non-empty directory.
  */
diff --git a/testcases/kernel/syscalls/rename/rename05.c b/testcases/kernel/syscalls/rename/rename05.c
index 7894a92147..2567a52524 100644
--- a/testcases/kernel/syscalls/rename/rename05.c
+++ b/testcases/kernel/syscalls/rename/rename05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that rename(2) fails with EISDIR when
  * oldpath is not a directory and newpath is an existing directory.
  */
diff --git a/testcases/kernel/syscalls/rename/rename06.c b/testcases/kernel/syscalls/rename/rename06.c
index 82665d1c2d..06ca8bf127 100644
--- a/testcases/kernel/syscalls/rename/rename06.c
+++ b/testcases/kernel/syscalls/rename/rename06.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that rename(2) fails with EINVAL when
  * an attempt is made to make a directory a subdirectory of itself.
  */
diff --git a/testcases/kernel/syscalls/rename/rename07.c b/testcases/kernel/syscalls/rename/rename07.c
index 51338dbf42..dabba77f9b 100644
--- a/testcases/kernel/syscalls/rename/rename07.c
+++ b/testcases/kernel/syscalls/rename/rename07.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that rename(2) fails with ENOTDIR, when
  * oldpath is a directory and newpath exists but is not a directory.
  *
diff --git a/testcases/kernel/syscalls/rename/rename08.c b/testcases/kernel/syscalls/rename/rename08.c
index 8a9a9b344c..c4cd3f48ea 100644
--- a/testcases/kernel/syscalls/rename/rename08.c
+++ b/testcases/kernel/syscalls/rename/rename08.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that rename(2) fails with EFAULT, when
  * oldpath or newpath points outside of accessible address space.
  */
diff --git a/testcases/kernel/syscalls/rename/rename09.c b/testcases/kernel/syscalls/rename/rename09.c
index 927b36f271..202efa1d67 100644
--- a/testcases/kernel/syscalls/rename/rename09.c
+++ b/testcases/kernel/syscalls/rename/rename09.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that renaming/moving a file from directory where the current user does
  * not have write permissions fails with EACCES.
  */
diff --git a/testcases/kernel/syscalls/rename/rename10.c b/testcases/kernel/syscalls/rename/rename10.c
index 5b5f79073e..129cecf46b 100644
--- a/testcases/kernel/syscalls/rename/rename10.c
+++ b/testcases/kernel/syscalls/rename/rename10.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that rename(2) fails with ENAMETOOLONG, when
  * oldpath or newpath is too long.
  */
diff --git a/testcases/kernel/syscalls/rename/rename12.c b/testcases/kernel/syscalls/rename/rename12.c
index d6e1ccbe93..3e717f2494 100644
--- a/testcases/kernel/syscalls/rename/rename12.c
+++ b/testcases/kernel/syscalls/rename/rename12.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that rename() fails with EPERM or EACCES when the directory
  * containing oldpath has the sticky bit (S_ISVTX) set and the caller
  * is not privileged.
diff --git a/testcases/kernel/syscalls/rename/rename13.c b/testcases/kernel/syscalls/rename/rename13.c
index 51490db75b..069971d1b9 100644
--- a/testcases/kernel/syscalls/rename/rename13.c
+++ b/testcases/kernel/syscalls/rename/rename13.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that rename() does nothing and returns a success status when
  * oldpath and newpath are existing hard links referring to the same file.
  */
diff --git a/testcases/kernel/syscalls/rename/rename15.c b/testcases/kernel/syscalls/rename/rename15.c
index d08b1e67f0..1ef5807353 100644
--- a/testcases/kernel/syscalls/rename/rename15.c
+++ b/testcases/kernel/syscalls/rename/rename15.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test suite validates the behavior of the `rename()` system call on
  * symbolic links under three scenarios:
  *
diff --git a/testcases/kernel/syscalls/request_key/request_key01.c b/testcases/kernel/syscalls/request_key/request_key01.c
index f349cd50dd..97121533da 100644
--- a/testcases/kernel/syscalls/request_key/request_key01.c
+++ b/testcases/kernel/syscalls/request_key/request_key01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test basic functionality of the request_key(2).
  *
  * request_key(2) asks the kernel to find a key which matches the
diff --git a/testcases/kernel/syscalls/request_key/request_key02.c b/testcases/kernel/syscalls/request_key/request_key02.c
index 48bb978dda..2d35aceeee 100644
--- a/testcases/kernel/syscalls/request_key/request_key02.c
+++ b/testcases/kernel/syscalls/request_key/request_key02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic request_key(2) failure checking. request_key(2) should return -1 and
  * set expected errno:
  *
diff --git a/testcases/kernel/syscalls/request_key/request_key03.c b/testcases/kernel/syscalls/request_key/request_key03.c
index 3837993efa..bacfbe9888 100644
--- a/testcases/kernel/syscalls/request_key/request_key03.c
+++ b/testcases/kernel/syscalls/request_key/request_key03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Regression test for two related bugs:
  *
  * 1. CVE-2017-15299, fixed by commit 60ff5b2f547a ("KEYS: don't let add_key()
diff --git a/testcases/kernel/syscalls/request_key/request_key04.c b/testcases/kernel/syscalls/request_key/request_key04.c
index 4a454731aa..404233ad58 100644
--- a/testcases/kernel/syscalls/request_key/request_key04.c
+++ b/testcases/kernel/syscalls/request_key/request_key04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Regression test for commit 4dca6ea1d943 ("KEYS: add missing permission check
  * for request_key() destination"), or CVE-2017-17807.  This bug allowed adding
  * a key to a keyring given only Search permission to that keyring, rather than
diff --git a/testcases/kernel/syscalls/request_key/request_key05.c b/testcases/kernel/syscalls/request_key/request_key05.c
index 35f326f505..8c20bab30a 100644
--- a/testcases/kernel/syscalls/request_key/request_key05.c
+++ b/testcases/kernel/syscalls/request_key/request_key05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2017-6951, original reproducer:
  * http://www.spinics.net/lists/keyrings/msg01845.html
  *
diff --git a/testcases/kernel/syscalls/request_key/request_key06.c b/testcases/kernel/syscalls/request_key/request_key06.c
index bd872867bf..34cc31fa05 100644
--- a/testcases/kernel/syscalls/request_key/request_key06.c
+++ b/testcases/kernel/syscalls/request_key/request_key06.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that request_key(2) fails with
  *
  * - EFAULT when type points outside the process's accessible address space
diff --git a/testcases/kernel/syscalls/rmdir/rmdir02.c b/testcases/kernel/syscalls/rmdir/rmdir02.c
index b545e9cd2d..308f864447 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir02.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, rmdir(2) returns -1 and sets errno to
  *
  * 1. ENOTEMPTY when removing a non-empty directory
diff --git a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo02.c b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo02.c
index ab30c2abdc..ee12bbb879 100644
--- a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo02.c
+++ b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, rt_sigqueueinfo(2) sets errno to
  *
  * - EINVAL if sig is invalid
diff --git a/testcases/kernel/syscalls/sbrk/sbrk01.c b/testcases/kernel/syscalls/sbrk/sbrk01.c
index 39e92094bd..b6a34d0fd6 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk01.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that sbrk() successfully increments or decrements the program's
  * data break.
  */
diff --git a/testcases/kernel/syscalls/sbrk/sbrk02.c b/testcases/kernel/syscalls/sbrk/sbrk02.c
index 08cbdf367c..7990196ed2 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk02.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that sbrk() on failure sets errno to ENOMEM.
  */
 
diff --git a/testcases/kernel/syscalls/sbrk/sbrk03.c b/testcases/kernel/syscalls/sbrk/sbrk03.c
index 00536c757c..5c22a39984 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk03.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Total s390 2^31 addr space is 0x80000000.
  *
  * 0x80000000 - 0x10000000 = 0x70000000
diff --git a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
index 9d0ebc2848..c0b2f5eada 100644
--- a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
+++ b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for the sched_get_priority_max(2) system call.
  *
  * Obtain different maximum priority for different schedulling policies and
diff --git a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max02.c b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max02.c
index bf1db294e0..d3a93a591e 100644
--- a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max02.c
+++ b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that given an invalid scheduling policy, sched_get_priority_max(2)
  * returns -1 with errno EINVAL.
  */
diff --git a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c
index 05cb9d1d5c..26e16a9408 100644
--- a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c
+++ b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for the sched_get_priority_min(2) system call.
  *
  * Obtain different minimum priority for different schedulling policies and
diff --git a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min02.c b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min02.c
index 57e49ffd4a..077beb7f96 100644
--- a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min02.c
+++ b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that given an invalid scheduling policy, sched_get_priority_min(2)
  * returns -1 with errno EINVAL.
  */
diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
index 4b99cdb66d..e2c0bf43be 100644
--- a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, sched_getattr(2) returns -1 and sets errno to:
  *
  * 1. ESRCH if pid is unused.
diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
index a357264870..2c56286d67 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that:
  *
  * sched_getparam(2) gets correct scheduling parameters for
diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
index f1c635edf1..7192b0170d 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that:
  *
  * - sched_getparam(2) returns -1 and sets errno to ESRCH if the
diff --git a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c
index 4191f09c0d..7edb594816 100644
--- a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c
+++ b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to check sched_getscheduler() returns correct return value.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler02.c b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler02.c
index 98818ff480..fbd5d66e50 100644
--- a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler02.c
+++ b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Pass an unused pid to sched_getscheduler() and test for ESRCH.
  */
 
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index 40ff6e988d..b4d75bdcca 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -4,8 +4,6 @@
  *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
  */
 /*\
- * [Description]
- *
  * Gets round-robin time quantum by calling sched_rr_get_interval() and
  * checks that the value is sane.
  *
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
index a61e2969b5..789e5ff10f 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
@@ -4,8 +4,6 @@
  *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
  */
 /*\
- * [Description]
- *
  * Verify that for a process with scheduling policy SCHED_FIFO,
  * sched_rr_get_interval() writes zero into timespec structure
  * for tv_sec & tv_nsec.
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
index 731c500823..5e2f4ed7ea 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
@@ -4,8 +4,6 @@
  *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
  */
 /*\
- * [Description]
- *
  * Verify that:
  *
  * - sched_rr_get_interval() fails with errno set to EINVAL for an
diff --git a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
index acd9b77bef..22fef40203 100644
--- a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
+++ b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check various errnos for sched_setaffinity():
  *
  * 1. EFAULT, if the supplied memory address is invalid.
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam01.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam01.c
index df789e93dc..6222b0f8ee 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam01.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for sched_setparam(2)
  *
  * Call sched_setparam(2) with pid=0 so that it will
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c
index b71c51c6ae..d71e2c6d69 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Checks functionality for sched_setparam(2)
  *
  * This test changes the scheduling priority for current process
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
index ffa92a3bf9..a8effcadb9 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Checks functionality for sched_setparam(2) for pid != 0
  *
  * This test forks a child and changes its parent's scheduling priority.
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c
index 26477e4556..aa47a8610d 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that:
  *
  * 1. sched_setparam(2) returns -1 and sets errno to ESRCH if the
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam05.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam05.c
index 0a49ecc4d0..e5fc8b04d7 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam05.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that sched_setparam() fails if the user does not have proper
  * privileges.
  */
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler01.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler01.c
index 4e48de8890..32a1a37acb 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler01.c
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to test whether sched_setscheduler(2) sets the errnos
  * correctly.
  *
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
index 66f7270bd7..425c0ce267 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to test whether sched_setscheduler(2) sets the errnos
  * correctly.
  *
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
index 828d1ec09e..abdd4c6dcb 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
@@ -4,8 +4,6 @@
  */
 
 /*
- * [Description]
- *
  * Testcases that test if sched_setscheduler with flag
  * SCHED_RESET_ON_FORK restores children policy to
  * SCHED_NORMAL.
diff --git a/testcases/kernel/syscalls/seccomp/seccomp01.c b/testcases/kernel/syscalls/seccomp/seccomp01.c
index 16abca78fa..88f2fbef89 100644
--- a/testcases/kernel/syscalls/seccomp/seccomp01.c
+++ b/testcases/kernel/syscalls/seccomp/seccomp01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test PR_GET_SECCOMP and PR_SET_SECCOMP with both prctl(2) and seccomp(2).
  * The second one is called via __NR_seccomp using tst_syscall().
  *
diff --git a/testcases/kernel/syscalls/select/select04.c b/testcases/kernel/syscalls/select/select04.c
index f7a463ee1b..4706901b59 100644
--- a/testcases/kernel/syscalls/select/select04.c
+++ b/testcases/kernel/syscalls/select/select04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test to check if fd set bits are cleared by select().
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/send/send02.c b/testcases/kernel/syscalls/send/send02.c
index 3a735d3be4..25d841bfae 100644
--- a/testcases/kernel/syscalls/send/send02.c
+++ b/testcases/kernel/syscalls/send/send02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that the kernel correctly handles send()/sendto()/sendmsg() calls
  * with MSG_MORE flag.
  */
diff --git a/testcases/kernel/syscalls/sendfile/sendfile02.c b/testcases/kernel/syscalls/sendfile/sendfile02.c
index 8e88dec20f..c88b93b121 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile02.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test the basic functionality of the sendfile() system call:
  *
  * 1. Call sendfile() with offset = 0.
diff --git a/testcases/kernel/syscalls/sendfile/sendfile03.c b/testcases/kernel/syscalls/sendfile/sendfile03.c
index 85a3b0f357..bd6e9a8f42 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile03.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to test that sendfile(2) system call returns EBADF when passing
  * wrong out_fd or in_fd.
  *
diff --git a/testcases/kernel/syscalls/sendfile/sendfile04.c b/testcases/kernel/syscalls/sendfile/sendfile04.c
index 4fa7481377..f74db177af 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile04.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to test that sendfile(2) system call returns EFAULT when passing
  * wrong offset pointer.
  *
diff --git a/testcases/kernel/syscalls/sendfile/sendfile05.c b/testcases/kernel/syscalls/sendfile/sendfile05.c
index 691ed9730a..865d83c370 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile05.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to test that sendfile(2) system call returns EINVAL when passing
  * negative offset.
  *
diff --git a/testcases/kernel/syscalls/sendfile/sendfile06.c b/testcases/kernel/syscalls/sendfile/sendfile06.c
index 2168da7279..9b2d8ff561 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile06.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile06.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test that sendfile() system call updates file position of in_fd correctly
  * when passing NULL as offset.
  */
diff --git a/testcases/kernel/syscalls/sendfile/sendfile07.c b/testcases/kernel/syscalls/sendfile/sendfile07.c
index f9cbb7b85b..47d312a3b9 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile07.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile07.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to test that sendfile(2) system call returns EAGAIN
  * when passing full out_fd opened with O_NONBLOCK.
  */
diff --git a/testcases/kernel/syscalls/sendfile/sendfile08.c b/testcases/kernel/syscalls/sendfile/sendfile08.c
index 66fd40cae8..1efff97c2c 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile08.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile08.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Bug in the splice code has caused the file position on the write side
  * of the sendfile system call to be incorrectly set to the read side file
  * position. This can result in the data being written to an incorrect offset.
diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
index eeef44519c..82feaeba03 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile09.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase copied from sendfile02.c to test the basic functionality of
  * the sendfile() system call on large file. There is a kernel bug which
  * introduced by commit 8f9c0119d7ba9 and fixed by commit 5d73320a96fcc.
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg03.c b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
index 2edccb8d97..4a9943a3bc 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg03.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * CVE-2017-17712
  *
  * Test for race condition vulnerability in sendmsg() on SOCK_RAW sockets.
diff --git a/testcases/kernel/syscalls/sendto/sendto02.c b/testcases/kernel/syscalls/sendto/sendto02.c
index a24a696dd6..0acbb97469 100644
--- a/testcases/kernel/syscalls/sendto/sendto02.c
+++ b/testcases/kernel/syscalls/sendto/sendto02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * When SCTP protocol created wih socket(2) and buffer is invalid,
  * sendto(2) should fail and set errno to EFAULT, but it sets errno
  * to ENOMEM.
diff --git a/testcases/kernel/syscalls/sendto/sendto03.c b/testcases/kernel/syscalls/sendto/sendto03.c
index 59caffb9aa..622de64747 100644
--- a/testcases/kernel/syscalls/sendto/sendto03.c
+++ b/testcases/kernel/syscalls/sendto/sendto03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * CVE-2020-14386
  *
  * Check for vulnerability in tpacket_rcv() which allows an unprivileged user
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
index 9cc83e6422..65061bf3d8 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
@@ -3,8 +3,6 @@
  * Copyright (C) 2021 SUSE LLC <rpalethorpe@suse.com>
  */
 /*\
- *
- * [Description]
  *
  * This will reproduce an information leak in the set_mempolicy 32-bit
  * compat syscall. The catch is that the 32-bit compat syscall is not
diff --git a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
index 0b68f70f32..1234e7f540 100644
--- a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
+++ b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify the basic functionality of set_tid_address() syscall.
  */
 
diff --git a/testcases/kernel/syscalls/setegid/setegid01.c b/testcases/kernel/syscalls/setegid/setegid01.c
index eef66311ba..871b4172bf 100644
--- a/testcases/kernel/syscalls/setegid/setegid01.c
+++ b/testcases/kernel/syscalls/setegid/setegid01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that setegid() sets the effective UID of the calling process
  * correctly, and does not modify the saved GID and real GID.
  */
diff --git a/testcases/kernel/syscalls/setegid/setegid02.c b/testcases/kernel/syscalls/setegid/setegid02.c
index 66a8a07fb3..825809fcf4 100644
--- a/testcases/kernel/syscalls/setegid/setegid02.c
+++ b/testcases/kernel/syscalls/setegid/setegid02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that setegid() fails with EPERM when the calling process is not
  * privileged and egid does not match the current real group ID,
  * current effective group ID, or current saved set-group-ID.
diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid01.c b/testcases/kernel/syscalls/setfsgid/setfsgid01.c
index 5b594b2d47..4724b5be58 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid01.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that setfsgid() correctly updates the filesystem group ID
  * to the value given in fsgid argument.
  */
diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid02.c b/testcases/kernel/syscalls/setfsgid/setfsgid02.c
index 2a0b0c5593..c1930edbcf 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid02.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase for setfsgid() syscall to check that
  *
  * - privileged user can change a filesystem group ID different from saved
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid01.c b/testcases/kernel/syscalls/setfsuid/setfsuid01.c
index 9805e38b6c..b23300f4a3 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid01.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that setfsuid() correctly updates the filesystem user ID
  * to the value given in fsuid argument.
  */
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid02.c b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
index b81f307f7e..6f46a98215 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid02.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that setfsuid() syscall fails if an invalid fsuid is given.
  */
 
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid03.c b/testcases/kernel/syscalls/setfsuid/setfsuid03.c
index ee06e9376a..b7f941bb17 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid03.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that setfsuid() correctly updates the filesystem uid
  * when caller is a non-root user and provided fsuid matches
  * caller's real user ID.
diff --git a/testcases/kernel/syscalls/setgid/setgid01.c b/testcases/kernel/syscalls/setgid/setgid01.c
index 4e225b13e1..65c1622867 100644
--- a/testcases/kernel/syscalls/setgid/setgid01.c
+++ b/testcases/kernel/syscalls/setgid/setgid01.c
@@ -6,8 +6,6 @@
  * CO-PILOT		: Dave Fenner
  */
 /*\
- * [Description]
- *
  * Calls setgid() with current gid and expects success.
  */
 
diff --git a/testcases/kernel/syscalls/setgid/setgid02.c b/testcases/kernel/syscalls/setgid/setgid02.c
index ff6791a1a3..93684ef8e8 100644
--- a/testcases/kernel/syscalls/setgid/setgid02.c
+++ b/testcases/kernel/syscalls/setgid/setgid02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test if setgid() system call sets errno to EPERM correctly.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/setgroups/setgroups01.c b/testcases/kernel/syscalls/setgroups/setgroups01.c
index 9a5b77e936..f8e7d301ad 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups01.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups01.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check the basic functionality of the setgroups() system call.
  */
 
diff --git a/testcases/kernel/syscalls/setgroups/setgroups02.c b/testcases/kernel/syscalls/setgroups/setgroups02.c
index 2b7f95c870..e636442ea9 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups02.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that root process can setgroups() supplementary group ID and verify
  * that getgroups() returns the previously set ID.
  */
diff --git a/testcases/kernel/syscalls/setgroups/setgroups03.c b/testcases/kernel/syscalls/setgroups/setgroups03.c
index fbf8de0bb2..8d17f5ba42 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups03.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups03.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for EINVAL, EPERM, EFAULT errors.
  *
  * - setgroups() fails with EINVAL if the size argument value is > NGROUPS.
diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
index 94ee51c6a6..22b89e4712 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer01.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Spawn a child, verify that setitimer() syscall passes and it ends up
  * counting inside expected boundaries. Then verify from the parent that
  * the syscall sent the correct signal to the child.
diff --git a/testcases/kernel/syscalls/setitimer/setitimer02.c b/testcases/kernel/syscalls/setitimer/setitimer02.c
index c545f6288b..7c38ad9f65 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer02.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that setitimer() call fails:
  *
  * 1. EFAULT with invalid itimerval pointer
diff --git a/testcases/kernel/syscalls/setpgid/setpgid01.c b/testcases/kernel/syscalls/setpgid/setpgid01.c
index c976c3a513..59ec372aa5 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid01.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify basic setpgid() functionality, re-setting group ID inside both parent
  * and child. In the first case, we obtain getpgrp() and set it. In the second
  * case, we use setpgid(0, 0).
diff --git a/testcases/kernel/syscalls/setpgid/setpgid02.c b/testcases/kernel/syscalls/setpgid/setpgid02.c
index b380d7df48..fac8836daa 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid02.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that setpgid(2) syscall fails with:
  *
  * - EINVAL when given pgid is less than 0.
diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c b/testcases/kernel/syscalls/setpgid/setpgid03.c
index 9ce2603d8a..7f360f6320 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests setpgid(2) errors:
  *
  * - EPERM The process specified by pid must not be a session leader.
diff --git a/testcases/kernel/syscalls/setpgrp/setpgrp02.c b/testcases/kernel/syscalls/setpgrp/setpgrp02.c
index f58f494e73..732364e601 100644
--- a/testcases/kernel/syscalls/setpgrp/setpgrp02.c
+++ b/testcases/kernel/syscalls/setpgrp/setpgrp02.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Testcase to check the basic functionality of the setpgrp(2) syscall.
  */
 
diff --git a/testcases/kernel/syscalls/setregid/setregid01.c b/testcases/kernel/syscalls/setregid/setregid01.c
index 2750208d44..58f874953e 100644
--- a/testcases/kernel/syscalls/setregid/setregid01.c
+++ b/testcases/kernel/syscalls/setregid/setregid01.c
@@ -16,8 +16,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify the basic functionality of setregid(2) system call.
  */
 
diff --git a/testcases/kernel/syscalls/setresgid/setresgid01.c b/testcases/kernel/syscalls/setresgid/setresgid01.c
index 2301a6771e..facb918cc7 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid01.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that setresgid() syscall correctly sets real user ID, effective user
  * ID and the saved set-user ID in the calling process.
  */
diff --git a/testcases/kernel/syscalls/setresgid/setresgid02.c b/testcases/kernel/syscalls/setresgid/setresgid02.c
index 2893aa5422..cca4c46b6b 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid02.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that setresgid() will successfully set the expected GID when called
  * by root with the following combinations of arguments:
  *
diff --git a/testcases/kernel/syscalls/setresgid/setresgid03.c b/testcases/kernel/syscalls/setresgid/setresgid03.c
index 4f6bc6aafe..8d827d17b1 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid03.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that setresgid() fails with EPERM if unprivileged user tries to set
  * process group ID which requires higher permissions.
  */
diff --git a/testcases/kernel/syscalls/setresgid/setresgid04.c b/testcases/kernel/syscalls/setresgid/setresgid04.c
index 1eedb883ae..9ba013eb63 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid04.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that setresgid() syscall always sets the file system GID to the same
  * value as the new effective GID.
  */
diff --git a/testcases/kernel/syscalls/setresuid/setresuid01.c b/testcases/kernel/syscalls/setresuid/setresuid01.c
index 196e03766d..b3cebcbd8c 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid01.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test setresuid() when executed by root.
  */
 
diff --git a/testcases/kernel/syscalls/setresuid/setresuid02.c b/testcases/kernel/syscalls/setresuid/setresuid02.c
index 0931d2a24c..6bd7a22dbc 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid02.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test that a non-root user can change the real, effective and saved uid
  * values through the setresuid system call.
  */
diff --git a/testcases/kernel/syscalls/setresuid/setresuid03.c b/testcases/kernel/syscalls/setresuid/setresuid03.c
index f1518c75c9..f2ff0b7a22 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid03.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test that the setresuid system call sets the proper errno values when
  * a non-root user attempts to change the real, effective or saved uid
  * to a value other than one of the current uid, the current effective uid
diff --git a/testcases/kernel/syscalls/setresuid/setresuid04.c b/testcases/kernel/syscalls/setresuid/setresuid04.c
index 57b290f378..cf10bad4b3 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid04.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that setresuid() behaves correctly with file permissions.
  * The test creates a file as ROOT with permissions 0644, does a setresuid
  * to change euid to a non-root user and tries to open the file with RDWR
diff --git a/testcases/kernel/syscalls/setresuid/setresuid05.c b/testcases/kernel/syscalls/setresuid/setresuid05.c
index 3a0eb47083..4193afdc4d 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid05.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that after updating euid with setresuid(), any file creation
  * also gets the new euid as its owner user ID.
  */
diff --git a/testcases/kernel/syscalls/setreuid/setreuid01.c b/testcases/kernel/syscalls/setreuid/setreuid01.c
index 5398246a61..9442e7c501 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid01.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify the basic functionality of setreuid(2) system call when executed
  * as non-root user.
  */
diff --git a/testcases/kernel/syscalls/setreuid/setreuid02.c b/testcases/kernel/syscalls/setreuid/setreuid02.c
index 2fa4cbc800..8f110ef727 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid02.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test setreuid() when executed by root.
  */
 
diff --git a/testcases/kernel/syscalls/setreuid/setreuid03.c b/testcases/kernel/syscalls/setreuid/setreuid03.c
index e83a3586a5..f21a141d63 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid03.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test setreuid() when executed by an unpriviledged user.
  */
 
diff --git a/testcases/kernel/syscalls/setreuid/setreuid04.c b/testcases/kernel/syscalls/setreuid/setreuid04.c
index 06ffa32b0b..7407fa0176 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid04.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that root user can change the real and effective uid to an
  * unprivileged user.
  */
diff --git a/testcases/kernel/syscalls/setreuid/setreuid05.c b/testcases/kernel/syscalls/setreuid/setreuid05.c
index 4c1c94ee8b..9ab1f21de2 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid05.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test the setreuid() feature, verifying the role of the saved-set-uid
  * and setreuid's effect on it.
  */
diff --git a/testcases/kernel/syscalls/setreuid/setreuid06.c b/testcases/kernel/syscalls/setreuid/setreuid06.c
index 0a094fdc9b..5566357001 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid06.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid06.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that setreuid(2) syscall fails with EPERM errno when the calling
  * process is not privileged and a change other than
  * (i) swapping the effective user ID with the real user ID, or
diff --git a/testcases/kernel/syscalls/setreuid/setreuid07.c b/testcases/kernel/syscalls/setreuid/setreuid07.c
index 62b9ec4cdc..1bb2d8428d 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid07.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid07.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check if setreuid behaves correctly with file permissions.
  * The test creates a file as ROOT with permissions 0644, does a setreuid
  * and then tries to open the file with RDWR permissions.
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt01.c b/testcases/kernel/syscalls/setsockopt/setsockopt01.c
index d8c70cbc5d..1ded0cda5a 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt01.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that setsockopt() fails and set errno:
  *
  * - EBADF on invalid file descriptor
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt02.c b/testcases/kernel/syscalls/setsockopt/setsockopt02.c
index 23e56ee7e0..15d86ae178 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt02.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2017-7308 on a raw socket's ring buffer
  *
  * Try to set tpacket_req3.tp_sizeof_priv to a value with the high bit set. So
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt03.c b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
index 82d5aebf1d..90d5466115 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt03.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for CVE-2016-4997
  *
  * For a full explanation of how the vulnerability works see:
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt04.c b/testcases/kernel/syscalls/setsockopt/setsockopt04.c
index a4c0a371e0..7916314c75 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt04.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt04.c
@@ -4,8 +4,6 @@
  * Author: Christian Amann <camann@suse.com>
  */
 /*\
- * [Description]
- *
  * CVE-2016-9793
  *
  * With kernels between version 3.11 and 4.8 missing commit b98b0bc8 it
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
index 68a093694c..35a3d1bd3d 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * CVE-2017-1000112
  *
  * Check that UDP fragmentation offload doesn't cause memory corruption
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
index 1c2421fe92..3f266123fb 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * CVE-2016-8655
  *
  * Check for race condition between packet_set_ring() and tp_version. On some
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
index ed80d2c503..ea3dead0fb 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * CVE-2017-1000111
  *
  * Check for race condition between packet_set_ring() and tp_reserve.
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
index a246cfdddf..1d50bd6cbb 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This will reproduce the bug on x86_64 in 32bit compatibility
  * mode. It is most reliable with KASAN enabled. Otherwise it relies
  * on the out-of-bounds write corrupting something which leads to a
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
index 9ed80e46b1..a4b6b9315f 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt09.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check for possible double free of rx_owner_map after switching packet
  * interface versions aka CVE-2021-22600.
  *
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt10.c b/testcases/kernel/syscalls/setsockopt/setsockopt10.c
index 4e7e449383..e52c6cd933 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt10.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt10.c
@@ -3,8 +3,6 @@
  * Copyright (C) 2023 SUSE LLC Richard Palethorpe <rpalethorpe@suse.com>
  */
 /*\
- * [Description]
- *
  * Reproducer for CVE-2023-0461 which is an exploitable use-after-free
  * in a TLS socket. In fact it is exploitable in any User Level
  * Protocol (ULP) which does not clone its context when accepting a
diff --git a/testcases/kernel/syscalls/settimeofday/settimeofday01.c b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
index e523b5b979..e403fe4030 100644
--- a/testcases/kernel/syscalls/settimeofday/settimeofday01.c
+++ b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check the basic functionality of settimeofday().
  */
 
diff --git a/testcases/kernel/syscalls/settimeofday/settimeofday02.c b/testcases/kernel/syscalls/settimeofday/settimeofday02.c
index 06021b9536..4be44df720 100644
--- a/testcases/kernel/syscalls/settimeofday/settimeofday02.c
+++ b/testcases/kernel/syscalls/settimeofday/settimeofday02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that settimeofday() sets errnos correctly.
  */
 
diff --git a/testcases/kernel/syscalls/setuid/setuid01.c b/testcases/kernel/syscalls/setuid/setuid01.c
index c136444c73..d7b44d790e 100644
--- a/testcases/kernel/syscalls/setuid/setuid01.c
+++ b/testcases/kernel/syscalls/setuid/setuid01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that setuid(2) returns 0 and effective uid has
  * been set successfully as a normal or super user.
  */
diff --git a/testcases/kernel/syscalls/setuid/setuid03.c b/testcases/kernel/syscalls/setuid/setuid03.c
index 06934f142d..1f96e04f99 100644
--- a/testcases/kernel/syscalls/setuid/setuid03.c
+++ b/testcases/kernel/syscalls/setuid/setuid03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test will switch to nobody user for correct error code collection.
  * Verify setuid returns errno EPERM when it switches to root_user.
  */
diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
index de3ea67ec4..a405bf42ee 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr01.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests for setxattr(2) and make sure setxattr(2) handles error
  * conditions correctly.
  *
diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 18afc031b4..9f5f998da9 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * In the user.* namespace, only regular files and directories can
  * have extended attributes. Otherwise setxattr(2) will return -1
  * and set errno to EPERM.
diff --git a/testcases/kernel/syscalls/setxattr/setxattr03.c b/testcases/kernel/syscalls/setxattr/setxattr03.c
index 52cec07887..0b5b48a55e 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr03.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * setxattr(2) to immutable and append-only files should get EPERM
  *
  * - Set attribute to a immutable file
diff --git a/testcases/kernel/syscalls/shutdown/shutdown01.c b/testcases/kernel/syscalls/shutdown/shutdown01.c
index 91e4378059..48b1a22566 100644
--- a/testcases/kernel/syscalls/shutdown/shutdown01.c
+++ b/testcases/kernel/syscalls/shutdown/shutdown01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies the following shutdown() functionalities:
  *
  * - SHUT_RD should enable send() ops but disable recv() ops
diff --git a/testcases/kernel/syscalls/shutdown/shutdown02.c b/testcases/kernel/syscalls/shutdown/shutdown02.c
index 33f7488147..2c488416d2 100644
--- a/testcases/kernel/syscalls/shutdown/shutdown02.c
+++ b/testcases/kernel/syscalls/shutdown/shutdown02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies the following shutdown() errors:
  *
  * - EBADF sockfd is not a valid file descriptor
diff --git a/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c b/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c
index 5a34851c01..e5412b2dac 100644
--- a/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c
+++ b/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that sigaltstack() fails with return value -1 and set expected errno:
  *
  * - EINVAL on invalid value.
diff --git a/testcases/kernel/syscalls/sighold/sighold02.c b/testcases/kernel/syscalls/sighold/sighold02.c
index 2807bf67e0..11515558d6 100644
--- a/testcases/kernel/syscalls/sighold/sighold02.c
+++ b/testcases/kernel/syscalls/sighold/sighold02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test checks following conditions:
  *
  * 1. sighold action to turn off the receipt of all signals was done without error.
diff --git a/testcases/kernel/syscalls/signal/signal01.c b/testcases/kernel/syscalls/signal/signal01.c
index 277661597a..20031af311 100644
--- a/testcases/kernel/syscalls/signal/signal01.c
+++ b/testcases/kernel/syscalls/signal/signal01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test SIGKILL for these items:
  *	1. SIGKILL can not be set to be ignored, errno:EINVAL (POSIX).
  *	2. SIGKILL can not be reset to default, errno:EINVAL (POSIX).
diff --git a/testcases/kernel/syscalls/signal/signal02.c b/testcases/kernel/syscalls/signal/signal02.c
index 54948646ff..187e6301c2 100644
--- a/testcases/kernel/syscalls/signal/signal02.c
+++ b/testcases/kernel/syscalls/signal/signal02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test that we get an error using illegal signals.
  */
 
diff --git a/testcases/kernel/syscalls/signal/signal03.c b/testcases/kernel/syscalls/signal/signal03.c
index 8118af4b4f..339fbbbf13 100644
--- a/testcases/kernel/syscalls/signal/signal03.c
+++ b/testcases/kernel/syscalls/signal/signal03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Set signals to be ignored.
  */
 
diff --git a/testcases/kernel/syscalls/signal/signal04.c b/testcases/kernel/syscalls/signal/signal04.c
index 27826ad483..598666c3c5 100644
--- a/testcases/kernel/syscalls/signal/signal04.c
+++ b/testcases/kernel/syscalls/signal/signal04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Restore signals to default behavior.
  */
 
diff --git a/testcases/kernel/syscalls/signal/signal05.c b/testcases/kernel/syscalls/signal/signal05.c
index f3480f0ab0..b64f17b502 100644
--- a/testcases/kernel/syscalls/signal/signal05.c
+++ b/testcases/kernel/syscalls/signal/signal05.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Set the signal handler to our own function.
  */
 
diff --git a/testcases/kernel/syscalls/signalfd/signalfd01.c b/testcases/kernel/syscalls/signalfd/signalfd01.c
index e54d4a6069..47f5eed758 100644
--- a/testcases/kernel/syscalls/signalfd/signalfd01.c
+++ b/testcases/kernel/syscalls/signalfd/signalfd01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that signalfd() works as expected.
  *
  * - signalfd() can create fd, and fd can receive signal.
diff --git a/testcases/kernel/syscalls/signalfd/signalfd02.c b/testcases/kernel/syscalls/signalfd/signalfd02.c
index fdd15781cd..332b5f5964 100644
--- a/testcases/kernel/syscalls/signalfd/signalfd02.c
+++ b/testcases/kernel/syscalls/signalfd/signalfd02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that signalfd(2) fails with:
  *
  * - EBADF when fd is invalid
diff --git a/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c b/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
index 4d9edcbed2..66307f8011 100644
--- a/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
+++ b/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify the basic sigsuspend(2) syscall functionality:
  *
  * - sigsuspend(2) can replace process's current signal mask by the specified
diff --git a/testcases/kernel/syscalls/sigsuspend/sigsuspend02.c b/testcases/kernel/syscalls/sigsuspend/sigsuspend02.c
index cfe95393f9..d809bacc86 100644
--- a/testcases/kernel/syscalls/sigsuspend/sigsuspend02.c
+++ b/testcases/kernel/syscalls/sigsuspend/sigsuspend02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that sigsuspend(2) fails with
  *
  * - EFAULT mask points to memory which is not a valid part of the
diff --git a/testcases/kernel/syscalls/socket/socket01.c b/testcases/kernel/syscalls/socket/socket01.c
index ca47315638..9563e19f92 100644
--- a/testcases/kernel/syscalls/socket/socket01.c
+++ b/testcases/kernel/syscalls/socket/socket01.c
@@ -5,8 +5,6 @@
 */
 
 /*\
- * [Description]
- *
  * Test creating TCP, UDP, and Unix doman dgram sockets with socket() syscall.
  *
  * Also verify that socket() fails and set proper errno
diff --git a/testcases/kernel/syscalls/socket/socket02.c b/testcases/kernel/syscalls/socket/socket02.c
index 957a257019..30f7690899 100644
--- a/testcases/kernel/syscalls/socket/socket02.c
+++ b/testcases/kernel/syscalls/socket/socket02.c
@@ -6,8 +6,6 @@
 */
 
 /*\
- * [Description]
- *
  * Test socket() with SOCK_CLOEXEC and SOCK_NONBLOCK flags.
  */
 
diff --git a/testcases/kernel/syscalls/socketcall/socketcall01.c b/testcases/kernel/syscalls/socketcall/socketcall01.c
index 85ffd9d1e6..55d1e165d0 100644
--- a/testcases/kernel/syscalls/socketcall/socketcall01.c
+++ b/testcases/kernel/syscalls/socketcall/socketcall01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for the socketcall(2) raw syscall.
  *
  * Test creating TCP, UDP, raw socket and unix domain dgram.
diff --git a/testcases/kernel/syscalls/socketpair/socketpair01.c b/testcases/kernel/syscalls/socketpair/socketpair01.c
index b1e140a55a..6463485310 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair01.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair01.c
@@ -5,8 +5,6 @@
 */
 
 /*\
- * [Description]
- *
  * Verify that socketpair(2) fails and set proper errno
  *
  * - EAFNOSUPPORT on invalid domain
diff --git a/testcases/kernel/syscalls/socketpair/socketpair02.c b/testcases/kernel/syscalls/socketpair/socketpair02.c
index b43cf7295e..1a6f13317b 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair02.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair02.c
@@ -6,8 +6,6 @@
 */
 
 /*\
- * [Description]
- *
  * Test socket() with SOCK_CLOEXEC and SOCK_NONBLOCK flags.
  */
 
diff --git a/testcases/kernel/syscalls/splice/splice02.c b/testcases/kernel/syscalls/splice/splice02.c
index 1da1186b2a..e9aba47cce 100644
--- a/testcases/kernel/syscalls/splice/splice02.c
+++ b/testcases/kernel/syscalls/splice/splice02.c
@@ -5,7 +5,6 @@
  */
 
 /*\
- * [Description]
  * Original reproducer for kernel fix
  * bf40d3435caf NFS: add support for splice writes
  * from v2.6.31-rc1.
diff --git a/testcases/kernel/syscalls/splice/splice03.c b/testcases/kernel/syscalls/splice/splice03.c
index 26beb562a7..32a683dc3a 100644
--- a/testcases/kernel/syscalls/splice/splice03.c
+++ b/testcases/kernel/syscalls/splice/splice03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, splice(2) returns -1 and sets errno to
  *
  * 1. EBADF if the file descriptor fd_in is not valid
diff --git a/testcases/kernel/syscalls/splice/splice06.c b/testcases/kernel/syscalls/splice/splice06.c
index 0cb5dec291..e64d32deda 100644
--- a/testcases/kernel/syscalls/splice/splice06.c
+++ b/testcases/kernel/syscalls/splice/splice06.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test is cover splice() on proc files.
  *
  */
diff --git a/testcases/kernel/syscalls/splice/splice07.c b/testcases/kernel/syscalls/splice/splice07.c
index d3b527a4ff..2228e2f269 100644
--- a/testcases/kernel/syscalls/splice/splice07.c
+++ b/testcases/kernel/syscalls/splice/splice07.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Iterate over all kinds of file descriptors and feed splice() with all possible
  * combinations where at least one file descriptor is invalid. We do expect the
  * syscall to fail either with EINVAL or EBADF.
diff --git a/testcases/kernel/syscalls/splice/splice08.c b/testcases/kernel/syscalls/splice/splice08.c
index 6f22094681..3f9a070b7d 100644
--- a/testcases/kernel/syscalls/splice/splice08.c
+++ b/testcases/kernel/syscalls/splice/splice08.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for splicing from /dev/zero and /dev/full.
  *
  * The support for splicing from /dev/zero and /dev/full was removed in:
diff --git a/testcases/kernel/syscalls/splice/splice09.c b/testcases/kernel/syscalls/splice/splice09.c
index 9c63fb03cf..8863a01342 100644
--- a/testcases/kernel/syscalls/splice/splice09.c
+++ b/testcases/kernel/syscalls/splice/splice09.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for splicing to /dev/zero and /dev/null these two devices discard all
  * data written to them.
  *
diff --git a/testcases/kernel/syscalls/stat/stat01.c b/testcases/kernel/syscalls/stat/stat01.c
index 365cdac8a6..86aaa253c5 100644
--- a/testcases/kernel/syscalls/stat/stat01.c
+++ b/testcases/kernel/syscalls/stat/stat01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, stat(2) succeeds to get the status of a file and fills the
  * stat structure elements regardless of whether process has or doesn't
  * have read access to the file.
diff --git a/testcases/kernel/syscalls/stat/stat03.c b/testcases/kernel/syscalls/stat/stat03.c
index 369e6d79f1..6e08f507e3 100644
--- a/testcases/kernel/syscalls/stat/stat03.c
+++ b/testcases/kernel/syscalls/stat/stat03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * check stat() with various error conditions that should produce
  * EACCES, EFAULT, ENAMETOOLONG,  ENOENT, ENOTDIR, ELOOP
  */
diff --git a/testcases/kernel/syscalls/stat/stat04.c b/testcases/kernel/syscalls/stat/stat04.c
index 05ace606ad..09a9a68231 100644
--- a/testcases/kernel/syscalls/stat/stat04.c
+++ b/testcases/kernel/syscalls/stat/stat04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test checks that stat() executed on file provide the same information
  * of symlink linking to it.
  */
diff --git a/testcases/kernel/syscalls/statfs/statfs01.c b/testcases/kernel/syscalls/statfs/statfs01.c
index 62e1d00edf..e88d5a3034 100644
--- a/testcases/kernel/syscalls/statfs/statfs01.c
+++ b/testcases/kernel/syscalls/statfs/statfs01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that statfs() syscall executes successfully on all
  * available filesystems.
  */
diff --git a/testcases/kernel/syscalls/statfs/statfs02.c b/testcases/kernel/syscalls/statfs/statfs02.c
index ee9dba0cdc..c0444d7599 100644
--- a/testcases/kernel/syscalls/statfs/statfs02.c
+++ b/testcases/kernel/syscalls/statfs/statfs02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests for failures:
  *
  * - ENOTDIR A component of the pathname, which is not a directory.
diff --git a/testcases/kernel/syscalls/statfs/statfs03.c b/testcases/kernel/syscalls/statfs/statfs03.c
index 2afdbbf044..62b8044c09 100644
--- a/testcases/kernel/syscalls/statfs/statfs03.c
+++ b/testcases/kernel/syscalls/statfs/statfs03.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that statfs(2) fails with errno EACCES when search permission
  * is denied for a component of the path prefix of path.
  */
diff --git a/testcases/kernel/syscalls/statmount/statmount01.c b/testcases/kernel/syscalls/statmount/statmount01.c
index 73b9a59b01..fcf73e6ae4 100644
--- a/testcases/kernel/syscalls/statmount/statmount01.c
+++ b/testcases/kernel/syscalls/statmount/statmount01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that statmount() is working with no mask flags.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/statmount/statmount02.c b/testcases/kernel/syscalls/statmount/statmount02.c
index 4e23c69797..504c558a11 100644
--- a/testcases/kernel/syscalls/statmount/statmount02.c
+++ b/testcases/kernel/syscalls/statmount/statmount02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that statmount() is correctly reading basic filesystem
  * info using STATMOUNT_SB_BASIC.
  * The btrfs validation is currently skipped due to the lack of support for VFS.
diff --git a/testcases/kernel/syscalls/statmount/statmount03.c b/testcases/kernel/syscalls/statmount/statmount03.c
index dface528f6..36250c1c0d 100644
--- a/testcases/kernel/syscalls/statmount/statmount03.c
+++ b/testcases/kernel/syscalls/statmount/statmount03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that statmount() is correctly reading mount information
  * (mount id, parent mount id, mount attributes etc.) using STATMOUNT_MNT_BASIC.
  *
diff --git a/testcases/kernel/syscalls/statmount/statmount04.c b/testcases/kernel/syscalls/statmount/statmount04.c
index 509fdf6a17..7fd4fe8c5e 100644
--- a/testcases/kernel/syscalls/statmount/statmount04.c
+++ b/testcases/kernel/syscalls/statmount/statmount04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that statmount() is correctly reading propagation from
  * what mount in current namespace using STATMOUNT_PROPAGATE_FROM.
  *
diff --git a/testcases/kernel/syscalls/statmount/statmount05.c b/testcases/kernel/syscalls/statmount/statmount05.c
index 95e674c069..a517f82123 100644
--- a/testcases/kernel/syscalls/statmount/statmount05.c
+++ b/testcases/kernel/syscalls/statmount/statmount05.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies STATMOUNT_MNT_ROOT and STATMOUNT_MNT_POINT functionalities
  * of statmount(). In particular, STATMOUNT_MNT_ROOT will give the mount root
  * (i.e. mount --bind /mnt /bla -> /mnt) and STATMOUNT_MNT_POINT will
diff --git a/testcases/kernel/syscalls/statmount/statmount06.c b/testcases/kernel/syscalls/statmount/statmount06.c
index 73740407ea..fe41d5b87e 100644
--- a/testcases/kernel/syscalls/statmount/statmount06.c
+++ b/testcases/kernel/syscalls/statmount/statmount06.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that statmount() is correctly reading name of the
  * filesystem type using STATMOUNT_FS_TYPE.
  *
diff --git a/testcases/kernel/syscalls/statmount/statmount07.c b/testcases/kernel/syscalls/statmount/statmount07.c
index fc4f204795..2053dcc6e4 100644
--- a/testcases/kernel/syscalls/statmount/statmount07.c
+++ b/testcases/kernel/syscalls/statmount/statmount07.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that statmount() is raising the correct errors according
  * with invalid input values.
  */
diff --git a/testcases/kernel/syscalls/statmount/statmount08.c b/testcases/kernel/syscalls/statmount/statmount08.c
index 21b8b73420..b77116f058 100644
--- a/testcases/kernel/syscalls/statmount/statmount08.c
+++ b/testcases/kernel/syscalls/statmount/statmount08.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that statmount() raises EPERM when mount point is not accessible.
  */
 
diff --git a/testcases/kernel/syscalls/statvfs/statvfs01.c b/testcases/kernel/syscalls/statvfs/statvfs01.c
index 1aafe5e4b2..4e901a0a20 100644
--- a/testcases/kernel/syscalls/statvfs/statvfs01.c
+++ b/testcases/kernel/syscalls/statvfs/statvfs01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that statvfs() executes successfully for all
  * available filesystems. Verify statvfs.f_namemax field
  * by trying to create files of valid and invalid length names.
diff --git a/testcases/kernel/syscalls/statvfs/statvfs02.c b/testcases/kernel/syscalls/statvfs/statvfs02.c
index 506a35fea7..5ed30d31d9 100644
--- a/testcases/kernel/syscalls/statvfs/statvfs02.c
+++ b/testcases/kernel/syscalls/statvfs/statvfs02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that statvfs() fails with:
  *
  * - EFAULT when path points to an invalid address.
diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index f9c2748d23..dc63659cbd 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This code tests the functionality of statx system call.
  *
  * The metadata for normal file are tested against expected values:
diff --git a/testcases/kernel/syscalls/statx/statx02.c b/testcases/kernel/syscalls/statx/statx02.c
index 5ed80894d5..c8cb8987a5 100644
--- a/testcases/kernel/syscalls/statx/statx02.c
+++ b/testcases/kernel/syscalls/statx/statx02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This code tests the following flags with statx syscall:
  *
  * - AT_EMPTY_PATH
diff --git a/testcases/kernel/syscalls/statx/statx03.c b/testcases/kernel/syscalls/statx/statx03.c
index 2465d87730..4877a3e49f 100644
--- a/testcases/kernel/syscalls/statx/statx03.c
+++ b/testcases/kernel/syscalls/statx/statx03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test basic error handling of statx syscall:
  *
  * - EBADF - Bad file descriptor
diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index c2ed52deb2..af30a200ef 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test whether the kernel properly advertises support for statx() attributes:
  *
  * - STATX_ATTR_COMPRESSED: The file is compressed by the filesystem.
diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
index 2411f3f9fe..2a46032260 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test statx syscall with STATX_ATTR_ENCRYPTED flag, setting a key is required
  * for the file to be encrypted by the filesystem.
  *
diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
index d3dd9b9cf7..9795740c45 100644
--- a/testcases/kernel/syscalls/statx/statx06.c
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test the following file timestamps of statx syscall:
  *
  * - btime - The time before and after the execution of the create system call is noted.
diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index 9681743307..770a55ea2a 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This code tests the following flags:
  *
  * - AT_STATX_FORCE_SYNC
diff --git a/testcases/kernel/syscalls/statx/statx08.c b/testcases/kernel/syscalls/statx/statx08.c
index 64b36986d2..caced5d3d7 100644
--- a/testcases/kernel/syscalls/statx/statx08.c
+++ b/testcases/kernel/syscalls/statx/statx08.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This case tests whether the attributes field of statx received expected value
  * by using flags in the stx_attributes_mask field of statx.
  * File set with following flags by using SAFE_IOCTL:
diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
index 864e35c7d1..ee4be42507 100644
--- a/testcases/kernel/syscalls/statx/statx09.c
+++ b/testcases/kernel/syscalls/statx/statx09.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This code tests if STATX_ATTR_VERITY flag in the statx attributes is set correctly.
  *
  * The statx() system call sets STATX_ATTR_VERITY if the file has fs-verity
diff --git a/testcases/kernel/syscalls/statx/statx10.c b/testcases/kernel/syscalls/statx/statx10.c
index 42106285e5..079fb67a67 100644
--- a/testcases/kernel/syscalls/statx/statx10.c
+++ b/testcases/kernel/syscalls/statx/statx10.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * It is a basic test for STATX_DIOALIGN mask on ext4 and xfs filesystem.
  *
  * - STATX_DIOALIGN   Want stx_dio_mem_align and stx_dio_offset_align value
diff --git a/testcases/kernel/syscalls/statx/statx11.c b/testcases/kernel/syscalls/statx/statx11.c
index 653050855f..5465c265bb 100644
--- a/testcases/kernel/syscalls/statx/statx11.c
+++ b/testcases/kernel/syscalls/statx/statx11.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * It is a basic test for STATX_DIOALIGN mask on block device.
  *
  * - STATX_DIOALIGN   Want stx_dio_mem_align and stx_dio_offset_align value
diff --git a/testcases/kernel/syscalls/statx/statx12.c b/testcases/kernel/syscalls/statx/statx12.c
index 432f1cb771..8b5393aab9 100644
--- a/testcases/kernel/syscalls/statx/statx12.c
+++ b/testcases/kernel/syscalls/statx/statx12.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * It is a basic test for STATX_ATTR_MOUNT_ROOT flag.
  *
  * This flag indicates whether the path or fd refers to the root of a mount
diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index e97ff2c626..bf097ac1aa 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that swapoff() succeeds.
  */
 
diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
index 0ab8338c51..b6c4289891 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff02.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test case checks whether swapoff(2) system call  returns
  *  1. EINVAL when the path does not exist
  *  2. ENOENT when the path exists but is invalid
diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index 7d1ec70702..a214bc9dbf 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Checks that swapon() succeds with swapfile.
  * Testing on all filesystems which support swap file.
  */
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index 73cc3bb44f..625d463f72 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test case checks whether swapon(2) system call returns:
  *
  * - ENOENT when the path does not exist
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 436f864eba..0068560fea 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test case checks whether swapon(2) system call returns:
  *
  *  - EPERM when there are more than MAX_SWAPFILES already in use.
diff --git a/testcases/kernel/syscalls/symlink/symlink02.c b/testcases/kernel/syscalls/symlink/symlink02.c
index d2226501e0..e5cf1c8ac6 100644
--- a/testcases/kernel/syscalls/symlink/symlink02.c
+++ b/testcases/kernel/syscalls/symlink/symlink02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check the basic functionality of the symlink() system call.
  */
 
diff --git a/testcases/kernel/syscalls/symlink/symlink04.c b/testcases/kernel/syscalls/symlink/symlink04.c
index c43a03a264..b8aca24126 100644
--- a/testcases/kernel/syscalls/symlink/symlink04.c
+++ b/testcases/kernel/syscalls/symlink/symlink04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that a symbolic link may point to an existing file or
  * to a nonexistent one.
  */
diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
index 47188aa487..ead4314a66 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic error conditions test for sync_file_range() system call, tests for:
  *
  * - EBADFD Wrong filedescriptor
diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
index 28a8156c8f..761a396feb 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests if sync_file_range() does sync a test file range with a many dirty pages
  * to a block device. Also, it tests all supported filesystems on a test block
  * device.
diff --git a/testcases/kernel/syscalls/syscall/syscall01.c b/testcases/kernel/syscalls/syscall/syscall01.c
index 356eb8f0d4..deb8a4e5dc 100644
--- a/testcases/kernel/syscalls/syscall/syscall01.c
+++ b/testcases/kernel/syscalls/syscall/syscall01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for syscall().
  *
  * Compare raw get{g,p,u}id results with their glibc wrappers.
diff --git a/testcases/kernel/syscalls/sysfs/sysfs01.c b/testcases/kernel/syscalls/sysfs/sysfs01.c
index 3a91fcb0b4..a83053df88 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs01.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test is run for option 1 for sysfs(2).
  * Translate the filesystem identifier string fsname into a filesystem type index.
  */
diff --git a/testcases/kernel/syscalls/sysfs/sysfs02.c b/testcases/kernel/syscalls/sysfs/sysfs02.c
index b6d8103649..4bca516163 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs02.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test is run for option 2 for sysfs(2).
  * Translate the filesystem type index fs_index into a null-terminated filesystem
  * identifier string. This string will be written to the buffer pointed to by buf.
diff --git a/testcases/kernel/syscalls/sysfs/sysfs03.c b/testcases/kernel/syscalls/sysfs/sysfs03.c
index b679d78097..aae962f8eb 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs03.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test is run for option 3 for sysfs(2).
  * Return the total number of filesystem types currently present in the kernel.
  */
diff --git a/testcases/kernel/syscalls/sysfs/sysfs04.c b/testcases/kernel/syscalls/sysfs/sysfs04.c
index ffda51bf38..ef504b9320 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs04.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test case checks whether sysfs(2) system call returns
  * appropriate error number for invalid option.
  */
diff --git a/testcases/kernel/syscalls/sysfs/sysfs05.c b/testcases/kernel/syscalls/sysfs/sysfs05.c
index bfcead7dbe..922c4630d3 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs05.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs05.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test case checks whether sysfs(2) system call returns appropriate
  * error number for invalid option and for invalid filesystem name and fs index out of bounds.
  */
diff --git a/testcases/kernel/syscalls/syslog/syslog11.c b/testcases/kernel/syscalls/syslog/syslog11.c
index 733da5f963..28a6fdf494 100644
--- a/testcases/kernel/syscalls/syslog/syslog11.c
+++ b/testcases/kernel/syscalls/syslog/syslog11.c
@@ -5,8 +5,6 @@
  */
 
 /*
- * [Description]
- *
  * Verify that, syslog(2) is successful for type ranging from 1 to 8
  */
 
diff --git a/testcases/kernel/syscalls/syslog/syslog12.c b/testcases/kernel/syscalls/syslog/syslog12.c
index e8b39a1150..9d519b548d 100644
--- a/testcases/kernel/syscalls/syslog/syslog12.c
+++ b/testcases/kernel/syscalls/syslog/syslog12.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that syslog(2) system call fails with appropriate error number:
  *
  * 1. EINVAL -- invalid type/command
diff --git a/testcases/kernel/syscalls/tee/tee02.c b/testcases/kernel/syscalls/tee/tee02.c
index 945261223b..0ee94000d3 100644
--- a/testcases/kernel/syscalls/tee/tee02.c
+++ b/testcases/kernel/syscalls/tee/tee02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, tee(2) returns -1 and sets errno to:
  *
  * 1. EINVAL if fd_in does not refer to a pipe.
diff --git a/testcases/kernel/syscalls/time/time01.c b/testcases/kernel/syscalls/time/time01.c
index d8625c04d0..7085f19896 100644
--- a/testcases/kernel/syscalls/time/time01.c
+++ b/testcases/kernel/syscalls/time/time01.c
@@ -4,7 +4,6 @@
  */
 
 /*\
- * [Description]
  * - Basic test for the time(2) system call. It is intended to provide a
  * limited exposure of the system call.
  * - Verify that time(2) returns the value of time in seconds since the Epoch
diff --git a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
index 57c2147bf4..a015cbe4c4 100644
--- a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
+++ b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
@@ -10,8 +10,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test checks base timer_getoverrun() functionality.
  */
 
diff --git a/testcases/kernel/syscalls/timerfd/timerfd02.c b/testcases/kernel/syscalls/timerfd/timerfd02.c
index 3dabfb5c06..f89d41502e 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd02.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd02.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 /*\
- * [Description]
- *
  * This test verifies that:
  * - TFD_CLOEXEC sets the close-on-exec file status flag on the new open  file
  * - TFD_NONBLOCK sets the O_NONBLOCK file status flag on the new open file
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_create01.c b/testcases/kernel/syscalls/timerfd/timerfd_create01.c
index 18a2335867..2a658f0674 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_create01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_create01.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 /*\
- * [Description]
- *
  * This test verifies that:
  * - clockid argument is neither CLOCK_MONOTONIC nor CLOCK_REALTIME,
  * EINVAL would return.
diff --git a/testcases/kernel/syscalls/times/times01.c b/testcases/kernel/syscalls/times/times01.c
index 408b91c9c8..4c809aa625 100644
--- a/testcases/kernel/syscalls/times/times01.c
+++ b/testcases/kernel/syscalls/times/times01.c
@@ -3,8 +3,6 @@
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  */
 /*\
- * [Description]
- *
  * This is a Phase I test for the times(2) system call.  It is intended to
  * provide a limited exposure of the system call.
  */
diff --git a/testcases/kernel/syscalls/tkill/tkill01.c b/testcases/kernel/syscalls/tkill/tkill01.c
index 15f2dfb3e9..d97ed0b941 100644
--- a/testcases/kernel/syscalls/tkill/tkill01.c
+++ b/testcases/kernel/syscalls/tkill/tkill01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic tests for the tkill syscall.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/tkill/tkill02.c b/testcases/kernel/syscalls/tkill/tkill02.c
index 6cd60923bd..30823f61b2 100644
--- a/testcases/kernel/syscalls/tkill/tkill02.c
+++ b/testcases/kernel/syscalls/tkill/tkill02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic tests for the tkill() errors.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/truncate/truncate02.c b/testcases/kernel/syscalls/truncate/truncate02.c
index 8d7f9a6fab..2ed6f18e6c 100644
--- a/testcases/kernel/syscalls/truncate/truncate02.c
+++ b/testcases/kernel/syscalls/truncate/truncate02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that:
  *
  * - truncate(2) truncates a file to a specified length successfully.
diff --git a/testcases/kernel/syscalls/truncate/truncate03.c b/testcases/kernel/syscalls/truncate/truncate03.c
index 2607e7d63e..a017ee4b62 100644
--- a/testcases/kernel/syscalls/truncate/truncate03.c
+++ b/testcases/kernel/syscalls/truncate/truncate03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that:
  *
  * - truncate(2) returns -1 and sets errno to EACCES if search/write
diff --git a/testcases/kernel/syscalls/umount/umount01.c b/testcases/kernel/syscalls/umount/umount01.c
index 264c8f7d7e..a8f34e7a15 100644
--- a/testcases/kernel/syscalls/umount/umount01.c
+++ b/testcases/kernel/syscalls/umount/umount01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check the basic functionality of the umount(2) system call.
  */
 
diff --git a/testcases/kernel/syscalls/umount/umount02.c b/testcases/kernel/syscalls/umount/umount02.c
index acc35e8a4f..e7fe246eb9 100644
--- a/testcases/kernel/syscalls/umount/umount02.c
+++ b/testcases/kernel/syscalls/umount/umount02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check for basic errors returned by umount(2) system call.
  *
  * Verify that umount(2) returns -1 and sets errno to
diff --git a/testcases/kernel/syscalls/umount/umount03.c b/testcases/kernel/syscalls/umount/umount03.c
index 3260312f7f..c181e63d92 100644
--- a/testcases/kernel/syscalls/umount/umount03.c
+++ b/testcases/kernel/syscalls/umount/umount03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that umount(2) returns -1 and sets errno to EPERM if the user
  * is not the super-user.
  */
diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
index f4b228f975..ff0bdf911a 100644
--- a/testcases/kernel/syscalls/umount2/umount2_02.c
+++ b/testcases/kernel/syscalls/umount2/umount2_02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test for feature MNT_EXPIRE of umount2():
  *
  * - EINVAL when flag is specified with either MNT_FORCE or MNT_DETACH
diff --git a/testcases/kernel/syscalls/unlink/unlink05.c b/testcases/kernel/syscalls/unlink/unlink05.c
index 81afeebf52..b270269601 100644
--- a/testcases/kernel/syscalls/unlink/unlink05.c
+++ b/testcases/kernel/syscalls/unlink/unlink05.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check the basic functionality of the unlink(2):
  *
  * - unlink(2) can delete regular file successfully.
diff --git a/testcases/kernel/syscalls/unlink/unlink07.c b/testcases/kernel/syscalls/unlink/unlink07.c
index b7bbd8d19b..ea99392d28 100644
--- a/testcases/kernel/syscalls/unlink/unlink07.c
+++ b/testcases/kernel/syscalls/unlink/unlink07.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that unlink(2) fails with
  *
  * - ENOENT when file does not exist
diff --git a/testcases/kernel/syscalls/unlink/unlink08.c b/testcases/kernel/syscalls/unlink/unlink08.c
index 1fe6e89f71..6d3ab261f8 100644
--- a/testcases/kernel/syscalls/unlink/unlink08.c
+++ b/testcases/kernel/syscalls/unlink/unlink08.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that unlink(2) fails with
  *
  * - EACCES when no write access to the directory containing pathname
diff --git a/testcases/kernel/syscalls/unlink/unlink09.c b/testcases/kernel/syscalls/unlink/unlink09.c
index 55bc4ab27c..e2ee062cb9 100644
--- a/testcases/kernel/syscalls/unlink/unlink09.c
+++ b/testcases/kernel/syscalls/unlink/unlink09.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that unlink(2) fails with EPERM when target file is marked as
  * immutable or append-only.
  */
diff --git a/testcases/kernel/syscalls/unlink/unlink10.c b/testcases/kernel/syscalls/unlink/unlink10.c
index 861f24a50e..453dd5c754 100644
--- a/testcases/kernel/syscalls/unlink/unlink10.c
+++ b/testcases/kernel/syscalls/unlink/unlink10.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that unlink(2) fails with EROFS when target file is on a read-only
  * filesystem.
  */
diff --git a/testcases/kernel/syscalls/unlinkat/unlinkat01.c b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
index 7dba1d6414..9374466f5f 100644
--- a/testcases/kernel/syscalls/unlinkat/unlinkat01.c
+++ b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
@@ -7,7 +7,6 @@
  */
 
 /*\
- * [Description]
  * Basic unlinkat() test.
  */
 
diff --git a/testcases/kernel/syscalls/unshare/unshare01.c b/testcases/kernel/syscalls/unshare/unshare01.c
index ad26a908d9..6e6315b114 100644
--- a/testcases/kernel/syscalls/unshare/unshare01.c
+++ b/testcases/kernel/syscalls/unshare/unshare01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic tests for the unshare() syscall.
  *
  * [Algorithm]
diff --git a/testcases/kernel/syscalls/unshare/unshare02.c b/testcases/kernel/syscalls/unshare/unshare02.c
index 3783e8e9ad..436b0c3b50 100644
--- a/testcases/kernel/syscalls/unshare/unshare02.c
+++ b/testcases/kernel/syscalls/unshare/unshare02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic tests for the unshare(2) errors.
  *
  * - EINVAL on invalid flags
diff --git a/testcases/kernel/syscalls/utime/utime01.c b/testcases/kernel/syscalls/utime/utime01.c
index 0cc9822e71..2a74f8952d 100644
--- a/testcases/kernel/syscalls/utime/utime01.c
+++ b/testcases/kernel/syscalls/utime/utime01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that the system call utime() successfully changes the last
  * access and modification times of a file to the current time if the
  * times argument is NULL and the user ID of the process is "root".
diff --git a/testcases/kernel/syscalls/utime/utime02.c b/testcases/kernel/syscalls/utime/utime02.c
index fdcd40f660..52185d839e 100644
--- a/testcases/kernel/syscalls/utime/utime02.c
+++ b/testcases/kernel/syscalls/utime/utime02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that the system call utime() successfully changes the last
  * access and modification times of a file to the current time,
  * under the following constraints:
diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
index 734f4897b7..564e1de3dd 100644
--- a/testcases/kernel/syscalls/utime/utime03.c
+++ b/testcases/kernel/syscalls/utime/utime03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that the system call utime() successfully sets the modification
  * and access times of a file to the current time, under the following
  * constraints:
diff --git a/testcases/kernel/syscalls/utime/utime04.c b/testcases/kernel/syscalls/utime/utime04.c
index 7b820ab061..0728454bbb 100644
--- a/testcases/kernel/syscalls/utime/utime04.c
+++ b/testcases/kernel/syscalls/utime/utime04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that the system call utime() successfully changes the last
  * access and modification times of a file to the values specified by
  * times argument, under the following constraints:
diff --git a/testcases/kernel/syscalls/utime/utime05.c b/testcases/kernel/syscalls/utime/utime05.c
index 941a3ccee8..045e275b9b 100644
--- a/testcases/kernel/syscalls/utime/utime05.c
+++ b/testcases/kernel/syscalls/utime/utime05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that the system call utime() successfully changes the last
  * access and modification times of a file to the values specified by
  * times argument, under the following constraints:
diff --git a/testcases/kernel/syscalls/utime/utime06.c b/testcases/kernel/syscalls/utime/utime06.c
index 3ba62a3162..c03b1d8527 100644
--- a/testcases/kernel/syscalls/utime/utime06.c
+++ b/testcases/kernel/syscalls/utime/utime06.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that system call utime() fails with
  *
  * - EACCES when times argument is NULL and user does not have rights to modify
diff --git a/testcases/kernel/syscalls/utime/utime07.c b/testcases/kernel/syscalls/utime/utime07.c
index 8889b3a6d1..e44b246dcd 100644
--- a/testcases/kernel/syscalls/utime/utime07.c
+++ b/testcases/kernel/syscalls/utime/utime07.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test verifies that utime() is working correctly on symlink()
  * generated files.
  *
diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index f9f5d7f6cd..c113279622 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat01.c
+++ b/testcases/kernel/syscalls/utimensat/utimensat01.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic utimnsat() test.
  */
 
diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
index 3c97c40532..b66f39b654 100644
--- a/testcases/kernel/syscalls/utimes/utimes01.c
+++ b/testcases/kernel/syscalls/utimes/utimes01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, utimes(2) returns -1 and sets errno to
  *
  * 1. EACCES if times is NULL, the caller's effective user ID does not match
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice02.c b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
index 24ff3c0f85..94c98fb13b 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice02.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that, vmsplice(2) returns -1 and sets errno to:
  *
  * - EBADF if fd is not valid.
diff --git a/testcases/kernel/syscalls/wait/wait01.c b/testcases/kernel/syscalls/wait/wait01.c
index 8245898dd2..685da14bc3 100644
--- a/testcases/kernel/syscalls/wait/wait01.c
+++ b/testcases/kernel/syscalls/wait/wait01.c
@@ -4,8 +4,6 @@
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
  */
 /*\
- * [Description]
- *
  * Check that if the calling process does not have any unwaited-for children
  * wait() will return ECHILD.
  */
diff --git a/testcases/kernel/syscalls/wait/wait02.c b/testcases/kernel/syscalls/wait/wait02.c
index 806557c1ba..d5d721f68c 100644
--- a/testcases/kernel/syscalls/wait/wait02.c
+++ b/testcases/kernel/syscalls/wait/wait02.c
@@ -5,8 +5,6 @@
  *    CO-PILOT		: Dave Fenner
  */
 /*\
- * [Description]
- *
  * For a terminated child, test whether wait(2) can get its pid
  * and exit status correctly.
  */
diff --git a/testcases/kernel/syscalls/wait4/wait402.c b/testcases/kernel/syscalls/wait4/wait402.c
index 36fba73784..18ed0814f4 100644
--- a/testcases/kernel/syscalls/wait4/wait402.c
+++ b/testcases/kernel/syscalls/wait4/wait402.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check for ECHILD errno when call wait4(2) with an invalid pid value.
  */
 
diff --git a/testcases/kernel/syscalls/wait4/wait403.c b/testcases/kernel/syscalls/wait4/wait403.c
index 8746794e5a..c610a9fa1d 100644
--- a/testcases/kernel/syscalls/wait4/wait403.c
+++ b/testcases/kernel/syscalls/wait4/wait403.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check wait4(INT_MIN, ...) is not allowed. The pid is negated before
  * searching for a group with that pid. Negating INT_MIN is not
  * defined so UBSAN will be triggered if enabled. Also see kill13.
diff --git a/testcases/kernel/syscalls/waitid/waitid01.c b/testcases/kernel/syscalls/waitid/waitid01.c
index 136eec8a69..cb444d19a8 100644
--- a/testcases/kernel/syscalls/waitid/waitid01.c
+++ b/testcases/kernel/syscalls/waitid/waitid01.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test is checking if waitid() syscall does wait for WEXITED and check for
  * the return value.
  */
diff --git a/testcases/kernel/syscalls/waitid/waitid02.c b/testcases/kernel/syscalls/waitid/waitid02.c
index f13a4ed00f..ea0d261277 100644
--- a/testcases/kernel/syscalls/waitid/waitid02.c
+++ b/testcases/kernel/syscalls/waitid/waitid02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests if waitid() returns EINVAL when passed invalid options flag value.
  */
 
diff --git a/testcases/kernel/syscalls/waitid/waitid03.c b/testcases/kernel/syscalls/waitid/waitid03.c
index ef3fd73763..4e70c401fb 100644
--- a/testcases/kernel/syscalls/waitid/waitid03.c
+++ b/testcases/kernel/syscalls/waitid/waitid03.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests if waitid() syscall returns ECHILD when the calling process has no
  * child processes.
  */
diff --git a/testcases/kernel/syscalls/waitid/waitid04.c b/testcases/kernel/syscalls/waitid/waitid04.c
index 96c1cf8b19..0d4b16118f 100644
--- a/testcases/kernel/syscalls/waitid/waitid04.c
+++ b/testcases/kernel/syscalls/waitid/waitid04.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test if waitid() syscall leaves the si_pid set to 0 with WNOHANG flag
  * when no child was waited for.
  */
diff --git a/testcases/kernel/syscalls/waitid/waitid05.c b/testcases/kernel/syscalls/waitid/waitid05.c
index 1b9186dc13..db9d3b22d7 100644
--- a/testcases/kernel/syscalls/waitid/waitid05.c
+++ b/testcases/kernel/syscalls/waitid/waitid05.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests if waitid() filters children correctly by the group ID.
  *
  * - waitid() with GID + 1 returns ECHILD
diff --git a/testcases/kernel/syscalls/waitid/waitid06.c b/testcases/kernel/syscalls/waitid/waitid06.c
index 5f51c81c81..ed6404bf67 100644
--- a/testcases/kernel/syscalls/waitid/waitid06.c
+++ b/testcases/kernel/syscalls/waitid/waitid06.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests if waitid() filters children correctly by the PID.
  *
  * - waitid() with PID + 1 returns ECHILD
diff --git a/testcases/kernel/syscalls/waitid/waitid07.c b/testcases/kernel/syscalls/waitid/waitid07.c
index d607dbd8f3..e5df1cc426 100644
--- a/testcases/kernel/syscalls/waitid/waitid07.c
+++ b/testcases/kernel/syscalls/waitid/waitid07.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test if waitid() filters children killed with SIGSTOP.
  */
 
diff --git a/testcases/kernel/syscalls/waitid/waitid08.c b/testcases/kernel/syscalls/waitid/waitid08.c
index 2da680e640..519ccf7801 100644
--- a/testcases/kernel/syscalls/waitid/waitid08.c
+++ b/testcases/kernel/syscalls/waitid/waitid08.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test if waitid() filters children killed with SIGCONT.
  */
 
diff --git a/testcases/kernel/syscalls/waitid/waitid09.c b/testcases/kernel/syscalls/waitid/waitid09.c
index 115c2e672d..3a3080bc45 100644
--- a/testcases/kernel/syscalls/waitid/waitid09.c
+++ b/testcases/kernel/syscalls/waitid/waitid09.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test that waitid() fails with ECHILD with process that is not child of the
  * current process. We fork() one child just to be sure that there are unwaited
  * for children available while the test runs.
diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
index 9100cc2d7a..14d4ba76bf 100644
--- a/testcases/kernel/syscalls/waitid/waitid10.c
+++ b/testcases/kernel/syscalls/waitid/waitid10.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test is checking if waitid() syscall recognizes a process that ended
  * with division by zero error.
  */
diff --git a/testcases/kernel/syscalls/waitid/waitid11.c b/testcases/kernel/syscalls/waitid/waitid11.c
index e3754bb1d6..63d011e6d5 100644
--- a/testcases/kernel/syscalls/waitid/waitid11.c
+++ b/testcases/kernel/syscalls/waitid/waitid11.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * This test is checking if waitid() syscall recognizes a process that has been
  * killed with SIGKILL.
  */
diff --git a/testcases/kernel/syscalls/waitpid/waitpid01.c b/testcases/kernel/syscalls/waitpid/waitpid01.c
index 1e38863e6c..cb65d1e20f 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid01.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid01.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that when a child kills itself with one of the standard signals,
  * the waiting parent is correctly notified.
  *
diff --git a/testcases/kernel/syscalls/waitpid/waitpid03.c b/testcases/kernel/syscalls/waitpid/waitpid03.c
index b2ee0549c5..12a2a214d8 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid03.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid03.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check that waitpid() returns the exit status of a specific child process
  * and repeated call on the same process will fail with ECHILD.
  */
diff --git a/testcases/kernel/syscalls/waitpid/waitpid04.c b/testcases/kernel/syscalls/waitpid/waitpid04.c
index 7e60ef6ab3..ee8e8daad3 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid04.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test to check the error conditions in waitpid() syscall.
  */
 
diff --git a/testcases/kernel/syscalls/write/write02.c b/testcases/kernel/syscalls/write/write02.c
index ab38dce77e..a5855c8d6a 100644
--- a/testcases/kernel/syscalls/write/write02.c
+++ b/testcases/kernel/syscalls/write/write02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tests for a special case NULL buffer with size 0 is expected to return 0.
  */
 
diff --git a/testcases/kernel/syscalls/write/write04.c b/testcases/kernel/syscalls/write/write04.c
index a5d62e0f54..41bd35a101 100644
--- a/testcases/kernel/syscalls/write/write04.c
+++ b/testcases/kernel/syscalls/write/write04.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that write(2) fails with errno EAGAIN when attempt to write to fifo
  * opened in O_NONBLOCK mode.
  */
diff --git a/testcases/kernel/syscalls/write/write05.c b/testcases/kernel/syscalls/write/write05.c
index b907624a8e..96988b0d0b 100644
--- a/testcases/kernel/syscalls/write/write05.c
+++ b/testcases/kernel/syscalls/write/write05.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  *	Check the return value, and errnos of write(2)
  *
  *	- when the file descriptor is invalid - EBADF
diff --git a/testcases/kernel/syscalls/write/write06.c b/testcases/kernel/syscalls/write/write06.c
index aac1e6f7c9..068aaa584f 100644
--- a/testcases/kernel/syscalls/write/write06.c
+++ b/testcases/kernel/syscalls/write/write06.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test the write() system call with O_APPEND.
  *
  * The full description of O_APPEND is in open(2) man-pages:
diff --git a/testcases/kernel/syscalls/writev/writev03.c b/testcases/kernel/syscalls/writev/writev03.c
index 7074a418a9..f2326095ec 100644
--- a/testcases/kernel/syscalls/writev/writev03.c
+++ b/testcases/kernel/syscalls/writev/writev03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Check for potential issues in writev() if the first iovec entry is NULL
  * and the next one is not present in RAM. This can result in a brief window
  * where writev() first writes uninitialized data into the file (possibly
diff --git a/testcases/kernel/syscalls/writev/writev07.c b/testcases/kernel/syscalls/writev/writev07.c
index 3dda1caa4e..0798296a72 100644
--- a/testcases/kernel/syscalls/writev/writev07.c
+++ b/testcases/kernel/syscalls/writev/writev07.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify writev() behaviour with partially valid iovec list.
  * Kernel <4.8 used to shorten write up to first bad invalid
  * iovec. Starting with 4.8, a writev with short data (under
diff --git a/testcases/kernel/uevents/uevent01.c b/testcases/kernel/uevents/uevent01.c
index a1f9941509..09ef424128 100644
--- a/testcases/kernel/uevents/uevent01.c
+++ b/testcases/kernel/uevents/uevent01.c
@@ -5,7 +5,6 @@
  */
 
 /*\
- * [Description]
  * Very simple uevent netlink socket test.
  *
  * We fork a child that listens for a kernel events while parents attaches and
diff --git a/testcases/kernel/uevents/uevent02.c b/testcases/kernel/uevents/uevent02.c
index daa1b4f12c..abae4f88ed 100644
--- a/testcases/kernel/uevents/uevent02.c
+++ b/testcases/kernel/uevents/uevent02.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Very simple uevent netlink socket test.
  *
  * We fork a child that listens for a kernel events while parents creates and
diff --git a/testcases/kernel/uevents/uevent03.c b/testcases/kernel/uevents/uevent03.c
index f7072db1c5..126c924f18 100644
--- a/testcases/kernel/uevents/uevent03.c
+++ b/testcases/kernel/uevents/uevent03.c
@@ -5,7 +5,6 @@
  */
 
 /*\
- * [Description]
  * Very simple uevent netlink socket test.
  *
  * We fork a child that listens for a kernel events while parents creates and
diff --git a/testcases/kernel/watchqueue/wqueue01.c b/testcases/kernel/watchqueue/wqueue01.c
index 904e512af1..2f621ebc1a 100644
--- a/testcases/kernel/watchqueue/wqueue01.c
+++ b/testcases/kernel/watchqueue/wqueue01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test if keyctl update is correctly recognized by watch queue.
  */
 
diff --git a/testcases/kernel/watchqueue/wqueue02.c b/testcases/kernel/watchqueue/wqueue02.c
index 0c3e947d15..943a62674f 100644
--- a/testcases/kernel/watchqueue/wqueue02.c
+++ b/testcases/kernel/watchqueue/wqueue02.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test if keyctl unlink is correctly recognized by watch queue.
  */
 
diff --git a/testcases/kernel/watchqueue/wqueue03.c b/testcases/kernel/watchqueue/wqueue03.c
index c17fc14525..d36a201e21 100644
--- a/testcases/kernel/watchqueue/wqueue03.c
+++ b/testcases/kernel/watchqueue/wqueue03.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test if keyctl revoke is correctly recognized by watch queue.
  */
 
diff --git a/testcases/kernel/watchqueue/wqueue04.c b/testcases/kernel/watchqueue/wqueue04.c
index fc880064bf..5cb28eb1d6 100644
--- a/testcases/kernel/watchqueue/wqueue04.c
+++ b/testcases/kernel/watchqueue/wqueue04.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test if keyctl link is correctly recognized by watch queue.
  */
 
diff --git a/testcases/kernel/watchqueue/wqueue05.c b/testcases/kernel/watchqueue/wqueue05.c
index 78a4c702ec..9ef1b58142 100644
--- a/testcases/kernel/watchqueue/wqueue05.c
+++ b/testcases/kernel/watchqueue/wqueue05.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test if keyctl invalidate is correctly recognized by watch queue.
  */
 
diff --git a/testcases/kernel/watchqueue/wqueue06.c b/testcases/kernel/watchqueue/wqueue06.c
index 2cb6a966d7..524ba9960d 100644
--- a/testcases/kernel/watchqueue/wqueue06.c
+++ b/testcases/kernel/watchqueue/wqueue06.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test if keyctl clear is correctly recognized by watch queue.
  */
 
diff --git a/testcases/kernel/watchqueue/wqueue07.c b/testcases/kernel/watchqueue/wqueue07.c
index 6c4d1e92ad..4189600ba9 100644
--- a/testcases/kernel/watchqueue/wqueue07.c
+++ b/testcases/kernel/watchqueue/wqueue07.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test if keyctl setperm is correctly recognized by watch queue.
  */
 
diff --git a/testcases/kernel/watchqueue/wqueue08.c b/testcases/kernel/watchqueue/wqueue08.c
index 4ed9522da2..21fbd246b9 100644
--- a/testcases/kernel/watchqueue/wqueue08.c
+++ b/testcases/kernel/watchqueue/wqueue08.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Test if key watch removal is correctly recognized by watch queue.
  */
 
diff --git a/testcases/kernel/watchqueue/wqueue09.c b/testcases/kernel/watchqueue/wqueue09.c
index 9f077b35be..dfda0cc6f3 100644
--- a/testcases/kernel/watchqueue/wqueue09.c
+++ b/testcases/kernel/watchqueue/wqueue09.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Fill the watch queue and wait for a notification loss.
  */
 
diff --git a/testcases/lib/tst_ns_create.c b/testcases/lib/tst_ns_create.c
index bd7633b0bc..90862d9dee 100644
--- a/testcases/lib/tst_ns_create.c
+++ b/testcases/lib/tst_ns_create.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Creates a child process in the new specified namespace(s), child is then
  * daemonized and is running in the background. PID of the daemonized child
  * process is printed on the stdout. As the new namespace(s) is(are) maintained
diff --git a/testcases/lib/tst_ns_exec.c b/testcases/lib/tst_ns_exec.c
index 5d34e9ad5d..d5011231e5 100644
--- a/testcases/lib/tst_ns_exec.c
+++ b/testcases/lib/tst_ns_exec.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Enters the namespace(s) of a process specified by a PID and then executes
  * the indicated program inside that namespace(s).
  */
diff --git a/testcases/lib/tst_ns_ifmove.c b/testcases/lib/tst_ns_ifmove.c
index 03531fc9bb..ba1d23400f 100644
--- a/testcases/lib/tst_ns_ifmove.c
+++ b/testcases/lib/tst_ns_ifmove.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Moves a network interface to the namespace of a process specified by a PID.
  */
 
diff --git a/testcases/network/can/cve/can_bcm01.c b/testcases/network/can/cve/can_bcm01.c
index 30d85ad62e..e316a8deb5 100644
--- a/testcases/network/can/cve/can_bcm01.c
+++ b/testcases/network/can/cve/can_bcm01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * CVE-2021-3609
  *
  * Test for race condition vulnerability in CAN BCM. Fixed in:
diff --git a/testcases/network/iptables/nft02.c b/testcases/network/iptables/nft02.c
index 8b7248c69b..5f0671c5d3 100644
--- a/testcases/network/iptables/nft02.c
+++ b/testcases/network/iptables/nft02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * CVE-2023-31248
  *
  * Test for use-after-free when adding a new rule to a chain deleted
diff --git a/testcases/network/lib6/asapi_02.c b/testcases/network/lib6/asapi_02.c
index 7808b2c3a7..55588c3310 100644
--- a/testcases/network/lib6/asapi_02.c
+++ b/testcases/network/lib6/asapi_02.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic test for ICMP6_FILTER.
  *
  * For ICMP6_FILTER usage, refer to: https://man.openbsd.org/icmp6.
diff --git a/testcases/network/lib6/getaddrinfo_01.c b/testcases/network/lib6/getaddrinfo_01.c
index 1974021413..61a4aad508 100644
--- a/testcases/network/lib6/getaddrinfo_01.c
+++ b/testcases/network/lib6/getaddrinfo_01.c
@@ -8,8 +8,6 @@
  */
 
 /*\
- * [Description]
- *
  * Basic getaddrinfo() tests.
  *
  * The test adds LTP specific addresses and names to /etc/hosts to avoid
diff --git a/testcases/network/lib6/in6_01.c b/testcases/network/lib6/in6_01.c
index 823d3cac7a..b5066a5847 100644
--- a/testcases/network/lib6/in6_01.c
+++ b/testcases/network/lib6/in6_01.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * Verify that in6 and sockaddr fields are present.
  */
 
diff --git a/testcases/network/lib6/in6_02.c b/testcases/network/lib6/in6_02.c
index e9630d7049..71bfe71886 100644
--- a/testcases/network/lib6/in6_02.c
+++ b/testcases/network/lib6/in6_02.c
@@ -7,8 +7,6 @@
  */
 
 /*\
- * [Description]
- *
  * IPv6 name to index and index to name function tests.
  */
 
diff --git a/testcases/network/nfs/nfslock01/nfs_flock.c b/testcases/network/nfs/nfslock01/nfs_flock.c
index 02f105b22c..dbe5ffe31e 100644
--- a/testcases/network/nfs/nfslock01/nfs_flock.c
+++ b/testcases/network/nfs/nfslock01/nfs_flock.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Program for testing file locking. The original data file consists of
  * characters from 'A' to 'Z'. The data file after running this program
  * would consist of lines with 1's in even lines and 0's in odd lines.
diff --git a/testcases/network/nfs/nfslock01/nfs_flock_dgen.c b/testcases/network/nfs/nfslock01/nfs_flock_dgen.c
index 6ecdcdc4fe..d050e5e581 100644
--- a/testcases/network/nfs/nfslock01/nfs_flock_dgen.c
+++ b/testcases/network/nfs/nfslock01/nfs_flock_dgen.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Tool to generate data for testing file locking.
  * Used in nfslock01.sh.
  */
diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
index 4674868467..6e2d6f2fff 100644
--- a/testcases/network/sctp/sctp_big_chunk.c
+++ b/testcases/network/sctp/sctp_big_chunk.c
@@ -5,8 +5,6 @@
  */
 
 /*\
- * [Description]
- *
  * Regression test for the crash caused by over-sized SCTP chunk,
  * fixed by upstream commit 07f2c7ab6f8d ("sctp: verify size of a new
  * chunk in _sctp_make_chunk()").
diff --git a/testcases/network/sockets/vsock01.c b/testcases/network/sockets/vsock01.c
index 7eecebdfcb..416bd65d0e 100644
--- a/testcases/network/sockets/vsock01.c
+++ b/testcases/network/sockets/vsock01.c
@@ -4,8 +4,6 @@
  */
 
 /*\
- * [Description]
- *
  * Reproducer of CVE-2021-26708
  *
  * Based on POC https://github.com/jordan9001/vsock_poc.
diff --git a/testcases/realtime/func/matrix_mult/matrix_mult.c b/testcases/realtime/func/matrix_mult/matrix_mult.c
index e028952be8..dfee3827a0 100644
--- a/testcases/realtime/func/matrix_mult/matrix_mult.c
+++ b/testcases/realtime/func/matrix_mult/matrix_mult.c
@@ -6,8 +6,6 @@
  *          Dinakar Guniguntala <dino@in.ibm.com>
  */
 /*\
- * [Description]
- *
  * Compare running sequential matrix multiplication routines
  * to running them in parallel to judge multiprocessor
  * performance
diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 5ffc1ff461..b89970542a 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -6,8 +6,6 @@
  */
 
 /*\
- * [Description]
- *
  * Scheduler test that uses a football analogy.
  *
  * The premise is that we want to make sure that lower priority threads
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
