Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524E6C32774
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 07:10:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70DED3CA346
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 09:10:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B09EC3C91F0
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 09:10:20 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 524466008DB
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 09:10:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1661238620; x=1692774620;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=fn1vNtpe4/eHEAk7iIaUpJsWpOcKmAXAIwoPC2FBjac=;
 b=l3G4LEHLIopRDvat/Bc6ef8kAJLbzh63oUrQ3ULblvtDLrZc5KfVr0Rw
 +DXqF4B0VWCrDksAWGgZmCL0075zxczP7He4pR1Gn7AaJlaW4ft7pCD8m
 731gnITatZTzMTzoHCzFdeZix+90RPffjpKToRLtI7WsrQk+0L9o8punF
 F1FV8+OkbD7TuWu8VjKCfPSZHvH+vmbgeIRWBAkzNMqcTcrXayRs0NrVF
 lsqoBqNYVitgOf4YK5t5GAUWhZX6NYz5y0JsCNSYOyFBD7L28xmwYUqqN
 9aEMPkjJVj5Iks55dhc/254IShqTxt9jkIPikC10cMPQbCS1wRQz6pF+1 A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="63196851"
X-IronPort-AV: E=Sophos;i="5.93,256,1654527600"; d="scan'208";a="63196851"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2022 16:10:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ja+ZDX45oJflmAzArv5lp4DXSlvHFSIFwgCb1TgDjbYso1to2ZSoHeWF6zrAsZPm3FDwhVZ9+K19OoBdwGyUciT8rjsMtjRFdUhfaqEkv6h0GfLCYsvMUI2ertGSC3bJN2mCwpRp/lDvkdsPA/nGWEcOcSMF/VLkpadUJplXnbSkOibmRvciPXvV8XTw+wbhtoUl4S8s+m6dsKWzwaHWbJGyeUxqcHxN7pR6UHvsOmOn6J+2qKO+RzIeVzNEnwPH1zq8s6bBU6Ska37KL/5Apq8UYKYQPAS8cYDyrJOfkXdRxxysu0kQW1RIdYshaeUylEYKgcweSKC/+Xl8FLXh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fn1vNtpe4/eHEAk7iIaUpJsWpOcKmAXAIwoPC2FBjac=;
 b=JmYkZVvpxrDSKa7QbVfMEWPBlghn0Y5D4Piqn2ND3cnfLMc1xjsOruUQrK2MZ6rKY+onLnXbHCOKEYxBkLylzxXSBlw8bJf2ZsznTggONaiGqI94NxnkJaTvu0XrBdnbH9ZqjfHPbZARIMxYLZ+vVerg9Y08eVtrfIINsTZw9FGdNMmVQgc+V9zUCGoCxMUfwjuSilg6ptdRHsG/KJ8wLS4yelncjQPO+NVYYZDAgJEWElDzy46PqGudk1yrXqrul92QpkYZ6ohSxUkM/WIJ0FZ0TqUSk4++nKgZbP26lX2GpzqOOrMkFKmoA8xpIJc/CLulLogteqp2fUAHJi+GWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB3529.jpnprd01.prod.outlook.com (2603:1096:404:cf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 07:10:13 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 07:10:13 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [PATCH v1 2/3] tst_cgroup: Add safe_cg_open and safe_cg_fchown
 functions
Thread-Index: AQHYpxonL8L7qQ3YBUegaqa46E0RxK2einQAgBKoWYCAABCKAIADMgqA////OICAB80GgA==
Date: Tue, 23 Aug 2022 07:10:13 +0000
Message-ID: <9cf50109-5c06-08ee-6de5-36456ad1a757@fujitsu.com>
References: <1659521981-2241-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1659521981-2241-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <87zggks3pe.fsf@suse.de> <031f32b2-70fd-8b6d-e2ec-f1d3d1bdcaa5@fujitsu.com>
 <87fshwlh5t.fsf@suse.de> <dd62e1fa-0b53-e45a-83fc-21a7a2105419@fujitsu.com>
 <87edxdkfq8.fsf@suse.de>
In-Reply-To: <87edxdkfq8.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a9e0739-adf6-40e3-678a-08da84d685f5
x-ms-traffictypediagnostic: TY2PR01MB3529:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BnbASS3qVVyve7t3nY5fsBXMBi2AHRWFr+9GRiksDu/z6TRUVVcnk084Ddy51bfDCi4MIDA09Woz24mswxxOBEsrLsBEcONNV7ECpP0YwF1CvT25NOtAvEGO8u0/x0gs9o8VJ9zOQXlZi6xjdl4KfajQbIUwRLw6Vt3kQ5V+IQS/S7bFPgK3uQw8Ja5Hi0rTyQWQyE/7xo+5BjaHTCFhKmgsNVkxMaPICQB0gFIrGuzs3EHvBPDy81sy2T+yLA9lT2KCqC9Gb5zNuRfiOTaRjGbmUjlOtLpiitDkoLvnUjGd3Nu+d1ppVBg+ybAo0YkPfyXhrVSucapMzOGjpU2GLUIQpkCVujuHSkhwohnm9u+eIaPzSeA4DcJtHBwsMkBvIhzYMZThtQ66W277hxeSalqBZ3lrx7LhLjwOxlaWOcDIHZ3mosWVBoxPmsPXWmzOE4gDI5p7XYpkDyO0svR1DFTODrNGK0WJyDPoGdx+PV6Jd1pBNcmpc+fJNfdmuqgWC2KY0kwsV6sbgeJ+fklzX59pr/vQpTX3+XwQSVjxedYWkyOAw5osrYWa0EOwcMXgMcmqDssnxuVv8a+ALqd0LXNOVvS+ONdwkQ38vqcK0pd0JpXMBbTo7Z5VwxHEa4bbHQ1nlGG7OdoRnv9Bu2JFfxYALG6WIjyjQeAVxaeXISNthXQl7USq2Nr/NdhYF/M2NWrwOXNlT7BQHLTipNM8kZRCuVJQD4No868v+cx9ZOVyW7b6GORyFWvsYtXmSfr6c/w5vf4Lx8Ei83rjGfHvVe2txafzhfqNsiy676QFTVfS57tnTZ6+uAjIfD1krFhwAHLpTcR8Vt8AC/3+HPMY9zPXRnPCCGO7yKBBdcTlmvk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(1590799006)(31686004)(83380400001)(6512007)(6506007)(122000001)(26005)(71200400001)(6486002)(41300700001)(66446008)(66476007)(6916009)(76116006)(64756008)(66946007)(66556008)(316002)(54906003)(478600001)(91956017)(8676002)(4326008)(38100700002)(5660300002)(8936002)(2906002)(82960400001)(86362001)(2616005)(186003)(31696002)(38070700005)(85182001)(1580799003)(36756003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0dyOUxNQnl1SFdhU0dOcXNTRVhXVUdPTWt5R1lIQnBQb2dLbmxIVFZkc1hw?=
 =?utf-8?B?TjdvdXVzdVlRUWtvZHNQc2R1U2xNUlplU2RPdDVFeExHeEMyR2RuNFpXUlJJ?=
 =?utf-8?B?Vys4ZktpblpHS0FwZFNVaVRnK3E1Y0NSSXlTR0RYSGpoUnQ5OExXREhSS0lL?=
 =?utf-8?B?MWRMbEl5NkFicy9VdTNPRmRreHJmby9LOS8rREc3bG53YlY5TzlZNDhzWHBX?=
 =?utf-8?B?SThITlhvNzlOREZGNVppUzRXdmF2MGFWS2xUdmZodUtPc3pSTVFjMW0vaDly?=
 =?utf-8?B?cVJpbnJTKzg1SVhTZ3dGTUdFUkRpUDdpVk1Pc1MyUXJHbmdzNWE3VEhBb3g0?=
 =?utf-8?B?VkRtdk8zcnJYeVc5NEpEc1hpV1ZBOGwvUnJoWjJGTEdkSExFRmpDQ1daalFZ?=
 =?utf-8?B?cXZwY3ZPR21DZVRWcVpib3c2L3lkMHhIYzhVTEF3ODBMeTNWSDZ4ZVR6RkMz?=
 =?utf-8?B?RmJBcHZ2VHlZVitnY2h4b25hQ0VqYVZ0SWJxWFBMdkU0OUVra2IwTE9CRDJY?=
 =?utf-8?B?Z2dCcDBtSHVoUVZTbUR5SWt1alY1N3YyTWE4QmdZNUZyV0w4MllOUXBkcmtX?=
 =?utf-8?B?djZoSldBMVNLcVl6dkZsTjNMU2pQTDR4blVOU3VUOGFscjVWbC92OG96c3Na?=
 =?utf-8?B?SW8vSmh2cjVVMFRIWmx2Q2gwM1lDM0l2di9NZFlPbEpUOSt6T2ZxWjZleGgw?=
 =?utf-8?B?TzZxTXVzZTJ2SnhOZ3lHMnhlVWxMYU5ybU5uS1U4aUlXUlFRTjV4bGt4RjB2?=
 =?utf-8?B?MDU3MHdaM3QxT3NVczBoWWFzaG14WEgvYXEyc0YzTkRQelFwdXVGRG85aXY3?=
 =?utf-8?B?d0txblNSUWxBNWtTc3pNaUcvc3BmV014dVdTOTdsaktFd09ZS1pFMXY1WHBH?=
 =?utf-8?B?ZHh4YUdKaUdkaWg4ZXV5cnhIRGNJeUJiUjZydmI4T3RkQVM1ZUg5UENEV2t6?=
 =?utf-8?B?ZnlWM0lWby9ITXRFeWRTQ2hUM0UvNSs0ckluWTRadXAwRzJVU1VBYW13YjZ0?=
 =?utf-8?B?RFlhbFpWM2ZVTnV3bXRac0pUM2paeGMwUDE5Vlk1ZFphZWxrSGpSZ0l1N0FX?=
 =?utf-8?B?aHNjL0QwR0pjYXFqS1VQNlFDL0VZZDhVOVhNYjc2ZDdpOVZqZWNxa0o2R3NQ?=
 =?utf-8?B?Q1l1VFJIdFR2Ris3bkdwdExwRVFBeDN1eGRBcHBOUGVCSElxaldXUXo3MHls?=
 =?utf-8?B?Z00zV1N6dUo5ZlJiVFRPMWU5cFBwb1AzcFhrcDZ6bUQzRks3amJOQm1YenFp?=
 =?utf-8?B?QlRscDR6c3VjeW1Ma2IvKy8vRnRuNXBxREV0eUpMMU96a2FiRURLeTM0WnZQ?=
 =?utf-8?B?eXlmSWNydUhId3BxVXpZb0xHeTV3OGkxUUYzVnJqc0FSd3UvSmRybFZWaGkw?=
 =?utf-8?B?bmtWU0RwZm9CbVQ1WHl0a3NlbFFLS1NBbXdRV1YwT0cwSVFHOWdwVzFEVmNW?=
 =?utf-8?B?ZSsrQUd6ekZLSFVoVE9hOCtOaGd3eXY5emNLN05pelNCWGpnckVaeEtabU1Q?=
 =?utf-8?B?YXI3bk04L2FBZTlGcmZ0TnVrTTNjc2hTSHZ0bVhpREphckxZL01KVklreTBS?=
 =?utf-8?B?c2w3Y1UvYmlqdFVHUjdXbEdCTFdzd3NYNWZsQ2xnaFd0VWtZUFgydm4wOEV5?=
 =?utf-8?B?blRUcDdoU3ZXelNTOWl1Ti8yZlVWUDhXV1FkYnVhTTdVWmtpTUppakI1NnlB?=
 =?utf-8?B?TU1TUDVWdlhFOUUvVnNuOEZ3MGltMjhJUmloQ3VlTXp3NnVNdVlwdmlRT2Fw?=
 =?utf-8?B?bmVGdnY4azBJTnlITWhPZzU3U1Z3d283VEUzT0FKUUhCcFhPeUEyc010dytk?=
 =?utf-8?B?ckw1M3hqZ3loN0taS09aKzN0YVJHSkMraERhcDJpSFg4TmlCeDRwQjR5VUdI?=
 =?utf-8?B?SFVmQnRMNk03VlVTRnl5VHF0MkY4NzdGVCtPY0R4THI2OHBDazVCeGRXUDVU?=
 =?utf-8?B?cDJVblRSY2JuNUNHcWg1SjdiaHlpZ3hPeXRneVRQeC90cGZCVjNOZmNGYzYz?=
 =?utf-8?B?bDJMc2JvWjJUdlZZeTM3SCtPaXVoamNJd0tuSExBV2xrVlpia3FoT3ZDb3Fw?=
 =?utf-8?B?ejNxRDQyNVd6T1NkWnZpQ3RFckI3TG03L1FKL243NTZVSE5ubld0TTJ6Q3pJ?=
 =?utf-8?B?c2UxejBYZFpsTjV6OUNGblNRbksrU0crc0R2T3hUdWo0bGNFM25EdUNHQ0U5?=
 =?utf-8?B?TEE9PQ==?=
Content-ID: <1DDCFA0479A03D4BAFC6D699A832B7D5@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9e0739-adf6-40e3-678a-08da84d685f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 07:10:13.1354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSnvOF5vXDg6TcFR2QMNMkw+GuIDBDltWIptTO6pEPrdio0/Ga2zrKMr7+7zAiKeItaPgOSnnnVbVucyq68q6Z+/bS5GwsIIMhZQ2y9tdWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3529
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/3] tst_cgroup: Add safe_cg_open and
 safe_cg_fchown functions
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard

> Hello,
> 
> OK, I see the new patches. However I just realised these tests are part
> of test_cgcore. These are not related to memcontrol. They should go in
> controllers/cgroup/core01.c.
> 
> Let's start at the beginning and look at the original selftest.
> 
> static int test_cgcore_lesser_euid_open(const char *root)
> {
> 	const uid_t test_euid = 65534;	/* usually nobody, any !root is fine */
> 	int ret = KSFT_FAIL;
> 	char *cg_test_a = NULL, *cg_test_b = NULL;
> 	char *cg_test_a_procs = NULL, *cg_test_b_procs = NULL;
> 	int cg_test_b_procs_fd = -1;
> 	uid_t saved_uid;
> 
> 	cg_test_a = cg_name(root, "cg_test_a");
> 	cg_test_b = cg_name(root, "cg_test_b");
> 
> 	if (!cg_test_a || !cg_test_b)
> 		goto cleanup;
> 
> 	cg_test_a_procs = cg_name(cg_test_a, "cgroup.procs");
> 	cg_test_b_procs = cg_name(cg_test_b, "cgroup.procs");
> 
> 	if (!cg_test_a_procs || !cg_test_b_procs)
> 		goto cleanup;
> 
> 	if (cg_create(cg_test_a) || cg_create(cg_test_b))
> 		goto cleanup;
> 
> So we create two subgroups this translates to
> 
> cg_child_a = tst_cg_group_mk(tst_cg, 'a');
> cg_child_b = tst_cg_group_mk(tst_cg, 'b');
> 
> 
> 	if (cg_enter_current(cg_test_a))
> 		goto cleanup;
> 
> This writes "0" to the cgroup.procs file which I guess is a shortcut for
> writing the current processes PID. We have to be careful here incase
> this behaviour is different on V1. Probably this translates to
> 
> SAFE_CG_PRINT(cg_child_a, "cgroup.procs", "0");
> 
> It's not clear why the current PID is moved to this CG. It may be to
> ensure we have permission to move to a sibling CGroup and to eliminate
> other possible reasons for getting EACCES later on.

Yes, it's not clear.

But from kernel commit[1], it just check open fd's perms instead of 
current. So I don't use a and b two cgroup .  Also, it indeed fail on
unfixed kernel  by using only one a cgrpup.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1756d7994 

> 
> 	if (chown(cg_test_a_procs, test_euid, -1) ||
> 	    chown(cg_test_b_procs, test_euid, -1))
> 		goto cleanup;
> 
> Then the procs files are chowned to nobody. I see no reason this
> function can not be implemented in the same way safe_cg_printf is. We
> don't need to check which controller the file belongs to, just chown all
> of them.
> 
> 	saved_uid = geteuid();
> 	if (seteuid(test_euid))
> 		goto cleanup;

Yes, we can chown all cgroup procs files ie SAFE_CG_PRINTF did.

> 
> Then the current procs effective uid is changed. We need to make sure to
> set this back before doing cleanup (or fork like you did originally).
> 
> 	cg_test_b_procs_fd = open(cg_test_b_procs, O_RDWR);
> 
> 	if (seteuid(saved_uid))
> 		goto cleanup;
> 
> Then the file is opened and the euid set back
> 
> 	if (cg_test_b_procs_fd < 0)
> 		goto cleanup;
> 
> 	if (write(cg_test_b_procs_fd, "0", 1) >= 0 || errno != EACCES)
> 		goto cleanup;
> 
> Then we try to move to CG B and expect to get EACCES (because of the
> permissions present when opening the file).
> 
> 	ret = KSFT_PASS;
> ...
> 
> 
> Probably we want to run this test on any controllers which are
> available. Currently the API doesn't support that. We need some way of
> specifying that the test will use any available controllers in
> tst_cg_require and/or tst_test.

I will move this case into cgroup/cg_core01.c, kernel selftest seems use 
memory controller, I guess we can also use memory controller because it 
is most common.
> 
> Then we need to handle setting the euid between open and writing which
> stops us from using safe_cg_printf.
> 
> Probably the API shouldn't try to handle stuff this wierd. Instead we
> can create a function like
> 
> int n = tst_cg_group_dirfds(int *dirfds)
> 
> which copies tst_cgroup_group.dirs[i].dir_fd into dirfds (which can be
> statically allocated in the test code if we export CTRLS_MAX).
> 
> Then we can do
> 
> seteuid(nobody);
> 
> for (i = 0; i < n; i++) {
>      procfds[i] = openat(dirfds[i], "cgroup.procs")
> }
> 
> seteuid(saved_euid);
> 
> for (i = 0; i < n; i++) {
>      ret = write(procfds[i], "0", 1);
>      if (ret >= 0)
>         tst_res(TFAIL...)
>      ...
> 
>      close(procfds[i]);
> }
> 
> and whatever else is required by tests which are doing something unusual
> with the CG hierarchy.

OK. Will  try.

Best Regards
Yang Xu
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
