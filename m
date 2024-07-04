Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0D2C3065C
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 05:38:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 450613D3CC8
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 07:38:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 539633D3CBA
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 07:37:55 +0200 (CEST)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01olkn20800.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:280c::800])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BF0DA600FA4
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 07:37:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8Hi/DVBxztV9l/amIw921vPfAhx7dPv9sYN1sNskcKWUvOSdyoyjzO9XeJqIuVpIJ00fY6rnQSBOoDGZooZgp0qdOAo/iU/lUm20Hv/uGM0Ifcm/7vwkxtNL+Fwwjr0vq2GslOBnAGwAiHUrwuA+hTx3ak/QPeFw5JfokDxhT8UNzEXq8T0RdsbnI2PRP9Qy9XMBviV4V/puebEnHLsdZSpRVrlwpLTe55ZUDa94koEYy33R0xevsGxJH5Qyds7j9P1dYrqpJBwY23pRw+4Ad+NIAs9zsLeB13VsnVa1XTlrzCg3h/Gt2SFD5iwMCtGUInhQD0nQaLUyy7zEzAsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q98Aw5kjewLERagYriNUYuwOmReGp9MML9GNdwMZo4o=;
 b=UoTnGTDNEMEZbslZofZfXcl7Tsps59UqnKnLfv0uSYrm5qRr7TkPjQ4YYVwR3uXIyOSBS296f7xGOF9QT51sas3RzHlZW1KvHf8LcWIvf8OglwpGLW2twvHT0W5/ZkeALLLgeg6wjgsYMA5lNZuMEGMSgWI0+Xu+YcaoLcxbk7Hmtc1L6buGglAADq0bccBKX9tEAzalORxwt/P9u/UdQagpK2hWLknBNOwUwXGuuhhdYoyVXxbmodiQfBFFO8Q4sA1cPkafJV3wdbA+i+dPZPmWeHLmb8j9U8uEYiwhiURZ+u5q2Ptpns1U/L/O8IEuoKi3EHIjLATdOdMhFW6Vrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q98Aw5kjewLERagYriNUYuwOmReGp9MML9GNdwMZo4o=;
 b=fD+TbYy03ZQVDP/prEYWo7Ws78NK9JMP/hy179j7mYA35cq8fAUskzo46CWB5ki3lKNqusOsv7A2SR+CMw4SauuP1D9UH7Gnw8lO+KjzSntvHl6vM/WTT9swJYStA1slVKzGyuv71ncpTGgFUG17ySFiTU3QXavA9jWcyJM04BBx+GRFTumCgZtr2JuuDc/JpdTeY60vpca7VslmU70Tc768YZ7kTrRXcDz9ni9mL7BhoEPX61yp8pK3DOLjFhDG7yxGjEY13AStph46FrStOTTkQ2diV35x3YKJDM1CSvXeDHXZuJGcH/Phbz6pd8qnxd9u47tOl2mtkhbCwVWO1w==
Received: from SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 (2603:1096:101:76::5) by KL1PR01MB4653.apcprd01.prod.exchangelabs.com
 (2603:1096:820:c6::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 05:37:49 +0000
Received: from SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 ([fe80::653b:3492:9140:d2bf]) by SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 ([fe80::653b:3492:9140:d2bf%6]) with mapi id 15.20.7719.028; Thu, 4 Jul 2024
 05:37:49 +0000
From: Jiwei Sun <sunjw10@outlook.com>
To: ltp@lists.linux.it
Date: Thu,  4 Jul 2024 13:37:39 +0800
Message-ID: <SEZPR01MB4527B0054808F801B05EECB7A8DE2@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.34.1
X-TMN: [Nt8SbVk+dxq97liiAwuNfTi4mT+kjTET]
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 (2603:1096:101:76::5)
X-Microsoft-Original-Message-ID: <20240704053739.10006-1-sunjw10@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4527:EE_|KL1PR01MB4653:EE_
X-MS-Office365-Filtering-Correlation-Id: 160a05d1-6c69-42cd-9b76-08dc9beb70fe
X-MS-Exchange-SLBlob-MailProps: AlkLxVwsndl1++jkS5JtmafIN+9Zs6O1bFp0dZHljV1zKeXMFBUvUlmLto1uOyw92c48mYPLO5vPF5OCZuHb0C70M3ICUTOlKsxogcjcnJUPLvruoLfTIAiT36PPnENlT1qMjTvB4I2ncV/JWiETZyy0HJnXfwdPblP6/mDXoE95fTUWaVnymoDlIL6hUCpqdcmB43Fz1AMcXK8dQrIghJi88W/8/llWFRKZDeSTzlr1z2m1OXMZTPDD5uZgecReRb1DQnZvO9W8wnLiQQd8KTf5GZRtHsv8/4W+mrZuA+U0EEWvBc9VrI3tOgUQszhuI+ys76stN/10pGZzP19yUN04DUDqDaV8LjcXmM9RKCK87fHg9cSYuIj0Vxec5+94gR/zrFJXyvc6E0+mQrL7cFjrS5b5ea25/aR8xYQo/K0aQoTYRI/xHkeaEV1c3AeR2iZ1Q6ecbwB0xD9mY9YzZXEwPkFgHdfrfmutovOjwbv7++/BOVj1W9EhwpjP+F+T9ZGOqY6TMifEw28zHF5rcEbBQJhWhFha8dzBheOsKLDQtJQIF9yithEAj/VfEWgS+ywD+2TDcndGJxWDJSwI4qih0jlOUz+v8U11ZO9tKxA1b2LmZuzWKLJ3RKXyNFfVWHsJYREneth/+TbHKiyzU/znyiLpitK9HaAbFKPmtoUcJUxKFNM2QMmzLbqoFjbfDi1fcOxkRhZIexb9vcPdMYygdJTdiC2PIyPlG2bVTo+fgBjGFUXDv8lmcn0ioH3pw5gpX84+j4VXc8/wAko4WdZm6eNsibaa
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|8060799006|3420499032|440099028|3412199025|1710799026; 
X-Microsoft-Antispam-Message-Info: s3TlIs2tH7UkNpWJsbND9aT5hMttttEwzgOVGgogz8q5KFsjr77vMQt01ujKUnpwwpcjfN1PEKjPzEZcLXm5V2qUYabGfBWfk6QDyxhUHx5Ooskq7bmGY80wBRwS1dqicXkwxbwsHgPBdeiIQB2k0BFvL8HuQL5rINtAAm64YfnCIS0gnvCXI1jZ/GIhGpXNiohwxhDhZS1ce/a7uY5rbLvV60VOO7b6GEOXflvlgNU4Zz6SGmQbyiMpX0UDdVHixSPvUAqsiFHRXLguBQU6h1BNVeI/sojLs8BBculiwf+lnUmX7ClJO/Xj1p7dJ5+E7NeK268RHVhRSGGasjDGrAVd1CO+8nHyYZZ6s46zvkQHFvjM9h9CPpbJ/oSTGaNrxF8fleYYPk1caLgTe+14RPgklhOpPtGJhL3KMoRM6TNRx2Bf6dyXD2HnR2hnSWz3TAIOTp+FkZVLWJyYf0PwCqKydEYYUmkvk5/tTmVXSQyfbQ/vclkhcTsGzr08kJHdKHEoMfBTOcSZXA6E5H5YdOP88NSDem7ArDEkVLif1x9h2xrjCLVzgAEHTxqADUCcaiMxB8P/ZNB0gK3pb2xtrTPuov1T3ULNMKbedrbRpOq61pxCLmDH4qDEsJVmJUq9/l9ZwOea6l/+LkNeTidpNg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w3vp1sqPNFF2H44vBRTMot6fz/6RLlY64SNPR/3kW9nuvgeAarutItg3IFE1?=
 =?us-ascii?Q?ZKXbD8Gl11pCRAN/4qWVZoobjW/OPe64+2XuY7MRkWMr+jJYqsRGVkkyxsKa?=
 =?us-ascii?Q?Hp04VtsEfkkJ+9UIKnCGR0BMEvmCl9DUrd38bPRHPcEZnwNgWkV0Swc9di77?=
 =?us-ascii?Q?peqefMAxTba9KijXDRPggz0PCMgfJV+CYgSypCbXuMRt5wIeS7lz3TVSm/tM?=
 =?us-ascii?Q?KRBfEid+7WqjFfbvY297pu6x7lndtCWxYuNlor9oP3Xrx4LtaHrNtYtpaUpP?=
 =?us-ascii?Q?2H7XVJEI+rc/5Tp+mpD05QzA/8k0K++21CbpJ7uCOnggHjsyuNH8moDQu2Q5?=
 =?us-ascii?Q?VxOEwn3EZNXGSqMTRMrNQ7Z9cZPF7XSX5zgdSwSxMZ8Kp2KmxxuzJZDly1sG?=
 =?us-ascii?Q?7fDMjFC28cGIfuZ7FggsXk3VbWVF8Edje5fFNitBLPlYbuv74qVsYa9Yuuh6?=
 =?us-ascii?Q?AUSAPgK4sCjWYH8UaOukUaT5gLWpdZO60omS9DOenqjAuQ7+frN2rTVIwdqm?=
 =?us-ascii?Q?ln0dwAn7Lyq7IwzYCrmFVTRIIYhA5cmYnKAXSPtezlMNrJh39O+8JlHN15Es?=
 =?us-ascii?Q?gMakXEvJhvKYFKMSuJw2NlRaG4yvgkbS/ZFsO2mv1EdPV97wnAmKivz6ecGH?=
 =?us-ascii?Q?TRnUhi57Wt4AIgZzywmlr2EmG6kmJXAnFJl05kPtjuHBIUiMo3pKXv1/1TqC?=
 =?us-ascii?Q?ZyTe05W62nWVda0X2HpNNDpuE/nQ2Esj54aTwd/hcWuWdzTb1kP2+MsgM99X?=
 =?us-ascii?Q?GpVKD0mFfKyRWzxrVUzB7iPC8YEWIF+ZzhJ2iFrHAziHucnkkg+02RgWa1oC?=
 =?us-ascii?Q?tssa+0DH/vSjM6GWYQTfMWRhZdS8cICwv/Do2MAAiZSsxQsdU8WoqaLCxq6p?=
 =?us-ascii?Q?MyrEwfE1lx9F0Cx2+aGZNPxxzhrciTGvFJJfbir3DJQ0g3oGYgVrYawoDkhU?=
 =?us-ascii?Q?nb1sykPLI3T7QRs/vCRcMsxIvMXBhmNNdNTCC7cd5q3huHh7+rfyfWAmdf/P?=
 =?us-ascii?Q?2MmSjVH0jgXqyVoN1b5D6hq0693E6MK4j2BUG3U0sdC1jHC1oVawd1mqqkgH?=
 =?us-ascii?Q?RY4VCB07lCtfQpZwRMzsNbjSrjR8EPSlt4WVu3yBKtAR9NrGT+r7AqOrzKws?=
 =?us-ascii?Q?aD9e+keNLIjBnVBz54qNL0wOxcrngumM++oAtxN70wHfuGQwhGx9vTRo9C+l?=
 =?us-ascii?Q?7H+YWgtWMnTMWXDS75b1kU425KaYH6x01Pdit5DdYnoVPx8TJcAAXUYQIU8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160a05d1-6c69-42cd-9b76-08dc9beb70fe
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4527.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 05:37:49.7646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB4653
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] build.sh: delete outdated SKIP_IDCHECK parameter
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
Cc: ahuang12@lenovo.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Jiwei Sun <sunjw10@lenovo.com>

Commit 1accb3e03ec37 ("Makefile: Remove IDcheck.sh") removed the
parameter SKIP_IDCHECK. Remove it from build.sh and INSTALL in order
to avoid confusion.

Reviewed-by: Adrian Huang <ahuang12@lenovo.com>
Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
---
 INSTALL  | 6 ------
 build.sh | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/INSTALL b/INSTALL
index 99386bed8..dd57f6a38 100644
--- a/INSTALL
+++ b/INSTALL
@@ -55,13 +55,10 @@ in the same directory where the source files reside.
 	$ make all
 	$ make \
 	  "DESTDIR=$SYSROOT" \
-	  SKIP_IDCHECK=[0|1] \
 	  install
 
 - Specifying DESTDIR is optional, but required when installing to a non-host
   sysroot, as opposed to the host system's sysroot.
-- Specify SKIP_IDCHECK=1 if and when you don't want to modify /etc/{group,passwd}
-  on the target system's sysroot.
 
 If you get a build error, please report it to ltp@lists.linux.it with
 following information,
@@ -95,13 +92,10 @@ items which need fixing in the LTP tree.
 	  "top_srcdir=$TOP_SRCDIR" \
 	  "top_builddir=$OUT_OF_BUILD_TREE_DIR" \
 	  "DESTDIR=$SYSROOT" \
-	  SKIP_IDCHECK=[0|1]
 	  install
 
 - Specifying DESTDIR is optional, but required when installing to a non-host
   sysroot, as opposed to the host system's sysroot.
-- Specify SKIP_IDCHECK=1 if and when you don't want to modify /etc/{group,passwd}
-  on the target system's sysroot.
 
 Quick Start
 -----------
diff --git a/build.sh b/build.sh
index 1767cc21b..7bd0d3859 100755
--- a/build.sh
+++ b/build.sh
@@ -138,7 +138,7 @@ install_in_tree()
 install_out_tree()
 {
 	cd $BUILD_DIR
-	make $MAKE_OPTS_OUT_TREE DESTDIR="$prefix" SKIP_IDCHECK=1 install
+	make $MAKE_OPTS_OUT_TREE DESTDIR="$prefix" install
 }
 
 usage()
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
