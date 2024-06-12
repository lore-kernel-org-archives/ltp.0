Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9DBC27C53
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 07:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718177300; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=3Dw+UB+LoTp/U47wNOtZ5CzFiyQ435BzL16e1sl0Ym0=;
 b=dFv5Qjtfa1lkCqRebOFiBOuEq4OmeCE83AsnwKcdjpju139jt6SX6HxibrKRPkRZtlT1+
 bEd1d6sLLMBIHx2+TLVSBjQ0x033iodheM+rGujCEyqUlWhSgOWIiKteRMW/Hus3MfWOFMY
 IlfjoxRqT7qeQv+eCWy3WUi/S0f7LVk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 925373D0BAF
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 09:28:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B24B53D0B76
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 09:27:54 +0200 (CEST)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feae::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E983D610221
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 09:27:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lACxDgtThvkeFNd7GXyxHQu6JI6IG1nOLoqQUXIOTlziZMVlrljYw7pwluWPfkCt/YIyaSz5DgP8L9kC5wHXuCTaWKOEVaJA6b7nfBjwZParuHEzdsfL+zhnraExnPy0M/9/ub7NKPDravhQpIMPCr1kTo8dN0FvQWNnI2QKQXY3cUDN2kAu/fuLpVOfYibswMZLCedlPtcgNjf5RJ9Y1ScII5Or8wL/Ql7yjK1qTTCaPccfECp5RHkygrxo28Ue0QC+Uuu6B7Mhq9zEPXt8Ld/TVROQcC48KObQj8wkXV0M/0u9nPeC2sek9dU1JMk83475J6E/DhD3yf167B/mmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgMmotGz3edM9JNmmtz77ueTOm5n7aoM2wJSjFcyv3c=;
 b=JT2c/11WleH8a5/tLmC6ogG4hswbIA3Qh6Ud/ODQi0K9lmw7qwlv+uM28+2mMPO6XAvixQmWJht5Ozjk0OQYab7zco0Fv5/Dz0HOMVYJArfL4vrX/NG4rm035zdtW3TExXqVtU7kZSSI+AWBBtFxrAR/+w3MnXSeUqe633g/j9guPzinButS3jbPkqcv7VGzyDXtJtDXQNPWUioRK/vpKRzxfAD1xbz+FIxzScx4pMB2IOgksOGKt3UcgxETkHk7rRH9cYfoFaJmmEAGyM1tObxC5gXuOWqdlfLZXKWv47K6CXeWUYdKtHJxy9pusdzGtH+wpSVZeOxJAwDcZKpGIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgMmotGz3edM9JNmmtz77ueTOm5n7aoM2wJSjFcyv3c=;
 b=Ne6vhenKlM/GCI7CNJ/fElUww1zKdAvCW47HPa8Ye4Bf+kjZXtXmDljQQ+rtL/cmUA5qiDi9fljoFK8tJFUE8ll5DqrdZk0R1M3NXGxCJFyykBsRxNNLvZKP9lT1mGFjBE8k+Sh2bfB8lzvrxllBWf7PWdbjYu5HfkQqpnr3294=
Received: from SEZPR02MB7037.apcprd02.prod.outlook.com (2603:1096:101:19b::7)
 by SI2PR02MB5707.apcprd02.prod.outlook.com (2603:1096:4:1ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 07:27:47 +0000
Received: from SEZPR02MB7037.apcprd02.prod.outlook.com
 ([fe80::b946:6ae4:bb79:5d8b]) by SEZPR02MB7037.apcprd02.prod.outlook.com
 ([fe80::b946:6ae4:bb79:5d8b%5]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 07:27:47 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] Reduce loop count to meet need of low performance
 terminals
Thread-Index: AQHau7FBpMdqR1iUI0C3YbwoRFy64LHCcQGAgAFGCJA=
Date: Wed, 12 Jun 2024 07:27:47 +0000
Message-ID: <SEZPR02MB70372C81C17D62159C21742D89C02@SEZPR02MB7037.apcprd02.prod.outlook.com>
References: <20240611034058.12611-1-xufeifei1@oppo.com>
 <20240611034058.12611-2-xufeifei1@oppo.com> <Zmg3veXx0s0b5B4H@yuki>
In-Reply-To: <Zmg3veXx0s0b5B4H@yuki>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR02MB7037:EE_|SI2PR02MB5707:EE_
x-ms-office365-filtering-correlation-id: eb2bb597-5fdc-4ed4-d748-08dc8ab1287a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230032|1800799016|376006|366008|38070700010;
x-microsoft-antispam-message-info: =?utf-8?B?ZDErcEkzTG9rQ2NvZ3V6VURyN28xb2RKYTdwaUhuYTVqMEJhNWlENG85SU9m?=
 =?utf-8?B?MzFteEQzME0xcnJQT1lPOVFBU0dVMkphb24rNUZIN01qWmI4WC9UdkRUTXJx?=
 =?utf-8?B?cWdFaWpHMVFKbEp1R2VHNC81cDJpNW1PUDQ4NFk2ak9KcDEyenl0N0tRNit5?=
 =?utf-8?B?a1p5STdEZm51QjRvOFhtVUxsM0oxeHcxcyt2VzRWenFtYzRBc1ZKcE1hS3Iz?=
 =?utf-8?B?NHhlbVZacVlIODZoNmx4U1BhREFlWGkrOVFvSzd0MzN0cTYxZXFLSkh6ZWZB?=
 =?utf-8?B?WjhsN25IdUFqRlRyb3N2U0FVR0s2bTNWY0JmSEtZdjZSa2Q5SE9paVV4ZmFE?=
 =?utf-8?B?ZSt2S0lpSDQ0ZFYrS0ZXc05GZ3BqbDNIZlZ2Rk5NQlprcHE5WVJzcFRZc0tZ?=
 =?utf-8?B?QTlwZURNZkY0OEt5UU5IaVdOa2VtdGpyMnNaemN0Q0QrN29BRzV4QmNCRS9F?=
 =?utf-8?B?RFBIb3pOWGtiMmY1bFh5NW0yMU1mUlcyTExpTld2T05leVJTQmhjZC9uTlNn?=
 =?utf-8?B?STlnS0l4bU1ONlpiNlU2U1l4Ykp2dWI5TE5idTBLaWk5cFJIeWNFd2dsZlRs?=
 =?utf-8?B?MkdzOVdTY2JvcmlaZzFuYndHbDZTeW1sQW1vejkxa1FkV25TQlNMNmlNQnlT?=
 =?utf-8?B?RWhmVnV2QXZDVGxQQVgzTlAzUGcvRCtmWU50TW5CTlh4M1dpOWFsZlpRS3Za?=
 =?utf-8?B?NnB5dFl2M1Y0UnBiclhHcms0Qm1TZWM1TElqZjEweCtRd0oyMjgwN2pzUUFn?=
 =?utf-8?B?d1oxU2MyL1dHbGtNVHdGZ3M4OEVYODV4OXlQSmNmSXBseXZORHJERUUva05l?=
 =?utf-8?B?V1JVQmlYeTRFRmdrUlVyOFBMU3Fqb2JVSFVNRCtqOUVTbVJFaUUzTHBxUk8z?=
 =?utf-8?B?bDE1TTFmMVR1Si9QMEVGRmJzbEFpazM2MXQ1TXF1cGl1Wlg0cnRQbkN2bEJY?=
 =?utf-8?B?YVFSenBOSUhpaTdoZEQ5U0liNGRqNjBqZWdBZnRIK3pDMnFaUmlKVFdvb0dF?=
 =?utf-8?B?MHF2RysrSDR5dElKd3cxZkdHZ1p4Yk0rdFQzaVQ3RG41K2NvN3BFZEFNQjlh?=
 =?utf-8?B?N2xyVWNMVk9LKzJ2bVJYMkU2U3N4TlRpZlMzdWdUZ1dPU1RzSEdiZjJIbGsx?=
 =?utf-8?B?eDhCN1VTM3I3OU1oRVpTZVMrSm5NakNvSE5raDVlQUZSZC96Qm1udE9zMHNO?=
 =?utf-8?B?Wkh2YXlCS2Vpb09NQis1MDgrQ2crNE81ZGZnUks1OXEyWVhEV042SlU0eC9Y?=
 =?utf-8?B?bzQ4SS9qUXBuM2tkTDBJMTBKZDZXd0ZETUNZN3dsSm51OUlNS2ppVWV1Qlgv?=
 =?utf-8?B?ZjEweDlxQ1lGdlZIWGVBRHBINUVlakJ2dy9mNERyZHd0alhwQXJaZWFVSnR3?=
 =?utf-8?B?b1BvQTFPNVh1eW1teWJTU3VsQ28xWlA5Q0ozcHB0M2hqUUF4K0J5d2c0c1hU?=
 =?utf-8?B?Ry9MRzVZNkdGS3lBS3lyV3NGejl6c1NvZGYyRERjem9Wckd1T0ozZlc1ZVB3?=
 =?utf-8?B?VWtPVW5tR1ZTK3BoNElOREJZVHJmZmNKOTJTamM4QTFObVVzRHZuS29HWitX?=
 =?utf-8?B?R2psZ09kVVAyQ2F1OFN4dkFqd1JtaFdkay9ncmdjUlZXVWZBcThiVnJ0Lzlx?=
 =?utf-8?B?WGFRMWM3UzN4VFJMRWc2TjE2dHdxd3JBdG1IYW1xcGpLaWk4VDJwZ3FoU0dp?=
 =?utf-8?B?UW5YVGlJN01YK2dGKzlRQlkrcTIyZjU2ZTFETHZsZVdvdnFVaWQ0aUpubXBn?=
 =?utf-8?B?Nko5TFN2cW1naVNYS0VHd09CZ2ZNVnR3Q21ERG52dUdZemNlQjNodzNnRWVR?=
 =?utf-8?Q?c4t3GJ3K0vDLDvfdsMsyXuUGgzvR7oKF6MHvo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR02MB7037.apcprd02.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230032)(1800799016)(376006)(366008)(38070700010); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajk2VGNweTN6cHBSZlFibUtjc2NGUkJ2WTdUMFdieDJGaGVxYnl4d2Q4UDEz?=
 =?utf-8?B?dnZ2R3hFU0tzLzN0Q2ZlS0p3WWJoMnZhUnplajJQekk0NC90SHBYZUkycld1?=
 =?utf-8?B?andlQ2xISlNpcU9mUENTYWVFODdSUnA0dVM2V2NwczFoemdhZVkzTksyM1Q2?=
 =?utf-8?B?ZExFTEpZVDJYZ2pkR2ZqaXhzMUp5aXNhZytscUZRSEFHOFhzNms2QkgxS2Jr?=
 =?utf-8?B?OWVYaWROVGZFMTBMK05mbnR0Tk5DakhDb1EzTUVBRjhnRUswdTVKOGR5NUZD?=
 =?utf-8?B?MVJUWFVzVEdBaXFSV0oycmF1Y29KWUJBS1NSSzJFNmZvcXVFcmpMTlRPNncz?=
 =?utf-8?B?ZWxGa0dVZlRHeGsrKzJYellwZFhGS3AvcUVmZ09HdHFqcTBFbFVzemlkcVVO?=
 =?utf-8?B?Y1daSjVmdzNWbmNIbDJmbXBXUnEwT2pFb3Z6bXgxMlhNakRjdjl1clJHSzRS?=
 =?utf-8?B?cDRibGZ5U3JsbjRweU05Vi9Ya0RIdGsrcnVoZTl0VjZvQThYR0pMOXprVHJw?=
 =?utf-8?B?OFBxdjArUXRXTlhBcUIyQXY3bHFnNmhGU2RhVG54RDZPd3lVTU5WcThaR29C?=
 =?utf-8?B?QW5uaXVNeCszVytUS0dLWjhYb1Z5VFRNQ09GT2hhRlp4UGl6UmhBSXBaajJT?=
 =?utf-8?B?bVNweTBaZ3UyUnlveHdXRVA0eTJweVZya00vWVBuK0dKM2ZwOEVTRGJ2OCtU?=
 =?utf-8?B?TzN5OVNXd1kzeFlKYVdjMWVWeWtIOUpMdFlSb2ViUS9tOHMzT3dkcTRURStE?=
 =?utf-8?B?RTNiU2NPV0svQnN3dEdQemNPS1YxelFqbE1JZUJJMTRmcDlJNDdPOXlEVGoz?=
 =?utf-8?B?cktNRCtBditOaCszYVNDWnRPaEZ1QXc1MzhpSmVtZUpBT3dtcEkwdTFGMmtr?=
 =?utf-8?B?TkpoSXdtWTZpYWh5WThiamJRSmJ4YWN1Vmh4RlNxa0NRM3pZSDFGOWdNdEI5?=
 =?utf-8?B?WVdCaW1RdGV6Y3FxSFRrZzN0Y2NvQzJ3V1M1U1NlMFE1TEQwYllwemZKTHlG?=
 =?utf-8?B?a0pwK1hwT0YxcWRDa2RYc1hJeURSb1RpaXpraDJvdWp2V1Jlbjlqa0E5UjBU?=
 =?utf-8?B?WWM0NXpYRjVGb3lIUFB3eHM1NXQ5MmxpMG1oWW5PWXhIVVo0Y3Z5VHcwMnN2?=
 =?utf-8?B?TzZkdmk2bnplTm44bjlUYlJwRXh6OW9YUk1QSnFvcjFqcC94ZXN5ZjBmSjZi?=
 =?utf-8?B?a0lES2IvT1g0ajVzZDZKYTdXd3BJQkRQWlVscG9jT1MzY20ydGV0LzV6dEgx?=
 =?utf-8?B?aEtWb2RVNnJXNEV5UDdjaVAvRis0ZERMb2UrRHc2bzhFckp3cWVsOG5Jb1Zl?=
 =?utf-8?B?eFRoaFVLKytrbkg1VDNUNi9OeXRTQmJ4NjdiL01WYy9INDY2elZEbkRTTVVS?=
 =?utf-8?B?WVlKVXl6N1RablZBa0JvMG5QNDgxcU5MT0VnK3MvU1lsQ0RjRStHOG9SQktn?=
 =?utf-8?B?WEhNSUpPWlk5dHl1enZLbXlHWGZWNWpNaFZCUEsyQ0pBOTVTU1lnRk40TWVL?=
 =?utf-8?B?ejViMHJidHJ5Y0NqRmpXRXJkZXA5OEE2MDEwK0h0dVVtSFVjeUZucU8yd3RG?=
 =?utf-8?B?SG9sYVBBMzBSOS9LK1JILzJPWC9tY3ZaUGUxYlZQYlhLOG1BSVhSN1YyYnJD?=
 =?utf-8?B?UjQwTWRSblBuYUE2S203MWtMay8wN0NlQkJrSnBDWXcyM0k5Y0NyVXN6YjFG?=
 =?utf-8?B?bjZOQkJyc3dZUUd0cWN5ODk3bVZDczV6a09qeWwxYm54TTBTYXM3dnpxL1ly?=
 =?utf-8?B?UmNKRU1IcEU4V1N0bDAzQUNiR2lFcjVqZ01zNGhqUHVvbWJPOGY0SU5BTUhL?=
 =?utf-8?B?dmloNjVqeFlrQjF1aGJTUklwb2dVUGtIOHNzbDlQZFdoc2pRWTB2TWhRZnI3?=
 =?utf-8?B?QmFXV3lFb0U1WXlUZE5UYzF6Sk9IZVM2VHpCaDQrYm5jMjR3V1MxNitKaGg0?=
 =?utf-8?B?VHNra1NZOGpaeVRWTTRaRXdMU2FYaHBydUJpdFVQWnp0OGxKbkJxeWxwZjJN?=
 =?utf-8?B?M1NGWmJFbG1aaE5TNUFDWVlTcklWRERaQjlQRWFJSUEvaFRyTGVIcVRsSGpq?=
 =?utf-8?B?SG4wT29GUmNiVkx3Sy85TURwS1VMYnEvNFk3cFdHMjE4d05ad2QvWjJLOE9y?=
 =?utf-8?Q?OAb/sPOUdrBAecE84O7Sw8ZG8?=
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB7037.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2bb597-5fdc-4ed4-d748-08dc8ab1287a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 07:27:47.2334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o2jTweVUa/S2ONdL6B2EX2o/Zs6GaUNLG60PGD4beemg2e3dE3E6MdPEqutvpLPTkX9ta2KREXiJvDGvdxNe1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5707
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] =?utf-8?b?562U5aSNOiAgW1BBVENIXSBSZWR1Y2UgbG9vcCBjb3VudCB0?=
 =?utf-8?q?o_meet_need_of_low_performance_terminals?=
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
From: =?utf-8?b?5b6Q6aOe6aOeKFN0ZXZlKSB2aWEgbHRw?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?5b6Q6aOe6aOeKFN0ZXZlKQ==?= <xufeifei1@oppo.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

QXJlIHlvdSBzdXJlIHRoYXQgeW91ciBrZXJuZWwgaXNuJ3QgYWZmZWN0ZWQgYnkgdGhlIGJ1ZyB0
aGUgdGVzdCBjaGVja3MgZm9yPyBUaGUgdGVzdCB0aW1lb3V0cyBvbiBhIGJ1Z2d5IGtlcm5lbC4N
Ci0tIElzIHRoZXJlIGFueSBwbGFjZSB3aGVyZSBJIGNhbiBzZWUgbW9yZSByZWxldmFudCBpbmZv
cm1hdGlvbj8gd2hpY2gga2luZCBvZiBidWcgeW91IGhhdmUgZm91bmQ/DQoNCnRoZSB0ZXN0IHRp
bWVvdXQgb24gbXlzaWRlIHdoZXJlIHRoZXJlIHN0aWxsIDY0MDAwMCBsb29wLA0KWlpMIHBpZCA9
IDI5NDY2IHRoaXMgaXMgd2hpbGUgNjQ2NTMzIHRpbWVzIGxvb3AgPSA2NDY1MzMgLS0tLS0tLQ0K
WlpMIHBpZCA9IDI5NDY2IHRoaXMgaXMgd2hpbGUgNjQ2NTMyIHRpbWVzIGxvb3AgPSA2NDY1MzIg
LS0tLS0tLQ0KWlpMIHBpZCA9IDI5NDY2IHRoaXMgaXMgd2hpbGUgNjQ2NTMxIHRpbWVzIGxvb3Ag
PSA2NDY1MzEgLS0tLS0tLQ0KWlpMIHBpZCA9IDI5NDY2IHRoaXMgaXMgd2hpbGUgNjQ2NTMwIHRp
bWVzIGxvb3AgPSA2NDY1MzAgLS0tLS0tLQ0KWlpMIHBpZCA9IDI5NDY2IHRoaXMgaXMgd2hpbGUg
NjQ2NTI5IHRpbWVzIGxvb3AgPSA2NDY1MjkgLS0tLS0tLQ0KWlpMIHBpZCA9IDI5NDY2IHRoaXMg
aXMgd2hpbGUgNjQ2NTI4IHRpbWVzIGxvb3AgPSA2NDY1MjggLS0tLS0tLQ0KWlpMIHBpZCA9IDI5
NDY2IHRoaXMgaXMgd2hpbGUgNjQ2NTI3IHRpbWVzIGxvb3AgPSA2NDY1MjcgLS0tLS0tLQ0KWlpM
IHBpZCA9IDI5NDY2IHRoaXMgaXMgd2hpbGUgNjQ2NTI2IHRpbWVzIGxvb3AgPSA2NDY1MjYgLS0t
LS0tLQ0KWlpMIHBpZCA9IDI5NDY2IHRoaXMgaXMgd2hpbGUgNjQ2NTI1IHRpbWVzIGxvb3AgPSA2
NDY1MjUgLS0tLS0tLQ0KWlpMIHBpZCA9IDI5NDY2IHRoaXMgaXMgd2hpbGUgNjQ2NTI0IHRpbWVz
IGxvb3AgPSA2NDY1MjQgLS0tLS0tLQ0KWlpMIHBpZCA9IDI5NDY2IHRoaXMgaXMgd2hpbGUgNjQ2
NTIzIHRpbWVzIGxvb3AgPSA2NDY1MjMgLS0tLS0tLQ0KWlpMIHBpZCA9IDI5NDY2IHRoaXMgaXMg
d2hpbGUgNjQ2NTIyIHRpbWVzIGxvb3AgPSA2NDY1MjIgLS0tLS0tLQ0KWlpMIHBpZCA9IDI5NDY2
IHRoaXMgaXMgd2hpbGUgNjQ2NTIxIHRpbWVzIGxvb3AgPSA2NDY1MjEgLS0tLS0tLQ0KVGVzdCB0
aW1lb3V0ZWQsIHNlbmRpbmcgU0lHS0lMTCENCmV4dGVybmFsL2x0cC9saWIvdHN0X3Rlc3QuYzox
NjQxOiBUSU5GTzogS2lsbGVkIHRoZSBsZWZ0b3ZlciBkZXNjZW5kYW50IHByb2Nlc3Nlcw0KZXh0
ZXJuYWwvbHRwL2xpYi90c3RfdGVzdC5jOjE2NDg6IFRJTkZPOiBJZiB5b3UgYXJlIHJ1bm5pbmcg
b24gc2xvdyBtYWNoaW5lLCB0cnkgZXhwb3J0aW5nIExUUF9USU1FT1VUX01VTCA+IDENCmV4dGVy
bmFsL2x0cC9saWIvdHN0X3Rlc3QuYzoxNjQ5OiBUQlJPSzogVGVzdCBraWxsZWQhICh0aW1lb3V0
PykNCg0KU3VtbWFyeToNCnBhc3NlZCAgIDENCmZhaWxlZCAgIDANCmJyb2tlbiAgIDENCnNraXBw
ZWQgIDANCndhcm5pbmdzIDANCg0KDQpIb3cgbG9uZyBkb2VzIHRoZSB0ZXN0IHJ1biBpZiB5b3Ug
ZGlzYWJsZSB0aW1lb3V0cyAoYnkgc2V0dGluZyBzdGF0aWMgaW50IHRpbWVvdXQgPSAtMSBpbiB0
aGUgc291cmNlKT8NCi0tIGFib3V0IDM3MCBzZWNvbmRzDQoNCkFsc28gd2hhdCBraW5kIG9mIHN5
c3RlbSBpdCBpcz8gSG93IGZhc3QgaXMgdGhlIENQVT8NCi0tYW5kcm9pZCAxNCAsICBrZW5yZWwg
Ni4xLjQzLWFuZHJvaWQxNC0xMS1vLWc5YmJmZTkwMDliODYgLA0KDQpjYXQgL3Byb2MvY3B1aW5m
bw0KcHJvY2Vzc29yICAgICAgIDogMA0KQm9nb01JUFMgICAgICAgIDogMzguNDANCkZlYXR1cmVz
ICAgICAgICA6IGZwIGFzaW1kIGV2dHN0cm0gYWVzIHBtdWxsIHNoYTEgc2hhMiBjcmMzMiBhdG9t
aWNzIGZwaHAgYXNpbWRocCBjcHVpZCBhc2ltZHJkbSBscmNwYyBkY3BvcCBhc2ltZGRwDQpDUFUg
aW1wbGVtZW50ZXIgOiAweDQxDQpDUFUgYXJjaGl0ZWN0dXJlOiA4DQpDUFUgdmFyaWFudCAgICAg
OiAweDINCkNQVSBwYXJ0ICAgICAgICA6IDB4ZDA1ICDvvIhBUk1fQ1BVX1BBUlRfQ09SVEVYX0E1
NSkNCkNQVSByZXZpc2lvbiAgICA6IDANCg0KDQoNCmNwdSBjaGlwDQotLS0tLemCruS7tuWOn+S7
ti0tLS0tDQrlj5Hku7bkuro6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pg0K5Y+R6YCB
5pe26Ze0OiAyMDI05bm0NuaciDEx5pelIDE5OjQxDQrmlLbku7bkuro6IOW+kOmjnumjnihTdGV2
ZSkgPHh1ZmVpZmVpMUBvcHBvLmNvbT4NCuaKhOmAgTogbHRwQGxpc3RzLmxpbnV4Lml0DQrkuLvp
opg6IFJlOiBbTFRQXSBbUEFUQ0hdIFJlZHVjZSBsb29wIGNvdW50IHRvIG1lZXQgbmVlZCBvZiBs
b3cgcGVyZm9ybWFuY2UgdGVybWluYWxzDQoNCuWklumDqOmCruS7ti9FeHRlcm5hbCBNYWlsDQoN
Cg0KDQpIaSENCj4gLS0tIGEvcnVudGVzdC9zY2hlZA0KPiArKysgYi9ydW50ZXN0L3NjaGVkDQo+
IEBAIC05LDcgKzksNyBAQCB0cmFjZV9zY2hlZDAxICAgICAgICAgICB0cmFjZV9zY2hlZCAtYyAx
DQo+ICBjZnNfYmFuZHdpZHRoMDEgY2ZzX2JhbmR3aWR0aDAxIC1pIDUNCj4gIGhhY2tiZW5jaDAx
IGhhY2tiZW5jaCA1MCBwcm9jZXNzIDEwMDANCj4gIGhhY2tiZW5jaDAyIGhhY2tiZW5jaCAyMCB0
aHJlYWQgMTAwMA0KPiAtc3RhcnZhdGlvbiBzdGFydmF0aW9uDQo+ICtzdGFydmF0aW9uIHN0YXJ2
YXRpb24gLWwgMTAwMDAwDQoNCkFyZSB5b3Ugc3VyZSB0aGF0IHlvdXIga2VybmVsIGlzbid0IGFm
ZmVjdGVkIGJ5IHRoZSBidWcgdGhlIHRlc3QgY2hlY2tzIGZvcj8gVGhlIHRlc3QgdGltZW91dHMg
b24gYSBidWdneSBrZXJuZWwuDQoNCkhvdyBsb25nIGRvZXMgdGhlIHRlc3QgcnVuIGlmIHlvdSBk
aXNhYmxlIHRpbWVvdXRzIChieSBzZXR0aW5nIHN0YXRpYyBpbnQgdGltZW91dCA9IC0xIGluIHRo
ZSBzb3VyY2UpPw0KDQpBbHNvIHdoYXQga2luZCBvZiBzeXN0ZW0gaXQgaXM/IEhvdyBmYXN0IGlz
IHRoZSBDUFU/DQoNCi0tDQpDeXJpbCBIcnViaXMNCmNocnViaXNAc3VzZS5jeg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18NCk9QUE8NCg0K5pys55S15a2Q6YKu5Lu25Y+K5YW26ZmE
5Lu25ZCr5pyJT1BQT+WFrOWPuOeahOS/neWvhuS/oeaBr++8jOS7hemZkOS6jumCruS7tuaMh+aY
jueahOaUtuS7tuS6uu+8iOWMheWQq+S4quS6uuWPiue+pOe7hO+8ieS9v+eUqOOAguemgeatouS7
u+S9leS6uuWcqOacque7j+aOiOadg+eahOaDheWGteS4i+S7peS7u+S9leW9ouW8j+S9v+eUqOOA
guWmguaenOaCqOmUmeaUtuS6huacrOmCruS7tu+8jOWIh+WLv+S8oOaSreOAgeWIhuWPkeOAgeWk
jeWItuOAgeWNsOWIt+aIluS9v+eUqOacrOmCruS7tuS5i+S7u+S9lemDqOWIhuaIluWFtuaJgOi9
veS5i+S7u+S9leWGheWuue+8jOW5tuivt+eri+WNs+S7peeUteWtkOmCruS7tumAmuefpeWPkeS7
tuS6uuW5tuWIoOmZpOacrOmCruS7tuWPiuWFtumZhOS7tuOAgg0K572R57uc6YCa6K6v5Zu65pyJ
57y66Zm35Y+v6IO95a+86Ie06YKu5Lu26KKr5oiq55WZ44CB5L+u5pS544CB5Lii5aSx44CB56C0
5Z2P5oiW5YyF5ZCr6K6h566X5py655eF5q+S562J5LiN5a6J5YWo5oOF5Ya177yMT1BQT+Wvueat
pOexu+mUmeivr+aIlumBl+a8j+iAjOW8leiHtOS5i+S7u+S9leaNn+WkseamguS4jeaJv+aLhei0
o+S7u+W5tuS/neeVmeS4juacrOmCruS7tuebuOWFs+S5i+S4gOWIh+adg+WIqeOAgg0K6Zmk6Z2e
5piO56Gu6K+05piO77yM5pys6YKu5Lu25Y+K5YW26ZmE5Lu25peg5oSP5L2c5Li65Zyo5Lu75L2V
5Zu95a625oiW5Zyw5Yy65LmL6KaB57qm44CB5oub5o+95oiW5om/6K+677yM5Lqm5peg5oSP5L2c
5Li65Lu75L2V5Lqk5piT5oiW5ZCI5ZCM5LmL5q2j5byP56Gu6K6k44CCIOWPkeS7tuS6uuOAgeWF
tuaJgOWxnuacuuaehOaIluaJgOWxnuacuuaehOS5i+WFs+iBlOacuuaehOaIluS7u+S9leS4iui/
sOacuuaehOS5i+iCoeS4nOOAgeiRo+S6i+OAgemrmOe6p+euoeeQhuS6uuWRmOOAgeWRmOW3peaI
luWFtuS7luS7u+S9leS6uu+8iOS7peS4i+ensOKAnOWPkeS7tuS6uuKAneaIluKAnE9QUE/igJ3v
vInkuI3lm6DmnKzpgq7ku7bkuYvor6/pgIHogIzmlL7lvIPlhbbmiYDkuqvkuYvku7vkvZXmnYPl
iKnvvIzkuqbkuI3lr7nlm6DmlYXmhI/miJbov4flpLHkvb/nlKjor6XnrYnkv6Hmga/ogIzlvJXl
j5HmiJblj6/og73lvJXlj5HnmoTmjZ/lpLHmib/mi4Xku7vkvZXotKPku7vjgIINCuaWh+WMluW3
ruW8guaKq+mcsu+8muWboOWFqOeQg+aWh+WMluW3ruW8guW9seWTje+8jOWNlee6r+S7pVlFU1xP
S+aIluWFtuS7lueugOWNleivjeaxh+eahOWbnuWkjeW5tuS4jeaehOaIkOWPkeS7tuS6uuWvueS7
u+S9leS6pOaYk+aIluWQiOWQjOS5i+ato+W8j+ehruiupOaIluaOpeWPl++8jOivt+S4juWPkeS7
tuS6uuWGjeasoeehruiupOS7peiOt+W+l+aYjuehruS5pumdouaEj+ingeOAguWPkeS7tuS6uuS4
jeWvueS7u+S9leWPl+aWh+WMluW3ruW8guW9seWTjeiAjOWvvOiHtOaVheaEj+aIlumUmeivr+S9
v+eUqOivpeetieS/oeaBr+aJgOmAoOaIkOeahOS7u+S9leebtOaOpeaIlumXtOaOpeaNn+Wus+aJ
v+aLhei0o+S7u+OAgg0KVGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWluIGNv
bmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIE9QUE8sIHdoaWNoIGlzIGludGVuZGVkIG9ubHkg
Zm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBB
bnkgdXNlIG9mIHRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGlu
Y2x1ZGluZywgYnV0IG5vdCBsaW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUs
IHJlcHJvZHVjdGlvbiwgb3IgZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRo
ZSBpbnRlbmRlZCByZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3QgdGhl
IGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGRvIG5vdCByZWFkLCBjb3B5LCBkaXN0cmlidXRl
LCBvciB1c2UgdGhpcyBpbmZvcm1hdGlvbi4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyB0cmFu
c21pc3Npb24gaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBi
eSByZXBseSBlLW1haWwgYW5kIHRoZW4gZGVsZXRlIHRoaXMgbWVzc2FnZS4NCkVsZWN0cm9uaWMg
Y29tbXVuaWNhdGlvbnMgbWF5IGNvbnRhaW4gY29tcHV0ZXIgdmlydXNlcyBvciBvdGhlciBkZWZl
Y3RzIGluaGVyZW50bHksIG1heSBub3QgYmUgYWNjdXJhdGVseSBhbmQvb3IgdGltZWx5IHRyYW5z
bWl0dGVkIHRvIG90aGVyIHN5c3RlbXMsIG9yIG1heSBiZSBpbnRlcmNlcHRlZCwgbW9kaWZpZWQg
LGRlbGF5ZWQsIGRlbGV0ZWQgb3IgaW50ZXJmZXJlZC4gT1BQTyBzaGFsbCBub3QgYmUgbGlhYmxl
IGZvciBhbnkgZGFtYWdlcyB0aGF0IGFyaXNlIG9yIG1heSBhcmlzZSBmcm9tIHN1Y2ggbWF0dGVy
IGFuZCByZXNlcnZlcyBhbGwgcmlnaHRzIGluIGNvbm5lY3Rpb24gd2l0aCB0aGUgZW1haWwuDQpV
bmxlc3MgZXhwcmVzc2x5IHN0YXRlZCwgdGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBh
cmUgcHJvdmlkZWQgd2l0aG91dCBhbnkgd2FycmFudHksIGFjY2VwdGFuY2Ugb3IgcHJvbWlzZSBv
ZiBhbnkga2luZCBpbiBhbnkgY291bnRyeSBvciByZWdpb24sIG5vciBjb25zdGl0dXRlIGEgZm9y
bWFsIGNvbmZpcm1hdGlvbiBvciBhY2NlcHRhbmNlIG9mIGFueSB0cmFuc2FjdGlvbiBvciBjb250
cmFjdC4gVGhlIHNlbmRlciwgdG9nZXRoZXIgd2l0aCBpdHMgYWZmaWxpYXRlcyBvciBhbnkgc2hh
cmVob2xkZXIsIGRpcmVjdG9yLCBvZmZpY2VyLCBlbXBsb3llZSBvciBhbnkgb3RoZXIgcGVyc29u
IG9mIGFueSBzdWNoIGluc3RpdHV0aW9uIChoZXJlaW5hZnRlciByZWZlcnJlZCB0byBhcyAic2Vu
ZGVyIiBvciAiT1BQTyIpIGRvZXMgbm90IHdhaXZlIGFueSByaWdodHMgYW5kIHNoYWxsIG5vdCBi
ZSBsaWFibGUgZm9yIGFueSBkYW1hZ2VzIHRoYXQgYXJpc2Ugb3IgbWF5IGFyaXNlIGZyb20gdGhl
IGludGVudGlvbmFsIG9yIG5lZ2xpZ2VudCB1c2Ugb2Ygc3VjaCBpbmZvcm1hdGlvbi4NCkN1bHR1
cmFsIERpZmZlcmVuY2VzIERpc2Nsb3N1cmU6IER1ZSB0byBnbG9iYWwgY3VsdHVyYWwgZGlmZmVy
ZW5jZXMsIGFueSByZXBseSB3aXRoIG9ubHkgWUVTXE9LIG9yIG90aGVyIHNpbXBsZSB3b3JkcyBk
b2VzIG5vdCBjb25zdGl0dXRlIGFueSBjb25maXJtYXRpb24gb3IgYWNjZXB0YW5jZSBvZiBhbnkg
dHJhbnNhY3Rpb24gb3IgY29udHJhY3QsIHBsZWFzZSBjb25maXJtIHdpdGggdGhlIHNlbmRlciBh
Z2FpbiB0byBlbnN1cmUgY2xlYXIgb3BpbmlvbiBpbiB3cml0dGVuIGZvcm0uIFRoZSBzZW5kZXIg
c2hhbGwgbm90IGJlIHJlc3BvbnNpYmxlIGZvciBhbnkgZGlyZWN0IG9yIGluZGlyZWN0IGRhbWFn
ZXMgcmVzdWx0aW5nIGZyb20gdGhlIGludGVudGlvbmFsIG9yIG1pc3VzZSBvZiBzdWNoIGluZm9y
bWF0aW9uLg0KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
