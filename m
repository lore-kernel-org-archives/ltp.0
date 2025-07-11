Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402F5C83F1A
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 16:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752252284; h=message-id :
 date : to : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=rBRGw9RSM2LVw5jgWfKFTJ7y77P0W8JkXuaaEhJGv5U=;
 b=mlMEXlbBD6hLZ3nMlmdreJLPaz3XfexHh07zuJw9Z9d9wmOkBwTyu3dm0oEHaNvlqGYOr
 EbzZxDW5u1aLi4+Jq2tixcnVl25/doXgqPVgihJB08zz7wDDGPk9RRmAp6R9Jfra8RzhJXp
 QDq18y7mxsv2pKBOGoQ/QYEyBD9tRKU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 291563CB356
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 18:44:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DD213CB28D
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 18:44:22 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20708.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::708])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5B9DB6009E2
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 18:44:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbq4eWKeSdlTfaNE81SXWAvFULBHTGprICCZO9XZKizkRhhjMArJ8DeGjVkakkYfDefEGaTnA8LvNHZY0+LN/qUxDULsma7/P6ZNYaMeWq+FnQAgKqHtcYpW7eAykqzszz/DLy5ea82InKukaRzmadEDy6IkxQmOy1veYkEbYIBATszoZRWwqMImDdStCLwsYUHZ04LclzE5ScMUoUn9uuE/bnL7VPK7647VI7/86JI6WmUF3KwNT/pctDuABBI/y9uoKGr7Q0Ic1xAWaykrh8RmMu8hDl27C1H4AxM8TRxC07JcMrSmBNXeBQRaOu4LZEitERlONiJFujn2hYGZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nu2dAZwaLAHlQ2EnsKuudWDZNFyF2QAuJiBVpjtphes=;
 b=saVhI75Y1KAD/lkNYwwyBDlHv1kT86yX9uriAi9TCcdRBgnFwHZZ8kcax0SJyaPsjtyzK0oaxeMpHJxu1KQ+UAxiEr8Q8glEMDg2N3KFHaTsn+K7C/yFJcoqZztlXwYqWNK0VXmbyfGN0qbieKUHRJwSrJnc7hiS3QNeo9h0H5NXqeoWn+k1FTPwgdED7njTpwZLQzDFizGcdTMyV2SbP4E4k20sMhOkD0J9y41fqh4xnUHsxL7JcwYO1uziidGeT/J7Ub/VGEjwOxMNSweJKtRSwxT6oaNhmryJMskf/qBo8mcHIB9ls6/CF2CUjg2oAeuOsKMjjdq+hzyfVxa5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nu2dAZwaLAHlQ2EnsKuudWDZNFyF2QAuJiBVpjtphes=;
 b=hHPfxkRz6bMb8XeQi2b0a5wsIRo6VzXBpLC/bSTqMUippJ/Qsg4ChqI9xIBAaK7bfx1h1R970L7G0lpt5CNHWZOprrtWYR1eTEANNlshRsEjEX1ftXyurCFb0QL2NBGJc8Wa6+rGinrQyh8T3kzfa4VEApCsV0S6CPvMcCO5aurMQ0QieoqFAJJ68EyEgNgPNzgrzoVuXLcuMB8sqIesfC9sznoNFdmwlUbjIRytExo1yZJotp0SiQ/SIhSaRBm+6jsbillliPS/q52O1gmskwk/mR8SSLBtdqvwgsJCHF3Q627q7AV+Xk5ZJlRT60fMrAaDAXO+smUU8U7N2W2w4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by GV2P192MB1990.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 11 Jul
 2025 16:44:17 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443%5]) with mapi id 15.20.8922.017; Fri, 11 Jul 2025
 16:44:16 +0000
Message-ID: <775c5a55-6079-44f3-9af4-11587bcec468@codasip.com>
Date: Fri, 11 Jul 2025 18:44:15 +0200
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
Content-Language: en-US
X-ClientProxiedBy: FR4P281CA0418.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::13) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|GV2P192MB1990:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0581a5-2a3e-4a9a-ad5c-08ddc09a2cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFB1ZklaSHB6eTlzSmlyVllRTk1JelcrLzRmMDdDVUdzOTNDWTNsditQeVVu?=
 =?utf-8?B?cUozam84alJ1aGJIRnFEV2Z1V2c5YjBHdFlYMXRBbDhUdURKcnRtSnFLU3I4?=
 =?utf-8?B?WEVndVg3aTJ1cFZOUnZUalUxUy9JNFI5b1V2UTE5eWpDT2dtYm5HMURUOW5q?=
 =?utf-8?B?VXk4Zk1xSVJ6ZmZjcjkzcEhCV2Ixb200b3BmcEtCKzNmQjZPYWdhM3JmaHZv?=
 =?utf-8?B?aUNua1JvWWw0R1lwdVFyYmNqcHcvc3hGOXhJamFiQkJhUXJNdzRFT3BYa2Vq?=
 =?utf-8?B?MHJLODR2b0k1Y2lDbXpjczQ0S20vdWFOU1cwZWtEKzcvcDBOTjhvZ2NKc2I4?=
 =?utf-8?B?dUhmeElLWkUzZS83aHdxL1Vvc3dheDRxR1BkOGwvY2tFZ2Q0d3JINUl5WExZ?=
 =?utf-8?B?YThER0JTOUJxQWFqK0krcjRWZ3NkS1d4WmpsczhBSTIzeDRVRjUycVlOUHBD?=
 =?utf-8?B?b3c5dG54cTdKeWI4L2tIcEl1cWNFZGc4Zy9QU29iL3dWa0pCRUtlby9Xb3BM?=
 =?utf-8?B?QjhEdWVYZThSd01yMnNjbis5REhDYU40UmJNa0RFNmkwRjFIT2wzSzNWMkw3?=
 =?utf-8?B?Q0I1YWJjNTQySFU2ZDdIdHRFNUttcFF5OVNNenJqdnNxWDNPL2xJckU5YzYx?=
 =?utf-8?B?VnFIWUN1VW1FUUE3NExpdmlMRjJLc3JibWZNRVJaZHdrbUxVMG5nWS85K1Q3?=
 =?utf-8?B?ckczbHBNeVc2VUFkdDdaaU5FNHE2NkhhMk9JSS9HQWdpY2dSenFzRWpXTE9X?=
 =?utf-8?B?TTVVLzZVbnZlZ2l5emVNK1JkVEhZOFJKeDg3dHdJbHdTcHlWd0hRYzFHU1Rr?=
 =?utf-8?B?NnFXT3FyVzlvSFpWelRHaGR6MEJ0b2QremZTcVl5bm42UjdaMU5CSE53cjJa?=
 =?utf-8?B?VnNTVmFVT3lzK2pZVFVXLytpWkdtQ1FtQVg4SVpCV3lVQndKZk5lQUw1dGs2?=
 =?utf-8?B?cDgzcURDQlFLc0wwWmR4dUhxWGtJZzJIMmFGbys2RVpydEN5alRaS1l6N04x?=
 =?utf-8?B?am1sZmhiV3cyNDVZV0IvblBtbjdLUnlxMlQwdS9NS0dRYi84U2ZVaEJTaG9S?=
 =?utf-8?B?YjRrM3dGR3ZPTmhhMUI4NCtGeWJvUUFwU1djK0dRL01LbStSSVQrMHhUOFJn?=
 =?utf-8?B?Z3hsT3E3ekRrcEZuN2N4d2oxejFCSGpTZlB6RE9PMnYvS1k1UGJ5T1dtUmZX?=
 =?utf-8?B?Qnh2TTRKZ3Z5TU9EVVdyVlM0RE9IUkppZGxvSVpPeHphOXphbUU0SkpDczJk?=
 =?utf-8?B?QkNQVXhQM2d0d09xZU9pcmxKN1dMR1dXMFFHVWR5K09QR1NnK0lKUFYvVGxk?=
 =?utf-8?B?SFhjMG1JQ0d3bDVpRGVIRmVFempZQlpNTGJoRzB2ZmxMQVZjdjVHek5ab2dr?=
 =?utf-8?B?UEJlN3V5Q29rbmVYNUE0bS9GZmRvdE5UbzRGWTkvOUJtM09zUGc2UWdBVmV6?=
 =?utf-8?B?L1lpRXVQNktRZXdPWkp3THdLb09VM0lVQjZSQ3Q3TDFyZjAwelBHWFBZWmdI?=
 =?utf-8?B?aUZGV0NlZVM1b25nZDBTbER5OWhtT1phalc2QWp2aFFjNUFBUGk4dnZDeXhz?=
 =?utf-8?B?T2h2MXNJZWxycmlwd0djaXFIZzMvZ0VHcFI1R2djdmFsZUN3emxKdEVOWlBB?=
 =?utf-8?B?bjBZcXIvKzlXOGo2NUNSNHJaYldLL3hhdGdQNGdUdzhybTFMOFUrSmJzT3BN?=
 =?utf-8?B?a29SelMxd2lUQk40Zks4THVCU1V5RkY2M0wzdWdPUVFmcXlZMDFGcEc3ZWI0?=
 =?utf-8?B?Z29LUFRoM3pQOGZnK0IzTmp4c0Q5QVl0VFhzNEZrbXVURCtHR0pqZFZKTVVm?=
 =?utf-8?B?QlFRRHN2cUZjQjNqZ2xSVkVOS1NlMFNiUmZaOHhqTkMzZDVhQVlVd3krSkpJ?=
 =?utf-8?B?V0lZbTVUTXFhb2xjRCtsZm5pdHpMcVVSbkdrc1JtZk1WQU5nSU5BQ3I4Y0Nv?=
 =?utf-8?Q?cgx8NGxWbkI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVREZGdlSHE5SnlPd3ZwN0IraFNYcnJma3NPQmQ0em80SmJuMWxwV0xkZG5C?=
 =?utf-8?B?QkluQjl2NE5MSGE0akRJbjRxV2oyY0w3MnRTQnNsTEthcnRGOWE5UGxBV25J?=
 =?utf-8?B?aTNJdjdqWTlWbXkvM2Rhd2ptNkpVWEljZzFCaFpYZ09oUmJzYzFYSEF5SER1?=
 =?utf-8?B?bVgybTdHMWJnQVF3cUdHaEppSmtxRXF3YlFwdVd3UE9OK212aEtWY1djVHJF?=
 =?utf-8?B?ZmwxaEVlVFJ5QXpmYU10YnJvSTJwcmd1WjJJd29GdmRmNkVjeE1zRHlXaTY4?=
 =?utf-8?B?RlJ3TnY2MXc2MFd2Z2dqejdjVUZxakE1dXhhcHd4T1lreUxlWTU3SXIrUVRr?=
 =?utf-8?B?V3FwU0IwcSszTWVPT3pBVTZCdk9MZUxLTkxjMXFOQnJFc05IbG9tZGlXbUlE?=
 =?utf-8?B?aEpKaXMvSFE2VjJaNHR4MGdLSXZmcGFMOGtsSEVrclI2WFFsL21KUW9oVm8r?=
 =?utf-8?B?elNFK1ZXUzJYZTF6cGZZNkRZbHV0ZTBIQzVnOGxJRFBTVXlCcytYMEN1cEJj?=
 =?utf-8?B?dkJnV3NBOHZ5dFZzVWdHTzBBdythS3pEWkp2bVUrQllmSmhTRjFvM1VtSTc0?=
 =?utf-8?B?VWpxU1VieWpXN2dUeFlCNVFtWm12ZmxJV255TFdPQUdqeTVhT1Z4V0k2eUxL?=
 =?utf-8?B?M1NjVGNYZWFUMnpPd2poZE5Gd3FNNE9pVTdpMmdDMXhKbGpWdWV4NkxUVjVl?=
 =?utf-8?B?RnIxUHgySEdkZysyTTVqMU5sVGRrMG5aN0taUXBFSkZyZjR2VW42bkczSktG?=
 =?utf-8?B?MFRpTkNlOHI2aW9JWi9ZckRIL1g1WmU3V25EQW1GS1ZoM0hNQXU0c0NVOGJW?=
 =?utf-8?B?V0h1clVhVUxGODIrcmJFOVVINUMrbGpaa2dob2VQNjRIOXE1cytwL0Z3OG8r?=
 =?utf-8?B?K1JZcGcyUkhidDJKZ1FmalJkRTNkdjlOTElZVXAxNWUzVm1aZWZiT1RmWHVO?=
 =?utf-8?B?djJ5UlhkVnJmdUhONEgvNmNMcDNIV1NWcE01enF5TG51M2tKNHlESVc0YW1j?=
 =?utf-8?B?eXB1cFppM1ZkWXFBTWJacXNiK3BXajJTc2pLRU5iYVhReTRrazBNalRMY3Iz?=
 =?utf-8?B?N0sxQnVGVU5wMzMzT3dXT2N0NTNDaFFXOXphSkZqcFhvdkFxenRDa05yZUdV?=
 =?utf-8?B?U25KbGlySm5CaWJKbGFneXhTMWkzZFVJSUVJbjk5WEg1QUpnVmhxQ2xFWDR1?=
 =?utf-8?B?S1pIU3lLMkpyd3dOVEpMYlhvRjZpNXU4cVVxOWE4NHdFd3dVUlFobmNIRCtr?=
 =?utf-8?B?RnpnZ082aG1MVzVjK25Ic0Fva1ZodXVOQnFSUTVFTHhFQndmeDMxUmlyenNx?=
 =?utf-8?B?KzBMVmM4eEM0UTNHMXMvQ0pSRXM4cXh6R0xHUlBlMVF6ZEdqeCtVbDZVNDRL?=
 =?utf-8?B?OXppUGlGa3kxaXBPT0pKS1dITitSdzNoM2V1TlFZbHdrbXNIblNnTTVHSDdE?=
 =?utf-8?B?N1hPMGptWVJDMmg4RFZpdi9sdVViOEVKU0NKcllFU3V6dmxhN3dvWm5KVDRR?=
 =?utf-8?B?aFMzZW1hRTNPZ3RxeDJCRS9UU1VIZGxqQ3F0VDJpWnc5NlVyYm1rNnUyYnJQ?=
 =?utf-8?B?OGdXazFQSW1qNURLMGxCRTRBemF2ZlFHV1RXNGFUVHdLc3dyNjR1UG4vSTVB?=
 =?utf-8?B?alhqWmwrRVJTcDhjODFFTHBUNjlRaEVCaTZZMjlZQktKSjVNcnhnWDdjWGts?=
 =?utf-8?B?OTRRakx0aHBCYXAzVDlnUTcrcXRBZEh2cmlaR0sxZTdIUjNoTTRXZDZPcng5?=
 =?utf-8?B?bVdFMHJ6TEtxWWhCeUlvMHBNWko4ZlQreHBaK3J3eHE0Rm9zTWlRdlZlZGtl?=
 =?utf-8?B?ZkVrQ1U2WjZ0NnpXOTRRQkxBMG1yemFrdWR6K3pIMXkwRTJLMGlHdUlEbmhJ?=
 =?utf-8?B?TnVHY1dObkU1Nkl6WXZ1ZlhUTUMzYWR5Q3YzSWd5S25qdS9wRHRhTmwwc0Mw?=
 =?utf-8?B?SCtNakhVaXVNd0I1T0MrWUhzb05Hdld2R2I1dnQwN1dhVUhmYWpONVpCTEF3?=
 =?utf-8?B?Rk5OcE9yelNhRWR5SHN3cGpOTERUWUdUSTZBMzRrTDMwK3U5SEsvV2xhNXcy?=
 =?utf-8?B?VWpncGZ1MWtJZFBQZU5jcVc2L1RyOTJVa2V6b3RhUTU0Nk13eGxabEgvNjRz?=
 =?utf-8?B?SUZERlNudW5JbGJTU1RqWDhEY3lETnJTUnpDOFQrRm5GQlRZdGJrN2dSVE1u?=
 =?utf-8?B?NjRVQ2wvUEhZMGRsMXBZR2pGellkQndZWS9RVUxHUEVYTXZuWk81N1VqK1BF?=
 =?utf-8?B?a2FocExuTVVwUk1Bc2xwREdXRXhRPT0=?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0581a5-2a3e-4a9a-ad5c-08ddc09a2cc7
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 16:44:16.7465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cp1fSAYS6RdMSDOzWLoralLLBd3WblDzhNSMISDhM3kHfIkVb8o+MmhQQDRLJfTL0KVDSllz7/dwtKxocgmy5mf1WCooSjHOqeDahyuKbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P192MB1990
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sigrelse01: Fix out-of-bounds read when invoking
 write()
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
From: Florian Schmaus via ltp <ltp@lists.linux.it>
Reply-To: Florian Schmaus <florian.schmaus@codasip.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The sigrelse01 test would invoke write(fd, msg, MAXMESG), where
MAXMESG=512. However, msg is often as short as "ready", i.e., 6
bytes (5 bytes + \0).

This mismatch causes write() to read additional bytes outside the *msg
buffer and write everything to the file descriptor. For example, the
strace output of sigrelese01 contains the following:

     write(6, "ready\0Unable to tell child to go"..., 512)

Fix the out-of-bounds read in sigrelse01 by invoking write() with the
correct number of bytes to (read and) write by using strlen(). There
is one case where sigrelese01 invoked write_pipe() not passing a
string: when the child sends sig_array to its parent process. We
convert this case from write_pipe() to write() using the proper
arguments. After doing so, the memcpy() of sig_array is no longer
required.

We identified this issue on a CHERI [1] system, which provides
fine-grained memory protection through architectural
capabilities. Unlike traditional MMU-based protection, which would not
detect this specific out-of-bounds access, CHERI precisely bounds
memory regions. In sigrelse01's case, CHERI correctly identified that
the 6-byte buffer containing "ready" was being overread. Consequently,
this out-of-bounds read during the write() syscall would cause the
Linux kernel to return -EFAULT, revealing this hidden bug.

1: https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/

Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
---
  testcases/kernel/syscalls/sigrelse/sigrelse01.c | 14 ++++++++------
  1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c 
b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
index 95754212053e..f7fdfbab3a28 100644
--- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
+++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
@@ -486,12 +486,14 @@ static void child(void)
  	 * then PASS, otherwise FAIL.
  	 */
  -	if (exit_val == EXIT_OK) {
-		(void)memcpy(note, (char *)sig_array, sizeof(sig_array));
-	}
-
  	/* send note to parent and exit */
-	if (write_pipe(pipe_fd[1], note) < 0) {
+	if (exit_val == EXIT_OK) {
+		if (write(pipe_fd[1], sig_array, sizeof(sig_array)) < 0) {
+			tst_resm(TBROK, "write() pipe failed. error:%d %s.\n", errno, 
strerror(errno));
+			exit(WRITE_BROK);
+		}
+	}
+	else if (write_pipe(pipe_fd[1], note) < 0) {
  		/*
  		 * write_pipe() failed.  Set exit value to WRITE_BROK to let
  		 * parent know what happened
@@ -622,7 +624,7 @@ static int write_pipe(int fd, char *msg)
  	printf("write_pipe: pid=%d, sending %s.\n", getpid(), msg);
  #endif
  -	if (write(fd, msg, MAXMESG) < 0) {
+	if (write(fd, msg, strlen(msg) + 1) < 0) {
  		(void)sprintf(mesg, "write() pipe failed. error:%d %s.",
  			      errno, strerror(errno));
  -- 2.49.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
