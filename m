Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7886CCA0EC0
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 21:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724966685; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=SBGhRfqVg0vX/FCHmuFHd66whLAKmTmZikyF2XhPt5Q=;
 b=P3qge7xHuBSnFmrQTpMq8uvxWCQtsgjNElTcYkopAo1kQImpPUofRVOBwWkJMnA3kNd8q
 WwejktUkO/BXmiqZQ7yEBz7BgACutTnlWCznuYwd5T3s14rwPNgt50v/kx7H2/4BZwnKohL
 Woj8H/QExb61zNMZFRktVNQ1aiK+ZV4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98CEA3D2825
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 23:24:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4755A3C02D5
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 23:24:24 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=chuck.lever@oracle.com;
 receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D202F1A0090A
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 23:24:22 +0200 (CEST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TKO31h004595;
 Thu, 29 Aug 2024 21:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=corp-2023-11-20; bh=ymR6EGZHbuXjI0lix1Z0xwMs6LTE/qYId5fpqMTEM
 QU=; b=I1H76/weftg4YN6l3E9sO+tW2WBBvkLnPZAN7NJDnPFzHZcnBht/qDUlk
 0R2eeCvq7f3o8hFH+J8CaDQgTdXAujyYuyFj3stHiHHBkFtZOoiSMi+Zw5bN6ljZ
 A0WfnGmvlCxz42kerD8kjCFD+8Jh8OkDpDGUIHVfoioTDqa22lbDJggwtupcZX4P
 Gjr8cKGXA87S33jCkvIoHE0kmrbqvz0/LdYTXPK3cKd09Dq81hKZ90qBJhhFgGja
 dq1IDDiqvBWuEpU1CgMYLQM5yl20vr0bSZTF8F6dbNwdzceWjNZOqJVqR/f7XUh5
 yQyFXdGNexfkBv3vyMJFKjF91A/6Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pukn7je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2024 21:24:21 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47TLAALB016852; Thu, 29 Aug 2024 21:24:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 418a5vppev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2024 21:24:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4OxEnG0u8BLMtU0CMztLRbo9e594Mg2bLjs0/n67Il0j+1ZoUPaU4wYd5CC2SJLlM3oOxG5rrVGdGEX7QHLh/KHDLB/Li3xnG2lm6VfIKsa+LzFOw8pB9X6C47mYa00KyYIbKbgoEHiIfltX4itni0X6Q+iIIRgBWDcS5YoJgetf6fmIQW7e9hEtfJl1YGBBWVMup4+0LBIAhbE96718wHfCRUdA46H0qjd3slJEuWC8AOVyWetv6aP8ZcSwMhHFa3X/PY+fqIcj9W5zcThGyLj0v4W78PYkeW2c2B66hdKOdJb1i1FlMarpsDogxVnzuPKcSWfucvdgNKpRw1lUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymR6EGZHbuXjI0lix1Z0xwMs6LTE/qYId5fpqMTEMQU=;
 b=FdiSvsld9zniDipRSxC1jc2tNS30SmS7t2F6VGQDAety1bIroOtFOcdariAdFvsUk1a870u+sQyFvBP9cGhzjKmgEpHRSPopVjiNTgzZGeON9o9v9HuWcW8RQ8fdw+hNFPIrfSOrpYTs+R+fQvi+4cRfbuKNmilGx1bf29en73hUJOaSZdFzc4t9iOtQUMSFbBFGJNf0T5ugzV4UfapEQR7xjz+OqmlOB1AfmoTXPyMuXUA3HTpkCdgwKQOnzUnR942pGlKIZ2Kx8y/cEUuSAo4sI6q8v0ILu5Mihsg946R8RJPQUei/PGq2PTmj8LnAhWW8Vn/t2MAM18yszV3zVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymR6EGZHbuXjI0lix1Z0xwMs6LTE/qYId5fpqMTEMQU=;
 b=ED6hEQgGu9kP1CjUDZZNJAS2RLk0jVEldz4R3VhrGQMlUovVbf7aJ3SFlAI4pd/oLt3g8MOHym+Xh6YlQ2UWv5ht1C+XoQSMSAMIq7lDmBe2xJLUKyR2yGMhaLbz2Yew5l5T2AXBadJuyRVDfUUhvXZD/JOnhOtWv8trxTJ6ZVI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4423.namprd10.prod.outlook.com (2603:10b6:510:40::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 21:23:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 21:23:49 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] ltp build broken on Fedora 40?
Thread-Index: AQHa+YT+UV889xyYd0y15QMuZDk25rI9RdsAgAFnDACAAAoegIAACV0A
Date: Thu, 29 Aug 2024 21:23:49 +0000
Message-ID: <F46C0EE3-EA5C-45F6-BDE3-C53BFAF65276@oracle.com>
References: <5295D578-7B15-4613-A1FA-41A425E992FA@oracle.com>
 <20240828224850.GA1773775@pevik>
 <51DBF795-A185-4E38-993F-E3CAEC37EC83@oracle.com>
 <20240829205007.GA29837@pevik>
In-Reply-To: <20240829205007.GA29837@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4423:EE_
x-ms-office365-filtering-correlation-id: 35819f9d-5b35-444e-c77e-08dcc870df88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bUJhM0JHRGRiQVB6cmh5K25WUXpNekRGQmMwell1QTNGdjB4MVRtTUlEeUgr?=
 =?utf-8?B?NmlWOHl3SzdEZ2FsaTZHbG1ucDJmc0l4c2trcnhObGMwM1diN0czQzRGMmJr?=
 =?utf-8?B?Q0RnSmlLREhVU1FxRnU1WmpFQTNBRGVQcWd1YjZ3VzludzU3K0d1cisvNmpW?=
 =?utf-8?B?YTEyUHd3eDJBMVB3cVZkZjlxcTdIV3N3Y0ZCVlVDa0VlNkQ4Z3dNeHNNaHZE?=
 =?utf-8?B?WVpqZ25ydmVoZEloNExWcE9wcW1saTZyWFJyS2h4MnQvTjI1Z1F0RTRXR1pp?=
 =?utf-8?B?UkVVWjEvTVNnSHhxbkZVTG1CZEw1b3cyeTFLMHNtZUxEUk53V1I3c05sZDN1?=
 =?utf-8?B?cFVqNE5qNGVPK0h2V1RiOFF3eGkvbU1VdFBpWmgrdThqZlFuVXBaaEcvZHNm?=
 =?utf-8?B?TkxNT01WNUhGcEpxM3RldExVeXJmSkNZc1F4SDRqci9TeGtyZFJodXM5TkJP?=
 =?utf-8?B?RFdScXJtTzlsNFNUQ0JQYzh4WGY1QThlZjdLUlRoTEo3S2tCbUNtOEQrZkZy?=
 =?utf-8?B?T2pvU3RKNEJuZ0hGYUtXNFJuODhLZCtRMEpnM3dYdU5tblM3WGczM3dKeU16?=
 =?utf-8?B?VnNReHpidUxHbzZHeFAwWlMvekJWQ3J2MmFRYVZtR3FrVWVFMlpoZUhSRDZI?=
 =?utf-8?B?MDc1MHlhUDJZQ25YOFBUZ2lXMjlwYmpwQXl6T3krSHllbFpodk5wNDV0RUoy?=
 =?utf-8?B?Y1cxTXJVTUtjQlpKK3lEdzNYRWJOTEl4cm80MmR0dlVJQnhjWE9kRUtJcS80?=
 =?utf-8?B?Y21tRE9MSFdna3h5MEFlSG05SUJtU05BeGNpT1lnRGxsS3NZNHh5OWJsUnhn?=
 =?utf-8?B?dm5GT1BhckpvdHhZKzRXUGhSS2VkRG5nRE02dGlOWk9XZjVOK0ZVOTZwTjRB?=
 =?utf-8?B?RWVueVZUQjFOY09ucjVDeXdqdW41UnRtcUx6dHdTamo3MVY3dXM4dDd4MzR4?=
 =?utf-8?B?dWJWY3BuQ3kxRkRuR0hKdlowSnlaWlcreWRaTHZNcXRMa3NIY2JNSWE3OHI5?=
 =?utf-8?B?UFVGMWJEOFRVZjgyR0RuK3ZrQUtqYUZkUS8yZ3FRK3dwbXMwckVyVGo3b292?=
 =?utf-8?B?d1B4aXZtTjVvTzRNTlVCWUpVSXZmNzNQek8xdTYxeTljL0FvSms3dFZwS2JT?=
 =?utf-8?B?MVY4TzhES1V0c0JybUJvNXNleE0vbG11N0lrdWNHc1Npc0V2ZFN6dW9OeXlS?=
 =?utf-8?B?RDhlWU5WSXpoNC9RQzRIQUFDbWdtcnViZXJUeTg4SkJnTGdjV2laMjBqK1lB?=
 =?utf-8?B?T0FFRGNhdHc1YkY2R0lhYjl3V2ZPSVN5UHVzK25jN21GaVp2aU42WEx5Um9v?=
 =?utf-8?B?WVBnYnJPZnpsYTI2OTFMOEhpdHN5bW9RNGM5b2NlKzBySWZNY2cxdEJ2UmNt?=
 =?utf-8?B?ZjNPVVJ6TWhHblc4bXFSSUIzWTBJaElZV1d2ZHRLM2Vhd0Z6enA1TzNUTnJM?=
 =?utf-8?B?VGpWM2FaaHNCd0RWa25HbXJmRjAyWWE3MTFSVmFHVHNERmJSWTM1YVJ1RHFu?=
 =?utf-8?B?U2Jrck0vdVJIdXlOZXdpTExGRUU3UnNLcEF0VFZQVFdpSm9FNnNYd3dkaEt6?=
 =?utf-8?B?TmEwWTJxMi9yb0dGRW5vWnk5TTRreEN2am13TVljZFpwM2dUdUdTYmUxbWNK?=
 =?utf-8?B?T2ZIMDNTcGxMR1RydUdobE9iYWQyTjhGRlJyYWlPWHhBamhvN1IxV0F6VGMx?=
 =?utf-8?B?V3lTWVB5ZzFEeDhkSmdxWFI0SWJ0MTlucWUwNTQ5T2xIYjNoLzFLYThrY3Jh?=
 =?utf-8?B?K2EwcjB4VkFvTU12RFJRQm1VbVRwSk00WStEUjd5OGRnY0xLcG5KeTJxZkN3?=
 =?utf-8?Q?vr7XQih6Mme1Yr6bNak9AkVqep9N4e3/Eh4XA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5128.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzZSU0cyRzZVTjYramUrK3FnMVZSeUxoWDFOM3hMckViZ0VCQllidktPVmNF?=
 =?utf-8?B?M0hWU3hsY0RiSW1wYUMwZDgyZVFnbWY3KzdjQ0Y1RzRCWFJyNU5iMnUwb3Bt?=
 =?utf-8?B?T00ySjZsZk1sN0o3Z2xzaERnekdUQm8vVjVONHdkOTFENlpyU3RIeGx0a0dY?=
 =?utf-8?B?ZUJUQXRSdldoa3k0aWVSdDZFaThiSnFQSUtva3VVOGtRYzhNWW9Iejh0cWVT?=
 =?utf-8?B?Q245djJuMGJkMTFEcGJhWHF0WGthRnorOXNpNTNSdEdtQUVUSmVnb0ZmWktm?=
 =?utf-8?B?dFFBcEJNMjBRamZaT0paZVVoN1VFV2hITDQvOHNVUS8wY0wwU0dFTEtxZ0Vh?=
 =?utf-8?B?MGFLTjBWeUhyZWNTcEhTVk9EbHdrV0dJa0hOUUIxL0czUTBna1R6Ujc5eDlF?=
 =?utf-8?B?S0pKcnQ4R2Z5VXVFNVY5TVY2TGsySVpORWJLM1NrK2RVcjd2NE9VYlRiZ0Vu?=
 =?utf-8?B?bE1NaGc4RU11dHFQcXFQZkUveG9MSWN0aDl6Mnl2N1dPSEFBbGxNU1l3bFdZ?=
 =?utf-8?B?WWRCZlRveGtBcDJZKzVBaUswNmF6VzNqOXNkV3pXY3EraWwxeEJwOGpjRFZP?=
 =?utf-8?B?aVIzaUl4U1lvZDByckJ2NkZjallMbFdGbmRJTkkvZm9ObnNjUVVqY0ppZHZm?=
 =?utf-8?B?U2VxTElxamxOcmNvSksrTGJqQjF6VzlGYXNPQUV0SmlWdHpTQ0EvNldEKzNR?=
 =?utf-8?B?Sy8yUVd3Y3phM3A4RHovclJ0OTc4VHlXOGdHdGEyY2tOWENremFSR1hEUmpC?=
 =?utf-8?B?VzUzWVZ6VkF6a0draWI5M01XZ3kvNU9ldTlYNnpna1NhK09qYzhZLzQxcWo5?=
 =?utf-8?B?RktUVCtzOGxPY0JVcUQ0aDdoOVhBSnBaTjRqZ0R6YURlOExKMXZldzFzZUZS?=
 =?utf-8?B?ZVpPY1NYRWVLSTQ3bjFVUmpzN05CaU9jYVNpbzZYdjZkckkxei9yejRNK3pO?=
 =?utf-8?B?cG93OXBlK2N4emZwQTBpemJrbGFkVEZRNnk3aWE1U1FZNmV3SHVGZFJGcFdi?=
 =?utf-8?B?Q3NMR1JUQXdzbERLM2dWZUsxWnQxRzJHekY3a3dkdkxvQWZIeTk3QVgza1RU?=
 =?utf-8?B?bk9Kb0ZzcldBYlYxSy9lSlp6allpbmR5bGlzbEZKNjcxbXRvTlpnYjVzRHdL?=
 =?utf-8?B?VVpRWkoyeU53MXY0aFpqQU1CbWZHVm9rN2VsZFR6cnJwTkp5UFNzR0FzZXdH?=
 =?utf-8?B?cHNkL2s2am9qRm9NRnF5VWN0cmRCU2hBWDZnTEJqMlc0UjRubGVZdzB2V0w0?=
 =?utf-8?B?RVNqNXZuMHFxWUxid0duME1qNVhxMnVla1RleEJTT0tGYnBGK1BMdHVHVWhh?=
 =?utf-8?B?T2lqL2EyT1luMTY3dEg3NURJOVlUZUVYd3Fmd1BzOWlHM2U4LzBiVTByOTEy?=
 =?utf-8?B?NmlNcXhDVXhUZnMrV3VxWlFHeUlZOWNESzA2TE8yN1MxblpIR3F2M0YwSkZv?=
 =?utf-8?B?aUpZeUhLaXNmTGtHT1RhbDdnemV6TFpQblNIV1JhaGNScmxaeUJVbGUyaVRt?=
 =?utf-8?B?OHVnSUVWTGtlYllDMi9VN2tqblo0MkJmU3R5U2pkMnBvYjFzRlk4d1ZXYzdn?=
 =?utf-8?B?WWdLRnF5NjJkb2g5WUltZlFuSFVhV0VheE9lbllXSFZOdUlkZXorRmwxVk1p?=
 =?utf-8?B?bHJBVEEyWkNicFBQRzB0RlRvMGNhYTNOeFFHVEhrQnZNMmVLMU9PdkR2cXRq?=
 =?utf-8?B?Q09Fb2FlekVEQjNYWXhhNlc3WURPZ1U5RCtVYVl2YXQzSm5wWWcwTXBtRkJU?=
 =?utf-8?B?bGxTeG9QT1gzMmhLb3hSdmVqTFk3ODZFc1RWUCtHUk1IQVh0UTZoWk1RVDIr?=
 =?utf-8?B?dzlvSHppZlMxUkV1SGtyQXQ0bG1jTXR3VVJuWmwweU1FZ21vU3NvR29LaUpD?=
 =?utf-8?B?eWNpeVh2N0hHWWZCTm80VWcyakh2YkdMdWFXdWJ6QXk4YlZSYm0yMzYyQUpN?=
 =?utf-8?B?TGVpU2xEMzcyekd1aGh2K09PSTdjcUFmU0oybHZzV2ZFYTNjRVFvUExaL2Ux?=
 =?utf-8?B?YUNpMmxYS1VMdU13T3RhelUybEF4bWJmaHh1RDBqOGhTOXk5em1kM0VENXhK?=
 =?utf-8?B?TE8rdE5uanVlenZtMEIrZ2lYM3FFdDVvbnBxakRQMXo3Y2NtV09GSFplOXhT?=
 =?utf-8?B?MVJqdW9Rc3p1VDBDTXJCSVU3c3RWdm1rVFJtYW1vdnBMd2trYnRPQ051RXJC?=
 =?utf-8?B?Zmc9PQ==?=
Content-ID: <6BE9E75672FC8945BCD91E4A43EA5D8D@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qn9AkvuG25Ker/sPb5KeC9NI1xqtraHsq53xN+mkExqJM3hpYgPyUyKWF3u00yfm9OHJDzrgqt03Vbr0Nlo2zETrTeO6YB9a6vcgsc7Kmb6YPjPEDm7rrE+nhWtEztwKfkUNdM03GtKQLVbXxQzdM/WRS2LZrkz/DAG+b1g2jYyqjL0wLmoLtR57QrxZYc+tUs2yHdzN80nTPPSlqnsKSaX0lI9MyY/GNeT+O12kGzNwm0S5PRS8l1HcRXjp26vv+MfbckRAStumceHUq7BdM1h3AMTe+oPsGwg3pC3UMQ2hb8/9luAKrssN36lNgRA3w6KANMqpvqePmaIeuWN1MGjyTR+PbCTNboLnAHkxFFebVeLsiVXhspvY60qSXZ2zYdQoVmZ6gQeI7QKw+sZBUMGTN56os9j/AvWQSN9CsjMYBtpGcULa6LWXSmxG5yB9jKSjmR+1lUKwLNHkkkYYx1sLaxCY7NjSb3McJRcK5uGXS4mXBvHIss6p4eGJnoGAD6TQwFhOP9ALxiQt7RaG5iuPB90FFRhLSr35YQ0jwyEojf8ibHeGCj5h20pnf08BvRmJC80pTu7Fwct9W+Yqu3tHbYqsGXPxhhnOoy1XSiQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35819f9d-5b35-444e-c77e-08dcc870df88
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 21:23:49.1440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HdRPiYD+8r0/nUZI83yBdFMWj+LdxlF2bXBNXlp4JZDjLdT3wHTVA6y3Pn7WlylL0lb6Wkm1CV9H3Cz2QsI/dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290152
X-Proofpoint-GUID: X-ypBnZBAgXkaQbwEKelqjzJBHaqrIFB
X-Proofpoint-ORIG-GUID: X-ypBnZBAgXkaQbwEKelqjzJBHaqrIFB
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ltp build broken on Fedora 40?
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
From: Chuck Lever III via ltp <ltp@lists.linux.it>
Reply-To: Chuck Lever III <chuck.lever@oracle.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQoNCj4gT24gQXVnIDI5LCAyMDI0LCBhdCA0OjUw4oCvUE0sIFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6PiB3cm90ZToNCj4gDQo+IA0KPiANCj4+PiBPbiBBdWcgMjgsIDIwMjQsIGF0IDY6NDji
gK9QTSwgUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOg0KPiANCj4+PiBIaSBDaHVj
aywNCj4gDQo+Pj4+IEhpLQ0KPiANCj4+Pj4gSSdtIGZpbmRpbmcgdGhhdCBsdHAgMjAyNDA1MjQg
ZG9lcyBub3QgYnVpbGQgb24gRmVkb3JhIDQwIGR1ZQ0KPj4+PiB0byBhIG1pc3NpbmcgaGVhZGVy
Og0KPiANCj4+PiBJIGd1ZXNzIHlvdSBuZWVkIHRvIGJhY2twb3J0IGdjYy0xNCBmaXggYjBhZTFl
ZTIzOSAoInJwY19zdmNfMTogRml4IGluY29tcGF0aWJsZQ0KPj4+IHBvaW50ZXIgdHlwZSBlcnJv
ciIpIFsxXSAob3IgYnVpbGQgd2l0aCBvbGRlciBnY2MpLg0KPiANCj4+Pj4gbHRwL3Rlc3RjYXNl
cy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvdGJpby90YmlvX2tlcm5lbC9sdHBfdGJpby5jOjQ2OjEw
OiBmYXRhbCBlcnJvcjogbGludXgvZ2VuaGQuaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0K
Pj4+PiAgNDYgfCAjaW5jbHVkZSA8bGludXgvZ2VuaGQuaD4NCj4+Pj4gICAgIHwgICAgICAgICAg
Xn5+fn5+fn5+fn5+fn5+DQo+Pj4+IGNvbXBpbGF0aW9uIHRlcm1pbmF0ZWQuDQo+IA0KPj4gQnVp
bGRpbmcgbHRwIG9uIGNvbW1pdCBiMGFlMWVlMjM5IGluZGVlZCBmaXhlZCB0aGUgcHJvYmxlbSBv
biBGZWRvcmEgNDAuDQo+PiBJIGd1ZXNzIHRoZSAiZ2VuaGQuaCIgZXJyb3IgbWlzZGlyZWN0ZWQg
bWUuIFRoYW5rcywgUGV0ciENCj4gDQo+IFlvdSdyZSB3ZWxjb21lICh3ZSBhcHByZWNpYXRlIHdo
ZW4ga2VybmVsIG1haW50YWluZXJzIGxvb2sgaW50byBMVFApLA0KPiBmZWVsIGZyZWUgdG8gYXNr
IGlmIHlvdSBlbmNvdW50ZXIgbW9yZSBwcm9ibGVtcy4NCj4gDQo+IEkgd291bGQgc2F5IG1vc3Rs
eSB0aGUgY3VycmVudCBtYXN0ZXIgYnJhbmNoIGlzIHRoZSBiZXN0IExUUCwgSSB3b3VsZCBmYWxs
YmFjaw0KPiB0byB0aGUgbGF0ZXN0IHN0YWJsZSByZWxlYXNlIG9ubHkgd2hlbiBtYXN0ZXIgZG9l
cyBub3QgYnVpbGQuDQoNCkkgdGhpbmsgaW4gZ2VuZXJhbCB3ZSBzdGljayB3aXRoIGEgZml4ZWQg
dmVyc2lvbiBvZiB0ZXN0cw0Kc28gdGhhdCB0aGV5IGFyZSByZXBlYXRhYmxlIGFuZCBkb24ndCBj
aGFuZ2UgYmVjYXVzZSB0aGUNCnRlc3RzIGhhdmUgdW5leHBlY3RlZGx5IGNoYW5nZWQgcmF0aGVy
IHRoYW4gZHVlIHRvIGFjdHVhbA0Kc291cmNlIGNvZGUgYnJlYWthZ2UuDQoNClVwZGF0aW5nIHRo
ZSB0ZXN0IHZlcnNpb24gaXMgdGhlcmVmb3JlIGEgbWFudWFsIHN0ZXAsIGJ1dA0KdGhhdCBtZWFu
cyB0aGVyZSdzIGEgYnJpZ2h0IGxpbmUgKGEgY29tbWl0IG1lc3NhZ2UgYW5kIHNvbWUNCnRlc3Qg
cmVzdWx0cyB0aGF0IHNob3cgdGhlIG5ldyB0ZXN0cyBkb24ndCBpbnRyb2R1Y2UNCmFueXRoaW5n
IHVuZXhwZWN0ZWQpLg0KDQpJdCB3b24ndCBiZSBkaWZmaWN1bHQgdG8gcHVsbCBiMGFlMWVlMjM5
IGp1c3QgZm9yIG15DQpGZWRvcmEgNDAgc3lzdGVtcyB1bnRpbCB0aGVyZSBpcyBhIHRhZ2dlZCBy
ZWxlYXNlIG9mIGx0cA0Kd2l0aCB0aGlzIGZpeCBiYWtlZCBpbi4gKEFzIHlvdSBub3RpY2VkLCBJ
IGFtIHJlZ3VsYXJseQ0KdGVzdGluZyB0aGUgTFRTIGtlcm5lbHMgdG9vLCBhbmQgdGhvc2UgcnVu
IG9sZGVyIEZlZG9yYQ0KcmVsZWFzZXMgd2hpY2ggdXNlIGFuIG9sZGVyIHZlcnNpb24gb2YgZ2Nj
KS4NCg0KDQo+IEFsc28sIGluIHlvdXIgY2FzZSwgZm9yIE5GUyB0ZXN0aW5nIHlvdSBuZWVkIGp1
c3QgdG8gY29tcGlsZQ0KPiB0ZXN0Y2FzZXMvbmV0d29yay9uZnN7LHY0fSBkaXJlY3RvcmllcyBh
bmQgdGhlaXIgZGVwZW5kZW5jaWVzDQo+ICh0ZXN0Y2FzZXMvbGliLyB0ZXN0Y2FzZXMvbmV0d29y
ay9uZXRzdHJlc3MvKS4NCg0KSnVzdCB0byBhdm9pZCBiZWluZyBteXN0ZXJpb3VzIGFib3V0IGl0
Li4uLg0KDQpJIGhhdmUgaW50ZWdyYXRlZCBsdHAgaW50byBrZGV2b3BzIFsxXSBhcyBpdHMgb3du
IHdvcmtmbG93LA0Kd2l0aCBzZXZlcmFsIHNlcGFyYXRlbHktZW5hYmxlZCB0ZXN0IGdyb3Vwcywg
aW5jbHVkaW5nIE5GUywNClJQQywgZmFub3RpZnksIGFuZCBmcy4NCg0KVGhlIGtkZXZvcHMgd29y
a2Zsb3cgdHlwaWNhbGx5IGJ1aWxkcyBhbmQgaW5zdGFsbHMgdGhlIHdob2xlDQpzdWl0ZSBpbiBl
YWNoIHRlc3QgZ3Vlc3QsIHRvIGtlZXAgdGhlIGF1dG9tYXRpb24gc2ltcGxlOw0KdGhlbiBBbnNp
YmxlIGlzIHVzZWQgdG8gc3RhcnQgdGhlIHBhcnRpY3VsYXIgc2V0IG9mIHRlc3RzDQp0aGF0IHdl
IHdhbnQgdG8gcnVuIGluIHRoYXQgdGVzdCBncm91cC4gKFdlIGNvdWxkIHRyaW0gZG93bg0KdGhl
IGJ1aWxkcywgdGhvdWdoISkNCg0KVGhlIHBvaW50IG9mIGtkZXZvcHMgaXMgdG8gYmUgYSBTd2lz
cyBBcm15IGtuaWZlIGZvciBhdXRvbWF0ZWQNCmZpbGUgc3lzdGVtIHRlc3Rpbmc7IHRoZXNlIHdv
cmtmbG93cyAoaW5jbHVkaW5nIGx0cCkgY2FuIHJ1bg0KZm9yIHNldmVyYWwgb3RoZXIgZmlsZSBz
eXN0ZW0gdHlwZXMgaW4gdGhlIGtlcm5lbCBhc2lkZSBmcm9tDQpORlMgKHRvZGF5LCB0aGF0J3Mg
eGZzLCBleHQ0LCBidHJmcywgYW5kIHRtcGZzKS4NCg0KU28sIGNvcnJlY3QsIEkgYW0gdXNpbmcg
aXQgZm9yIHVwc3RyZWFtIE5GUyB0ZXN0aW5nLCBidXQgdGhlDQprZGV2b3BzIHdvcmtmbG93IEkg
YnVpbHQgaXMgc3VwcG9zZWQgdG8gYmUgbW9yZSBnZW5lcmljYWxseQ0KdXNlZnVsLg0KDQpJbnB1
dCBpcyB3ZWxjb21lIGhlcmU7IHRoZSBsdHAgd29ya2Zsb3cgaXMgcHJldHR5IGZyZXNoLCBzbw0K
bm90IGV2ZXJ5dGhpbmcgaXMgd29ya2luZyAxMDAlIHNtb290aGx5IHlldC4gSXQgd291bGQgYmUN
CnByZXR0eSBlYXN5IHRvIGFkZCBtb3JlIHRlc3QgZ3JvdXBzIGlmIHlvdSB0aGluayBhDQpwYXJ0
aWN1bGFyIHRlc3QgbWlnaHQgYmUgdmFsdWFibGUgZm9yIHRoZSBMaW51eCBmaWxlIHN5c3RlbQ0K
Y29tbXVuaXR5LCBmb3IgZXhhbXBsZS4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KWzFdIGh0dHBz
Oi8vZ2l0aHViLmNvbS9saW51eC1rZGV2b3BzL2tkZXZvcHMKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
