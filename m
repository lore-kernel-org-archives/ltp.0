Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E92C2BB41
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 07:29:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3388F3C9880
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 09:28:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9135F3C9737
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 09:28:47 +0200 (CEST)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7E3F11A0064F
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 09:28:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660634927; x=1692170927;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=31UWNRUnejays37Wyvij+cUb2O5DNAb9v60+tfzLdkI=;
 b=Da2JvofsiOVt/m2JdkSfYyy7v3e+9xdJB1MeiM/WFN/vkwLxw+ZUwGhi
 Ehpp2gkHs5CUOUsJt+XIYMrAEOsQJWbVcRtIvs7ThgEF0+MiQLctE8fyk
 It96Cbc7WZSFD4JJyfdHEmUmrMsj+Hwm9sxOFNBRoz8zA1tNS3x+sbCJa
 uBRrDldq9SsJ8MU0AEsQ60XfCcESr9IHzK58kMakBmFszZrjB9N2LdRNc
 +0Z96a/AQlP8hODkflrM6rotzqU4DI5q0Gvlur2NRD7F9IW5jVvJz+9vU
 CVRUQZK96tL7tjvcJXYztcQeDAO3rI2O6X3lL/ZFHwpKySg2nIGtvYieC w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="62817866"
X-IronPort-AV: E=Sophos;i="5.93,240,1654527600"; d="scan'208";a="62817866"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2022 16:28:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6rzu48ii7dG3DqF3MZ2k43gJbFTvdntN9YJO2AByufdbizScCKGXdnbViPv1sJeWN+0MskC/xXkIxrC5YNvN9dWlIgPNTVhcSqYv65LInCs9YweYNXqrNVtZRet9KdB+8WDiIFEWSQf8Cj8WoQe/Wpx+bggFX2udyTQRkw3zfkI24lbCPdmfij5hvBnEyltfM0XhmnI7ZhLSRcjyRvXsUoldq4BWR6rIGqqt8ZZk+GWbpsLS/nTXjs5kQt8RAvgloMiD7Cy2XMG0y8MbFnbbYha8xKHa3FXVPVXda6c8JAz2O5M2zVetlkR+7hcY3pRY7I2FcGVk8utWq7y46THQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31UWNRUnejays37Wyvij+cUb2O5DNAb9v60+tfzLdkI=;
 b=Fei0sULiJPeU7ukLDyQAU1SScmtNPaoA+eH5zyhkmCHyVssSOuZlRqvMU7dt/vuLA/3pBNxEhkH3xINIvFD7seJefwc2lmW9oNH2kIjImUSYj6RX4yRtmc3LD2w/wsCGbnDR1davcOc23KRG2pgqr3VrtZk4pOVyFGD0u07zs6bABt3Koz3ulfUh98PNR5Dd5r9BsV1dKp8DiDRShBGzdCfwaNY4nQbWLQxzM4xi8nr1uuB3pkatPg0wF9TcWGmjb9lvW9CIBHzY0pmn9KbaohZCSFKLLypVVPuf44VxZmexRyJjSv6O+6NnqZIi/FAEosbbBBodjfzjoFl+FLy1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB7357.jpnprd01.prod.outlook.com (2603:1096:604:11f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 07:28:41 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 07:28:41 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v3 0/2] mount03: Convert to new API
Thread-Index: AQHYrYpdivkAy4rXlU+UH1tz7IrvUK2vgeuAgAAG24CAAYDvgIAAFiIAgAAZsAA=
Date: Tue, 16 Aug 2022 07:28:41 +0000
Message-ID: <97d8ae7b-8547-2f83-7f9d-3cef4f9f2afb@fujitsu.com>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com> <YvnqZfyByO42kAX9@pevik>
 <09a4ff13-eaf1-6a97-f868-893c56ac6b4c@fujitsu.com> <Yvs/3gBnn/FGyAyq@pevik>
In-Reply-To: <Yvs/3gBnn/FGyAyq@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c22d572-9898-4f31-2e1e-08da7f58f17c
x-ms-traffictypediagnostic: OS3PR01MB7357:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aGva74/pO4/A+YZ2zJH7mBkBzvbtd0EuSoFINFdPB5CEjcu5EMvq3bqps8aILrS06wLbujIjThDYYtM8m7cfAcUeHmW5wzncDAXtC4edaZp8h1wCmVy7lM7Ung8SkhNRpHNqBdb2gBP6bjtbRjh7GQ3drqVPDgagIka+n4/8fgWMq9Z3+0QSl9W8nQlvMEY4q2hiTfk1trYrwarFX0W78a9p9CCPzVRpmzHCR8mJeH1CYcyxsJNeB1wTt7A30CQ8mhGD6CvqTaaoIR995LFPDjUCqGpjNpXGOHSe0XgvBlNd4Gu0VuciNNyLyNwAYlv9dUdOZjknPAqQH+aK9HW95CSVvijTCL0WjrJYmUIq1IHIRYloitHIghoZWOH0pQhOTsv6bDRoDSTPPbwqVGSvjfQrdGT7I8TnC7xCq1dFLcwILSOjzemW4KSqcI166IZd9zLM37el3gNp2c+FhXS90U3iggh/uDluOvCXi8wyfxgw3kJKit80LLUflp324nJjvTT6XVBRUNCbNLPuxUGEv5EKjhmITNjGaCzhvFYEEVaH+helZrxmNKYwF3q700f46FLOL83w5+FVNr6rrV1hA2vo27vci5n6ryQ5Ibki6tJkWEMiOeSuMSdhWrTahw+8yYkjiGbLsZ6tZWBIg8EWsPVwv+bx2MXM+T6oncCYh+zm0GR8x9NopDB5lGZv2v18EcrNC3Z/tWJBiHuyvmjHuNEBcFir52fE9bHiog0D+XzFbA0RH2O0lK+fPB9pJ6LeAsozVYniGPTUaQBkJsR0iC972cak4kh1tgXtIGn3nvRBL0iTMCvtWO1ZUJYHtUeY6A84OHPCNFqJmR3bIMYklfB4UxP7btYbTf0+gMfhzKutSLnzWei8z8kgsKyBgDk/Fszgv1EzKirdLPyK3LeSnw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(186003)(31696002)(478600001)(31686004)(64756008)(5660300002)(36756003)(6506007)(6486002)(966005)(83380400001)(6916009)(8936002)(85182001)(86362001)(316002)(41300700001)(91956017)(38070700005)(82960400001)(2616005)(26005)(122000001)(71200400001)(1580799003)(76116006)(8676002)(4326008)(66556008)(38100700002)(6512007)(66446008)(2906002)(66946007)(66476007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGY4VEpzRWdlMWtHWWRMbEZ5UTN6YkxzWXFGZ0c0WENIM2hJcG9EOGNNQWZK?=
 =?utf-8?B?SEdpdmVLcmlVQ2d6NGZXSnNzY0k1K3J3WVlVT25uZWxFRkU3VXVLOXZmbjly?=
 =?utf-8?B?ZndieFlvaGdDbnF1RW4zV0RZQUMvaDByM200MzRRTkgzY1gxNlVlTk82NTkr?=
 =?utf-8?B?LzYyVzA4TFRMeGt5QVZCNWl3cmJEMGZHUEE4VnkrYkFmK3kvNC9JZThxUzdk?=
 =?utf-8?B?UFVlTE01ODhhQjRiSHY4QnhyRzNEaTNjTkpLWVNSUVRMNFRKem50bmdDN085?=
 =?utf-8?B?U3B1bSsyUFcvVTdGdFJGb1VpZ1ZDZDVuZHNNTlNCdFZONHZLVGtiRVVtdS9C?=
 =?utf-8?B?SWNZNWlZb1JzaHJHTGgxR3o3WWxHWkFiSWpQejhiRHZBSFN5bVgzVXp1b0lz?=
 =?utf-8?B?N1ZFS0pZTGRmZmNHR21RYWdYQlpXNkJ0a091MEFPTlY1MUxEY1hzNThYVkdj?=
 =?utf-8?B?Zjg3VGVENHZ3aXZMKzdqdVkrZ0RSRU5pWFBEbkN0c1BrYTc3eWtTOVROQ2w0?=
 =?utf-8?B?QlF2dUU0OEhJcnFNaWk4WWNWT1F1amYrTnh5Rk1URmlCY0JDSDM1b2xLS3ZY?=
 =?utf-8?B?N2tiKzJJOFRwdWNuSE1ObzlSQmIyZTh5VlNNb25YejBDbERudnYycFhYbkM3?=
 =?utf-8?B?RDE0UnFPVFoxanpPb0UwblBqR00wRkNvbllLNWZLWjlqY25zV0JGMUxJODdO?=
 =?utf-8?B?WnRCSHc5Zm9nZWoxSVJSSFROWjlvUnJJVDRDbzVLN2JYM2s1VUxFdnR5bVJh?=
 =?utf-8?B?dE1jUzFFQjJuT3FETWcwMHFYV1lIRkVqMHZRMFhqL2tQVHhVOS9XL0tqSnZl?=
 =?utf-8?B?VjZuWUVtTnRac2RTNE5wWnJIRGgreG1sdEl5YUVQT1BBeVFPam5WbUljZzR5?=
 =?utf-8?B?dmw3SHVINlNuSk5oUEQ5cU1CNlppWTVpcFN2Um56Vm5nQjEzeGJzV1VhMVUy?=
 =?utf-8?B?ZVZFSzZKM0p5N3ROUDIrN1kyRS8zUTBpZjNOMFVab2lacWNYQVIzeW82TllO?=
 =?utf-8?B?QUdPWHVvVGFCS0NrM1AySFAwVDdOVllGTHFCZ21xMVg5NW50eldqMDdHYUtP?=
 =?utf-8?B?RzZFcGJIZlU1MFRYZ2NpSUQzVEpCb1pxTCtaRS8xUGxLRHBNc3FOTFBVcDlu?=
 =?utf-8?B?RjQ4VTNNZW05M1lFcEd6bU4rV2RPY295VmFYMGdBN2FKbWUzWXFQTTV2UEpE?=
 =?utf-8?B?UDlEVCs2ckVMQTRTNXNXbXpNOHgzMHJrNnVqVm51SlZqTDBGSGpqVWRYRmt4?=
 =?utf-8?B?MWhTUHAxQTZnVnQ4VFkwSDlFMlAxOWlhQXhqOVEvUE1jRzNUa040TExQbkxG?=
 =?utf-8?B?TnZuem9UdVdia0xjRG84S1d0V3dERk1mUVhDMWJ1SnhTcWwxbUp0Skd5YktD?=
 =?utf-8?B?QlhET0FXOHRxK3JpTFQ4QkhzdmlweXBvbk1XZCttaHM3NXdkb1BIZmZvdUY3?=
 =?utf-8?B?Vi9Wd0FNRFdCb1VPMURubnA4TlYxaC8vUGpYdkZzdDJBZEVueHdEWWFXNk5Y?=
 =?utf-8?B?b0hXS1Y4eHNvNkFpTU1RamI1TkNTNzFNUStEUHhIUHRvYXNPRTN0ZnpQOTUw?=
 =?utf-8?B?RVppVGpIdjhvamQrTWhnQW42ZzNzWVRqd1JqOU02Q1VLdGFDUnJINTFDUEMx?=
 =?utf-8?B?ZWNPOVd2UG1aNjE2OTAyNGtkZ1IvSVBVYTUreEdmOG5LakNVN2Z3OUVhQWtS?=
 =?utf-8?B?M2FwUytOd0lKS01TdkJLRWV0cVE3alJkMGx6MmdUSit5NkphWndyclI0VEJ5?=
 =?utf-8?B?NThBWXBwV1VXRTgwaVR6RmVWV2puVDlicWtuSXhkOGU3ZTMyVXlIU0hmZERl?=
 =?utf-8?B?QjArMGljYmJCRXl1aTV4M3V4eW5jNVdTTlg2NEVDZUtFaXQrR1NxbXVhaUZT?=
 =?utf-8?B?cVBnRTlod0Q3cExJNi8vazRhbDdUdFlGYkJZOFYvNFM5N2dCeEV5eHRoOHR2?=
 =?utf-8?B?NTc5YlZTNDdGL29XMC9URlFKUGNPWmsxc0tnTitqMzh0azlCM2Zndm92Tk5Z?=
 =?utf-8?B?MDNadmhiTHNKVTM3NTFXYUFBUGIwa2FUakUzQUFUa3NvbEtGcURLU0h4eTd6?=
 =?utf-8?B?dEhFeGMxblF4aTFIZThIUHpydWRuWnpjdFkrSmpCZFBDR1h3eHhHdkxQNzc1?=
 =?utf-8?B?L1lsaDgwSjN6bEJNY2JCcnZDekVlSXErTXFvQTN5ZDdVdzZWUzliWG5ORjlI?=
 =?utf-8?B?QXc9PQ==?=
Content-ID: <3BF9BC41B768B44DA202A24901B66D8E@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WFa2xxRtcLNYtn9Mby003cVmIZ8v1TxaqzsAZGygnaERbydZx+0hOlmDu+USnhPjO0VpwpLx1ijr+5AEYT+DArBJ/7vPkdr+a32cTmb8/fz83LjUcgyuvsHR7/ce+HJcI1Frv85w+h76flPj+pu5mvjYFaO6CLzydzVshgFPtDHALsNR+YsuvvO5lzWBlW7Ju2nABTd7RSLYn+bxCmUR/MucpoVqmeuYoKXH+89k7BYryXBmwKlAMqN8qX5A+u2I6jjHgYXvX5WqGjmos/pAmWii4P0a094H59uKoeC/Hz+t7+jqhhl0/8yJFmobx1JYJ00MGGWuKxyuSjZtpeyivrnWnNdgFP7t/WBfOVQLFNuky/Y3FBAjhbx+I3+a4IZzEP+MYP3M76QSiSIPFEd0Qdye8ANkuM52BL6cMEFRSLc8Ckz6vm62LBkyTL+Qbrjdqha/TIjEPKvpxojTNOne1yefXmRfwh600oQH7OJrmRJS7Xl9EsN+NFUwTnacg0TFB+2JvCaZcowUsajsD1H50z1jbhj0kj/k3DB+HRTVEQv9XaW6/Q5avKYGJLtZn1ioH1wPieg7QzB5kTBeq7yEYLYw7VumNai50H0v36Csh7+DCPRYoCuJvRnXcgRPv0GAtk4FxZ+o3ijkB8I56cre6IEYcXAZ9prl52Y9Oy5iCVe0HBApWS9t1e0OyHygVKcxTBdB7nb6yPds6PmWygm5SGkZwFvG6zjhF+05pIlVnGlIU9moCD8U2o3No7bfJti7
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c22d572-9898-4f31-2e1e-08da7f58f17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 07:28:41.1487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZSQa6ojGVj6PDJmMt/V20fdkfFE0twpeWyNxW+sdzSS8fx62HbFscKM10xa4K/uc3Ba19Kk7p3IPAiCM17nB5Xpb0nIvTWEgVpoYcEgfeCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7357
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] mount03: Convert to new API
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

Hi Petr

> Hi Xu,
> 
>>>> Why here is nobody_gid?
> 
>>>>> +		SAFE_SETGID(nobody_gid);
>>>>> +		SAFE_SETREUID(-1, nobody_uid);
> 
>>>> What problem do you meet?
> 
>>> Using original code SAFE_SETREUID(nobody_uid, nobody_gid);
>>> causes mount03_setuid_test to fail (exit 1).
>>> The same code is in creat08.c, creat09.c, open10.c.
>>> Did I answer your question?
> 
>> I look mount03_setuid_test code today, nosuid mount option should
>> expect setuid failed when using a non-privileged user even this program
>> has set-user-id bit.
> 
>> Old api also think PASS when mount03_setuid_test exit 1
> 
> Ah, thanks for catching my error!
> 
>> So I think you should use  SAFE_SETREUID(nobody_uid, nobody_uid);
>> and then use code as below:
> 
>> 	if (WIFEXITED(status)) {
>> 		switch (WEXITSTATUS(status)) {
>> 		case EXIT_FAILURE:
>> 			tst_res(TPASS, "%s passed", TESTBIN);
>> 			return;
>> 		case EXIT_SUCCESS:
>> 			tst_res(TFAIL, "%s failed", TESTBIN);
>> 			return;
>> 		default:
>> 		case TBROK:
>> 			break;
>> 		}
> I guess we can drop the default and TBROK part, right?
> It's caught later by tst_brk(TBROK, ...)
>> 	}

Yes, I am fine with drop this.

Best Regards
Yang Xu
> 
> https://github.com/pevik/ltp/blob/22652d668a5ccbf3c7aa835c2dab6d0eb6058ba2/testcases/kernel/syscalls/mount/mount03.c#L74-L105
> 
> static void test_nosuid(void)
> {
> 	pid_t pid;
> 	int status;
> 	struct stat st;
> 
> 	SAFE_CP(TESTBIN, BIN_PATH);
> 	SAFE_STAT(BIN_PATH, &st);
> 	if (st.st_mode != SUID_MODE)
> 		SAFE_CHMOD(BIN_PATH, SUID_MODE);
> 
> 	pid = SAFE_FORK();
> 	if (!pid) {
> 		SAFE_SETREUID(nobody_uid, nobody_uid);
> 		SAFE_EXECL(BIN_PATH, TESTBIN, NULL);
> 	}
> 
> 	SAFE_WAITPID(pid, &status, 0);
> 
> 	if (WIFEXITED(status)) {
> 		switch (WEXITSTATUS(status)) {
> 		case EXIT_FAILURE:
> 			tst_res(TPASS, "%s passed", TESTBIN);
> 			return;
> 		case EXIT_SUCCESS:
> 			tst_res(TFAIL, "%s failed", TESTBIN);
> 			return;
> 		}
> 	}
> 
> 	tst_brk(TBROK, "Child %s", tst_strstatus(status));
> }
> 
> Kind regards,
> Petr
> 
>> Best Regards
>> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
