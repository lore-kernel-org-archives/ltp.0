Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE88C433FE
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 10:09:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C9AD3C6D8F
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 11:09:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1E2A3C01FD
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:09:37 +0100 (CET)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D3780601AA7
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:09:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646906977; x=1678442977;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7MAtvQeusfhJpm91NLQCqf1Of6Y1HhZINFpBX8MYwNo=;
 b=ZIMG/THP+d/HHdhLbDxaoZUkaQ1gDB+SGxfXL3GpsOg7DsBxFMN9VNRV
 /lR+PJNcFqdKbDnwudR/ZfBmfg9QTMaYkazqOnvIMtsEWpf4523ZsPobk
 ScCbuuTzT3uSlylzmTak2SD5enVGJbasnsgzxCQhIPigGl1p29akpGZdU
 ZgZNSLdu6V+TjIgFoQ+KwkLRdChUXCK5/ECcNfPWNJUtuVPfP8mommdQb
 5SnNUPKKK1B08G3sg/dLHrJpKtezRT93VFviIKnwraffUfhYOF0X5rZmV
 QI+CskuxfOq0/zMeQ1R6nPT8wEpCH5Z0SkErDfB9OcKdcCIhnQAG+O4sc w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="51413664"
X-IronPort-AV: E=Sophos;i="5.90,170,1643641200"; d="scan'208";a="51413664"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2022 19:09:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dh0iILSHaRmoUO3iqp9q61QM5F8NJDz2EegoboyFCljnSXf7ycoBXER8IIxqUaJG1JVZ60/g4LAm5tdFGNFrLJ3FSvD6iQoN79CENDb53+/hdB3XMJ8txJAD4EAD0NlNoib7mQiAuRZpmOaTD0/GHo/KBGqT178RVCta0S1c5oUMJRiIsQdz7PQyzGcT3pHFMlZur6DCxOAmokfDvYmaM2yrrVhfo8aAJBWCOyGDd5TNjtyD+EAljXLe2jhtUe7r/xC/x/MB5x2vHJqgrXzH7T3lEzSdPgAkRev+z6uuCyERgAye+RmU/tJgHKT6KLq/YDeyymTF+yOD50KOc0I1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MAtvQeusfhJpm91NLQCqf1Of6Y1HhZINFpBX8MYwNo=;
 b=foWpxf+I/Lb900cI5X+KK8lAtzM+fJFzVHd00TGJYaxe+llSupnnmhTkzAnZEXEJ+HCxRfJKgyEVH6Piv+pFx4ycIINg/RNVlHF3oGpyyZKypJKBN8nRiIyiMIKwut6Iv0xOFOp/n8cXYDFbiQhVDcJgarprLepnweS5QHMu2kv8fUBfaYQ27nDleW+FkHzwgdRiz9BcHPvdXy4svn4HQPaF+u9IoZkFGHo8LYNAYgFkfEYy1/pLc6DUztOU+ucJWGpxMol7kBU7BMU+TrubC0l/klTkE/gWTZNPn7ozt2uW3+nDmVaAnROkjt5+CbcvooY81q1S3fHySfb9lMwE8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MAtvQeusfhJpm91NLQCqf1Of6Y1HhZINFpBX8MYwNo=;
 b=gGWNm38YUQHndmVFk+q3Q5MgjvZZ5mOrrsbkEW2ZJO4qZv/xvUWSlTsjmriFMnmxi7RDAQ6uYg+ATfk00bvL8WCijwF1D6lQkm6/R6K+w/BvZl7Di6dCsDyDGnnyjhg/tAK+u3ZztciYjqno1VPZRlka5rjxJoD0zMGM7ygjt8U=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB5106.jpnprd01.prod.outlook.com (2603:1096:604:6d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Thu, 10 Mar
 2022 10:09:32 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 10:09:31 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [PATCH] lib: use braces instead of NULL for struct arrary ending
Thread-Index: AQHYNGBmlhpA6C9kFU+KQkInLyMnvay4ZVuA
Date: Thu, 10 Mar 2022 10:09:31 +0000
Message-ID: <6229CE8F.6080100@fujitsu.com>
References: <20220310092227.15854-1-liwang@redhat.com>
In-Reply-To: <20220310092227.15854-1-liwang@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6553525b-4996-4fee-1d8d-08da027e1221
x-ms-traffictypediagnostic: OSAPR01MB5106:EE_
x-microsoft-antispam-prvs: <OSAPR01MB5106E1BD0EAE2CC6A9BF15A6FD0B9@OSAPR01MB5106.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: smEF1T21XrLO85bv66EXUJm5YNy1qnYSI0xl1i+HHNM12WW9MOFM65ntxYT/qGivsiguFS4XINGOjRhlgELyNOi5VOSgl0X0QuILOoEDEMVpHoBvRHSXix5UiVw7AfXXRvyZfYDZ4I9I9njkqcjmPpo8GSc0B9Jm8/TeQXl/s/rg6oDIbZH+RrmV0NtR+TQ5+lsOhEv+eCEEPPZsu3TRi+kYlvPX0cKSZ+5dr/OM/ZEUzgFJg8CGqzvajZNfcnpIg4frleCdVtLRbXWfXzvGhbZyxa+PQgZNJxs/bLtiDBGDDYDvQnsZrlYnF8HrxcoHXed8kvBfxbZ+rHPpUF/FunFbUs10T9ivy26u5yMMCMsujXcpYBEo0UEKekEoiqsEDJS01XshzwqJ1qFAcYKrx/1sTAjHt16V+cGIvumWITJiRdr5kU9zUIcoTH6UsP20/ig1k7BGhzxwVc3OtFmrv47/ucEl/P0HyBBJGtZ5eGLezPTtv3BplbT1yehoYrVpYHmN8hsVThM1Fz6fHrotuy1S2lqjPUzv+i5VXPmE+f3PcGzaSnBawZgoqWF2MjRQRtpy9Oiyk43MFB+d76H0+xwsbNYsS/EZ/uo0C/NBhjENXSB39YFpsH/+yq51wv7/fYHx6OWZuvBtNiPsMfoU6ELixwxxz0AlCFD/bNaU0QAWmIVcblynLtoL93gAKr+CttK7LM+c0YmsCNcG8+9JZg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(33656002)(8936002)(316002)(87266011)(4270600006)(26005)(6916009)(85182001)(86362001)(4326008)(186003)(66556008)(82960400001)(6512007)(2906002)(6506007)(91956017)(508600001)(66446008)(558084003)(66476007)(122000001)(6486002)(8676002)(36756003)(76116006)(38070700005)(71200400001)(2616005)(64756008)(5660300002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?czlaWXBxaENPUUkveHY5OUVFTHR6eis0UmJzbVY0V1dOK3R0REU0cXkvYmdW?=
 =?gb2312?B?RDZFOTlzOFMrZUZ2QnN3YUNncjB3czh3Q1MzdTZtRXlFbG0zVjJrTXo4dE1T?=
 =?gb2312?B?WWo2eUZiMm01SWhwU29kdHJmcmtYZE9BOG8vMmNqMnhEeXFzbHZ5S2ExanF5?=
 =?gb2312?B?TmQ0a1NYc2hQb2FVZFVJTTh0YXFrMndTZ2l3dFhVU2oydGtUT2dWQStrYjIx?=
 =?gb2312?B?MElFZFNQNjk0ZEIzR1E4WXJrRWZiNHBlcmVFc0psdDQwQ05Id3p2dkRhMDNI?=
 =?gb2312?B?Q0dNL2JVM3FRamdBTWU0UUlxRjFBZEVKVXNzakZkeDVKMjVWVmRJL3FXL3A0?=
 =?gb2312?B?dEpoYTI0UGZOV1JITVpJR0o5bkdCbUZNZ2FaRkNTRXV4VTlQakNLUjVWUUk4?=
 =?gb2312?B?QzhVVWgrc09TNHFwd050Z3BMUncrR1kwUkozUUdqbU0yVW9rcUU1WmZhcjJk?=
 =?gb2312?B?dzBwVkN5WVpKM3JEMHg3YkRQSzFiMHlrSGhJYUVZaGZEdE5LenhpOXBEeC92?=
 =?gb2312?B?dlp5S0JxclY1TW9hNUJ6NHR2Yzdnd0tDcmNQTEdGeUpFRjhrRmtGYkhET2ww?=
 =?gb2312?B?dVpodkMyNmtmbi8vMllBanEzWGJrSjB3TEZBTE9URzhUQjRuUWFtY2o5WnRl?=
 =?gb2312?B?c2Z3OWs4VHZWUzNZSytlWVdGNDR0ZHlJWDZ0VkRGWlJNZXpWOFQ3Qml3TUdF?=
 =?gb2312?B?aU4xSFZmWXlCMVBCRkFOMEcyTnNMMnJhTUlZY1A1aWhmdzlTZWhJSXpMMG41?=
 =?gb2312?B?b29ZNGNVdDl3UkpyTDdUcFFMV0NrVDkwNGhUT1AyUFpORThyN2NTMjIzNUN0?=
 =?gb2312?B?ZnpCYkhmaHFGbGZUMDJ1elRFcXhiNlBpTURvbHpNUFRvWFYrREdOeXFKUkxH?=
 =?gb2312?B?TW1VUnRpYjVJMXhaQVE5NmJkV2dmdVJrRUs5SFZHY1ZzS0ZLSVNZSGxNbGF6?=
 =?gb2312?B?TFloN29rK2RWeDBwTC9RYkJlM1Z6VXd2cmRrcDhLREJMNFZlcXgvcSsveU03?=
 =?gb2312?B?Z0J3ZVVBdHZPWGNlV1JVRzlmWTNBMjhQa3I2UmlKakhxQklHL3lOeE55b2Zq?=
 =?gb2312?B?TXpwaXQ2a2ZaemN6K2lLMFAxZ2lTaDhHSHAveHVDU3ZBYmZEdGNEejJkMjl2?=
 =?gb2312?B?eW96alY3RWZTUXBsMTRyRVFDZTBTVzFyejUwSDYraXVONGp1eVBKcFE1UlVt?=
 =?gb2312?B?K1hXK3IvWWYwYitNV214Q09mYkkrT01oQWdlVHBPVEVPeDhtSlBVMlc5OFdE?=
 =?gb2312?B?U0xheEJEQU5tTjFvUldFUGRqUHFoRitCd05yV01hVVFJQnh0SytudUk5TkZ2?=
 =?gb2312?B?Smgwb2JPU0lqcXJFekN3bTFrWHVzaXNDTnRPWlVoUGs1aXh0eVg3OTgvVEZ1?=
 =?gb2312?B?YlFweUxEdXB6UnhobUFFOWVCVVRMUWVQdWtESGFQT1hRQzVveVh5N0R4cUdU?=
 =?gb2312?B?OTQ4MFcyNml5V2R2S09TWk9nM1RjdDJjUnl1NWYzK1pnc08rRm9jN21TaUor?=
 =?gb2312?B?RlU2WDR5Yy9SUEpOWHFoNEhXeWExYUlMTk1NL25zRDRxZEJTRjdMamUxL1R0?=
 =?gb2312?B?dWFrWVl4QUFYZWpBZmpiR1pZK1lLdnNUSWErRDNqYWVtaFk0c1JRZkV4TVJ0?=
 =?gb2312?B?TVU4aVNKOW5kZk1DV1BoTEFkZ1ZiRUw5bW1RRDI0NFRvOGJrU2hLVTJnVkFW?=
 =?gb2312?B?ZkdQTC8rZGwvUHRBL3J2cllkZ1gyYzNpcExXVE5hTDVrNFNURjFFeitIYjRw?=
 =?gb2312?B?eWlLVUQ4a0FBdDB5a25MQmhiTmNzUTNkeVRiRFBMZ0tGWm1QUldKVTMrSkxB?=
 =?gb2312?B?cm81OW1EN3pUODRDZnVENkZGajFSWWtrYzk0WFdvS0M2ZHpaQlVldy9HY20w?=
 =?gb2312?B?Z29VSk8wSEdKM1VjOXV0YW1mWUJoYis3TEphSEJyL1dvNWVzcmVuU1RGMG5u?=
 =?gb2312?B?SjZ1R3NhZTFyd0xQby9lU2tkbU9BaEVxQjN4UDRqVk9FblVkQXRSS1NScmZu?=
 =?gb2312?B?SkFOWVhrL2lBPT0=?=
Content-ID: <3F209F92215CAF4B9FDE173E30E5E2FC@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6553525b-4996-4fee-1d8d-08da027e1221
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 10:09:31.9172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+LIeZON/+EcJ/8XOjIE37xQgEe3aV2S+ZWJg7eUl+Nqb7CZKNNwvZjEkg3zp/5sITlRWDsgoyKrULVxa1qSS3Zpo2Elxosw965v1IuZdf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5106
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: use braces instead of NULL for struct arrary
 ending
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

Hi Li

Looks good to me,
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
