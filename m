Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D31DC43334
	for <ltp@archiver.kernel.org>; Fri, 22 Jul 2022 08:35:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1C283CA0C5
	for <ltp@archiver.kernel.org>; Fri, 22 Jul 2022 10:35:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B0443C1BD8
 for <ltp@lists.linux.it>; Fri, 22 Jul 2022 10:35:38 +0200 (CEST)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8C0681000A2D
 for <ltp@lists.linux.it>; Fri, 22 Jul 2022 10:35:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1658478938; x=1690014938; h=from:to:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=DWSnW989S+gz1auHlBWjMngI+SLrlr8uNs/6OlSTji8=;
 b=V9AlvB00b2q9Z3n0nJx5J+87lNxnnRqdahJMA3AzFQbkM/cwrNi4xMmS
 qA6Qkwmqa44s0KoMCmxcKfDCtOQI33qQuqWVd8MhaEYyKjURD6vgQF19x
 wq0ffpLHusVygAXlrRADA51GnjlCH6MVoBxMa6dP9wbu3kBLU1huh+QMK
 qsD3rob6uAznr3P4L70L+Ultcc2DcxoJ7DKkjYasYbBBGA8UzK3Nc8NJg
 VdNhoUAy/W0vT/jDtTiLJxsEwrWenmfz2Zh/svO453ibBChRwKV6J2L5t
 GRszWCRuOEr0ir+ZgDlxXcg83dZudicCva33cw3wjWN2vk8qWV3EEaeoT Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="69222352"
X-IronPort-AV: E=Sophos;i="5.93,185,1654527600"; d="scan'208";a="69222352"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2022 17:35:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CumFFAvdIg+6m0KbEZm8O06mbdYKlVFDxNCDFf6ivvPoY4YnzYM6MHrl0vhxXcfH/vBcWAacFCE6/VCdYYwSEGBudtEYoNJFu7O7C8i1yy1ogCoZscK7WjGk9wFgGFrlHcXQ13ID/v5NTgfHZPFQp9up53X1fO0copFMsNnJx+E6RcjHkl5tRnx6vt54MdWuo0D3trIrza1x+PTbybNvntDnxrlAE/t/8KmuwDXHp+ay22hlwc9W8BEIltWJOLeElxlD4BaMWIYan+zQwnH5QcBRApsJHrzBVg613ulRW2Df2GW7Su5gBU8FscbsltvfYmf6uo5oEV7F3Ix7xcBUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWSnW989S+gz1auHlBWjMngI+SLrlr8uNs/6OlSTji8=;
 b=KPyS6UF4w3dNLeZnbXSVdLzOMqsAfMFFCN/YCittG/LVoq3VTAhtZpG2+XmkIg8vM4tExBWbs9rLldkKNHSxYa/kYSAx1290ETov23s8gzSJpYo6Nc1j7I6Z0wnWyRQriOCoAVtHwRi0aePeX3op/Z/sFtkXNhoddB+POcbD1dNznPOSqGV95jJYtYVj7HDOjko+CDJoCGBAH69AnXQrsskWl+wBnEqjLrQwAoov6phBamHmOA+2hAuGGW0qS5pfA1tygOgipRlN4U4P3VV/oXn57peEzqFKrTPWC0q+UlSMyI7sr1HqU39tVjJC47qv/KHU7vusF/xI5EWAyGl37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB8586.jpnprd01.prod.outlook.com (2603:1096:604:19d::6)
 by TYAPR01MB2221.jpnprd01.prod.outlook.com (2603:1096:404:5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 08:35:32 +0000
Received: from OS3PR01MB8586.jpnprd01.prod.outlook.com
 ([fe80::576:dca1:ffc6:de00]) by OS3PR01MB8586.jpnprd01.prod.outlook.com
 ([fe80::576:dca1:ffc6:de00%5]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 08:35:32 +0000
From: "chenhx.fnst@fujitsu.com" <chenhx.fnst@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH] resource_files: inline resource file for readable doc
Thread-Index: AQHYnaYBa9trGiZeiUScYe62UuOMhw==
Date: Fri, 22 Jul 2022 08:35:32 +0000
Message-ID: <20220722083529.209-1-chenhx.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61c3a517-7004-4fba-a92c-08da6bbd23eb
x-ms-traffictypediagnostic: TYAPR01MB2221:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UDbwKuTlQVee1/LNKgu51mtXMeJUucNahoYRn5N1RRgSmgdORZr9FpdJrJWOHIVMMchWTfSPKdyTk7RDQ8QHOd3n6FUj2hc09vwULSGbAe3YXRRdt+NnNMu49odzUm95sT/tgcfcXob/tLTxaiq8x9FPT57RR6Rv77LtVZlC1O6VRSG05/a6VrLBVrzDCaWyJZ7z0SLFOfVu/C3EmjvQltFippTLguvS+kaHLjFYAm4V1Uou9tHL/EfE/JkHqWdepkJOdjS7mOQHNB3ED+cvErmk/sd+v3Yigt7Y915H7LfYLVipWV/VfDrUjgGXVzJDri04hMzgyS1rQplaZWWPe+/lk+TKAAflx6Y7g8/8W6hZQip+Wi/6IfXWYl5RWqElyw9zOw7LaMN0YlZyAis124KUFEBqJLGCUj8cbO9EPHaahT75UnUxgS7fK/PEHVd2HDM/2hAkx0TDK/hJQTaCqZYGZcXcz1joqxdueCLDhM2QAp3sBnQVWUuV5swQzkvHqYiiHkdou4ztMYNu1BM+YDZ5cPzUrlrS+n0wac6awDDRZf0DkW9KPYUICDKuSuiMIo6Wt53R4XyxyTeZjNHXrwsa9qs9FX9gz3Z+hlAPT4UK9XkuUSHXhPNZqIFl7w1xlQS0MDsknxJxLuDu8kV+3vFYsI8Spjg8NfoF4sLYXpKAejIbwPzDS1fplb95p7DhSNmdJQYKE5gjpvkBHvzyr3ERltMX7GYNZFIrCSOfboPBYKszGPsf0nyWhgCgpQod7/rCEpF6e66MFzfcKKbQsAMxjgE0qQL3haFX+x/ZzJPy/S4rgkxw3jDqcyw05vJx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB8586.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(122000001)(38100700002)(82960400001)(66476007)(38070700005)(186003)(1076003)(64756008)(83380400001)(8936002)(5660300002)(66556008)(30864003)(66446008)(316002)(478600001)(2616005)(2906002)(6486002)(6916009)(41300700001)(6512007)(6506007)(66946007)(76116006)(91956017)(71200400001)(8676002)(36756003)(85182001)(86362001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZHNHMzlFL2FNWmsySmZaaG1wZzk5Y2hINldzeTZ2R0x1QlRrUklNWlVXQWtS?=
 =?gb2312?B?UFdSb0w5K3ZpTXZURkJjVTBrQ3RTdDNRV2d3c3hiaUl6TFhnQlBraVgvb3Fw?=
 =?gb2312?B?UDdkSHkrU3RSUStuclFJb1JQa2gyZ1J6ZFpuWFlycndrWmR3Y21Wd2c0aVVj?=
 =?gb2312?B?OTRvd0ZFbGJQajBaSkVTTWtObUpiU1k2OXY3V1V3OFlGSDM0Q1doVUNYNURK?=
 =?gb2312?B?cFdBQVpqQWVlUU5TM2k2KzAwN3Zwd3pqNHhEajRSN3RtazNiM29mVFFEckxD?=
 =?gb2312?B?amk3SlpuZGtZbFhLL21FZ2RZM0pza1czVG41UmNiRDlza0JQc0k2dVZqTWNh?=
 =?gb2312?B?WlNBVllER24wZGJLK1MrYU1kRE1FY1BIN2xyc3gxQTAwQWpjNHNmT0dlanBU?=
 =?gb2312?B?QndsSVMvZHRORGtHTk8yN2o0MmhCaThoTEtPcko0NDU2NHZwbTVMOXorNkRY?=
 =?gb2312?B?ZDBPVWI1M3RZdjhFMUZwMXFLM0U0QjFoTnQ2Q05uK0hScUdHd3BpZTE1MXNI?=
 =?gb2312?B?M2ZNazZCVnBWVFJRTUxrbURNMXczSi93ZnkxVWNMcWxnWGFVSHdJeTVxc2JP?=
 =?gb2312?B?YjcrUXBwTDJhODhITU9oVkNaZGZSQlVnOVZheWgrR2lhU0R0NTdNQ29sRTZn?=
 =?gb2312?B?S1BPWjdMQkpHNnIvaTlhREErT1FreDVZblFOYlJZdmZBMkQxdjNMT1ZJV2o4?=
 =?gb2312?B?WFMyWmp0N3lodSt1SmtUK0VHVTlRUlpjckE4MGRCSmdyRm5ST1FpeHZhWHpl?=
 =?gb2312?B?NnpCY0FsLzRsdTRzcGlmdno2N2RYaXIzakdEUGFXQ2JkNllrQzNxVkR0eDBl?=
 =?gb2312?B?OFdFV3VVMk5xR2czL0dsVXBUenZrckp4QXA2RmtsZmtPYllHaU9sSTk0NEEv?=
 =?gb2312?B?bmpwQk9FbnFMRXVGWFNuUmcrUnlvazF3NjRkNVk1Smx2SlBHVmdsMTFYOXJw?=
 =?gb2312?B?QjF4dGZqbkJkeFRoN1RpUnlkdG93enhBWHB5Uk5jZVpwdTNtN3VXWXBvbGJu?=
 =?gb2312?B?c2tRU2wzZjdsRWY3L0xhZFpaTVcxY05XdmFkZ2RHSGxueUtCbks3bmVuOWVU?=
 =?gb2312?B?U0Vkdkd4T3pxaG9TYW56Y2N4dElwdEhZdXltY3YrTnY2ZlNRZkIxMlZDeHJZ?=
 =?gb2312?B?OXFWK0lJT3ZvTVAvaTN3RWhWN0Zta3phaGQ0VFBpTkMrUnNKV3JVTTN6c3Fz?=
 =?gb2312?B?Qk1wdnNtb1hEcEhBWkZPMzYyWEhka0hPNUhRZmY5K0NBc1NxZWt3ZDlVVURr?=
 =?gb2312?B?V0NveXJMSWRuRFRxQVgxUnFGcEhjNjZ0elFwa0wzdmFrSjV1Q0RNNFZCN1Mr?=
 =?gb2312?B?RHNHQVpTNE9rN3NPUmc0MlVRc0J6VUowYjB1Wi9rT2wxTWwvOE0vZVI4bUdW?=
 =?gb2312?B?amhvTlFaS2N1UU9nYWRsTXNVYkxwTU5tVWZLaWJkRmhVdGhRTWhDY05JWUNR?=
 =?gb2312?B?cS92ZXpsdDFrVmhIN1lTd0tjY3FDZDE1YzdBck85MnAxdWRuakNUUERLOVVX?=
 =?gb2312?B?VGhRY1hPaytoQVJlaExJM3ZiYVpKZTNuUlg3QUw1emFUTjRtN2xVdTd6ems0?=
 =?gb2312?B?aDI2QjRuZ285SmRLVDJoZk1sK2xyaGZzWDQzcGYwTG5EUGt2a1lrK2M2cEZP?=
 =?gb2312?B?UERvdjEzUWpsWldPajFWNDhBMUd6VWFlWFdVYWtDNWFmZXRFWXZTUitCSWZp?=
 =?gb2312?B?TTNBaFNoSWo4M2l4OE5pVHQvQVRnNkJPc0Vjc1hwaWdKYlJ5dDd3L1E4Wi9P?=
 =?gb2312?B?SENTdkF3N2dybTErbXUzNWhtZDZHSENxVU5qdnMvVkNpZlJlanlzcHQzU09u?=
 =?gb2312?B?UktoYUExL1BMajUxTWFyUG1va3M3RVAvME1yQkU0cS9OMHN4d09vT2hYcFRy?=
 =?gb2312?B?VUdzR3Vuc3FzSTMwNS9wYjZTSFcyZGtGMk14b254c2Q3M0Vyc1Z1TEZoekNp?=
 =?gb2312?B?cU04dnFEWEJtT1dvbmdMbU03R1hmN2Vud2VnaGJUdzBTVTZRbHpzeEI4Kzl6?=
 =?gb2312?B?dHJlQmh6MnZxQzRyZUYzM1pQUXZwcGNYTVVIeXFwSkJpOHd3ZUZIY1Z6NTRl?=
 =?gb2312?B?c0JUbTJYV1BIVVlaVXJLdE9qdUwvamFPbG9RSTgvc0MwYXVqL1BRMGlsYUpr?=
 =?gb2312?B?SkZkdkdCY2FZYnlleTVOM09ON1lhTkNtRHFtSjAxajc5L3JVZy9vQVdiOFJu?=
 =?gb2312?B?Q1E9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8586.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c3a517-7004-4fba-a92c-08da6bbd23eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 08:35:32.1515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CkmaQ8EH0jsSpJrBvmDC8GwaQpgqHinBQh4N/RW9F+bJsTRsSIdP3Ab9IwgKXHuh9rcLKtmLXkl0/DTk6hlUPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2221
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] resource_files: inline resource file for readable doc
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

Currently from resource_files section of metadata doc, we usually get:

.resource_files  TEST_APP

or

.resource_files  resource_files

which do not help much.

This patch will inline reource file with its real name.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 testcases/kernel/containers/userns/userns06.c     |  2 +-
 testcases/kernel/syscalls/creat/creat07.c         | 10 ++++------
 testcases/kernel/syscalls/execve/execve02.c       | 10 ++++------
 testcases/kernel/syscalls/execve/execve04.c       | 10 ++++------
 testcases/kernel/syscalls/execve/execve05.c       | 10 ++++------
 testcases/kernel/syscalls/execveat/execveat01.c   | 10 ++++------
 testcases/kernel/syscalls/execveat/execveat02.c   | 10 ++++------
 testcases/kernel/syscalls/execveat/execveat03.c   | 10 ++++------
 testcases/kernel/syscalls/fanotify/fanotify03.c   | 10 ++++------
 testcases/kernel/syscalls/fanotify/fanotify10.c   | 10 ++++------
 testcases/kernel/syscalls/fanotify/fanotify12.c   | 10 ++++------
 testcases/kernel/syscalls/getrusage/getrusage03.c | 10 ++++------
 testcases/kernel/syscalls/pipe2/pipe2_02.c        | 10 ++++------
 testcases/kernel/syscalls/prctl/prctl06.c         | 10 ++++------
 14 files changed, 53 insertions(+), 79 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns06.c b/testcases/kernel/containers/userns/userns06.c
index 002c72907..9e900d94b 100644
--- a/testcases/kernel/containers/userns/userns06.c
+++ b/testcases/kernel/containers/userns/userns06.c
@@ -122,7 +122,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_checkpoints = 1,
 	.resource_files = (const char *[]) {
-		TEST_APP,
+		"userns06_capcheck",
 		NULL,
 	},
 	.needs_kconfigs = (const char *[]) {
diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index 1e9779476..327bd2ee3 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -47,14 +47,12 @@ static void verify_creat(void)
 	SAFE_WAITPID(pid, NULL, 0);
 }
 
-static const char *const resource_files[] = {
-	TEST_APP,
-	NULL,
-};
-
 static struct tst_test test = {
 	.test_all = verify_creat,
 	.needs_checkpoints = 1,
 	.forks_child = 1,
-	.resource_files = resource_files,
+	.resource_files = (const char *[]) {
+		"creat07_child",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/syscalls/execve/execve02.c b/testcases/kernel/syscalls/execve/execve02.c
index 0574f5c8b..4f43c8f0f 100644
--- a/testcases/kernel/syscalls/execve/execve02.c
+++ b/testcases/kernel/syscalls/execve/execve02.c
@@ -74,16 +74,14 @@ static void setup(void)
 	nobody_uid = pwd->pw_uid;
 }
 
-static const char *const resource_files[] = {
-	TEST_APP,
-	NULL,
-};
-
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.child_needs_reinit = 1,
 	.setup = setup,
-	.resource_files = resource_files,
+	.resource_files = (const char *[]) {
+		"execve_child",
+		NULL,
+	},
 	.test_all = verify_execve,
 };
diff --git a/testcases/kernel/syscalls/execve/execve04.c b/testcases/kernel/syscalls/execve/execve04.c
index c7b8c1614..c084af244 100644
--- a/testcases/kernel/syscalls/execve/execve04.c
+++ b/testcases/kernel/syscalls/execve/execve04.c
@@ -63,15 +63,13 @@ static void do_child(void)
 	exit(0);
 }
 
-static const char *const resource_files[] = {
-	TEST_APP,
-	NULL,
-};
-
 static struct tst_test test = {
 	.test_all = verify_execve,
 	.forks_child = 1,
 	.child_needs_reinit = 1,
 	.needs_checkpoints = 1,
-	.resource_files = resource_files,
+	.resource_files = (const char *[]) {
+		"execve_child",
+		NULL,
+	},
 };
diff --git a/testcases/kernel/syscalls/execve/execve05.c b/testcases/kernel/syscalls/execve/execve05.c
index 63bfb0fbd..252abb9c2 100644
--- a/testcases/kernel/syscalls/execve/execve05.c
+++ b/testcases/kernel/syscalls/execve/execve05.c
@@ -44,11 +44,6 @@ static int nchild = 8;
 
 static char *opt_nchild;
 
-static const char *const resource_files[] = {
-	TEST_APP,
-	NULL,
-};
-
 static void do_child(void)
 {
 	char *argv[3] = {TEST_APP, "canary", NULL};
@@ -86,6 +81,9 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.child_needs_reinit = 1,
 	.needs_checkpoints = 1,
-	.resource_files = resource_files,
+	.resource_files = (const char *[]) {
+		"execve_child",
+		NULL,
+	},
 	.setup = setup,
 };
diff --git a/testcases/kernel/syscalls/execveat/execveat01.c b/testcases/kernel/syscalls/execveat/execveat01.c
index 16d27acf6..77fd0c68e 100644
--- a/testcases/kernel/syscalls/execveat/execveat01.c
+++ b/testcases/kernel/syscalls/execveat/execveat01.c
@@ -84,13 +84,11 @@ static void cleanup(void)
 		SAFE_CLOSE(fd4);
 }
 
-static const char *const resource_files[] = {
-	TEST_APP,
-	NULL,
-};
-
 static struct tst_test test = {
-	.resource_files = resource_files,
+	.resource_files = (const char *[]) {
+		"execveat_child",
+		NULL,
+	},
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_execveat,
 	.child_needs_reinit = 1,
diff --git a/testcases/kernel/syscalls/execveat/execveat02.c b/testcases/kernel/syscalls/execveat/execveat02.c
index 9b08efb78..59c24efb3 100644
--- a/testcases/kernel/syscalls/execveat/execveat02.c
+++ b/testcases/kernel/syscalls/execveat/execveat02.c
@@ -85,11 +85,6 @@ static void setup(void)
 	fd = SAFE_OPEN(TEST_REL_APP, O_PATH);
 }
 
-static const char *const resource_files[] = {
-	TEST_APP,
-	NULL,
-};
-
 static void cleanup(void)
 {
 	if (fd > 0)
@@ -97,7 +92,10 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.resource_files = resource_files,
+	.resource_files = (const char *[]) {
+		"execveat_errno",
+		NULL,
+	},
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_execveat,
 	.child_needs_reinit = 1,
diff --git a/testcases/kernel/syscalls/execveat/execveat03.c b/testcases/kernel/syscalls/execveat/execveat03.c
index 1900c076b..bf341007e 100644
--- a/testcases/kernel/syscalls/execveat/execveat03.c
+++ b/testcases/kernel/syscalls/execveat/execveat03.c
@@ -67,11 +67,6 @@ static void setup(void)
 	check_execveat();
 }
 
-static const char *const resource_files[] = {
-	TEST_APP,
-	NULL,
-};
-
 static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
@@ -81,7 +76,10 @@ static struct tst_test test = {
 	.child_needs_reinit = 1,
 	.setup = setup,
 	.test_all = verify_execveat,
-	.resource_files = resource_files,
+	.resource_files = (const char *[]) {
+		"execveat_child",
+		NULL,
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "8db6c34f1dbc"},
 		{"linux-git", "355139a8dba4"},
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index a3b9d5c37..d663ebc32 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -337,11 +337,6 @@ static void cleanup(void)
 		SAFE_CLOSE(fd_notify);
 }
 
-static const char *const resource_files[] = {
-	TEST_APP,
-	NULL
-};
-
 static struct tst_test test = {
 	.test = test_fanotify,
 	.tcnt = ARRAY_SIZE(tcases),
@@ -351,7 +346,10 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
-	.resource_files = resource_files
+	.resource_files = (const char *[]) {
+		"fanotify_child",
+		NULL,
+	},
 };
 
 #else
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 52277d0b7..2ec28eaf6 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -633,11 +633,6 @@ static void cleanup(void)
 	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);
 }
 
-static const char *const resource_files[] = {
-	TEST_APP,
-	NULL
-};
-
 static struct tst_test test = {
 	.test = test_fanotify,
 	.tcnt = ARRAY_SIZE(tcases),
@@ -647,7 +642,10 @@ static struct tst_test test = {
 	.mntpoint = MOUNT_PATH,
 	.needs_root = 1,
 	.forks_child = 1,
-	.resource_files = resource_files,
+	.resource_files = (const char *[]) {
+		"fanotify_child",
+		NULL,
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "9bdda4e9cf2d"},
 		{"linux-git", "2f02fd3fa13e"},
diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
index 52e728e2a..8ccc67a73 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify12.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
@@ -235,11 +235,6 @@ static void do_cleanup(void)
 		SAFE_CLOSE(fd_notify);
 }
 
-static const char *const resource_files[] = {
-	TEST_APP,
-	NULL
-};
-
 static struct tst_test test = {
 	.setup = do_setup,
 	.test = do_test,
@@ -247,7 +242,10 @@ static struct tst_test test = {
 	.cleanup = do_cleanup,
 	.forks_child = 1,
 	.needs_root = 1,
-	.resource_files = resource_files
+	.resource_files = (const char *[]) {
+		"fanotify_child",
+		NULL,
+	},
 };
 #else
 	TST_TEST_TCONF("System does not contain required fanotify support");
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index 7e7a1f555..243d1b859 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -26,11 +26,6 @@
 static struct rusage ru;
 static long maxrss_init;
 
-static const char *const resource[] = {
-	TESTBIN,
-	NULL,
-};
-
 static void inherit_fork1(void)
 {
 	SAFE_GETRUSAGE(RUSAGE_SELF, &ru);
@@ -176,7 +171,10 @@ static void run(unsigned int i)
 static struct tst_test test = {
 	.forks_child = 1,
 	.child_needs_reinit = 1,
-	.resource_files = resource,
+	.resource_files = (const char *[]) {
+		"getrusage03_child",
+		NULL,
+	},
 	.min_kver = "2.6.32",
 	.min_mem_avail = 512,
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_02.c b/testcases/kernel/syscalls/pipe2/pipe2_02.c
index 9ba69667b..953e4be9d 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_02.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_02.c
@@ -54,13 +54,11 @@ static void verify_pipe2(void)
 	cleanup();
 }
 
-static const char *const resfile[] = {
-	TESTBIN,
-	NULL,
-};
-
 static struct tst_test test = {
-	.resource_files = resfile,
+	.resource_files = (const char *[]) {
+		"pipe2_02_child",
+		NULL,
+	},
 	.cleanup = cleanup,
 	.forks_child = 1,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/prctl/prctl06.c b/testcases/kernel/syscalls/prctl/prctl06.c
index 62c5a135b..f6b41b500 100644
--- a/testcases/kernel/syscalls/prctl/prctl06.c
+++ b/testcases/kernel/syscalls/prctl/prctl06.c
@@ -113,13 +113,11 @@ static void setup(void)
 		"current environment doesn't permit PR_GET/SET_NO_NEW_PRIVS");
 }
 
-static const char *const resfile[] = {
-	TESTBIN,
-	NULL,
-};
-
 static struct tst_test test = {
-	.resource_files = resfile,
+	.resource_files = (const char *[]) {
+		"prctl06_execve",
+		NULL,
+	},
 	.setup = setup,
 	.test_all = verify_prctl,
 	.forks_child = 1,
-- 
2.31.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
