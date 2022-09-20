Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F62C54EE9
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 01:08:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E47D43CACFE
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 03:08:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CBC63CA9DE
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 03:08:41 +0200 (CEST)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A00D02009EE
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 03:08:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1663636120; x=1695172120;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yejmEOhbWYeCKClJrjqvy0jD6dVK+oR1DxyPFGCGTJ4=;
 b=Yq3SqtqFg+16u6+2H1jw+JsO7DJ+UUrjdYrtmjWpF3eO14FagxNUSQ2D
 WmAn8m/hd6I8RDopi/+NqxOecUsLxGMMoLIZxDaWK758pGqwIBgFHVHq2
 ui2KJb8NI6pOnnL/1cUlD9M83eGHC5SW4k6yCNDUXLCWyhw2naTqnqiBH
 L6nl7ImhbqoRrCAY1h3HfYWUMpIxARgyEYi2QRz9gw3cmaB1/fNwLZ+Ua
 hcU7CHI1l9sWs6i72AFGCGriBCL+GHQcM2Y80WwZe7dgkSu10SN/yc+Ha
 J4Vn6CxnIpNkyIXI0Gt4ck0eGwcb6xV6e3M/0D/lDcDygM7N8estBbZfz w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="65697504"
X-IronPort-AV: E=Sophos;i="5.93,329,1654527600"; d="scan'208";a="65697504"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2022 10:08:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZh3poL8GV2jcLiALJ2gHDtlNobBmxO0PwxbUHjEHDp6kw6MDfHTpSozp2IE3HMyKvz8vLQXWTwB7olZ7hKtYh63QzKf9Zl05Lw0kOeH1UMG6i1pqBjXjApnEebNYWpEv2636v/h8moHsjzHzUdtmpWdfWxNhbpxUSPtviZ8lMzJr9H4Hgz8QMf9uZQn1ewo2i3vkkbb1pbqQlqKU0z6fcrw3hNFcgeqF6lMOHfSoBgUdnla8D0LMNSV0hUDy1/DgT+mkG7qqMK/fZKtWHa+5tpEsdT0SRR1jjZ8HM7464ep2GwjqNLNYbrdtPnu/EKqv5wlkIzy10xqurZuKto1FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yejmEOhbWYeCKClJrjqvy0jD6dVK+oR1DxyPFGCGTJ4=;
 b=jhOlshBGVdXqXiVie5vOAC/RPFRatmTBCdEG99ANT9pe5HKmNQAXVGuRUHdU8KAlYxJsT1mprwOmZiRahL9VBI6a1SDETg8LdjfBOmXD4foMkChZ4ye1HzqXrP2Yzl0bqkQdC1gFY0fU4n3i1Tyde0S9rNxvGQbntqA0pjSY4Cie1ILP93CjA82HBcvJHHUPfj8DBC2tOrhzgw+jnCgJJWYCU02aN/Het/qQqoe5xBfspvMxSgjhE2gQEk4Z2DVrOJLgL3wElPTrEQz06VWud7M/PrPilZ4v2xzQDTMXP8vDVsKREoxspFExxaldyjyMwB6xVy5gdve/TOJDVTU6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB8600.jpnprd01.prod.outlook.com (2603:1096:400:159::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Tue, 20 Sep
 2022 01:08:35 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 01:08:34 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v4 1/3] syscalls/creat09: Add umask test condition
Thread-Index: AQHYyAlTrUVCU8c+IUqnRmjYm3bjvK3eyhwAgADtgICAB+RbgA==
Date: Tue, 20 Sep 2022 01:08:34 +0000
Message-ID: <12eff5a1-bf6b-59bf-bfca-7a1d4f3ca009@fujitsu.com>
References: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YyG61JHO7iDAfJ1N@yuki> <bd50a9da-0b32-2318-31ec-67a78155cc25@fujitsu.com>
In-Reply-To: <bd50a9da-0b32-2318-31ec-67a78155cc25@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|TYCPR01MB8600:EE_
x-ms-office365-filtering-correlation-id: 0d0ed9a0-b2f6-45d4-e0d2-08da9aa4a462
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wTLzF3B1Tq+HsDkv+hy37Arig5Fx97kIAmzU78RlM/pn39wehAxhIA1jMIMO8i5/zQgbjTMEBe3AHL79Dx/OUIgL/WO8IBuIfsNiWfwlxrA5PJh6CkFBkkXk9lJ9no4CdXk9j6Wq5xYnt2+T5gDCFv7242S5mtDtSDy7EHPj2zC6dCxJCOuxovBBZsTPuEmgI2wePcsQ6Da3+7oBERcowxFcsfYT2BGgl6oTWHGjzBQOK4LTEMwTWURMKnQkhS7lUJqNPpE9lLoxP6hXz5o8o1mvvHrb3VsJCiltiV98NVkRtrDEijti0vyMWmRxQFYmopejdcJ91PqtWzWPbJtKoW5qxo9br7Zb9A9YoF4cNBOql82gwqEuhC483J5wEEkoOczxPyWroEOoasYN17SC+Ssh9hsc7C8RhTuDwpdLn+0iSc3pUZ7VQtshQ5V7Z8hqwPDkL1DwLC3dvc6AwMln5egJetGuw1fVdxZoz8W+UkxZ3QiqrogwLrwUnT5J88F+C+PUFJblZwxQ5X+jkglQ7cSiWN5Tvdb3Y0d6MmTbl5/XtrUVleb1jpwXsP3/9fVMnbnIqcN43dUkzxrd2a6IYNSVVfDidL+/V2c6STUM06pLUKjtU1f/N3TXxUhODpKgQ7vaBmxsvuvgt/AodsSHbgyIdkIl0cJh8EJJ9ao0B0f7ssyr/FApwpXo/cjtRXnABS9eksvxt25yNd79UU+t9/H7eN4ragztj4rILcn8EMpIEKG6q245FqMT1gJMK0WzdjHfgtPQ3dc4fJStHxVp1ImM9UTitxemdCr4oq5/HnS3Y/S3jKoROXNHL3ihW1lWv76IJG9OGuf+B82EzuRlng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199015)(1590799012)(31686004)(6512007)(122000001)(1580799009)(38100700002)(26005)(82960400001)(6506007)(8676002)(76116006)(91956017)(4326008)(2616005)(2906002)(41300700001)(38070700005)(86362001)(31696002)(186003)(5660300002)(85182001)(36756003)(478600001)(8936002)(316002)(66446008)(54906003)(71200400001)(66946007)(66556008)(66476007)(64756008)(6916009)(83380400001)(6486002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXFJT0pXYXU5UzIwVDUxRHAzdXFEcFI2MG85LzhocS8rb0VSc1FkMUhxQTdV?=
 =?utf-8?B?QXNqQWJsaERIWW40dWI4dSt6ZFN4MVpTWksxWFdtTlZCcVJWM1FvdVRMclFj?=
 =?utf-8?B?bWN3TFJjblN2TTBWaXJWSnBRc2QyUHNkQm5nd0U1Z1NDenFpNExSVVRRMWE2?=
 =?utf-8?B?L29WdFJtSUlLaFkyMjhGL0lSRjBXSFVIYmdyMThBZFBvdUVsNmJZWFk5STgz?=
 =?utf-8?B?RnlERHNJdC9CaTVBbFF5QjYvNnczMTQrbXZab2c5TWdvWTIxQ1FkaGFSK2l6?=
 =?utf-8?B?ZEd5eENGTmkrQ3E2aStoRnRjeXRMaWRkbFpNQXo3WHFwTXIrV0NIUnhPTnQ2?=
 =?utf-8?B?dUlHT1JaWXNwUGRvZXZRTERTYjc1QklLQ1U0U05ZY2RzZG1GdUFoOUVRblRK?=
 =?utf-8?B?d1puNGsrL3JBNmc4dUtxVHMxQ2J5d1VZaEszUjVudE5oc1RUUlhtL2lxUlU3?=
 =?utf-8?B?Q0ErZ1k0Zk9ILzJNaTBoaGFrd3REcmE0QkZsQjZNeU5yS0xpb25CZ2l1WEFs?=
 =?utf-8?B?ZC9EMHUwZE5wY2xCS204Tkl0SE1vRzZUYkw1amlQaVV1a2JCWlZlMnBQQjJ1?=
 =?utf-8?B?eDNEY0pXUDhVb3RKb2Z1cjRNeUMwQUMwNjBBb1ZwNmJLY2lWeG9aL2hrcElE?=
 =?utf-8?B?ckZlaEpnVkdySEgzak5aUXUzUjlZaEozWW01bGdFcHVJV1k0ZFc2T3o1U1Ux?=
 =?utf-8?B?VzFPL1RwdmVaaEVHN0VTNm1rVDh1TXlHSUNicVU4amNCRk91ZWtIWDBmME5z?=
 =?utf-8?B?QStjMGN0UjFnQ0ZYU0FTdSsrbUhjei83L01sb0p5TUdXWE1rTW1Kdi9oQm5x?=
 =?utf-8?B?VVB2ZjhFdU1XQnhaMThnMUsrWURFQXRvb2RuSUpVOTNlM2hFMURDdEp2RFlQ?=
 =?utf-8?B?cno1STZMbjFJeTFhdHd3SU91MXBaanl0YzNWUUd4MDhRQ2xHRExJcnpWVXJa?=
 =?utf-8?B?bUhxRjZWaWdLWlViMFBOa2dQS2s2UWhMYTlCNEtIUDRrR1ZxNWEwVHIrNmtz?=
 =?utf-8?B?c0ZDVkQwWk9uMU85NjZZR2VYYVdHaE5aSTJoSXNYVXpwQ3RiVnNFeFovTGlx?=
 =?utf-8?B?bXpIcVB2b2hUQ2JVM1UwTW9Vc2h1MXJHVUdzVXdqTnYzek1hMVNZbnFNNWJE?=
 =?utf-8?B?VVE0eXpncUdPOW95MTZrVUJOcS9vNm54MmxuUnNCeWpQcHlrYzdRN1ZBWjFa?=
 =?utf-8?B?REVpck9mRU9SWHVNQWtIOE1oK1FzZ3grcmdPZGVyS0gvMUNoeWpIaS9QemJJ?=
 =?utf-8?B?ZnNFRElBaEJSdVBXL29Hb2xsZXVoU2t5WnU1T2NMWTdDRXhYSlh6eCtMUm5x?=
 =?utf-8?B?aC9zNkp5c051d2gxejJLeThvUmFaenJiTnkrUXNLVHIzblRma1FsRVl2Zkdk?=
 =?utf-8?B?VkZXNFFXZDk2eDNyUHE1aG8xaTJxMWhDdjVjNXNrQ29xTStoVEZVWGRjYTJs?=
 =?utf-8?B?bVZxcjBaV21ZYWlVdExoczhDVVJJYW5kc3I0eE9LOXBLYk5hZ05vNWpxQWx1?=
 =?utf-8?B?cVBaYlJtdVlDcXVPTHlFK3R1MnN4NzRhRm5CSXAzK3FJNnpEa0ZmRzFKbmhl?=
 =?utf-8?B?RFRmSWpNYlptdVRieHh2aGdETnAvZVlFems1TjEreUZraXk2UUR6VklRa2FU?=
 =?utf-8?B?RVVRY3B0cDR3RFh3UHBjaU4yT2ZrRXhrc3hiZTlvd3Q1WFBGR1ZCVERxK0to?=
 =?utf-8?B?VjlvVEhuNHJJQVRXbE5OQktBa1l6VjNlZHZUZFdKRm81cTY0YUJyZEU2TmpR?=
 =?utf-8?B?Mm8wRG1nMXA5MjhZTHZDeTkwS3BxdGJPUHJOb1JJbEdYRjdXMWhRRjlaOS90?=
 =?utf-8?B?K3FPZDhFanNkck16ZFF4VXhSTS9EdEdLVm5yQk96a1ljNGZyRnI4Sm5DNzJL?=
 =?utf-8?B?UDZOOWpYVys4S1FwQ2VhYUR4OUhndkttL29iSkxZc3ZjTGFHTVNadXJxRER2?=
 =?utf-8?B?eDVHTDFNemxjejJPdlptYTgrYkNPT3VqK2k5M1VOUjU3Y2hVNnZiM0FFczUw?=
 =?utf-8?B?aFVkcUxLQTdBWlM4SXR3bUxZNFNMZWNQNG5pMU9tMDUyaGZLNEZ6cjJJUXAx?=
 =?utf-8?B?aVphYzFBSFFSdEpyaERrUXcxRnV3cjJVVDNmNkEvbGtadjRkd21zYkZOcHBq?=
 =?utf-8?B?dFpvZjFPeVY2VEFIYUxLdnQ2T0tLUFc3SmJ2NlpyOFZDbG02WEpXcEhCR3Jp?=
 =?utf-8?B?WHc9PQ==?=
Content-ID: <1C166D2553FAB84A8771A3C1B2F73F63@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0ed9a0-b2f6-45d4-e0d2-08da9aa4a462
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 01:08:34.9291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGHb2CbuteboKkasJIz0F7IXd3clo5/kYfRefKCBrQtq9vEWwhOtR+ogBYEptAkXgXOWl1szfvdMD0xwRwjhaK1wNzjc5niKI/VlUpIecdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8600
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] syscalls/creat09: Add umask test condition
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
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril

> Hi Cyril
> 
>> Hi!
>>> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
>>> index bed7bddb0..d583cceca 100644
>>> --- a/testcases/kernel/syscalls/creat/creat09.c
>>> +++ b/testcases/kernel/syscalls/creat/creat09.c
>>> @@ -28,6 +28,16 @@
>>>     *  Date:   Fri Jan 22 16:48:18 2021 -0800
>>>     *
>>>     *  xfs: fix up non-directory creation in SGID directories
>>> + *
>>> + * When use acl or umask, it still has bug.
>>> + *
>>> + * Fixed in:
>>> + *
>>> + *  commit 1639a49ccdce58ea248841ed9b23babcce6dbb0b
>>> + *  Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>>> + *  Date:   Thu July 14 14:11:27 2022 +0800
>>> + *
>>> + *  fs: move S_ISGID stripping into the vfs_*() helpers
>>>     */
>>>    
>>>    #include <stdlib.h>
>>> @@ -47,6 +57,14 @@
>>>    static gid_t free_gid;
>>>    static int fd = -1;
>>>    
>>> +static struct tcase {
>>> +	const char *msg;
>>> +	int mask;
>>> +} tcases[] = {
>>> +	{"under umask(0) situation", 0},
>>> +	{"under umask(S_IXGRP) situation", S_IXGRP}
>>> +};
>>> +
>>>    static void setup(void)
>>>    {
>>>    	struct stat buf;
>>> @@ -94,8 +112,14 @@ static void file_test(const char *name)
>>>    		tst_res(TPASS, "%s: Setgid bit not set", name);
>>>    }
>>>    
>>> -static void run(void)
>>> +static void run(unsigned int n)
>>>    {
>>> +	struct tcase *tc = &tcases[n];
>>> +
>>> +	umask(tc->mask);
>>> +	tst_res(TINFO, "Testing setgid behaviour when creating file %s",
>>> +			tc->msg);
>>
>> This can be shorter and more to the point, something as:
>>
>> 	tst_res(TINFO, "File created with %s", tc->msg);
>>
>> And the msg could be just "umask(0)" and "umask(S_IXGRP)".
>>
>>
>> Otherwise it's fine and I can fix the messages before applying if you
>> want.
> 
> Yes.  Please apply it with fix the messages. Thanks.

I guess you miss this patchset. so ping again.


Best Regards
Yang Xu
> 
> 
> Best Regards
> Yang Xu
>>
>>>    	fd = SAFE_CREAT(CREAT_FILE, MODE_SGID);
>>>    	SAFE_CLOSE(fd);
>>>    	file_test(CREAT_FILE);
>>> @@ -115,13 +139,14 @@ static void cleanup(void)
>>>    }
>>>    
>>>    static struct tst_test test = {
>>> -	.test_all = run,
>>> +	.test = run,
>>>    	.setup = setup,
>>>    	.cleanup = cleanup,
>>>    	.needs_root = 1,
>>>    	.all_filesystems = 1,
>>>    	.mount_device = 1,
>>>    	.mntpoint = MNTPOINT,
>>> +	.tcnt = ARRAY_SIZE(tcases),
>>>    	.skip_filesystems = (const char*[]) {
>>>    		"exfat",
>>>    		"ntfs",
>>> @@ -132,6 +157,7 @@ static struct tst_test test = {
>>>    		{"linux-git", "0fa3ecd87848"},
>>>    		{"CVE", "2018-13405"},
>>>    		{"linux-git", "01ea173e103e"},
>>> +		{"linux-git", "1639a49ccdce"},
>>>    		{}
>>>    	},
>>>    };
>>> -- 
>>> 2.23.0
>>>
>>
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
