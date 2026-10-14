Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4012CC6B1A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 07:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791962284; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=KlKLUmuHGPppoMz3Bx4p4i+lvNx6FCB727ZsJeVrSuo=;
 b=axK6t17gjuOxwQOOSCrWqwKU3i8wMHRalbjdbsLQhDIGREv0mh2SbgEqFe63g4/q0XHZb
 82m7w0/ONRIJ+fzGha9VECvhOiBASzIyj9kMdgUAHed1oc/4LLFUERPg6MkfKUabqkm3yGP
 es5JENnf90y7uiDku6zMIih+vxxfCxQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 388E03E2B4D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 09:18:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 227943E2B4B
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 09:17:44 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4E00A2009F7
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 09:17:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVhB29s77kd4N6uCCzkruDdH2hMzrD55RaQERlL19cYOB3H//QmzXVS9gCzz0SeKEDJn2qInsfqff4SjRCAvh+xj+jjuP4e7p3hHVxr1HfgabdUVDchvhSpFUhq3PmfspTJndWEjW03VsWPlkPNVGwTyKN2AgsCRLsSNsN12VhcWcrwUNBNx1mmW20CNkhrF0V3tqMN5aQ4xPQwdwhZaADpAIsdEQejASa5pHzi5dnaro7sXD+HYN+2X1gTW6cJCrRxLPeIH/C0TZn55HqkF7hJWgLSbCpY0rhUKgeXOyvkn17Ry1Ao6SoUp/mKl5kB9fjH3Xz79+8UlCnprmkeBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4YUN2raPMX4MCMjZd14yktYLuxtyhqHrFuCLwf1ARU=;
 b=Vgev9cgoj54CNpW43x/pbMQKA4H0xa/bvcuJT7Ayajk9M1Aaa2C3luJ9pQs7E1XBjYOgzib4LgtNzd7OZxeaVuua0wV/IKIC9WUd4FeTYndhf/f2lFv3ECcTRZKueDd+iUrzmESo13vXsobtWIPwfiS/EjbS0DQ3HrBl8PUYpbYZfMDjG+3qhdtmNJ6QLJUDDtWHP6ZowqkLkaOF+pyKkxWz3qdg3Qz9RHGpeIG1IDhMIh3X7j9Z430ZVsVRHCyc5bu3IfSpw90nJZBx/8V3pwdjOVdsmylGUfGWRBVuk4DEptv+C2BXI9TXD+kBr7fWBXU+EEZAV6S57mAlvh5Viw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4YUN2raPMX4MCMjZd14yktYLuxtyhqHrFuCLwf1ARU=;
 b=BMiUx6ZKDfyVO2LCY/wRww0FBaFKbOzYXx020LbZGYCxR6HFb5yO5Dd1VAQwiOiLidBcp2JDoiZapfYGzZCCiy9eVfOT3glhtNznhDf//KIcGvWtjX0XRysv2aGNbCCeCDmJ7aIvqrfwpUYMz+K/4rrj7d//DJeCSY6vNVmCmfpb87vpkWhYueqqLQenBtx1qm1f53BzjZ5NRLLVcFjWf7mRqHvOFg3DLGyDG/pqDAYidHSMco1gHswzlwZtnfXAj+SlSALFXI4eQ8b++txzdgCRciTK3eDUeraPuLovsUdynlkywE9zKtHDZLTF09aJNKsdg5hESnroEaZZNO/NJg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by DU4P192MB2422.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:575::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 07:17:40 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0e5:8465:302:9a9c]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0e5:8465:302:9a9c%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 07:17:40 +0000
To: ltp@lists.linux.it
Date: Wed, 14 Oct 2026 09:17:34 +0200
Message-ID: <20261014071734.450957-1-florian.schmaus@codasip.com>
X-Mailer: git-send-email 2.55.0
X-ClientProxiedBy: FR4P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::17) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|DU4P192MB2422:EE_
X-MS-Office365-Filtering-Correlation-Id: 3502e92c-7bdf-4fda-af79-08df29c33bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|23010399003|366016|6133799003|10067099003|18002099003|260925022911599003|260925021311599003|260925021911599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: CZZ5bEKwvunEnPf6UcNVylmjzbkm2PHOHAnuJ6R9nsssZbmA/phPQXhE+3cavmgJfF+LwJAN3OZHBu9mVmsyhKgvACI+imlsqLybQ5b8jz/SUe3/2/YzhGSCiMBoGSlg1SzEtex+MkYmgmyx3Wuka/7JTOpAfFokDY5jJuODlxxx7AOBIpfJy6Jb+PEJKkY+lG/ojTzMbhLlXZYKljJkfUFbGog9tDZ1l2uIBoGQcC1n+LYogAIqBg93Wmv1PQbZwoSQFfcCVRJmw/6gBa2HH57gGPctU2Ek3DKCWU8TQZFOQWFPbe71WRV+UMH7X41e5nBVmLENxa0K6duMHjdTHc+NVT1HI9ZZG49HwVKdk3pmXcLYxQSRxXBdI1zufIYJOY+eIKzla51qj3boJbcDg+8SdE7x0OakZTw74ZH512XStuvgo1Y6Ajj0ZkGYG9KmFPGCQ6dzZntd+6tojQXfp/2F+mjOfCoIk5IXWYCoutpKrxuu2j9QjBUkJPdJGEdwldb4rhvDIijAf1KFCOGGrrqFJ8GpeYSvlAIZoMmZ6FqPaCLXgcQ5VVbgl1rFycQNSMIUl1zIsNLF78gNZPky7T/TLQLfNgaga2G1UTtKw7MXFF3Efs/oJZW8nNAtCqjZcTQqvcEu34BdhVt2RgH0XRUAzSsTBiGyzm1zoNy6aqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(23010399003)(366016)(6133799003)(10067099003)(18002099003)(260925022911599003)(260925021311599003)(260925021911599003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vt+RpET25EQUpvAw6H6/78QY0lGWiOWRUu9vVcNSrrXrCGdTRTTdvUYNBzsG?=
 =?us-ascii?Q?Gpw6VUBWJi2X6N3VWKTav0CXKwPtjchUCv7pa2pCU3vaLGhk9Hee9AdxT3S8?=
 =?us-ascii?Q?CEoa0b/xRSH+L6xKAkZaSuNRrz/lufseu+2LJ3ELr8fE+pnBieeaJmqdgub9?=
 =?us-ascii?Q?acycIEhHeMp1x+aQaECSh48qi9r796+/OV9usCMspF1k6kzQHfcXpTyo+8d1?=
 =?us-ascii?Q?tbaP3Kaaurc6NNI1yk2OSW1H3WWWtSgooK2g6QZBiaIt6fhYqDDU1T5RcN0E?=
 =?us-ascii?Q?PFyGqolEWaRLcJ8HHlwFZNVKgaAh7xRHOgfdLrZ/aFk+sXECvW6+aSsO6pWi?=
 =?us-ascii?Q?HTF4f8KpCRPPLDlnDbK4YNRCrSsLZO9PNxoDAqazJYHnQpgGUF8HOJ1evrak?=
 =?us-ascii?Q?j6wgta/DnGquAHTfiFHjm4I6vvKYw7DUVpQFBWz2g9qfRaF8WZkilZz4Rig5?=
 =?us-ascii?Q?EZey/CdIEso6yJBrC3GcC/ZE+tNjilNYd1VF/bgPEY+iYAor8oOytZvs8V0y?=
 =?us-ascii?Q?Zcrxiy32X9EoKf/fBiIjsG7z9BUXnNa1pcR2oZmgQ0C3/lCa2yGMUogIzyl/?=
 =?us-ascii?Q?FC4EoIFJaUyV+s1Wv99yMQITlI3y7cHPv21c9iPsKSgypPUE01y2Dqo/Fs8n?=
 =?us-ascii?Q?KyC1ojAzwFZV+KrIRvzERpSECX/BQlI9i3eluK8G/TTQ+65VqGok2PBRZfr4?=
 =?us-ascii?Q?C0iwVkUrz8LRGIFXGWWJsAY8kKYdVLh4Z8v0M1tEu6g82fZno7XCC6U6FBGV?=
 =?us-ascii?Q?p4EBKvtISCQvjB3Nl8GVqE4lEljwFizuZB5VcQ+on8cTTjKnnPD0bZddkMhM?=
 =?us-ascii?Q?S3DcC0JLNa92Vu2/OWj1IhyURUag3MmnuncbXGS2ijyUDik8ei61MWrL45Fy?=
 =?us-ascii?Q?3hlFPHXfeH/e2LkdGfDiyBy5GW5RpeofcQMazZmIwIMrFB9V8s3Sm+t7n5vi?=
 =?us-ascii?Q?oHhb5PfaYrf1kfmP9VExmqxwR02f4tJ3sA4pN6iIB3GI/5TC7ULGGmwlyQfz?=
 =?us-ascii?Q?D7uaPNt1GKihh0pQ7e761EPyW/S/+YzQDJzKOQ/sZwDSH88GIq/CzJa0GQ8b?=
 =?us-ascii?Q?1/WH6TXr9UiIQEYkZAVsgB7/ibSa2174h3Qa+i/T/n7/fa+22bpIRaPvZhLg?=
 =?us-ascii?Q?goYl2JVqakzKvNObn4Tkjm5Y9RlkFNG0mcF3oRBGTm2J4+mRKXW6RMKMQdm1?=
 =?us-ascii?Q?sI68p/F81Oo5d28dZyb/STmQ5OPyaGtFjTWJ7w4PbuuWZfU9oFx7OHyOWnue?=
 =?us-ascii?Q?1d6RvT904TJH9Wli/FB+ZJOu4XJ/fTGl9bP1PcQvHeEVGOtW2eOkLKEyM5+a?=
 =?us-ascii?Q?dVaKvNE9/TWsjJKWydZ6iqd7X50q/lq21o50rMq4GqLJ1iPB4gre6sZU2LQd?=
 =?us-ascii?Q?Aui18hiTgOihwhJApI3oop1exvcveySNncZeEa1ozaja5442WdIuI76htBxm?=
 =?us-ascii?Q?LzNRE8UknC+43/thAzky2MSxxQPJWKUP9RKeUN0RHdSb1DUZbNUibDff0b/b?=
 =?us-ascii?Q?TjP9DfNKrvmyb8wIj/tx3csSYtDOQB37p38o6mLkB3dpakOVw4b/McWNBrfR?=
 =?us-ascii?Q?ev9hvUYcogaBIngrWb3iQR1+cJIdY+lD9QHIDTSe2NZ31fOZquzCXuFzkt+p?=
 =?us-ascii?Q?NjKg0HgWLj12P3ioqI9l9ru7fi1Z7dnKMQwP+1GPGBEpgbA9ChsX6MI5aRM1?=
 =?us-ascii?Q?80E8hEZBwNzLhABeCwKEn+Z3ustLyQsYFXjoQrP4y3vnV+c1cveiSj+MEoZY?=
 =?us-ascii?Q?zZxO56bswWd000ADk+Jt6gepUn9RgpZgP0XZ3s+lzWAswOaaJPYD5EkeUyIk?=
X-MS-Exchange-AntiSpam-MessageData-1: Gy26Qy3wlag28p1RrLlP9KXxugn9YSy/YO8=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3502e92c-7bdf-4fda-af79-08df29c33bb2
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:17:40.7992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sT8s2uo/F6DzpsJZmJlqEhl8ifA6sTbbzOWjAYC3pM8SmTNw68BLlVoJZVyz/PzjUjllFauNcMsTiXaUjF+jc5NVEYv3VMFQnROw4kAAeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P192MB2422
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] keyctl05: Use DNS_LOOKUP_GOOD to avoid
 false-negatives due to EKEYEXPIRED
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

In keyctl05, test_update_nonupdatable() verifies that
keyctl(KEYCTL_UPDATE) fails with EOPNOTSUPP on key types without an
->update() method (such as 'dns_resolver').

Commit 4e9400050683 ("keyctl05: Improve the dns_res_payload for boundary
testing") changed the dns_res_payload to a 6-byte V1 server-list header:
    { 0x00, 0x00, 0x01, 0xff, 0x00, 0x00 }

Byte 4 represents the lookup status (enum dns_lookup_status). Setting it
to 0x00 (DNS_LOOKUP_NOT_DONE) causes the kernel's dns_resolver_preparse()
(net/dns_resolver/dns_key.c) to treat it as a failed lookup:
    if ((v1->status != DNS_LOOKUP_GOOD &&
         v1->status != DNS_LOOKUP_GOOD_WITH_BAD)) {
        if (prep->expiry == TIME64_MAX)
            prep->expiry = ktime_get_real_seconds() + 1;
    }

This sets an aggressive 1-second expiration on the key. On slower
environments, such as QEMU, more than 1 second may elapse between
add_key() and keyctl(KEYCTL_UPDATE), causing the update call in
test_update_nonupdatable() to fail with EKEYEXPIRED (127) rather than
EOPNOTSUPP:
    keyctl05.c:143: TFAIL: updating 'dns_resolver' key unexpectedly failed: EKEYEXPIRED (127)

Set status (byte 4) in dns_res_payload to 0x01 (DNS_LOOKUP_GOOD) so
that the kernel does not set a 1-second negative expiry, while still
retaining the 6-byte boundary payload check for commit acc657692aed.

Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
---
 testcases/kernel/syscalls/keyctl/keyctl05.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
index abc881628678..45f25fa7d366 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl05.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
@@ -208,8 +208,13 @@ static void do_test(unsigned int i)
 	 * the incoming data for add_key() sysdall should be not less than 6
 	 * bytes, because struct dns_server_list_v1_header is 6 bytes.
 	 * The minimum payload will be tested here for boundary testing.
+	 *
+	 * Set status (byte 4) to 0x01 (DNS_LOOKUP_GOOD) so the kernel does
+	 * not treat it as a failed lookup and set a 1s expiry (prep->expiry
+	 * = now + 1), which causes keyctl_update() to fail with EKEYEXPIRED
+	 * on slow systems (e.g., QEMU).
 	 */
-	static char dns_res_payload[] = { 0x00, 0x00, 0x01, 0xff, 0x00, 0x00 };
+	static char dns_res_payload[] = { 0x00, 0x00, 0x01, 0xff, 0x01, 0x00 };
 
 	switch (i) {
 	case 0:
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
