Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390CBCD4F54
	for <ltp@archiver.kernel.org>; Fri, 29 May 2026 13:52:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7AB33E2034
	for <ltp@archiver.kernel.org>; Fri, 29 May 2026 15:52:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE0333E2034
 for <ltp@lists.linux.it>; Fri, 29 May 2026 15:52:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7CA741000D40
 for <ltp@lists.linux.it>; Fri, 29 May 2026 15:52:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D6F6466D82;
 Fri, 29 May 2026 13:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780062722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XEg75lcxLC0IFCoXG9tEFBfZo2i+gFP8eRf6j2A1efM=;
 b=PKi5peKTod5QlndkISHh7qiVI+Q83ntDhFC3P6WVhW+HRBPWDPEPpTlg0ON1gkeWJXaFc7
 koEwt0iQn32Xtzm1Av3/ku+Dil9mPiTaYJ4nxizKb8pZrzjr9J6/Vcb8LJK4zw6KV+nWuS
 ab/BI0zSGtNHa9iFUG1PryS1dHR3IIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780062722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XEg75lcxLC0IFCoXG9tEFBfZo2i+gFP8eRf6j2A1efM=;
 b=thk1ElDQP4NCC5fRNWKkIZG/tRUVJ7ukbz7rhIrq4CEoT14Di9u7kgKzc9TSnpfPe2baVD
 H2oZt9kowOP7JBBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sAaCRLe9;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4WMcj7g3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780062721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XEg75lcxLC0IFCoXG9tEFBfZo2i+gFP8eRf6j2A1efM=;
 b=sAaCRLe9EnGAVAkAOcGQYfPyRsqEnLtdSkQOBTvKhRcmmLVwVge3pMUutEOM0zweNPVLPm
 XeYYdxdExjjdIJkHUMraFiEYcvjkQbUuDzJpnVwz6Fn/PQZdMzZyP5lLKo+sEjhWdD8I+A
 M5cunNeFmuqBtU+B8kqmBVPnmpNO4kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780062721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XEg75lcxLC0IFCoXG9tEFBfZo2i+gFP8eRf6j2A1efM=;
 b=4WMcj7g3eTU1W3B/Kl5wPGfVNsjwHpKzi91U++ytxqCpTrna/KfhkgaTDcU6m0Ahf0vMmp
 hAl5vxLVe4vDjEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5F18779A7;
 Fri, 29 May 2026 13:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mvgeLwGaGWrCXAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 29 May 2026 13:52:01 +0000
Date: Fri, 29 May 2026 15:51:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it, linux-kernel@vger.kernel.org,
 libc-alpha@sourceware.org, valgrind-developers@lists.sourceforge.net
Message-ID: <ahmZ_HcEEuyPzPFq@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D6F6466D82
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for May
 2026
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
Cc: lwn@lwn.net, akpm@linux-foundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Good news everyone,

the Linux Test Project test suite stable release for *May 2026* has been
released.

Since the last release 253 patches by 27 authors were merged.

Patch review is what most of the projects struggle with and LTP is no
different. If you can spare some effort helping with the patch review is mo=
re
than welcomed.

NOTABLE CHANGES
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* RUNLTP AND LTP-PAN WERE FINALLY REMOVED

  The modern replacement kirk is now production ready for several releases
  hence we finally decided to remove the decade old hacky scripts to run the
  tests.

  See: https://kirk.readthedocs.io/en/latest/

* New CVE tests
  - xfrm03: skb_segment SKBFL_SHARED_FRAG stripping test (CVE-2026-46300)
  - xfrm02: ESP-in-TCP page cache corruption test (CVE-2026-46300)
  - xfrm01: xfrm ESP page cache corruption test (CVE-2026-43284)
  - af_alg08: page cache corruption through the AEAD scratch-write (CVE-202=
6-31431)

  There are a couple more high profile CVE reproducers in the pipeline and =
we
  expect much more to be added in next month(s).

  We also have a new autogenerated page with list of all LTP CVE reproducer=
s:

  https://linux-test-project.readthedocs.io/en/latest/users/cve_catalog.html

* New tests
  - close02: Test for double close EBADF
  - ioctl_getlbmd01: Test for ioctl() FS_IOC_GETLBMD_CAP on block devices.
  - mremap07: Test for mremap() with MREMAP_DONTUNMAP
  - io_uring03: Tests for IORING_OP_READ and IORING_OP_WRITE.
  - io_submit04: Test case for RWF_NOWAIT flag
  - userfaultfd06: Test case for UFFDIO_POISON
  - fanotify25: Tests that fanotify works on tracing filesystem
  - poll04: Test for POLLNVAL on invalid fd
  - poll03: Test for POLLHUP
  - chdir02: Tests that valid buffer lengts up to PATH_MAX are accepted cor=
rectly

* Increased coverage
  - mount_setattr01: Tests open_tree_attr() syscall as well.

* Rewritten and updated tests
  - aio_cancel_{2-1, 3-1, 4-1, 6-1}: Were fixed to properly block in the mi=
ddle
                                     of the write operations.
  - ima_violations.sh: Was fixed to use proper synchronization with a child=
 process.
  - ima_kexec.sh: Was fixed to work with UEFI systemd-boot
  - stream{01,02,03,04,05} Were cleaned up and rewritten to new test API.
  - sysinfo01: Was rewritten as a proper test.
  - madvise09: Was rewritten to support cgroup V2 as well.
  - readahead02: Now waits for the cache to fill in order not to fail on sl=
ow
                 I/O devices.

* Removed tests
  - runpwtest{01,02,05} and runpwtests_exclusive*

    Which were testing removed sched_mc_power_savings and
    sched_smt_power_savings sysfs knobs.

  - vmcp_m.sh A s390x userspace tool test which was moved to s390-tools pac=
kage

* The checks for CONFIG variables can now have associated runtime checks

  E.g. CONFIG_USER_NS also checks for /proc/self/ns/user presense or CONFIG=
_KVM
  checks for presence of kvm.ko module if it's set to 'm'. This simplifies =
the
  amount of checks tests needs to do in a test setup().

* The test library was changed to treat fuse NTFS and in-kernel NTFS as
  different filesystems. Which means that tests that iterate over all avail=
able
  filesystems will test both implementations now.

* OpenPOSIX wall clock tests now detect jumps in time (due to NTP or VM ste=
al
  time) and retry the test if detected.

* The timeouts for checkpoints are now scaled with the tst_multiply_timeout=
()

* The ltp-aiodio runtest file cleanups and speedups

  The dio_sparse tests were removed from ltp-aiodio.part4 since these tests=
 are
  executed in ltp-aiodio.part2 already and there is no need to run them twi=
ce.

  The file sizes in the runtest files were adjusted so that the tests finish
  faster without sacrificing too much coverage.

- 13 test were rewritten to the new test library API

+ The usual amount of fixes and cleanups

NOTABLE CHANGES IN NETWORK TESTS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
brought to you by Petr Vorel

* Removed tests
  - route[46]-rmmod outdated route rmmod tests
  - udp_ipsec{_vti,}.sh outdated UDP stress tests
  - icmp-uni-{basic,vti}.sh utdated ICMP stress tests
  - tcp_ipsec{_vti,}.sh outdated TCP stress tests

* wireguard tests were fixed to properly work on RO /

* NFS tests were fixed to work properly on two host setup


DOWNLOAD AND LINKS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20260529

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp

If you ever wondered how to write a LTP testcase, don't miss our developer
documentation at:

https://linux-test-project.readthedocs.io/en/latest/developers/test_case_tu=
torial.html

And our library API documentation at:

https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.=
html

Patches, new tests, bugs, comments or questions should go to to our mailing
list at ltp@lists.linux.it.


CREDITS
=3D=3D=3D=3D=3D=3D=3D

Many thanks to the people contributing to this release:

git shortlog -s -e -n 20260130..

    73  Petr Vorel <pvorel@suse.cz>
    42  Andrea Cervesato <andrea.cervesato@suse.com>
    39  Cyril Hrubis <chrubis@suse.cz>
    18  Martin Doucha <mdoucha@suse.cz>
    13  Li Wang <li.wang@linux.dev>
    12  Jinseok Kim <always.starving0@gmail.com>
    12  Wei Gao <wegao@suse.com>
     5  Ricardo Branco <rbranco@suse.de>
     4  Guixiong Wei via ltp <ltp@lists.linux.it>
     4  Jan Polensky <japo@linux.ibm.com>
     4  Sachin Sant <sachinp@linux.ibm.com>
     3  Avinesh Kumar <avinesh.kumar@suse.com>
     3  Stephen Bertram via ltp <ltp@lists.linux.it>
     3  Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
     2  Changwei Zou <changwei.zou@canonical.com>
     2  Martin Cermak <mcermak@redhat.com>
     2  Samir <samir@linux.ibm.com>
     2  Wake Liu via ltp <ltp@lists.linux.it>
     2  Xiang Gao <gaoxiang@kylinos.cn>
     1  Chris Wailes <chriswailes@google.com>
     1  Darren Chang <chihsheng@google.com>
     1  Disha Goel <disgoel@linux.ibm.com>
     1  Fushuai Wang <wangfushuai@baidu.com>
     1  Jeff Mahoney <jeffm@suse.com>
     1  Sayali Patil <sayalip@linux.ibm.com>
     1  Sebastian Chlad <sebastianchlad@gmail.com>
     1  Soma Das <somadas1@linux.ibm.com>

And also thanks to patch reviewers:

git log 20260130.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | s=
ort | uniq -c | sort -n -r

    109 Andrea Cervesato <andrea.cervesato@suse.com>
     85 Cyril Hrubis <chrubis@suse.cz>
     80 Petr Vorel <pvorel@suse.cz>
     19 LTP AI Reviewer <ltp-ai@noreply.github.com>
     18 Li Wang <liwang@redhat.com>
     13 Li Wang <li.wang@linux.dev>
     10 Martin Doucha <mdoucha@suse.cz>
      8 Ricardo B. Marli=E8re <rbm@suse.com>
      5 Li Wang <wangli.ahau@gmail.com>
      5 Jan Stancek <jstancek@redhat.com>
      5 Jan Kara <jack@suse.cz>
      3 Avinesh Kumar <avinesh.kumar@suse.com>
      2 Enji Cooper <yaneurabeya@gmail.com>
      2 Anders Roxell <anders.roxell@linaro.org>
      1 Sachin Sant <sachinp@linux.ibm.com>
      1 Amir Goldstein <amir73il@gmail.com>

And everyone else suggesting or co-developing:

git log 20260130.. | grep -Ei '(suggested|co-developed)-by:' | sed 's/.*by:=
 //' | sort | uniq -c | sort -n -r
 =

      5 Cyril Hrubis <chrubis@suse.cz>
      1 Petr Vorel <pvorel@suse.cz>
      1 Jan Kara <jack@suse.cz>
      1 Eric Dumazet <edumazet@google.com>
      1 Claude <noreply@anthropic.com>
      1 Andrea Cervesato <andrea.cervesato@suse.com>
      1 Al Viro <viro@zeniv.linux.org.uk>
-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
