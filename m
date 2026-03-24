Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68C7F54AD0
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 16:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774368344; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=15ydoyCFLa11PeJnvzNJ0wXC1YgMD0ybxE7VHdDirPI=;
 b=bP5z1Qv3iDzEg4mcYvO03wv8Ac0U2t9IU7X2ppDgqSFI50rJMXK5p19KdE3cyxHzaH/Y1
 TeVSg/Zh2kLiNngVUsVkAnilGivOAvDF6JZKokD60PJrvgCZqWOXnidAB//JZ9UOY7lNx0U
 xbOkIR+FT9MrrfYSm6ctR/55RXsMrcA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78C223E1712
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 17:05:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 731233E1712
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 17:05:22 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3BA8510006AE
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 17:05:20 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OD2KMu2755971; Tue, 24 Mar 2026 16:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=tmsm49E/Dmwe01idk4wUTCu47YelVp
 H77RMVelKUAUs=; b=OzH1FOPidvpIx4VmaEws4Tq+0IPVzibEGUVAt2Eg7U8S+6
 W6AoyV+xX2hiqudXM/l0SfRq0lS/Zu3C6TNqtXYREO3VhOUp7sIWFTwj0x+tP6Ea
 g3SUsleeVl8AxgEzSUR8tTw0UYPyyzcOwfswJUNpwU9LfZ3wzBTZxsaHRzRdemdJ
 TaDvBDjDV8MvlVckCUM78drnu8+BROQp0UvwPJtbsH+a8lCR6JiObrpOU9m63cRO
 t9Sx2FQzuLoUlTruupZ0/ovNdraHWsc7rWGoYDi47AfmLiLKqxo3W+AV9INX/3wi
 Ht0ayuvx3dC71JakraCwAHENL0tr3uyk1Ek53DLA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumkve0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 16:05:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzCc8fEohnOrZl6k/XNtlLzXO8JkG10RgIwhsrcS2NnrE2gDHydIUkgii8vaiETpp+42sgvzu6gCB12tiVfDGyAqFBpCvY0JtDh+yyAbJY3XLcOSltZ9DoI60oVR9tpwsYAz0nvA1PEUnrI7Vxxyo6udZAgP4WEkBwUb275NyDEo9ubaAUrR3kbavj9xKNbZWhEoqWPly0MwB1ZlDQKIBlP5S+crK2soZJyHH93E8x+faoU+NQZhG8qOBz/WXbNf0erxzjbd2e5ONqQoyElachyHLVhRcAdThj4pR4XmaYvgwK2YGPp8LzPmLOPEc8VWZTVCbpk6dOGWixFPwuTHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmsm49E/Dmwe01idk4wUTCu47YelVpH77RMVelKUAUs=;
 b=e/VA+JSyBhZ+E1Jd4MHH4LBy94Ss8Q6BhoLpuiY/0XIsCOUWcpNO3w2WeyP6VMaXn4Qla6GjBwKJL+lX72fUpm5ln+Nahe0IDtVv5ygYQc3hyb51CsOfXR9ppJjsNUZcz+OKBcy5LKZL6XNCwYPjXPSYo91DqRasBuDheewBQmRbDUYc3jKqPB7nqzRT7GoWTAL34QRqO/mcNTSy9z3st0pS+NjKh5r6wJbDu+9nXHPoWN55dgxOvGefsP6wJLgDWk+xuLLbbPHG6Dmnb48gEpQ+FciYKA9v3toox5qkD3e4Ca8aQxFQY/5MPyYYvGkRJSTx+zythChrtLltSNOGcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from BY1PR15MB6200.namprd15.prod.outlook.com (2603:10b6:a03:529::5)
 by DM6PR15MB4071.namprd15.prod.outlook.com (2603:10b6:5:2b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 16:05:14 +0000
Received: from BY1PR15MB6200.namprd15.prod.outlook.com
 ([fe80::2e97:dd4e:4558:ec87]) by BY1PR15MB6200.namprd15.prod.outlook.com
 ([fe80::2e97:dd4e:4558:ec87%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 16:05:14 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [EXTERNAL] Re: [LTP] [PATCH] vmcp: skip test on non-s390x
 architectures
Thread-Index: AQHcu5f0ZXLNRg6keE6ZbkPvgH34l7W911kAgAAA2HQ=
Date: Tue, 24 Mar 2026 16:05:14 +0000
Message-ID: <BY1PR15MB6200533F558E9C523FE9B7C9F248A@BY1PR15MB6200.namprd15.prod.outlook.com>
References: <20260324143332.2200651-1-sowmya.indranna@ibm.com>
 <acK1AIOCm0qpXsat@yuki.lan>
In-Reply-To: <acK1AIOCm0qpXsat@yuki.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR15MB6200:EE_|DM6PR15MB4071:EE_
x-ms-office365-filtering-correlation-id: 36c224c8-014a-4801-0f27-08de89bf2260
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|13003099007|7053199007|18002099003|56012099003|22082099003|8096899003;
x-microsoft-antispam-message-info: gmp39oGqkrRcUgJIuf0Q9HCsqJWJ6WizbWAT1cRaYSoQ34YUJ0/3DJNfceSzLatBn3UlzEwcVqynRCzGVc72T9gY6ysojaGwL+2jS0kI5SIJRXk5qA8e23yPB2lGhjM8/KmW0Wx+weaqD+qZwJB42ELSYcLHYRrYQK43tnPaoQbDq5DEiyjXVA8nIZFRnMEwK4ojXDAg9vfJ68UEYy7XGwQku4YPIbY6UFoz85NDxJ4quEiY6IxWA1YTNInjET0jn/p0lLouYYDfi5f4U5xltngUC3EwJ3haM4J2iotKFHjrHJEyV1iRDtLRHXfQE8yvOFKc6B0pLk3wrDUeCznLup9HRbBFzOIFn3hd7zqBfUc0LVMShCobJzJAYHcG59EqSqtTu+BFivWmQ8J8tLXAQlc5B3LxIdU70seXg6brZpAWxh/muWhvXQLWCOZLPmpkW9T+nUWPMAke4EUFiOD7/oSq1IWj002B07G1Evw6Dxf9e/R9fP2t0KAboBqB/bApLsHqbqaRjrZcWlqDw5r/atnFW/YpTYHuZYVTqWvQrGSORDAnWAf52LhFefUWGc55gTDa72Y2KjRiqd5VnpYVwfJYitAKXve3OKsbwuT897ZY1DURSADemoWeNXqDpxReUXwN2+YjysH8sIvk/T3bwbC9xaRUdHpTdFFlAJ+r+FX9dpLYS6lY0iE+M1hshFF9vImAOAEzqz+ED/ET+7x/UhiDLOVZKAUJN/gPDZ/7klxqnzWhkUbI9Y4qeCEv7GluXKzFB4rbkIL825iHjMBLf2nje8bjTZeMAsoEGpql7j4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR15MB6200.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(13003099007)(7053199007)(18002099003)(56012099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CY1ym5wdWgr8IzW/hqddtefvgircXT1c7YBukemCWLwsC377/1d/NZsRVRbs?=
 =?us-ascii?Q?fuvI0PVV+zzUf0TRosiMbPd/EnirA23o+Dq+IYplqp3qykixjupQjn20/I/i?=
 =?us-ascii?Q?AmR9j2RBj0Rccqkh4rHgaHJQDk1odQH0QT4iFh74Vg9QoSW0U0yd67A8JPL1?=
 =?us-ascii?Q?4XjSEISHhTukfzWoNqW95L776JI0BwlAlOZ+Ban9mC5CDR63azQ1ozSdLnKH?=
 =?us-ascii?Q?fA/lvHxFd/kW7VlfhWPY+Cp6wpBF6dWJmV0VMrmB77NZ94nfrHlOORgzYwQu?=
 =?us-ascii?Q?wjp1H0fPX97pxjCUaw4Vmgv9sSnM9N7/VjILTsnw3OswdlJOCFo7DSfPaDko?=
 =?us-ascii?Q?MxDifm1ECEpyN5Gi/7H5FBYWsQKqmetOnsyNqWCZL01eSWIBNUxSbkA+CBsL?=
 =?us-ascii?Q?/D8UXPXMLgE9zYtlkpTGLI23traZm6tm/S4D3Zsz7pW8YIaJd5VuPAiYI2bL?=
 =?us-ascii?Q?77asn8xGF0YD4rl29FpWtdDN7RigDZZ+LbTCBrW0MjOPKo45MIKB0a3cjJEL?=
 =?us-ascii?Q?16S3JN678mEsMYlPsVpAJO7U78HjK+f3uutB1fKC8ygD/rKK8R75XQu3HLN1?=
 =?us-ascii?Q?TSoZf415p0OOHP/YJK6leni0mr3b447DB3th59mB48xOzqPyzjXsToK0lgF6?=
 =?us-ascii?Q?6h7cc3sLjP/0JIR+lKhDfLYm5czvkUQSb3DFAzo2YkRvMeqItWuvpgHJiZTc?=
 =?us-ascii?Q?cazRPwlcOUuWnBnU+o0mGcpGSBykqdy6BwXd1/Ks5czQNbSYidgLTViIqDNx?=
 =?us-ascii?Q?Gf3Ee6nbT2pYJocnXT9mVxcjLseOiYxXXupt4BVLNc5V10CZMP89uYO7GxWr?=
 =?us-ascii?Q?8mximMCGLEm3wrEoMHfpNttvSg8Bt0r3beua0Bx+/fjP2NKv//lp9e2peahp?=
 =?us-ascii?Q?aVbo2j2oIp60c9pf1wsMIiYCiW4XOFuR8Efbe4D6dB2kGwmG85ih5mNibCC6?=
 =?us-ascii?Q?g1eiwk+tSd9UlhFF6KkcsTsacprZe5JZwQSAg9dPhJxGwFLlFiAkz2JWePNy?=
 =?us-ascii?Q?rFKnTlKweYyYsx44J2oPLKeOizwUV37KV7OmmZA+OLv0XbasM36/Z8hi3uSM?=
 =?us-ascii?Q?m+YvjJmXtJ2r05DE/9OU5d6iK7gLotDNJRYCD6CjAww1fyfuth9CWjC9WbKw?=
 =?us-ascii?Q?OqejhsvoLBjxHtqGuOsoDKQlaVjCCP9Qkik31yuG9P7sX8mQk+G4H4Sp3VTR?=
 =?us-ascii?Q?SOi7MfHz6BxzkVNShuRaxuKXztV5cndqIR2am92sGAo6Mt2eKlvGyl6MK9KL?=
 =?us-ascii?Q?YmQywv9yrq9R8S3n34iCJdcl5x8fK/88sYLPImr22iffdAgAvMuuALINdGdW?=
 =?us-ascii?Q?cAq9qFB1DcCMBQ67W8AASL4685RTDhob8ktWRRWC1AlDfc0de8uP8mPzVlgk?=
 =?us-ascii?Q?gZsRCY0aX98BKqvnvvigM05myIesuZYvRrGcIeGPxHHHNyaP3qzh24hz2JCQ?=
 =?us-ascii?Q?185SCcmXG6JENL/tfASmauGlAa+5esxaMVrHP9i886WmQw9ZmB4LrmLECndY?=
 =?us-ascii?Q?0qUCrIFpW704emEAN13BvKea/1JUmXCBit/NoKBgbFgqRqnoDStkJ57OuAdG?=
 =?us-ascii?Q?vPMdmD1lhg0AtfPc+xP5F2daB7nrDY29G5WyaKh36DLasEraFAmEaHkesuzH?=
 =?us-ascii?Q?f+GrK34S3naHqi6VB8aydjZHsatzsD21YQ9FCjhlLLh7Qdav/BNnoO8/OiOn?=
 =?us-ascii?Q?IsQKZuPZ5qGSFwBIP8xDzK0c9FNQwGHRPyzkGyEGTWvZ9RWvRztWsAt1WgG1?=
 =?us-ascii?Q?J7LM9UO2WA=3D=3D?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f5NoNZZH/nQj+8NQWD5FkHxK4KWmmRPYRVj2vVpxSoab0caOOyheTUTjmEeqXiy3bJAs1XtxK4V6t8CRasVDdFaganUVi9xK5jVwUUUwGLkLIsZOoiDle5VmZdEpO6v9EZ++qRlJENr0eF/qQGEvFAsvRzRns9xZD4g+NDBzNOKkaR3YEzSji/uSKHGEXEPwXPez2W8EEb3EkMl2M3K0iLeCq7J1RSkPImJtODDxNqj5XYAuCRie/DU1SjGbjnYCDtDIuahzT8RUgb96s4x9xPlLbrpfvvPYoaP2UHRF5f5QfRgpg7GZk0tfe3P86c+iZYhvKme8Uynv3ZTOepA7+A==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR15MB6200.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c224c8-014a-4801-0f27-08de89bf2260
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 16:05:14.1626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3qaEZk7L25NhWrhnGn2FBEbmvE3BU+wpnBE/laK6XFwJSI6wNY9n7LHk/uAnAJmjNRHqEx6UCWb05hUcNctoWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4071
X-Proofpoint-GUID: ZjSR2vKgalmr2HAyu9HSvf36cWKmnas5
X-Proofpoint-ORIG-GUID: ZjSR2vKgalmr2HAyu9HSvf36cWKmnas5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEyMyBTYWx0ZWRfXy3+BQ3TXIONZ
 OSDt7QUDvUJsfU6GGecT922PvCe5kn1sKBb3GqFhVJCvIKsmMyLdwTKoUcZi/K0s68OQfM8DlKH
 wXmr0Kcn6TeVHcrSOqv6QYJTbAc4j9LA0Dtw3ngyoPpmrn/T6/0t5yePZTjVWn8+ejjdU4xmHAL
 yIEQJ3htw3B2GwxaG2DYoNEScJ25AJs7Fyl2swdlblNW5n37+I/d1hpaS2eF4VYlz6uxnQDgUWu
 IFvKqV9MjXb8HbXMR7TgAHRTTx+wRlajr+4tYdI2NAyAcaepq/jRZ5XXAO6J9F9LEm1CLHtdAQx
 rodqY19l9QXYkc1JrL7k9IKAqdo+2ppDcRK7fVQIUxuqrl1HFmNMuIyJdlVCqB0E6rFSklLgyJU
 CpV9BKoOD2Z94DBAxkJ1pya1m02lxBobzxCTiLNmP8KK4BB2wgTr4SW+T4LUYZ6rO5ttFslsqVN
 WC8D0TdxnYC4tQ2sdYQ==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c2b63f cx=c_pps
 a=3TwBhgzW/NSYP80ElIqEIA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=k7m-P1l7ALv2vkaqAJcA:9 a=CjuIK1q_8ugA:10
 a=IxdTUQ69qPTfC6lo:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240123
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] vmcp: skip test on non-s390x architectures
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Agree, the test results in failed state when run which should be part of skip tests, complete details are in the issue https://github.com/linux-test-project/ltp/issues/1298 for reference.

Thanks
Sowmya Indranna
________________________________
From: Cyril Hrubis <chrubis@suse.cz>
Sent: Tuesday, March 24, 2026 9:30 PM
To: Sowmya Indranna <Sowmya.Indranna@ibm.com>
Cc: ltp@lists.linux.it <ltp@lists.linux.it>
Subject: [EXTERNAL] Re: [LTP] [PATCH] vmcp: skip test on non-s390x architectures

Hi!
> The vmcp test is specific to s390x systems and is not supported on
> other architectures such as ppc64le. Currently, the test fails on
> unsupported platforms.
>
> Add an architecture check to skip execution on non-s390x systems
> by reporting TCONF, avoiding false test failures.
>
> Signed-off-by: Sowmya Indranna <sowmya.indranna@ibm.com>
> ---
>  testcases/commands/vmcp/vmcp_m.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/testcases/commands/vmcp/vmcp_m.sh b/testcases/commands/vmcp/vmcp_m.sh
> index 3924a6e11..e40dec4bd 100644
> --- a/testcases/commands/vmcp/vmcp_m.sh
> +++ b/testcases/commands/vmcp/vmcp_m.sh
> @@ -15,6 +15,15 @@ TST_CNT=2
>  TST_TESTFUNC=vmcp_main
>  TST_NEEDS_CMDS="vmcp"
>
> +# Check if running on s390x architecture
> +check_arch()
> +{
> +     local arch=$(uname -m)
> +     if [ "$arch" != "s390x" ]; then
> +             tst_brk TCONF "vmcp test requires s390x architecture, current: $arch"
> +     fi
> +}

The test has TST_NEEDS_CMDS="vmcp" it shouldn't even start unless there
is vmcp installed. And would expect that vmcp is not installed unless we
are on s390x.

--
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
