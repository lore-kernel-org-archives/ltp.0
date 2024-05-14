Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B09C25B74
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 02:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1715654518; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=94/gVRnN9kwd6y9NQyWCB1ofIj+VSpw0KAsdJSuZlEU=;
 b=prC9FCJik64tUYYy3AtHpkVFRtMDB+2ibTvKz59DlzyoEoAv0cqGUZDk2aXyDiu6v7mHW
 6Scm0DhdMGO/u16wZ3efUYbkZCqkm3jJaNfd5zr85AzCT/TTuAG2Dvj2NXqNA1yYfvhG0rV
 eiRbsUfTAF39Fe+hpavQzet5juJC2pc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3CBC3CF1DD
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 04:41:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA2E23CDEAF
 for <ltp@lists.linux.it>; Tue, 14 May 2024 04:41:32 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.156.101;
 helo=esa14.fujitsucc.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BAA55600452
 for <ltp@lists.linux.it>; Tue, 14 May 2024 04:41:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1715654491; x=1747190491;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=5HhgR77Qx9k0V5aVFt9eJR02r8GVtjsy/APd97wc7jk=;
 b=oHmRt+80OtZiNifGVcJeVr8n2erPpfwqHwW2zBIIAFE2sA9GnDel+aRM
 doh+j6SaeyijyFtYv2HpiIDSnHxLBr3wlBG3D64uEaFt+/lAovIUct665
 0Y2MhxJX7D1DXIQsBJro1kaq8An/LZPmcLehlR8FxIfEzdBFZLyn1s1DZ
 sgFDu3Psh57bZG8L+Ltmenz8jElM2iO+tHnYJXepiqqY2QlSNXH+LyFgg
 R3SfxIARPh1xlnbFZ40RrQ9xF0xT3fbdcEGyOKmduyWf6ySgird+GA72N
 lvg5AhCLYJlciZ83CPFBg3u9WSJAkX7r3N2rkULLXc6GuJ3UPRxXD+M4+ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="118852492"
X-IronPort-AV: E=Sophos;i="6.08,159,1712588400"; d="scan'208";a="118852492"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2024 11:41:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFJYzn6BlNZ5boPshoSgvLYWpcV9CyNenwuJFtWxnmrOwrTmYHG2PQamIRqaXnp1qzFxNTUVbsfM0+FN4LeRWLENUnDCWk3msphD6Bb82TL3e4ez2JsNuER+DaDM5ZGmx635f4E+JJBXrdV2Cm0+fonwUe7bN1Gq7AHyXlStiq1hI6dbUu3coOyuCfGw0TU6tuQdeYY6QU1MD8kZiPCjKOYKnrWvWpOj7fSvNdEVeR17x2FWjLPh1OYNciI9ZjCUprkfYgaMTwOUu4lO/eisMyVvUNtTl+8C1pnwwSX0ufKqcNN116btnARcRijgLU2ZW3GXYgtIbrqD2hDPFi7fGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HhgR77Qx9k0V5aVFt9eJR02r8GVtjsy/APd97wc7jk=;
 b=mrKF+yEH2emVbrCJ9xaBXrR7OaPWO2z/r0HMlmtDYc99DXJWXlRvA6/EoBHBL41W25hL1eMwgXwS6ywZVofv+h2W62WgViP8jUmINCoHCDK782/U46qVcgSNXyi6gKHJy/5nDW3Ia1L7l9YVdVDOTc830JoBsuDxB577WxexGSKPbgilPNy0+2vk1GSNfvo5lQCtwQK+TsWkKZwwLuMdAJi15BEIzi6sqUzvQzMuykV8C6h3mOvkZgjYmTldJcXy+9Xw2s9Iz7FPLHi/6wgRYAcb7HZbLen4WUNdSPahKtbyHfp94Pm5DxfxWguYgQXWu8WBzJSHY5PiAFHeFT6POg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB6504.jpnprd01.prod.outlook.com (2603:1096:604:e6::10)
 by TYWPR01MB10969.jpnprd01.prod.outlook.com (2603:1096:400:395::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 02:41:23 +0000
Received: from OS3PR01MB6504.jpnprd01.prod.outlook.com
 ([fe80::573b:9293:619b:1da]) by OS3PR01MB6504.jpnprd01.prod.outlook.com
 ([fe80::573b:9293:619b:1da%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 02:41:23 +0000
To: Avinesh Kumar <akumar@suse.de>
Thread-Topic: [LTP] [PATCH] lseek: Add negative tests for lseek
Thread-Index: AQHamRBeynSs7No7sUiimhpP3jZ+G7GVIAYAgAD+QYA=
Date: Tue, 14 May 2024 02:41:22 +0000
Message-ID: <26b3c58d-ff1b-4f2c-82de-8692aacaed5a@fujitsu.com>
References: <20240425052536.68290-1-xuyang2018.jy@fujitsu.com>
 <2689176.lGaqSPkdTl@localhost>
In-Reply-To: <2689176.lGaqSPkdTl@localhost>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6504:EE_|TYWPR01MB10969:EE_
x-ms-office365-filtering-correlation-id: f45eca8d-ae5a-471d-8648-08dc73bf57e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|366007|1800799015|38070700009|1580799018; 
x-microsoft-antispam-message-info: =?utf-8?B?S2NNWGlDbjN4dmlNWENtczdSRFJDeDkxcXE4ZldhZStIUXN5VWljMyswYUpr?=
 =?utf-8?B?bmd5bnZkUVhsU0M3dVBBYjRnclVvYytDQ1oyVWZnSHgycVdKamI2cnBJdk5h?=
 =?utf-8?B?dG9iRllqTWd3bmh4eFdhdm9udy81OFl4MmQ0cDZQNndtUGRDcEZwaWFGbVRq?=
 =?utf-8?B?cnZTd1g5QVpsaUJmQ2pkMVB2eGVHVFpjOE9EdHhTOVhEdU1FQ252aGpqeG5C?=
 =?utf-8?B?dk85NnRJemhSMERnMCtWSmE1cFNKaXBsUHhXRTRoZllML0RDWWlGbXg1cXZo?=
 =?utf-8?B?ZGU1cWQyTUlnczNUUHRtbnh4WXNKSGp2Ukg2R21YYU94c1VqRVZUa0J2ZWhX?=
 =?utf-8?B?QjVxeHlNYnMvZGtTVmNvcUxLTmdNT1lGSkhmMmlEY1BMS3VoeVJRMW0yOE5W?=
 =?utf-8?B?ZjBiUzZPZmUxd3V5bWxjYnE4TC9VdVNnU0VLczFyVjExRTFzL1A5SFE0YWI0?=
 =?utf-8?B?aDErc1NOY3ZkYkp1TXhtZjh5MTJReC8rTzg2aWdRaEZGa2dEVWJlN1liQ2wy?=
 =?utf-8?B?OS9yL2p6R3dPaTVNalVROGkrcDd1UWFBY0lPVHBFL3ZaSS9VMlJoNHE0cFlP?=
 =?utf-8?B?QXh3SjZmcHJ5aGlHeGZtZWFkRzQyMGI5MDQzY1pzZEZzK0JKVk56YUFzODYz?=
 =?utf-8?B?d3I0dlpVQkIwTDhybEhwS3pEK0pZU212dklmaUxRUFlNS2JSSFViQVdUS0VD?=
 =?utf-8?B?YThtd2pkNTI2ZlNQMUVhQXVTUlVhY1NDWWZ1KytiRlFBQVVibGVkQnZxQ1lC?=
 =?utf-8?B?UHBzaTRVWjE2bFpBd3hPMjg1Q3cxMytiQ1c5SnUya3lBM0FiNjBybW9oRTJO?=
 =?utf-8?B?UEsxKzNoRFl3VE5xcVl6MnlHeFR3V3I3bktaU1Qya3ZQOS9kU2JzR3cranlR?=
 =?utf-8?B?ZUpwRGx2MlZaQXlocFVCS2dMb01BWTNLWXAyckhybGFuM1pYeVdqTDlDTlRk?=
 =?utf-8?B?N2dvRERtaFE5Qno3UXhtN3o0MHpxY1NwOWtCQThIYk9Hd2prZzA1R1J6bm10?=
 =?utf-8?B?SUVVeFdHT3U2UlF2QjFMV1V0bHNSQVMydWI3ejBDVzJlUjYxL05ER0FZK2E2?=
 =?utf-8?B?WG9pVVppdC85MytmSVdiRXdyWDN6V1oyZFJsbFVUTUVuaUQ0eGUyOTJrUGR5?=
 =?utf-8?B?WFJFRzhMZkppUTN1ckxtY05TcmJXU3RJMjJGUllLMS9Ed3Zva1ZQbmJ1TmlJ?=
 =?utf-8?B?N1hIOTFhbXdlUHJHdktRZURrd1F3U28yM0EzWThpWkFmcEk5R0RkcXlyaGJI?=
 =?utf-8?B?STBZR0NSNlpZeWNvOWoxQ2U5V0NvVVlMUVA2Z0x5NERkc010elB3cjJNMlVs?=
 =?utf-8?B?c0RjbTlQUDhJcVhtV0Z4V0x5SUJEZDRMR1JyN3lmTXVwdnNSdmU1OXpha0Y5?=
 =?utf-8?B?R1lCdXdBSEwxK2FsNUpFN2k2STVBc2dyUWFDQ1Jtalk2eDlhRVJEU01KZGtC?=
 =?utf-8?B?YS9jY2RQNGNReUZDOWI5QWd3RStSZUhnTVYxRG1QUjloeUJHQVNnY1JWSWIv?=
 =?utf-8?B?UlR0NEZVUTdOZ2lpSkhRbWdmUXpDVisxcHV2MkltdXIvcURzOHdwT01jYm1V?=
 =?utf-8?B?SFl2L2FSMjRNSGEyQXQyYmN3azBGK0VBZmdiOWd6dUIvb01wOXY5QU0xT21L?=
 =?utf-8?B?d0xVc2RvUGt2TktGQXRBWGR0QmR0OXFwTmdKVFFORnQwQmg5YlVIaFJ3MUho?=
 =?utf-8?B?TlI3Qm5ieEtpcFc5RmgrSnE0cFdXaTVxamY4SzJjU0d0SzBCZTVMTmNIUUJo?=
 =?utf-8?B?QnNiZkhKc3FWcjdZYzlBOGJYYkNWQURwckFtY1hDa1lTSitTL0NPQ3djcGJa?=
 =?utf-8?Q?P3QB5AXf56CzyzoyIBMFd+D0XYtbLlzzE+cYg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6504.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009)(1580799018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlVrRi83elhYcnRSTXE0VFhFOCt6MEpRYW1QNXNzL1puR0hqa21XUGxJdStm?=
 =?utf-8?B?Z3c0cUMyb0xkbmFjZWZmRmtDY1V0R3N5OVRPU1VpbVdvL1lOSnVGQTNkelNP?=
 =?utf-8?B?YXdPZjVaWCtTOURCWkpyU1BNOHhWSHNSQWhaQXRPT1lzWVkwb3JTQXdxbDVI?=
 =?utf-8?B?REpXWENRQVJPbWlDY1lQSmNaVGxYQkRSL3MwbCs5QjU1cG1JUER0cjhBeTdq?=
 =?utf-8?B?aWtlM0xTSUM1YnpURkxHSTQ1WVhSL0g1M051MzFlaXZteXYxaGRneW50cHFo?=
 =?utf-8?B?MlJpMyt5b0pRdm02dzlVVnladWQ4YXdSQ0FUSDk2S1JPTitvRjR0N0Uycy9y?=
 =?utf-8?B?b0tHalBqbmNCdjRWS0krTGlCMEZqRG1vRUhONWpmbGRaYTNvMElEVFVISWIz?=
 =?utf-8?B?YzByeEtaQzVpdmZMVkliaDNEeCtRZHg5cXNtVW5xYklMckxadEJoRnNBRUU5?=
 =?utf-8?B?dGxwbTNmVmhtM3dpb2o5dVg3Z2pyZ0FrdUNWMmE1NWxkbVJBSytqNk9xRVpX?=
 =?utf-8?B?ZnRMalIxYmFYdmY5bXhwbUhNVUUxT3dqdWZYdjdhK2lrVTc0bkRMNENGZjVM?=
 =?utf-8?B?T0c3MUU0R3FQOWdydnd4clFmcGlhVTVNbndNdDI0bFBsVFBjd2V6Zlh2dS9P?=
 =?utf-8?B?YVF4LzdVVEpNbEdlWVMvaWQrWEJTZ1ZyVGViTVZ4RFJucEJvWXBBOXJCSjFS?=
 =?utf-8?B?ZjZqOENzMWQ0SWN1MDNNTnJEM3Jyb3lZSTdZWmpBT2VzVS9TUi9qMDVjV2ZH?=
 =?utf-8?B?UXpLL3RVQTdsWlg0SWdmTlBhejJaTzhmeDIrVWp0QlM1NGF6OHNJWDIyc2c5?=
 =?utf-8?B?WW1uYVROSDBRd1hiNFZva1dyZmpnOTh1bWJ6RU5TaEpEL05ZTDlueE9XVWJZ?=
 =?utf-8?B?S0hmQ0JqN3IrNkRRZjJDT0NLbEo1K0JYSmFxdXZ6YklPcjlPUlpJV0Z5YUZL?=
 =?utf-8?B?RDlNNHAxR0Q5UUJ6NHdybnNCZ0pZVzFnQUJXZDFqNzcyMDk2UHZHUU94dkxs?=
 =?utf-8?B?d3BGTWxPTFpONTVlRGI1alJHVjJwZS83T1I2OGpFMktrdFFMVGw1dzFpVFpo?=
 =?utf-8?B?d0NEVW1MUFN0NHVyMlVERGhnb0NQRHhWa1d1dUV0cWZOSXpwUWt0YUhHLzdF?=
 =?utf-8?B?WWNTODhvVFNtMHlUZUNnbTBmRU9PYWlObmFQQmNxMkZ4Nlk4V0NETkxDaWRp?=
 =?utf-8?B?U2c5ZXhNVU9Rdm8zaG9YNFhkUkFSSm9ybitoeXVram1oRS9Ra1BmR1Ywckpz?=
 =?utf-8?B?MzRtWUc1MEpsN2NlVkVzWkJENnhXZDgrK2xsWlQwN0RVSnVnNEV1QjhoRmcy?=
 =?utf-8?B?dWlSU2ExMUFpZlc5Q1U4SFNOV0lMdVpGMUpIaUdTWTZUNWx2K1FIcXRXb0VL?=
 =?utf-8?B?VExnUXU5eHNCUU9SRjVQeWFhN0tuSVpBWVNHRVpIbVZ0OG9OUVU4eDNGRDI2?=
 =?utf-8?B?RHZHcjJhRFhqK1M2WSt1OElYcXA0bkFaQTR1Vy9VNUxBZUhEVUdKcVNoc0M0?=
 =?utf-8?B?NkNqVFNlUTZuWlp1M0ZGOE91L0pjbGNQMkdwWktOcitjSlRzM1I5SndLQldu?=
 =?utf-8?B?ZjNHV0ZLR2k3RVNBdE1Kd00zSC9VWHJKVFI1NUxkOHl6ckJjZm9ndGRMY2xu?=
 =?utf-8?B?WGdJZmNQdWxqQlljSlZMUGJmUDNhdGEzcFZDamF2aTl5bGhDbEpYN21XSG02?=
 =?utf-8?B?NXJBRk9SZnNiQUFtWSt4aWl3WmRGZXg0VjQ5SVZjU2xUVUs3S1NVQnZXdyti?=
 =?utf-8?B?MWpGWCtnT1BkK1laOER5M2RWMnliNzEzUmNHb1FqRkxqZHRhNVJtL0lockdt?=
 =?utf-8?B?bndVRGJKVEZuWVkxdHo1eXVMdHlvT3NIVCtEaDlSWHF4VWNkakRNNTJuc3Bv?=
 =?utf-8?B?NDdaemplSFZGQTdDYldKTFErTjNKWUhNckV1MXcvdXZ0UUhGTFlSWnFsd3ZV?=
 =?utf-8?B?dGxVZnV0SlkralRoN2p5d08vN3N6OVljS3RJYWdPN04wdkpEUmp2Z044cE50?=
 =?utf-8?B?ZlY1b0oyQ0JOcHB3N0RCd2tjS1VIdWppM2pkc3JVVXRzQ09ubURvU1RNVS9h?=
 =?utf-8?B?TkZVVmdNdHlCV1JxZGF4b3Q4aXkvRk9HMkhSVzEwc1p5dVJxbjVaN0x1d25r?=
 =?utf-8?B?aU84YWNlWjlqcm1uZmpmRVJ4QlhkNUhKUUx4eWVtZ0k5YTJVRDVVcVJaeWt4?=
 =?utf-8?B?WFE9PQ==?=
Content-ID: <C841DEEA5143F34CA68087BD8F7B6742@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ijfCp79nRn6e5L+welUAmZdVOIUtJVgoCJ3Y7EUWB9cA8+u+lvbaPb35/v4Vak04eBd/ET2YKQ6jqUa/0KY5Fmi0DrrHnCYBQpu4t82TLvumFQC22WXCWB+H8tceIYuKHExRoglN8d9wwgipvhsWLuqxFRr2MZHeyn5ukd/U2bh1bsbQkmPc/WJg4/FC3pBhc7eTxFXFEEyrv2VsJrGj3/Jd0RuMBklyHcdytE0QjL8QzedzdC9Syns2zwBdJQpaXYvFBMb51mmBJdMyCt+H0IXVChN69XgJHxx9GIzlReAeU+F7lH3Fnw2JVHvC++rWaf+SDApHeEwZE4xPyYRdSQA4Iilsa2KUHMapY9pdK4jAtXv9w8O/hX+lGR/dpq8tARww+4VqPiqkLZ6w3O9HQJXJqPJfLEakNBkcYnxyNU4PSB7lTjFvATgkrOUVuZHwp44QV28mmqvhLg1JYX8A6GKGKTc3ASnGofQX4ZK6azChI0/NKt5k2HQjD26CIPnRLfwFQJYSmfGfDVjTdnt6p//iNHM3Mb3bnpucHd1DMDVoaWS4b6Y8Lg66PaeGR3BLFaBzPdRd8MC3hWprw0Ey6rE5eY0Ch+ELKZCKDEMbkz/yXd277DMm2B0qUluOGVpd
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6504.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45eca8d-ae5a-471d-8648-08dc73bf57e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 02:41:22.9887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXIn/qRlXyUoAsRR/KuTS6yE/1/AnTeTysSfbe8ep2A2d/Fof2wAkfNmjhgeBiVJhd9fX5MPao7yfPq53OloEuietCzmRou8wwBLdWmkSSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10969
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lseek: Add negative tests for lseek
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
From: "Yang Xu \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Yang Xu \(Fujitsu\)" <xuyang2018.jy@fujitsu.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQXZpbmVzaA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3aW5nLg0KDQpBY2NvcmRpbmcgdG8g
dGhlIG1hbiBwYWdlLCBub3QgYWxsIGZpbGUgc3lzdGVtcyBzdXBwb3J0IFNFRUtfREFUQS9TRUVL
X0hPTEUuDQoNClVzZXJzIG1heSBydW4gTFRQIG9uIGFuIG9sZCBrZXJuZWwsIG9yIG9uIGEgZmls
ZSBzeXN0ZW0gdGhhdCBkb2VzIG5vdCANCnN1cHBvcnQgU0VFS19EQVRBL1NFRUtfSE9MRSBJZiBy
ZXR1cm5pbmcgVEZBSUwgZGlyZWN0bHksIHRoaXMgbWF5IG1ha2UgDQp1c2VyIGNvbmZ1c2VkLg0K
DQpTbyBpbiB0aGUgY2FzZSBJIGNoZWNrIHRoZSBlcnJubyBvZiBsc2VlaygpLCBhbmQgcmV0dXJu
IFRDT05GIGlmIA0KU0VFS19EQVRBL1NFRUtfSE9MRSBhcmUgbm90IHN1cHBvcnRlZC4NCg0KSSB0
aGluayB0aGlzIGlzIGVhc2llciB0byB1bmRlcnN0YW5kIGZvciB1c2Vycy4NCg0KQmVzdCBSZWdh
cmRzDQpZYW5nIFh1DQoNCj4gSGkgWWFuZyBYdSwNCj4gDQo+IE92ZXJhbGwgdGVzdCBsb29rcyBm
aW5lLiBCdXQgSSB0aGluayB3ZSBzaG91bGQgZW5hYmxlIHRoaXMgZm9yIGFsbCBmaWxlc3lzdGVt
cy4NCj4gDQo+IE9uIFRodXJzZGF5LCBBcHJpbCAyNSwgMjAyNCA3OjI1OjM24oCvQU0gR01UKzIg
WWFuZyBYdSB2aWEgbHRwIHdyb3RlOg0KPj4gQWRkIG5lZ2F0aXZlIHRlc3RzIGZvciBsc2Vlaygp
LCB3aGVuIGVycm5vIGlzIEVOWElPDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWFuZyBYdSA8eHV5
YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gICBydW50ZXN0L3N5c2NhbGxzICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArDQo+PiAgIHRlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbHNlZWsvLmdpdGlnbm9yZSB8ICAxICsNCj4+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9sc2Vlay9sc2VlazEyLmMgIHwgODAgKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAz
IGZpbGVzIGNoYW5nZWQsIDgyIGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbHNlZWsvbHNlZWsxMi5jDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL3J1bnRlc3Qvc3lzY2FsbHMgYi9ydW50ZXN0L3N5c2NhbGxzDQo+PiBpbmRleCA2MmVi
NGMxY2QuLjc1NzViMjdiMSAxMDA2NDQNCj4+IC0tLSBhL3J1bnRlc3Qvc3lzY2FsbHMNCj4+ICsr
KyBiL3J1bnRlc3Qvc3lzY2FsbHMNCj4+IEBAIC03MjYsNiArNzI2LDcgQEAgbHNlZWswMSBsc2Vl
azAxDQo+PiAgIGxzZWVrMDIgbHNlZWswMg0KPj4gICBsc2VlazA3IGxzZWVrMDcNCj4+ICAgbHNl
ZWsxMSBsc2VlazExDQo+PiArbHNlZWsxMiBsc2VlazEyDQo+PiAgIA0KPj4gICBsc3RhdDAxQSBz
eW1saW5rMDEgLVQgbHN0YXQwMQ0KPj4gICBsc3RhdDAxQV82NCBzeW1saW5rMDEgLVQgbHN0YXQw
MV82NA0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbHNlZWsvLmdp
dGlnbm9yZSBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbHNlZWsvLmdpdGlnbm9yZQ0KPj4g
aW5kZXggMWRjMTQ2NWVlLi5jNDk3Mjg2MDcgMTAwNjQ0DQo+PiAtLS0gYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2xzZWVrLy5naXRpZ25vcmUNCj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvbHNlZWsvLmdpdGlnbm9yZQ0KPj4gQEAgLTIsMyArMiw0IEBADQo+PiAgIC9sc2Vl
azAyDQo+PiAgIC9sc2VlazA3DQo+PiAgIC9sc2VlazExDQo+PiArL2xzZWVrMTINCj4+IGRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xzZWVrL2xzZWVrMTIuYyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbHNlZWsvbHNlZWsxMi5jDQo+PiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwLi45ZDgwZTYzMmINCj4+IC0tLSAvZGV2L251bGwNCj4+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbHNlZWsvbHNlZWsxMi5jDQo+PiBAQCAt
MCwwICsxLDgwIEBADQo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3It
bGF0ZXINCj4+ICsvKg0KPj4gKyAqIENvcHlyaWdodCAoYykgMjAyNCBGVUpJVFNVIExJTUlURUQu
IEFsbCBSaWdodHMgUmVzZXJ2ZWQuDQo+PiArICogQXV0aG9yOiBZYW5nIFh1IDx4dXlhbmcyMDE4
Lmp5QGZ1aml0c3UuY29tPg0KPj4gKyAqLw0KPj4gKw0KPj4gKy8qXA0KPj4gKyAqIFtEZXNjcmlw
dGlvbl0NCj4+ICsgKg0KPj4gKyAqIFZlcmlmeSB0aGF0IGxzZWVrKDIpIGZhaWxzIHdpdGgNCj4+
ICsgKg0KPj4gKyAqIC0gRU5YSU8gd2hlbiB3aGVuY2UgaXMgU0VFS19EQVRBLCBmaWxlIG9mZnNl
dCBpcyBiZXlvbmQgdGhlIGVuZCBvZiB0aGUgZmlsZQ0KPj4gKyAqIC0gRU5YSU8gd2hlbiB3aGVu
Y2UgaXMgU0VFS19IT0xFLCBmaWxlIG9mZnNldCBpcyBiZXlvbmQgdGhlIGVuZCBvZiB0aGUgZmls
ZQ0KPj4gKyAqLw0KPj4gKw0KPj4gKyNkZWZpbmUgX0dOVV9TT1VSQ0UNCj4+ICsNCj4+ICsjaW5j
bHVkZSA8c3lzL3R5cGVzLmg+DQo+PiArI2luY2x1ZGUgInRzdF90ZXN0LmgiDQo+PiArI2luY2x1
ZGUgImxhcGkvc2Vlay5oIg0KPj4gKw0KPj4gKyNkZWZpbmUgVEVTVF9FTlhJTyAidGVzdF9lbnhp
byINCj4+ICsNCj4+ICtzdGF0aWMgaW50IGZkX2VueGlvOw0KPj4gKw0KPj4gK3N0YXRpYyBzdHJ1
Y3QgdGVzdF9jYXNlX3Qgew0KPj4gKwlpbnQgKmZkOw0KPj4gKwlvZmZfdCBvZmZzZXQ7DQo+PiAr
CWludCB3aGVuY2U7DQo+PiArCWludCBleHBlY3RlZF9lcnJubzsNCj4+ICsJY2hhciAqZGVzYzsN
Cj4+ICt9IHRjYXNlc1tdID0gew0KPj4gKwl7JmZkX2VueGlvLCAxMCwgU0VFS19EQVRBLCBFTlhJ
TywNCj4+ICsJCSJ3aGVuY2UgaXMgU0VFS19EQVRBLCAiDQo+PiArCQkiZmlsZSBvZmZzZXQgaXMg
YmV5b25kIHRoZSBlbmQgb2YgdGhlIGZpbGUifSwNCj4+ICsJeyZmZF9lbnhpbywgMTAsIFNFRUtf
SE9MRSwgRU5YSU8sDQo+PiArCQkid2hlbmNlIGlzIFNFRUtfSE9MRSwgIg0KPj4gKwkJImZpbGUg
b2Zmc2V0IGlzIGJleW9uZCB0aGUgZW5kIG9mIHRoZSBmaWxlIn0sDQo+PiArfTsNCj4+ICsNCj4+
ICtzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQ0KPj4gK3sNCj4+ICsJU0FGRV9UT1VDSChURVNUX0VO
WElPLCAwNzc3LCBOVUxMKTsNCj4+ICsJZmRfZW54aW8gPSBTQUZFX09QRU4oVEVTVF9FTlhJTywg
T19SRFdSLCAwNzc3KTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQgY2xlYW51cCh2b2lk
KQ0KPj4gK3sNCj4+ICsJU0FGRV9DTE9TRShmZF9lbnhpbyk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0
YXRpYyB2b2lkIHZlcmlmeV9sc2Vlayh1bnNpZ25lZCBpbnQgaSkNCj4+ICt7DQo+PiArCXN0cnVj
dCB0ZXN0X2Nhc2VfdCAqdGMgPSAmdGNhc2VzW2ldOw0KPj4gKwlvZmZfdCBvZmZzZXQ7DQo+PiAr
DQo+PiArCW9mZnNldCA9IGxzZWVrKCoodGMtPmZkKSwgdGMtPm9mZnNldCwgdGMtPndoZW5jZSk7
DQo+PiArCWlmIChvZmZzZXQgPT0gLTEpIHsNCj4+ICsJCWlmIChlcnJubyA9PSBFSU5WQUwpIHsN
Cj4+ICsJCQl0c3RfcmVzKFRDT05GLCAiU0VFS19EQVRBL1NFRUtfSE9MRSBhcmUgbm90IHN1cHBv
cnRlZCIpOw0KPj4gKwkJfSBlbHNlIHsNCj4+ICsJCQlpZiAoZXJybm8gPT0gdGMtPmV4cGVjdGVk
X2Vycm5vKSB7DQo+PiArCQkJCXRzdF9yZXMoVFBBU1MgfCBURVJSTk8sIHRjLT5kZXNjKTsNCj4+
ICsJCQl9IGVsc2Ugew0KPj4gKwkJCQl0c3RfcmVzKFRGQUlMIHwgVEVSUk5PLA0KPj4gKwkJCQkJ
ImxzZWVrKCkgZmFpbGVkIHVuZXhwZWN0ZWRseSIpOw0KPj4gKwkJCX0NCj4+ICsJCX0NCj4+ICsJ
fSBlbHNlIHsNCj4+ICsJCXRzdF9yZXMoVEZBSUwsICJsc2VlaygpIHN1Y2NlZWRlZCB1bmV4cGVj
dGVkbHkiKTsNCj4+ICsJfQ0KPiANCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHN0cnVjdCB0c3Rf
dGVzdCB0ZXN0ID0gew0KPj4gKwkuc2V0dXAgPSBzZXR1cCwNCj4+ICsJLmNsZWFudXAgPSBjbGVh
bnVwLA0KPj4gKwkudGNudCA9IEFSUkFZX1NJWkUodGNhc2VzKSwNCj4+ICsJLnRlc3QgPSB2ZXJp
ZnlfbHNlZWssDQo+PiArCS5uZWVkc190bXBkaXIgPSAxLA0KPj4gK307DQo+Pg0KPiANCj4gUmVn
YXJkcywNCj4gQXZpbmVzaA0KPiANCj4gCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
