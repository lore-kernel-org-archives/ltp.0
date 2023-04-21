Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5A8C77B75
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 13:40:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0AEE3CBF13
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 15:40:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C5D53CBEAD
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 15:39:49 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8962960080D
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 15:39:31 +0200 (CEST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33LCqVGY013427
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 13:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : content-type : mime-version; s=pp1;
 bh=P4sgEjbXq3WdU7J3uHiPPRR8Z8ZK2ebFQFDXNXIVv/k=;
 b=jMk7VArMvUir9HPlW9Aug99dR9quGWFTnwetVGHBxm3AD5h4dUQq3UdppnFGEacjvzcY
 XYneuTtEd/2dvmL67nXCbpGzuRP/cYuOGFxllGym+OICHqOpF1zNooprpVxFdoKCpPWT
 wXquDhfx8kGHCBbFV9hjDiw65GxtqOT+944wbm/neOsorbzXr/uERhb3N3kYMGmx2NVn
 hD2wVE7moF4iILnJ55dRHNE7US/TXBg01nHuzw/KpcOnhNyuQstt57OBiybIYY0QIazn
 Me0/Y3zxMIfivycogZ97Jly+uZTndH9/LtXOJdU42YgqRlD4YIlkWMdAzEP5sLAJ9VoZ Ag== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q3tvea9mv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 13:39:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAIN1XmKD2SL1HLYuX0Vrhwenbkbv0a1KGKJowmqjkJ2MRSvlJdmmzwNnMgQKCQdICn2NWPL5ZJzCP4nGPrEXbKpC0ZJvFM9Z/nmqfIzxsboPtrObP12ZVEAq/PaZsnRImM1xXCdcmu940ZsLtytQOpqsz/Ruxwl+rPuYCWwljWg2vN5LrVkpPM+Qi5q4fdZ6NX/uPikEVrL3R5BXjbLK6A4J6hzMUZY4bg+kDnXjAFM4bJycn+7Bx9EdQ9mOU2OJ0GViHiUb9iV60VLlrs0JCI6eEZg7V/Hwr6nyZ28d11nUxYymQxMWx8xXPNHErNbQviRC8kNNNzgxhbmYIwJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4sgEjbXq3WdU7J3uHiPPRR8Z8ZK2ebFQFDXNXIVv/k=;
 b=nvCXetc5pRnGQHkOINDItI51gHg5ma2nXAgMo2dalqdrr659tikIR6c9SGFHCcIm7z6OYGuvVSbEY8PRPesfXdctw1eAL595Kg6zR0YB17U4TUzz0twB/rMSobKTeOtMfxc6uEgVvbyd+6zIWliQbuIBPHzBRjuokqH2MSi93FsDamNCk7ZjthV2UdkkOKeklHoQKuG4InEf3mJTV0DV/YRanAyPa4StIrwtm/dyjrquCcsPQHyAm1r5VHaKrlaZP5YnGNyEHGAc3kA1y5jvG8u4phuhHTqDfAZw8ggSIDoa88YuIrlsGQFu7teEow3sEdfthQzLP0KFgzCKz4SyyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from MN2PR15MB3664.namprd15.prod.outlook.com (2603:10b6:208:1b5::11)
 by CH3PR15MB5841.namprd15.prod.outlook.com (2603:10b6:610:121::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 13:39:02 +0000
Received: from MN2PR15MB3664.namprd15.prod.outlook.com
 ([fe80::880:35b8:5445:8c9c]) by MN2PR15MB3664.namprd15.prod.outlook.com
 ([fe80::880:35b8:5445:8c9c%4]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 13:39:02 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] controllers/cpuset_regression_test.sh - Issue #1033
Thread-Index: Adl0VocFKZgxaxLRQvmb8RX1d++KcQ==
Date: Fri, 21 Apr 2023 13:39:01 +0000
Message-ID: <MN2PR15MB36640A5589296ACE83A0A422F2609@MN2PR15MB3664.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR15MB3664:EE_|CH3PR15MB5841:EE_
x-ms-office365-filtering-correlation-id: b5355f4c-b230-4fbb-8ece-08db426dc4a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lb6TxCWNI7Xt9YDv5s4bIhmmhUhXdFxsDPeSIXLIHsls37o8irDNiqzDopI405dKTH8bTJUHYt4XBhdfp5MPWzqXMcjaq/RxIQ+kTr7J1SJAfkdOqeO5V4HRhdfL5QsSvu2tvXMQ1O/oHN0I5TekgIctBOfWPtVwE0V252uq0r8aemeAOjriSYcY3ThvBVuBnzj84rD0JgtkUASjjLlEvkuJtpiskcJAEzSwQ3W3rjJ01SsGVLFWxyuTyMkbrzH0HRa70fycoctALjYvGcAXAmhR8Q5QRfzPOffSruWJJ6vDtdSTJ2d3PCmHq/O43pqB9/Nf6uyxAUXMuKVlMNWyCFWdjDjMb32drmR9rr4ioloclSuSpTxvJR3jhzxlvkkR/NpkRidnOuwRwDtka78YCLeoIbuOy8vuNa1DeVOSUXlDiu4vD1xjelJtsvubT5Xby3er9RlozeAsKAxWJnKaJPo57MwC/B2qzApZEG0yfd0TmW3Ktr+2RROQFZ63+TRDuxy00NlxAK8abRu+ml3/RkYATwAfn5gWPAJZ45YYRISUVNgH8dwgMJeUMspgGKvFh0nSH531yy0vXcSG2IZ11/WMME+E1a28Rd9KPHO1JRhEjvMHKXhgfsxMBCYh1W6a
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR15MB3664.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(9326002)(41300700001)(38070700005)(122000001)(5660300002)(52536014)(38100700002)(2906002)(8676002)(8936002)(4744005)(33656002)(86362001)(7696005)(55016003)(71200400001)(9686003)(6506007)(478600001)(186003)(76116006)(66556008)(66446008)(66946007)(66476007)(316002)(64756008)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GCLDFOg/ZpIeiTxAZem596XzcZe8yL76lW/uGFKTST0ls7jS22UuP9BJNEJY?=
 =?us-ascii?Q?kwmxzQjZXjTKzcNVnYsKM9LijfDEu3l8j7WTWWGGJKRVj4jFUCuXhu6AitF2?=
 =?us-ascii?Q?q/PqdAnTZoYPd0Vjj2T6NZZgj1l5OhfRujbP61ie1UBGmlXjFxytIxQSjMAp?=
 =?us-ascii?Q?v230NiXoP5OIBXn77X23lqPOsZwcjZhOfgrqt2uJK7UmuGdsBwLrDOW9Son1?=
 =?us-ascii?Q?fSWw1zGK+istE3EfyW3u+a2t4ghIJHabH7cm1UvCY8ypTEQsfZ1DLMGWMQgh?=
 =?us-ascii?Q?sFlaJOThH0w4SHysgcbCjemEJGi8X8ktFs+xuyYF9OajiqcgtfP/mOVS1t+R?=
 =?us-ascii?Q?3LD6iCgaVBXymkGQlDNKJg0eesFitAwc8AFq1dav2i6aovkjVJg5Aqo9KJJl?=
 =?us-ascii?Q?a/xQZHFWDn2C7AtYqAFZnBZV+WZW1Ak975jwd3Z3ACFsnoxgip0amUmA9xNs?=
 =?us-ascii?Q?sZeSaVo3e1uHUT/bQERy0CJ2nOn5b/ci/lequr1yn7O5sA1huvuHYzYpzocd?=
 =?us-ascii?Q?vIFUV43qpWk/wY76Y/1l6dMSScbyN3y3vQssYYn8r8KYSnBnWDAIIUP0dWtn?=
 =?us-ascii?Q?AyBQrqXvGPOkdjtoBpR0DE18occXL+PscIYnFmx6LQhBxc+CfbkC/M3HHo5q?=
 =?us-ascii?Q?W2kyt8dSXnG5SyjiIimNq3wjsjcO14wN/QGs1Y9iyoJMZc0cgOIZ9+3tThwp?=
 =?us-ascii?Q?2W4UHpsT9wMaRiw+3yfiw9DsgiKWetdWevJDcfTry4TukC1fuQRkF0rSn8jo?=
 =?us-ascii?Q?PEDr7Qz2Jr5xAyyipUNwybtFhfB70OlbepB/GdohTmTCvSzOEz01bV8XghEk?=
 =?us-ascii?Q?8pcTfrsmEwLxnlHv2cIzLTQBgQMlteJ1/G9pDCgKlgcvtP/58frym2+iirs9?=
 =?us-ascii?Q?MAFcNpQP5LpxefDTjWaLxNheuupdLqFRklvKDHU7Wr+Hs+Lh2mGnKmRfiu91?=
 =?us-ascii?Q?svF/WJgTvWW6vMlJsJQREw2GsbAGq94gObwZGq9ffVhHfBcCN2IGE827h8h6?=
 =?us-ascii?Q?4Mu++BPmT1+mDSBq936De61ZJju6l7JUEdsUnJCvr/Fk54hUeRk2bHjV7s7t?=
 =?us-ascii?Q?xD9xCc5iCtFfzzh7CdS1khsV8TLsmM4jDE/AWMQZtBHUw5pEjvRGDNYGKkbn?=
 =?us-ascii?Q?3lgdwNw1S+5iMSozgB0Qt2rfJK7aUWjYXyntpPXaAk5+5zjz7B7VgTC39mDR?=
 =?us-ascii?Q?5GSnwJQXOYmcvN0Bs3aXS4N89b/ycQX6QuIaa03FSE8Y6sLp1LR3SsbKoT+t?=
 =?us-ascii?Q?X+YaurkGhTds4jAmnlI1TcrnZ4zo4msO3yMwftPLLHjXzNNcmEXKzgDJgoUl?=
 =?us-ascii?Q?YrSFkoqkYx55esZQuNMT+kmJ43W/43K4LM6/IeuUNt5euMyK75PhavHCbTvh?=
 =?us-ascii?Q?82byVxWHq7TYaOFHdBv47liJLUo24c2o70lLhMJRUZgoI8gKmgJ6KElCsU44?=
 =?us-ascii?Q?dXXUnKPRJMKgV21EosJXsemaNV9x0zrAtoJ0DoAKNzxrZp9gSz0/tmcNyWOc?=
 =?us-ascii?Q?b0+5nCKVSTKBUZmHhozVXG6ntVSJ3DukXiWUPSDh7IJj38RYxBskGiBRmjSw?=
 =?us-ascii?Q?3TxRgSrSqOz6WiCxpoXXNTOw/UkmliNscPdvV5/voKfEypI1y5ctcrc1Uevc?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3664.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5355f4c-b230-4fbb-8ece-08db426dc4a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 13:39:02.1103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DE5ywniz6vtao4otn22yGwapzzteW/1BDnuZGjo1bsRqQM2TuKWmgQzVAtwX/n3giRhOiKpgkxlgB9Ieba/k/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5841
X-Proofpoint-GUID: HnMTOsbvQfLKnZQJb_m4CHLprdqr6mz8
X-Proofpoint-ORIG-GUID: HnMTOsbvQfLKnZQJb_m4CHLprdqr6mz8
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 mlxlogscore=938 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210118
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] [PATCH] controllers/cpuset_regression_test.sh - Issue #1033
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,



Sharing the patch for issue#1033 - cpuset_regression_test.sh


commit 6c681b9480a8aa47b053a8aa5d5b2a6592e79b47 (HEAD -> master)
Author: SOWMYA INDRANNA sowmya.indranna@ibm.com<mailto:sowmya.indranna@ibm.com>
Date:   Fri Apr 21 13:31:52 2023 +0000

    cpuset_regression_test.sh: Renamed the test function

    Signed-off-by: SOWMYA INDRANNA sowmya.indranna@ibm.com<mailto:sowmya.indranna@ibm.com>

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
