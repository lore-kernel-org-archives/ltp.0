Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD305C83F21
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 09:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752571197; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=k6ScIoD/FE4uoLc6wELpEoSGwJKSStNRCQHl6Kb2fxg=;
 b=Po9HBu+Xe9R/3tp4xhhrgSTfYBMndCJNGjj7qbtUeCIHSndePCnfy7mSA9f3MQsFKaaZO
 hDIGOrFRh0jiDJqAntJP81jYLJ4tC1AwFPsD2RXqCDHOARdeo9b0Eb027pasSRNenESKxht
 b37KrIC4cTkDZzCJSmPLaLQsxJJjUAg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3867B3CCDC8
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 11:19:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B44C3CCD2F
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 11:19:35 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2072e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::72e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B66202005D3
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 11:19:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVvsbt4mlOXsLA5WdZrbXsntUFZXuSF+MRmd+1zTBtJZNRTuZ2AXIaqU5AY37RE6ygSMjsNGbFB39cDL4uue7s4KQwcQBcu668eO35Uyhvqfuu7y9hraziwYEs4Tv507dZX1qlzUjO4oG3nv+3L2xIBUIkRcMNTKPicC6vbpO5Jl2hO7ug+QNpEHnc6Xt2Z2avabzCj6j7qq7iJ05jOJrRphFk0QUzrPKr0oY3UmJmAM5Et1iuWsqfClNLtcbJYNeH9ontx2kbHUR0spjaabicSTK9qHg0v3qXZzc78u1nOlUtrPhV+HAQ4oDJV0VWvtcgzkB3I3OOEvPDK7Aw7QqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNsN74itCWRoi5e+vfEQvP8zmQ/OPlXsoLDFDUVODJc=;
 b=lzyX9sqG3cbTbopiJyGu9qNcR7FDkAeck4JVz1iC1GGBI71TUpO4GLHj+ag+XjQEtlPuFZbnBgA1IeSv0vDMFQ2/jenLLUE+tVaRGlBp97cKw6eH9QWxLl8ZJWV0kD94c2s4k2En5IQ1CeSJ83RZd2mzXcQjt5C8g5dgS+s6AZ0eL9qxTO0b4jh3un+Hmdbe3YADHYJx8GU60o7wA0rS4HkIXljJzuxm/lG2EvmvXEFFXCjP77H2uw5cHasRUvsd5e4vFdS2yF3QffmaV7QNJdMeBuoP2blZ71JNwhh9Jc0yFlAPi63Zh3QMMc2En5vtlr5pe8Ni4BkwrA2ontCeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNsN74itCWRoi5e+vfEQvP8zmQ/OPlXsoLDFDUVODJc=;
 b=IT5EINOmsMtK0JLZcMemZW+GAcNlp64A0B8XTa5wPlEbFx2rK2tGV+iVY+WsiaM7m+3JwZH60Vkbeba6nFh30pPed3rTDhqEHJZqaMShSiAVdo3G00zGbl89yUPzjo/yHB3WHtM4iW7tn8Okxi4Mk0Ci1XZnRiQ8Qishw5bvwaFExn0n5iMgJRC1oyxmYB5b7W3ZZbRNdKSEHerVE9F1Ik+guArXEP03l5jyrIV2Yeg3aNZCBpltfuJHdLD+uomIAiEh+loCLEJkplez83rjE466EEpkwswqDjZiEiLz2T6IJKSbc0HoFIFHVX51Ac4TYA8xozb41xDW6fj4fLRVSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by DU0P192MB1452.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:344::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.15; Tue, 15 Jul
 2025 09:19:33 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443%5]) with mapi id 15.20.8943.012; Tue, 15 Jul 2025
 09:19:33 +0000
To: ltp@lists.linux.it
Date: Tue, 15 Jul 2025 11:19:31 +0200
Message-ID: <20250715091931.505865-1-florian.schmaus@codasip.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <aHWsnL8bUYkTJt21@MiWiFi-CR6608-srv>
References: <aHWsnL8bUYkTJt21@MiWiFi-CR6608-srv>
X-ClientProxiedBy: FR4P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::8) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|DU0P192MB1452:EE_
X-MS-Office365-Filtering-Correlation-Id: ccdb968a-64e3-4bf6-c8e7-08ddc380b5d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pNNkfyhTapkL93jVDm5zvgxqCyaehksi8QCu0+5EKNvcIDt0F73Igdo3pgxo?=
 =?us-ascii?Q?dBhI9SfL4Nh6lW7PVMEUekEmzqreWmZeq+mvnsnWwvpmbo9ucKtETAS1dEBz?=
 =?us-ascii?Q?SA8QzoySQ1e0oCP2Dc7pJQlcmZknFZIud0njV4Kjp0TOMje9sK4qRg32Plhd?=
 =?us-ascii?Q?HiE206A9XIKYhei7mqPaazUlbcf+fDpgDqFgyYYmSdc0VS0DJzJbvqTQzHQO?=
 =?us-ascii?Q?0lRpX12i6KBxdxDx+XcN5QJgZEwh2qrQq68U2BuwZT+XlisKeOqSo2VnDhxc?=
 =?us-ascii?Q?WUeFLJSim1eiUkTvWFU+74DKvT29FSXT09SfztckbhANU6VGMcFWwbRcqMQE?=
 =?us-ascii?Q?Ly1RI/Muc/jb6+Y7N5TgwO0Jf0tY9/Ly5zi5n5RurYyTKjsyMpLhQEhPLgZD?=
 =?us-ascii?Q?OtdHkyGDzZDNSgnJXPgazQVE20VGmw5EA47Qv0ySre6BMgts05RZldKByhwU?=
 =?us-ascii?Q?tW6Re1u0CB74BOdQmY7e4upTndlmLdFYCTMvbbu4VW5jcI+pvIRFPSpm7vNb?=
 =?us-ascii?Q?617Te/+/MmDIfMgKGC7qpctaT88wUdI8QM2d6FSsV+CXHzYIbcjGCoBcYGKn?=
 =?us-ascii?Q?hzkh5UA/iEVvLzxobcYurN0d4LVdKQfKMCOcMrbzyM44874jylY1oeV8/GOG?=
 =?us-ascii?Q?DBYE0PCuHbVYaDVJtD0/ck2kQMzN+ZNU1vltccVK8+Bb8j1xCQd/r/0SApU1?=
 =?us-ascii?Q?5qMwdvPL8wtzjOXRLeCAmZGco/yhgSS4RDEdbZDpvK1z/k83NeFUPyr0EVOv?=
 =?us-ascii?Q?Hk72n5hlHipxUSX67Mllw9wkYXGfLJ+LFdp8Qy+x8spVfHLFlgPsxPznD5QZ?=
 =?us-ascii?Q?Mf05qZjmPSq5s9s+TB1cITmrUF+ilRZLbBVzlgEaDwt2Jq1MB9aY6bjZsP+f?=
 =?us-ascii?Q?lXSIT3s5rD3uG/9rEJHD/tZiqA6iTeeRm0rduz+P8MX/Rf0nBtd7Om3ijD73?=
 =?us-ascii?Q?dbENmbMt7qWeSKyVOQiULbpuCjIWqS0W3W19Jh3i0LcwavGAh2be6bQHIUtP?=
 =?us-ascii?Q?jpaXSH6dkiNePwncHBOIBjKXum8z7K5HYuaSk8wfU9mYFcRKWTxHKoGWPKyQ?=
 =?us-ascii?Q?/rsubhJVHOlE5Xb3BIob/JoFLyjvsYWyrlOfwe+uHoo2ZckWjGPYyPcKfu2v?=
 =?us-ascii?Q?M9J9FoycEQmXYbnU9QmNjsIPa7azkwIhbxEQUy+siQhEP+26scJrBK2eHp7l?=
 =?us-ascii?Q?XTQ0WBrBqqfASW8XS+FRXAiElFfUvTqPCG5tzAz97KUJxIo405EDZ3ikdavj?=
 =?us-ascii?Q?BQd/Dai7rzcZIuVCwdwptnwxe/iZuD4oI+SQ7kFLkQ0HAfPJzZzStP//3rJT?=
 =?us-ascii?Q?iJyhwXXYZyGzRdqVPedZI1Tdm38K/Rzn2RhMwIPUXKEXfhMCOg0rYM5ZcqC4?=
 =?us-ascii?Q?Ao5UZbBo8dhX/lI2rBAt5xiwMVkZwUAtbJM9vKoWGKUgrl1w/Re13rqHsDy8?=
 =?us-ascii?Q?imzTNjOhfXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UHANwOoPl3hdYhQqWIyKgGQf+R2xziFK3J9n9sW9RU2It7bt5HITza+T0lXh?=
 =?us-ascii?Q?xRASTR7GJK6fBXW5muad3eyYV7iOVJwIAMQpBcCEivMgSn5xhAUqCu0qcdwE?=
 =?us-ascii?Q?2wfQJ42NgJ+kVliMa7n6JnJ5kUkgs2l3gE+N6NEhQFbW/S/jyBnm82T6gMGp?=
 =?us-ascii?Q?QIbB+oA55GrwS8ul0v6GHNvMVbYGFJF80fskVl3MH3MtsdMJLPAySkL6FhnV?=
 =?us-ascii?Q?a4uOtnCjd/yyFmoJZIzMJK4J0FW2JTatdJvI8/GbRbM837yLLcYh8SZ+I9A7?=
 =?us-ascii?Q?0FC6XMHn3PFS2VpA5osFPLxlG52BDW3RIPumX4eIB5hCz/jEQufYGEASj53i?=
 =?us-ascii?Q?sj/Vh3jUoJjdMB6iPINgVNPMdiFMSfx8LG1JhFpsx7nw/XlNpFw3Fh4jNZbY?=
 =?us-ascii?Q?E522AUD5GE8aE8NuwNEjYzMh72o7+bfX8xu+z/iZR9n6/W087a7aA0PHc2+E?=
 =?us-ascii?Q?tB4h40WWRkP2ohnr7jfoyF9nPnON8rkpaFR1Jf2bDcrxJpiTmqV8OYFLxFGL?=
 =?us-ascii?Q?S9cgQVzxs0TnQ9IOu+UFpXvZcPEeafv035yRUrDoOfxVy4Z7UmJVwzoOvsoG?=
 =?us-ascii?Q?AheJIgiGAwdzVTxksb0xEAup+7UH5C2bzhBSk5AGimGrq/10qBT3YjnVj8fR?=
 =?us-ascii?Q?G8FhruCPop+1X5tX2nAkljb8nDkz+N8C/cJIe7DDW8vfOlHTZsIIdhThccVM?=
 =?us-ascii?Q?vhKpnB4b1i92Fv1MQDshCVZw2y4ZgD4El+a/8SuHhP1zNfAI+0nFkCI7y3Zr?=
 =?us-ascii?Q?DNLul1l/7YX5sMaqTICpUF0/xJpNH2Echb3d0p/HznLtZJ6VDKeX3MaeoUxU?=
 =?us-ascii?Q?Mv4PsncdlSFEQ9ulvG6E4a/GYW2dlQDxMjobahfXUMMk2FUUOfK5aMvbNdNN?=
 =?us-ascii?Q?1TeCy9vnRBhSTWms/htppHlnQgPL69TDAEIn7w2LxR43VxXWjdFU/zTzPf0P?=
 =?us-ascii?Q?fQhF1HsnMYBL09bvlHtOwrukLaKh5q76oOGpsF4FvBvdiCb0mBWbmcUGhLLT?=
 =?us-ascii?Q?GYIM8RcmFzpIFkrtm4zj0SUQUP066y2KJKtnvZWQoODp3e+0HtCTGn/L24Gz?=
 =?us-ascii?Q?8RFzwsEEmBA7nVk31FRlnsXqjx0ZxFw6YWwGnpqq0KZg+VdvVLpnZFhPkSwl?=
 =?us-ascii?Q?cs5T1rjZftqjkfDsnoMEYWCl1Hn55Vh01Qeu0+lxzsddhqhUv5cXseV4h6P5?=
 =?us-ascii?Q?m703vl4idb2kfv+cM1Ik1hkr8qcfMMwovIin1JwLpOKJyhIjg8SWqUh7F0db?=
 =?us-ascii?Q?mR49/8w8Oh76AHZpFzYtEzyOl56jzxMFZ0SKHHIQenKXfNg8mU3/flxTdUQz?=
 =?us-ascii?Q?FsAFi3sfWt6dJHXwU8AAEspgit7HPFTmw9gbNqvz/rRDW4JWLD4+ZMeNdB+c?=
 =?us-ascii?Q?kam+4J0iMwiIlfSgzTo8uK0Jvly0oGON2Dh4FfU+idoFBLws9WgYKgqYtKQI?=
 =?us-ascii?Q?JkGszpnhWxNjg87qJBv6ci1nupZzgPo4WYub6jpcqBsm/Yi4i/vxQNngRwrf?=
 =?us-ascii?Q?fje3dqQVWKOYRYQPfou7z2WHxbpNt+oH1vPSQfieKUebOQQQL4Wbuxr7Z0Bb?=
 =?us-ascii?Q?8FWxurk8W4eYKR6lO8sEDRyYbt6q6QKNevpDaCmu2S7hRSiqI7ryrf/sTGfp?=
 =?us-ascii?Q?vDJD6xzpyueNOPfZZ0J+J3kp2TDpxcQZuD3IeT8i/u0oNE5tcy5RR9haH1WB?=
 =?us-ascii?Q?TExn8Q=3D=3D?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdb968a-64e3-4bf6-c8e7-08ddc380b5d5
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:19:33.1156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4HGkSiAqCnM5czpW7awg0y2iu4/3eEgiagDyX9Sm6DrwR/YUyx0thiKsBeJBJbEEq881BX8MpEWqTaJkKECHrqJhRJ6GMQ6AAUV01/K8F8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1452
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify22: Make 'dev' the last debugfs argument for
 musl compat
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
From: Florian Schmaus via ltp <ltp@lists.linux.it>
Reply-To: Florian Schmaus <florian.schmaus@codasip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The debugfs(8) man page specifies that the device to operate on should
be the last argument. So instead of

debugfs -w /dev/loop2 -R "sif internal_dir/bad_dir mode 0xff"

the correct command line invocation would be

debugfs -w -R "sif internal_dir/bad_dir mode 0xff" /dev/loop2

The former works on glibc-based systems, due to glibc's optind
handling. However, it breaks on musl-based systems, where the
fanotify22 test will hang because debugfs is awaiting user input.

Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
---
 testcases/kernel/syscalls/fanotify/fanotify22.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index 20c7a6aca243..357e74dbc702 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -61,7 +61,7 @@ static void trigger_fs_abort(void)
 
 static void do_debugfs_request(const char *dev, char *request)
 {
-	const char *const cmd[] = {"debugfs", "-w", dev, "-R", request, NULL};
+	const char *const cmd[] = {"debugfs", "-w", "-R", request, dev, NULL};
 
 	SAFE_CMD(cmd, NULL, NULL);
 }
-- 
2.49.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
