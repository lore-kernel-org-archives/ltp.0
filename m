Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D07FF885A
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 07:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777360500; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=gAvH0TGPT1CCxzkZhiaMZJrnBJyc04NFLo2jQgt1+eQ=;
 b=fY4eKdq8LhxFY8SfBqaTUVl4Io5ZMPn3hleOPCBRcDB+WGP6z+Ug503aYROqC+/UtmU7b
 AKCUuNXOf/WPKVTKHt1z9ieobl2timOVdex/3so2+4WMyJ6+SGx85u3wJ/v1Fd8ZiTo2but
 C8dVpSX73QCDnzKMs/ypNR6gaojejK0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5018F3E2536
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 09:15:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 450C93C4BFC
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:14:36 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 305D61400BC2
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:14:34 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488d2079582so130366885e9.2
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 00:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777360474; x=1777965274; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lzsPeuTTgcnX511zk6q9WsJdZUEOQk9sjyAuV37gq2g=;
 b=WA2cy/QH6UpKgYxsV/zATVUakLAbEkpjXSEzoZnCYb3wj5UzKgDkf6itvwRDvr9tBh
 1Te3YqvR7C1f68B/ceCOxQx/pR7LErwpqcPilyaXE5Y2g4OKe9baWvNiDBO99qLXgocA
 aI3UGoSs9rinDovz7dJQqvcJsC6UBNjernghJuNFhw9P6Wv7/GDsJapn/7R47Y549Rg7
 /j/mEED87DpZYN1ADgs+2ceVCn1L91mtaFLjl+3LncxkrgGoP7Oo6ZZF5xHCiSA8letj
 4KZ6WvOpQMO6bIzwq3Vhr9ftE05d+XntRZO9J9124TsDMPu7AOrbr96pm75vJN2GrGNk
 WC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777360474; x=1777965274;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzsPeuTTgcnX511zk6q9WsJdZUEOQk9sjyAuV37gq2g=;
 b=qnyJoYKW/lH6iXtltols61f/DfQIzEPyD/qGZXeqmNH4wC5Zc5kFNUE8ugUoSWQoMz
 I+00HpPfWc8lZJ4zpf+0ktIVPKw9Zk5WRamgKkqbU/vL8A2dUre3w1L3axFzJLkJRZ9N
 8+dued6788M2yTcndkQqxnGg1a5NPCxOjJ8ZZns5aqH/yhOmWdE5fSsEVa/lspvkYnof
 u2EczxQHzvpBg22KvV1NAhxLfhNfgQoEYu0nk7LrZ09OF2QUkOD+FZBWEB1l6ftzJlH2
 W0thkC4TVIQIkqX1L2VQ3BbrEbObxreo/RTkb6PNA6MaZmwWsgal4kN9y+DHk6g3VwoU
 /yhA==
X-Gm-Message-State: AOJu0Yw/RMxQgYoS2JnjrzApIz4m7umFSkW4N0c7IPqcAAKKoeanKjiD
 QMbAQmCN9BBj7QfdFYY/4Wd6pWP8MYIB13XeKKGM0tf5lQ2yYjaojTEGReFWdHe70vc=
X-Gm-Gg: AeBDievCGx287LJ9uyEtbDW+v8YYDfeThgcGE4m+wIkIxJ/cvly0P2655bBj3FLI9Ec
 bWlttpY61AAvrMEvOMtaUAfwLR9LtmxgpcP/m6Slvq+P5COjGaa0Qli7eaW7U92N9qm4dkwqpnm
 bmZ6jLjsxg5B7ZLAfCsP5cz/QhpVSu9FSeSZ9pNXTrm/D/uTfPKDHV2e12nrfE2TdLaxHuNsHMV
 5ER9GnA9ZXrQPB0X2KISmqb9K+YODZNo/5iSXH4WZ1De3pWaFq9rHVQUgyA41I5lxIIEHH3riwc
 0C3Yk9/p+HCmcusqJhmD+9LClxcs0/DylSwEtBm5S0LStoEDf8GUGvHUFtklfuUA5RDg5B+MiZU
 FEz3BfzM8WD80rKckTawMDXQn0AOLdbUAbG73QkACAbmFZgtv6lmp281gW65/UZf9l6rSRJmiew
 JN5urc6VolZpN5AhyAuFMtclKaHsVVKaiS33Ha4KCf43JalDt2PgHGmcaQQFj1ug4=
X-Received: by 2002:a05:600c:1e88:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-48a77b2aaf8mr27365685e9.27.1777360474222; 
 Tue, 28 Apr 2026 00:14:34 -0700 (PDT)
Received: from localhost.localdomain ([37.162.84.198])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773e7d20sm42128675e9.11.2026.04.28.00.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:14:33 -0700 (PDT)
Message-ID: <69f05e59.7b0a0220.32d441.7979@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <20260424121845.10914-1-sachinp@linux.ibm.com>
Date: Tue, 28 Apr 2026 07:14:31 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] doc: generate CVE catalog documentation
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

The idea is good, a few comments on the implementation tho:

> Add a Sphinx builder hook to parse runtest/cve and generate a
> comprehensive CVE catalog in a single documentation file.
> 
> The implementation:
> - Parses runtest/cve to extract CVE IDs, test names, and options
> - Generates a single CVE catalog file (_static/cves.rst) containing:

Please use just 'cve.rst' instead of 'cves.rst'. The plural is not
providing any info here.

> +def generate_cve_catalog(_):
> +    """
> +    Generate CVE catalog in a single file. Parse runtest/cve file and
> +    generate documentation with links to CVE databases and test sources.
> +    Similar to test_catalog, creates a single _static/cves.rst file with
> +    all CVE information.
> +    """
> +    output = '_static/cves.rst'
> +    runtest_cve = '../runtest/cve'
> +
> +    # Parse runtest/cve file
> +    cve_data = {}
> +    cve_pattern = re.compile(r'^(cve-(\d{4})-\d+)\s+(\S+)(?:\s+(.*))?$')

Do we need a regexp for this? The runtest file is well defining the
following structure:

  <cve-id> <binary> <arg0> <arg1> ..

We only need to split lines which are not starting with # char,
considering space as separator.

> +
> +    try:
> +        with open(runtest_cve, 'r', encoding='utf-8') as f:
> +            for line in f:
> +                line = line.strip()
> +                if not line or line.startswith('#'):
> +                    continue
> +
> +                match = cve_pattern.match(line)
> +                if match:
> +                    cve_id = match.group(1).upper()
> +                    year = match.group(2)
> +                    test_name = match.group(3)
> +                    options = match.group(4) if match.group(4) else ''
> +
> +                    cve_data[cve_id] = {
> +                        'cve_id': cve_id,
> +                        'year': year,
> +                        'test_name': test_name,
> +                        'options': options,
> +                    }
> +    except FileNotFoundError:
> +        logger = sphinx.util.logging.getLogger(__name__)
> +        msg = f"Can't find runtest/cve file ({runtest_cve})"
> +        logger.warning(msg)
> +        return
> +
> +    # Generate single CVE catalog file
> +    total_cves = len(cve_data)
> +    text = [
> +        '.. warning::',
> +        '    The following CVE catalog has been generated from the',
> +        '    runtest/cve file and includes all CVE reproducers in LTP.',
> +        '',
> +        f'LTP includes reproducers for {total_cves} known CVEs. These '
> +        'tests help verify',
> +        'that systems are patched against known vulnerabilities.',
> +        '',
> +    ]
> +
> +    # Load metadata to check which tests have documentation
> +    metadata = None
> +    metadata_file = '../metadata/ltp.json'
> +    try:
> +        with open(metadata_file, 'r', encoding='utf-8') as data:
> +            metadata = json.load(data)
> +    except FileNotFoundError:
> +        pass
> +
> +    # Add CVEs in descending order (newest first)
> +    for cve_id, cve_info in sorted(cve_data.items(), reverse=True):
> +        cve_url = f"https://cve.mitre.org/cgi-bin/cvename.cgi?name={cve_id}"
> +        test_name = cve_info["test_name"]
> +
> +        # Only create cross-reference if test exists in metadata
> +        if metadata and test_name in metadata.get('tests', {}):
> +            # Create anchor using the correct document path prefix
> +            test_anchor = f"users/test_catalog:{test_name}"
> +            test_link = f":ref:`{test_name} <{test_anchor}>`"
> +        else:
> +            # If test not in metadata, just use plain text formatting
> +            test_link = f"``{test_name}``"
> +
> +        # Create section header with CVE ID and test name
> +        section_title = f'{cve_id} ({test_name})'
> +        text.extend([
> +            section_title,
> +            len(section_title) * '-',
> +            '',
> +            f'**CVE Reference:** `{cve_id} <{cve_url}>`_',
> +            '',
> +            f'**Test Name:** {test_link}',
> +            '',
> +        ])
> +
> +        if cve_info['options']:
> +            text.extend([
> +                f'**Test Options:** ``{cve_info["options"]}``',
> +                '',
> +            ])
> +
> +        # Build test command on a single line to avoid RST formatting issues
> +        test_cmd = f'``{test_name}'
> +        if cve_info['options']:
> +            test_cmd += f' {cve_info["options"]}'
> +        test_cmd += '``'
> +
> +        text.extend([
> +            f'This test reproduces the vulnerability described in {cve_id}.',
> +            'The test verifies that the system is properly patched against',
> +            'this known security vulnerability.',
> +            '',
> +            f'* **CVE Year:** {cve_info["year"]}',
> +            f'* **Test Command:** {test_cmd}',
> +            '',
> +            '.. raw:: html',
> +            '',
> +            '    <hr>',
> +            '',
> +        ])

All this text is redundant and occupying space for no reason.
Also I'm not sure about this approach, now we have tests list duplication
inside the documentation.

What about generating only a simple reference table? There are only 3
information we need: CVE ID, test binary, year.

| ID | Test name | Year |
-------------------------
| .. |    ..     |  ..  |

etc..

There's no need to have a direct link to the CVE, since we already pointing
CVE to the Test catalog anyway.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
