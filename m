Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F8FC87FD2
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 20:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724962473; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=kJA/wd4Z9loBnE69vLQOtRRkB4S3fJ0yhv9GxfM7Vmk=;
 b=cUzc0Ku/NXc+k3eRjfFunVoyBXa0ZdAOjoajVB0CWQRu6Pr8XHG3CLdq/ZIrvHmJ9sU0p
 ldqMAlbsIi/ViG9ss7hW4Ky3iRXBIDqfsjnRvD3or7iOFiPEVELc5BFTdmh1UQ/7ET+pCMA
 2I1z3mGR4avziDdpcvXlG8wEAk4sw1Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFE4A3D2827
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 22:14:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C2C53CFF4A
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 22:14:11 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=chuck.lever@oracle.com;
 receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 94C312001A8
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 22:14:09 +0200 (CEST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TIQWYA010140;
 Thu, 29 Aug 2024 20:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=corp-2023-11-20; bh=W/hHCClSM9JKHtMouLuz0SlZGOI+DREZYvmA+1J+r
 9s=; b=YytDoGuFSuunIyIRthHpKmrUCyiiZzDyvXn515cOrZYF4bseos4Yq6fcK
 XBV0KJX0MKjDWjt/JuweUtxFvSwJeyaa/RQW6vFfhIlhPyPo91P7Tbk077WHAMM7
 1FAc9mcW4qNNQtTVCUQfVXRLtSw6tdILUMNtoq83wsw7A4rAUqzRtRKKEXg0iYmQ
 yfgnUSEYHhZ/xm7qUhZwhn+p8ZRUQg4Q7IX8ZyOpwGTtPTOqLG8nbYjUmVkk7Wds
 ES8I//g7y6CUjx0gLXnqToGpKj+FohsnOh6NkfYWaiNX4vFyPTJ5pAsE3/N624j6
 65HCiOnVa5lE+YPHJgVGG4xtSGuYg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41ax0gr8jd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2024 20:14:07 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47TIwfQL034765; Thu, 29 Aug 2024 20:14:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4189swgj8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2024 20:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYuWlB4gnL7Pc3VvSUrEQAA/XJiG8014E/sYbqvKSzdxBRSsGzcR7sQEb9LxfZ/GNx4afwHA+4k06yPzq2EgI5zW24RJxXSNJpv8hsUqtNaMb00xTGCmksAO8Vi7ESDwnkUvdYhUyKFoWrsaJCzxNXT6+vftvk+avTJEnEg2sfIMgcBreH1+E8c/zibfcs2d8WICppH0QD1vm1YC7XkhhI431RQccBIyRs9jQrglE6MEGhKdZfzyO3CCYLcFw3JM4Uah+QLKKnpc2TL5LM2CMIW4INuSgeFP31ZkFlNNkULb7XLocVQjM+1IWqdHF6eUdpw6C0zQR0cw80UUA+VcNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/hHCClSM9JKHtMouLuz0SlZGOI+DREZYvmA+1J+r9s=;
 b=Cr5j9ah9jifinvBs5j/xjCJP4MSET032qyqbFrB83ek+V34JVsQuYEoZ5ZRghNaMEnXa8QwaSh7YCVAa5NgDmrRcwD01cQBFGYZGEmz0avDBsRVqO020ByA6M5mZ45VFZR0od5vtn0Mh2UpMvW5oEIzARZV42/Glb7UMFUofg3PZgcN25ZGcV6KJv2h8J8w14J0c1XDWSVAZPcXsKCHlsynQWCI1J/d70lXdGWPAtWP0YUBiFE3cvZEVmgDoRH152EDdbKsvl1N6UixqR7s0RZ6wbDSPcpCnfh+cuVPzdCuUeeA8t55GkKrH4kE/DOt1Zrdla+MmV/BMUzrp/QGt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/hHCClSM9JKHtMouLuz0SlZGOI+DREZYvmA+1J+r9s=;
 b=s/n/+xBiaPDlSFuqE0AT1IfgFkigcgTn1RfNO0A82RVPaB5bP8ntwijaxyqL5jWirrk5Xi/FUnMZ31NQdDE/TKfeAG056XrZ4lNuq11by4lbVRzd9MKdPZJSrt7EFmr4UhVTNEGcHA0d6XUYOCxBqcm481WkanFqHBOSIVGwrHI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7159.namprd10.prod.outlook.com (2603:10b6:208:401::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 20:14:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 20:14:04 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] ltp build broken on Fedora 40?
Thread-Index: AQHa+YT+UV889xyYd0y15QMuZDk25rI9RdsAgAFnDAA=
Date: Thu, 29 Aug 2024 20:14:04 +0000
Message-ID: <51DBF795-A185-4E38-993F-E3CAEC37EC83@oracle.com>
References: <5295D578-7B15-4613-A1FA-41A425E992FA@oracle.com>
 <20240828224850.GA1773775@pevik>
In-Reply-To: <20240828224850.GA1773775@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB7159:EE_
x-ms-office365-filtering-correlation-id: d634658e-9195-47c9-7b7b-08dcc8672156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NG9oaVFrWXg1U1Q4UnZRWWhUZ3lzQ3ROZjd2ZnJTdkRBYzUrRVFxNkpjSFRQ?=
 =?utf-8?B?YTBFSnV6Tlh3UThTa1lJY0xBVC9CWlQxUkJBNUxwall5RW5NMmhGZnRNV1By?=
 =?utf-8?B?VTlGRHRBNmpFRHRRenArS1VRUHRteTlKZEdVWWNsTDdibmlXSng1N1NFdnBo?=
 =?utf-8?B?T1dTSHdTNmpyVXVWQjBid2M0TE8zdS9QYyt5alFIQ3BQRVJ0em5scU9Nc0Z2?=
 =?utf-8?B?aW8vVUNMT2JGa20xQURCNWtzUEdaRGhscUFVUzR5OEdNWGo4ZmJxRlpWM1l6?=
 =?utf-8?B?a1FySFB1WDgzQ2lJR0orUGVyK2xZUG5OUDNwNlFZYVJraTNxT05BWnVPd1dE?=
 =?utf-8?B?NWRhL0tIUWhTOXBEUjhQYmhFNlJwRTB6cFVXWmpnSWFBUkNINGFLMFdabG9J?=
 =?utf-8?B?RHNXWVNNYWIxaTV1NmNpdUc5Tjl5ZHJldTEwV1JBV2FpY21YbVg3YnJ1SFZM?=
 =?utf-8?B?cFp1M3lSNzVpVVV3Zjd0QklwVTdqOTlZd05GSnM5cXNFRDlQTGFWTUFqOXlS?=
 =?utf-8?B?WitLb0dRaXczcGNQQ1phR2ZMZ01lSFpaS1FiL3dXMWN2M2JDYi9WTEFreGd3?=
 =?utf-8?B?ZXN4d2FidW5Fa2I4Unlsa2NDalVSRHMxZHBRb25VVllvOGJFRHVWL2pvcU0x?=
 =?utf-8?B?c0FaZVBndnBlZW96azdVMmttbUJnUzVWajFUS1VERVFDMEhFa0JYSndrVWVm?=
 =?utf-8?B?TWQyQXUrWnZFRElSbERISTZ4aVMraHFzTVRZVDNFbHZjVk9kZDJScjBDejRL?=
 =?utf-8?B?djRzRkZhT2Z4cDZvc0c0dDV5VTF5KzBkNHo0VE5LSGtNN1lWOTg4ck5hclZa?=
 =?utf-8?B?aE9Rb2V2UHN4RkE1RlIzMnBaS0FHRG1sUlBiWE04cUp1ZEZXeWM5eUxWYTZT?=
 =?utf-8?B?Yzd0aTZObGFFcklmRzRQRjcrcElZdzhLcEI1ZXdRQ2JNVVllWlpYd2VMREsx?=
 =?utf-8?B?SDg3ZDRjQ2pRRHVtM0ZtZ295TURMZzZ2eE5vS0xYSmpNbFdac1NVQ3I3MEtr?=
 =?utf-8?B?bng5Q21ENVlLcVNFOWFLVEs1WWxvdU9YYXZyTjd5c04vdGp6TXZYUHhjS09y?=
 =?utf-8?B?dC9OTGlmMG1OVnAvZGZMeWlaVjdkYlo4cFZCV2Q5NmdIczUybGdEN1JWV1lX?=
 =?utf-8?B?MjU2Yk4yMThLQ05SKzRMbnIxZ1BWRDJ4R3JVaTBWOTdWbTBMS3lhZFEzdlU0?=
 =?utf-8?B?cG90UlZhK0RvZ1JuTEtTaGcwdDFJWnlNb3VIV3k4NTBsdHBrVHpOY2xBSFlM?=
 =?utf-8?B?MEtoeVdldjhRdmV3eXd4RGNrYXhER2FpRnlJYXJSYWtwZDdBNkJQdllrOEd3?=
 =?utf-8?B?UTVFUEpjL1cyU3pXb0krNGNGSGxwS3hMNzNBaG5WaUM4YXRxRUpsK2ZrV1FQ?=
 =?utf-8?B?Z1lnZW0rak9kRzUyVU1CeVY5WUtpdDU1TXJoUVEyTzR5RUIreldhWXlXT3pR?=
 =?utf-8?B?S1RUWi8yN2ZweUNmVHdua2YrK2tHWkt1RW9ZdVJ1YTZnTlhGMDgwQll1bUky?=
 =?utf-8?B?L0Rqa3lUTTM5YmE3dDFCc0RQYVQwR0l6akVYeG0vZ3B0RDVBejc2ZS8waGJu?=
 =?utf-8?B?L2N0c0Y1VGRZL285eS9jdldpTml6Z1p3clBkNVNUck1zUWxPaUxsa3hqdDNK?=
 =?utf-8?B?MUc1TTV2a1JMRXhCbFVaMFl6Q1g5cmFveGNaOStoTHhCb2FtTnJJb3lUQW9M?=
 =?utf-8?B?OTc4L0p2bVdveXdRVEFVdGhSL3Q5cGpWK3Z5VjZ5bXRDUVlBZ3F5ZWNYb0dr?=
 =?utf-8?B?OG5TL3ROVjBUM243dUdsQ081UWpMV2ZVTzJjS2lzRUlXSXV5OTlNYnp5QzZJ?=
 =?utf-8?B?aUh4WTE5NXVPdiswN21mM3h5OEVHUEl4aW1WeTlGTEZ6ZHRiUW8rSFJOV3o3?=
 =?utf-8?B?SVJ2MFJHdUN1dnNjSGRFdHl6b0dkbFZJMnVHTWM5bVFvekE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5128.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEt6dkg1SlB1YUVxTlNsVTZWVndsMTRoRmp2RFpvam5vWjNTdHZqZnRSbmov?=
 =?utf-8?B?cFVRR3lFZGwvQzFpdHlCaGNwcXJSMzdZUFhUYjJMTS9vRGpyTG8rTzJaajJP?=
 =?utf-8?B?YnRuM3MzVXBEeUoxdWNwbjFQb29FZEJiSWpMdms1WHZRcGlYczlXdFFYNkdw?=
 =?utf-8?B?TllGeXdJVkVsaUw3ODdGTVBEeTRCT2ZWZmkyeHVUbXd4OXFwNzFGRWFGTk1u?=
 =?utf-8?B?N1JXMTA3ejJsV2t4RUdRWjNBNU5XOEVBV0lIQ2xLTzhVNTU3UHNZZVByaUd1?=
 =?utf-8?B?ajNESlhub1VsTWFZSU1ORlhvZTIxSFM0VDVaaFRPQlpVcjZwNjVpR0tzNjRE?=
 =?utf-8?B?Sk5lWHdJTWpSVGI5N3RVODdJblF3WkpZa0p5RGxybHAzR3JtSnhFeWkyMmx6?=
 =?utf-8?B?cnhGV0t0UzF0T3FYci9sSXIrcVpLNlZzZlk1enhDNDdyY2pHQ2ZWeVU4djBN?=
 =?utf-8?B?WFJSWnYvSFl1VG1GTkhsank0NmxVNFJrQjZaMWpEdjN6TmhTMlg0bjRSNEdO?=
 =?utf-8?B?ZzZHSUtQTjJ1QWZHZEpQU0dJYmhTZUhNdm4wTkpoOC83dTdZUmN1MmxiYVl3?=
 =?utf-8?B?R3pkYmc1RXB4d3BZSU5JcmhpUm5aVjNGeUd2VVJ6cEwzU2hRL1ZMY0hHN1kv?=
 =?utf-8?B?K1B2c09Ma0hyb1BVWDJ3MnNmc2RiNDJmQkZEWnhMZ1FqVm1mVk92aFRvZE9Y?=
 =?utf-8?B?VHZaaUdSenI2ZVhqUGQySTZ3RUVUajVOMG1WWE5NcDNSdnNZc0QrNkwzNG1R?=
 =?utf-8?B?VU13SWNMazc0Z0h5d1JNT09yM3RVQXZnSWNwMHlURnRtYzFYMEk4c3hsNDhs?=
 =?utf-8?B?OU5NMlpUL3dnTHlZam9BQlBKeTQvUUQvQU5NQ1ROYTRuaWd6Uk81Y28vRm1W?=
 =?utf-8?B?Z1VacWVPelRYVC85aDBZRHNhSmd2M0YweGpwdHBxY29KQVZNenhRWVdDVXJr?=
 =?utf-8?B?Y0RxTFQzcWJmdUkvUldSRkM4VFJlQUtsUklHY0MxWEc0MUJINzhiYXVNaUVh?=
 =?utf-8?B?MjlMNEp1V0xhQUxVUGpvWEM3K2R5RC9Ha01XVnpPTmdBUE5heEFrcW5OQmI5?=
 =?utf-8?B?bUI1L3JNL05iWE5JeWx4NWJ0NHRQS2RLblBaYWZvS0NPb2daK1lOSFFwUFdI?=
 =?utf-8?B?YkE3RFg5bFJiVjhBWndvZG9CS0dnd2ZiQ3AxdDNyOTJLNnBLc09sdVMvZkxs?=
 =?utf-8?B?TUNTVzg4NlN2eXFER1BqNmJEUHQwcnFhSWtRVlR6UEZXa1dkZmdBalpGMUIw?=
 =?utf-8?B?Z2ljNzEzSkJjbjFvOHZRNlQ3SE91SmVqcUtNMS9GWHhGVGt0bUh3Y2Q0NlZw?=
 =?utf-8?B?ZmZsQ3Y5bnErUEpLNDZBTVJYajh5eEVMS0R6c2ZCUXZsTldTZFhxNEZ1N1VY?=
 =?utf-8?B?Rit0VlRwWVV2b2FCL0I2WDJZNDdPbmhnangzb0RRb2h4VjY2eGN3LzljajBY?=
 =?utf-8?B?N2pZRTYrM2cwa3JXK05FQmYyMjVrT2JKWkwyUnNqTmhVbTdLRFlrYzZ2TW9r?=
 =?utf-8?B?MU9KQVlWdS8wK3Y0dGZOaGVwTkxPcmRFZEpaZWRWM1pkdkl2by9iM2duWWhu?=
 =?utf-8?B?RVZHMGlOZUQwOEpyNEFyeGVnSklyWHh5aXZzWmFuQmgzVDNDbkpxVjZXdmFU?=
 =?utf-8?B?VHB2TElzWmhPZFZncHUwaFRPWW5ScFBHSWdzOVcrNVFLMWE4UGVZdmt2aDZm?=
 =?utf-8?B?S2FXZko0ejdqV1hKclhTQlJWR0xQYmw4K2lLZkhYK1pUUjdXb3VTREhuSzZ2?=
 =?utf-8?B?SDF4ZElNaWcvYkVSV1FmeHJBMHpaZUxxazJZdThGV21naVJIUERPMU1ydGZS?=
 =?utf-8?B?VUwrNGpBVThVeUVXRVhpSWVIMmpiQk5nSzZlR1h0WmZ2R2lidEsvdUMybURm?=
 =?utf-8?B?MFYzdnh3OU90cGhRbDNwRk1seXZXd29OMS9IZ1p2SW9aSHpETnNoN0RJS3or?=
 =?utf-8?B?WkFwSFJaYlhaWDlEaUpJNFg2bENaR0VJd0JqSFp1RGErcWY5S1VOSGJRNU1B?=
 =?utf-8?B?azhXRzNvSjc3bFpiNi9Lejg0NmJlNWVxK09tcW4yeFE5bE51VmRtNVdoa0NS?=
 =?utf-8?B?U09Gc3ljaHR0QUwvajhUNENCMXpzQTR1Wkl2WFBlZnhIREZTa2R3MG9EcnNZ?=
 =?utf-8?B?TFNXZjZEMTVHM2wxemlQRStXL25Sd3NNd1FLOENXRUdWQTVFNmJjekErdSs0?=
 =?utf-8?B?TVE9PQ==?=
Content-ID: <13F6372410E888478D16D7FD4BCE792F@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7bNuysNrrss3a2LXjl2mspRPMN9u481Hl4a+YtxsSu4cU9+hGPLRNPQ16rgEZnUGFW8XQs0x9gTghGNdkCi9yZWxB/BbK6yvK1S8PDgWmpI/2ID9nT9U+qUosF/jziUkNM4qsmJzYD3SXOeP6gYHI6SS1SsMYm+KDUGzlfnOEnQUHOESMK5EWVgt/YuWT1r/kI1wsF0AaKZ/TkGip/OzwN9J85XyM+VJ2Cpb9o7FIzChZPZ3y2TxOQtb6Xa/349HLELYXr03bF9nP5sshMxStDdcjlO2JX5Lgro/YvLWwQNWY3iO3p5cnjTPdJ+cAh7Yp+p7lq8kZOvGDL3JjwEoPlp6lknsKiPMqZzUMP4sfepQ1xr4yG5y44W2nnJMIGlAtwYqggniAlAY/X8zS2e4w7dOksVp43dHnsw87sgHZYgWrH+tBHv0IWW4e3tVua0c6qDtggVpmOmCVaq0F6L9MD8+wuVjW/T14dBCe9B+Kc+Epp/6w7gSZZPQX7qEXVObkqVPik5Hb9vRqtcw9nIP77da+zlHqnqJ60LEHQde+uKmp8YDH8jr6cuRmH6G+kQ6RTUnv1d9kdNUH5X77mp8/vGgKtX3RNtUScRaHgRusH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d634658e-9195-47c9-7b7b-08dcc8672156
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 20:14:04.5802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3ahbYYVEZljW5f5TVpFYuR39E1B43JTGH/H1EiBdnxlzPNWMuxsWUtRo8fGbuWAa+DXNn/A4v1UF1S5KJWM6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 suspectscore=0
 mlxlogscore=808 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290142
X-Proofpoint-GUID: f0s7RlGJOxpGKEwwQPXX1-YMQ-6mTH3G
X-Proofpoint-ORIG-GUID: f0s7RlGJOxpGKEwwQPXX1-YMQ-6mTH3G
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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

DQoNCj4gT24gQXVnIDI4LCAyMDI0LCBhdCA2OjQ44oCvUE0sIFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6PiB3cm90ZToNCj4gDQo+IEhpIENodWNrLA0KPiANCj4+IEhpLQ0KPiANCj4+IEknbSBm
aW5kaW5nIHRoYXQgbHRwIDIwMjQwNTI0IGRvZXMgbm90IGJ1aWxkIG9uIEZlZG9yYSA0MCBkdWUN
Cj4+IHRvIGEgbWlzc2luZyBoZWFkZXI6DQo+IA0KPiBJIGd1ZXNzIHlvdSBuZWVkIHRvIGJhY2tw
b3J0IGdjYy0xNCBmaXggYjBhZTFlZTIzOSAoInJwY19zdmNfMTogRml4IGluY29tcGF0aWJsZQ0K
PiBwb2ludGVyIHR5cGUgZXJyb3IiKSBbMV0gKG9yIGJ1aWxkIHdpdGggb2xkZXIgZ2NjKS4NCj4g
DQo+PiBsdHAvdGVzdGNhc2VzL2tlcm5lbC9kZXZpY2UtZHJpdmVycy90YmlvL3RiaW9fa2VybmVs
L2x0cF90YmlvLmM6NDY6MTA6IGZhdGFsIGVycm9yOiBsaW51eC9nZW5oZC5oOiBObyBzdWNoIGZp
bGUgb3IgZGlyZWN0b3J5DQo+PiAgIDQ2IHwgI2luY2x1ZGUgPGxpbnV4L2dlbmhkLmg+DQo+PiAg
ICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+DQo+PiBjb21waWxhdGlvbiB0ZXJtaW5hdGVk
Lg0KDQpCdWlsZGluZyBsdHAgb24gY29tbWl0IGIwYWUxZWUyMzkgaW5kZWVkIGZpeGVkIHRoZSBw
cm9ibGVtIG9uIEZlZG9yYSA0MC4NCkkgZ3Vlc3MgdGhlICJnZW5oZC5oIiBlcnJvciBtaXNkaXJl
Y3RlZCBtZS4gVGhhbmtzLCBQZXRyIQ0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
