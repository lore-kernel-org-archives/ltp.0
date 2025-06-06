Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91C5C5AD49
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 05:41:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 016853C937F
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 07:41:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97C033C315D
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 07:40:56 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 64E25600CF5
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 07:40:54 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5563hEG6032442
 for <ltp@lists.linux.it>; Fri, 6 Jun 2025 05:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-type:date:from:message-id:mime-version:subject:to; s=
 pp1; bh=56A0PdRSb1BE9VU8khtRHoPJF71KtkO2Sajvmvb0Ibk=; b=rfXhbReE
 LvAR5T93cO/7UL342GNp8S2ayvwocVmWspZB517Ltl2kTiv/Nvu3B4QhSAoten+r
 FC65w60OqkAYM2J2jV7uA6EZfk1M2BWNVONovBskkDz1LYPqaZBQl+tGMULSgEMl
 AEPz4I8d/11Tg/vxirpLuEnOgx4pxu+MtnpZLvEGpEmZT4+AeY2yuSB0we32GRP0
 rPQvn3044OOp5FZSxdRa9n2ZAasIcn4yKozHUjpim0INOSGwf3KQI875EaREOku5
 QGTqAeYmZir9lUV3EaaA/w8d/tXirZjN8EtVHrkKeMmuTfraIm6vBZ8n+0ahRmdB
 Dzn2UK1pZoEwVA==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 473j1y1qjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 06 Jun 2025 05:40:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiLv+89M3nnblKDRNH0POo/Jg8yh2QgfXqQ+8I4w7Lwl2b4nb49bQHJCMZ8S8qcSqua5Y1moO3ZfOrQiSEVRM3XAxgdb40GSol4XxcfWzLEtfRPO0swH3jXp2WYxg/9uID4NaBCseAqX8fnJi3+mY7ilSAfKkjbL8pCgQAJ34xpuSvF+qP0d9U6F4lG36eWW9APkeun6+Fj+ImKMBQhx+e5slqw8sb6fOkX5+AxxRN2DT5gveQ0/2FSjTTzkDIu1McmiLTBCEe3L4LJRz5iZAiNtcvWO9Wohh01X1WUXfSz0cL1JnSbfyi6MJVJc2MYB0n+m7t8kFC93KodHro3VFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56A0PdRSb1BE9VU8khtRHoPJF71KtkO2Sajvmvb0Ibk=;
 b=o6YrZqEejB/PZrbdMpplXjaxsHYtU2p9nUakRVk6898FdynzRmdPaolkAPWN61fBQUsB+9UxYc/XoxoWL5yeqtKXVFWXCiX/i1NhoIljBP8ga7tvHkZ+WYvosPTIMZrDUwBL2WtuSKYdsl37Ibr9m5/w+KZbpa/4TfUWnNX2IDhqgzAZVj9SekDvOBn+ynm8EYg0Oy73Vm/EPGDgik38nO7Pnh5ZLzmpmCCH7s8uyuAmDrOtNBnSN6yvMHGLS2EyTR5wNqbNv4LNooLV283XO9Frf55SIQug9NE57KtealrF3Vg+N9ZFE9Oa8OKbNLUPntocnMBOO1ZyD4voN+VeUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in.ibm.com; dmarc=pass action=none header.from=in.ibm.com;
 dkim=pass header.d=in.ibm.com; arc=none
Received: from IA0PPF4F221E3C3.namprd15.prod.outlook.com
 (2603:10b6:20f:fc04::b1c) by SJ0PR15MB4185.namprd15.prod.outlook.com
 (2603:10b6:a03:2ca::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Fri, 6 Jun
 2025 05:40:48 +0000
Received: from IA0PPF4F221E3C3.namprd15.prod.outlook.com
 ([fe80::afc9:63ec:f805:991f]) by IA0PPF4F221E3C3.namprd15.prod.outlook.com
 ([fe80::afc9:63ec:f805:991f%3]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 05:40:48 +0000
From: PRIYA A <priyama2@in.ibm.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: unsubscribe
Thread-Index: AQHb1qVz5EGQ5YiyYU+7TuVGE+Hgtg==
Date: Fri, 6 Jun 2025 05:40:48 +0000
Message-ID: <IA0PPF4F221E3C3CC5891493E3F41A1311EB76EA@IA0PPF4F221E3C3.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF4F221E3C3:EE_|SJ0PR15MB4185:EE_
x-ms-office365-filtering-correlation-id: a6989a15-dfce-4614-ee51-08dda4bcb0c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|4022899009|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?4HRWaDaEuIsP2jooV+lR+5kRIzT+u6WcIyX/tAIha3jxLMPUKIwmEqXJsLbi?=
 =?us-ascii?Q?FT8wRRn1/vNzPS3EECOeEuH+haO/tGvQRfdW6fK0E4B3jLMj54x9+Wp4V1lq?=
 =?us-ascii?Q?ZUJCZmXNqEWOD6QuZ/YNUAzhCZE7KjZXrpeF+SalP/9rMdmvZhdBvFVpWHDH?=
 =?us-ascii?Q?vONx7Y1ShhAs7w8FcHIpvbt6/iNUW0E33TqGp3CTVSZNtMsJQYGRlCZ630Ju?=
 =?us-ascii?Q?sQQjbKJUm50GAcbBGh/80PYAV/wzKk4p0QI5yFdbZIvZ9PMABCW4SdYzVKg9?=
 =?us-ascii?Q?vLvcoKX44rxSEVfDJY4fvLr9rc6DgI57rQ71KPwHkU7m4uGtOKtbXxSknEae?=
 =?us-ascii?Q?bQ0ZE4umjn94PpOJeUB/R6s0vURPBGkymqqncEdrBUi8wl/c0aYenBaBd4ih?=
 =?us-ascii?Q?RBkXCZeO1IvD5VIB0rRBToZsWM4nTtMasTTuAMFV4PkfUX3jx0UT5ZuwdGb3?=
 =?us-ascii?Q?Y/L87RMjIR2IQc6EDswqjsiE65RxoCuBMpoPCsvk74dqo0MUDmphiT9osTs7?=
 =?us-ascii?Q?jtRFp/hSUYAlZWZuLe7QQ1u6erD0+mIgSWPehhddVoodmc5bkg7QZzP5UKtr?=
 =?us-ascii?Q?NvE9t0lU0MLj0gdDDLfQj1m2nx3fYxKd+gUxjWK4w2gr1K2p1YblLejtHXzR?=
 =?us-ascii?Q?lnNQBdxHFVszhxaH2y4eOMwollo0tl5fWPHwcUwHhpEKATVctvsfM48fRw1h?=
 =?us-ascii?Q?uWoIJ+YoSIWfGTDmHfn6WqKkHRArFyIP2LTkBne+wO7F189hoWuXH1uiTVyj?=
 =?us-ascii?Q?lc/4hqFVGLn+GduQfNPd+TENnrfBEwgHOjpBjJNxF9VGrq2naibSl1pKEVc9?=
 =?us-ascii?Q?6GfCQY2ZeGYnh3OqAwEwnWPFYmCx4VRCOSBAWbh2ndQXCTsnT+I827nIGcwV?=
 =?us-ascii?Q?v9LI0vXqQXxIVPjTKPoJeMwdzAw5pe+gC5RKJna3DzG6T5kMP8S0jpJaPddh?=
 =?us-ascii?Q?FSBBkWakxe5mEHhy6D/wqw785zR2UvwqzxiHw33W4+eCcwHm5q0gUrBdH4Sg?=
 =?us-ascii?Q?xANNKVioFvakzZ9gRa8BLm4ayqtrulfpZQxcsSe2kJWAyau3U0J61BXEKEE+?=
 =?us-ascii?Q?IJbJewLUMLagnem1Ke4/sQMi0KovfxbTV4vJj/eiTJZWaFTKVZnLgGySh1Da?=
 =?us-ascii?Q?xMOb81f81cF8kzE+vcLr2Ex4U4MPKb0IoIASVfM0zD0qO1rjZdGMVCSx1b9F?=
 =?us-ascii?Q?iP7W82etaQ55zLkZ/gOnK2AFUB7ByaGMMbRvBOqKjvGC9oe/oyn4BMeiBgPb?=
 =?us-ascii?Q?yshfwe7kZM07xt3Bef3cH0eRFrWBAgEhM1gVQngjg7eoT6OIUVTMY5wQ+LPk?=
 =?us-ascii?Q?LlrUX7UgfbHKwbg58TzUOPzCT+lykPWazEMnwqiw8UKsRNdLDHq4j+x2xxJ9?=
 =?us-ascii?Q?upsjpgwzCuHOgAtYP4xjggGm5dGQyfHLGNRf5Nd09CWvdT9Z1xSnrECBIrPG?=
 =?us-ascii?Q?Yu34UeJnbX8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PPF4F221E3C3.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(4022899009)(366016)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MAX2I5aGKzBJJ6d7kTGKTxOHt+2RhX4IfjQ9uaMhDZEtjz3LeTT/pAuDwE78?=
 =?us-ascii?Q?PrrPf/134Ugs3/8Bl3z/RsZ1FQ4Y6+pam7A3+E/uEWB0eNLRGXxROPj/r2sH?=
 =?us-ascii?Q?TqCkGJaYS+8UK5ACad1xuYs8ai19n4UizMspIFWuzcBxiBX0stoZZmCWd5mL?=
 =?us-ascii?Q?FRguhGxnAxVWWPSVZqj1mOwgNgwhrza4ee5AcLcMCEV7xXjpSKqlxohgxKiW?=
 =?us-ascii?Q?pk2WELxPf5F9AZPdtwQAh1CItCSbn8yqo7mSUAeUwgY8JC38jR9O1VnisNMY?=
 =?us-ascii?Q?U5QS5mkY4DT6DIBY/rwmES0wVN1d2YDpktnEW51+cofHc55TIioWN5ccqeZ4?=
 =?us-ascii?Q?RI4T5E10aRNY5WlZLiSGWz9FMh7hb+fC/0veATEJEF9xcKIyQRHHEq4xwnSA?=
 =?us-ascii?Q?eFFYRTFyQDfEMMh9I7vnj8fpn87Ua3vdcj/a+0JYictd8RMZe+jwYWkSmHlA?=
 =?us-ascii?Q?L9oltU6oEIEvvdRFO4MSvyQVhwipG8lqgjE0CD3sHKaJarJxDoLxRG1tTy/O?=
 =?us-ascii?Q?rFl2gXCAfDC60lLhT/HStLItfxNRGFFKiYP61TQxtAbln1em4AfKb02E3AM8?=
 =?us-ascii?Q?V+Neswl0OUNqt8pm5eQe6HuAncaBLKBNtJsvQHR2waryYGfFwbICQIuYfY4X?=
 =?us-ascii?Q?PL7eXsRgwx7uEcVgeGUwaEboRKZgFUDk/fzNe91+0+oaTFRDz4SQ4olcqOt3?=
 =?us-ascii?Q?CZrIzSuXRJvGmURoMil6vcZAJv50Yuvur5StefUSO0SEZvEjW5F8DC33xjbD?=
 =?us-ascii?Q?+yihpyCWJc3UC32xWbXBc92lIUKfTk/0GtF5nWXtsWN/I2pzaDZejfytanu7?=
 =?us-ascii?Q?0QzNCJy1DPsAkbdTGcH2alXULgua13OCoTpgdSGztHxTzri06NVITxgjoJ82?=
 =?us-ascii?Q?vEn4iYnNx8Tasm1lytM8ppap7mjNtfO0DnfG4A4XVOqclheCzTExygJFQ7GT?=
 =?us-ascii?Q?s+yawlRQvSq8dB7EURp9MU9ugCkAiZtj/aiBYGbyCWtOdunJYKFvixTOSt+0?=
 =?us-ascii?Q?uoH9lDTl44GcWTcM7LPgFX4IRMi0ZiNuocKfmJ9C597DkStLiIOBYCUKmuNe?=
 =?us-ascii?Q?+ZMwBx2tzIO3UGatNRL641GCCMvDGHNgdmUNG5uYwV2fPj3+uU/ANGRGRBWE?=
 =?us-ascii?Q?w23KLU9Oswvs3UlmX3RwotE4Mr1JEecf19Q1xNwf5w0pdeci2LwZGa+wxx7J?=
 =?us-ascii?Q?8mNfLm4GET+3y7yPi68zB2bOUFdyt5ZkVnuf1XKh8nV6XOY796aIp8sTOZqv?=
 =?us-ascii?Q?Kwv5sl1bauZcJKSqJ0wBmv6b6VAev3c7mJpydPrrewyLnWPJGY7xXtVRt8o6?=
 =?us-ascii?Q?o3guRQ0K4Dz1B5WRGd/RlgrM6R3Rz5dkisNeS33Ead1LODPl50P+AKj5H7VQ?=
 =?us-ascii?Q?cRwEFhnORcsqYOS3mqNpZlqLe7xBEkX/roHzW83RTnYFdGlyfpVoErLYz/gl?=
 =?us-ascii?Q?RigpgNn1wKv3jjj8nO3XaM30OyQ1tWQpR84ruvkUpu3TkupqOAktmumT7pnt?=
 =?us-ascii?Q?pee+J0RVKoduozUMwdHbuARD+lzcYu9byjvJfJ2D273yH4B8meAHK7wUlSPB?=
 =?us-ascii?Q?VUmPAHKSMMoeprH/NJH9eWUpSlGMCAwXAeEYU+Uif90C6H4iwp5VD17MJ1SI?=
 =?us-ascii?Q?Dw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: in.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF4F221E3C3.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6989a15-dfce-4614-ee51-08dda4bcb0c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 05:40:48.2661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DULfNvu4fUxy8OiV5cY8xqg4lmMcBhojPKRRdkZb36qMaKVRNDLw30LSlte5LfIrQHSNVvPsnx/BGXsQngvqUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4185
X-Authority-Analysis: v=2.4 cv=Nezm13D4 c=1 sm=1 tr=0 ts=68427f64 cx=c_pps
 a=YMoqzFPP0rmi67lb+G4OcA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10
 a=_EeEMxcBAAAA:8 a=aa8A4Dfp6KL4WFzyChQA:9 a=CjuIK1q_8ugA:10 a=X4NfE0mPVp4A:10
 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=LW90t1ch_1gDpv6RYJAA:9
 a=R7aFNY8n_ZeZgrzI:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10
X-Proofpoint-GUID: FDzbG9VmPFGN8zX3Rqge6kpwWeI2o3gx
X-Proofpoint-ORIG-GUID: FDzbG9VmPFGN8zX3Rqge6kpwWeI2o3gx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDA0OSBTYWx0ZWRfX3GQCbSsz3oG8
 C4BjQ4HEHG0j9lD2KADeOwdC9D3m5NCqZAI3CjdEN/IfpJGpagALnyxrqyRt68Ge90Rk+dZVEXX
 HJcg3CDbs1sXzlEo8sjFX8g2PHHUDj5+YUORtNf9FK1qnrjz4HdoBcsQztj/csKTp1c+iyVR0SD
 euwj0iF7gNlbPF+JZnbClQnF9qXvV3nZMkpIekXGr02TMqQxIhBie7KNnww4vLJSKBQcEjeco0U
 6o4wAsIDR9169qnvE5xRLNM6oLIYJpLixuagJ4qoL+NhSOcGH1MIQF5xHenpEXnnltQ6MMnkF3K
 6pFnJBV2HU/v5fqIeXv3FSrq5MBjN+vKcHV0EiUy0SHjqjHxwCKJUHmQE2tDiTJv3PVzy9RgRRS
 e5pIWALPZ82eOTD0q8FJe+/IYj5g6OPxnJPp2nNhKtk+nPE1OxREhZ9HJ2RG3Tnso7/BHvKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_01,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011
 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=627 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060049
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] unsubscribe
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

unsubscribe

Get Outlook for Mac <https://aka.ms/GetOutlookForMac>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
