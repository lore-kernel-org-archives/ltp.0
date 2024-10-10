Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9588CF07A8
	for <ltp@archiver.kernel.org>; Thu, 10 Oct 2024 05:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728539787; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=btWIJXeIN+SixqdGXh2+V4Otg2nN1HhoMzf2YKO25BI=;
 b=lFrPrfBwCbmHlBaL1w58gsG/rmK7f+GUNacLdopYrhZggnAbypOxCmtMZwP3lex3HpVb2
 iPKfGBD5T5GzP4OpcuzDk8GpNh+udAOzx3zL8D+TljlMl05p4IH3zpRNMKSEIb8EtHn8pxE
 O+hBQj525T2UH7Ubds4+YdEStSJ9eAA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4E343C267F
	for <ltp@archiver.kernel.org>; Thu, 10 Oct 2024 07:56:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 826613C076D
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 07:56:06 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=216.71.158.33;
 helo=esa16.fujitsucc.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5CFD71B6200E
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 07:56:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1728539765; x=1760075765;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BBfClUdVpsjeWpbFRo//Z01Q4YUE817iZl5pLrdeujQ=;
 b=HfxVbf4ezzwxmihIRoXNZ8dBIPx/jJDFaHdAXwZbrzg/mDfqXEUPtX+y
 sozDAzQmRwGq3ELwl8Hi3rTMbbgVZ/STRc544ANHE+b5WPIxkhXhYddmy
 VKQKgrfmJ2wpmb9ZIVhQWrYVsOl2ttiHjjzfHvtmALKJr2e/k+bhj0NH4
 kor8P2IayLEQweUu1MJvk4pB2Trvx23Yc0PDjctQ3w/C1Wb6IBvupvYjD
 ZEwcAx+OMO8caftUQiWH+DspGFfuAwkYWq+xTY3mtNhFPtjYPPHvXZjsj
 XPJpBI8bfSBi2+HCA23fU7qNysfCupbF6BkXIMKXuIRaUP5vtfTxi7n22 Q==;
X-CSE-ConnectionGUID: 9/+n5hDVTX2WDMHrGtuzBA==
X-CSE-MsgGUID: uoFggFb8QLC85LekslA2Hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="133268531"
X-IronPort-AV: E=Sophos;i="6.11,192,1725289200"; d="scan'208";a="133268531"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2024 14:56:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/oAWpLB3vPZf0Gjl/6EpufMr42lcbyL34M4iUjUQ2GywtV5fmGGvtm7NOTHDFrYW7bPfwzkKVEMEurg8Vak00oesh4zP1tZaLDpLZ3TvFuOfq7FnWO+amy1Vj+ohSfRK+sA3uX3cWZ2nNZ+iAmcNqLDNQPWqiEunmIhFOR06HJZ60yAdIIcYl2vBFy6bnnALcioy6D0eSGAbcebY8jTYo++bOZKCxe3RSsFlrw+/edIgPWA3X0qrBE5rxFHjiCeayj3STtCyAvjS/tmESOVYFRsCwyj5uuwxLiEDwO1D+Sg+9+RTn3khfNl3glQcBP4SFVhw23vyBRMfemAmWNIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBfClUdVpsjeWpbFRo//Z01Q4YUE817iZl5pLrdeujQ=;
 b=wsfB2B8UoSr4EMbf7jgR78fvTG6fPHNaucoOHW2OlpCo64WO7fFJTEkl0TCbAlK4SH1GSnUCwRal7MGb2IOdmQ8UIswdyS+TwuBzgoMwVaVxlh29Qy3K2urfMc4wjY2r0M2sTPcUaCgbtUNpvPURPw1Ycq3Ouz3M+N/ZjA7e+WPwo7hxviR8EV0cz4nv1YUNmOr1DGbfoAQncfOkoq1HfpIyUMZM2IxUbTn0+xFkqChzxqaGluDSPjFcWXFC5bMCgv1il+qDTidF0tzdZdM9/ZyRFwkTNI1wP+gu/0VBNWHDol1ReG07B5sW62dBwKsfjskWxSOkl2vOPnbFdZ0C8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 (2603:1096:400:3cc::12) by TYCPR01MB5710.jpnprd01.prod.outlook.com
 (2603:1096:400:42::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 05:55:58 +0000
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9]) by TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9%6]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 05:55:58 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [PATCH v2] rt_sigqueueinfo02: Add negative tests for
 rt_sigqueueinfo
Thread-Index: AQHbCnPX3DRZn9s0c0C5dY64sYQgB7J2zNiAgAjOSjA=
Date: Thu, 10 Oct 2024 05:55:58 +0000
Message-ID: <TY3PR01MB12071B99072CB0A93B67052A7E8782@TY3PR01MB12071.jpnprd01.prod.outlook.com>
References: <20240919091230.570477-1-maxj.fnst@fujitsu.com>
 <ZwAHn9lO56KKgGJn@yuki.lan>
In-Reply-To: <ZwAHn9lO56KKgGJn@yuki.lan>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9M2YyZDhlNmUtOWIyZC00YzA4LWExODYtOGViYzVlZTlj?=
 =?utf-8?B?Zjg4O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTEwLTEwVDA1OjQ4OjM4WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12071:EE_|TYCPR01MB5710:EE_
x-ms-office365-filtering-correlation-id: b44af3be-0937-467b-f3c1-08dce8f0368b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?T0F6dERINTlJcjE1R0FPWXpOSHFhOGVaWEhYSHhQc2RkQllhMnFQcWdXVTMx?=
 =?utf-8?B?UTFXWlQxRlo3NVJoaUtsbU1HUGxBL0NwM0dCOHRPaDVRMENtZVlaRkZyM200?=
 =?utf-8?B?cTQwTGRTdm82NXlPdHV1bFBIckVWYkYrMWFqOXR5SkFWNzEvZjhtN2VCcGQw?=
 =?utf-8?B?R2xDZWZlblZtTzA5ckQyQlVOeGJlUkl3c3FNTXNoK0FPazBnVDQ1Nmd0N1Zh?=
 =?utf-8?B?dUFjSXNObWxXdUU4UzJnaSs0VmI4UDE2R2RCTjMzU1BJZlo2TXVnTXlLclBo?=
 =?utf-8?B?cndaSndXSGNadFM3TmVIQk9haSs3bmI4Zy93MThNN0ZzQUtnZmcyVXBRMGJh?=
 =?utf-8?B?Y0gvd3dkUVFSQ1FVMHF6MFY3bittTEhFcXNZaEdWbldacE1CYlRBd1kwbWFr?=
 =?utf-8?B?bTVMUEZ0QmZXc3F2SjQ1SmFLNURLcThhNHBHL2RZUmZBVHd4WE5GTktHaVJQ?=
 =?utf-8?B?WEtjbUxIQVlJbGNERjdENnU1eU5GQjJwTHJRcTd4VCtMZVV6ZS9LeExSbXpV?=
 =?utf-8?B?T2tnZ1lsMFQ3Q3RrbE1PaHNqenBvY3Z0VFZTYnBRMUlvOFZTS1VhKzE0dVVw?=
 =?utf-8?B?RlhwSzl5Z1Q2eDA1RmxxeEt4QTJKdTF2N3lFSHZOMUJST3lkZ1RIVzA2aWJi?=
 =?utf-8?B?d1pKeXI2RkpVSXROTVBpdU0vNGFvTDBpaW85REt2bmFpbFRhYmExcGtJMXVI?=
 =?utf-8?B?QlBpTW41VW1HUjNwSTFzQ1RQK3ZQdUpIYlR0bnJSVGJzdnBkNUZPTlJISkhP?=
 =?utf-8?B?Y1A4b1JWVzY5MDJlM0pWd2VtK3VkZlFOV2RwSDZEekEwNkFTSjNIMDVOeXhI?=
 =?utf-8?B?eDR2ZkJWOXBzOXd1dG0vTjZKQjFCWkhnTEQweEcrdzFZM3NyTXkvTUFIMDN3?=
 =?utf-8?B?cTBoTU1JbWVJTTFGam9wNWw5SVdEVW5qaG1VeSsxWWdvMnN6R1JIWWhzSXN0?=
 =?utf-8?B?b2k4djBmY0FQU3JaRmdKak10TkZneWY3NVF5Qm1YZlQvSExLNEppNHJ4MUgw?=
 =?utf-8?B?ZmJ5cnl6T3FLZmtoU0xiWkJkTHhZZ3hvZTFLQUlIUW5wd3N3cXFtWmF1SVdz?=
 =?utf-8?B?Z3Y1NTljMmgyK21QbnZ3YkhRaDJGSlhrSGxFb2lmbENubzZhbGsxbTNVOXpB?=
 =?utf-8?B?ampmbnJpYkFsaU5xelh6L1N0c3haRVBvWWFMWFFWNGN6aU1rcGtqSXc3NWl3?=
 =?utf-8?B?UndMbkxZckxKUms3UDhFNFVFTy9HQ3paTktnZkZkdkE5QkR1NUdDNFNnOHVx?=
 =?utf-8?B?cU5BWjFLSWk3a3Q1cHJucmlLNFlpZk1OcTFaWVFrVDk4c3BYWUswdDlzMGNP?=
 =?utf-8?B?dW1DRXlTcXIrVXJxUmNiNFhrVXVtTnN3bnJYQlM3R0tNOTN6cUJNWEM2YU1N?=
 =?utf-8?B?U0hoS0lpVDM4eXFCVGdTK0YwbFEvTERrdU9jek84Z1lZSnl1Z3ZMMG1RSkIy?=
 =?utf-8?B?aUREQ3AwdVVBZmZOem5DVGZ0MS8xMCtzOUR1a1VvOWcwbEhYNXYrVlFjWW9o?=
 =?utf-8?B?T3pxQWNDd1Y3UzFzeGV6aVN1ZFRmS2dabUMvSnJqc0ZQMU5XN2VMWjI2anor?=
 =?utf-8?B?emF0ZE9rb0J5UFFBMHhjVDQrQytCUmpGYlVlMUpjOGdoYlE0TUhhRkw3Yndj?=
 =?utf-8?B?OWJVQnM3V1hEYXdZMXV3cHdzWlBOWkxjZFl3ZU5XYkJicnJPZnFyZEVGY2Rl?=
 =?utf-8?B?eDhJWHo2Y3Y4eTJqQUNuQktJR0Z3ZXVSR0g5enlpS1lmdDNzc2Jqcjg1Qkw2?=
 =?utf-8?B?aWJ0UHlqaHFQTTVwVU9ZUjRwVThjb044Rm5VaHpiaWVXQ2N1TFJaVndrOG8z?=
 =?utf-8?Q?XmsPm1l2IssfihcgUh5Pm4ohZ8TUKD0dyGJmc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB12071.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkUwd3NyVG95S3MvQWxBUDFTTm5QNlVGdkl3NnBtSFpYS05JUHRycWFkNnNp?=
 =?utf-8?B?a0JIaHNOTlh1eHpqdklzMSt4aUFDbDJWMy94TVdDazRxZExxOTNiSXJWNmt2?=
 =?utf-8?B?ck9xV0pXY3ZWVVo2VmJQSHE5aThpNDlWTFdPZkhMaGs3cHJSKzBWeHpZSGtO?=
 =?utf-8?B?Ymc4dnRPK2x5U0x4V3Q0MkRvU29xU2ZscEhHRWpROWNlZXhqQ1hTdXl5dXBi?=
 =?utf-8?B?a0ZsOTEzSE1BTFcrczZib25ySy8rREsveDlXN3VZYjMvMnBMbEFtKzd0M3lL?=
 =?utf-8?B?WFJQVWZRdWtFOXBnWGFkMUU5VVFTYjk3dkdDNS9IZHhLVXRSM0ZoOFYvY01L?=
 =?utf-8?B?YkxkMko4OTBueDJUQnNvZ1VsS0FYekFicGorM01vclI2NkhSUkRmaFNQZVk2?=
 =?utf-8?B?a2lIQkF6bUpzWjdRRERkYWtHV1ozeEdkdHVPVU5MeGpvQ3U4UTNXQ0dEbVRE?=
 =?utf-8?B?anFtWjBOV0ZhYmNpYlJNdm45bUVZUStWNEFXeHIrR3kxcCtoakd6Z3FHNlpI?=
 =?utf-8?B?bi9xZFJlUDBWNmw5ZXNPbVVsRk5tOGVLQXQ3cnkvb3RoVjM1dVZSZm13cGdO?=
 =?utf-8?B?V3RRTE02VXdTUmJWd3NpMDFuRGNRWUlja0VTLzgxa0NoV2gyTkcwSGtkYVU4?=
 =?utf-8?B?OG1HWUZHU1Q0VmtBOVdteXB2aTJpQ2tDNmgrN3N6ZWJYNE9Cbmx4TTJnNm9K?=
 =?utf-8?B?WFh1VkJnbEpuYzd1NkEwTDlRVWpNRWExQUJYb2cwVHhscmhQT1FWcFMyQk4r?=
 =?utf-8?B?ZU5lWmhGVWJHZTVMWFo5ZTIvVlo2aGxxYkVzZCtVZEZUbGFRRGtKY3UxTGZW?=
 =?utf-8?B?V1hvSmNmdWlhcjF1L0NJOTRqVlhFL1p3d3d5Z2hUVFIvT1RjdjZRVmp1YWp1?=
 =?utf-8?B?bHdmWDh0ZjIvWVFiMzNtQ0o4TUpGU3cwKzBNc1JhRTluOHp6TVpaWU0yYnJi?=
 =?utf-8?B?SWRxaDh3b0M0dDNlVG5FZ2RxM2lxcTlZZVAwRWdyTEN6YkRMUUpZNk1hL05D?=
 =?utf-8?B?aXRFN01KejhtYlNoSkM3SUszM3h5NnlueFQwdy9UYkZ1VWNrQ3VMM2Fkcm9T?=
 =?utf-8?B?WSsxM0VZRSt4T0FxalgyWU82Vjl1THV5V1hPOEs3eFFudHdmdGZXdjdQV2pp?=
 =?utf-8?B?ZG5LQUdaNWI5MjRUSTJGQnQ2c2lUV1BpQklqZWIrNzVDL0pjRkpuVTZrQjhr?=
 =?utf-8?B?ak95RlVGdmxhcGhjcXZRMW1BY1M3Q29wd2hORUlhSWZMcWgvT1dWd2Y2QTVC?=
 =?utf-8?B?YUFwVktBWk9VZktQbXhBcnBOSXRoWUxEcE5aNVV3Y3N0cWtxMVVmSWdTQ1pP?=
 =?utf-8?B?bzdkK3RiQUVsbDUwM05DTXJqUVY1UjNwbVlKVEtGNjd4SjlrNjl2RWZhVjBN?=
 =?utf-8?B?TmZpMWhhQitLeHZjMTc2RUkrL0RRRVRWYXk4VENhNG1Yalh3QW5kUmRVS1JL?=
 =?utf-8?B?bk1jeE9OeVh6cEdHb3NVNi9CR0JlSWdOM1pHaDBDQlIvcmJGR0YyYlAwaE1F?=
 =?utf-8?B?TS9WYXdCSDNYL2UyVFdORVpkd1I1UGNWMXMzc010THR3T1BoT1RSLzd2Rmgr?=
 =?utf-8?B?Rm9ESEhUUWgrZjVTK0RrMWlrR2l4TmFxRWRVUzdRdHJ0emg0ZE83VFNGTWxy?=
 =?utf-8?B?cnJTVHVWRE9Na0ovaStPUW5FdWxod0NLaWh4WEtLdzBQTFl5bTNvRjVPalg0?=
 =?utf-8?B?bGRXTzBrUlhNOHRiNnk3SWlEOTA4MDFROUJiMndIVzBMVVA3Wm1yZ1N3MENw?=
 =?utf-8?B?UzFhWGo0c2wrS0JEL3NxRlF3RkkyQ1Z6S1JMcEQwRXlHdU9ReFlGV0YrYlda?=
 =?utf-8?B?K3JJOW5MTC93RnJBRUU3M09ieW45Sjk5NlFOMUVhRHcyMlQxY3F0VSs2TmhU?=
 =?utf-8?B?elp2MlBPZUF6a2tsT0tBZTN5QUFqOXl1MDZXckZWbVJiTytQT0FSOXZHWkht?=
 =?utf-8?B?RmxsSkRabFRLbTg2WC80LzEyTFBGN2svMVhqUGtSdDdJZDNWQW1aY1VrbExN?=
 =?utf-8?B?VkQxeXAvSGxhTzdUb1VFeVNuMitOVkVyVWxKOU01Q3hjOUVZakpCU3JobEEr?=
 =?utf-8?B?ZStiZXZxM1NuWVpJSEEzQlI3V0lFQlJpM3k1cUh5a0lxMVBjazh1OEhISUt3?=
 =?utf-8?Q?FztfhNE9rEMB2R0HWunQkVNDV?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7G4o3jiPWo7Tb/W/y+C8mAnoz/ysfL5bgamkWpt1uvGoz5/oeHXpX1PKaLkNhQIjd4/2iRf3AHWKPBxJy0mxSThbXr48Zx6wDrDF2CrtUnE2Sm5XjjbgIGr3z1jp5gcjtC57iuiDLhE2M58JeBDU4mVUBTl8bD6HGZyE3oxz2kaOG+PhArm2OWqDumbBHVyqRI9RB+1qhd/WDBHsXE/PKET6GgEeb8FxBepcH/c5DZOFogktBpyUqT/UwC6HaUGCY9hKJb5oVmvY2B4WMCZ4ILuzH8aognSPYNOK7S9PIw254vY7YI7fYN15J+24TI3meU6TkWgmfDd1NpUgC5bQQ3N7ftz4AOWescL6eDErq6NEzkGpLT3TX7jhC7YD9ahXsawqwn76mxKL2pvMekGEjAoi77fS8V0M8gM/9RgLoyzCCiaERP4SpJ0lfyHSxAWQk/F6hYjNvTX9JUDJaS1bzmWEWktH/i4XjJ27J2aLAloM4FCLLrPAjdKmMJ3yCtOr/6M387YazHtJQn1HEtcB0UfXS6hj/gYSeKYB6RoLiP759Q4YJUJWQrl9n3FWsIimIJH7HFyCBfdNrwd/PpcyMOz20Dt8Jdj1mjqZoQkMSRTW53fPkCSNLfsyOO661KxV
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12071.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44af3be-0937-467b-f3c1-08dce8f0368b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 05:55:58.4143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQ3TcNu2kQGCOGyr29kvt0cC9TlAhttu96+b8g6mXmDM72QJJZRbjGuggHuXX/ovJN+ZIKWl7gaFsFH3GnH+9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5710
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] rt_sigqueueinfo02: Add negative tests for
 rt_sigqueueinfo
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
From: "Xinjian Ma \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Xinjian Ma \(Fujitsu\)" <maxj.fnst@fujitsu.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi

> Hi!
> > +static void child_do(void)
> > +{
> > +	TST_CHECKPOINT_WAKE(0);
> > +	TST_CHECKPOINT_WAIT(1);
> 
> This still has the wake/wait pair in here. Why?
> 
> As I said preivously I do not see why the child needs to signal the parent if all the
> parent needs is the child to exist.

Oh sorry, I think I totally get your point now.
I sent the v3 patch. PTAL.

Best regards
Ma
> 
> So the child can just wait here for the parent to wake it up.
> 
> Or we do not have to use the checkpoints at all, the child can just do pause();
> and parent can kill() it once it's done.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
