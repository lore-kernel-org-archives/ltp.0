Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E4CCE7A94
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 11:36:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 529D63CDD39
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 13:36:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 924123CDCF5
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 13:36:13 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 37748601285
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 13:36:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cewdsy05frnF4OU56iCytPZTA+m5Utl4GA6IssKnuLRqyXS009+57pIqIItRK1zspQEG6dHAYFjV4fhJRytGROoIBsXSNecCzz2jG2tfsQ9yXi2ih0VsyycKYgY4fC+k2WSlb6YuumO50LpLwNRfggl3Udg/09TydAsOCrHGYGCDQ0i61Uj+3cqcK1BUwCvcbsBmCfvx/1il8is2QEIvv/prGqGguSXI/3tYzXb0wc3m4p/+K0JAxa6usW8qU+2n1NOM+LdGWVdmWLSVLFfHtFz3wUmo1yLh65ooM1gnUU8Jb+Fc4g9a8xDOFVEUXYwguUZPRlpSd0ZmUPA4iPFCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEGhUZboLfuG83oQanJstrRqA2YbNtoZB3g6IFydGJM=;
 b=HhEriCozR/BgkH2anbckbU51hVoVW8zDef6sQzs/ec01lU6FT4lYH09Z0oK4kXYNxQmKtTQPqZU/WVAhPevKDpywil9nbaF8wEoUKAsrbP8HxDFjznLUB8Xb7fk/Zs0t4eIfxtUVu1IFeJfI/65EQ/AtM18FWiXSIxLB71Eu/Na+Tw8HhOl/c2Zsy4OWfgPgrPkkvGveiPhuxRVCP25H4uGV5CTp+YqX+x8hXoPfQhMwxAqrUMr9qtgttr5PT4lHbLMzfPZ4nUHqsvDFnj/ku/gxqDwYNkZ75gsLUyyRitlFzPwCmlFNziiO6veucmKZj5GxFVP0BhxrxdTZVy0Gyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEGhUZboLfuG83oQanJstrRqA2YbNtoZB3g6IFydGJM=;
 b=NBMBKqprhsjB/nOzc7reF3oI8Mg8S9s9mYKObdcCqn8whbEvqLs/1uBzT/unwS+j7trM7qOY4kG0Owvl01wCAy7BFuWiO7zuh1IggAFhqnPzVZTbOoussLNusA6cCIaETvOu4eL89ISyIZ4iIe4BvBHSfHqESn/k/0xm/3SpF0AKzAmBXNQkcD3qSwTqg95HTLOE6XTZfc5WZMs0dELcRcIEdtu7qbzDbV1y729MM2VIzSZUNtqQRDI/bQOjpHFMOoDWlcUEoK63nKKpRtXNwQ1guA0GaRUiRfa0MW09AXWM5f57UVF/PAyodtX9Ow68bq80aDzgPy2/+sicKYwtlg==
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DU2PR04MB8982.eurprd04.prod.outlook.com (2603:10a6:10:2e1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 11:36:10 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 11:36:10 +0000
To: Wei Gao <wegao@suse.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v1 1/2] seccomp01.c: Add SECCOMP_RET_USER_NOTIF check
Thread-Index: AQHZ76EEcggz7rY/LEaNqbRFclGECbAraa2A
Date: Mon, 25 Sep 2023 11:36:10 +0000
Message-ID: <AS8PR04MB8199ED73CDABF20BF2E9810ADEFCA@AS8PR04MB8199.eurprd04.prod.outlook.com>
References: <20230925110422.19167-1-wegao@suse.com>
 <20230925110422.19167-2-wegao@suse.com>
In-Reply-To: <20230925110422.19167-2-wegao@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8199:EE_|DU2PR04MB8982:EE_
x-ms-office365-filtering-correlation-id: a3e2d85e-ae59-40cf-e4bf-08dbbdbb9d71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wgpanZNJqth5ijkHq4NUb46dWW4SnMFSfId1smgFBqwDSfuDwtAl7+fkWnFF6DWdJ2yMLWifTEyey/bnFcU8opJBI6qIQ0NQFuaHxrtCYDFqmNH+ZWwtTuxnuDRdRBoHnRyOVNbLRb1Z2s9UVjDupxb3bqG6jBeCCZXtPaiv7Xxx+2Wntsl7CxyjE0dzelBgJ8F+wC0SdathTlLEPsGLm3egQfcQqpOh/OLihKVpWlUfx1n40FN5L5o+eBIS6p822R4l4cKnrSGTGSfT4g1T/z9og1zdBpos5gCcQaSYp2RQ7hGVa2qJUoDDnO3sSTUebGBk4Peun7+mmLTc8+tSR3qNw4QyiUgtwacSgoeXCTZILORxDbBXfJT61E1SFcVFefxg3auMfaCeHOAVmv/yQ+nbNxrYUuCaD+Rid07x0tTbIdk+YxOQ+rqxY+YMpElOu5JhroonFg04B6zY6dZChGjI/k9XgFQ9LFmHJ6A0vjihUYsCl7zi6nnwrRFkfKjq1xGhEGMXuprYaqki+048Xb2g+rp242SOCtpA4+M/XZVK4475RfiY+LnukXt8J++TC99Kb2dxTFnVyB88qq0HyN7x15lAnNLTduCsTqV7tDM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(39850400004)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(30864003)(2906002)(52536014)(5660300002)(110136005)(66946007)(66476007)(66446008)(64756008)(66556008)(76116006)(478600001)(966005)(71200400001)(53546011)(9686003)(7696005)(26005)(6506007)(8936002)(8676002)(316002)(41300700001)(83380400001)(122000001)(86362001)(38100700002)(38070700005)(55016003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SoavVXMNVsfyGhGp/izHuSs2QS79U45K8KgaEwLNZiYYSWOx/1vUTJuttROi?=
 =?us-ascii?Q?qDAUNHniNbDKimC63JJ8bOs/NELbA9JHP79i0xSNyg+62o/L89/hM0tyuowe?=
 =?us-ascii?Q?d9LtlHD6Z8/y94LqRqv7iUl2xTio+r9o83CfQC2f5tHZ09llaeLQ2l99Ar0v?=
 =?us-ascii?Q?yi2RI8KxtwsSc6kb6+XgJkZnpC+9QGs3KHLJeOEj0hgKPpXF3YFHnFT6TnKg?=
 =?us-ascii?Q?2cOvplH8aOmGeSsb58jzRkHC0iQDIiEA1QBPVIatTYDQwe7CuCHVPOHllXOz?=
 =?us-ascii?Q?SKTWJKxo15EM7oeeQ6YSHRz8wF7h65Pi95LI4bYqJ+OBc6zCvdcuuIPgcKOr?=
 =?us-ascii?Q?g3EhktAnuG3481zixe6ytsTCaUm1l3pMt4PNEryvwgclO12NpZC+BT1UzIjZ?=
 =?us-ascii?Q?21xVnYwWrNI8ii/5F4IC9tH7ntztHni9Pozny49a7R678DiNkfgMZ15D2k85?=
 =?us-ascii?Q?KdGJ4HNcZxKbpV+PaT9zzkN+ogdZ5aLjF6UFX7jHjP/Gh5xR8tJ3Ctfl2ahi?=
 =?us-ascii?Q?hlLXR4UGlv4K1TXannkRAn/DSvYTvQb6J4bdm7teE2RcQixXEA8x809gnJcn?=
 =?us-ascii?Q?C9zV6OIS57JtQkIcUJ9OXc6bwqvXEGPx+wZKStABIwqBjjntH1AwJU9Eh7Ik?=
 =?us-ascii?Q?l67El6qKLyhpbzqZrB76MQ8ArfI4TDgrVpKv3Aq7HxVqBKqCCuLrIgjtY4Z9?=
 =?us-ascii?Q?n4bWWsZA6OoZ/URhG9O2YzGyGdNa69cOky7IEg/OMrfTCP9qsW2jkDitTUo9?=
 =?us-ascii?Q?1IKh8lgdj91yBujmpLgiHfgkq0y4+K0E44DDwqOjb6bpsrXAIWETk+s5ISHs?=
 =?us-ascii?Q?AdzT+QWpzDFNPzu9iWj6eH9PN/eEWki3H2AunTnf6922LKgpzXIQ3Eo88fun?=
 =?us-ascii?Q?nQx6ETjatKthlAEBCML5nSZvcHVyGS8jjq6gtKYFHJFw+VFT9Yyt7nhFgyWU?=
 =?us-ascii?Q?o6g1qLNybJiRM0MbXZ3nCLfqL/Uu4yP8+u3FdMUkU74jf++5Fou36p1mQ10v?=
 =?us-ascii?Q?4aIgROoHQU50vraWKDje5jsYBk0UaGH+bj1ODNvRBcKCNLBCWzXVzOusJANH?=
 =?us-ascii?Q?57TE5NKyrDbpjVybnABp8ZmKn6X1tUzzpWq5XvhRj9oP4Hx8xRvlYZJPF4sj?=
 =?us-ascii?Q?epMbW70gamlhuSTBotXsjvejI+zktMhdoQvyQNXG/OuFuSHsfdB5bm95bJJT?=
 =?us-ascii?Q?vvbWEU9XT0hBTbKlCy08VksTJat0ojxRsa+vpLZmNRQsV/HstNUSmTJ2QoH1?=
 =?us-ascii?Q?K7OBDzSzLpfYzY1TFneAd6LamepupVXJtddHlvAVEc/P6xILTn1b3wihGN3X?=
 =?us-ascii?Q?Vq23U0OS1Bb4Unp0AMQ7bQkdcPryCldyjrA22BxXpFPVl8ClKOF0I//k9qC6?=
 =?us-ascii?Q?XbHP3yhgGkQU4paSrREH3eo6h8SYpRFJ0XI1vqGioxL7T2PW+c/JsH6+Ew3A?=
 =?us-ascii?Q?J+afspgcuyPFjVhlci+LkwY7+MKktszD6QPFrCJOh4ay97Ot7Dp7/8Y1LYVC?=
 =?us-ascii?Q?uB41jaAByIANin+9nTrcxDgfxKMBYwUTp7XA/RH0bH3TR9iZa2UbJacfDyNL?=
 =?us-ascii?Q?NFJfdyFNEW8EhdnHARk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e2d85e-ae59-40cf-e4bf-08dbbdbb9d71
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 11:36:10.0703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VfMR76DGtzo3XynuURP0F3eF18l+HnKSvUbckFD/4IyE3GppUQEwaQcwXZDCwMan
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8982
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] seccomp01.c: Add SECCOMP_RET_USER_NOTIF
 check
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Sorry for the garbage email, please SKIP this email.

-----Original Message-----
From: Wei Gao <wegao@suse.com> 
Sent: Monday, September 25, 2023 7:04 PM
To: Wei Gao <wegao@suse.com>; ltp@lists.linux.it
Subject: [PATCH v1 1/2] seccomp01.c: Add SECCOMP_RET_USER_NOTIF check

This case will report EINVAL error when execute SAFE_IOCTL(notifyFd, SECCOMP_IOCTL_NOTIF_RECV, req) such as 5.6.19, so i put current case's .min_kver = "5.7.19"

NOTE: If your old kernel compile env is ubuntu 22.04 LTS, better use old gcc-8 and also apply patch base following link:
https://www.spinics.net/lists/kernel/msg3797871.html

Signed-off-by: Wei Gao <wegao@suse.com>
---
 configure.ac                                  |   1 +
 include/lapi/seccomp.h                        |   7 +
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/seccomp/.gitignore  |   1 +
 testcases/kernel/syscalls/seccomp/Makefile    |   8 +
 testcases/kernel/syscalls/seccomp/seccomp01.c | 456 ++++++++++++++++++
 6 files changed, 475 insertions(+)
 create mode 100644 testcases/kernel/syscalls/seccomp/.gitignore
 create mode 100644 testcases/kernel/syscalls/seccomp/Makefile
 create mode 100644 testcases/kernel/syscalls/seccomp/seccomp01.c

diff --git a/configure.ac b/configure.ac index 662c4c058..6cea35cb4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -138,6 +138,7 @@ AC_CHECK_FUNCS_ONCE([ \
     renameat \
     renameat2 \
     sched_getcpu \
+    seccomp \
     sendmmsg \
     sethostid \
     setns \
diff --git a/include/lapi/seccomp.h b/include/lapi/seccomp.h index 29819ba6f..cfb3da55d 100644
--- a/include/lapi/seccomp.h
+++ b/include/lapi/seccomp.h
@@ -37,4 +37,11 @@ struct seccomp_data {  };
 
 #endif /* HAVE_LINUX_SECCOMP_H*/
+
+# ifndef HAVE_SECCOMP
+int seccomp(unsigned int operation, unsigned int flags, void *args) {
+	return syscall(__NR_seccomp, operation, flags, args); } # endif /* 
+HAVE_SECCOMP */
 #endif /* LAPI_SECCOMP_H__ */
diff --git a/runtest/syscalls b/runtest/syscalls index 4f1ee1f34..544610d63 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1242,6 +1242,8 @@ select02 select02
 select03 select03
 select04 select04
 
+seccomp01 seccomp01
+
 semctl01 semctl01
 semctl02 semctl02
 semctl03 semctl03
diff --git a/testcases/kernel/syscalls/seccomp/.gitignore b/testcases/kernel/syscalls/seccomp/.gitignore
new file mode 100644
index 000000000..9196906cf
--- /dev/null
+++ b/testcases/kernel/syscalls/seccomp/.gitignore
@@ -0,0 +1 @@
+seccomp01
diff --git a/testcases/kernel/syscalls/seccomp/Makefile b/testcases/kernel/syscalls/seccomp/Makefile
new file mode 100644
index 000000000..49238eee0
--- /dev/null
+++ b/testcases/kernel/syscalls/seccomp/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only # Copyright (c) 2023 Wei Gao 
+<wegao@suse.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/seccomp/seccomp01.c b/testcases/kernel/syscalls/seccomp/seccomp01.c
new file mode 100644
index 000000000..bf23fe8f7
--- /dev/null
+++ b/testcases/kernel/syscalls/seccomp/seccomp01.c
@@ -0,0 +1,456 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Michael Kerrisk <mtk.manpages@gmail.com>
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>  */
+
+/*\
+ * [Description]
+ *
+ * Verify seccomp and seccomp_user_notif  */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/prctl.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <signal.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <linux/audit.h>
+#include <sys/syscall.h>
+#include <sys/stat.h>
+#include <linux/filter.h>
+#include <linux/seccomp.h>
+#include <sys/ioctl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include "tst_test.h"
+#include "lapi/seccomp.h"
+
+#define TMP_PREFIX_DIR "/tmp/ltp_test"
+#define CWD_DIR "./abc"
+#define OTHER_DIR "/aa"
+
+static struct tcase {
+	char *dir;
+	int expect_ret;
+	char *desc;
+} tcases[] = {
+	{TMP_PREFIX_DIR, strlen(TMP_PREFIX_DIR), "pathname begins with the prefix /tmp/"},
+	{CWD_DIR, 0,  "pathname begins with ./"},
+	{OTHER_DIR, -1, "pathname begins with /abc"}, };
+
+static int sendfd(int sockfd, int fd)
+{
+	struct msghdr msgh;
+	struct iovec iov;
+	int data;
+	struct cmsghdr *cmsgp;
+
+	/* Allocate a char array of suitable size to hold the ancillary data.
+	 * However, since this buffer is in reality a 'struct cmsghdr', use a
+	 * union to ensure that it is suitable aligned.
+	 */
+	union {
+		char   buf[CMSG_SPACE(sizeof(int))];
+		/* Space large enough to hold an 'int' */
+		struct cmsghdr align;
+	} controlMsg;
+
+	/* The 'msg_name' field can be used to specify the address of the
+	 * destination socket when sending a datagram. However, we do not
+	 * need to use this field because 'sockfd' is a connected socket.
+	 */
+
+	msgh.msg_name = NULL;
+	msgh.msg_namelen = 0;
+
+	/* On Linux, we must transmit at least one byte of real data in
+	 * order to send ancillary data. We transmit an arbitrary integer
+	 * whose value is ignored by recvfd().
+	 */
+
+	msgh.msg_iov = &iov;
+	msgh.msg_iovlen = 1;
+	iov.iov_base = &data;
+	iov.iov_len = sizeof(int);
+	data = 12345;
+
+	/* Set 'msghdr' fields that describe ancillary data */
+
+	msgh.msg_control = controlMsg.buf;
+	msgh.msg_controllen = sizeof(controlMsg.buf);
+
+	/* Set up ancillary data describing file descriptor to send */
+
+	cmsgp = CMSG_FIRSTHDR(&msgh);
+	cmsgp->cmsg_level = SOL_SOCKET;
+	cmsgp->cmsg_type = SCM_RIGHTS;
+	cmsgp->cmsg_len = CMSG_LEN(sizeof(int));
+	memcpy(CMSG_DATA(cmsgp), &fd, sizeof(int));
+
+	SAFE_SENDMSG(sizeof(int), sockfd, &msgh, 0);
+
+	return 0;
+}
+
+static int recvfd(int sockfd)
+{
+	struct msghdr msgh;
+	struct iovec iov;
+	int data, fd;
+	ssize_t nr;
+
+	/* Allocate a char buffer for the ancillary data. See the comments
+	 * in sendfd()
+	 */
+	union {
+		char   buf[CMSG_SPACE(sizeof(int))];
+		struct cmsghdr align;
+	} controlMsg;
+	struct cmsghdr *cmsgp;
+
+	/* The 'msg_name' field can be used to obtain the address of the
+	 * sending socket. However, we do not need this information.
+	 */
+
+	msgh.msg_name = NULL;
+	msgh.msg_namelen = 0;
+
+	/* Specify buffer for receiving real data */
+
+	msgh.msg_iov = &iov;
+	msgh.msg_iovlen = 1;
+	iov.iov_base = &data;       /* Real data is an 'int' */
+	iov.iov_len = sizeof(int);
+
+	/* Set 'msghdr' fields that describe ancillary data */
+
+	msgh.msg_control = controlMsg.buf;
+	msgh.msg_controllen = sizeof(controlMsg.buf);
+
+	/* Receive real plus ancillary data; real data is ignored */
+
+	nr = SAFE_RECVMSG(sizeof(int), sockfd, &msgh, 0);
+
+	if (nr == -1)
+		return -1;
+
+	cmsgp = CMSG_FIRSTHDR(&msgh);
+
+	/* Check the validity of the 'cmsghdr' */
+
+	if (cmsgp == NULL ||
+			cmsgp->cmsg_len != CMSG_LEN(sizeof(int)) ||
+			cmsgp->cmsg_level != SOL_SOCKET ||
+			cmsgp->cmsg_type != SCM_RIGHTS) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	/* Return the received file descriptor to our caller */
+
+	memcpy(&fd, CMSG_DATA(cmsgp), sizeof(int));
+	return fd;
+}
+
+/* The following is the x86-64-specific BPF boilerplate code for 
+checking
+ * that the BPF program is running on the right architecture + ABI. At
+ * completion of these instructions, the accumulator contains the 
+system
+ * call number.
+ */
+
+/* For the x32 ABI, all system call numbers have bit 30 set */
+
+#define X32_SYSCALL_BIT         0x40000000
+
+#define X86_64_CHECK_ARCH_AND_LOAD_SYSCALL_NR \
+	BPF_STMT(BPF_LD | BPF_W | BPF_ABS, \
+	(offsetof(struct seccomp_data, arch))), \
+	BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, AUDIT_ARCH_X86_64, 0, 2), \
+	BPF_STMT(BPF_LD | BPF_W | BPF_ABS, \
+	(offsetof(struct seccomp_data, nr))), \
+	BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, X32_SYSCALL_BIT, 0, 1), \
+	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS)
+
+/* installNotifyFilter() installs a seccomp filter that generates
+ * user-space notifications (SECCOMP_RET_USER_NOTIF) when the process
+ * calls mkdir(2); the filter allows all other system calls.
+ *
+ * The function return value is a file descriptor from which the
+ * user-space notifications can be fetched.
+ */
+
+static int installNotifyFilter(void)
+{
+	struct sock_filter filter[] = {
+		X86_64_CHECK_ARCH_AND_LOAD_SYSCALL_NR,
+
+		/* mkdir() triggers notification to user-space supervisor */
+
+		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_mkdir, 0, 1),
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_USER_NOTIF),
+
+		/* Every other system call is allowed */
+
+		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
+	};
+
+	struct sock_fprog prog = {
+		.len = ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	/* Install the filter with the SECCOMP_FILTER_FLAG_NEW_LISTENER flag;
+	 * as a result, seccomp() returns a notification file descriptor.
+	 */
+
+	TST_EXP_POSITIVE(seccomp(SECCOMP_SET_MODE_FILTER,
+				SECCOMP_FILTER_FLAG_NEW_LISTENER, &prog));
+	return TST_RET;
+
+}
+
+/* Close a pair of sockets created by socketpair() */
+
+static void closeSocketPair(int sockPair[2]) {
+	SAFE_CLOSE(sockPair[0]);
+	SAFE_CLOSE(sockPair[1]);
+}
+
+/* Implementation of the target process; create a child process that:
+ *
+ * (1) installs a seccomp filter with the
+ * SECCOMP_FILTER_FLAG_NEW_LISTENER flag;
+ * (2) writes the seccomp notification file descriptor returned from
+ * the previous step onto the UNIX domain socket, 'sockPair[0]';
+ * (3) calls mkdir(2) for each element of 'argv'.
+
+ * The function return value in the parent is the PID of the child
+ * process; the child does not return from this function.
+ */
+
+static pid_t targetProcess(int sockPair[2], struct tcase *tc) {
+
+	pid_t targetPid = SAFE_FORK();
+
+	if (targetPid > 0)          /* In parent, return PID of child */
+		return targetPid;
+
+	/* Child falls through to here */
+
+	tst_res(TINFO, "T: PID = %ld", (long) getpid());
+
+	/* Install seccomp filter(s) */
+
+	TST_EXP_PASS(prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+
+	int notifyFd = installNotifyFilter();
+
+	/* Pass the notification file descriptor to the tracing process over
+	 * a UNIX domain socket
+	 */
+
+	TST_EXP_PASS(sendfd(sockPair[0], notifyFd));
+
+	/* Notification and socket FDs are no longer needed in target */
+
+	SAFE_CLOSE(notifyFd);
+
+	closeSocketPair(sockPair);
+
+	tst_res(TINFO, "T: about to mkdir(\"%s\")", tc->dir);
+
+	TST_CHECKPOINT_WAIT(0);
+
+	TEST(mkdir(tc->dir, 0700));
+
+	tst_res(TINFO, "T: SUCCESS: mkdir(2) returned %ld", TST_RET);
+	if (TST_RET == tc->expect_ret)
+		tst_res(TPASS, "Case %s PASS", tc->desc);
+	else
+		tst_brk(TBROK | TTERRNO, "Case %s Failed, expect %d but return %ld",
+						tc->desc, tc->expect_ret, TST_RET);
+
+	exit(EXIT_SUCCESS);
+}
+
+
+/* Access the memory of the target process in order to discover the
+ * pathname that was given to mkdir()
+ */
+
+static void getTargetPathname(struct seccomp_notif *req, int notifyFd,
+		char *path)
+{
+	char procMemPath[PATH_MAX];
+
+	snprintf(procMemPath, sizeof(procMemPath), "/proc/%d/mem", req->pid);
+
+	int procMemFd = SAFE_OPEN(procMemPath, O_RDONLY);
+
+	/* Check that the process whose info we are accessing is still alive.
+	 * If the SECCOMP_IOCTL_NOTIF_ID_VALID operation (performed
+	 * in checkNotificationIdIsValid()) succeeds, we know that the
+	 * /proc/PID/mem file descriptor that we opened corresponds to the
+	 * process for which we received a notification. If that process
+	 * subsequently terminates, then read() on that file descriptor
+	 * will return 0 (EOF).
+	 */
+
+	SAFE_IOCTL(notifyFd, SECCOMP_IOCTL_NOTIF_ID_VALID, &req->id);
+
+	/* Seek to the location containing the pathname argument (i.e., the
+	 *  first argument) of the mkdir(2) call and read that pathname
+	 */
+
+	SAFE_LSEEK(procMemFd, req->data.args[0], SEEK_SET);
+
+	SAFE_READ(1, procMemFd, path, PATH_MAX);
+
+	SAFE_CLOSE(procMemFd);
+}
+
+/* Handle notifications that arrive via the SECCOMP_RET_USER_NOTIF file
+ *  descriptor, 'notifyFd'.
+ */
+
+static void handleNotifications(int notifyFd) {
+	struct seccomp_notif_sizes sizes;
+	char path[PATH_MAX];
+
+	TST_EXP_POSITIVE(seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes));
+
+	struct seccomp_notif *req = SAFE_MALLOC(sizes.seccomp_notif);
+
+	struct seccomp_notif_resp *resp = 
+SAFE_MALLOC(sizes.seccomp_notif_resp);
+
+	memset(req, 0, sizes.seccomp_notif);
+
+	TST_CHECKPOINT_WAKE(0);
+
+	SAFE_IOCTL(notifyFd, SECCOMP_IOCTL_NOTIF_RECV, req);
+
+	tst_res(TINFO, "S: got notification (ID %#llx) for PID %d",
+			req->id, req->pid);
+
+	/* The only system call that can generate a notification event
+	 * is mkdir(2). Nevertheless, we check that the notified system
+	 * call is indeed mkdir() as kind of future-proofing of this
+	 * code in case the seccomp filter is later modified to
+	 * generate notifications for other system calls.
+	 */
+
+	if (req->data.nr != __NR_mkdir)
+		tst_brk(TBROK, "notification contained unexpected system call 
+number");
+
+	getTargetPathname(req, notifyFd, path);
+
+	/* Prepopulate some fields of the response */
+
+	resp->id = req->id;     /* Response includes notification ID */
+	resp->flags = 0;
+	resp->val = 0;
+
+	/* If the directory is in /tmp, then create it on behalf of
+	 * the supervisor; if the pathname starts with '.', tell the
+	 * kernel to let the target process execute the mkdir();
+	 * otherwise, give an error for a directory pathname in
+	 * any other location.
+	 */
+
+	if (strncmp(path, "/tmp/", strlen("/tmp/")) == 0) {
+		tst_res(TINFO, "S: executing: mkdir(\"%s\", %#llo)",
+				path, req->data.args[1]);
+
+		if (mkdir(path, req->data.args[1]) == 0) {
+			resp->error = 0;            /* "Success" */
+			resp->val = strlen(path);   /* Used as return value of
+						     * mkdir() in target
+						     */
+			tst_res(TINFO, "S: success! spoofed return = %lld",
+					resp->val);
+		} else {
+
+			/* If mkdir() failed in the supervisor, pass the error
+			 *  back to the target
+			 */
+
+			resp->error = -errno;
+			tst_res(TINFO, "S: failure! (errno = %d; %s)", errno,
+					strerror(errno));
+		}
+	} else if (strncmp(path, "./", strlen("./")) == 0) {
+		resp->error = resp->val = 0;
+		resp->flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
+		tst_res(TINFO, "S: target can execute system call");
+	} else {
+		resp->error = -EOPNOTSUPP;
+		tst_res(TINFO, "S: spoofing error response (%s)",
+				strerror(-resp->error));
+	}
+
+	/* Send a response to the notification */
+
+	tst_res(TINFO, "S: sending response "
+			"(flags = %#x; val = %lld; error = %d)",
+			resp->flags, resp->val, resp->error);
+
+	SAFE_IOCTL(notifyFd, SECCOMP_IOCTL_NOTIF_SEND, resp);
+
+}
+
+/* Implementation of the supervisor process:
+ *
+ * (1) obtains the notification file descriptor from 'sockPair[1]'
+ * (2) handles notifications that arrive on that file descriptor.
+ */
+
+static void supervisor(int sockPair[2]) {
+	int notifyFd = TST_EXP_POSITIVE(recvfd(sockPair[1]));
+
+	closeSocketPair(sockPair);  /* We no longer need the socket pair */
+
+	handleNotifications(notifyFd);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int sockPair[2];
+
+	tst_res(TINFO, "Test case %s start", tc->desc);
+
+	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sockPair);
+
+	int pid = targetProcess(sockPair, tc);
+
+	supervisor(sockPair);
+
+	SAFE_WAITPID(pid, NULL, 0);
+
+	if (!access(tc->dir, F_OK))
+		SAFE_RMDIR(tc->dir);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.min_kver = "5.7.19",
+	.needs_checkpoints = 1
+};
--
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
