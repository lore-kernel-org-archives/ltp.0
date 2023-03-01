Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A22C64ED6
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 16:10:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE2C33CCE1F
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 17:10:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66BBC3CB2C7
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 17:10:07 +0100 (CET)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A9A342009B7
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 17:10:04 +0100 (CET)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 321G3Vck013485; Wed, 1 Mar 2023 16:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=pe5XuPh9inQT6jgCKV7PC1sPsCuW3ejJ3AKUqc6qKoA=;
 b=JstDrHmcaxb8fMUUJBFfGmYZlgKivMqIsiGlzf0pnLOYEXz6qGMsnndOzokx9DAxigka
 3plxB5tECEfhl123gpQSrqeXgfwzB3bNrrnpLmKbFapG8Z2Xfq8sSOjqJ6iJgMMByqZz
 KMfhcjZVLZGLSgWZaHw2es3fK7mDc8iRyMqiyVMpqVeGwZwZzTGoBZJhTFkp+S1bIA9/
 C9Sr/V7PDXOaT+qUAJj5gyWJ5g63Bop5KAsJdpvLOex1aIxuXK8M2CLPqvZay+OACz3/
 kX/sHPd17d8PQfXapTanje/vlW2FCfPhYRlOvL2Z7PwzEXKvVTlygzGPvHixX3IkJ+X/ 7w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7ha9a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Mar 2023 16:10:02 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 321FBDZe032857; Wed, 1 Mar 2023 16:10:02 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ny8s8p94g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Mar 2023 16:10:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVvrP+BBObB90g+GwrXin6SxrijmMRnNslnnNxVtVFf0WXggd7rQOa2MSgPV1E/xmdBrb5Og6YCjAvMDU0ID5FEGPNs8Tf6jxO3LTsXIhj8JCt9NpiGkRFC1IPz9qLn/fnxo6frSIzoQEiI2ku+0sao7MeKE23nzLktNeuJVTQZsHPDyMvOkayfybkPZlDAVOfHFGV1M9qRMmDStRlQLQ/hI4w5AUwWscfyEQKtX2QbSHCXnq+F+QgATn4fCYi1pyNb0nNaXYyaFd4aw6XqUvOXiiUzFjN2CG6j6FyIDt/I77VEx7BonIodJxIppR7tUHPFFUNinwqcGejSatU3bPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe5XuPh9inQT6jgCKV7PC1sPsCuW3ejJ3AKUqc6qKoA=;
 b=d/+UGTprDvMxPmXRhIIdqvnqxQA3lO6IdR1nZwPe28qxiJioYQmnLTlrbqYQa0qjT2kDZ67T0PVnS0dOp8OBjNNvkFfSHIEnOaIAoUI3+9oDcEfWlrZSZIbIo4eRJATutnMKAby10O9yzASsY7psZnQNX3e3wdyJSp81H5RGJTKB9Eh5JJo/rLFjlD7i2Ye3Zs8QhBgr/jhD+tzJ/DYX0B1CwM1J/7rzzB+KcU3Qxn/l/jZ8+TKM+DCE+sMHV0hSVLvVtiqcZ5qzfPk9Iq93YmWSb/Mwgjnf35fFtLpiQfhnMkdf87/v/VTGskNPk9lB23ysBpP+KY9FU0hEy9hJVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe5XuPh9inQT6jgCKV7PC1sPsCuW3ejJ3AKUqc6qKoA=;
 b=F3AiXwUWe8JsQF4YMdghdInOwYpGC9CmHDqYtvMncnjMNGQFU2vRO+OXGMM98Nr4d7mqeLEKF53MvIwW+iWjghxDqoW2E++J9co6Axmnw4YaQzKHJTCM7UDWvGrgNFd6tm1h3d4pe51VoTitqL0zu+4x4VFIJdbMROR/u4AgaPo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6554.namprd10.prod.outlook.com (2603:10b6:510:205::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.14; Wed, 1 Mar
 2023 16:09:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 16:09:59 +0000
Date: Wed, 1 Mar 2023 11:09:56 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230301160956.uttpkqzoovwyyze2@revolver>
References: <20230301141634.2881117-1-Liam.Howlett@oracle.com>
 <Y/9vL6uW2UxcMzrP@yuki>
Content-Disposition: inline
In-Reply-To: <Y/9vL6uW2UxcMzrP@yuki>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0079.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: c8430a40-ced8-4365-5b57-08db1a6f6821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2aAn1CJ9uwGSItppDNo4oI83hrtrRAUnUx+uTyERFRVDf75FSqohtCsdgdtB32Jc0Gzuhsa4n6zlQ+jht8QTkexGcVVyUKXUJ16nFnzajqSOYMVw0APjeofHap5FyzLwTUEOGT5G4keOEDMZsPjfvj2aBzEKKLCXdDWTp8lLLjVGM6dmiAXJeFhDRe/fgBMofmegpTN3r58Vf+XeJCtaYjwbZH/fO0pIhljzYLZ0rLU+s9Oiv2nEKBsQ1YwrN7DnxyTP8xe9cZ10axlTUBWKOJfFJCr/h2LOE6AEJ/dNfohsiqLU8F7tPOuf9kkYsVixOFAIFMObD54ItxeKzidDA/N4NwQvpEdfhIGGhSBo1935GWBBci3C3hMWP0rgBuU2GO4LjJ6+OfAz3H0wO2swg8JNVeaZbwrR81Xz71l5IekAk2ExJKxRbPnpRdGmBPsq4cSMy1n0Bp9hj2ixDQmmtXlt8/3tg2gbxaZLVL3wL2xL0vuCP9TLFF9tfWgMVomXdD0xef5DHb07ZJ+B8cPrB3H0spcm8Cc68rEsYhKjMCQ3wEQK9oFinJnC2KM1Ffg51GkYXBp+qLSo0FAxWwd2ufZ2iuA72Ah7nM8GKxtnuK0hlxClUDoI9StZBPL8eltSD3NrRoz2FycOXaUu25Ly6E9LAnMzYnjwn4LxKgJi/bh4ebcjzUqUdm70mng0ocG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB3022.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(7916004)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199018)(86362001)(66946007)(66556008)(66476007)(8676002)(5660300002)(6916009)(4326008)(8936002)(2906002)(41300700001)(38100700002)(6666004)(6486002)(966005)(478600001)(316002)(33716001)(26005)(83380400001)(186003)(1076003)(9686003)(6512007)(6506007)(2004002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LIRIoPifxrIeLYq2OiE12CAdGqHGY0lD9fyx88YYD6zxiTZwy9eWvd6vUnq8?=
 =?us-ascii?Q?SWk+t/O1Atm72JiAWYA+yFLbXuQpFY1VgnRiijmpBeKYBePVMXOe7cTmuGLH?=
 =?us-ascii?Q?8uBPa4Q7CJAOCJpV77NkEWk85dco9rrwzOYM2v39cNvmH0TytuIHHyWV+D3h?=
 =?us-ascii?Q?/vE7TC++l/FTeQoisMGu92zCMBZ4kFxGpsvVSo0GCUUSReFCeV6OU++GTStw?=
 =?us-ascii?Q?5VlWWZ5GFKqtfpxKDKYTKF/UvGUudEnaSWGTC+yM8I9B5qQRoXYIOyMKHK1P?=
 =?us-ascii?Q?aDEuxMP3cFbkYxyGQ6osJKV66Xk4mRi/b6CxRpi+JPuln9A+y/3/IhHcA+g8?=
 =?us-ascii?Q?IzO9Fpr1bTYYka+rlqQG2rFIG43EJQAobfYZH6504dFrVzmT5KjPUThmnchK?=
 =?us-ascii?Q?GxTH/d3tzusFvCZJjIdAeTH8gKZZ7DpmWcqGvWz6UKAzj9J4n7emlQOCbhZW?=
 =?us-ascii?Q?tVZJ8b0JxqKkYcfLkIPiP1oe+16VCetcDLddpKV8eUherJIxHaGUbRkF1bs8?=
 =?us-ascii?Q?o0Tw5lVgdO8uRbjPF+axF8h6OpE9KYtQitVKL6j5Of1QS9WzGnEJvZqA/rEq?=
 =?us-ascii?Q?JUTJvFuj4cNifN0Gr+2/yqul2po80+mmwZZOGc7TIxOcDwVafsDDMeA3EAAr?=
 =?us-ascii?Q?+hKeSByX7A0XoPNAW/+nqSAIBCzcSdlppqAz9cQQc5rFhtcdsQPQ3sy78KNQ?=
 =?us-ascii?Q?zzTFTfnJPgJn9rAQ1VAHSG2ieYM8JiSMMCJijfz6CFQpowWVomOAIBYul6sI?=
 =?us-ascii?Q?X03kvwAjjb50QPnMCsbsrYuFkkrmb7uv5K71G3L/c2VhrrlBCTMbY2U7c5At?=
 =?us-ascii?Q?Rt17XF9MuV25Dinm2MsH8o33tjN438sqBCIeN801bmP2b5TK/9Np2qAZ+6tT?=
 =?us-ascii?Q?Tu6kIZxSQZKll6dMQgYwdPL6EvH6YT/Wx0gJMCH119dJ7MiWP44egIGqM5J7?=
 =?us-ascii?Q?I8VVaq0paoYs4WvE6PNtyKjIOcnFPCIPOX9yoVxPeHxhTDEHhPJNiNfsdHJs?=
 =?us-ascii?Q?jRYy67PTJX5RKL7/jtzpz1mepTVyF7bju0cC19avSrGTldNB130TfXc/pyqh?=
 =?us-ascii?Q?D2qacNkjnR48Wh9M7muX78anmqCN5NesXLyAgWDIyJYpkvVHqaWuJnmxRww5?=
 =?us-ascii?Q?SDcvL+pwtAPrIv9Dl5A/R26XXvpYHFSnoYaeThSQAVYwH2NNtUXfYwKhcXdo?=
 =?us-ascii?Q?xtec8FT0oPaPAAhTb8hlTLDzSg6m2KD3j/HOKsqdb2iSAUgj5MfIRYldhzxW?=
 =?us-ascii?Q?v8VEFG1HRMH/55XrndZw/8PgBOR2/QZm0xYuQ+ZXHp5CRxPI71P5K5J/xyeV?=
 =?us-ascii?Q?bhRle5tZB0aIk1HkWbZLziUQjctD+wVzz2FMUlqZwrc1UG0YxAxw3I4JdW0t?=
 =?us-ascii?Q?NeNFN9xSi4SC9XB5Abm33DXsLHBQokBfn5rAMuO4W09YijazRWCnamibd7ml?=
 =?us-ascii?Q?XQDq+U1sdSWuul91MiUSB5BFS8NcINRVp1yUVqLpwTZ1Oe+vwBX1SBs2wbB3?=
 =?us-ascii?Q?KUGQH2xOSApVU6lA9D1qPAecwbAk7e5m2QjGsqevl4QYkJy6D+Z17dP/1R77?=
 =?us-ascii?Q?DRY+RWSX/iKSgTv9qbxcsQX01BeK7+Ro9Rl2rkNqus4ZFwZos9hNxoAWZN+J?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hrR2AJq7s9oKP7SNmlsUoB2RH9kqWZzExZHA2kj3URR7nYpdrE9g8r61mBuTodGrEOzS37irfs9Amga5tw+1xKP8v4jbI0H2q79u0Buu6AuEdXuOo28O/HEu/sOvRnZURma8j98LpyDC9IGtZXRICOdDyNCc5thc8SEmF3hnhbRpw6jJaoQHkc8C8SaMijL6r+mOkaXnm0HI1kSma6KshV4xlqorMEL4kLERo0whTZEVjEyUyk8aTvTjX5q2dORSic+/PhLgvJv3ccKRw/h3OBlkoy5Qs+092v8Dqd3SOw7YRivQrRMaC2aR5gSCexSiyo2PJ2QlwKQcX9aEcjZzhaQUHBrvZAd96sqrIUE58HUlROcwAqZ/VAFnz4wfEUKUfM1cymTvbo25ThBZncGrfyfGlZlB05FkcK3vj1A9eVcNf/3R6YNZZOfUtTkdvOav+jShztUkryVILq5JoqsjjcAJ2S8Hy28pZOlse5Q4eOHz5aOM32a482b+XyYsbb3LSSAEwFsk6ieDion6zJqj11uJxeoPTp4cr1h55PVY6QcS0kqfm6d72Viujvpo3oyqKMF8ckXmGOjFCTPTpr2h/npAXus3l4Ls2kW21TAw1OF5NQAI2mH2rogj0OWk5SqCRhPLS+nwMDOerD44E2Io0KErPmTC3yfrotiEJoyMPlCJm/C/aZymrmUgSwIHAgbBbiF7fxmIz7FyICGFMr2OOt8LzZ4PynMYVj5k8tnP9Z0x3PB0BUgwtF0fM+hu8dbk5ZNf2g8/zY8luk+HlpafFg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8430a40-ced8-4365-5b57-08db1a6f6821
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 16:09:59.5484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msavISuwYELY3VOyphsbvyyqiWp+yo6UBOFcfw0hdetAtiFo7kYXCzNO8A83j2/5JUS0JG+1LzBZvttbGvduDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_13,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010132
X-Proofpoint-ORIG-GUID: jTEAuFPmYfe2wQ0l_T-WNo5T26pyzvBY
X-Proofpoint-GUID: jTEAuFPmYfe2wQ0l_T-WNo5T26pyzvBY
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mprotect: Add mprotect05 testcase
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

* Cyril Hrubis <chrubis@suse.cz> [230301 10:27]:
> Hi!
> > Add a test that uses mprotect to split and combine VMAs.  Created to
> > ensure the correctness of the VMA iterator after a bug report.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217061
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  .../kernel/syscalls/mprotect/mprotect05.c     | 118 ++++++++++++++++++
> >  1 file changed, 118 insertions(+)
> >  create mode 100644 testcases/kernel/syscalls/mprotect/mprotect05.c
> > 
> > diff --git a/testcases/kernel/syscalls/mprotect/mprotect05.c b/testcases/kernel/syscalls/mprotect/mprotect05.c
> > new file mode 100644
> > index 000000000..36f137544
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/mprotect/mprotect05.c
> > @@ -0,0 +1,118 @@
> > +/*
> > + * Copyright (c) International Business Machines  Corp., 2001
> > + *
> > + * This program is free software;  you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> > + * the GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program;  if not, write to the Free Software
> > + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> > + */
> 
> We switched to SPDX long time ago, please use that instead.

Thanks, this seems to be the wrong file anyways.  I've messed up this
patch.  I'll move to SPDX from the right file.

> 
> > +/*
> > + * DESCRIPTION
> > + *	Testcase to check the mprotect(2) system call split/merge
> > + *
> > + * ALGORITHM
> > + *	Create a mapped region using mmap with READ permission.
> > + *	Create different VMAs in stripes with mprotect (exec & write)
> > + *	mprotect over middle & write area, causing vma_merge of prev & next
> > + *	before hitting the limnits.
> > + *
> > + */
> 
> This should be asciidoc formatted comment that starts with a special
> header:
> 
> /*\
>  * [Description]
>  *

Thanks.

> 
> > +#include <sys/mman.h>
> > +#include <sys/wait.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <limits.h>
> > +#include <stdlib.h>
> > +#include "test.h"
> > +
> > +#include "safe_macros.h"
> > +
> > +static void sighandler(int sig);
> > +static void cleanup(void);
> > +static void setup(void);
> > +
> > +char *TCID = "mprotect05";
> > +int TST_TOTAL = 1;
> > +static int fd;
> > +static char file1[BUFSIZ];
> > +
> > +static char *addr = MAP_FAILED;
> > +static unsigned long fullsize;
> > +
> > +int main(int ac, char **av)
> > +{
> > +	int lc;
> > +	int fd;
> > +	unsigned long pagesize;
> > +
> > +	tst_parse_opts(ac, av, NULL, NULL);
> > +
> > +	setup();
> > +
> > +	pagesize = getpagesize();
> > +	fullsize = 5 * pagesize;
> > +
> > +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> > +		fd = SAFE_OPEN(cleanup, file1, O_RDWR | O_CREAT, 0777);
> > +
> > +		addr = SAFE_MMAP(cleanup, 0, fullsize, PROT_READ,
> > +				MAP_SHARED, fd, 0);
> > +
> > +		TEST(mprotect(addr + pagesize, pagesize*1, PROT_EXEC));
> > +		if (TEST_RETURN)
> > +			tst_resm(TFAIL | TERRNO, "mprotect failed to write");
> > +
> > +		TEST(mprotect(addr + 3*pagesize, pagesize, PROT_WRITE));
> > +		if (TEST_RETURN)
> > +			tst_resm(TFAIL | TERRNO, "mprotect failed to write");
> > +
> > +		TEST(mprotect(addr + pagesize, pagesize*4, PROT_READ));
> > +		if (TEST_RETURN)
> > +			tst_resm(TFAIL | TERRNO, "mprotect failed to write");
> > +
> > +		SAFE_MUNMAP(cleanup, addr, fullsize);
> > +		addr = MAP_FAILED;
> > +		SAFE_CLOSE(cleanup, fd);
> > +		SAFE_UNLINK(cleanup, file1);
> > +	}
> > +
> > +	cleanup();
> > +	tst_exit();
> > +}
> 
> Please use the new test library, the old test library is deprecated and
> will be removed. See include/tst_test.h.

Thanks.  I'll do that.

> 
> > +static void sighandler(int sig)
> > +{
> > +	_exit((sig == SIGSEGV) ? 0 : sig);
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	tst_sig(FORK, sighandler, cleanup);
> > +
> > +	TEST_PAUSE;
> > +
> > +	tst_tmpdir();
> > +
> > +	sprintf(file1, "mprotect05.tmp.%d", getpid());
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	if (addr != MAP_FAILED) {
> > +		SAFE_MUNMAP(NULL, addr, fullsize);
> > +		SAFE_CLOSE(NULL, fd);
> > +	}
> > +
> > +	tst_rmdir();
> > +}
> > -- 
> > 2.39.0
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
