Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5B6C7618E
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 11:44:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF0983CBEAE
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 13:44:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBD1C3CB329
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 13:34:27 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 41F4E1400C6D
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 13:34:25 +0200 (CEST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33LBY31w027424
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 11:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-type : mime-version; s=pp1;
 bh=NkWgeVmtHD5ZMvCil6oG+IFphyt6rBtyo5tj1nWiLI8=;
 b=gjMsAw+lo2jsr03QOt5Y3oLPZAC8qQn/490LZRX4j6VbrRyZ3/pqshAiRMkSUeU9WluW
 9Lpok/UC0P5EeBIBGvQEZmfsFWnXr5CLrwhzLePSvziKQrdZYgc+6+PE83boSZJkK7VP
 /mWH5NdTUu+QNV3urWuKFtRwFL45e1mpz4/y0ziUE3VKPuIX/1h9oOF57WeyQ9URWFQG
 dxNayH1lpgjps4f6WoX0+yl5/MteuqtZtvGOSHxwYi4EwEBuYCEVQuVUuyi9lo6agHyC
 zzgDf8yChs0FPRcI7qUpb/P9zFvIUzaE24Umo3S6onckbhklVtybrKLbfzmbTegO3Z7V fQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q3rhe2bh9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 11:34:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4RHSMlcfhWuDIHz5IHmM8yOiK6MsK0O8MOdE5iCndYTtPEk4NZgoovIYAO2aIMTVlB6iM2g94AWBWGZTYO0gvyRp61RGcnnJyiDQAG1YLWK1aQE2kwnl/bnpXTNgyA0FKjiNBHKtmJ3xWXlpdgjiIWvFAzXWWKXOhc+H9/WAaLywiexS4Gz2NWrGwmiG4eL+dNdhYAKgjmOiJRolix73IuKNLrz+/DYNJYaYayIsTkNnoGmaHju9VmVHke1dgom+63LEl8zE+siX5h0WRnIrcYEAje1wPlc0rvpiJGZY0oO/YTAKKMUswFv26jkzEWSSNUhFaLuH363REnqnd0KkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkWgeVmtHD5ZMvCil6oG+IFphyt6rBtyo5tj1nWiLI8=;
 b=ld7sme9WJsd7f+7OeKjOibFDGzJgrjLv2VP69zxzrqP/i/efJIrGR4WZwmljgLTQwNjE9kE96nbxPy7NqPZs4V0kZ79KysCc5blNXXZPnVo7rpC+vHOQSXNHZFx1SwCgxu1FZbje+SEJiRkChpWTyrxI8bcXedGyEaD7Ps3LiWjMG4njSwSTJY69YO8YAwqIFkvYB4awGywbc2T5bb5VsLUihZ6et1Y22CzOzFaGvQUcaj6c8+qobasG/uthib8bZMbBVNGPzxSHEEjYrp7Fhjo7NeXbVpcBJBpRVKs0l+p2bVZHt/WlthiJH7GB0FcMaueH8qRpuxEDUy076rJs2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from MN2PR15MB3664.namprd15.prod.outlook.com (2603:10b6:208:1b5::11)
 by SA1PR15MB4821.namprd15.prod.outlook.com (2603:10b6:806:1e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 11:28:03 +0000
Received: from MN2PR15MB3664.namprd15.prod.outlook.com
 ([fe80::880:35b8:5445:8c9c]) by MN2PR15MB3664.namprd15.prod.outlook.com
 ([fe80::880:35b8:5445:8c9c%4]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 11:28:03 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [Patch] controllers/cpuset_regression_test.sh - Issue #1033
Thread-Index: Adl0RD+Dr6pI6i/CTBKSsdw4RVfO3g==
Date: Fri, 21 Apr 2023 11:28:02 +0000
Message-ID: <MN2PR15MB36641E17F2BC189A06014B63F2609@MN2PR15MB3664.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR15MB3664:EE_|SA1PR15MB4821:EE_
x-ms-office365-filtering-correlation-id: 3e10c84b-d5d3-4a30-1a1d-08db425b7843
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iSPtqyGsYPkqBpwYZQb42BzkXLOsbBp44B5Q8z9gjKPiaoz45fbRJUNKW8MEv4qNGoY15IoiNHp4Un0sES5GIW7LWH6AqDcmNGEHlsn3lVs+aUoOPvaFQb+umMO9lSSVBL2qqeO/W/hNtLM7dV+I0GefPxB/jAEX7wylH9lAjI+Xg7SPohXiD0rkQa+IL4YHQbKzE6a1Vs1rn8LbrfI8CCIfpHynaz79Nws7ToJ41ua4P8PoC+1r3/f6UtCZrDylI8f81stnJEBTdxY/bLKgyNXrep4dvclQlqk2lvUQ19upl4lOqcMCEp5Yglbr/SQvlCwopxog9nidyC8ZkqZzvZR9FGwFTfkbGiFHaGCp7aqFkg+Ekv/Qwf27RFo2ZRHEIEXReaLLXxnXBeKz1h9jTjaEr2X1VlNk1kA+bkOWzrgzxCzl7zVFOmPLNpXLeEoMVmJ64i0Fi/NxxYnAMmOcXbViuVhRVN5ODutKZQc4ZedEdA4RACdBIN74/n4gsnRwTmdarbcAR2Cq0Rd/u6XKPRwO75nlfL9yXZM4aHepzelAynGzr1cdF8GZjzV6aMTaUl5fhx8dfVqp4h4Knv0MALmlYW+zx0O5U5FRcLj45glqXNv0xPsPMkNcE/lPsnl9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR15MB3664.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(9326002)(8676002)(5660300002)(52536014)(8936002)(316002)(41300700001)(122000001)(6916009)(4326008)(64756008)(66476007)(38100700002)(66446008)(86362001)(55016003)(38070700005)(4744005)(9686003)(6506007)(2906002)(33656002)(7696005)(83380400001)(186003)(76116006)(66946007)(66556008)(54906003)(478600001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2iqIbQ7oXDeNnlTlUBrfvv2EJGTWhkVyFrhAICe9kyxEvHCrVpfluJjrcWHw?=
 =?us-ascii?Q?rByLgDbyVA9JN+JOD/w70Ybw+IhHefyQZBL5qNoTEhjXHjUWLbQP6L9Ybe0N?=
 =?us-ascii?Q?IacwjTZ7QJ1rmSVZe+OwWWQdH/NOWbOsbxjpJ0uVpetfrHfv7mKupNSYUWIX?=
 =?us-ascii?Q?X3ExsCdXKdGapXgGsLOfgOGZg7OI8Kpvspkj2oxr+teqNbB2FisuYmWZSDXy?=
 =?us-ascii?Q?Nrm9VveJoL1SKwzIcmIrlEeKTpbYF1kEHWlAbvYVtuNuShAwfWxax23zF3tK?=
 =?us-ascii?Q?GL85kDQAqGelWWl6IqSD7G15s1IIfM4iNhg2Ke2FCfyDGEpy+Hag+3WaIqV2?=
 =?us-ascii?Q?pl1pC0ZpoPplcbVroBNAbbq140i3DK26ofnnZ4J7m16IE6Qw6RR+z/6s0TD3?=
 =?us-ascii?Q?/9iiUyuvLHpGyFx2geIM0uGYpe4mYPA2kd1qfTHo/x4XbZlp0nEUQv1sO1xe?=
 =?us-ascii?Q?5euOWqw2/5a/8lxw78PSTL1cpQad0xtuHEV//ktjAMquReUG8WGml/uMEAYg?=
 =?us-ascii?Q?LM9dUxgFTKsmzbh5IRyYk+dyRsisFlK7JvTDgPznIQkUeXTpGNHYvXz+h9vE?=
 =?us-ascii?Q?RDVxbg1Y/iUoBulIwe3MRHPs2dke8zte9iRCxNme9Fi9Wx6fF3TXgxn3UyHe?=
 =?us-ascii?Q?6+q+kjifEdSSZo6NMDV4WM+eQ5CSYgSPX9xc4R/SR2Vgt7o7zZxTTxleoIKq?=
 =?us-ascii?Q?3Jn13KTogKZVJeGuHCBIgX/addWmmyhjGOgUtIfciYC6cW3JfYit/KwXXet6?=
 =?us-ascii?Q?wbud7mPy82ZvNjQzip29PtHzbZ5QBf7dfqY/7cQVRGpM+u9EWsupha8bGbHf?=
 =?us-ascii?Q?dzt5IKYsljUlknauWpl5cagHw9ne2h95jzXdzj9wBh1vkxCh3LzpuoIVAWl/?=
 =?us-ascii?Q?YaSBruhEQnIbXl+ROkFJfZPkBNsSrdHflJf0yLc974KHGkbw9wWCifRpaO6Y?=
 =?us-ascii?Q?/E1PC0hnNCPw4pW3Mf/2XfMbmcZJIfjjSFjGV3iyVPblmI8cOLUnrX0fXTFf?=
 =?us-ascii?Q?aH2ztvWPhMDmB/dtZtCw5upmdYBtgrpAPrlotPf25BC2T1nX7IwgFpZTFPN+?=
 =?us-ascii?Q?TqQ3SwAB10Nt8wnXgJcndquCmYc+9npSD48bSQfEw4IAPdDkq3VeqiTRvS+I?=
 =?us-ascii?Q?Wxgp66ffXQ3XPRJav8QHHM8irmrAVRxpx7vrCfElzS5cXEjW8TraIY37hNcQ?=
 =?us-ascii?Q?mPWUta2EDqvd4lSSY9aePWlVH4ajoKt2+7BGXm+6KtiD3LXDVaz0Pw0YnnHS?=
 =?us-ascii?Q?I52LNHl3v9yeI9AwNd7c2ehRB9Yu+mVVu+ziYiNUMsUSrmGrRqmJCho7hl/M?=
 =?us-ascii?Q?1xCJIvIv7IN/zrD7i3KzNtKC/5yXPWW8XC69OiFgW3AVrjJxZC4/3HWvHCbi?=
 =?us-ascii?Q?+TTO6QbrpQd23RYEBAAkyAJwe+2ibI1OAjtBFeVb7uEeZGog5TD4qcl6GXCG?=
 =?us-ascii?Q?JC+uY84rHRNjRHkqkUstpnpzdZg1Tu8VaC/rKTpS5vhl0RImVwIllPSVPxOy?=
 =?us-ascii?Q?plBytYv4IFBeY3XeU6KGdgdtUyajFt6ygl20GCKXyQSHHCtUFeOMsJj5+EIe?=
 =?us-ascii?Q?Tk+xBpD7h8ndQs1fH5mxIq1m84AGpLqpLpfgNRR24CXcgO2906600npZH8G3?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3664.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e10c84b-d5d3-4a30-1a1d-08db425b7843
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 11:28:02.9966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNF+BpC9ALcZ840HiI/FhUhECV4BqUiUYkvCH4SZXr6p9ruiK489tSYwwBU8/927rFuty0tFwq16tW0/S1/SWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4821
X-Proofpoint-ORIG-GUID: 8--AGlf9v6PwBn_Hy_bYhFpcx0yenSey
X-Proofpoint-GUID: 8--AGlf9v6PwBn_Hy_bYhFpcx0yenSey
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_05,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=939 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210100
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 21 Apr 2023 13:44:22 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] [Patch] controllers/cpuset_regression_test.sh - Issue #1033
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
From: Sowmya Indranna via ltp <ltp@lists.linux.it>
Reply-To: Sowmya Indranna <Sowmya.Indranna@ibm.com>
Cc: Mahesh Kumar G <Mahesh.Kumar.G@ibm.com>, Chethan Jain <chetjain@in.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Sharing the patch for issue#1033 - cpuset_regression_test.sh

commit 7ffd942edf5acb7255a10c8ef9622dacbf9674d3 (HEAD -> master, origin/master, origin/HEAD)
Author: Sowmya-Indranna 131340936+Sowmya-Indranna@users.noreply.github.com<mailto:131340936+Sowmya-Indranna@users.noreply.github.com>
Date:   Fri Apr 21 16:18:04 2023 +0530

    #1033 - cpuset_regression_test.sh - function name updated

    #1033 - cpuset_regression_test.sh - function name updated. change test to do_test

diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index 8e87d20e4..1ae8933bc 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -12,7 +12,7 @@

TST_SETUP=setup
TST_CLEANUP=cleanup
-TST_TESTFUNC=test
+TST_TESTFUNC=do_test
TST_NEEDS_ROOT=1
TST_NEEDS_TMPDIR=1
TST_MIN_KVER="3.18"
@@ -178,7 +178,7 @@ cleanup()
        cgroup_cleanup
}

-test()
+do_test()
{
        local cpu_exclusive_tmp cpus_value


regards
Sowmya

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
