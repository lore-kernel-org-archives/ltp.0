Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74303C54FB9
	for <ltp@archiver.kernel.org>; Mon, 20 Nov 2023 11:13:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A3373CE1C3
	for <ltp@archiver.kernel.org>; Mon, 20 Nov 2023 12:13:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A5213CC1F1
 for <ltp@lists.linux.it>; Mon, 20 Nov 2023 12:13:46 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 84F2C6014F5
 for <ltp@lists.linux.it>; Mon, 20 Nov 2023 12:13:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700478823; x=1701083623; i=deller@gmx.de;
 bh=EQZ1hqa9HEEVc6Y77oIKm2b2N64X6rr4ERstmS+TRww=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=Zkl+YyaYyH1TFDWG0a80PAbu9kU7Xq5+i3dsB7QUJmoCGXt5Q7LtJPISHueM9VTG
 qwwvpoUISP+hPxB2mE8q7qBudu5KV6j1uS7UaIjxzDBJlyYC33i2ScW3TxZEah9z8
 gUmaJwv5gyvoI3v28gSsMC5+4gRq7JzPnAIaI9u4nd3wj65ii4YplgQNIly27D5iC
 QQ450ND6NusQn4d2se9EzdZRI+FvIgvreAjTdRt4xdRJCl6I2EA445BsjlduYaGbC
 HIpih/7WqGDqJtjatbr8/MehxA87FKjFBC07jRRBoheHaCB/8yx9pwfsBeVnw1XCk
 n8Zx61LD/aicZGbpig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.10]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6e4-1rYHyD1mKE-00hfZw; Mon, 20
 Nov 2023 12:13:43 +0100
Message-ID: <3b638b9e-6269-459d-bcc8-2bad7b538de1@gmx.de>
Date: Mon, 20 Nov 2023 12:13:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Li Wang <liwang@redhat.com>, LTP List <ltp@lists.linux.it>
References: <CAEemH2dJyfhEg4opn3v1c_P1Ewao+s33_PzoVMyP0siEy+0cxA@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAEemH2dJyfhEg4opn3v1c_P1Ewao+s33_PzoVMyP0siEy+0cxA@mail.gmail.com>
X-Provags-ID: V03:K1:K7KswcHeByJuWM4torNj+1rtxoPy2t9CYdmwGEYrNdThXoL8Tm9
 kuBMTQi6J5JOSNHPwW2j0oKshMzwXWy8OjhKwfAp2TKBhbaPo0P1v9Mxu7mP/0HXF6cyAia
 SrqyYWHSkhVUvWfuCYNzw1dANWWCehu8qHsI8FYZgj1ENNOFX5U+1xdcopGQIAcJkbRTHS9
 m7rqghaVfqmFXq/VAQ23w==
UI-OutboundReport: notjunk:1;M01:P0:nVx0yotCupU=;yTyw/jTL6uJ0zSfysDQnDt/TcTg
 NpjdHFgQIFEuTkWrN5h6XfFbR7IB8t6OPgZUXdWGO/2QySP/7FjW9NV6RjCpuLkYKH4gu9Pgc
 1JaK4sSAylutdeXUaYLAYo4fldNcd3onzAGQzIqTXKCRrM1V/4B2CCAmBc+J5PvTa35sMcJzy
 oeyhJD7JAjEhB5+yiZqdEwC7G2MT4qMn387H695QCVKQ1qt8VEJQ+mdG9Qyi6qv49O0c+AVi3
 RkDjAqv53QGw+8p26WPVNPcmttZztCoi0NkX+yC+LGpjly4sGHiOqcAnXNVG2QZZeaoyIjlUa
 mLJCxb7ZvJ/R4j1lRZrHLXiFKKh0Ici0xnxs1Q2LgiNc6SQIVuCMrlhjmhX0jABJwSo1vaBb4
 kvKN/iSn9QMfzeW2zetVlFybv8RaMrzRVo0vthpfBdgDuNFBAPP5HcnBXT/JnDNNQgYaYbdCe
 gihLJ+TgibScOm/DUq4L0GurBiEUjKksh324SssS0UfodenXMCWHPao1joR0Oybjp6tu8L/g/
 GsuSGVXPtPQBWfKxbPl7c7AzwSVzlyWrf/RqHJuK+3vU37TsyrX/cLOjOK8wUz3qjk8S6BTwj
 4v+N688F2+f1UHrNBN+wJq6CCT/6AaMRp0EGuwENe17VB85P4JH9wCUDMve99RtvQIqEbqdRy
 RjK2FCASr8hgZxDiRhwaewrNMtwwXdVQz6+MScj4TAiDJSuXoviD/YgE2qwSMaWZcarX/RF7v
 eNp5XbtiKwDwrJmr0fOoHZukFpp5/vcqG/uBegiW3bn4UQDMCJfLipGKgcG7QL1gBHKb4Yx5z
 M54rJFRsbPF9CaazgNiBBPQTWm+35jaJf8wlzvClrxFY2GfEDBrdjSEToZ8uyIZ0lMxIzVzBy
 B1xugwW+l0lWWGEJGdmTtjWeQrsWvgJYK0jUFkHFIKqQ0lE3dr4be4y94pxsmk7Ks8KR66nbb
 9UGFYOMUgwG4wa6zpusojhUOGGY=
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Cleanup IA-64 related code?
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 11/20/23 09:11, Li Wang wrote:
> Hi all,
>
> I noticed that the mainline kernel is declaring to dropp support for
> Itanium IA-64, actually, the commit[1] has been merged in v6.7-rc2.
>
> I am now thinking should we do the same action for LTP in the
> main branch to keep consistent with the mainline kernel?

Upstream kernel dropped IA-64 for future releases, but it's still being
used the next few years with existing kernels, machines and distributions,
so I suggest to not *pro-actively* dropping existing code yet.
E.g. it's still supported on debian until end of the current debian releases.

Just my 2c.

Helge


> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cf8e8658100d4eae80ce9b21f7a81cb024dd5057
>
> [liwang@liwang-workstation ltp]$$ git grep __ia64__
> include/lapi/rt_sigaction.h:#if !defined(__ia64__) && !defined(__alpha__)
> && !defined(__hppa__) && !defined(__mips__)
> lib/cloner.c:#if defined(__ia64__)
> lib/cloner.c: *   2. __ia64__ takes bottom of stack and uses clone2
> lib/cloner.c:#if defined(__ia64__)
> lib/tst_arch.c:#elif defined(__ia64__)
> testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c:#ifdef __ia64__
> testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c:#elif defined(__ia64__)
> testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c:#if defined(__powerpc__)
> || defined(__powerpc64__) || defined(__ia64__) || \
> testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c:#if defined(__powerpc__)
> || defined(__powerpc64__) || defined(__ia64__) || \
> testcases/kernel/mem/shmt/shmt09.c:#ifdef __ia64__
> testcases/kernel/mem/shmt/shmt09.c:#if defined (__ia64__) ||
> defined(__mips__) || defined(__hppa__) || defined(__arm__) ||
> defined(__aarch64__)
> testcases/kernel/sched/cfs-scheduler/hackbench.c:#ifndef __ia64__
> testcases/kernel/syscalls/mmap/mmap03.c:#if defined(__ia64__) ||
> defined(__hppa__) || defined(__mips__)
> testcases/kernel/syscalls/mmap/mmap15.c:#ifdef __ia64__
> testcases/kernel/syscalls/ptrace/ptrace.h:#ifdef __ia64__ /* what a pos */
> testcases/misc/crash/crash02.c:#if defined(__ia64__)
> testcases/misc/crash/crash02.c:#endif /* __ia64__ */
>
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
