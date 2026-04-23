Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA45F589DE
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776955513; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=iuE7JIzHMfbr5VsTQ0YY7DBEoJEOXx9JyH2LZmcZlU0=;
 b=mIRu3dXFO4wa0EYicebuUNCgRNk3VaExP8gpXX3A8EavlOy/U/QgiS0+1ya/0TTlpMuMn
 5YU0va3EBBMFRCFiSxTwQLK/vZEgVLWHtcyGdc5mTEu8vCB83WluTZwWy3ZQvAy3VURcib/
 tBkdhxSGBGo2ZzaFDcm9ZclR4tQlOeg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F02BF3E2943
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 16:45:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E81AD3E225F
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 16:44:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 914C21000405
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 16:44:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776955485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Xv5QcYmASdk9eSAS7VczWZLXT7gJO2vY5qPqISIa5o=;
 b=VSAK+d3xxwgCIczE6tUXjBwkwS1ybyR51+hAAKygQL1v3Mp1bsqZhOit+BzOvf8TsJmU/+
 vcWdiFPSBqC09Pc+Sk5Yddr3cIOwy4XQ3opk9BtoGvIDsuTTBknozqWgRQQBLABhCAAnbV
 HRxnYPOJ9gpZUUpsJXOsk7HMQSCNJyc=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-IJQ2iFPfMuGax4s-oTNnRQ-1; Thu, 23 Apr 2026 10:44:43 -0400
X-MC-Unique: IJQ2iFPfMuGax4s-oTNnRQ-1
X-Mimecast-MFC-AGG-ID: IJQ2iFPfMuGax4s-oTNnRQ_1776955482
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12c20d5d7f4so30672767c88.1
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 07:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776955482; x=1777560282;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Xv5QcYmASdk9eSAS7VczWZLXT7gJO2vY5qPqISIa5o=;
 b=V7coR3TgWmqRMJYXVTH24JKuXAkx5WuJ1tJUuy/dEYohWGPM9wVyRKzGHWCa4l9h3e
 adrSz6EPW+z31T48RGRVwVVwQH0Mzvuw9/UX2UcK7MQuipERxjybxLB2fF3RG6Vn30+K
 IUemjJVybQ85X3zTkMy/do2Cgz7xEmTFY3j/XXFAX+oDdpaZNXWVemVaFDQMjlSMJzzD
 DompgqC9l/W4MGtLZet94PqFUtg5GLJvYK9M5chUjTFB6JeSTwPAYoZp841Y6jW0o+cf
 uuSOXJ0cu/L+7FbBX2dNZcJKYUvHxVFd78/o0JQE91QWnBQ8vL79vpB8pDOHPrpyAaoO
 iBKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RSD6glsiwICxU1a7YKm/Pze192W+af7/2ppdjUXBj6flbCv4TLfY2R+1qwAhR0vgedVk=@lists.linux.it
X-Gm-Message-State: AOJu0YwinmCVqMm++1pOaNAmk1jH9S3vRX2pGjHUU0Y6L44ktuPN9h1G
 szyNux1C+riG6BefYGOqqYqImW1wFY9xoS5BTMbQLW9Ww+oZ3LalHoGlPBnn1bup32acFs36Arm
 Sh/BHGMex7jZ2TABLg7Xn9zniQdDjX0DZc3dOBcAHmHzarFkZ1rmF
X-Gm-Gg: AeBDieu5pbXrRfDTizNHtiIrH8DUTkIPGa3nFsqgHa+DyP2IuIIUm7Qn9L37cUzhdoE
 vJ7uLCZ3qJZ+Jn6YSasiL9y2Fzcjd5R4apKOQUqzZUDO+RYKL+NEuf11ePph9DXo3hm7RV4/jzt
 FnJdVf1IEB4xLk+mjm9SD+iDsutPJPGcxFISVyFZFXrpBzFG9LrQkGTcJkkVyeMnqXvxq1ln0bJ
 L8dAIgC/iusrE0CZ52v07jn1Odf1CNfTLGjyw+ZdY2tyXwL83nOkS6Iy4atR8lwd15n/GOGIApt
 QEFpcq9+mmKDW85ktKReVkMknYpImXq4USUzDCXjEI9XkiCQANuRRq9gDl5MHVBB7tpXlTzC958
 y98Y6IJBi2+NFnqmLhPXBvFSzs88aQkDu6OueSsbVAgrY
X-Received: by 2002:a05:7022:eac8:b0:128:d714:3ca6 with SMTP id
 a92af1059eb24-12c73f7167cmr16487460c88.12.1776955481734; 
 Thu, 23 Apr 2026 07:44:41 -0700 (PDT)
X-Received: by 2002:a05:7022:eac8:b0:128:d714:3ca6 with SMTP id
 a92af1059eb24-12c73f7167cmr16487447c88.12.1776955480768; 
 Thu, 23 Apr 2026 07:44:40 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c74a20b9csm28505777c88.12.2026.04.23.07.44.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Apr 2026 07:44:40 -0700 (PDT)
Date: Thu, 23 Apr 2026 16:44:31 +0200
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20260423144431.ozcixhmhki3aeigw@lida.tpb.lab.eng.brq.redhat.com>
References: <20260421152349.1673057-1-mcermak@redhat.com>
 <20260422053712.GB392764@pevik>
 <319d3965-30f0-49c5-b747-ad16334391e2@suse.de>
 <20260422121742.GA419002@pevik>
 <20260422130837.cdkcwxtbhkumx3eo@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20260422130837.cdkcwxtbhkumx3eo@lida.tpb.lab.eng.brq.redhat.com>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2p79-5Gm-5ABNEQE58y_Ydvgt_EtDNOkrhg-6eW7oA0_1776955482
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] [PATCH] Make userfaultfd0{1, 3,
 4} LTP tests valgrind compatible
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On  Wed  2026-04-22  15:08 , Martin Cermak wrote:
> On  Wed  2026-04-22  14:17 , Petr Vorel wrote:
> > =

> > =

> > > On 4/22/26 7:37 AM, Petr Vorel wrote:
> > > > > However, some of the testcases can be easily changed to use forked
> > > > > processes instead of threads.  That's what this patch does.  When
> > > > > client program forks, Valgrind forks too, and that allows for the=
 needed
> > > > > parallelism to handle the page fault.
> > > > You understand process vs. threads more than me. But shouldn't mmap=
() use
> > > > MAP_SHARED instead of MAP_PRIVATE for those which aren't using /dev=
/userfaultfd?
> > =

> > > The documentation for userfaultfd mentions threads.=A0 I'm afraid we'=
ll
> > > lose vital coverage if we move to forked processes.
> > =

> > +1, at least some tests would keep threads (not all userfaultfd tests w=
ould be
> > converted, but yes, that's why I suggested to use MAP_SHARED, which cou=
ld be
> > similar to threads (yes, the difference between processes and threads i=
n Linux
> > kernel is not that huge as both are created in clone(), it's mostly abo=
ut what
> > is shared).
> =

> My goal is to make at least part of these userfaultfd tests
> compatible with Valgrind.  I've experimented with clone() and it
> seems like Valgrind has limited support for it.  That said,
> adding another set of userfaultfd tests using fork() or clone()
> instead of threads might help.  Some of such new tests will be
> "incompatible" with valgrind, but it might be a test coverage
> improvement.

Here is an ai-assisted patch that works for me:


From 693f3015d39b39e2c263aac57c183e3e4cf7df4d Mon Sep 17 00:00:00 2001
From: Martin Cermak <mcermak@redhat.com>
Date: Thu, 23 Apr 2026 15:51:10 +0200
Subject: [PATCH] Provide Valgrind-compatible userfaultfd tests

The userfaultfd tests use threads.  Threads are executed serially
in Valgrind, but parallelism is important for userfaultfd tests.
When a page fault happens in parent thread, kernel stops it, and
waits for the handler thread to handle the page fault. That said,
userfaultfd tests 01 - 06 stall in Valgrind.

This update comes with second set of userfaultfd tests 07 - 12.
These additional tests use fork() or clone(), thus a separate
process instead of threads.  Support for clone() is also limited
in Valgrind. For that reason only tests 07, 09 and 10 are "Valgrind
compatible".  But it's a test coverage improvement.

Valgrind can filter LTP tests on the per test binary basis.  That's
why this update adds separate tests 07 - 12.

Assisted-by: Anthropic Claude
Reviewed-by: Martin Cermak <mcermak@redhat.com>
---
 include/lapi/sched.h                          |   8 +
 .../kernel/syscalls/userfaultfd/.gitignore    |   6 +
 .../kernel/syscalls/userfaultfd/Makefile      |   3 +
 .../syscalls/userfaultfd/userfaultfd07.c      | 136 +++++++++++++++
 .../syscalls/userfaultfd/userfaultfd08.c      | 113 +++++++++++++
 .../syscalls/userfaultfd/userfaultfd09.c      | 141 ++++++++++++++++
 .../syscalls/userfaultfd/userfaultfd10.c      | 106 ++++++++++++
 .../syscalls/userfaultfd/userfaultfd11.c      | 140 ++++++++++++++++
 .../syscalls/userfaultfd/userfaultfd12.c      | 157 ++++++++++++++++++
 9 files changed, 810 insertions(+)
 create mode 100644 testcases/kernel/syscalls/userfaultfd/userfaultfd07.c
 create mode 100644 testcases/kernel/syscalls/userfaultfd/userfaultfd08.c
 create mode 100644 testcases/kernel/syscalls/userfaultfd/userfaultfd09.c
 create mode 100644 testcases/kernel/syscalls/userfaultfd/userfaultfd10.c
 create mode 100644 testcases/kernel/syscalls/userfaultfd/userfaultfd11.c
 create mode 100644 testcases/kernel/syscalls/userfaultfd/userfaultfd12.c

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 05b322c1c..b33de6657 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -121,6 +121,14 @@ static inline int getcpu(unsigned *cpu, unsigned *node)
 # define CLONE_FS	0x00000200
 #endif
 =

+#ifndef CLONE_FILES
+# define CLONE_FILES	0x00000400
+#endif
+
+#ifndef CLONE_SIGHAND
+# define CLONE_SIGHAND	0x00000800
+#endif
+
 #ifndef CLONE_PIDFD
 # define CLONE_PIDFD	0x00001000
 #endif
diff --git a/testcases/kernel/syscalls/userfaultfd/.gitignore b/testcases/k=
ernel/syscalls/userfaultfd/.gitignore
index bc32fdf3b..59d28c6f3 100644
--- a/testcases/kernel/syscalls/userfaultfd/.gitignore
+++ b/testcases/kernel/syscalls/userfaultfd/.gitignore
@@ -4,3 +4,9 @@
 /userfaultfd04
 /userfaultfd05
 /userfaultfd06
+/userfaultfd07
+/userfaultfd08
+/userfaultfd09
+/userfaultfd10
+/userfaultfd11
+/userfaultfd12
diff --git a/testcases/kernel/syscalls/userfaultfd/Makefile b/testcases/ker=
nel/syscalls/userfaultfd/Makefile
index 3252e47df..e4ed56b4b 100644
--- a/testcases/kernel/syscalls/userfaultfd/Makefile
+++ b/testcases/kernel/syscalls/userfaultfd/Makefile
@@ -17,3 +17,6 @@ userfaultfd03: CFLAGS +=3D -pthread
 userfaultfd04: CFLAGS +=3D -pthread
 userfaultfd05: CFLAGS +=3D -pthread
 userfaultfd06: CFLAGS +=3D -pthread
+# Tests 07-12: Valgrind-compatible variants using fork/clone
+# Tests 07, 09, 10: fork-based (no pthread needed)
+# Tests 08, 11, 12: clone-based (no pthread needed)
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c b/testca=
ses/kernel/syscalls/userfaultfd/userfaultfd07.c
new file mode 100644
index 000000000..bebf0e921
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different process (using fork instead of threads for Valgrind co=
mpatibility).
+ */
+
+#include <poll.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/userfaultfd.h"
+
+#define BEFORE_5_11 1
+#define AFTER_5_11 2
+#define DESC(x) .flags =3D x, .desc =3D #x
+
+static struct tcase {
+	int flags;
+	const char *desc;
+	int kver;
+} tcases[] =3D {
+	{ DESC(O_CLOEXEC | O_NONBLOCK) },
+	{ DESC(O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY),  .kver =3D AFTER_5_=
11, },
+};
+
+static int page_size;
+static char *page;
+static void *copy_page;
+static int uffd;
+static int kver;
+
+static void setup(void)
+{
+	if (tst_kvercmp(5, 11, 0) >=3D 0)
+		kver =3D AFTER_5_11;
+	else
+		kver =3D BEFORE_5_11;
+}
+
+static void set_pages(void)
+{
+	page_size =3D sysconf(_SC_PAGE_SIZE);
+	page =3D SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	copy_page =3D SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+}
+
+static void reset_pages(void)
+{
+	SAFE_MUNMAP(page, page_size);
+	SAFE_MUNMAP(copy_page, page_size);
+}
+
+static void *pagefault_handler(void)
+{
+	static struct uffd_msg msg;
+	struct uffdio_copy uffdio_copy =3D {};
+
+	struct pollfd pollfd;
+	int nready;
+
+	pollfd.fd =3D uffd;
+	pollfd.events =3D POLLIN;
+	nready =3D poll(&pollfd, 1, -1);
+	if (nready =3D=3D -1)
+		tst_brk(TBROK | TERRNO, "Error on poll");
+
+	SAFE_READ(1, uffd, &msg, sizeof(msg));
+
+	if (msg.event !=3D UFFD_EVENT_PAGEFAULT)
+		tst_brk(TBROK | TERRNO, "Received unexpected UFFD_EVENT %d", msg.event);
+
+	memset(copy_page, 'X', page_size);
+
+	uffdio_copy.src =3D (unsigned long) copy_page;
+
+	uffdio_copy.dst =3D (unsigned long) msg.arg.pagefault.address
+			& ~(page_size - 1);
+	uffdio_copy.len =3D page_size;
+	SAFE_IOCTL(uffd, UFFDIO_COPY, &uffdio_copy);
+
+	close(uffd);
+	return NULL;
+}
+
+static void run(unsigned int i)
+{
+	pid_t pid;
+	struct uffdio_api uffdio_api =3D {};
+	struct uffdio_register uffdio_register;
+	struct tcase *tc =3D &tcases[i];
+
+	if (tc->kver =3D=3D AFTER_5_11 && kver =3D=3D BEFORE_5_11)
+		tst_brk(TCONF, "%s requires kernel >=3D 5.11", tc->desc);
+
+	set_pages();
+
+	uffd =3D SAFE_USERFAULTFD(tc->flags, false);
+
+	uffdio_api.api =3D UFFD_API;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	uffdio_register.range.start =3D (unsigned long) page;
+	uffdio_register.range.len =3D page_size;
+	uffdio_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	pid =3D SAFE_FORK();
+	if (pid =3D=3D 0) {
+		pagefault_handler();
+		_exit(0);
+	}
+
+	char c =3D page[0xf];
+
+	if (c =3D=3D 'X')
+		tst_res(TPASS, "Pagefault handled!");
+	else
+		tst_res(TFAIL, "Pagefault not handled!");
+
+	SAFE_WAITPID(pid, NULL, 0);
+	reset_pages();
+}
+
+static struct tst_test test =3D {
+	.setup =3D setup,
+	.test =3D run,
+	.tcnt =3D ARRAY_SIZE(tcases),
+	.forks_child =3D 1,
+};
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd08.c b/testca=
ses/kernel/syscalls/userfaultfd/userfaultfd08.c
new file mode 100644
index 000000000..f6bde86cc
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd08.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ * Author: Ricardo Branco <rbranco@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different process (using clone with CLONE_VM instead of threads
+ * for Valgrind compatibility) using UFFDIO_MOVE.
+ */
+
+#include "config.h"
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_clone.h"
+#include "lapi/sched.h"
+#include "lapi/userfaultfd.h"
+
+#define CHILD_STACK_SIZE (1024 * 1024)
+
+static int page_size;
+static char *page;
+static void *move_page;
+static int uffd;
+static void *child_stack;
+
+static void set_pages(void)
+{
+	page_size =3D sysconf(_SC_PAGE_SIZE);
+	page =3D SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	move_page =3D SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+}
+
+static void reset_pages(void)
+{
+	SAFE_MUNMAP(page, page_size);
+	/*
+	 * After UFFDIO_MOVE, move_page is invalid and should not be unmapped.
+	 * The kernel has already removed the mapping during the move operation.
+	 */
+}
+
+static int pagefault_handler(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	struct uffd_msg msg;
+	struct uffdio_move uffdio_move =3D {};
+
+	SAFE_READ(1, uffd, &msg, sizeof(msg));
+
+	if (msg.event !=3D UFFD_EVENT_PAGEFAULT)
+		tst_brk(TBROK | TERRNO, "Received unexpected UFFD_EVENT %d", msg.event);
+
+	memset(move_page, 'X', page_size);
+
+	uffdio_move.src =3D (unsigned long) move_page;
+
+	uffdio_move.dst =3D (unsigned long) msg.arg.pagefault.address
+			& ~(page_size - 1);
+	uffdio_move.len =3D page_size;
+	SAFE_IOCTL(uffd, UFFDIO_MOVE, &uffdio_move);
+
+	close(uffd);
+	return 0;
+}
+
+static void run(void)
+{
+	pid_t pid;
+	struct uffdio_api uffdio_api =3D {};
+	struct uffdio_register uffdio_register;
+
+	set_pages();
+
+	uffd =3D SAFE_USERFAULTFD(O_CLOEXEC, false);
+
+	uffdio_api.api =3D UFFD_API;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	uffdio_register.range.start =3D (unsigned long) page;
+	uffdio_register.range.len =3D page_size;
+	uffdio_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	pid =3D ltp_clone(CLONE_VM | CLONE_FILES | CLONE_FS | CLONE_SIGHAND | SIG=
CHLD,
+			pagefault_handler, NULL, CHILD_STACK_SIZE, child_stack);
+	if (pid =3D=3D -1)
+		tst_brk(TBROK | TERRNO, "ltp_clone failed");
+
+	char c =3D page[0xf];
+
+	if (c =3D=3D 'X')
+		tst_res(TPASS, "Pagefault handled via UFFDIO_MOVE");
+	else
+		tst_res(TFAIL, "Pagefault not handled via UFFDIO_MOVE");
+
+	SAFE_WAITPID(pid, NULL, 0);
+	reset_pages();
+}
+
+static struct tst_test test =3D {
+	.test_all =3D run,
+	.min_kver =3D "6.8",
+	.forks_child =3D 1,
+	.bufs =3D (struct tst_buffers []) {
+		{&child_stack, .size =3D CHILD_STACK_SIZE},
+		{},
+	},
+};
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd09.c b/testca=
ses/kernel/syscalls/userfaultfd/userfaultfd09.c
new file mode 100644
index 000000000..e1190a4ce
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd09.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ * Author: Ricardo Branco <rbranco@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different process (using fork instead of threads for Valgrind co=
mpatibility)
+ * using /dev/userfaultfd instead of syscall, using USERFAULTFD_IOC_NEW io=
ctl to create
+ * the uffd & UFFDIO_COPY.
+ */
+
+#include "config.h"
+#include <poll.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/userfaultfd.h"
+
+static int page_size;
+static char *page;
+static void *copy_page;
+static int uffd;
+
+static void setup(void)
+{
+	if (access("/dev/userfaultfd", F_OK) !=3D 0) {
+		int res =3D (tst_kvercmp(6, 1, 0) < 0) ? TCONF : TBROK;
+
+		tst_brk(res, "/dev/userfaultfd not found");
+	}
+}
+
+static int open_userfaultfd(int flags)
+{
+	int fd, fd2;
+
+	fd =3D SAFE_OPEN("/dev/userfaultfd", O_RDWR);
+
+	fd2 =3D SAFE_IOCTL(fd, USERFAULTFD_IOC_NEW, flags);
+
+	SAFE_CLOSE(fd);
+
+	return fd2;
+}
+
+static void set_pages(void)
+{
+	page_size =3D sysconf(_SC_PAGE_SIZE);
+	page =3D SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	copy_page =3D SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+}
+
+static void reset_pages(void)
+{
+	SAFE_MUNMAP(page, page_size);
+	SAFE_MUNMAP(copy_page, page_size);
+}
+
+static void *pagefault_handler(void)
+{
+	static struct uffd_msg msg;
+	struct uffdio_copy uffdio_copy =3D {};
+
+	struct pollfd pollfd;
+	int nready;
+
+	pollfd.fd =3D uffd;
+	pollfd.events =3D POLLIN;
+	nready =3D poll(&pollfd, 1, -1);
+	if (nready =3D=3D -1)
+		tst_brk(TBROK | TERRNO, "Error on poll");
+
+	SAFE_READ(1, uffd, &msg, sizeof(msg));
+
+	if (msg.event !=3D UFFD_EVENT_PAGEFAULT)
+		tst_brk(TBROK | TERRNO, "Received unexpected UFFD_EVENT %d", msg.event);
+
+	memset(copy_page, 'X', page_size);
+
+	uffdio_copy.src =3D (unsigned long) copy_page;
+
+	uffdio_copy.dst =3D (unsigned long) msg.arg.pagefault.address
+			& ~(page_size - 1);
+	uffdio_copy.len =3D page_size;
+	SAFE_IOCTL(uffd, UFFDIO_COPY, &uffdio_copy);
+
+	close(uffd);
+	return NULL;
+}
+
+static void run(void)
+{
+	pid_t pid;
+	struct uffdio_api uffdio_api =3D {};
+	struct uffdio_register uffdio_register;
+
+	set_pages();
+
+	uffd =3D open_userfaultfd(O_CLOEXEC | O_NONBLOCK);
+
+	uffdio_api.api =3D UFFD_API;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	uffdio_register.range.start =3D (unsigned long) page;
+	uffdio_register.range.len =3D page_size;
+	uffdio_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	pid =3D SAFE_FORK();
+	if (pid =3D=3D 0) {
+		pagefault_handler();
+		_exit(0);
+	}
+
+	char c =3D page[0xf];
+
+	if (c =3D=3D 'X')
+		tst_res(TPASS, "Pagefault handled via /dev/userfaultfd");
+	else
+		tst_res(TFAIL, "Pagefault not handled via /dev/userfaultfd");
+
+	SAFE_WAITPID(pid, NULL, 0);
+	reset_pages();
+}
+
+static struct tst_test test =3D {
+	.needs_root =3D 1,
+	.setup =3D setup,
+	.test_all =3D run,
+	.needs_kconfigs =3D (const char *[]) {
+		"CONFIG_USERFAULTFD=3Dy",
+		NULL
+	},
+	.forks_child =3D 1,
+};
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd10.c b/testca=
ses/kernel/syscalls/userfaultfd/userfaultfd10.c
new file mode 100644
index 000000000..8e9bd0b0c
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd10.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ * Author: Ricardo Branco <rbranco@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different process (using fork instead of threads for Valgrind co=
mpatibility)
+ * using UFFDIO_ZEROPAGE.
+ */
+
+#include "config.h"
+#include <poll.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/userfaultfd.h"
+
+static int page_size;
+static char *page;
+static int uffd;
+
+static void set_pages(void)
+{
+	page_size =3D sysconf(_SC_PAGE_SIZE);
+	page =3D SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+}
+
+static void reset_pages(void)
+{
+	SAFE_MUNMAP(page, page_size);
+}
+
+static void *pagefault_handler(void)
+{
+	static struct uffd_msg msg;
+	struct uffdio_zeropage uffdio_zeropage =3D {};
+
+	struct pollfd pollfd;
+	int nready;
+
+	pollfd.fd =3D uffd;
+	pollfd.events =3D POLLIN;
+	nready =3D poll(&pollfd, 1, -1);
+	if (nready =3D=3D -1)
+		tst_brk(TBROK | TERRNO, "Error on poll");
+
+	SAFE_READ(1, uffd, &msg, sizeof(msg));
+
+	if (msg.event !=3D UFFD_EVENT_PAGEFAULT)
+		tst_brk(TBROK | TERRNO, "Received unexpected UFFD_EVENT %d", msg.event);
+
+	uffdio_zeropage.range.start	=3D msg.arg.pagefault.address
+					& ~(page_size - 1);
+	uffdio_zeropage.range.len	=3D page_size;
+
+	SAFE_IOCTL(uffd, UFFDIO_ZEROPAGE, &uffdio_zeropage);
+
+	close(uffd);
+	return NULL;
+}
+
+static void run(void)
+{
+	pid_t pid;
+	struct uffdio_api uffdio_api =3D {};
+	struct uffdio_register uffdio_register;
+
+	set_pages();
+
+	uffd =3D SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
+
+	uffdio_api.api =3D UFFD_API;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	uffdio_register.range.start =3D (unsigned long) page;
+	uffdio_register.range.len =3D page_size;
+	uffdio_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	pid =3D SAFE_FORK();
+	if (pid =3D=3D 0) {
+		pagefault_handler();
+		_exit(0);
+	}
+
+	for (int i =3D 0; i < page_size; i++) {
+		if (page[i] !=3D 0) {
+			tst_res(TFAIL, "page[%d]=3D0x%x not zero", i, page[i]);
+			return;
+		}
+	}
+
+	tst_res(TPASS, "Pagefault handled with UFFDIO_ZEROPAGE");
+
+	SAFE_WAITPID(pid, NULL, 0);
+	reset_pages();
+}
+
+static struct tst_test test =3D {
+	.test_all =3D run,
+	.forks_child =3D 1,
+};
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd11.c b/testca=
ses/kernel/syscalls/userfaultfd/userfaultfd11.c
new file mode 100644
index 000000000..52590d117
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd11.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ * Author: Ricardo Branco <rbranco@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different process (using clone with CLONE_VM instead of threads
+ * for Valgrind compatibility) testing UFFDIO_WRITEPROTECT_MODE_WP.
+ */
+
+#include "config.h"
+#include <poll.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/sched.h"
+#include "lapi/userfaultfd.h"
+
+static int page_size;
+static char *page;
+static int uffd;
+static volatile int wp_fault_seen;
+
+static void set_pages(void)
+{
+	page_size =3D sysconf(_SC_PAGE_SIZE);
+	page =3D SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	memset(page, 0, page_size);
+}
+
+static void reset_pages(void)
+{
+	SAFE_MUNMAP(page, page_size);
+}
+
+static void pagefault_handler(void)
+{
+	struct uffd_msg msg;
+	struct uffdio_writeprotect uffdio_writeprotect =3D {};
+
+	struct pollfd pollfd;
+	int nready;
+
+	pollfd.fd =3D uffd;
+	pollfd.events =3D POLLIN;
+	nready =3D poll(&pollfd, 1, -1);
+	if (nready =3D=3D -1)
+		tst_brk(TBROK | TERRNO, "Error on poll");
+
+	SAFE_READ(1, uffd, &msg, sizeof(msg));
+
+	if (msg.event !=3D UFFD_EVENT_PAGEFAULT)
+		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
+
+	if (!(msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP) ||
+	    !(msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)) {
+		tst_brk(TFAIL,
+			"Expected WP+WRITE fault but flags=3D%lx",
+			(unsigned long)msg.arg.pagefault.flags);
+	}
+
+	/* While the WP fault is pending, the write must NOT be visible. */
+	if (page[0xf] !=3D 0)
+		tst_brk(TFAIL,
+			"Write became visible while page was write-protected!");
+
+	wp_fault_seen =3D 1;
+
+	/* Resolve the fault by clearing WP so the writer can resume. */
+	uffdio_writeprotect.range.start	=3D msg.arg.pagefault.address & ~(page_si=
ze - 1);
+	uffdio_writeprotect.range.len	=3D page_size;
+
+	SAFE_IOCTL(uffd, UFFDIO_WRITEPROTECT, &uffdio_writeprotect);
+
+	close(uffd);
+}
+
+static void run(void)
+{
+	const struct tst_clone_args clone_args =3D {
+		.flags =3D CLONE_VM | CLONE_FILES | CLONE_FS | CLONE_SIGHAND,
+		.exit_signal =3D SIGCHLD,
+	};
+	pid_t pid;
+	struct uffdio_api uffdio_api;
+	struct uffdio_register uffdio_register;
+	struct uffdio_writeprotect uffdio_writeprotect;
+
+	set_pages();
+
+	uffd =3D SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
+
+	uffdio_api.api =3D UFFD_API;
+	uffdio_api.features =3D UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	uffdio_register.range.start =3D (unsigned long) page;
+	uffdio_register.range.len =3D page_size;
+	uffdio_register.mode =3D UFFDIO_REGISTER_MODE_WP;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	uffdio_writeprotect.range.start	=3D (unsigned long)page;
+	uffdio_writeprotect.range.len	=3D page_size;
+	uffdio_writeprotect.mode	=3D UFFDIO_WRITEPROTECT_MODE_WP;
+
+	SAFE_IOCTL(uffd, UFFDIO_WRITEPROTECT, &uffdio_writeprotect);
+
+	pid =3D SAFE_CLONE(&clone_args);
+	if (!pid) {
+		pagefault_handler();
+		_exit(0);
+	}
+
+	/* Try to write */
+	page[0xf] =3D 'W';
+
+	SAFE_WAITPID(pid, NULL, 0);
+	reset_pages();
+
+	if (wp_fault_seen)
+		tst_res(TPASS, "WRITEPROTECT pagefault handled!");
+	else
+		tst_res(TFAIL, "No WRITEPROTECT pagefault observed");
+}
+
+static struct tst_test test =3D {
+	.test_all =3D run,
+	.min_kver =3D "5.7",
+	.needs_kconfigs =3D (const char *[]) {
+		"CONFIG_HAVE_ARCH_USERFAULTFD_WP=3Dy",
+		NULL
+	},
+	.forks_child =3D 1,
+};
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd12.c b/testca=
ses/kernel/syscalls/userfaultfd/userfaultfd12.c
new file mode 100644
index 000000000..3fd4e3652
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd12.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC
+ * Author: Ricardo Branco <rbranco@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different process (using clone with CLONE_VM instead of threads
+ * for Valgrind compatibility) testing UFFDIO_POISON.
+ */
+
+#include "config.h"
+#include <poll.h>
+#include <setjmp.h>
+#include <signal.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_clone.h"
+#include "lapi/sched.h"
+#include "lapi/userfaultfd.h"
+
+#define CHILD_STACK_SIZE (1024 * 1024)
+
+static int page_size;
+static char *page;
+static int uffd;
+static int poison_fault_seen;
+static volatile int sigbus_seen;
+static sigjmp_buf jmpbuf;
+static void *child_stack;
+
+static void sigbus_handler(int sig)
+{
+	if (sig =3D=3D SIGBUS) {
+		sigbus_seen =3D 1;
+		siglongjmp(jmpbuf, 1);
+	}
+}
+
+static void setup(void)
+{
+	struct sigaction sa =3D {};
+
+	sa.sa_handler =3D sigbus_handler;
+	sigemptyset(&sa.sa_mask);
+	SAFE_SIGACTION(SIGBUS, &sa, NULL);
+}
+
+static void set_pages(void)
+{
+	page_size =3D sysconf(_SC_PAGE_SIZE);
+	page =3D SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+}
+
+static void reset_pages(void)
+{
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		page =3D NULL;
+	}
+}
+
+static int pagefault_handler(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	struct uffd_msg msg;
+	struct uffdio_poison uffdio_poison =3D {};
+	struct pollfd pollfd;
+	int nready;
+
+	pollfd.fd =3D uffd;
+	pollfd.events =3D POLLIN;
+	nready =3D poll(&pollfd, 1, -1);
+	if (nready =3D=3D -1)
+		tst_brk(TBROK | TERRNO, "Error on poll");
+
+	SAFE_READ(1, uffd, &msg, sizeof(msg));
+
+	if (msg.event !=3D UFFD_EVENT_PAGEFAULT)
+		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
+
+	tst_atomic_store(1, &poison_fault_seen);
+
+	/* Poison the page that triggered the fault */
+	uffdio_poison.range.start =3D msg.arg.pagefault.address & ~(page_size - 1=
);
+	uffdio_poison.range.len =3D page_size;
+
+	SAFE_IOCTL(uffd, UFFDIO_POISON, &uffdio_poison);
+
+	close(uffd);
+	return 0;
+}
+
+static void run(void)
+{
+	pid_t pid;
+	struct uffdio_api uffdio_api =3D {};
+	struct uffdio_register uffdio_register;
+	char dummy;
+
+	poison_fault_seen =3D 0;
+	sigbus_seen =3D 0;
+	set_pages();
+
+	uffd =3D SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
+
+	uffdio_api.api =3D UFFD_API;
+	uffdio_api.features =3D UFFD_FEATURE_POISON;
+
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	if (!(uffdio_api.features & UFFD_FEATURE_POISON))
+		tst_brk(TCONF, "UFFD_FEATURE_POISON not supported");
+
+	uffdio_register.range.start =3D (unsigned long) page;
+	uffdio_register.range.len =3D page_size;
+	uffdio_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	pid =3D ltp_clone(CLONE_VM | CLONE_FILES | CLONE_FS | CLONE_SIGHAND | SIG=
CHLD,
+			pagefault_handler, NULL, CHILD_STACK_SIZE, child_stack);
+	if (pid =3D=3D -1)
+		tst_brk(TBROK | TERRNO, "ltp_clone failed");
+
+	/* Try to read from the page: should trigger fault, get poisoned, then SI=
GBUS */
+	if (sigsetjmp(jmpbuf, 1) =3D=3D 0) {
+		LTP_VAR_USED(dummy) =3D page[0];
+	}
+
+	SAFE_WAITPID(pid, NULL, 0);
+	reset_pages();
+
+	int poisoned =3D tst_atomic_load(&poison_fault_seen);
+
+	if (poisoned && sigbus_seen)
+		tst_res(TPASS, "POISON successfully triggered SIGBUS");
+	else if (poisoned && !sigbus_seen)
+		tst_res(TFAIL, "POISON fault seen but no SIGBUS received");
+	else if (!poisoned && sigbus_seen)
+		tst_res(TFAIL, "SIGBUS received but no poison fault seen");
+	else
+		tst_res(TFAIL, "No poison fault or SIGBUS observed");
+}
+
+static struct tst_test test =3D {
+	.test_all =3D run,
+	.setup =3D setup,
+	.cleanup =3D reset_pages,
+	.forks_child =3D 1,
+	.bufs =3D (struct tst_buffers []) {
+		{&child_stack, .size =3D CHILD_STACK_SIZE},
+		{},
+	},
+};
-- =

2.53.0


-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
