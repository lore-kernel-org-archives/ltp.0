Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7714DC77B75
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 12:54:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E629F3CBEDC
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 14:54:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF5F23CA8A4
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 14:54:11 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E36111A00A58
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 14:54:10 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33LCWnqU029948
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 12:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=BEoWE5c4vTYW0VNsh3VDOA3QslWg2yBG+bC8fYD09x0=;
 b=nUo+Z6324YvwNG4O89mkd+AsqS0+rAHKnusIoi+ePoF1PgP9gzsfLExQ8jVok8XZYxxU
 DaTmA4YhOEKpy+I12Vi8XPqHAh2bvfQyfyGEQBPIS+KKlO1iC1I5dMpYmsKDSeJ6Jzla
 HLFrGCuez8N8Dlq3lQiK35JN+MTCyww7d7WWXv7ZorHn21yTtaYgc2LIbqBvhBs9sR4d
 GLy8gZUNd23bPr5e6zc6ac6QUiz8TKUF4x1r9zoH+ZfAgJYoSSrnJcgGmKvPstqKjxLk
 njQ1ZSTOCC8aTeafNvCrtwbc8lOKuwh7ucnibHdOmLkJaKquWXwqj4qPOu0RYAL6+zgl 0g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q3tkbs4bm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 12:54:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWwWziYxFmtQH26MOvyc1kdYOlvx46kL9TSvOLzFEc/1b1EcxovE9uQscwjh1bVhLbvIlfQmdTlvO5q0f/koLytoVaym4i/q5wAT+VU8+8ZU0vca85vbqiJt90eMceuED3KVrfiRq7MMACtS30doOEieShjSS/JzXFCqIJyAm/ZfVOl66WaIfVu5/jEjza6LZ62QqXFTq7DXv507TsJeKk4dtSFQmbj9KTlWMCI00XuFQjdc5Acc8YdHaKTwUUJkD/niZz56iwUZhHh6EGP/B5B5OLizsQ/6f/CBjk1I7unmSYdp6WN51ugKBNBE0Zg8BGPQbirybaCbn1c8nG5SQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEoWE5c4vTYW0VNsh3VDOA3QslWg2yBG+bC8fYD09x0=;
 b=M3nx9WxSt2Et0FgW+ao8Bkk/4d6Gxgk6+vIp6cbNWknn9ropFwHQhfzHQiKkOWc7qhwfnLrhC2tpoWM5j0bhQiLxvxfZRS5wDl70h9YWFvfifQ4ByHyQdtKSbT1zTewIKO1LS86dzHzF1r58mEH6eyAw0Oguq4qNjgKR7lHCeoh0iEzz+KtXEAqjuFdJKZrNidxAt5AFNeGRtKJ2SVGKtlgCHB/sIEDnxbNcUHNDnfVJ8aJCMMCF4DSfbs4QVrRt52bWspNnMXI7zbhDW9c7csnDp/AWgoJON9iHq1ZrhSetBmvm6M/ogrHpnmo6GZ7YPedatA/yPCmGkDoUEOxUGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from MN2PR15MB3664.namprd15.prod.outlook.com (2603:10b6:208:1b5::11)
 by PH0PR15MB5658.namprd15.prod.outlook.com (2603:10b6:510:285::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Fri, 21 Apr
 2023 12:54:06 +0000
Received: from MN2PR15MB3664.namprd15.prod.outlook.com
 ([fe80::880:35b8:5445:8c9c]) by MN2PR15MB3664.namprd15.prod.outlook.com
 ([fe80::880:35b8:5445:8c9c%4]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 12:54:06 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [Patch] controllers/cpuset_regression_test.sh - Issue #1033
Thread-Index: AQHZdFBbsUNYhDI2qECBfB4Xt3dJCg==
Date: Fri, 21 Apr 2023 12:54:06 +0000
Message-ID: <MN2PR15MB36643ECDF70003A3486FFE90F2609@MN2PR15MB3664.namprd15.prod.outlook.com>
References: <MN2PR15MB36641E17F2BC189A06014B63F2609@MN2PR15MB3664.namprd15.prod.outlook.com>
 <ZEJ+fsJBLshJ3mMa@yuki>
In-Reply-To: <ZEJ+fsJBLshJ3mMa@yuki>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR15MB3664:EE_|PH0PR15MB5658:EE_
x-ms-office365-filtering-correlation-id: 8cdb1ef3-c314-4aec-24c3-08db42677def
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +cnj6bU9wwxHBHgRDRIcwhsis2j7PH6jssQoCAvJL5DhKCod3SJYkYtPRTgjgRpHLCHMNfjwneNT3ztPzOGO9r4Lera5KhK8AWMK4TuDQbYGSQ2rlFkOZ2RFfxsN3KJp0W7huMbCQGX/be26dsu1XzJGUk4D9P2ftFSXOFZi+sRHE8DOIy5Gpo6qIdX67xLSDjsfTLk7IomKP1Xjo2RvY2fFWQrUEmC7u//w88sEvMMCePenZhjGZe23/cKBvkz2taXHplJiJONKOeGrws7a8eNiGj3Kq+cZWjM4jiII3jxtz+FldSScBlVHW6DzYk2oKgDaDtnwfWzDqTcUdllSHCYjfqqVaRQnG4bvgQrau/s5fue1gB6FP1H3g6kV598rJFlCbYzckWlYMHoSBcMGXFxc1Rdjokmi2dOsyy5GHFRSV22iEGhT7Qf9LBevkzzwGNd9m+CTLahfgx1xafhNG1Hs4k0NwerlIzZyY0jeOM54FxupXisbxjjQeJ8m9D1jRGVFpdcd2ItOoSz8Na09A/d/FC+0edC6mXMm5nBR2lSrqELyN9T38NGY+PYF/U7UoAkwroZalB/g8PV7xx8Ks4G+v5z9EJjpRC4dfEb02/5lwFRkA8AIbXwVe7eTxFFcViEuvmNZU+6Q80B/llu6RMt3aVAn6blcNh0IMyBxKnQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR15MB3664.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(186003)(55016003)(4744005)(478600001)(2906002)(52536014)(71200400001)(7696005)(38070700005)(64756008)(6916009)(4326008)(66556008)(66476007)(76116006)(66446008)(66946007)(8676002)(316002)(38100700002)(8936002)(54906003)(41300700001)(5660300002)(122000001)(33656002)(6506007)(9686003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zlBlQgOC3lSdfKKeoSib868EtU3iwhwAIJ/Ngjj51c83H+V2F6TVymLYtVD7?=
 =?us-ascii?Q?X7rQ82NG4U50JMwSaTGWzTU3RavV5kA8iaA5JmoZkVlH48Yo6zEP68rjARpG?=
 =?us-ascii?Q?6wECmx3IOz87/mXAKemhtM2kbLUHiEuJjNm7s4Sph+0pwTsPmO1xGMs5KBEd?=
 =?us-ascii?Q?faa8eZ4tSE8PDIlLfLVOir1Tb8hYetMs5ugK/sI7k0u+CZ6c5LC7pVhCPck8?=
 =?us-ascii?Q?hA7UEFGXSYUYy7D3FZ5MWWp8a/ZtZVs7OHOfeHsgXnUWA863uTFCjp6TTdE2?=
 =?us-ascii?Q?PwzGztpAPy7/XvEYD6npOjo50cOYdeO/NfRYtOulHelLvDc/q99HVmkaLSSA?=
 =?us-ascii?Q?unJ66Y2NkjETeZxM6SnMRoM4oL/mdi67AyPw5Yf6mLgmjY8EIItn1gKQDaCI?=
 =?us-ascii?Q?rYXp4u4xEzxg1K5lPgWbclqEl+z8HyVgSq4nHP7J4QPOFygZkh7gwvtVYpgF?=
 =?us-ascii?Q?Qo4VkMLrFxC6SGYNWg9ykVcdtpD1yJZygb0jug1xlU8sJDg4e+qoWAYGTjM8?=
 =?us-ascii?Q?V8BF6EXrB2qbIqICYixFIVElvIh8ysu3XLmZilWUgpOkobWwrohlnUomwwsm?=
 =?us-ascii?Q?gpKsNW/iN//XDEL+IYqEQ1V4modNu3ESmIgmcoeR5nF8EQApv6Pmm/oSHBO5?=
 =?us-ascii?Q?R7BUkdB4/+7PE1/1odTGQebvgiLAuXhJQ6wPCsTDWFFpu2NHoItSSRv3WtsF?=
 =?us-ascii?Q?TRqyQ/kWSJfTYkTOQBnqyYjvSj0uVdJU4z3u/ti7mq1Z6GUNHcNefVnSKBPh?=
 =?us-ascii?Q?UpvISduSVcmYUmYFM/9EL23lxbQVTlsLQngqQkQUVKS0hD54bWT4KwcOkZ/y?=
 =?us-ascii?Q?dK2QDlBNThtVRPA09aFibExtolUd9IFmVOJlf6TRGChGfO8cHSl7cxt1D5Ow?=
 =?us-ascii?Q?7sINEPSwONFIR/uUu14Yyd92lRUOHNoDnuBUJGaY1Pl+PinLgS1+fR6kk1RM?=
 =?us-ascii?Q?TAFiF8YLa4ZOk/WAz4v7utCSO/2VdZiyd3Pm6TOOLD7HviAu6x2/a4uo7/Ed?=
 =?us-ascii?Q?UoPnaQDZzfO0XqXVCHH6/c2DiZz0na2+TeYn8TM1CRuVn/xONwWw5+uN6Cr4?=
 =?us-ascii?Q?0cKgSZVLqdrWzMJyQiEVPQ2t8K0SohgxJlmUlew+Jl5pBLRlC7hr5FgPnywE?=
 =?us-ascii?Q?BKvVc8CYcwYYNFGPCP7EaxK8F6Nv0I9LE8/szZYTuzleKTxQ9RFDKAtZsLPd?=
 =?us-ascii?Q?3kL03UkNP2EVdQMtiSFiCDCRELvXQvbsKk5hcsvEOE9+W05/YD/TbdZygpus?=
 =?us-ascii?Q?Sv5kQ8N5tuL8JXVZJj45RaI1JLfO+VaypXW8MRMjlYfIYs3TPRIwrkuMhpsJ?=
 =?us-ascii?Q?5cJIs0AcJRD4Ci4Qclf8CcvUgbUZRFkGc5C62sdlbydutWyMLbchq3/e+PKu?=
 =?us-ascii?Q?FCahvytcgyhaeV7aoHynAeFRTAT04Q7qR9V5FlrRQ/itSg4pGqgDUOF21wPo?=
 =?us-ascii?Q?mlKh/CR4Ufs7mFWd5hauIe3YBu9gAZCYFGuP+HEKgTNNmi2zeTx/4XV+I00a?=
 =?us-ascii?Q?zLSyylVmF5yZgPijq2O7rDBwLQ0GJoFHrjzh+28fk5dXSidm2h5xkrnNmyhC?=
 =?us-ascii?Q?9n6jePZRYMz6CWWeCfETEJWyqgbsP+3d09riaVFmYcasLH8viqCKlTKN4eZA?=
 =?us-ascii?Q?tQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3664.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdb1ef3-c314-4aec-24c3-08db42677def
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 12:54:06.4681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZnOjajwV9rGPwk0lfilsvcOT1n4EFXrEYkqZ2rBsQOny6w5P8lKKouT+bAsibfmZaYOD0B5uv4ThxCDdbMu3ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5658
X-Proofpoint-ORIG-GUID: FsnQmsU9GSQkGw64KUOCg16IBJRqJY38
X-Proofpoint-GUID: FsnQmsU9GSQkGw64KUOCg16IBJRqJY38
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=855
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304210109
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
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

commit 253ed67c6977c84bb46fb6e06bfac14f7f3392f9 (HEAD -> master)
Author: Sowmya-Indranna <131340936+Sowmya-Indranna@users.noreply.github.com>
Date:   Fri Apr 21 16:18:04 2023 +0530

    cpuset_regression_test.sh: Renamed the test function

    Signed-off-by: SOWMYA INDRANNA <sowmya.indranna@ibm.com>

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
