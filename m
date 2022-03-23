Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE0CC433F5
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 15:41:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E14173C95F3
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 16:41:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D12E3C95EB
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 16:41:28 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A172C200C62
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 16:41:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1648050086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hA3VooWx87gITMkXhzTf43IfTETSlE/+obXMHhWn4+M=;
 b=l5s1cQ1RIpD8lqUtwaKt0bg9B0fqfoQs3yumisU3AJgAsvmsH25qidssC37vxvV3/7te/q
 IR9uv9/jpAc8N8DCWVv2vbCzwiR7AQnQqEN/sebRIUnpg8GVeaTZpeoINYVdG7cRXGW6kW
 ajyqH+AXmS9KPw3tA7SRkDWFkFRD8TQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-oAiiDPlROZWuy-izfDulRw-1; Wed, 23 Mar 2022 16:41:24 +0100
X-MC-Unique: oAiiDPlROZWuy-izfDulRw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYM9zSSRf9Ep3A5snMbPMR4CsBOg7T31ZJ1SwIukbp1GfDk3NDaYxCdRQmKlKx8XB49qd0ync5S0p75EVkh3p3fjJDKZE+8YUtYJeIAzwCd3RWBHWvwkp0VOexY67ydifY9BZ8TKFHbcIsm5AoWN8urz9qS46H8Ge9REgebkLkP6SiYDES9km5ranAg7K38RjAaLW7K61678fRTMtA6blJe3nheg7S794SmgvOAiND3FwPfNZpAUf+v/2Rppf4/1ZizRtBp2FUjAM/N7MzXZtsaaX//wNKE8Qf5hxalJZ+oNiCHxk5Bn0GsWLrPnw6WIXL3d/FX1SIBnx5d4nAvgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hA3VooWx87gITMkXhzTf43IfTETSlE/+obXMHhWn4+M=;
 b=luW1YKK+4+jEaUjbimnG4OcOJVGn3pnfzV9OiLPO3z0W8lVGYxs0Qg/HGjHmbu/vHo0zAMioerjAYkmSwNHhJlExMdgDN7HHKm5hnCK8NlO2tXUh4UnULKh/gu6UI2yszfIasOlMiX88vXe5/cFdTmQ102pLHkMqEZAAdXvqyMwMk9H8AgiU6QU4boRIXwDMc/nGnkJ9+9MVrM2h9yhb1KLTM3jrt+dJl+VvkrEXW6G0PLCRWISiJvjGPG5RHwOPxg7OpVA1ruoTz+oPVXxhu4k5I2nPgLnYEOlqHk5oG4OEJkk0GLtvYHtx0GqjfLrkja20iFkN130OaNEI5gVqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by VI1PR04MB3088.eurprd04.prod.outlook.com (2603:10a6:802:a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 15:41:22 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::416d:72a9:694f:f1b3]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::416d:72a9:694f:f1b3%9]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 15:41:22 +0000
Message-ID: <599d319f-0936-5aee-f140-39bac113baeb@suse.com>
Date: Wed, 23 Mar 2022 16:41:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
References: <20220315122351.8556-1-andrea.cervesato@suse.de>
 <20220315122351.8556-9-andrea.cervesato@suse.de> <YjrqO8Er3NqOG8uc@pevik>
 <YjrvSVaU2jkLgwPt@yuki> <YjsYg2u82uLdxDTN@pevik>
In-Reply-To: <YjsYg2u82uLdxDTN@pevik>
X-ClientProxiedBy: AM6P193CA0062.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::39) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c404774e-9308-4cf2-0cc5-08da0ce39513
X-MS-TrafficTypeDiagnostic: VI1PR04MB3088:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB30889BE129860F794CDF4001F8189@VI1PR04MB3088.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICOa8wRS5+M/5anIojUBMHwNLT5Gb1SkzCBAsVqaLfR8M5ia1u1JFPHkn0eQf8qzZlBWf9d3B/tug9EuuXDwTuDv4jWADlwZ/p0qFxPmFVN4c5+m0UK6stdADdzB00VdSDb4GUCSnwsBsTcYN2aKOAuh1wNex1hwEKGtuXrQjOQ19n+62g34uGE8oQacIPH5kgpB9/M8fiRkqh8s3qQCx9qh3OgbgebVUa8FkPU84AI9pO4fIgPNSl2NWN72X1XO1jmnq03eHCSQC6hrxFaePqgKI+5DxaWdQdHqDCCPKZBO7eL4mM3LHwnsGwqG9xnzMFA3si+PS5Zo0mFerGzDtXo4+ImzET5sNmSUoE7a6WvHJue2N/EBhtzCK5KDctOAMYVBcAesRnoTJsRqeI2bDR0jM/gR5CKUAZmIW57RD9DT1Rh4oSIdxXcKHZBYNn7Z6uLjBPetxqz5s+Z7zCwqvxfv8o5bupRRTuAq7zmkaBE9JxdO7YTnUsUykBGjyyG4/ikVpMOwH3BRIJyUmDjkXsMpggTMiA0zyfDbBvYcmYfRt+l+6go7y8XBKrh7u7GAfa0+EQikhMjCuRkxGVIA5lU9YpblYEBC6UjN9qVBWwpBqALQ3ne+eT6cEqAghnWG/paaYAyKEuZ6OUKk52anlb22hO0/+LFRB55mrDWKnNmLalkqrl88s9TI+81+CkrmJWAfAnLLXV/R02ME3N1HMHcPYJHyOhH+dC/qGGjCQR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(8936002)(186003)(6512007)(26005)(508600001)(2616005)(6486002)(86362001)(53546011)(6506007)(83380400001)(33964004)(31696002)(2906002)(44832011)(5660300002)(38100700002)(36756003)(66946007)(66556008)(8676002)(4326008)(66476007)(31686004)(316002)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1ZiYXZLZStPdCtsK3VIeTFkdDNIeXY5VXMyNHo2R1cvK3NzZkVCT1hVVENh?=
 =?utf-8?B?UUtMRDQ2OGVlRkVlazZ1RkNkMkc0NkI1dDR2K0tvN2VIN0pxZVI2UktHY01o?=
 =?utf-8?B?VlBiNWRJR0g2SXduZEFsTWNZY1l5OFhXeXM1QnFEMS9vcXQ4VXJzOE5hV0Uv?=
 =?utf-8?B?OWtsRUhtU3ZObEtoN2R2Ym5WTXNJR3ZoZnNkeFppTXBEeC9uU08wVU9qL3Yv?=
 =?utf-8?B?LzhrbS9HaXZ2Y01aNnN5WGFrS3ljR2FTTnVmb3ZYeFp6K2JYNmdpWjdKYVFT?=
 =?utf-8?B?RjJ5eTZZajVad1ZwWFJmMWVMbldQYlBOMEw4a2F6b0R0UnpobjBhMzhkd1FM?=
 =?utf-8?B?b0FMdGh0bTc5aEZGc1ZobmVUTHlGRjlkWjhaN3o4dEI4aWVwSDlFUjNXWVpj?=
 =?utf-8?B?L2pVcFpIcXFPNHZrc0lsamNYOUxGN1hCeEp4amkrYjdWMkRkTUp5VTVmdXkz?=
 =?utf-8?B?a2kyVTA2bjJtQ2pGbGdiZXFUNTlMa2FtTExvTmVZenIxemtKdGZEV0QxblJU?=
 =?utf-8?B?dW8vOTVkeWVOb3ZqdHV1aGpKK0JqOFVIbDd0OFh2MTU5aUZCWWgzNUdqT041?=
 =?utf-8?B?Z3ViZ0lORklTY0ttSyt0U0IweGtzSjVWWEhIbkZObmpROCs3a0F1YWplQmRL?=
 =?utf-8?B?dkdOWmJ5VEExVk55VWNKMUVLNThta01Ya0tydjM4K0xUcUt0YllpamVNVXB2?=
 =?utf-8?B?TkFlWGtTMVhUUENFaXh0RTZZeW9qcGplcFR1ZnNKRXlDOUJ6ZWsvemhJbHRZ?=
 =?utf-8?B?empHcXpnOWY4QzNJbHMxK0RjSDFNUTJHU1JrUlpCdC8vVHhEMXpEYVFCSndG?=
 =?utf-8?B?M1JKVnFvSEp1RG50eGpLemNteVFGYmxNb2x2aDkyeC9xOVI3OVFDN0gvclY4?=
 =?utf-8?B?TTUvVnNiWGF4ZTg1RnFmRWJZbThzOE4rbW1xcndwai9jYzgvSUdSVU82NXRu?=
 =?utf-8?B?VHRQMjU2clZYWUQwSGpzRUZxTjh0VmtMWkNQQmtpSkRBZWZyWVJLWFA0NEhu?=
 =?utf-8?B?Mk9zUk5tclhTTldCZ0lsOUNuM0JiaS96cWxxcFZGajF4LzRDWnlmMzc4Zzdv?=
 =?utf-8?B?YmttbUdmQzFPZE9DMXp4TVpDaWRDZE5KUEx6blV6b2FnZEgwREdmWDVIRGF6?=
 =?utf-8?B?V1JCVnplKzdienc5SlFhSXFmTGxGTURxOS9XazZuK2x1ajVzVWRnSGgxQzFG?=
 =?utf-8?B?SDVQbXUzU1VWM0JRVnRxYlppTU1ieDZyUHdIOTRoYUFZa0hadklNZy9Nb0pF?=
 =?utf-8?B?azIxMXQxQTZtcUVVUnJTYUlFcC8wZG9Fc3BXUXc0YndDb1dzbWE4WituUEh5?=
 =?utf-8?B?RXBiVDhoTU9UYUhXUkJaUFMrV1J4M2I2cThlZjhJdXRZMFhZYXE2UmR3Y2lt?=
 =?utf-8?B?eEdtM1MrbXFMdWNMd1lmR1lVL0xhRGZWWVJDK2oyTWJ4eDd5MjZHL2hmZnJt?=
 =?utf-8?B?TWFnczl2K0NxSDNueXhHL0ltUFZDVmo0U1FQMHhBSy9VWlNIWk5BZEloV2FS?=
 =?utf-8?B?OFJUelp3SkpORGUzaXZNNUEvdFh0ZmdmL2lUMUNxQ1o2djVTS0EydDRzejRR?=
 =?utf-8?B?Qk8xcFZ5UzdOTFgrYzJtUWJlbjFta2U1ZEhFYjFXcVlpUGFuYzNjQTJiZDNY?=
 =?utf-8?B?aVBVa3R6TEZxUjFIUHJsMVpYVmpLOWRrWFlRbDlIeDNoY0g3Y2NuQklnOFhx?=
 =?utf-8?B?Z0tTSFZLWTI1ZjJWS1Zvenl2NEtxeE0wdEJYbmZqV25ZYk92QzVyZGdNZzJO?=
 =?utf-8?B?SE9IZmtQMVZQSnBVMmtoRG9vOTRYNWVRdlU2L2ZMQW9la05aeTEyQVc4VHNN?=
 =?utf-8?B?Qk5KVDJVdmpyOGFIVEdxdXhnUWpLMGo4Ukg2dXN0Vmc1SXBBT1hsbzBUYkRP?=
 =?utf-8?B?TzlsellJZTFkZzI3QWpKV3lyN1J1b0RacENFd2pmMmNRdW96cVV5eS9pOE9Z?=
 =?utf-8?B?aFNxc2VEWDIxQ3c1RkR5OHFoanZrOFRwMTZORms5NEZMQlZpdURjKytsSytH?=
 =?utf-8?B?aGY0WW95TVpnPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c404774e-9308-4cf2-0cc5-08da0ce39513
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 15:41:22.6071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mU6Nmz2PdqS3TuCHp9FJ5Wao5hbN+ayEV/yZR44H6X6GoHgSoRnFnDI9mqzkm2m3pegPGDNe8EKdRH9Wm3OrNinz+uroPRODDrTchnTTNmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3088
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 8/8] Rewrite userns08.c using new LTP API
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
Content-Type: multipart/mixed; boundary="===============1186899886=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1186899886==
Content-Type: multipart/alternative;
 boundary="------------RwbGfLyoWvAOVsNq5fhwhk8N"
Content-Language: en-US

--------------RwbGfLyoWvAOVsNq5fhwhk8N
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Petr,

I can check it, but it will probably take some time because I'm not 
familiar with that particular scenario. Can we go ahead with the 
patch-set anyway?

Andrea

On 3/23/22 13:54, Petr Vorel wrote:
>> Hi!
>>> ./userns08 -i50
>>> tst_kconfig.c:82: TINFO: Parsing kernel config '/proc/config.gz'
>>> tst_test.c:1456: TINFO: Timeout per run is 0h 05m 00s
>>> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
>>> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
>>> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
>>> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
>>> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
>>> userns08.c:36: TBROK: clone3 failed: ENOSPC (28)
>>> Something needs to be closed after each run.
>> ENOSPC means that we created too many user namespaces. The problem is
>> likely that we are creating the namespaces faster than they are being
>> asynchronously cleaned up in the kernel. Adding sleep(1) to the
>> clone_newuser() function gives kernel enough time to clean the
>> namespaces and the test works with any -i. Also note that we get the
>> exact same failure if we execute the test a few times in a row, i.e.
>> for i in `seq 10`; do
>> 	./userns08
>> done
> +1
>
>> The original test fails in the same way, so while it should be fixed,
>> it's not really reason to block this patchset.
> Agree (I forget to write I suspected the problem wasn't new in this patchset).
>
>> And the only correct fix would be retrying the clone() on ENOSPC in the
>> SAFE_CLONE().
> +1. I suppose Andrea will have look into it (otherwise I'll do it).
>
> Kind regards,
> Petr
>
--------------RwbGfLyoWvAOVsNq5fhwhk8N
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi Petr,</font></p>
    <p><font size="4">I can check it, but it will probably take some
        time because I'm not familiar with that particular scenario. Can
        we go ahead with the patch-set anyway?</font></p>
    <p><font size="4">Andrea</font><br>
    </p>
    <div class="moz-cite-prefix">On 3/23/22 13:54, Petr Vorel wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:YjsYg2u82uLdxDTN@pevik">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Hi!
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">./userns08 -i50
tst_kconfig.c:82: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1456: TINFO: Timeout per run is 0h 05m 00s
</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:36: TBROK: clone3 failed: ENOSPC (28)
</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Something needs to be closed after each run.
</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">ENOSPC means that we created too many user namespaces. The problem is
likely that we are creating the namespaces faster than they are being
asynchronously cleaned up in the kernel. Adding sleep(1) to the
clone_newuser() function gives kernel enough time to clean the
namespaces and the test works with any -i. Also note that we get the
exact same failure if we execute the test a few times in a row, i.e.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">for i in `seq 10`; do
	./userns08
done
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">+1

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">The original test fails in the same way, so while it should be fixed,
it's not really reason to block this patchset.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Agree (I forget to write I suspected the problem wasn't new in this patchset).

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">And the only correct fix would be retrying the clone() on ENOSPC in the
SAFE_CLONE().
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">+1. I suppose Andrea will have look into it (otherwise I'll do it).

Kind regards,
Petr

</pre>
    </blockquote>
  </body>
</html>

--------------RwbGfLyoWvAOVsNq5fhwhk8N--


--===============1186899886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1186899886==--

