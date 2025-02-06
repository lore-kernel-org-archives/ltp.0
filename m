Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D7BC02196
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738828331; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=qqyYoyrxp5hdiYS3kMyuSCCdqip0EVYn01GMemQL34U=;
 b=GPVyEByJ7yMHo+SyXQGD2dCvxvNsZu8DBtJ8m+O6wCLOTKAXJsqLxE1s9hEw2l8VJk3TU
 VztZD4PAD/OiIp5R++NCXQYkob4Um+qnbXYvqp4g6zStsN8n2BPgF5O8fvvBQ84jEiQofBt
 ra1ePyOHW6X0EbUNKWVuM+crwYE/ryQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DE243C4CF0
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 08:52:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 579413C0387
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 08:51:48 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 07AC0234675
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 08:51:48 +0100 (CET)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so6369825e9.1
 for <ltp@lists.linux.it>; Wed, 05 Feb 2025 23:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738828307; x=1739433107; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SzHLUA4+wfg0YTFc5LHRzSNVLyTxEuMF7AmG83hFbc0=;
 b=EAOnnqfnNwua8YoG8SbFL90QocUb/gB0C5FTBXsuhJeZS/NKz6m1zx/gQQ4FtR7blw
 DlfchHwxSZEm69woL9gHr9NlS4yRJoC/0aaDjz2oeWxk687QnuMgLizV5MHEPHcqSxD8
 dAVs5Xt3skA56LdO6KkiLhC5ZSd8e02ZXVtaXXYRXKBTbJIX4gciHnXfiCaeC99eOZe1
 o2tIEnCBiGEA3UZOTIfrCuCHmEQMwKk3UcZ1cak63x46ucL3ofZuyo4lz9AMV191EumL
 DVQlIQRMUabeoAehllQRseRb3VowOd3xLZhlDAve53Gcfqhs2JM/UISzTZ8VT94bBsJZ
 soPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738828307; x=1739433107;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SzHLUA4+wfg0YTFc5LHRzSNVLyTxEuMF7AmG83hFbc0=;
 b=cejhPm3YWviWiLlFi3RJRU767Uy6f6McJXBmWgKY2nGENHMqs4bpFSOjJmCnxOUbJ6
 2HbyKqJECTnYz4180Q4KSm7THzudzqXDYATlpA0amCnhFXQ7yivZFkGnhELUpz+LYIXO
 3koUP/urxEZ2oCcT0/OXkiGlpKk+iGHFOlqcsJ/Jv0Vz/Ba+APx9oDnLuH05bXHLA/59
 c3vEpO5+iZLoTk2xi1/1WoE3TIJNfGDL9vh6+47mSeFFKRMelbjG1J86x8PJA71nM1oO
 dul8izBIJySsFEQZpbWtTwJV1ZlQnfwvbpFbZYEkxyhSDtPO/jvjeLv4/F9cQO/DDxBm
 T+bw==
X-Gm-Message-State: AOJu0Ywj9yDuq495L6MZzUdYi4Ezj50+DubekgZZWNDASjnGsxKWmxrD
 b/fab7TTEEN2dM6E1+kt8ZmcdPSrkEJwAIuihL/M2NPfOLMD66kSuwG1FhiJNxs=
X-Gm-Gg: ASbGnctZTYFhNCE81m66BT913sFnXHgB6sKVTmy6O03q6LdWsaH5PeD1omAApTR+c0D
 QyRW8vBsEZSrvAw4au6JTvqxbNUGyHgTCvly4DbCtMBXgH7jT4jLvk1FuFl9VIhkjkUmkgjgDQC
 Zo+XVThQf84UJw+BzfX+Fr0P94JxpOdv3aXiBIG84dUCa06XV2dnWeQf4hyQXooPUmPPAwsAfEK
 v1ztEnFzhD4j03pRZnufTbIUgg88MFtQhvuom9jjk8q0mFAJSDx1yoBQ2F9z8KB6zJzZNUbEJ9s
 jia5bERrX7elIcqL1RvRMWChQJ1SbCrfPQxT8k31Kn55FqiOVidiFIn8NNNy5sPH3KZuuxQYPXf
 AiSj5Db5CDNm7DytkZ97KMNxzNyQF0cHN4zDqklry/RqSfXCKUUI=
X-Google-Smtp-Source: AGHT+IFKno0WKiONvP1sQLglAoJwwltvNgSBYzhjwBdaLiOYZ8ZdkFo7ogKXGxS/sOODdKsqnwYkKw==
X-Received: by 2002:a05:600c:4f05:b0:434:f586:753c with SMTP id
 5b1f17b1804b1-4390d434cb0mr47201595e9.7.1738828307342; 
 Wed, 05 Feb 2025 23:51:47 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dc9ff10sm10470695e9.12.2025.02.05.23.51.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 23:51:47 -0800 (PST)
Message-ID: <e4725e7a-5c5e-44b2-951e-e6a9faadd5ee@suse.com>
Date: Thu, 6 Feb 2025 08:51:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250205-doc_tests_list-v4-1-ae46e56073bb@suse.com>
 <20250205232049.GA1528001@pevik>
Content-Language: en-US
In-Reply-To: <20250205232049.GA1528001@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] doc: add tests catalog page
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 2/6/25 00:20, Petr Vorel wrote:
> Hi Andrea,
>
> generally LGTM, thanks for working on it.
>
> 1) clickable (referenced) keys
>
> I asked keys (e.g. needs_root) to be referenced to be clickable to the
> relevant API.  This allows reader to click and read relevant info about the key.
We can't do it because tst_test struct parsing does not generate a 
reference for the attributes, but only for the entire struct.
Maybe there's a sphinx configuration somewhere, but I have no idea, we 
should read documentation. This should be done by a followup patch.
> 2) git commit description of referenced tags
>
> Perl code was able to take git description.  E.g. instead of plain "d2f007dbe7e4"
> it got:
> d2f007dbe7e4 ("userns: also map extents in the reverse map to kernel IDs")
>
> I understand you don't want to bother with it, but it was more descriptive.
> I guess using github API or simple fetching web page on git.kernel.org and
> take content of "commit-subject" would work, but it'd be slow and we could hit
> some access limits from the provider. I can have look into this afterwards (I
> don't want to block this issue).
I seen that, but it's really too slow and I'm not sure if it provides a 
big help honestly. It's a "nice to have" but slow feature that can be 
resolved with 1 click more on the git commit hash. Feel free to try 
adding it after this patch has been merged, but my impression was 
negative, due to the fact network was having issues (timeouts, slow 
website, etc).
> 3) CSS fix of some tables
>
> Code on tables with keys and values (e.g. needs_kconfigs) looks ugly, when there
> are more items.  E.g. needs_kconfigs at icmp_rate_limit01, which has:
> CONFIG_VETH
> CONFIG_USER_NS=y
> CONFIG_NET_NS=y
>
> The ugly part is margin-bottom: 24px; from class="line-block".
> Single item line uses <p></p>.
>
> I looked into docs (https://tables-with-sphinx.readthedocs.io/en/latest/),
> but than I realized it's a simple CSS issue. It can be fixed by adding
> into doc/_static/custom.css:
>
> /* remove margin for multiline cells */
> .rst-content table td div.line-block {
>      margin-bottom: 0;
> }
>
> I can send it as a separate patch if you don't want to bother with it.
I can add that, thanks for checking.
>
>> +def _generate_tags_table(tags):
>> +    """
>> +    Generate the tags table from tags hash.
>> +    """
> nit: conf.py is getting slightly big. I need to remember that public functions
> are these which generates stats.html and test_catalog.html. Maybe having
> functions or setup() which references them on the top would help reader to start
> with relevant code.
> ...
If you mean to move small functions on top, that can be done easily. At 
the moment, I only see the syscall table generator function being a bit 
long. The test catalog generator function is already splitting it into 
multiple functions and it's pretty easy to read.
>> +def _generate_setup_table(keys):
>> +    """
>> +    Generate the table with test setup configuration.
>> +    """
>> +    exclude = [
> This list is slightly confusing for a reader. I would expect there will be no
> options in generated docs nor tags. Obviously they are processed separately.
We can add a comment.
>
>> +        'child_needs_reinit',
>> +        'needs_checkpoints',
>> +        'resource_files',
> Maybe add this? e.g. creat07 requires also creat07_child. That might be useful
> for somebody to see that test needs another LTP binary.
>
>> +        'save_restore',
> This is useful, it shows which /proc/sys files are touched.
>
>> +        'forks_child',
>> +        'hugepages',
> I know that these are cryptic:
> .hugepages = {1, TST_NEEDS},
> .hugepages = {TST_NO_HUGEPAGES},
> but trying to filter out info may cause people prefer using 'git grep' sources
> instead of searching in 'ctrl+F' in this nice documentation.
>
>> +        'options',
>> +        'timeout',
>> +        'runtime',
> Cyril already asked for runtime, IMHO important to have.
It has been moved in the timeout text. No need have it in the table as well.
>
>> +        'ulimit',
> Also ulimit is useful.
>
>
>> +        'fname',
>> +        'tags',
>> +        'doc',
>> +    ]
> ...
>> +def generate_test_catalog(_):
>> +    """
>> +    Generate the test catalog from ltp.json metadata file.
>> +    """
>> +    output = '_static/tests.rst'
>> +    metadata_file = '../metadata/ltp.json'
>> +    text = [
>> +        '.. warning::',
>> +        '    The following catalog has been generated using LTP metadata',
>> +        '    which is including only tests using the new :ref:`LTP C API`.',
>> +        '    For this reason, some old tests might be missing from the list.',
> Besides the fact that *all* tests using legacy API are skipped I don't think
> user is interested why they aren't included. I would just note that only tests
> which use new :ref:`LTP C API` are here listed.
>
>> +        ''
>> +    ]
>> +
>> +    metadata = None
>> +    with open(metadata_file, 'r', encoding='utf-8') as data:
>> +        metadata = json.load(data)
>> +
>> +    timeout_def = metadata['defaults']['timeout']
>> +
>> +    for test_name, conf in metadata['tests'].items():
>> +        text.extend([
>> +            f'{test_name}',
>> +            len(test_name) * '-'
>> +        ])
>> +
>> +        # source url location
>> +        test_fname = conf.get('fname', None)
>> +        if test_fname:
>> +            text.extend([
>> +                '',
>> +                f"`source <{ltp_repo_base_url}/{test_fname}>`__",
>> +                ''
>> +            ])
>> +
>> +        # test description
>> +        desc = conf.get('doc', None)
>> +        if desc:
>> +            desc_text = []
>> +            for line in desc:
>> +                if line.startswith("[Description]"):
>> +                    desc_text.append("**Description**")
> I suggested about deleting all [Description] from the code. I see no value in
> it, but it forces reader to scroll more (it prolongs the page).
>
>> +                elif line.startswith("[Algorithm]"):
>> +                    desc_text.append("**Algorithm**")
>> +                else:
>> +                    desc_text.append(line)
> NOTE: because there are more titles in "[..]" (there can be anything, why not
> just replace \[(.*)\] with **\1** ?
That's how it should be done yes. But at the moment we are still having 
[..], so that should be removed with a followup patch when titles will 
be adapted.
>> +
>> +            text.extend([
>> +                '\n'.join(desc_text),
>> +            ])
>> +
>> +
>> +        # developer information
> For me would be more obvious comment something like: "parse struct tst_test content".
>
> Kind regards,
> Petr
>
>> +        text.append('')
>> +        text.extend(_generate_setup_table(conf))
>> +        text.append('')
>> +
>> +        # small separator between tests
>> +        text.extend([
>> +            '',
>> +            '.. raw:: html',
>> +            '',
>> +            '    <hr>',
>> +            '',
>> +        ])
>> +
>> +    with open(output, 'w+', encoding='utf-8') as new_tests:
>> +        new_tests.write('\n'.join(text))
> ...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
