Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E331C25B75
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 11:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717673617; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=mPULUp7VJ/fDoB5J3y7Fj5yfFDsm2r+uOWbrxHApEJQ=;
 b=khZbTrKfP12oKCGkU3Mx8U6aGO3gm1EmQoa/o9TI8FCC244utY74ze/iWEJWg3oUepHs/
 813BIgnC2YM+aJkB1aLMMjDztWghN7X3xmj2Uq0YJ9hWhAgMVKdzK9LK8N3UJBnZIcDUCV7
 Jz+fq6k2rNlPzBQNLY13bipZajYWrbY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F23D03D0A49
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 13:33:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CD253CE32A
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 13:33:13 +0200 (CEST)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feae::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 536431000F25
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 13:33:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTcHM5/ZppbRmstABoFv2YTN3IreX6zAWp6RsD5hzJEHp5XAhCUF52IlZUNPSzyx9dYP0Oq7aGFCHWLwx32yluemMvik1X95ONCoaryNFGYXfCGkBlh/mEJcFrpVEb7kuMm+EHtxHVBpMpbNmF3Ce3oUoucCJEraAyEi30dxTqcU1s8RAA80/oveS4pDIJVj+V7Lz8qdwE09yXHIMsIAbYuyxcqS8tVpzGK/WV3vYe7/2Oqk3ubpLJ4ucEMC2sulWl+g8sA7sn7M8vKj4CzVAOCtipbr7MkRE8QMynfHqHCNIXuYkdZwSlW0W0eQy3uU2A8h4yJLHwcko+AWs4WoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jp4gio2m7dIx60Q+q4kuSgrgLEKnbxsQKAtWjd/yHGQ=;
 b=dJ8FeRcpJ4ol2iYo1HgDvtS/TnqwPlHQWjKh1ICcRvwSLuNLNn4LxytbhzZPGMfkhMQKXjElul4EhuiF1S4DW4NSOW6S69m3/Folzw6J4cNn7YVh+OeZrGdR5T9LsoqKeVd8qFDVpU6++sI82LHWNWDTMMtnt287XBj1GbyJ58bHD+rwTHH5AzlJvjRMqRkNkUwuBcozpgAwXVnM4w16A2Ksfl45YRL4dcPWqpwPZlhB93nMgt+Qv/b4atrcflPbqlbOmK8YV/82vT+afReI+18jwX3dZxot3syJwi4PAxeQJ7DN3xU9x+jZeJ/VoCdeDj0aEfEDVk6Idi8E2Kv5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=lists.linux.it smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp4gio2m7dIx60Q+q4kuSgrgLEKnbxsQKAtWjd/yHGQ=;
 b=IQDHi4cPpZUahVT3DKqqNQA0eN19+LE+xk0vIzJ4/CNMkTWUvX0cr0p62p8y75e0M0FgljWOAWQZFQFzqyIFpWmCibdo5upiidKoUM0jTtZJbgQs5zHwOggWMZe+CjNqKB2GLzlXLZ93WC/kYxtpxOxuLnYkFyQUe+9xlQh43yg=
Received: from SG2PR06CA0215.apcprd06.prod.outlook.com (2603:1096:4:68::23) by
 JH0PR02MB6424.apcprd02.prod.outlook.com (2603:1096:990:c::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.33; Thu, 6 Jun 2024 11:33:08 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:68:cafe::e7) by SG2PR06CA0215.outlook.office365.com
 (2603:1096:4:68::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 11:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 11:33:06 +0000
Received: from WorkStation.adc.com (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Jun
 2024 19:33:05 +0800
To: <ltp@lists.linux.it>
Date: Thu, 6 Jun 2024 19:32:43 +0800
Message-ID: <20240606113243.19768-1-xufeifei1@oppo.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [172.16.40.118]
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|JH0PR02MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 547fbe1c-2886-4562-453a-08dc861c6f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QmWPsom6VBSgqVbPINI/aEAx4sGlaOz1PSx8EIsvZorHBbtJqry129soN0li?=
 =?us-ascii?Q?uUm/fw+diDz8a1b6MSahNEVrQIBssoGOjkK493P57FGJipJoSDYbsQAo0XYX?=
 =?us-ascii?Q?M0xvPjpkq7OrvPjireG4QsHi74x56gFiCYh+fwENOSqSnofo2qcX/tUQQuT1?=
 =?us-ascii?Q?e2PqQIznrFGbbhqVoWsybo26dOepJYt3xs9zOqRQ5HAuNs8TUpNUb4L+YJn/?=
 =?us-ascii?Q?sqXSyozj+ZYNe9Sre5J+vg/OQu1h+LdqwdfHCu4OvWFbCMTMT5mvilHISBAW?=
 =?us-ascii?Q?8cUSA4jrZMwP1UQfBnkSm1BXfpR6J9a0je549yZ8i6FXMmYkM0MzbiyIggkt?=
 =?us-ascii?Q?oUqbEEEv9INGFSGPc0IauGDtUtoye3jH0wh/zAfBnbCWxIeMBxxdQuUxk8th?=
 =?us-ascii?Q?bGvqvFeLQr5Ge7NeSxDBNGQ7SaT77mvCImHSuqkQ5vw03UZHmtyY+5sROuio?=
 =?us-ascii?Q?WBYopdCPJHssSy/0w+O47BUSAsOK7CnCzpQlg27myeG8QyvIbHcokuhNH3Sx?=
 =?us-ascii?Q?x7uhVUbTTJ8pwrwfLp0jYTYgn7zPqsOFJigiMM2UYrlNCeZ+ZcZ78URsmsHt?=
 =?us-ascii?Q?4ECC14pI+FZ0tZNbhlgbSf1YdtcqstocGJWy2imo+zlRq0kGd4dDOR7efLAE?=
 =?us-ascii?Q?9Vnr7+WAwGy62gU4brO9z9+QTV3L8hjPLOSicyRyKXRWgOMsbnXnsox0Uf/j?=
 =?us-ascii?Q?pfTsUy02R+rIGj5+CHHOoynMaPlLyc9Or9kOY7zOTUt8DvMbTvCVoNsUCgjv?=
 =?us-ascii?Q?LRG1PYQ0SvBvKvdIWoJbvxLomnBfhGbT69J+uPJuzXOxnzkQrRw3lhi2CmvB?=
 =?us-ascii?Q?afyHC1Pgw/bD3StbM/6bRUWW1Zowhh95Ubjcj22VpxBEdNdlsrjmnaItM+xe?=
 =?us-ascii?Q?H1m/HGyK/RyKxgLNIVv3RIMIBkOl62WtseCUhHX1r7W2l8k9XL0cctfTuo58?=
 =?us-ascii?Q?msTpOROJ/LnWoSaBpDQixWNyiRugghuYStkJzbHb9wyU7OYS3evEm5F1m0bW?=
 =?us-ascii?Q?VWmQr5imfFFt8Fdq63Q8pLOz/O2OvOc9/NATUoCHPvAJZocNKp48ApThXLs9?=
 =?us-ascii?Q?W6emIUjj3bn/vT81SrduXgu4rGoqUaTCA2rz4l9Gqvf50e8S/xTFsaw+ns3T?=
 =?us-ascii?Q?16QKyUXay3ZFIHjt+TS35gmmFwkyE1ykPFcm5F9R/wgUu+kukygfplSvOtW8?=
 =?us-ascii?Q?Uoz6+Uabz9hyf94QYbWYNklKqaW5QI5LvipywTPKxRNREKX326moMNGp15H8?=
 =?us-ascii?Q?9GKANy25iq9vPLo2VbE5IkF4Hw6XFNp2CF4ROmszBPK3Bx+ngymGNjOCX1gt?=
 =?us-ascii?Q?kAZAkqHf38ImMDOlaDgmZUC2v5FQBX9U3Z8dGfMGWJzO7flhpiU06PGdXuW4?=
 =?us-ascii?Q?M7v2sYFaQwTQGZz/HbE4tWFJWEmem4ic+4XiZCUU1GHX3g+7FQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:58.252.5.68; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.oppo.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 11:33:06.7762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 547fbe1c-2886-4562-453a-08dc861c6f90
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6; Ip=[58.252.5.68];
 Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6424
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Different hardware always has different performance,
 and we cannot assume that platform performance is always above a
 certain standard. please consider change the threshold so it can easily
 pass all devices with a good margin.
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
From: xufeifei via ltp <ltp@lists.linux.it>
Reply-To: xufeifei <xufeifei1@oppo.com>
Cc: xufeifei <xufeifei1@oppo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogeHVmZWlmZWkgPHh1ZmVpZmVpMUBvcHBvLmNvbT4KLS0tCiB0ZXN0Y2Fz
ZXMva2VybmVsL3NjaGVkL2Nmcy1zY2hlZHVsZXIvc3RhcnZhdGlvbi5jIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9zY2hlZC9jZnMtc2NoZWR1bGVyL3N0YXJ2YXRpb24uYyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc2NoZWQvY2ZzLXNjaGVkdWxlci9zdGFydmF0aW9uLmMKaW5kZXggZWI5ZmQ2ZmY1
Li4wZjIxOTY4NjggMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc2NoZWQvY2ZzLXNjaGVk
dWxlci9zdGFydmF0aW9uLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zY2hlZC9jZnMtc2NoZWR1
bGVyL3N0YXJ2YXRpb24uYwpAQCAtMjMsNyArMjMsNyBAQAogI2luY2x1ZGUgInRzdF90ZXN0Lmgi
Cgogc3RhdGljIGNoYXIgKnN0cl9sb29wOwotc3RhdGljIGxvbmcgbG9vcCA9IDIwMDAwMDA7Citz
dGF0aWMgbG9uZyBsb29wID0gMTAwMDAwOwogc3RhdGljIGNoYXIgKnN0cl90aW1lb3V0Owogc3Rh
dGljIGludCB0aW1lb3V0ID0gMjQwOwoKLS0KMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpPUFBPCgrCscK+wrXDp8OXw5PDk8OKwrzDvsK8wrDDhsOkwrjCvcK8w77CusKs
w5PDkE9QUE/CucKrw4vCvsK1w4TCscKjw4PDnMOQw4XDj8KiwqPCrMK9w7bDj8Oew5PDmsOTw4rC
vMO+w5bCuMODw7fCtcOEw4rDlcK8w77DiMOLwqPCqMKww7zCusKswrjDtsOIw4vCvMKww4jCusOX
w6nCo8Kpw4rCucOTw4PCocKjwr3Du8OWwrnDiMOOwrrDjsOIw4vDlMOaw47CtMK+wq3DisOaw4jC
qMK1w4TDh8Opwr/DtsOPw4LDksOUw4jDjsK6w47DkMOOw4rCvcOKwrnDk8ODwqHCo8OIw6fCucO7
w4TDusK0w63DisOVw4HDi8Kxwr7Dk8OKwrzDvsKjwqzDh8OQw47DsMK0wqvCssKlwqHCosK3w5bC
t8KiwqHCosK4wrTDlsOGwqHCosOTwqHDi8KiwrvDssOKwrnDk8ODwrHCvsOTw4rCvMO+w5bCrsOI
w47CusOOwrLCv8K3w5bCu8Oyw4bDpMOLw7nDlMOYw5bCrsOIw47CusOOw4TDmsOIw53Co8KswrLC
osOHw6vDgcKiwrzCtMOSw5TCtcOnw5fDk8OTw4rCvMO+w43CqMOWwqrCt8KiwrzDvsOIw4vCssKi
w4nCvsKzw73CscK+w5PDisK8w77CvMKww4bDpMK4wr3CvMO+wqHCowrDjcO4w4LDp8ONwqjDkcK2
wrnDjMOTw5DDiMKxw4/DncK/w4nDhMOcwrXCvMOWw4LDk8OKwrzDvsKxwrvCvcOYw4HDtMKhwqLD
kMOewrjDhMKhwqLCtsKqw4rCp8KhwqLDhsOGwrvCtcK7w7LCsMO8wrrCrMK8w4bDi8OjwrvDusKy
wqHCtsK+wrXDiMKywrvCsMKyw4jCq8OHw6nCv8O2wqPCrE9QUE/CtsOUwrTDi8OAw6DCtMOtw47D
s8K7w7LDksOFw4LCqcK2w7jDksO9w5bDgsOWwq7DiMOOwrrDjsOLw7DDisKnwrjDhcKywrvCs8OQ
wrXCo8OUw7DDiMOOwrLCosKxwqPDgcO0w5PDq8Kxwr7Dk8OKwrzDvsOPw6DCucOYw5bCrsOSwrvD
h8OQw4jCqMOAw7vCocKjCsKzw73Ct8OHw4PDt8OIwrfDi8K1w4PDt8KjwqzCscK+w5PDisK8w77C
vMKww4bDpMK4wr3CvMO+w47DnsOSw6LDl8O3w47CqsOUw5rDiMOOwrrDjsK5w7rCvMOSwrvDssK1
w5jDh8O4w5bCrsOSwqrDlMK8wqHCosOVw5DDgMK/wrvDssKzw5DDhcK1wqPCrMOSw6DDjsOew5LD
osOXw7fDjsKqw4jDjsK6w47CvcK7w5LDl8K7w7LCusOPw43CrMOWwq7DlcO9w4rCvcOIwrfDiMOP
wqHCoyDCt8KiwrzDvsOIw4vCocKiw4bDpMOLw7nDisO0wrvDusK5wrnCu8Oyw4vDucOKw7TCu8O6
wrnCucOWwq7CucOYw4HCqsK7w7rCucK5wrvDssOIw47CusOOw4nDj8OKw7bCu8O6wrnCucOWwq7C
ucOJwrbCq8KhwqLCtsKtw4rDgsKhwqLCuMOfwrzCtsK5w5zDgMOtw4jDi8OUwrHCocKiw5TCscK5
wqTCu8Oyw4bDpMOLw7vDiMOOwrrDjsOIw4vCo8Kow5LDlMOPw4LCs8OGwqHCsMK3wqLCvMO+w4jD
i8KhwrHCu8OywqHCsE9QUE/CocKxwqPCqcKywrvDksOywrHCvsOTw4rCvMO+w5bCrsOOw7PDi8ON
wrbDuMK3w4XDhsO6w4bDpMOLw7nDj8Otw5bCrsOIw47CusOOw4jCqMOAw7vCo8Ksw5LDoMKywrvC
tsOUw5LDssK5w4rDksOiwrvDssK5w73DisKnw4rCucOTw4PCuMODwrXDiMOQw4XDj8KiwrbDuMOS
w73Ct8KiwrvDssK/w4nDhMOcw5LDvcK3wqLCtcOEw4vDsMOKwqfCs8OQwrXCo8OIw47CusOOw5TD
sMOIw47CocKjCsOOw4TCu8KvwrLDrsOSw6zDhcO7w4LCtsKjwrrDksOyw4jCq8OHw7LDjsOEwrvC
r8Kyw67DksOsw5PCsMOPw6zCo8KswrXCpcK0wr/DksOUWUVTXE9LwrvDssOGw6TDi8O7wrzDssK1
wqXCtMOKwrvDo8K1w4TCu8OYwrjCtMKywqLCssK7wrnCucKzw4nCt8KiwrzDvsOIw4vCtsOUw4jD
jsK6w47CvcK7w5LDl8K7w7LCusOPw43CrMOWwq7DlcO9w4rCvcOIwrfDiMOPwrvDssK9w5PDisOc
wqPCrMOHw6vDk8OrwrfCosK8w77DiMOLw5TDmcK0w47DiMK3w4jDj8OSw5TCu8OxwrXDg8ODw7fD
iMK3w4rDqcODw6bDksOiwrzDu8KhwqPCt8KiwrzDvsOIw4vCssK7wrbDlMOIw47CusOOw4rDnMOO
w4TCu8KvwrLDrsOSw6zDk8Kww4/DrMK2w7jCtcK8w5bDgsK5w4rDksOiwrvDssK0w63DjsOzw4rC
ucOTw4PCuMODwrXDiMOQw4XDj8Kiw4vDucOUw6zCs8OJwrXDhMOIw47CusOOw5bCscK9w5PCu8Oy
wrzDpMK9w5PDi8OwwrrCpsKzw5DCtcKjw5TDsMOIw47CocKjClRoaXMgZS1tYWlsIGFuZCBpdHMg
YXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gZnJvbSBPUFBPLCB3
aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRy
ZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVk
IGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwg
b3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5
IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0
ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBkbyBub3Qg
cmVhZCwgY29weSwgZGlzdHJpYnV0ZSwgb3IgdXNlIHRoaXMgaW5mb3JtYXRpb24uIElmIHlvdSBo
YXZlIHJlY2VpdmVkIHRoaXMgdHJhbnNtaXNzaW9uIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRo
ZSBzZW5kZXIgaW1tZWRpYXRlbHkgYnkgcmVwbHkgZS1tYWlsIGFuZCB0aGVuIGRlbGV0ZSB0aGlz
IG1lc3NhZ2UuCkVsZWN0cm9uaWMgY29tbXVuaWNhdGlvbnMgbWF5IGNvbnRhaW4gY29tcHV0ZXIg
dmlydXNlcyBvciBvdGhlciBkZWZlY3RzIGluaGVyZW50bHksIG1heSBub3QgYmUgYWNjdXJhdGVs
eSBhbmQvb3IgdGltZWx5IHRyYW5zbWl0dGVkIHRvIG90aGVyIHN5c3RlbXMsIG9yIG1heSBiZSBp
bnRlcmNlcHRlZCwgbW9kaWZpZWQgLGRlbGF5ZWQsIGRlbGV0ZWQgb3IgaW50ZXJmZXJlZC4gT1BQ
TyBzaGFsbCBub3QgYmUgbGlhYmxlIGZvciBhbnkgZGFtYWdlcyB0aGF0IGFyaXNlIG9yIG1heSBh
cmlzZSBmcm9tIHN1Y2ggbWF0dGVyIGFuZCByZXNlcnZlcyBhbGwgcmlnaHRzIGluIGNvbm5lY3Rp
b24gd2l0aCB0aGUgZW1haWwuClVubGVzcyBleHByZXNzbHkgc3RhdGVkLCB0aGlzIGUtbWFpbCBh
bmQgaXRzIGF0dGFjaG1lbnRzIGFyZSBwcm92aWRlZCB3aXRob3V0IGFueSB3YXJyYW50eSwgYWNj
ZXB0YW5jZSBvciBwcm9taXNlIG9mIGFueSBraW5kIGluIGFueSBjb3VudHJ5IG9yIHJlZ2lvbiwg
bm9yIGNvbnN0aXR1dGUgYSBmb3JtYWwgY29uZmlybWF0aW9uIG9yIGFjY2VwdGFuY2Ugb2YgYW55
IHRyYW5zYWN0aW9uIG9yIGNvbnRyYWN0LiBUaGUgc2VuZGVyLCB0b2dldGhlciB3aXRoIGl0cyBh
ZmZpbGlhdGVzIG9yIGFueSBzaGFyZWhvbGRlciwgZGlyZWN0b3IsIG9mZmljZXIsIGVtcGxveWVl
IG9yIGFueSBvdGhlciBwZXJzb24gb2YgYW55IHN1Y2ggaW5zdGl0dXRpb24gKGhlcmVpbmFmdGVy
IHJlZmVycmVkIHRvIGFzICJzZW5kZXIiIG9yICJPUFBPIikgZG9lcyBub3Qgd2FpdmUgYW55IHJp
Z2h0cyBhbmQgc2hhbGwgbm90IGJlIGxpYWJsZSBmb3IgYW55IGRhbWFnZXMgdGhhdCBhcmlzZSBv
ciBtYXkgYXJpc2UgZnJvbSB0aGUgaW50ZW50aW9uYWwgb3IgbmVnbGlnZW50IHVzZSBvZiBzdWNo
IGluZm9ybWF0aW9uLgpDdWx0dXJhbCBEaWZmZXJlbmNlcyBEaXNjbG9zdXJlOiBEdWUgdG8gZ2xv
YmFsIGN1bHR1cmFsIGRpZmZlcmVuY2VzLCBhbnkgcmVwbHkgd2l0aCBvbmx5IFlFU1xPSyBvciBv
dGhlciBzaW1wbGUgd29yZHMgZG9lcyBub3QgY29uc3RpdHV0ZSBhbnkgY29uZmlybWF0aW9uIG9y
IGFjY2VwdGFuY2Ugb2YgYW55IHRyYW5zYWN0aW9uIG9yIGNvbnRyYWN0LCBwbGVhc2UgY29uZmly
bSB3aXRoIHRoZSBzZW5kZXIgYWdhaW4gdG8gZW5zdXJlIGNsZWFyIG9waW5pb24gaW4gd3JpdHRl
biBmb3JtLiBUaGUgc2VuZGVyIHNoYWxsIG5vdCBiZSByZXNwb25zaWJsZSBmb3IgYW55IGRpcmVj
dCBvciBpbmRpcmVjdCBkYW1hZ2VzIHJlc3VsdGluZyBmcm9tIHRoZSBpbnRlbnRpb25hbCBvciBt
aXN1c2Ugb2Ygc3VjaCBpbmZvcm1hdGlvbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KT1BQTwoK5pys55S15a2Q6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJT1BQT+WFrOWPuOeahOS/
neWvhuS/oeaBr++8jOS7hemZkOS6jumCruS7tuaMh+aYjueahOaUtuS7tuS6uu+8iOWMheWQq+S4
quS6uuWPiue+pOe7hO+8ieS9v+eUqOOAguemgeatouS7u+S9leS6uuWcqOacque7j+aOiOadg+ea
hOaDheWGteS4i+S7peS7u+S9leW9ouW8j+S9v+eUqOOAguWmguaenOaCqOmUmeaUtuS6huacrOmC
ruS7tu+8jOWIh+WLv+S8oOaSreOAgeWIhuWPkeOAgeWkjeWItuOAgeWNsOWIt+aIluS9v+eUqOac
rOmCruS7tuS5i+S7u+S9lemDqOWIhuaIluWFtuaJgOi9veS5i+S7u+S9leWGheWuue+8jOW5tuiv
t+eri+WNs+S7peeUteWtkOmCruS7tumAmuefpeWPkeS7tuS6uuW5tuWIoOmZpOacrOmCruS7tuWP
iuWFtumZhOS7tuOAggrnvZHnu5zpgJrorq/lm7rmnInnvLrpmbflj6/og73lr7zoh7Tpgq7ku7bo
oqvmiKrnlZnjgIHkv67mlLnjgIHkuKLlpLHjgIHnoLTlnY/miJbljIXlkKvorqHnrpfmnLrnl4Xm
r5LnrYnkuI3lronlhajmg4XlhrXvvIxPUFBP5a+55q2k57G76ZSZ6K+v5oiW6YGX5ryP6ICM5byV
6Ie05LmL5Lu75L2V5o2f5aSx5qaC5LiN5om/5ouF6LSj5Lu75bm25L+d55WZ5LiO5pys6YKu5Lu2
55u45YWz5LmL5LiA5YiH5p2D5Yip44CCCumZpOmdnuaYjuehruivtOaYju+8jOacrOmCruS7tuWP
iuWFtumZhOS7tuaXoOaEj+S9nOS4uuWcqOS7u+S9leWbveWutuaIluWcsOWMuuS5i+imgee6puOA
geaLm+aPveaIluaJv+ivuu+8jOS6puaXoOaEj+S9nOS4uuS7u+S9leS6pOaYk+aIluWQiOWQjOS5
i+ato+W8j+ehruiupOOAgiDlj5Hku7bkurrjgIHlhbbmiYDlsZ7mnLrmnoTmiJbmiYDlsZ7mnLrm
noTkuYvlhbPogZTmnLrmnoTmiJbku7vkvZXkuIrov7DmnLrmnoTkuYvogqHkuJzjgIHokaPkuovj
gIHpq5jnuqfnrqHnkIbkurrlkZjjgIHlkZjlt6XmiJblhbbku5bku7vkvZXkurrvvIjku6XkuIvn
p7DigJzlj5Hku7bkurrigJ3miJbigJxPUFBP4oCd77yJ5LiN5Zug5pys6YKu5Lu25LmL6K+v6YCB
6ICM5pS+5byD5YW25omA5Lqr5LmL5Lu75L2V5p2D5Yip77yM5Lqm5LiN5a+55Zug5pWF5oSP5oiW
6L+H5aSx5L2/55So6K+l562J5L+h5oGv6ICM5byV5Y+R5oiW5Y+v6IO95byV5Y+R55qE5o2f5aSx
5om/5ouF5Lu75L2V6LSj5Lu744CCCuaWh+WMluW3ruW8guaKq+mcsu+8muWboOWFqOeQg+aWh+WM
luW3ruW8guW9seWTje+8jOWNlee6r+S7pVlFU1xPS+aIluWFtuS7lueugOWNleivjeaxh+eahOWb
nuWkjeW5tuS4jeaehOaIkOWPkeS7tuS6uuWvueS7u+S9leS6pOaYk+aIluWQiOWQjOS5i+ato+W8
j+ehruiupOaIluaOpeWPl++8jOivt+S4juWPkeS7tuS6uuWGjeasoeehruiupOS7peiOt+W+l+aY
juehruS5pumdouaEj+ingeOAguWPkeS7tuS6uuS4jeWvueS7u+S9leWPl+aWh+WMluW3ruW8guW9
seWTjeiAjOWvvOiHtOaVheaEj+aIlumUmeivr+S9v+eUqOivpeetieS/oeaBr+aJgOmAoOaIkOea
hOS7u+S9leebtOaOpeaIlumXtOaOpeaNn+Wus+aJv+aLhei0o+S7u+OAggpUaGlzIGUtbWFpbCBh
bmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20g
T1BQTywgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hv
c2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNv
bnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8s
IHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0
aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBw
cm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ug
ZG8gbm90IHJlYWQsIGNvcHksIGRpc3RyaWJ1dGUsIG9yIHVzZSB0aGlzIGluZm9ybWF0aW9uLiBJ
ZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIHRyYW5zbWlzc2lvbiBpbiBlcnJvciwgcGxlYXNlIG5v
dGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGJ5IHJlcGx5IGUtbWFpbCBhbmQgdGhlbiBkZWxl
dGUgdGhpcyBtZXNzYWdlLgpFbGVjdHJvbmljIGNvbW11bmljYXRpb25zIG1heSBjb250YWluIGNv
bXB1dGVyIHZpcnVzZXMgb3Igb3RoZXIgZGVmZWN0cyBpbmhlcmVudGx5LCBtYXkgbm90IGJlIGFj
Y3VyYXRlbHkgYW5kL29yIHRpbWVseSB0cmFuc21pdHRlZCB0byBvdGhlciBzeXN0ZW1zLCBvciBt
YXkgYmUgaW50ZXJjZXB0ZWQsIG1vZGlmaWVkICxkZWxheWVkLCBkZWxldGVkIG9yIGludGVyZmVy
ZWQuIE9QUE8gc2hhbGwgbm90IGJlIGxpYWJsZSBmb3IgYW55IGRhbWFnZXMgdGhhdCBhcmlzZSBv
ciBtYXkgYXJpc2UgZnJvbSBzdWNoIG1hdHRlciBhbmQgcmVzZXJ2ZXMgYWxsIHJpZ2h0cyBpbiBj
b25uZWN0aW9uIHdpdGggdGhlIGVtYWlsLgpVbmxlc3MgZXhwcmVzc2x5IHN0YXRlZCwgdGhpcyBl
LW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBhcmUgcHJvdmlkZWQgd2l0aG91dCBhbnkgd2FycmFu
dHksIGFjY2VwdGFuY2Ugb3IgcHJvbWlzZSBvZiBhbnkga2luZCBpbiBhbnkgY291bnRyeSBvciBy
ZWdpb24sIG5vciBjb25zdGl0dXRlIGEgZm9ybWFsIGNvbmZpcm1hdGlvbiBvciBhY2NlcHRhbmNl
IG9mIGFueSB0cmFuc2FjdGlvbiBvciBjb250cmFjdC4gVGhlIHNlbmRlciwgdG9nZXRoZXIgd2l0
aCBpdHMgYWZmaWxpYXRlcyBvciBhbnkgc2hhcmVob2xkZXIsIGRpcmVjdG9yLCBvZmZpY2VyLCBl
bXBsb3llZSBvciBhbnkgb3RoZXIgcGVyc29uIG9mIGFueSBzdWNoIGluc3RpdHV0aW9uIChoZXJl
aW5hZnRlciByZWZlcnJlZCB0byBhcyAic2VuZGVyIiBvciAiT1BQTyIpIGRvZXMgbm90IHdhaXZl
IGFueSByaWdodHMgYW5kIHNoYWxsIG5vdCBiZSBsaWFibGUgZm9yIGFueSBkYW1hZ2VzIHRoYXQg
YXJpc2Ugb3IgbWF5IGFyaXNlIGZyb20gdGhlIGludGVudGlvbmFsIG9yIG5lZ2xpZ2VudCB1c2Ug
b2Ygc3VjaCBpbmZvcm1hdGlvbi4KQ3VsdHVyYWwgRGlmZmVyZW5jZXMgRGlzY2xvc3VyZTogRHVl
IHRvIGdsb2JhbCBjdWx0dXJhbCBkaWZmZXJlbmNlcywgYW55IHJlcGx5IHdpdGggb25seSBZRVNc
T0sgb3Igb3RoZXIgc2ltcGxlIHdvcmRzIGRvZXMgbm90IGNvbnN0aXR1dGUgYW55IGNvbmZpcm1h
dGlvbiBvciBhY2NlcHRhbmNlIG9mIGFueSB0cmFuc2FjdGlvbiBvciBjb250cmFjdCwgcGxlYXNl
IGNvbmZpcm0gd2l0aCB0aGUgc2VuZGVyIGFnYWluIHRvIGVuc3VyZSBjbGVhciBvcGluaW9uIGlu
IHdyaXR0ZW4gZm9ybS4gVGhlIHNlbmRlciBzaGFsbCBub3QgYmUgcmVzcG9uc2libGUgZm9yIGFu
eSBkaXJlY3Qgb3IgaW5kaXJlY3QgZGFtYWdlcyByZXN1bHRpbmcgZnJvbSB0aGUgaW50ZW50aW9u
YWwgb3IgbWlzdXNlIG9mIHN1Y2ggaW5mb3JtYXRpb24uCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
