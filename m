Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691D4C4332F
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 07:06:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FCA33CEADF
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 08:06:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD2523C8938
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 08:06:08 +0100 (CET)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2FBBA602963
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 08:06:05 +0100 (CET)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39U73U18024274; Mon, 30 Oct 2023 07:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 PPS06212021; bh=yQ7nVTBtm1yw/fOBeVdl9ZPF71TIkRZS3LzmozqdIwE=; b=
 LP4LF2QCyF+KPYnsE23wdiOffzNHU7fqt8faw+mkJxmNw30Jx9u5WpEcTWkPGk+I
 efLl1sqZ0+xeUf+nkTQR1AucgLU1ZM9ElLGcKDYJ7G7pzERTzKFjvmb1Fgv9RbZx
 jejmIcSa7qJwTiX/TG/L/Kwt36nHiqL1z8JIUbHbQrR8fYKW3pciio/qEZP6eDtf
 m0Ky/yGHxKpVwMr916HzzFQXSJLqFVWSDN3EXN9QTOXHLzjYuKGSvAdkffMizuzd
 g5p5NcsTtVUcsK95ItTDOk86InmsAt5nMjAu2se5sPrLjYMtKWcE115gzLpdtZO7
 4LjB/i9S7cBHUOnZZU2I5w==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3u0qgxt0gw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Oct 2023 07:06:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ikm1KQ+FD6B15cqAXKpV9LM7djuBO4W++pxc6mkXcQN1y0MIhHl5FILMJbivsH3o7n+qUaFO4VjqLhoEL3BOwS9zXO51yzh4oTlGVFxcgB+HFPRcm+lXcuaG4bqkyBUaiTgBiovQ6Tm34/l+mNQVFQPVtyJGrzwSlMcsoKwIo0gqO8RyQcJU6S/P/we4lZ2VCjpl09yNyRGZk5+Nz+Qk0JSRT7DsIUX3DQnZoaeZd2tYrUgeXCQpkONLmuB3g7liuMqcnZsOVp5KbgXNNxeMTk6dz7W9mCs9lrNUAfyo11vo6Ig56LfdbNNUrRsrG5R+qSRwhdwIIrg3KYzh91cbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQ7nVTBtm1yw/fOBeVdl9ZPF71TIkRZS3LzmozqdIwE=;
 b=NdnOwDEyjOmKfu5fST+VwKa9dlTxYK+ueizPY9G4rhg9fhQ+MjKIW/t63mlyCOHFVI3vLW3gAvgTrIzK3QAHKmAjgxVZEW5pOiDgqHQvKpkwegxaLBOhLZYh4Chir/7q9k+5/eWKUYSe8wg2B1ZcwnRwBDkOmixW1et2ltCGkxDMWy4XS1b4PrT8wKm/vVyJCZuoz3ibCbTqTS6fCM9MCluhPdKH+Ay2dYcWc9tXAbloqfZBq51UIF2DzMPxEtMVcXFzIr97d56Zt98EMMBhHouQPMZAl4KCLhQbzNoy+maTmO5ZEOro/GCgX4ot3c8dXxRJFoCexw8CEl8GDVHP8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by SJ2PR11MB8470.namprd11.prod.outlook.com (2603:10b6:a03:56f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 07:05:59 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9f52:2999:c2f5:729e]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9f52:2999:c2f5:729e%4]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 07:05:59 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Thread-Topic: [PATCH v1] Rewrite fsx-linux test
Thread-Index: AQHaCN9x4eUyTLqjxkisnVHG23/5K7Bh42Ig
Date: Mon, 30 Oct 2023 07:05:59 +0000
Message-ID: <CO1PR11MB497902BC56CF9D0B6EBAC9B395A1A@CO1PR11MB4979.namprd11.prod.outlook.com>
References: <20231027140858.28829-1-andrea.cervesato@suse.de>
 <e1febc9e-f4c6-4735-8b45-9448af30df1c@suse.com>
In-Reply-To: <e1febc9e-f4c6-4735-8b45-9448af30df1c@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4979:EE_|SJ2PR11MB8470:EE_
x-ms-office365-filtering-correlation-id: 4afd3442-8f0e-43d4-6c17-08dbd916ab7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qL1cu/yj180yr9LeoPlekpNkUvgo4RLAPzwxnZYO7JKwryu88i+j+Gff8x8INmQy2bwTWkLmIY++/OJEBsodJXAG5xIEU4uS79nObNZvzUUjUqfkiO6yjQ+CEoJgp4Kysh3mZGvo1YFRRHl1Uuag5i/o6IGD5L8yD4jOa+xcdMksxv4dFBzIq2d36hYASPho2ALPrfkhB328VOHsp8z3ugIUsrCQEIBeGV+BEvhBYt/9KZdqSXCN+KpnwLl+ycqJV5OZhPM0BXKmNrxnac6L79fiX0ncdVBGSMOZj3FGK2eHWBr/YW2DB8mDBC1Ct4S4tz25cX74MQmN48GWI28qpkrlK0D41fH9gcSgBQs4cEdPyr+Fps6GsH1RSHP796PdO0eLR7hNyPOUGB0SoHPsS2raUNXEIDV5UWcjltS8PyQagXGXXqzSOQrwaZAjpUmYY20Cp4WwbtDfxKg9FU8Dti6Y/HvHYD35sBg4295brfjEdbh2oL8sunCmSBzQayrjLHl3OZBweIFSDHRZ+ikpRvadNeuSjw9mmk4qWkUQFW80dVzxWQQjO7zxtUEYCp+XpP4jHtY2IEeOQl+bnknKhoA2dsbPp8vdZFNvJUxvSZEpy+jtn5zL+Qmq9w3jaimF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4979.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(376002)(396003)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(52536014)(66446008)(66476007)(64756008)(6916009)(66556008)(76116006)(66946007)(4326008)(8936002)(8676002)(316002)(33656002)(5660300002)(41300700001)(2906002)(86362001)(83380400001)(38100700002)(9686003)(122000001)(26005)(38070700009)(55016003)(478600001)(53546011)(7696005)(71200400001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWZ3ZXF3MG1Ma3NDaGlQVzJYcGJBeXFBcGhXSnUrZkIwRUJHcW5iWHRTYU9n?=
 =?utf-8?B?RFBvU2R4VE9MR3drZlpJSXBxOExjOHVjT3NTaUhCcGd2NXJHNGZVa3ZKOGtT?=
 =?utf-8?B?dHdhMXB3QUVDc2w4NUhTVmtVZ2ZrVUllVUpwTEtpSWx3Vmp4bEJDbnRaS3B2?=
 =?utf-8?B?MDlEVUxpdVhRWmxvbm1QL3hIUEQwemEyYTR1SnhCb0ZQT2dveCs0byt4bXE4?=
 =?utf-8?B?aTVEZStBVnVYY21KTkQ2OXcvVzJxNHNzZ3hxMGxZdktEZ2xQZE1ZSlUybTBy?=
 =?utf-8?B?bDVlcXN1djcySkhseXF0TnB2VjlUZW1Ub3IxQjdJcTFpQnNTMmw0eU44THFP?=
 =?utf-8?B?ajJheDZyTCtPY1dROXpPeS9IdnJtNjdlUk5sR3dSb0wwTzhzVlQ5bjhJWFNp?=
 =?utf-8?B?UmtrN3JXY3Q2SnFXbUhGNnQ0eWN0ZDVSQlJZdjBEVVhualZkRkJ2TFhZMVE4?=
 =?utf-8?B?NjNLdDhuQ2FmQmFJRUlqblVSNlFWYUR6RGdMU2pXNHU5QVZaS3hhR2YwR0pR?=
 =?utf-8?B?QXN3cFhFaWtteGZMMWpRcDhHaEk5VllGMUxOamIzZERPendnb05qa1E5aHN2?=
 =?utf-8?B?VDRWY2RwWnJNVkxmWUQzcWNwcEQveFJPc3RiU05HTk1JRzFJY3Z2TDRrczh4?=
 =?utf-8?B?NEJkYUtvQUp6bG5CcVVtMnVZcTlMNEFROGdoL2pDeXJya1VGSFAxWFRldlQy?=
 =?utf-8?B?cHAwVDU5Y0VwSDc2NUZxVHMzMldPRkZSTms3dUcrN0srNll3Y1VkbktrVHd5?=
 =?utf-8?B?VG93ZUdVU25uVFFEQXFQVUYvTk12b2pPZEVSV2V4R1crczc2R3RMeWlSUWRy?=
 =?utf-8?B?b0pIY2xaRXFBd280dUZEcjBoQkdVUjNWRzRpQi9BTUFVMERlV0FWZHhaeTEz?=
 =?utf-8?B?L1NEREF1VzYxS0dzbmsvYnZvYVRLdURhWmwzY25zSjVWWUVNYWx6NVZRS0NN?=
 =?utf-8?B?WjUwdHA5encvUUpPZmgxaWYzb1ZWSWdnTm9vNmUyRDN5RUdrYml0L2t4MEFK?=
 =?utf-8?B?b1haUVAzNXpzUDV4c1RYUkR5NlFTajlDdGM4TVpxdHdKVGpMREtqYXllOVJm?=
 =?utf-8?B?QTAyV2dqdUpQRVpwRXRFMjBHaG1nQUZ5UkpQaGhFSWZzb1dHM0tnYTBtVkY1?=
 =?utf-8?B?bjBZaUFtOFVKdUhtRnhBd3VWdUpWeG1aWXpIVnBkRXAwY2wzK3llenRtM1la?=
 =?utf-8?B?ME9XUUFjdHlSaXllOFNyNDg4THNlWXVFVGRzZURrRlZnMnl0RFE1a2c1QzJr?=
 =?utf-8?B?S0hkbkJFS0IvUVQ5a3l6QVovbWNucFArR2l4V0xWWGlYMzJBYnJrcTNqbjhh?=
 =?utf-8?B?T3lscXBnQVVIOFkyOGYvbUpqdm9pT1pHdTRnOWprK2FXRkQzZzcrSlRieUNz?=
 =?utf-8?B?ZlZ6TElNQVFzZXQ0TEdBWlhQRjgwdVFMZlZpUlJRK3JFT1BkSUVLeHByRXNG?=
 =?utf-8?B?NitjTndieXpJZ2hlRFZUS04zajN4VG1OVU9TUVFsNXVubUljWm1sNWNzdlBi?=
 =?utf-8?B?Zkkzb1VWUkNxbXhVUjRQTnFvM2g1dXJ6VVlmMXlDR2NDMTVGNGxadm54cHd5?=
 =?utf-8?B?QVYxS3JPYTVBb0Z0YjJVdlZaNWtsVmZjVzBsaFBrU3hzcUw4R25EMkpJU1Np?=
 =?utf-8?B?alFSZ3FrZURPa1VBZWkyNjVrWHgrbmpUa3paRTRXOEcyUy9mVXJ3b05BM21J?=
 =?utf-8?B?N1liTWlnR2pBcjgwSjJIbkdJTTBlN0dkdDRTM0tYWXNmWWJ1elhSa2JickZ2?=
 =?utf-8?B?WEJWRG8xNWpZMkwzSmhWSGFlUzBucUpIMVFDcjVzQVBvc3RycmYxa2ZhMis4?=
 =?utf-8?B?ZElKcUJkcGRkZlZiOG1NTURZZFQvTzQzMnZITE9IMHVSTDVwSlc0Nll1QjBM?=
 =?utf-8?B?cHhQL2E2RVc5Q0dhOU9LVW16TDRySWJYdVZBQUxlLzIwWnRyRGNzeG5ZeUhl?=
 =?utf-8?B?L3I3L3hBUlNNMmQrWXI5Q1pjRUJXbnBxczNicUZuY21Ia2d1bDIvQ1NRZmgx?=
 =?utf-8?B?N0ZuTEVGUjNjcWp2TUdDNG16dTR1d2J5eEZWN003OExmTDh2aytwdStrakxz?=
 =?utf-8?B?MEs0ZHBra0NuRm1TY3hkelg3ZGxpZXkyaCsxVnFpNDU3MFFVbFdiV0YrZWgr?=
 =?utf-8?Q?FHYASaXs6J7++A/UclizXY3LI?=
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afd3442-8f0e-43d4-6c17-08dbd916ab7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 07:05:59.2541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2G0qtVeskFA/MoRBO8D8WgNrYrRKizTZZglSPtbbABq2ewIYssFQgb2GUKQM9X7rLTmEkBO8MwQTjyUKOdNQDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8470
X-Proofpoint-GUID: ajAQlWTbvAVMSv1lS46BbFQocLiO5L4L
X-Proofpoint-ORIG-GUID: ajAQlWTbvAVMSv1lS46BbFQocLiO5L4L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_05,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=606 clxscore=1015 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2310300052
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite fsx-linux test
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
From: "Wang, Xin via ltp" <ltp@lists.linux.it>
Reply-To: "Wang, Xin" <Xin.Wang@windriver.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Andrea,
> Hi Xin,
> 
> I had a bit of time to complete this patch. Please verifies that it
> works on VxWorks.
> Thank you.
> 
> Best regards,
> Andrea Cervesato

Because VxWorks doesn't support building LTP test library now, I need find a new way to support this patch.
The old version fsx-linux.c can be built alone on VxWorks and used in VxWorks user space because it mostly calls POSIX APIs.
I will take some time to investigate if VxWorks can support LTP test APIs. 

Regards,
Xin
> 
> On 10/27/23 16:08, Andrea Cervesato wrote:
> > From: Andrea Cervesato <andrea.cervesato@suse.com>
> >
> > This is a complete rewrite of the old test. Some options have been
> > removed, since they were not used by LTP runtests. Also, the new
> > test is not skipping any operation and running a new one if the
> > previous failed, until the total amount of operations have been
> > executed. The test passes once all operations succeded.
> >
> > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > ---
> >   runtest/ltp-aiodio.part3                  |   99 +-
> >   testcases/kernel/fs/fsx-linux/Makefile    |    4 +-
> >   testcases/kernel/fs/fsx-linux/fsx-linux.c | 1509 ++++-----------------
> >   testcases/network/nfs/fsx-linux/fsx.sh    |    3 +-
> >   4 files changed, 324 insertions(+), 1291 deletions(-)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
