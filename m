Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13601C77B7F
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 08:26:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91B5C3CD743
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 10:26:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B8783C0238
 for <ltp@lists.linux.it>; Mon,  8 May 2023 10:26:09 +0200 (CEST)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E248014002DE
 for <ltp@lists.linux.it>; Mon,  8 May 2023 10:26:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1683534368; x=1715070368;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=LdRK2UbMrnxoExyqAnYiqUM61ELcWnVJhJBTw6Wdprw=;
 b=ZUHC4l8jroWvvJYgKzWElVy85rNI0TS5FV3Ytyl0dRLzaPvNuTPL0LEb
 woFS9nm8uznF07mEK/tO8fGOkaGzAHaCOnF3JrcbzKND82EYHAnVpyD+c
 h6vJ2ilel95zs93GWQPAcG0G75T9o1AuyZfeUqFlMRSuQHXwMExDvynxl
 N0QGQTpysjnr7p5HDyxM4NuokP8xZdLiS8m4WkWV6ptqMxKaWBgy97Ubu
 J3lUqz1vgpMG1BaXfV6FKrhs37Nd/21CPpbxPDKrTsxhvcvf3Y2aOFv09
 lWlS7Lj761Ul8VkT65P3Ilm4GJY0wuxbiWM4z4iNCwwXLBT+IIZZ9ygeI Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="84021489"
X-IronPort-AV: E=Sophos;i="5.99,258,1677510000"; d="scan'208";a="84021489"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2023 17:26:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrzu0oD9hhaBOJTOaxsZ/T76W+obLqpQCNR2K/Lre+NOSpY3etAvZSAs+I8dzYC28eSDw9UmOx2ypXC1yO+MbpG++P8PqwtmGQAyBKxAPacsSvIrA//RXmnOYZoS0Kox7IG9W07C4O9fPKNuAEuI/GGOv5QwV2QgRy+KeHWdXHk1+1ocn2WULlN/ZVn1/33lAhyzvt+3PEGPgwvvnqobM0O+s3ZSFI0NWTDoYZMuiZQN05aOk4ZngzDD9Hr5jGlnNpNQ6JwV8D8bZPbeeeXklxljc7QkbwiZjrad7D5GbmtHPQUBYp0IoS6bLS+9FwOVso5cMQdPByGEluSmoEB7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdRK2UbMrnxoExyqAnYiqUM61ELcWnVJhJBTw6Wdprw=;
 b=g2NcO8qgau4CVhB4n3A7Bnk1xvKKGXKwYb0YKTcuW4glJZstULper4BfA5ug2Hly4lRax9XDfQpl85ErSY2QC0FIcYz043Bn56hcvILppaj9IlgiciDEMJsfU1UAXMpfNM0pnZDirM8lwD6kg6NMdu3s2FlB65MvPdEol38bUzL27elHBrifE++fHR8pU48/I/7DexR5tam5g9dKII5vubkexS85uhgVbiajDZyJch4kmCBNEmxO7vRs3FiRpKj7oweHG3q2jXwZGHhtIV4ArccIhF1iG4W2i9uNB+tiYKTuAAr+WhG+0eBHMqB3jCcoWJ0VanIbSaZXHKDZu0InTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYWPR01MB8640.jpnprd01.prod.outlook.com (2603:1096:400:179::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 08:26:03 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 08:26:03 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: [LTP] [PATCH v4 3/4] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on block device
Thread-Index: AQHZaEpp8gRlocgl2U2Mzd7BL4X3s68+R8KAgABa2wCAAAOZAIAHM6MAgApjBAA=
Date: Mon, 8 May 2023 08:26:03 +0000
Message-ID: <5f608daf-0de0-b6f0-59a8-ad27b5215f52@fujitsu.com>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680759622-8738-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230426221221.GE58528@sol.localdomain>
 <b33d70da-c629-0c4d-3be3-87a0611e5f9d@fujitsu.com>
 <ec7f64e2-2645-768f-85d3-63193339de38@fujitsu.com>
 <20230501174902.GC1224@sol.localdomain>
In-Reply-To: <20230501174902.GC1224@sol.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYWPR01MB8640:EE_
x-ms-office365-filtering-correlation-id: ef675367-c587-400f-adfc-08db4f9ddcf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /yMK1aSSfgXsJzJEyUw885ZIvix4UObTEg9O/rp+2zmhoYcyGw6mnXcPCCLXQpaqanb/HGRuF7Z+i8Mv6iN6sOvbooiQY4YcCiVj7QdIRn61/rA21OrUiXFCctpjB08JIYLBmNxDmg/A07MC+Vmqzf9SvzkcOA4xPozd8gP94XMQQAEJi2GfPpiLIVdfSOs2K5Ue2+sJZU+NboOj1TPo3cvmg7jy6aMuz0Jd52f1PeMCx7JNzXum7PEh6dW5Di5CdK6gZ8uJ3txT3Vj12Ya/CiaOYhTg62jaL+xNi65Eak83SoUmKOcLISyohGpGPEmsFclZ9gS2P8GzkHUHihopDZZ/yzUxr0DODKtqSOz0ggwSLYCKp5xG74LtnYptlV8cI81awrnrewcyGMbQ8sL1fXWlzJWE1aDIAratjdtH8TAZeQcjANww8Gb1tko9mYOhzYlWJCBsXKAdkFuY545cvljwOwP495gx7xpC6dl5CV5uvWO6HP698jHjKvTi8dIda/zMTQm55YpK/MNyiB/hEFmJ/nbneTErEcc25ZAOwKAgzSopuWKyqci22cLZqk5pmL586oH1ZcoyREPihBLsWxKlJc9e8VGKk8FYIaxZQYwwU0b8dJizB//vN9F2mYicZOJB1vCLu0O0ZNadrpQ3lPjsKBqGCyQl4DE+XlgZmhv3WJjb2suE3o3YXhHX6FG3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(1590799018)(451199021)(6486002)(478600001)(26005)(6512007)(186003)(6506007)(8676002)(41300700001)(76116006)(83380400001)(4326008)(6916009)(91956017)(66476007)(66946007)(31686004)(66556008)(8936002)(64756008)(66446008)(71200400001)(2616005)(316002)(1580799015)(5660300002)(2906002)(122000001)(38100700002)(31696002)(85182001)(36756003)(86362001)(38070700005)(82960400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHlDdUlkc2VBZklKYkpYdnUwbENseFlMdE50V2lQZHk2R1dWc3hHVVRoQVhL?=
 =?utf-8?B?ZEhWNFdHQ1Z2V2FsV3VSZEhMdk91UnV6V0pwSGZZQzhuSkl6alhKRFBoNEVw?=
 =?utf-8?B?SmZ3cWowZGJHbkhkSFQvN0VOSzFVTUF2UW5NeWVXbkYwY1JJQXBjNWt5a1hO?=
 =?utf-8?B?L3ZNNy9vYXY3OEJsSzBBTXNsY1dzYncrWndpWi9CQngvMEx4anlNeDhpQVB6?=
 =?utf-8?B?R2E5TWJSNVRCRUxiSktlVS9uZGJjc2N2ZXhSUndsblByeklNSTZSYkd0TFRO?=
 =?utf-8?B?NFlkNUFnWjVrS1I3bi9rN1V3Ums0b2N3Y3ZzME5GL2xjVEZwYnRHei9KKzd1?=
 =?utf-8?B?YnZZQmpDdFcxN1JNNXk3Wis2dnBZdHhPSm9BOHk4Vy9SRDRhbmVsSUk4N0sv?=
 =?utf-8?B?L0pJRFpyWXl0NllyeExUOFpoY2VwZkc4OStiOWs3OVZ2NE9FT3gzdzJxU3Js?=
 =?utf-8?B?TEtZMTZyTWVCR1gxY0l6dWJTNkFCK3FpbFZKZ0U3eFR2dEdEdEhLeTBzWGJj?=
 =?utf-8?B?Y2pZaXcxd29kcXFZbGRndTIxQ1h4L3NvUEF4Z2tKVFpmejJHd0JIejJCZHpZ?=
 =?utf-8?B?QnBsS1Fxd3dyRXZQeEh5eHVuVzdCbWZDTkhVeFdXb1BCTzJPdk1GcmZjbXkr?=
 =?utf-8?B?SjlUYTF0cmx0YTBRMnE5Rlg0MDZpcjJnRXRZbWNlTnpsNVZLc2h3K1JjbWo2?=
 =?utf-8?B?OTJEakhVTDA2SlJkR0ZJQllkU0lIK3Z6VDFTdzg0endUNURCK0tKMC9wd1dE?=
 =?utf-8?B?K2xobEhFWndvcnBjbEdON20xbDc0WE9Edk50RTNXT0xtbmFRVExPL04yTytL?=
 =?utf-8?B?Vi94MlY4WmtJeW90MDJOZTJBVGVpaGR4ai9qS21KM3I5WlBQRDluVUFtMDU1?=
 =?utf-8?B?ZWlzaWNpYU1tMmx3LzRRandXUkY4bjdGUW5pRVMyYk5FWURFb3BJOGhrWEdV?=
 =?utf-8?B?Y2Rnb1IzUUJyQ1RZVnBXeUtVMzVnYTRFTlBVUlFEL20rRDlib1lmZ3NrNjVo?=
 =?utf-8?B?K1VadERVcEllcVdIbkpMVUFndC9hY2VBMDNUSWRxb00xM3FiNnAwYUdieXJ5?=
 =?utf-8?B?MUVJYlhmN1Z5eHpMQkM1dW1DR3RveU92N1VIbW40Mm9CYm5LbnFld0VoWUM0?=
 =?utf-8?B?M1lTTlJqSWdrRExGbGxxd3E5dm1GVzFxTWdIMGJsSnF2RFR5VThocEQxNnlH?=
 =?utf-8?B?NU5idlIxUGFFVjFsamRNNWIwNktEeWNvK3krVnUxalY3K1NWQTZhTUw4RHBt?=
 =?utf-8?B?Z1A0eHIwYmVJdEhteUZEVlhOOWo4a0lzTGkwRzJBd3ZGbitsbmRkV2Z1a09N?=
 =?utf-8?B?eDBIR2NiMTYvU0NuS2Nlb2pWL3E3UzN5UnhDa0tRRGJoTmEwYytPNnkvYnA2?=
 =?utf-8?B?MTZlYnJKckFnZXN2SzA4dDRrd3BhUlhieUlBSkxTcmVmZ0dvckxnRlhvY3RR?=
 =?utf-8?B?N3ZmZmU4UlA1US85ZC9hZVlra0dkZjR3ZE1CNlFLd0VuZjBJcTJyZjRYZlNR?=
 =?utf-8?B?KzdQSGNYZE9GLzJjekYwUndXQ0xIUjVZcGhLVmVEYWtOY0RXL08xbWpzeUMr?=
 =?utf-8?B?U2VRTFpOUWgwWFErL29Cb1ZFK3UrZnk2MHN3WkZtYWdIdXlzemE4U3FjWE56?=
 =?utf-8?B?cWQ4cDlzZERQNXJ1bnpOYXlPL3VXUHpYNnR1RCtwd1JZNHZpSE1rLzZSVnJT?=
 =?utf-8?B?MFlXU0tQanlnM0xsV1Z0SWxaaGNXcm1GWWxtTm5RdjZaRmh5THdNOENiajRE?=
 =?utf-8?B?SXZneExjS2N6UHAzK3l3RS9vd3ZGZ1QyWGdISkJYNzhTd05sZGpzSEZKNHht?=
 =?utf-8?B?eGgrMUl6OEh2MUlBNVgvUFpXRm5ncmJFdW9FcjZsMFFVTW5FN0JzM2RyYytT?=
 =?utf-8?B?Nkx4QkJWTEJIZmNTdHhITXZxYmFlcVAyUjBWbjZTamtIaGNtMWpndUdVMlh2?=
 =?utf-8?B?SERLQkVrR08wQmhUMzBrVGZEaXZNbUZiOU1HbWx3bkE0Z2RkTGVyR2hJYVFy?=
 =?utf-8?B?QktyZEFHRll0enB2eElGQTRBVVJRMmlzU2JwbnhoTUZGWWJrMEdXekVOTi90?=
 =?utf-8?B?WEtjZ1ZJUEh0Zzk3YVQzV3FIczVSWmNlaklEdHF5aVhLdnEzUDFES3ZRV3VK?=
 =?utf-8?B?SUFQeDZsRGV4eWpzeHFrK1NTcnhJMjBNMmxvSnlBWUJLd3RGbHFKY1pEektl?=
 =?utf-8?B?aVE9PQ==?=
Content-ID: <0AFED3B86F4FD242B94F021838B10A79@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cbe0a6QizhKJS33f4iitfdkNxLs/qaFJfz0rN6RqqC7YbIFeEcHBKPNxVqZ0T3opDqsX7e7+z12KywUIBmzFqsTGY0L4NK//cEKVPwH3okS8W8SeOVdk6K/e/iy0iykVadhDKJPHcfQ/paKe2z3CyWoqnhHSVsprNlA5HVIERjeXDAMIUiS7a1D3VUBrFPkYideF7fwRuKYuhMpm1P4kVPOtXtAeITLGfSU3Oe1hVcxRvjZzfeaG8aMZqh1itQnn+aCLoZEmVuxP+09My0J1hwGq4Zid9YF7i6Vg/bDDiPve8GASvX4tMA7Ptr0F2pEq7Dl1HJF/I58RxAL9kk9wL4ZOg6yGww3pvxFIiPyqNGDAgXQcWGzwn0ixBC/gDGM17ZS1tmcD6C2Ms4NAJwbLWNP7wtWquKgdfbtOGWQz654TwoVXIjAyLqXsmnhWba06v9ef2sQkZhya4ZcJmhoxelVYPShHjzpWvzY03cocI48vEHUuE35dM27dKVMvCOWTWqQh8FYT7XrgUiN+vNcSakRafMYX9o9xI19OAyGfUWFysdSSDNTWPMLp960kg2MtUmRlfKYbKQn66zTOYuhuMP/SDtgOJxpLuKd+GshxkoxQa12Qrbx1OV195SYZ7O4LAWNyVvFcXVHaXRlt2/Feh7I/2iJyzxOsaJkrIaPSFmglOPLdjKivYpXo0jLZadAMKnsSojiLmmU8wbA6MBfJZGeYiOz7y4D9TfAb/2OhrTiiv9ZRh1GFestiQQF3XRItOlmFfUn4BmICq+z7txdabyQXQ151RyoouZZej0kLYN8=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef675367-c587-400f-adfc-08db4f9ddcf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 08:26:03.8128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mj7JKxoKCF0SGleaYltWex4TTY6Zwyx/Y6bOJ0DDW2kOLc8nSLYzkz7SXRwOI18xnskXILTvHGXGyNYZtElsJf3rSEmQ4K/EB3g4DDKFrpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8640
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/4] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on block device
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



on 2023/05/02 1:49, Eric Biggers wrote:
> On Thu, Apr 27, 2023 at 03:50:25AM +0000, Yang Xu (Fujitsu) wrote:
>>>>> +	sprintf(sys_bdev_logical_path, "/sys/block/%s/queue/logical_block_size", dev_name);
>>>>> +	while (access(sys_bdev_logical_path, F_OK) != 0) {
>>>>> +		dev_name[strlen(dev_name)-1] = '\0';
>>>>> +		sprintf(sys_bdev_logical_path, "/sys/block/%s/queue/logical_block_size", dev_name);
>>>>> +	}
>>>>
>>>> What is this code doing?  Is it trying to strip off the partition number of the
>>>> block device name?
>>>
>>> Yes.
>>>
>>>> If so, it is incorrect because it assumes the partition
>>>> number is only 1 digit long, which is not guaranteed.
>>>
>>> I don't assume the partition number is only 1 digit long, this code has
>>> a while circulate. Also, I try the /dev/vdb11 and it also works.
>>>
>>>
>>>>
>>>> How about just using /sys/class/block/%s/queue, which works for partitions?
>>
>>    /sys/class/block/%s/queue for partitions does't exist.
> 
> Okay, sorry, I forgot that /sys/class/block/%s/queue doesn't exist for
> partitions.
> 
> Please at least add a comment that explains what this code is doing, as it's
> hard to understand.

Yes, will add a comment for this

Best Regards
Yang Xu
> 
> - Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
