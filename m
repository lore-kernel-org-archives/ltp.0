Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4DEC5AD4C
	for <ltp@archiver.kernel.org>; Mon, 20 Nov 2023 18:25:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B996C3CE1D0
	for <ltp@archiver.kernel.org>; Mon, 20 Nov 2023 19:25:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0516F3CB683
 for <ltp@lists.linux.it>; Mon, 20 Nov 2023 19:25:02 +0100 (CET)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CF37F600C38
 for <ltp@lists.linux.it>; Mon, 20 Nov 2023 19:25:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJ1yFTWHTBIOv4XfhkbvsBIPsi+ft0yhfhcJm21heIU1dgGc8GkQh4doadvc8QygYWGpXRbiXyL+ydWEhV5VFwnrbnSZ/joO4AEnCCSE4cjfXMiVwBE4GCLz4ZMNPf3i01NbS8KHFyCRXQGvCn6fkN4OlEybKLtJ1GUuWnzSIL+gezWuYjsWgFQ7lettcTAmGFOBBYaC7eFc0YlA3CB4ZPnEGrgFmi1z0PR3UpObSWGYhKm54HQBlTpIOHU1l9j2u/XwKpd9ShNd6rA/cycCh/w0avTjvh842lWsK37IgNphbBFsgDq5EqDAzc3unHi9tr7XNpkC7gK03nmV4GmB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7tfOXZy0vhWuPKP/a6L4kU1wPWW8WqAUBYHzthYoWE=;
 b=QuL4Qo8g7pET98oAFnYO/BVhFUTmv17aqWvX03Lo1JJEXUS273wANn/pULCaAlQE9tJnal3WviWBxt0RQc6yulChQjnUAYg9fze8X5mJKTk2hLYGl+H87WupE2sPQP+BlhyJAMF+yyTJqhmKexRo57kiT16c2oUdg/H7PFeWO6aikVEXsvAjdFURBj92AUYq8AM/0lQA7u0p5r7N+K6F0SAEhes8H3zSvh7Ofur36NdjLnSM3p3PSarV9c/MVnhh9JGoqWEYkadnm2TyU69aLhyDZCe0ABTHELMFWVFIzPAWrrjukPMNuBux9OGG3+10yyazcNyWi9tfJYXdkyhZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7tfOXZy0vhWuPKP/a6L4kU1wPWW8WqAUBYHzthYoWE=;
 b=rsvdrAqOHezB2gWlMXELqv52bYxy22QEtUksnU8Z3hcb8ofssMNDhQDqPkwspibn/93eqrddKdBqRgpAIcGUQhwV8cKgQTPwNQVs4CdtYn/+AxFgIkah8UzeKzQHw0BPHgYJDhLfwCLg7xhBSYPJG2pZCGCBpUOtJljkQXHkLXHNjSf+AHPSBEa3lkMLpRkNBalMcwOlukDhAaKfpJnuPKIyNLeW6i2GTJhFZGHpRU92G93KkgrGi/ag0uTTSZ2kTmnFEvI09pSi7pzAS8UoVUZtNS4V0E1L9fEHVmrJnZX2bjZspWBmUcH56SxWakuI6N0QVA6UbDa22r9yocVg9A==
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PAXPR04MB8605.eurprd04.prod.outlook.com (2603:10a6:102:218::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 18:24:56 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::37d3:a796:d252:be6c]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::37d3:a796:d252:be6c%5]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 18:24:56 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v2 1/2] Rewrite fsx-linux test
Thread-Index: AQHaCyBkY/ijF8BXXECGSLe00Mmy1LBlR7AAgAAFZwCAHkF9gP///pSAgAAaUAg=
Date: Mon, 20 Nov 2023 18:24:56 +0000
Message-ID: <8024A023-F1A3-4723-8780-1BB5E623AD59@suse.com>
References: <20231030110107.4528-1-andrea.cervesato@suse.de>
 <20231030110107.4528-2-andrea.cervesato@suse.de>
 <20231101103420.GC884786@pevik> <ZUIuNMoMbu2gGApM@yuki>
 <a54b0968-fca8-49aa-91a2-4135e8bd231e@suse.com>
 <20231120165045.GA40415@pevik>
In-Reply-To: <20231120165045.GA40415@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB6797:EE_|PAXPR04MB8605:EE_
x-ms-office365-filtering-correlation-id: c7ad6ddb-1fdc-4c7c-9320-08dbe9f5ff6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rk4NjkcENN0JzEOD9DhYDud7lnoosBC/sB+QuKSBDL/77K/XY/j2MP7bl5g1W/bwWBPbY4+bnNauI/HvqqPff5NoteT99wNjvhr3X32cHgzuBIGwvgZtRgbPXfht9E03nGn9dJQYzAYK2BIh95nrfiE7vQjpk5/s7lY/BvpWFThoFM/s54zBWNUpxcyr3QoB5rdN7cXh1MiLHIZjXPB3E9u+h0R9upLAo/jdyvAtJBBblz2rDsI8onIoB43rSDt04H+Fi8zFIHXxkDjpavLMj/xEqb3qVEIRZCO5KgitR3XraB9NHYaQ6Whya6ERRoHiXljemQtoECGVA5o+UrSILli5f+usffjDEvqkFuFqwXNeqRZADMg3qe2MChaU6ea6JAheyncaj/lDSfKjo0gCbUXJMI9H9mhV4R6NMp9Akl/layhMQD+ja71RixTz1XKJvwOwxFiLO271M5onsHZHcE5DRbAIKsxHG0r4bSb1Ju+52tKbN1pokDBdrTBk2FJWEdxyI7AVmpFLY30kmMtnuGlokpDQ8AFrShxMggTseitGqNfmpp0yD2GGdW3uCp/0Z88qnw49F9PR+ig7I1w5+OmgvI+ABFJQYhTV626AHq0xGP6Rs7zU8a8APnjNooP01ua+/bxU2VSqM2aJNAj4Dg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(316002)(6916009)(66946007)(91956017)(54906003)(66476007)(64756008)(66556008)(76116006)(66446008)(36756003)(53546011)(6512007)(71200400001)(6506007)(2616005)(38070700009)(6486002)(966005)(478600001)(38100700002)(122000001)(83380400001)(33656002)(86362001)(44832011)(2906002)(5660300002)(8936002)(4326008)(8676002)(41300700001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU1TSStIRG9vc1lRcy95WU1rYUFJb3ZWZEhvUHNTNlcyS0EwRkRmakY4YTFu?=
 =?utf-8?B?R3NoZHU2OCtQTUpOSllxRHk3VU1nblN2Uk54RkZZMCtZNFdyeFcyZThSam9Q?=
 =?utf-8?B?SytqZlpaL2dVbldIZjdRSXZ2cTdRQW00ZWtjYVJaOGhGd1ZiMWRUNjU2VW94?=
 =?utf-8?B?dXZrUzBxRnVNQlBaRzJxendUQUJydUFaMUdRa2ZwL09lMnBzMXBUcjBKYitF?=
 =?utf-8?B?N2poOWJiUzFhNU1VZWRFM0xlOXNoR2g5YS9Bb1ljTFFLQW9PZFNwUFNscVZJ?=
 =?utf-8?B?Yi9kRll2Q3psSXpSY1Fqbkh2bVEySVI1RkIrK3RRR3lFUk5aZ1RHMUVPYnB0?=
 =?utf-8?B?UE04TDczUTNMTWlTQ2VTYmpIbXpxYU5iOFZkWXdvd3loZkczOEFUdHZrME93?=
 =?utf-8?B?QmhYeHNJL1U4SUIrQ1YxZUNyYzM1SmVqdlFHZExXMkxWczFxMnNlR1pSUm55?=
 =?utf-8?B?MmMvenVCalM1bXdOTmxxOERVQnVVaGs2SnNQQVF3SDhyUWd1cGhDWFJHMFdB?=
 =?utf-8?B?cW9FVmZRaWFGRWVST0FjU0xJdmpaNkFpN3V4SWxKZ2cvVUxld1QxdS81czFP?=
 =?utf-8?B?Nk1TbW1TY2ZqMXdaazlxTTBFayt1cHN6MlJ0VW1NN0RDQk91SHVlcHBWQS84?=
 =?utf-8?B?U1VGZTdQOEZpaUNlZTRqRUkvczArNHBXMlNVMGZVOU5SK1V2REVKMEpIanRo?=
 =?utf-8?B?OEIyekU0T0FTK1Ewa0ZOeG5zaUZ1N2E4ckVLVWRVTXErSUFKU1RENHVscWVF?=
 =?utf-8?B?MEtLR0NHSFBmZ0RXQ0U2Q0xCM0wzM0FSc2hMT2loKzFLcnVveU92MnFicTgr?=
 =?utf-8?B?UHN0ZE9yUWVpWnpoeGtvUjF4TUFIazVJWnc2djBNeTFORGNhWXV1Vy9YY3l5?=
 =?utf-8?B?OWFld0NGZTVnclRobnlOaXRSUCthMXdoWmgrOHMzeVY5bGJRWHdmckxjbzBS?=
 =?utf-8?B?TXJoUnljUHR1SWJnNDhWQ1F5T1IrNTd1Rjl5OXNHYWVGL0hDcVBwRVVOUXQ3?=
 =?utf-8?B?VHFwTjBFdXFMbXEzYUJRNnFxMVVHZ1pobHUvRXIrK29FRmFHNEJjWW5oaEhj?=
 =?utf-8?B?cHZxTXU3V1pFdzl4SlpWN2loZjNmVGtjODhqTk1jV1oxL0ttWVlacTQrSkJX?=
 =?utf-8?B?NkR5c2FGSjBPTmtNcnVLeHBtSU9LNXZBdTl3QWV1aEwwVGxZTjF4dW5VM1Y5?=
 =?utf-8?B?a0NYaStzMWtEd3pNR3VicmJ0b0hhaG9WdTlGekFva0o2UC92My84REZza2xF?=
 =?utf-8?B?ZGpvaUh6MTdZUXVMMUs2UG1KVHJWQ0hucGZua3VWOWpUQllOQkI0R0FoU1o1?=
 =?utf-8?B?ZGtCb2U3bnJramt5VVJtbXFjYVA4RDYvWFh1eVo2Q2lLa2RCdEFiNmpxZlM5?=
 =?utf-8?B?amhMT0tIckdwR1pCaG1ZdWNBWUpUdEV1Zmk4NlRoTHNaZGdJMWtMRk5xWE1o?=
 =?utf-8?B?UWZtSStnN3JPalFFVDhRc2E1S3NTY2t2MGlEVGxIMnBiU1FBYWFBWXBnRENx?=
 =?utf-8?B?T0hLM1VjaXFNMjVIWCtJWktiTFFxdUE5Z21kV0lIc1VuRUNmYkYvcjJ1THIw?=
 =?utf-8?B?enM3dUVKZE5QZVVlbjArd2tHaHN5OHgrRDJtaUxJcm0reUxaUll3dW9lQnQ3?=
 =?utf-8?B?cnZaWFJBbTBZNGhGbHRIb1NuQi9uZ1kvTmgyZnl4TFA0dlhNbThKQmhSbC9V?=
 =?utf-8?B?dlNZd2VTSkxkS01MK2JhUThZaVVUV2FNRW5nbzI5YlNnSXJ4dWR5eGYrS2tE?=
 =?utf-8?B?NkMwT3RvcmZCckd4N3ZZQSs2RVUrRUkwNUhtUTk1ckNsWnBKWU5Dd0Y2WGpp?=
 =?utf-8?B?a0RZVncxWmFhYlNGTUI3ZmhkSjJZQkFKZkt5UE43UmZRdVV0Ny9zSlJDR0tY?=
 =?utf-8?B?LzRSZXZWTXNVVG9hd2U5QmMrcllQYUVwam8zOUJtWWl5SW14M2VDV3d6Yzh4?=
 =?utf-8?B?aDhtSzZzMm5pNkNLUzRXeDZ1Ujd6YkN2aEdaZ1NORlZFMUpPRW43QzZjdzVn?=
 =?utf-8?B?ZjRoNGFnMHFjM00xZ1FYNlZjYWxTbDB2d0creWRWYVE3cVFuWGh0ck9IdjE1?=
 =?utf-8?B?czJ0V29TYzdHcUdTVXNZU3Y5WDBQYm5CRElXYm1NakVnZnRydTVRWjEzZS9T?=
 =?utf-8?B?L1dNTGFET2ZhdVBpNllPalpaVHJ4RGxhN1ZQbmRITnBsZDdPdmhiSkVIMmM5?=
 =?utf-8?Q?pKU2Sf2/60mugqGIF/Tsq/ZmmzG6ZWJ17oUIagxiNWm+?=
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ad6ddb-1fdc-4c7c-9320-08dbe9f5ff6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 18:24:56.4254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHorsI6oys5iVxR8YrEiSMoXxedkAeTaAzG3Crg9uwT0TsTEfLsvLkkcdUDUVREXUZccs/hGuMwjArrZjRQDCN807HEw2QC16GzQNhbhZcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8605
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Rewrite fsx-linux test
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwNCg0KPiBPbiAyMCBOb3YgMjAyMywgYXQgMTc6NTAsIFBldHIgVm9yZWwgPHB2b3Jl
bEBzdXNlLmN6PiB3cm90ZToNCj4gDQo+IO+7v0hpIEFuZHJlYSwNCj4gDQo+PiBIaSENCj4gDQo+
Pj4gT24gMTEvMS8yMyAxMTo1MywgQ3lyaWwgSHJ1YmlzIHdyb3RlOg0KPj4+IEhpIQ0KPj4+Pj4g
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9mc3gtbGludXgvZnN4LWxpbnV4LmMNCj4+Pj4+IEBA
IC0xLDEzNTMgKzEsMzkyIEBADQo+Pj4+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjAtb3ItbGF0ZXINCj4+Pj4+ICAvKg0KPj4+Pj4gICAqIENvcHlyaWdodCAoQykgMTk5MSwg
TmVYVCBDb21wdXRlciwgSW5jLiAgQWxsIFJpZ2h0cyBSZXNlcnZlcmQuDQo+Pj4+PiAtICogQ29w
eXJpZ2h0IChjKSAxOTk4LTIwMDEgQXBwbGUgQ29tcHV0ZXIsIEluYy4gQWxsIHJpZ2h0cyByZXNl
cnZlZC4NCj4+Pj4+IC0gKg0KPj4+Pj4gLSAqIEBBUFBMRV9MSUNFTlNFX0hFQURFUl9TVEFSVEAN
Cj4+Pj4+IC0gKg0KPj4+Pj4gLSAqIFRoZSBjb250ZW50cyBvZiB0aGlzIGZpbGUgY29uc3RpdHV0
ZSBPcmlnaW5hbCBDb2RlIGFzIGRlZmluZWQgaW4gYW5kDQo+Pj4+PiAtICogYXJlIHN1YmplY3Qg
dG8gdGhlIEFwcGxlIFB1YmxpYyBTb3VyY2UgTGljZW5zZSBWZXJzaW9uIDEuMSAodGhlDQo+Pj4+
PiAtICogIkxpY2Vuc2UiKS4gIFlvdSBtYXkgbm90IHVzZSB0aGlzIGZpbGUgZXhjZXB0IGluIGNv
bXBsaWFuY2Ugd2l0aCB0aGUNCj4+Pj4+IC0gKiBMaWNlbnNlLiAgUGxlYXNlIG9idGFpbiBhIGNv
cHkgb2YgdGhlIExpY2Vuc2UgYXQNCj4+Pj4+IC0gKiBodHRwOi8vd3d3LmFwcGxlLmNvbS9wdWJs
aWNzb3VyY2UgYW5kIHJlYWQgaXQgYmVmb3JlIHVzaW5nIHRoaXMgZmlsZS4NCj4+Pj4gSSB3b25k
ZXIgaWYgd2UgY2FuIHN3aXRjaCBmcm9tIEFQU0wtMS4xIHRvIEdQTC0yLjAtb3ItbGF0ZXINCj4+
Pj4gaHR0cHM6Ly9zcGR4Lm9yZy9saWNlbnNlcy9BUFNMLTEuMS5odG1sDQo+IA0KPj4+PiAiVGhp
cyBpcyBhIGNvbXBsZXRlIHJld3JpdGUgb2YgdGhlIG9sZCB0ZXN0LiIgbWF5IGp1c3RpZnkgdGhh
dC4NCj4+PiBUaGUgdGVzdCB3YXMgd3JpdHRlbiBmcm9tIHNjcmF0Y2ggYmFzZWQgbG9vc2VseSBv
biB3aGF0IHRoZSBvcmlnaW5hbA0KPj4+IHN0cmVzcyB0ZXN0IGRpZCwgc28gSSB3b3VsZCBzYXkg
dGhhdCB0aGUgbmV3IGxpY2Vuc2UgaXMgb2theS4NCj4gDQo+Pj4gQnV0IEkgc3VnZ2VzdGVkIGFk
ZGluZyAiQmFzZWQgb24gZnhzLmMgdGVzdCBieSBOZXh0IENvbXB1dGVyLCBJbmMuIg0KPj4+IGlu
c3RlYWQgb2YgdGhlIGNvcHlyaWdodCBsaW5lcywgc2luY2UgSSBzdXBwb3NlIHRoYXQgb25jZSB3
ZSBhZGQgdGhlc2UNCj4+PiBjb3B5cmlnaHRzIHdlIGhhdmUgdG8ga2VlcCB0aGUgb3JpZ2luYWwg
bGljZW5zZS4NCj4+IFRoaXMgaXMgZXhwbGFpbmVkIGluIHRoZSBkZXNjcmlwdGlvbi4NCj4gDQo+
IElmIHlvdSBtZWFuIHRoZSBjb21taXQgbWVzc2FnZSBkZXNjcmlwdGlvbiwgdGhhdCdzIElNSE8g
bm90IGVub3VnaC4NCj4gU3RhdGVtZW50cyBsaWtlIHRoaXMgYXJlIGFkZGVkIGludG8gdGhlIHNv
dXJjZSBjb2RlIGhlYWRlciBzbyB0aGF0IHBlb3BsZSB3aG8NCj4gZG93bmxvYWQgdGFyYmFsbHMg
c2VlIGl0IGFzIHdlbGwuDQo+IA0KDQpJIG1lYW50IHRoZSB0ZXN0IERlc2NyaXB0aW9uIHNlY3Rp
b24uDQoNCj4gS2luZCByZWdhcmRzLA0KPiBQZXRyDQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
