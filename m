Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04496C433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 13:44:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AADD3C96FA
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 14:44:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FE1F3C0DEA
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 14:44:05 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 10200601490
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 14:44:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1642772644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zjJWNNu3Hz52Xw0c+WP6XrKdLlK8HtUOSznlFNCfYas=;
 b=bzX8ykjHpo+sJZtDHfu30aPZ1aNMYBqzuwE0+RkVXG9i/3tjL0d71nRnDeqIkNvDhzP3nb
 XiAhVA+zHLOtCQpH9LBgcyRrVUEY4TVoRm5x3uUiJ1u0ufYFjxb0hecZOWzhSx4vwiOBuJ
 Ix9L/kLjrdaXL721vAEtEdPZSMgoEac=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-cdSGOuxQMzuTUD9cTOoP5Q-1; Fri, 21 Jan 2022 14:44:02 +0100
X-MC-Unique: cdSGOuxQMzuTUD9cTOoP5Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmAexN2bQbT/8+mqT1qqHtUxJIRlBHlPIp6V4Boa1DHNMdg8infDvZ0tkIgc/0ZKMuq2YL6f5NG1KFAwBTQqKMohH/x+NIV8SaOAkb7Z8K7LNOxX8D93OQQF0KHdt2bcu83JJnBCvogB5OxA1CKQclfUcwIwwX15LiJvbJq4KVfmva3yE9qjuI89gV/f3PXH/MYxFP3TNlvreOLHDbffnmZ7qtXg2NvKmi3fxBglAstMTvg5YT+pFOOOcPeDnxZsItHZhOY879y68qyudwH+64LT2mbvNGxciDVEDBl5HFDFn+zCYR7KZAqQwNBSpuPy2Q0rO96cBaOBe97yB88ozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjJWNNu3Hz52Xw0c+WP6XrKdLlK8HtUOSznlFNCfYas=;
 b=hf2RVI0RjE0OhkwgJWT6jAdU6d27iu7SyC33porp/8Qiov76vN4HfVSVcfmXr1LBT7cItSRDKTlac5OHw7oYZCJlejuzlMWCa+HRBHDvMgNO8URAoX9pwSJZATEIQR3zPn6z20lsh8bxGrvJBDbIxsEH/t+W+WVw0sVnLoMnNuJ/+Lm6T9K/E8AY+toAB3OdeJvuOG2d8/recoq49k6a9h0z0OuHbm3XjKTfk9hTWV+8nRmPU7Rf6d9f4gwiBM4S3GX+gz6rBEprD0B1hVpjzMz423MhTlMYA9r9loo76ITgmsDILsP7NLRkk0PcHojtWINlAxwX9OzUZOBw+dGzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com (2603:10a6:208:18e::20)
 by VE1PR04MB7343.eurprd04.prod.outlook.com (2603:10a6:800:1a2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 13:44:00 +0000
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::1c48:b656:15bb:a794]) by AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::1c48:b656:15bb:a794%7]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 13:44:00 +0000
Message-ID: <cf761305-29fb-cd07-48f9-e6cea8f0cd7a@suse.com>
Date: Fri, 21 Jan 2022 14:43:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Martin Doucha <mdoucha@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20220121103011.6266-1-pvorel@suse.cz>
 <4508acbd-3ca2-b1b4-ff38-6ffa573aa6fd@suse.cz> <Yeq2KeBX5/04d01m@pevik>
 <5988d540-ce29-d210-365e-7e5efa91b547@suse.cz>
In-Reply-To: <5988d540-ce29-d210-365e-7e5efa91b547@suse.cz>
X-ClientProxiedBy: AS8P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::14) To AM0PR04MB6788.eurprd04.prod.outlook.com
 (2603:10a6:208:18e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e937bc4-2f31-4044-701e-08d9dce4140b
X-MS-TrafficTypeDiagnostic: VE1PR04MB7343:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB73439708580558C06361FD5FF85B9@VE1PR04MB7343.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOGHyK00RWll9iv4bkjd3zdkjwmj42WwLyAuELbMEZKUF7Vxas0P9dxVc4aLg+FL1LODd+bKQxIkD5Z+Iyz+DBs2NMUAjp6U25oPGbRXiNunpV5GwMxC6p6AaQCEmU4MfLSlO+nED3VFMktEtVISA1Y+Aq/wNruSfWnvAAYKfCbSlak834Jj3qpIgIHmxtIuMUGam+P/0YAlslPynCaZrfMoRt+b1rO5jReanZbIXBuqbUSUZRiuj7SVzvZwXIYR4z6mfhf51yET96ZBWEshMASan2ra9ZShP1EjGxKzshQRM8Tq7ILE1Bw8P+CUKq71DdzBxbLHzzGTt894fzOahO3TdR7iAbuV0zBNjI6E7YSj7JjDXKPdqXKw5SiSSimFlhW36OJtKVPqSuCe7dIKHKCeR95wp9R3bu8kVIqUsZc9L9I/CDlktiNBa3BnWeE8+EA/cM5f9HRjD4r+arWbi2agA6EeRSDLnvObUU4Sn3FHwa9gyzL5GCaMKdD7TeFDJfulLQPaA6lS4cOS8j7acVYrvpx5A7PLtzVrAvTzb9/CtEprHHoWHduWSTOsZjf7gQNlHJZuoEMB90+QFKd4Vgg5PvG4sliaxocjBNHXO4BRj2zsjbyjZylIMa5OoYk1IZA9NThunWGfhJCuSmBTRbSe65w7yyIBJnZfmXmT/oApGtT3HSU6ACRuKGLLrAHAlEcUs3OtYqr9zlW4kua3lo7LE95df7/Lt7isdmpFOSQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6788.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(26005)(31696002)(36756003)(5660300002)(33964004)(2616005)(110136005)(86362001)(54906003)(316002)(83380400001)(186003)(31686004)(44832011)(6666004)(8676002)(6486002)(38100700002)(66476007)(508600001)(66556008)(8936002)(53546011)(4326008)(66946007)(2906002)(6512007)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlN5d1ppeS9ndzNlQSt5c0FEOEJ1TFpmSFJ5U2RwTVYzYTVWYU5DOWM1VGdO?=
 =?utf-8?B?SmVCNnphUGRUeEhUczJHbTRvc2FQZTAxYktja0wzaEM0cFFQTjJ4OWlWVjRQ?=
 =?utf-8?B?Ni8yWDZDQXc3UGRwQkI5c1hEczJ4MkNjK1NKemFIa1B3ZlhpQmRhbHVxTHJN?=
 =?utf-8?B?RGQzRXN5R3NSMUFJSXVrNUlDeHl0cUprS3FzTlhwL05RVk52WnRHeE92Skh3?=
 =?utf-8?B?Z2pWOXNhQ2ZJcjkrRVVWQ1B0TWdRZHh1VkdtU1VMdzB0c2oxUVZQQTJYNXBG?=
 =?utf-8?B?S09HNjRReDY0ZWIvazMvcTQ3cTlvNVQvYlRNU09aR2xab1p4cGRaUlpUSlAv?=
 =?utf-8?B?NmM0OTloZFdMU3VPZWFOTDllelRXTnRaMDh1K1RvSmx1VXlhZ0tYb2NtZWw4?=
 =?utf-8?B?UGdiVjVPRHNFSU1rODlXVmNjdUt3V1lnYWlQRlF4WlNUMWxOcEF4WUtxdEIx?=
 =?utf-8?B?blNQbmJvQTNNVjNMRXc1ODRnSnVIdXpCaVdmSkoyamtQSElMZ1dqL1RkNHV0?=
 =?utf-8?B?Y1l5MVVNVEt6cGZWRGZLNHAyRUY3VUJub05YYjc0OWE2cnQ4RHpXNEVqMWFR?=
 =?utf-8?B?Z2oreGlLcXdvNHhxSVlQZWVGOUV5QkJZSU9ScmFFd2tTMlZKYWMvSW9ORDlF?=
 =?utf-8?B?M3BQd2hRR0Q1T2czSko1eHA0TDcrN0JvekxiUUdGTDFWRC9HTXlvSHhJQUtU?=
 =?utf-8?B?Q25WZXdNN3dNNXpmcmZ5NktjcGc3VkFjbEp2V1ZWWlpURVZPK3B0eEZzbld4?=
 =?utf-8?B?Y0dJTVFCQ01OZUM3MU9iZzN5WHp4RVh6Q053QStHL09LWUlBSFFLb2IwYTZ6?=
 =?utf-8?B?V3FzUHNRVzVaZFRnamtNbWRYd1RIOHVJTFJkenZrN0FnL3VVQ1YyNkMxUHNk?=
 =?utf-8?B?eFNLbXlvR1hTbFJWUVc1YnBRSzdwRkJ5aVU5S3B4OTdicUc1d01sUzBBdmhI?=
 =?utf-8?B?RUhRQzVYbWpUd3AwRThxaUpVU2NoS1dxVERjemlQVmtzOXdyV21EN2czcDJu?=
 =?utf-8?B?YVRJVWU5STJzUWhQelkyY2t0bGFoU2srSXR5MmdJalpFNlQxL1RybW5qRExl?=
 =?utf-8?B?dlBoS1J5ZmF4ZFVGaG1QSmVQbFltL0kyZmx3UFZNZ0JlejQzai84NHFXY2ZO?=
 =?utf-8?B?UEFsUEFQZWthbjEzYWMxRmZHSnhhUDEvM3VZclIybUVmY2VOdXB6QUhEOU1M?=
 =?utf-8?B?RW83VGhxanNtMjdIcFdLT1RBQTFFd2J3WW1WYTMremwxYWI1OG1oTzdjMVh2?=
 =?utf-8?B?eW5seldMZEZhdDBQK2cvbU96QVRnNmo4Y1JTdkExYTZGUkcxTlFvaW5pbFhT?=
 =?utf-8?B?V3ErTzczekV4Rys5UkRhd2dNL3V2T1JrRDVxOGp2Vk4yWE9qcndKSnZlNlhK?=
 =?utf-8?B?emVocERsRk9TSzMwNEVYSys0bHhJV3JHd3RKY0w5TUhmb0VqQml3QUJ5ZHVP?=
 =?utf-8?B?UGtIb2ZLQVRDZkI2a3AzUS9mbndZKzF2M2V3clVmeDNQb2duNWwzZU1LRjZn?=
 =?utf-8?B?cjgwNzdkblVaMXY3eGJiaEZsRVlaUzRZcE9lakwzeVRBMjZTOHBRempvU20x?=
 =?utf-8?B?Q0R5YUxCaEZXbHlBMGFOWGQ3Yk5TUlplVCtLRGo5WVFtTTFiNFJERFpCT0JG?=
 =?utf-8?B?VTRENEpPTnJ5MW4vQWxUbXRSTG5CbUdzWUNqY1Via0FUNStWQUNLNTFsTGRY?=
 =?utf-8?B?SENaaWVaemY2NStXWldRZHh1N1lXMnh3b0lMSHpGZHloS2ZBZ2VmNkdhZkZm?=
 =?utf-8?B?ODFwekdyNHlWUFFCTmpkMVpaYUVhMzBBdDdvVkxVVGlUKytFSTVsekZXSjJu?=
 =?utf-8?B?aUNMVk1mS0RoWXlqL3IxWGZReDBFNXhIaHQ2MVFxM2VxQVM1NjdGS0FoaXVU?=
 =?utf-8?B?dnN1dWtHaS9obW1aWnEzenZVVDRFMHYyWWdUZytkdE4vdnN2a3h4TCtyc0V1?=
 =?utf-8?B?ZkxDT0xVbktRdW1rK0RnR04yZWJyUFJKcjJkU1VHa2t0bFFkRnB6QkRkV0Vt?=
 =?utf-8?B?bEgzQ3JoN2hLUHNpU2cxN3JHd2FUWmwvYS9uamxJVk9LMFpxL1NaK0taclNo?=
 =?utf-8?B?c0traHR6Z0x6RHRxNnZEUTF5a25pb2NCQ0J1ejlQRnJnWW9PRUcwLy9tS3Bh?=
 =?utf-8?B?MWlSeXJ6dHY1cUVVQmxjamlLRXVsbGxQLzY5TENaSVY1WWRvMDlQRy9WV3JZ?=
 =?utf-8?B?SFJBeFl0UTQwUkE3dGRJcjMzdFhlTXNzbzYzZnd4OEpOdHArTkJhTTBtUEdI?=
 =?utf-8?B?Y3lMeDNnL0hwYjAxZkNLaURjMkR3PT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e937bc4-2f31-4044-701e-08d9dce4140b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6788.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 13:44:00.1285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaI29YrtTNI4S2yL6bk//Y/og/2uc8lO+a4qTNUsFnwkE3bMKG33NSl1hle+gt4z1hmMX23K0nPW+LrNBI4FVvFB1a+PvovSqhw10wz0h+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7343
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] aiodio: Set timeout 30 min
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1257416129=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1257416129==
Content-Type: multipart/alternative;
 boundary="------------SLooBFKPF6ujc9whszOVBSxP"
Content-Language: en-US

--------------SLooBFKPF6ujc9whszOVBSxP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I agree with Martin that some tests in the aiodio testing suite should 
handle default value a bit better. To reduce the amount of memory/time 
required by manual execution with default values could be a task for the 
next future.

On 1/21/22 14:38, Martin Doucha wrote:
> On 21. 01. 22 14:33, Petr Vorel wrote:
>>> Hi,
>>> only dio_sparse really needs higher timeout because we use it for a slow
>>> stress test in a runfile. dio_read should get a lower default number of
>>> child processes instead (8 or 16 to keep the default memory requirements
>>> under 512MB).
>> Thanks!
>>
>> I also noticed dio_read, but as you pointed out it's already fixed by
>> f3caabe44c ("Reduce memory footprint of the dio_read test")
> Runfile usage is fixed but running the program manually with default
> setting would still result in extreme memory use. We should make the
> defaults more sensible as well.
>
--------------SLooBFKPF6ujc9whszOVBSxP
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">I agree with Martin that some tests in the aiodio
        testing suite should handle default value a bit better. To
        reduce the amount of memory/time required by manual execution
        with default values could be a task for the next future.</font><br>
    </p>
    <div class="moz-cite-prefix">On 1/21/22 14:38, Martin Doucha wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5988d540-ce29-d210-365e-7e5efa91b547@suse.cz">
      <pre class="moz-quote-pre" wrap="">On 21. 01. 22 14:33, Petr Vorel wrote:
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Hi,
only dio_sparse really needs higher timeout because we use it for a slow
stress test in a runfile. dio_read should get a lower default number of
child processes instead (8 or 16 to keep the default memory requirements
under 512MB).
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Thanks!

I also noticed dio_read, but as you pointed out it's already fixed by
f3caabe44c (&quot;Reduce memory footprint of the dio_read test&quot;)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Runfile usage is fixed but running the program manually with default
setting would still result in extreme memory use. We should make the
defaults more sensible as well.

</pre>
    </blockquote>
  </body>
</html>

--------------SLooBFKPF6ujc9whszOVBSxP--


--===============1257416129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1257416129==--

