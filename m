Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBB0CD80AA
	for <ltp@archiver.kernel.org>; Tue, 10 Oct 2023 11:29:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79CCF3CD720
	for <ltp@archiver.kernel.org>; Tue, 10 Oct 2023 13:29:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9842D3C894D
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 13:28:54 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7B04160090C
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 13:28:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4kzIzO2To5BGi4RnkOTFswgmO1jpXjpm6Env/vBxNVqVnrolH25x7ub7Ybt3+5Atvewu12wS74gKpl97wBCoVyJ9rRD/XWP//FBy0hwNgRpFqat0MoEjlSv2hOAJk3tvudQoL6HNh+hAqBIFVrwkEIl2ynx87F7XmxigqfsPa7p5WRTBua03JaC5ENAUyreYM164RPxChsVA+zpCA7MYBIhPfC9Wrx8qVIYxxaeFz3JdSO/Dx6wYZqM7HIVzx+FRQfrLSVt6wjIM8XF5a8RR7nkJYG1DgwQfRDqrWW7xIYezS4x8+JjEV2pGk+0hfypkBRE8dIUDWmP6wFfRR8Idw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghBZVV6NBYA+o+UOnKghJgEj/CeqB9s27se42aFYOeU=;
 b=eZRk2Q57BYWcCeGomNR0lrlhTq/MDKGl97bnD8QTcNH8JNm/oTgYoLDyAXjlSdfcXKueFB2diHHZE3+Ugifn02kqQt+VA1O6NhcwvUwyrp0ICQRwZ6mwVVb0sUE7/U0cbw9WSxjIdmhGN5DLmOVj4x08/oFp4l8jyN3pyrzrWAUDswYk54YnLfPOjhOCUzHUpFE7CFaMnk7M0QcymewJGk8KviPnXksWE9GUpofc5khx7ETlMJoV2sOKewZnvomLOnoZrk0NqXZMQ+qqUri79z4goPyiY8DWZzylEogoMoyfg+3BwBVqN6vBOnfkAS1OwzXPjn3lOYce4yFghF+X3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghBZVV6NBYA+o+UOnKghJgEj/CeqB9s27se42aFYOeU=;
 b=Gegqyr040+cd8wd45KGVwU1Tt5Jla3D5iyfHQg6sbB0bcTCBxCDPU6SeL6/b0Bmep449AiW+5b5bRz9BVs75IjdQGPZ6et8NfPwf03/lKOpbpmdwwvzwRs75o27/m1fHDFUIDzBqe0Bsg4iN3q066kBOQXAf52Edd+Ikg/XaJWhImS0ug6vu6+cC6MepBtYYrOxDi3RKyjMez3H2LL9u+Kah/624edr5px5KmEHI+SalD9xt+spQ/nUoaax9YdJE5+54K8ZC3dxHNZd+mDMRK3KMt4wSuzED+8QJZNLSE1SbiwhLYrwHpXJHudBRRtPHIcWs+nub83zZ+XMgVzB1hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by VI1PR04MB7040.eurprd04.prod.outlook.com (2603:10a6:800:121::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 11:28:51 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4f58:e0be:dd19:58ed]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4f58:e0be:dd19:58ed%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 11:28:51 +0000
Message-ID: <28e07530-fb1f-4668-9e98-c2ec2a49433a@suse.com>
Date: Tue, 10 Oct 2023 13:28:49 +0200
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20230928104458.12115-1-rpalethorpe@suse.com>
Content-Language: en-US
In-Reply-To: <20230928104458.12115-1-rpalethorpe@suse.com>
X-ClientProxiedBy: FR4P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::10) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|VI1PR04MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca0fca7-8c4e-4371-2058-08dbc98413f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDfHRlN7Y27Ysi45toh5m4AMVLHSBe+In0zBovUD4qMBnLuVwr9erTDU/05oZL4uIB6iO+Ac2yBBvEyuF64dNfWsMw2k527FaZI1eJAnTEVI1s+a3rMJjMufPzcVHE2ZZiGERT4k1yG/7EuNCQu45vlnAZ/Omg2v0kDIwb8VUlleN8LgqzpFEgM33VE3lmrN78qGcaCrHL5u5CHL6mMZgOkGqsBOu9AWlFUpx8Cg+slyJBGvBoZt56E+ku8GwLDJc8S5seJ+zk8PNVxDx1bUJuv0o/Z8UgbDaYqubEsbVr4bNbTR25rF7K9j7uH2ZF7B+YvVNwTEGJ82Yzarv8jpJTRBagN9aOHld3VklcQGX/U3Z8tcXB4DR5GAJZo8mPFgNWeYCWP1p71RgX1rAI8ICuVtfFfc2+/mNpvl32EpF9BjivNnU1UpEm/yRMXT4iWORg5zq2U8GslrbreNrQTkkLvlyf0a4FrWMsDJME6YYW0VUTxz7d1zoC1jQ4ujpTMkGGtQSXe51o3YlSiV61sBRIg4iQNi78QivOD5cTjefXUeNq8N0cxXL8VHurzg66Vr6fOFWkZVp2laRDclye4XHlQv12BGJ0qpI1eg8BAjB3f11pQ3vcUUqerZ7vI04CuoNgsfCBJk+kVRbKq6GhPDwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(396003)(376002)(39850400004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(84970400001)(86362001)(31696002)(38100700002)(36756003)(31686004)(6512007)(6506007)(966005)(44832011)(478600001)(6486002)(2906002)(5660300002)(41300700001)(53546011)(8676002)(8936002)(2616005)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2JtekFMZVNsTllCazdyTVl0UEdKV2Z4ZU1uV0UzYnpvdVlqVzZSNmxGOXV2?=
 =?utf-8?B?aFhua3ZmZTQ3WFRWZm43ZWt5T3c2ZUNXd21uSVRJdklqOEo3T1VsY1h1ZUVk?=
 =?utf-8?B?K1NqcUxwOThCbDF6bGpZYldjU2RicjczeHVxQ0FDWTN4ZTBZcjRDYitCUEJx?=
 =?utf-8?B?Sklvbzhsb3Bsb0VvYkpyL0E5Ry9PU01tSzhVWkY4Q1hscCtuQWlmWUFENFcr?=
 =?utf-8?B?TnJIdWVPWFBFRXhIdzRoM045V2twUW9pY1N3K3hiN044b2RyNjE3S1UydzQv?=
 =?utf-8?B?WUtsNFR3QU9XeHNDU0ZMRTI2OHM0WkRXSmJxVUlsWEtPYXVzeHgyQ21QcVVx?=
 =?utf-8?B?aHAyTi9EQUdUaSt5T3hWVi9pVVhYTTF6eE9zSGZuYTRDSndBRXNQeGRVVHIv?=
 =?utf-8?B?ZUhvRjF2ZW1rT01rS1p4ZDIzZGFpOTdzT1RQZWU3OWlkVzhBNUdQZXB0U2l1?=
 =?utf-8?B?d2Q4ZGJ5UUZGVDhtZXF3NW5wYjB0TlF4WWFDY0dZd2tNcjhLZ3JkSmNVMDY5?=
 =?utf-8?B?cXl1ZHpiRWhnaFcrSGNjQzJ2UFhpSFJYOHBFczRCN0dwN2twNExqVEUyNVRG?=
 =?utf-8?B?VmQzRzc3SElsS2hIMEZBeDZZUTZzN0REUHVsN0I0L01VNGRYWlFReTNweXVX?=
 =?utf-8?B?MGRhS3pDSWdDK1RiYzZxWGFMajJaYUR0ZVVqZHRkQ0xZQ2xYTFZFbFZBdTRi?=
 =?utf-8?B?YnpMVnhZMGt2YW1ucFRqUTBhZDdpTHdzSGhUeFVQbjljbnZUSnYwaFl1WU1I?=
 =?utf-8?B?SDQ4WkNnYnUwYUlBTEFFdFo2czFEOFMwRFI1b1F0eGZsMXBlT1JHQmZCeldS?=
 =?utf-8?B?VGNrYWJVL0RoR1N2Y2FDSGNuRzFVRDRuT3BjKzQ2amU1MFhiRmdaVDFvZ2pG?=
 =?utf-8?B?SXBkdDdlZTVrOEJJdTBGVERmc0JoMlQvSU5qaEVKNXR2aVV2YnVHK2owaG5p?=
 =?utf-8?B?YVpTODNiSlA3cVZoWEVGeFdxRmxSMmdJbTJ0aVlQRHlaWnc4ZGc3YlErdGVW?=
 =?utf-8?B?QVRkRldBc2I3b2xIb2RZakpXUmhSNVlqRWViNXhzeVRFY2lmekNucE1TZ2Zu?=
 =?utf-8?B?eWNuTjRsNklMRXlUeGV3c010YXQ3eEJiTGZ0SDZGaGFNd0IvWXVVUTZWYXk5?=
 =?utf-8?B?WExhMHFnaUZaV1RoTVVxeDNtTjcvYzUxL09DMUN0RmlwbnA4dGc1am8rQXpP?=
 =?utf-8?B?aFM4YU05b0VSK1h1OVp6M3hSQWtZcC9sMTA3ZlhseFBGU0I1K0EyK2RKN3FK?=
 =?utf-8?B?Q210YkZCSi93S0tSNTNZSlBnRzI3ZFpvZFNZcnBGUWRIeEt6ZXBlbjJSNjZi?=
 =?utf-8?B?YUFodlZwT1Zld2dsQ0QwZWFQNXdpM0s0TnhQUi9vYXpHbjdxZFF5RTNqekdT?=
 =?utf-8?B?MGQzUFhKR09lZDRId2RlZFA4R0hZeXZic2ZSeFRoYVF5V2h4NkRIaE9EVEJV?=
 =?utf-8?B?b3UzVGlWYnNQR2Qzc3ZIK3ZNa1hPUy9saGZnUGY4cDBpeHpxekswVHhXOE14?=
 =?utf-8?B?OXlwR202YmpnR2QwWSsvVW9SMkpDbEpIN05XZGVTUDF3TG5jQnBTMEF4RStz?=
 =?utf-8?B?RHg3RUI4ZGVtQk5yVndtUEFnWWc3Rk1CZWdsaTNIdWpocXVtd2hqYU95NzFt?=
 =?utf-8?B?UXpmWWxZZUw5bHZtSzR6MFgzcXZ1YlB3eC9YaGpjRVE1K3QrMXY2a25keTlZ?=
 =?utf-8?B?RU0rOS9hWVYvMlFCZVMxUFNHT0xCd2xEc3VkZEQyeXFMZGV0MHdNT3gzMWNh?=
 =?utf-8?B?ZGE3WCtHSnBGbmtkaDBNNVVXRUF3UkFNN2FuTjIxVDB0ZU9HQnlpWWt0ZUla?=
 =?utf-8?B?OHpLRms4OFJRWmtRU01LRXo3a0N0NlE1aGtvUVRFSnBtUEdteDIzQnlaVFlI?=
 =?utf-8?B?UFF5VjZXVHJHczZFbVJ2SkdSWDFzdXZTTmVqTXVVejRIU2FjTWx6cFc3MmRz?=
 =?utf-8?B?MUVYSGx2UEtKblBKVGdQRDRsM3pIQjhubXZlUGhtRGxSTXZVNDdMNEI3STQ3?=
 =?utf-8?B?aWY3RWFFdG1YVjZPandHb3dGcEJhSlJNRGJ2Mk9KZmd3VHlkM0ZERDAzSDhq?=
 =?utf-8?B?ZFppenkrRU80aWxCeXdwbnB2MmJwL1crTVducWNOR0JNWlV6Q1hXV0xQK0xj?=
 =?utf-8?B?M3hWZThCTEtJS0V3ajE1SE53ZmVZK3VpWFhkVTdqczVmbFAweTBxTC84WWxt?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca0fca7-8c4e-4371-2058-08dbc98413f6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 11:28:51.4894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIiqQFz1/3WslYPGBD4L7mU7jDn3tFID+lg38aQ0JcoM5ZOOGvcYzV+b2jGPMbRf6mophzrOShL1YxcRILRJ1Wvrr5oiH7HIGuFqmQjZCzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7040
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add simple Containerfile
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

thanks for this patch. It's really useful.

Regards,
Andrea Cervesato

On 9/28/23 12:44, Richard Palethorpe via ltp wrote:
> This adds a regular container (or Docker) file which builds LTP from
> source. This is initially intended for testing the LTP itself.
>
> The resulting container has just the LTP installation and runtime
> dependencies. However it is still quite large, probably due to debug
> symbols.
>
> The container can be built with a command like:
>
> podman build -t tumbleweed/ltp \
>         --build-arg PREFIX=registry.opensuse.org/opensuse/ \
>         --build-arg DISTRO_NAME=tumbleweed \
>         --build-arg DISTRO_RELEASE=20230925 .
>
> Or just
>
> podman build -t alpine/ltp .
>
> It contains Kirk in /opt/kirk. So
>
> cd /opt/kirk && ./kirk -f ltp -r syscalls
>
> will run some tests.
>
> Note a much smaller container can be found at:
> https://registry.opensuse.org/cgi-bin/cooverview?srch_term=project%3D%5Ebenchmark+container%3D.*
> This is created with SUSE's build system which does not use container files
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Cc: Petr Vorel <pvorel@suse.cz>
> Cc: Marius Kittler <mkittler@suse.de>
> ---
>
> RFC comments:
>      * Add git clean -fdX which should remove any build artifacts
>        this is different from the suggestion of just doing a check. I just
>        found it easier to remove the build files.
>      * Added seperate alpine and tumbleweed runtime scripts. Again it's
>        different from the suggestion just because it's easier to add
>        seperate scripts than adding a switch
>      * Obviously a number of distros are missing runtime scripts. They can
>        be added when someone is motivated to do so.
>
>   .dockerignore            |  1 +
>   Containerfile            | 32 ++++++++++++++++++++++++++++++++
>   ci/alpine-runtime.sh     | 16 ++++++++++++++++
>   ci/tumbleweed-runtime.sh | 13 +++++++++++++
>   4 files changed, 62 insertions(+)
>   create mode 100644 .dockerignore
>   create mode 100644 Containerfile
>   create mode 100755 ci/alpine-runtime.sh
>   create mode 100755 ci/tumbleweed-runtime.sh
>
> diff --git a/.dockerignore b/.dockerignore
> new file mode 100644
> index 000000000..bbcd7072f
> --- /dev/null
> +++ b/.dockerignore
> @@ -0,0 +1 @@
> +Containerfile
> diff --git a/Containerfile b/Containerfile
> new file mode 100644
> index 000000000..2f8192c3b
> --- /dev/null
> +++ b/Containerfile
> @@ -0,0 +1,32 @@
> +ARG PREFIX=docker.io/
> +ARG DISTRO_NAME=alpine
> +ARG DISTRO_RELEASE=3.18
> +
> +FROM $PREFIX$DISTRO_NAME:$DISTRO_RELEASE AS build
> +ARG LTPROOT=/opt/ltp
> +ARG DISTRO_NAME=alpine
> +ARG DISTRO_RELEASE=3.18
> +
> +RUN mkdir /build
> +WORKDIR /build
> +COPY . /build
> +RUN ./ci/${DISTRO_NAME}.sh
> +RUN git clean -fdX
> +RUN ./build.sh -p $LTPROOT -i
> +
> +FROM $PREFIX$DISTRO_NAME:$DISTRO_RELEASE
> +ARG LTPROOT=/opt/ltp
> +ARG KIRKROOT=/opt/kirk
> +ARG DISTRO_NAME=alpine
> +
> +COPY --from=build /build/ci/${DISTRO_NAME}-runtime.sh $LTPROOT/runtime-deps.sh
> +RUN $LTPROOT/runtime-deps.sh
> +
> +COPY --from=build $LTPROOT $LTPROOT
> +ENV LTPROOT=$LTPROOT
> +ENV PATH=$LTPROOT/testcases/bin:$LTPROOT/bin:$PATH
> +
> +RUN mkdir -p $KIRKROOT
> +COPY --from=build /build/tools/kirk $KIRKROOT
> +
> +USER ltp
> diff --git a/ci/alpine-runtime.sh b/ci/alpine-runtime.sh
> new file mode 100755
> index 000000000..e4941f329
> --- /dev/null
> +++ b/ci/alpine-runtime.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh -eux
> +
> +apk add \
> +        acl \
> +        keyutils \
> +        libaio \
> +        libacl \
> +        libcap \
> +        libselinux \
> +        libsepol \
> +        libtirpc \
> +        numactl \
> +        openssl \
> +        py3-msgpack
> +
> +adduser -D -g "Unprivileged LTP user" ltp
> diff --git a/ci/tumbleweed-runtime.sh b/ci/tumbleweed-runtime.sh
> new file mode 100755
> index 000000000..5207988e7
> --- /dev/null
> +++ b/ci/tumbleweed-runtime.sh
> @@ -0,0 +1,13 @@
> +#!/bin/sh -eux
> +
> +zyp="zypper --non-interactive install --force-resolution --no-recommends"
> +
> +$zyp \
> +	iproute2 \
> +	keyutils \
> +	libaio1 \
> +	libmnl0 \
> +	libnuma1 \
> +	libtirpc3
> +
> +useradd ltp



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
