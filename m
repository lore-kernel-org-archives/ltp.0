Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9F5C3DA4A
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 06:39:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57B023D2133
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 08:39:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CF9A3D2026
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 08:38:56 +0200 (CEST)
Received: from MA0PR01CU012.outbound.protection.outlook.com
 (mail-southindiaazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c409::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 285851000986
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 08:38:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsTHGbY3XrgIqxe/E0AJntpoxcMZefd9K5uEpHRhCv/O/rvZNgSE4XYIApWc5zC2238rmHIuMQlgqosdXfoWyrIfQG8P/kvDBA9VMzimy55HT2g8I+0TgAwLdGdrfBnwL8r9uK2h4nFYYaeY8EuQiWuQbERsF+d5s7RSkwccahIVCsij3txB/zxx0xduWgLjAVbeiP3GJti8X3KS/4SJTjWCBm2MCARrrO2UyZSC3wssZH7LSB3P/3wpIIqHqAS8HUJFF9dPHQVDOQzgWgwcIlilYxFMjCDAItNE48YJ2E+FvSLbLq87h3uPyq/PY4maTV8p5oWoIJ8IP5u10DMf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HS9E9qzX9240RcHyqRlLC3aC3Tsb393bvnQHIDcFNqk=;
 b=SWQtcSw7ReJ+wQcwIyG70cpCRiZx14Rxwu+6HsGCkEt0imoyC10yPMC+Dli/FL2y739wAhQAL3bwZlYNAGMAgcdVO1MbcLKnmyVuHlNv/FiObVEnaxHaQItgcxKREEDYfhL8mPxLdFOzo3r0m52rsPNJu4BSIPu6EdAXFyUGhzXGCNJIVwOthtlHdT5cQO5Rhn/lVmpKgnALlz0+t61T/JEQPpU6MRYFuPFnqPAFcLBEKhISOlTzEfwjJQ+/129JIkJIejhFz0/8uUgB9A+jBYTjx/JX/tB5vz9UQPmvbUNAmE1UrFJF8S51lwyNiIlPQqYUOvSplAodf5x4iZTP6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=exaleapsemi.com; dmarc=pass action=none
 header.from=exaleapsemi.com; dkim=pass header.d=exaleapsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=exaleapsemi.onmicrosoft.com; s=selector2-exaleapsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HS9E9qzX9240RcHyqRlLC3aC3Tsb393bvnQHIDcFNqk=;
 b=GcSMuBfrvZ2MMU2wKuvXpdIfPbkOup5a6sBQDkSl55hloR26gIIlncuxlwRjf21rdwU6LkSDIMZQjCcuZWXfyipj3sl8q+ym6vaWtqff3AEMugUPApPNdLMIb0fWdzRCu4BtI98N6IUrjuSJXyRf55NG0LwvYJe4mkIXl84VA04=
Received: from PN2PR01MB9569.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:fa::12)
 by MA0PR01MB7754.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:2c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 06:38:50 +0000
Received: from PN2PR01MB9569.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::b684:5ab2:6c46:d67a]) by PN2PR01MB9569.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::b684:5ab2:6c46:d67a%5]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 06:38:50 +0000
From: Indumathi Raju <Indumathi.r@exaleapsemi.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Index: AQHa7hRcH+Yp48H/NEOIPgicYW10Xw==
Date: Wed, 14 Aug 2024 06:38:50 +0000
Message-ID: <PN2PR01MB95699F92D98659C10E6D19A6F0872@PN2PR01MB9569.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=exaleapsemi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN2PR01MB9569:EE_|MA0PR01MB7754:EE_
x-ms-office365-filtering-correlation-id: 147e1b02-8671-4f4b-facb-08dcbc2bc215
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: HrV+ckcTW9jXXLiR8Fd6zucZFipGsVNluMUqRa8vVDJBLbOOGPTz2yJ9sQjy2C0eZQG0c/25nNmJS/jbVyDtZhem7gUUE/u+9FnrNvdMW4FngAuvEWMgq6nzdTf9PyOGMfFPguMzuT74xZr1LGvkgIs8K+4RuO3oiGMKxXYwHCO1Q74g4lTdD0eCzKpeG0Jf6DIfIGZ9jip4D+M1n2v/wFUi/HQc/8ZoeFBsvsG3jYKsiXj/Afo2HMD5nXVZrkXpuyWQDXDgCVHtLDPfiPHNYAaUfONMc4+AMYfqsFnhKpV02ZvrVPgOWbUDoLqLnllrit1SgdupJhCazBre5W4Hf+xcxTo4113UeIOmiVGg/B/SzCzaihIWhf1GuYeaO7yFG9WipHa4B0cQjNvnhy067HWtFaVcf2w5j6JJoLZdo8uIIu8KuUqcCO4/ZbyJgdd34qVynZP5vFPXoyt+emYZGNyWiIqTXcN5XjcPn+YuZDxl8BQkXIu4Ok/FNcv7H+xREQj62lTEDtYOOf/osUxX5+wRccuTx2FTHf2EVfuszX0Cq/vG3B2ZLP56R4pLVUjt5oT78D1yFFJAcWxXrZegfvFm//7p3URlz79kdujaosltHSyAvja5a+bOWAwyQgaJ1oo3Da6TqaOQO67fZ3MrPQE0zCgBRBoDXcYOchZqhAo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PN2PR01MB9569.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hKR2jkapGofNxIsSc7EtDS74fCAAzFYskLtguS4WEN96tzefbOgygu9xdr?=
 =?iso-8859-1?Q?g3n2NyuT0im8HPj5S8LiqjoLbocV91pHnfk149PqsEyidur8PnGygmVRff?=
 =?iso-8859-1?Q?4OLHGbwVc6Ys9hNCj93AYTSBTZ0+CaoDTZy7ZYfMAqzYYE5HsvAMRkbQp6?=
 =?iso-8859-1?Q?B5OuWzufUk2OMvv65fPBnx8buhdk0onDJMMKkwIEm3Mamlb5Z8nAh8IHj0?=
 =?iso-8859-1?Q?q16R/rPycOHmfQAUtxrT7EoLuWylixYZO+BrcoTxoVeoSM9e+A0xTgnOGj?=
 =?iso-8859-1?Q?YfKoVbAlTGwAwt3G7VOZjuZMHJdmye0NjL78eVTOJiQYF9nMEmNaKwMTnW?=
 =?iso-8859-1?Q?7X8CXouu9e8UjdTTgCJ22EWiyQPar8uA8tgRREhINXqMvqyo3EqefFzRrV?=
 =?iso-8859-1?Q?xY0FZnAo01tmmyLdr653PPBXa3YpKPO0tI7Zo1vKMxS8Lw5fYEMaz6H5Tm?=
 =?iso-8859-1?Q?yHPtJ/BHdmT5sObD/7DEzLVkKmMlqgNn9X7HYoSGasZ2225O2W6ofpNNAw?=
 =?iso-8859-1?Q?y6O7ryt1TPJPISwzxKUPCZUHiUPWUCyw3QQXvXOFii6OvuJZRcQ1UUC7D/?=
 =?iso-8859-1?Q?Fqh/TjiSWLThwzFVcAR1Zf/YtWbsGHFpdvwSKWSEsH6wO+uV0cBdYNLQRe?=
 =?iso-8859-1?Q?s2Kc64eOCiEavBlSzNXKTQoWg3R9D3MVgYQ9c0d1jBRwK7s/jXwWBJ1ytD?=
 =?iso-8859-1?Q?ebGvPUckvngcU7cyDAnVK9d0SDi84/DKUIzRM66hb0TxI66zlTCFCoKuFr?=
 =?iso-8859-1?Q?pC5rO0nIhAZNIPudk2mZlf+qBkKnmN7EyIlhHMwltkKUVsdyX4Q+YVg0Ru?=
 =?iso-8859-1?Q?tN3O+/dN9gdQZ6ekRbJHKcVSsafbgQzlqtodql1Wtu+VjVLAYAiWiw6qIe?=
 =?iso-8859-1?Q?Nn0x3TUAOgnhMJi7pkgkcXJHhoQxFRfBAqeDHdS+Ap/wPgXMGLJ5g4+fBE?=
 =?iso-8859-1?Q?J1QxC7VgOWonJWuZaVBkeJ1GIoDdXg9FDHJvrsSo3fHbuABxTNm+wR9T13?=
 =?iso-8859-1?Q?uKrNiBuvIjMVh5osimxxMC4HctW2M1YikyXrdDD+arkFrb0eBkvXPMmUWG?=
 =?iso-8859-1?Q?GPq63QPOJXR8zHAU4SZDLfPzI0NRFhh6eD2sZcx2ka1SeW2B78SqvP/zod?=
 =?iso-8859-1?Q?ITebIwxPa/ASe5tJjIRBMWAPlCjIXYKNPgX8xp+gKeuElcTLk2omN09tL3?=
 =?iso-8859-1?Q?RH/NT/v8PlPFqvP2vpO3j9yX+pe5EaAzbnLWExEeqq33MEVASkTkmkJIxz?=
 =?iso-8859-1?Q?4pqtDjmLA7teAz4poK1yscSyq2Q1jyqcA56GnDlPD70VFFcN2jDpRV1A6p?=
 =?iso-8859-1?Q?97LR342VxgfTlbZdcBiQDA9Vf9zpa89mGz9pH2XTjHATKBCAqxHEKwyAzd?=
 =?iso-8859-1?Q?0eJTQvc9I3fzyyrzLFmU6u2Iec5HLpD3PIIsKSpQGUZuEFY+1QdrVN+QKE?=
 =?iso-8859-1?Q?XbWaXLD0FGvWr6JMPAQOdli5ovegwsZJsmNm31n1Y2z9f6mrGjOllaxY5v?=
 =?iso-8859-1?Q?oq1ViXmKwIwHHpHdF24hJoEi870TTdmU1UPoyfjqFZqxrGmcUHaKTyq0kp?=
 =?iso-8859-1?Q?sY/goVUUDooRFdnmnvVge8AKzkwiEEK93vy+4I2TK3B+2E8dGEfiMN0uFX?=
 =?iso-8859-1?Q?m2G5zBmPqfJDbKJXZETCV12CcRlupdBAh3?=
MIME-Version: 1.0
X-OriginatorOrg: exaleapsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN2PR01MB9569.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 147e1b02-8671-4f4b-facb-08dcbc2bc215
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 06:38:50.5102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34df156e-9bc4-4450-9e80-487c0e7f9471
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9PBqDVPvqrnSn+ogpIPNjo/CNUR3vOsocqvh0XLCRAjfXiTRYiqOcadCNReFlK79AuYBWTUKis0NJFTtks+d3nMKqNV7yA9xA/hEFzT/W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7754
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] (no subject)
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

 Hi am Doing LTP build and execution at Riscv64 on Linux platform There am facing issue with controllers.cgroups here the log "CONFIG_LOCKDEP is not enabled


CONFIG_LOCKDEP is not enabled


HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1756d7994ad8

HINT: You _MAY_ be vulnerable to CVE(s):

https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-4197
tst_cgroup.c:878: TCONF: V2 'memory' controller required, but it's mounted on V1
cgroup_core03.c:90: TCONF: cgroup.kill is not supported on your distribution
tst_cgroup.c:862: TCONF: 'debug' controller required, but not available
cgroup_fj_stress 1 TCONF: 'tst_cgctl require' exited. Controller is probably not available?
cgroup_fj_stress 1 TINFO: Re
tst_cgroup.c:878: TCONF: V2 'memory' controller required, but it's mounted on V1

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=cgroup_core03 stime=2083218808
cmdline="cgroup_core03"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1690: TINFO: LTP version: 20230929
tst_test.c:1574: TINFO: Timeout per run is 0h 00m 50s
tst_buffers.c:56: TINFO: Test is using guarded buffers
cgroup_core03.c:90: TCONF: cgroup.kill is not supported on your distribution

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=cgroup stime=2083218808
cmdline="cgroup_regression_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
cgroup_regression_test 1 TINFO: timeout per run is 0h 5m 0s
cgroup_regression_test 1 TPASS: no kernel bug was found
cgroup_regression_test 2 TPASS: notify_on_release is inherited
mkdir: cannot create directory '/sys/fs/cgroup/cpu,cpuacct/0': File exists

can u help me to resolve these issue

Regards
Indumathi R

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
