Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C7CCCA470
	for <ltp@archiver.kernel.org>; Tue, 30 Sep 2025 12:18:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E7CA3CE2B8
	for <ltp@archiver.kernel.org>; Tue, 30 Sep 2025 14:18:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D96DC3C1988
 for <ltp@lists.linux.it>; Tue, 30 Sep 2025 14:17:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A55A610007BB
 for <ltp@lists.linux.it>; Tue, 30 Sep 2025 14:17:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2DFD13369D;
 Tue, 30 Sep 2025 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759234669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hnu9DszaUUeumBnlKOb72Y0PnOvWBWZEXkZPHXDg0TA=;
 b=zLEyNct98ejr4FEfNY7a8x5xmjldWQLo/IqxWE9br1v2crSC8TP0qM1dVRJYSwSFuNQxnz
 keY0UrB+Gebx3oAbVWnetAWES7I4WTU4okqMmaS3C/AKfTGqPq5DMcQqfSwf3zY9lAu8AU
 4JMbdtPj3fnzgkbCYk9FVALJJl+ry/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759234669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hnu9DszaUUeumBnlKOb72Y0PnOvWBWZEXkZPHXDg0TA=;
 b=19/YfcK9cc6pjWQc8DkDiRrR48WXj3Hcu+bEsmcuwIOL20rcCyafCMyHMTYkvVYSzJXVAF
 W7/58pMnFV07G3CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zLEyNct9;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="19/YfcK9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759234669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hnu9DszaUUeumBnlKOb72Y0PnOvWBWZEXkZPHXDg0TA=;
 b=zLEyNct98ejr4FEfNY7a8x5xmjldWQLo/IqxWE9br1v2crSC8TP0qM1dVRJYSwSFuNQxnz
 keY0UrB+Gebx3oAbVWnetAWES7I4WTU4okqMmaS3C/AKfTGqPq5DMcQqfSwf3zY9lAu8AU
 4JMbdtPj3fnzgkbCYk9FVALJJl+ry/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759234669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hnu9DszaUUeumBnlKOb72Y0PnOvWBWZEXkZPHXDg0TA=;
 b=19/YfcK9cc6pjWQc8DkDiRrR48WXj3Hcu+bEsmcuwIOL20rcCyafCMyHMTYkvVYSzJXVAF
 W7/58pMnFV07G3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1398A13A3F;
 Tue, 30 Sep 2025 12:17:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vtaQA23K22hhLQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 30 Sep 2025 12:17:49 +0000
Date: Tue, 30 Sep 2025 14:18:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it, linux-kernel@vger.kernel.org,
 libc-alpha@sourceware.org, valgrind-developers@lists.sourceforge.net
Message-ID: <aNvKnEwB73dxuucq@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 2DFD13369D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 SEPTEMBER 2025
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

the Linux Test Project test suite stable release for *September 2025* has b=
een
released.

Since the last release 221 patches by 25 authors were merged.

Patch review is what most of the projects struggle with and LTP is no
different. If you can spare some effort helping with the patch review is mo=
re
than welcomed.

NOTABLE CHANGES
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* New tests
  - CVE-2025-21756 regression test for fcdd2242c023 ('vsock: Keep the bindi=
ng until socket destruction')

  - CVE-2025-38236 regression test for 32ca245464e1 ('af_unix: Don't leave =
consecutive consumed OOB skbs')

  - file_attr[01-04] tests for file_getattr() and file_setattr() syscalls

  - clock_settime04 Tests that changing the CLOCK_REALTIME clock has no eff=
ect
                    on a relative/absolute clock_nanosleep()

  - statmount09 that verifies that statmount() is correctly reading the mou=
nt
                ID for the current namespace

  - listxattr04 regression test for 8b0ba61df5a1 ('fs/xattr.c: fix simple_x=
attr_list to always include security.* xattrs')

  - ioctl_pidfd[01-06] tests for PIDFD_GET_INFO ioctl() and PIDFD_INFO_EXIT=
 flag

  - mount08 regression test for d80b065bb172 ('proc: restrict overmounting =
of ephemeral entities')

  - unshare05 tests that unshare(CLONE_NEWPID) assign pid 1 to the first ch=
ild

  - ioctl10 test for PROCMAP_QUERY ioctl()

  - landlock02 test for landlock ABI v6

  - landlock09 test for unix socket landlock sandboxing

  - landlock10 test for signal sandboxing

  - epoll_pwait06 regression test for d9ec73301099 ('fs/eventpoll: fix endl=
ess busy loop after timeout has expired')

  - lsm_get_self_attr[01-03] tests for lst_get_self_attr() syscall

  - lsm_list_modules[01-02] tests for lsm_list_modules() syscall

  - lsm_set_self_attr01 test for lsm_set_self_attr() syscall

* Increased coverage

  - open13 now checks that more operations are failing with EBADF on O_PATH=
 fd
           and also verifies that dup() preserves O_PATH flag

* Rewritten and updated tests

  - open posix aio_cancel_7-1 was rewritten to trigger the tested condition=
 reliably

  - mmap22 now uses mincore() to test MAP_DROPPABLE flag

  - open posix pthread_rwlock_rdlock now use PTHREAD_RWLOCK_PREFER_WRITER_N=
ONRECURSIVE_NP
                                     on glibc to force POSIX mandated behav=
ior

  - ioctl_loop01 and ioctl09 tests now use loop device instead of the backi=
ng
                             =FAfile for partitioning

  - sched_football thread synchronization at the start was rewritten to mak=
e sure
                   threads are started in the right order

* Removed tests

  - eject command test

  - kdump testsuite which was unmaintained for nearly two decades

* General smaller improvements

 - LTP kernel modules can now be build separately with 'make modules'

 - The new shell test library now support setup() and cleanup() functions

 - The concept of min_runtime was added to the test library, now tests that=
 run
   for longer time can define min_runtime in order to make sure that the te=
st
   actually runs for a reasonable runtime when test runtime is scaled down.

   For details see:
   81ba405dfbd9 ('tst_test: Add min_runtime to control lower bound of scale=
d runtime')

 - Test library now properly translates MS_RDONLY flag for FUSE based mounts

 - The test metadata parser now correctly handles designed initializers

   Details in:
   375286fb9361 ('metaparse: Map arrays with designated initializers to JSO=
N objects')

 - New LTP_QUIET environment variable was introduced, if set TINFO, TDEBUG =
and
   TCONF messages are suppresed. This can be combined with the previously
   introduced LTP_REPRODUCIBLE_OUTPUT to create shorter logs that are easie=
r to
   compare between runs.

* Kirk and ltx has been fixed and now works well together

  This marks a milestone in new LTP test runner development as we are neari=
ng
  the vision we had for years. The ltx, which is minimalistic daemon that
  communicates over byte oriented connection, can be started on the system
  under test and kirk can connect to ltx from a machine that drives the tes=
ting
  and run tests in parallel using ltx.

  The documentation is sparse at the moment and kirk qemu SUT does not start
  ltx automatically. However if you want to feel adventurous and try ltx in=
 a
  qemu virtual machine with communication over virtio with these steps:

  Manually start qemu virtual machine on a host:

  mkfifo ltx-io.in
  mkfifo ltx-io.out
  qemu- ... -chardev pipe,id=3Dltx-io,path=3Dltx-io -device virtserialport,=
chardev=3Dltx-io,name=3Dltx-io

  Start ltx inside of the guest:

  /opt/ltp/ltx -s /dev/virtio-ports/ltx-io

  And on a host use kirk to talk to ltx via the virtio serial:

  ./kirk --run-suite syscalls --sut ltx:infile=3Dltx-io.in:outfile=3Dltx-io=
.out

  Parallel run can be started by passing number of workers (-w N) to kirk.

  Similarily you can run ltx and kirk over real serial null modem between t=
wo
  machines.

  Next step that is already in queue is separation of communication channel=
 and
  SUT definition in kirk. That will allow us to select different ways how k=
irk
  connects to SUT e.g. qemu while the SUT module will handle the power e.g.
  reboot. Hopefully that will happen in the next release and we will be
  finally removing the old and deprecated runltp next year.

* Testers guide to the Linux Test Project was added into documentation:
  https://linux-test-project.readthedocs.io/en/latest/users/testers_guide.h=
tml

* Documentation was written for test macros:
  https://linux-test-project.readthedocs.io/en/latest/developers/api_c_test=
s.html#test-macros

* 52 testcases were converted to the new test library

+ The usual amount of fixes and cleanups


DOWNLOAD AND LINKS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20250930

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

git shortlog -s -e -n 20250530..

    50  Andrea Cervesato <andrea.cervesato@suse.com>
    50  Petr Vorel <pvorel@suse.cz>
    33  Ricardo B. Marli=E8re <rbm@suse.com>
    16  Cyril Hrubis <chrubis@suse.cz>
    15  Li Wang <liwang@redhat.com>
    14  Martin Doucha <mdoucha@suse.cz>
    13  Wei Gao <wegao@suse.com>
     5  Avinesh Kumar <akumar@suse.de>
     4  Tiezhu Yang <yangtiezhu@loongson.cn>
     3  Florian Schmaus <florian.schmaus@codasip.com>
     2  Amir Goldstein <amir73il@gmail.com>
     2  Jack Morgan <jmorgan@naotchy.com>
     2  Martin Cermak <mcermak@redhat.com>
     1  Ben Copeland <ben.copeland@linaro.org>
     1  Charles Shi <schrht@gmail.com>
     1  Jan Kara <jack@suse.cz>
     1  Jan Polensky <japo@linux.ibm.com>
     1  Jan Stancek <jstancek@redhat.com>
     1  Liheng Chen <791960492@qq.com>
     1  Mark Wielaard <mark@klomp.org>
     1  Mike Tipton via ltp <ltp@lists.linux.it>
     1  Tengda Wu <stavewu@gmail.com>
     1  Xiao Yang <iceyangxiao@gmail.com>
     1  lufei <lufei@uniontech.com>
     1  yang.zhang <zhangyang01@kylinos.cn>


And also thanks to patch reviewers:

git log 20250530.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | s=
ort | uniq -c | sort -n -r

    97 Cyril Hrubis <chrubis@suse.cz>
    54 Petr Vorel <pvorel@suse.cz>
    48 Li Wang <liwang@redhat.com>
    38 Andrea Cervesato <andrea.cervesato@suse.com>
    11 Avinesh Kumar <akumar@suse.de>
    10 Wei Gao <wegao@suse.com>
     4 Ricardo B. Marli=E8re <rbm@suse.com>
     3 Jan Stancek <jstancek@redhat.com>
     2 Mimi Zohar <zohar@linux.ibm.com>
     1 Pedro Falcato <pfalcato@suse.de>
     1 Martin Doucha <mdoucha@suse.cz>
     1 Jan Kara <jack@suse.cz>

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
