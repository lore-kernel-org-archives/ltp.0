Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B765C00140
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 01:37:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E5F13C935A
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 03:37:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 710633C0CC0
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 03:36:55 +0200 (CEST)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EC79E100079A
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 03:36:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1659490616; x=1691026616;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1ROImKeIFncyu5XwG58Vttb5yw8Pgv6NgaTG2sOsiMM=;
 b=L12Tnp+Dlell4kroOuko59WlJXfwzFA5z6gwPA2fUScuD9IA6MvVSCC0
 VjIR8BOUbRpSxAhpwKaTBakxAUZx8fnpbuXKQEpS7eQmlPiRKXr0UtMst
 I1gTYOrAFfX5nxKsz7TJytI0xBK6wnpvtNpw/FR0PFSyksg13hd1IWZbh
 4ScOeu7nowYfw/enxOPBYyDNXGZ/KpzPIB8+30Q22aImR4yjvCjSnYESZ
 MEWAZQm+p/Fr0mQHNjQHK+oK/Bm3+9om/004dY4ZNdYZVuuAyk4MF/JUt
 LWZpHku0W8vrO1YMW8l7jLdrrWeQXVbsq1ebIeffQ7vfz5ut+uhpuMs3w Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="61705167"
X-IronPort-AV: E=Sophos;i="5.93,212,1654527600"; d="scan'208";a="61705167"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2022 10:36:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMvYbV6mS/Jskdti5ftvxRSwy/rqx/psuyqC6OhzgiA7Fv9OirXjSm2vM17KLH55EFApruR87PRkC6HpyTLmdNC064d9IT6cOifVdYmotoLl51XAsbKSysol1JqaY3Pa9MVLHbmzI+VIQRjfRwj9ammelPv/8FvOo7TUyQH1FvktqdvqILXKeYbWqZ4QLcgbJgwcIkljwxyg1AUzXO60PZ4I6OMOCcPCHefVijspMKqbdHsfdFruEwMOf60OS+hkQ6CKXxOAwnPB0GuAXTkaTwl0RiJMgsvHNLs9heP2pC6JopmKx/ARo2KGVCT+BYSdRIl9tSxYnTeiYA3E3JE5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ROImKeIFncyu5XwG58Vttb5yw8Pgv6NgaTG2sOsiMM=;
 b=j3TgMBKQkbYq+pNXptBa90bnhMp/kBuNaiSeGnVyfTpj2oLDIVM0lnu1w9tCXGU3rrfnWBcABRlm9N5Q195fLttmpWXlgCq7bQAjeYdFisqQcueiJHkJMCFuWH3uyLdabylgwjxSBXFu7e44ra4Spz0fB+jct/vgE30kMvImSDArtkeSBz0vID4rjNqUDXmSTLdxqrzxd7eMmk+CYpPfnOHdLCdogJPVe1A1Zv0UUTUn7fcyDv7Q+1+QAPOGNldJwW/a3drBe8O4K0i+8uZxHo6UDLnpCZb6lMT71gDPEgw8LYkVqWb9I62YEAfwrSjzP4ykl93cwTZnvUF8ISzrOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB9834.jpnprd01.prod.outlook.com (2603:1096:604:1ec::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 01:36:46 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78%5]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 01:36:46 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH v1 1/2] syscalls/creat09: Add umask condition
Thread-Index: AQHYna1SBAFSFKrMW0+tAefp3g0xZK2b7rOAgACZ54A=
Date: Wed, 3 Aug 2022 01:36:46 +0000
Message-ID: <c7263252-6c78-ee18-6984-5cf2e32051b7@fujitsu.com>
References: <1658485640-2188-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YuleUaVMAnGEQ8ov@pevik>
In-Reply-To: <YuleUaVMAnGEQ8ov@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3913534-4bfe-4f7d-e38e-08da74f0a0bc
x-ms-traffictypediagnostic: OS3PR01MB9834:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qQGcUSSytJ2CycDUzDGhPCA5p0kixEohQG7j0aKgYlSDL6T43ks0ldYy6Bg8re0nga80wUHBoa9RzsISJj+YMaQzFkoEOIWSga1Ejm3uPAcfsCdXvuj8CjnJhn/4tbgqe+uTlJSVnzJucSwSMTsAiDZ9EPSz5X3TdlG0l8Qh26Fgzz0qxKAwV2FRfc0IHOKsBVl/MbTzWLfyFOq/zOvowur+CxqxhY+yQYVVg8eRFAiuy9phbFMBjtIPVgGOXGDIwPci+5u89uD2Neql4mZVa1k97p2WMn/5UfrZP7i/9+kxJtWrGYWNBxC7ncsyns9RjmE5+Vtd7FOzpRsV4VbhcUo3J6bXwVEtHdNTeQdQi1xvzQrOhOIZi3YzFWBKyoz9E7QCz0bENQ9NAGPP9Y06DZvh7+7OXnumO6T8pmRzKeTPydb+Z+7NoEii95ZWn6czdjpLoeT8gSwnGB5ijeag7KNMb367Rx3o+LhvoITdMYJwB1IzvpIvhi7FP06l9lIDUC4Z770t0Ldi1d4D+0hlhvzy//K5f1IMavBsi7WMhu+4wNAfdKq2843d3D8zPh39A0WJrz/WGc74qgt7XqC8nhMHEqEDCCgNFLF9twZR1A4orf3qk8gF6vqnlbhJJmCMIRplMUPfwsx65cJlzKAZqTfqn2PmfQM6rpuxD7Pg2XkpJIOuW0gKafyfqdTSW+7ueTORbEr5uyg8TPhVb3GqnVkpKf0SmeAuGErj/7xYimM9rfLGKyRoK5f8DLtHK6mNocWUC2o5s073aqEDZ1pMAv/LicAnpQLppc9K215GIdE4OCS8Fe34qMUFEV5O3+WFUSYwpnm1U1Y2qWyZ64dkI0AtGrn8WMxltdo8vXEjwu+6AVSPAxSexeBsaJjsP+okzzZPlk9AzSjT1sTPWA3XZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(5660300002)(8936002)(82960400001)(31696002)(86362001)(38070700005)(122000001)(2906002)(38100700002)(6486002)(478600001)(6506007)(41300700001)(6916009)(316002)(54906003)(71200400001)(83380400001)(8676002)(4326008)(66946007)(91956017)(66476007)(66556008)(76116006)(2616005)(6512007)(26005)(64756008)(66446008)(186003)(31686004)(85182001)(36756003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUtpdmtSWDNqWWk3MjdmMW13V3V4M3gwSi9QQjZOTk9IdzhOdWVsOXBXSE9z?=
 =?utf-8?B?QVFRa2loZDJwTEtyZHhIMVhjUjVmVGNIU0t0SDRnOHExdHVzRWYyVW5hMno2?=
 =?utf-8?B?Z2JMSWNKOXNzanFiNERGOUdhUDRiRUMyYXpIT2RNalQzYkxpeWE1dVNjdzVW?=
 =?utf-8?B?Vk1sWTVrYlpHVkxxdDNQOUJrVW1jR0hwYjF1RzdMck1pMW40N1ZjalVVT0FG?=
 =?utf-8?B?OEdoRzJ6NDYzQmxpNkVoMHo3cm1jMHhMYUZrRHNncXhKckVTZmErZFN4aGpT?=
 =?utf-8?B?RVBQT2ZIcnA1Wmw1akhYMGk0dkRwZmMxL3o5MXdNYzdHbVFKdmU5TmJJc1NE?=
 =?utf-8?B?aDY0djJ2VVlVRk5BdzFPUXg5Z3Zlczh2bGtrWS9xNlJHYlhuRkZDd2d5RWMv?=
 =?utf-8?B?ZTZGWEVBUmFUS0RScWhtUGJLKy9LRVdsWmkwSkFTYnpPZDJ1YVh6OFFybFlW?=
 =?utf-8?B?eUNpai9CMVZTdVcvQ29QNEF4ZXJWT21PeGFTT2ZjcFUvWkhQNFpNcGIzclBR?=
 =?utf-8?B?MDNQVGo4RG1QcEtiYmE3bG5kbXN3ZkhkRzI2UXlaeTN1MXV4R2ljYmF6eFBR?=
 =?utf-8?B?N2Jzd0dEckVLdFRheDg1MHlvOFhsdEJHRFRZUXNsUGYzNkdYWHpYdFB2WW1V?=
 =?utf-8?B?SFIvQW9wZ25qRXJuMlNUN3RsMGQ4cWhNTmVvNFRFVmVRL3RLZ2dwSGRLSHRJ?=
 =?utf-8?B?N1o4MUZ1RVpJRXd4ditDQ3Y4YjAxSFNXSWFSc3ZTYkNkWHV5MEYrZnhSWG9U?=
 =?utf-8?B?cGpxNlZUQmNpL3M2TE01NEk2eitYZDFrUFhQRDlzclV5aFVwbEFwanZCUVBl?=
 =?utf-8?B?aEpFMDRNYnVCaHlmNWRhRitRZWw1T1B2MzJKajUvamdscmpCWVB1WGtrSGxr?=
 =?utf-8?B?QWtqV0g4T1BkcEUrR2pYSGhxL09DbzFuRGZPZm5kTU0yV2VMS0s5UjlVd3ZX?=
 =?utf-8?B?UEZUeENtdGxHTkJsTzNBUGFUZ29uV2R6YmIyNG92RjZpb3JYR3pGc1pZTTRP?=
 =?utf-8?B?SnFpc1hjRnVKTHR2YUxRb2gxZ1FqcTNFbFptdGNtd2tyZjVvcTFWVjU4QU5P?=
 =?utf-8?B?ZkNDM3psVUpRTktkZ2NhdGgzVGJXbUp1bDhLSEVFVWFpQk1DV29ma0Fyd0FO?=
 =?utf-8?B?NW54bVI0L1ViTGN2QU8rK0F1MUhlYUNjYVJ1MU1JVGJheHFIWHBoV1JRYTJ0?=
 =?utf-8?B?SjB5clZRdUtMNi8vTE4zRzU5NXZ1NVFZODEvYjRtZjV6RU82WjZkUmtlRDQ3?=
 =?utf-8?B?YXkvaElBbVVOa3dubFl0aThVVHEzZFJKbG5GbWRGb0pvZzNIZkRKUzNzMDMw?=
 =?utf-8?B?SVVDU1UvZm9EblU2dEJzVjRHcUJTdDRLa0VjOUdjZFVyZjdyU1lUN244ZGxk?=
 =?utf-8?B?eE80MUYxVVZtRTNnUEdUaEJ1WnhCYk9KbzhjcXFWOWRHcStuZityU25XNDN0?=
 =?utf-8?B?NUgyczBJVndFcC8ycGNQZTE2OVR6VlZPLy9KTFZkWC9wQzE0TmZhZC92K09O?=
 =?utf-8?B?Wkp2aFhIN0FCNTVjWGsreEVhRStRZTlQSWtaQ0E1UVlrdFNGaXBkbmZtMU1Q?=
 =?utf-8?B?YTR1V0RubEdRYnNYZHdHWDhnMVFpUDlYa2tqRmFiVzJtSDdXcHBlNkVwTis5?=
 =?utf-8?B?SjBxRzdlbS9wMUF3cGVySFUxNWhDRnRhYXU4Rld6dWNzWTE5Mk8way9LSGJD?=
 =?utf-8?B?dExsUURWRlRuODRzZFhrRWhqdUtrbTA2bVdIT3lXNmRSdWtaL0xROUswLzZr?=
 =?utf-8?B?RlQ4bWZvcWFuUXRFSEI4Qi83aWJ0YXdQRHpJaWxBRDF4UHlwSHN4enVsNnJ2?=
 =?utf-8?B?Q0I0RTJqY2JoM3U1TG1qaFBXNmtJd05RTnN0T25vMWRwZXExQmhxWHpCckFM?=
 =?utf-8?B?VXVEajlwbG11YlRnRGU1cEkvKzBidUJXR2FCRm9YbnY5REpoK0xmN2VJVHhL?=
 =?utf-8?B?dkVnakdCaXJ6Mnk0U0c4eE04dHJEeGpHQnlKa3ZLLzNDallLbHAzSGYxWUxN?=
 =?utf-8?B?YUc0WEhlckdUU2xSN1AzSTNHNXJhL2srbzFUaTVIbTlQMUtkWEJRN1ZBUjR6?=
 =?utf-8?B?WUkxNFBWaXN1UkNSOE5CSUF3WnJtdWNmUzZ4MjJrRlJXcElqUGl2N01rcUhP?=
 =?utf-8?B?SzlLN1Jub2hqMXkyMHNlT0ZzdDkxN1ZwOFFDMW5KaVpmcmtUaTE0dEVPT3B1?=
 =?utf-8?B?d3c9PQ==?=
Content-ID: <672E4F9401101C4BAC66C9138599EF06@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3913534-4bfe-4f7d-e38e-08da74f0a0bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 01:36:46.3428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9rh/el4F8h7gBohZkXvJF57F7T1YdHSkLrw9V9sIa+dpVZBvt8C4Br+dIT7cr1UYComgabFX32jit2kY2zgOd+3GuixzuOraMqCeaRna98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9834
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] syscalls/creat09: Add umask condition
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
Cc: "brauner@kernel.org" <brauner@kernel.org>,
 Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

> Hi Xu,
> 
> [ Cc Martin ]
> 
>> A kernel patch set that fix setgid strip logic under umask(S_IXGRP) found by
>> this case has been merged into Christian Brauner for-next branch[1].
> 
>> I guess it will be merged into linux-next branch.
> 
>> I will add acl and umask test[2][3] in xfstests because there is more suitable
>> to do this.
> 
>> Here I just only add umask condition simply.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks.

> 
>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=for-next
>> [2]https://www.spinics.net/lists/fstests/msg19554.html
>> [3]https://www.spinics.net/lists/fstests/msg19555.html
> 
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   testcases/kernel/syscalls/creat/creat09.c | 27 +++++++++++++++++++++--
>>   1 file changed, 25 insertions(+), 2 deletions(-)
> 
>> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
>> index bed7bddb0..04bc98d11 100644
>> --- a/testcases/kernel/syscalls/creat/creat09.c
>> +++ b/testcases/kernel/syscalls/creat/creat09.c
>> @@ -28,6 +28,16 @@
>>    *  Date:   Fri Jan 22 16:48:18 2021 -0800
>>    *
>>    *  xfs: fix up non-directory creation in SGID directories
>> + *
>> + * When use acl or umask, it still has bug.
>> + *
>> + * Fixed in:
>> + *
>> + *  commit 1639a49ccdce58ea248841ed9b23babcce6dbb0b
>> + *  Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>> + *  Date:   Thu July 14 14:11:27 2022 +0800
>> + *
>> + *  fs: move S_ISGID stripping into the vfs_*() helpers
>>    */
> 
>>   #include <stdlib.h>
>> @@ -94,8 +104,19 @@ static void file_test(const char *name)
>>   		tst_res(TPASS, "%s: Setgid bit not set", name);
>>   }
> 
>> -static void run(void)
>> +static void run(unsigned int n)
>>   {
>> +	switch (n) {
>> +	case 0:
>> +		umask(0);
>> +		tst_res(TINFO, "under umask(0) situation");
>> +		break;
>> +	case 1:
>> +		umask(S_IXGRP);
>> +		tst_res(TINFO, "under umask(S_IXGRP) situation");
>> +		break;
>> +	}
> nit: Maybe just use if for to cases.

Of course, will use if in v2.

> I also thought that .test_variants could be used for this kind of setup.

In here, I don't agree because we usually use it for similar syscalls or 
glibc wrappesr but not the test condition.

Best Regards
Yang xu
> 
> Kind regards,
> Petr
> 
>> +
>>   	fd = SAFE_CREAT(CREAT_FILE, MODE_SGID);
>>   	SAFE_CLOSE(fd);
>>   	file_test(CREAT_FILE);
>> @@ -115,13 +136,14 @@ static void cleanup(void)
>>   }
> 
>>   static struct tst_test test = {
>> -	.test_all = run,
>> +	.test = run,
>>   	.setup = setup,
>>   	.cleanup = cleanup,
>>   	.needs_root = 1,
>>   	.all_filesystems = 1,
>>   	.mount_device = 1,
>>   	.mntpoint = MNTPOINT,
>> +	.tcnt = 2,
>>   	.skip_filesystems = (const char*[]) {
>>   		"exfat",
>>   		"ntfs",
>> @@ -132,6 +154,7 @@ static struct tst_test test = {
>>   		{"linux-git", "0fa3ecd87848"},
>>   		{"CVE", "2018-13405"},
>>   		{"linux-git", "01ea173e103e"},
>> +		{"linux-git", "1639a49ccdce"},
>>   		{}
>>   	},
>>   };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
