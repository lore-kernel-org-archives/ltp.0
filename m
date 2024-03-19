Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBCCC54E60
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 08:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1710835617; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=hTx+7CpoiFqAUjC56PponzPMQ2Z+Aow7Wvkn5WCIkKE=;
 b=RRosNseddWYIlyqEjdBvELBOZhnjtqR36YXGRtL3I89iGv7r7vUP2j2xYOgEAi00XmqBj
 6LYs+U9+KLa5Rd+iB2K3qeQ/wRD1zXwfTUHhxJmN1nU7NzvM0hYAt1XSf7PgNIFaaXyRUPT
 71wWy4GA8dBlC1x9A5Hes5vHbwWnfzY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 124383CE6CD
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 09:06:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C65D23CB37F
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 09:06:36 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E107A200761
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 09:06:35 +0100 (CET)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a44f2d894b7so609435966b.1
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 01:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710835595; x=1711440395; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jiO2N/4FwCp8AqRn/rSSGxyNHHcvJH6nJNomsOlw968=;
 b=QwRnBe78DfCOdd7zF6Nj0vTsw8NlAC6TiCAKQPbwHR6ms3grPF7BEPQrF1w1YbPIyd
 tZFv20ue2pGJPPV5M1VE4vCud0F5jB0DUIUbH8JGRr8rxyUmHjz8fvXh53gqaSA5aEeV
 4zKf150qDPGhidW93zfhdSGD4pnlejfFK1ksjN9YhxArb7mSjtiQXvmVslFCi0R3j1hG
 OpRCHM6kZfLtJPNMfQeo5rWnlnHlNTOfQzWvR07VYuNr70j7WksLrEnrml/e0NUF97lx
 m/vtNBRmST/CzKkF3DbEkNUqSApnMRUgDQp8FtDVXmEgF6ozUJ0qbq0kd/6Pfc8kWrVz
 qC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710835595; x=1711440395;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jiO2N/4FwCp8AqRn/rSSGxyNHHcvJH6nJNomsOlw968=;
 b=ZjAwSyuV62k00BG/e+STYlFJ8Av21YXVkAmClmSr6cbjtj/alKwtEDCqIxZP6xJ0ce
 ytfALNJ8sIn8ctbbbMd4Z1OAVR6wwF/UgIziai7yA+dm2RNbxO9B9EnMKNN9/Mo2mq0+
 0Gum1cnQ+o/iEUAq8s5ErD3+YavXeuSTodhFsMDGnXYxP2ab5BABjexJQ2X9Sec7N8IM
 Y4Nx2rvJ1uyUOaOwDnRllwX4yoD7H+2N3i1wk8vxGXO2Ao/CEpQUGr/DWGoFYAGUSUWO
 eyWq/sPjNnt1QU4SwjuOrZ4NOatrU4OhUNCzn9y40l4AujLXs9uhIEMNolTsFL3bp7ED
 UY6w==
X-Gm-Message-State: AOJu0YyzszCSQ+cdnn+Q1BQ9OtoNv1DRKVh6kwJ6oESSnpY2BBGiEolD
 msPtVS0rk5GtSzB9xdnifiGadHJ+NXsZ5NXhirE8B+tZ6f2k70+rdxt9KtThtlzt8QGhV116tV1
 fXMw=
X-Google-Smtp-Source: AGHT+IECQiw0sOKyTvTkEiQX+1DSCSOnMLdqjh3bvrk/igYjYLnhrOcjApfdoZrtWMVPBmsp+GbfdQ==
X-Received: by 2002:a17:907:2d21:b0:a43:bf25:989 with SMTP id
 gs33-20020a1709072d2100b00a43bf250989mr13051553ejc.9.1710835595262; 
 Tue, 19 Mar 2024 01:06:35 -0700 (PDT)
Received: from [10.232.133.97] ([88.128.88.102])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170906260c00b00a457a55b814sm5805341ejc.73.2024.03.19.01.06.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 01:06:35 -0700 (PDT)
Message-ID: <29f9b68f-0c7a-476c-8a11-4e339190f081@suse.com>
Date: Tue, 19 Mar 2024 09:06:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <6868ae95-b004-4fb2-8aac-7ccf96b32f90@suse.com>
 <20240318170107.GC408613@pevik>
In-Reply-To: <20240318170107.GC408613@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] New LTP documentation!
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 3/18/24 18:01, Petr Vorel wrote:
> Hi Andrea, all,
>
> First, thank you for doing this POC.
>
>> Hello everyone,
>> as already mentioned in the monthly LTP meeting, Linux Test Project lacks of
>> a nice and clean documentation that can be easily accessed by users,
>> developers and maintainers.
> This was from the start confusing for me, because we have docs in wiki and
> metadata documentation. But the text below explains the main advantage :).
>
>> The current LTP documentation is also not matching with our expectancy
>> towards the entire project, which is has been heavily refactored and it has
>> changed in the past years, providing a higher quality code and new testing
>> features.
>> For this reasons, we think it's time to move forward and to start working on
>> documentation, helping people to use, to develop and to maintain LTP in an
>> easier way, increasing quality of the overall project and to call more
>> developers in the community.
>> I started to work on documentation refactoring, re-organizing the overall
>> structure. The first prototype can be found here:
>> https://ltp-acerv.readthedocs.io/en/latest/index.html
> +1, nice POC. I see from your github LTP fork it's generated via
> .readthedocs.yml - +1 for docs sources staying in LTP main repository and
> generated as a result of simple push.
>
> I wonder what to make with our static page:
>
> https://linux-test-project.github.io/
>
> Could we somehow redirect it to our github URL or to docs on readthedocs.io?
I don't think it's possible. One it's meant to be github pages while 
readthedocs is hosted somewhere else in https://readthedocs.org/
>> The idea is to move documents from the current asciidoc format to RST
>> format, following the current kernel docs guide lines [1], and to move API
>> headers descriptions from regular C comments to Doxygen format.
> IMHO library docs generated with Doxygen is IMHO the main advantage.
>
>> By using the powerful readthedocs service [2], it's possible to deploy a
>> documentation website with one simple setup, using Sphinx [3] as the main
>> documentation framework.
> Maybe, we could later generate our metadata docs with Sphinx. To have single
> source
>
> Although markdown is supported elsewhere (if we one day want to migrate e.g. to
> gitlab), using readthedocs.
As far as I know, both github and gitlab support RST and the idea is to 
rewrite README as well, because it contains multiple errors and it will 
be replaced by index.rst
>> For now, website prototype is showing a couple of pages, but the overall
>> structure is there and ready to be filled.
>> The purpose of this email is to ask for feedback and ideas from the LTP
>> community, so we can make documentation even better. Let me know what you
>> think.
> +1
>
> I hope you plan to do the conversion and plan in the future to add Doxygen
> generated docs (to actually add more content than what we have now with github
> wiki).
Yes, we will use Doxygen. It will come in a second phase, after 
refactoring the whole documentation into RST.
>
> Kind regards,
> Petr
>
>> Have a good day,
>> Andrea Cervesato
>
>> [1] https://docs.kernel.org/doc-guide/sphinx.html#writing-documentation
>> [2] https://about.readthedocs.com/?ref=readthedocs.com
>> [3] https://www.sphinx-doc.org/en/master

I also forgot to mention that Sphinx is highly customizable due to the 
python scripting, so we can generate static pages at build time, 
introducing (for example) versions release letters and many other things.

Best regards,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
