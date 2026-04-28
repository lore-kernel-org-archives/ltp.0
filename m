Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD75FF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 12:55:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0EFC3E2539
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 14:55:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59C8F3C7A5F
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 14:54:44 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6D0CB600779
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 14:54:43 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RKl5O21693197; Tue, 28 Apr 2026 12:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GdI5n2
 Q8kcdqdYeHbBEJkMSY2v4ysY46wNIFHKTEYus=; b=eYZd2MujqiYvdmxtVzES5t
 U1zCiyDXAHsPSpwnF6BayTuIO6BnaU4g8Sl1r6r6aK+HQjBa9CQVfdOn8uUkuAz+
 y9KCNoDNRJwokygXjdVvClvyaNzosvXMHbTzZ3sc8fcsIb9xqv5GUduyP4+KBXwA
 6kh4mMiSn5YiKwosVzapU2PjF89BwbzQelivC/PBJ+PaO6otD5O0gS8KSuVzTsny
 YcOapbSyVSX34DBSmZomuzDjLqqImTt/yZSyeK74sSnFcD6i5tgXhMwe4PAiKQDc
 cfnUlNjffbnLLnegbd8jb4PB8ZuL3oR965XKNRulAgejdUKqHdvSYMviFUjXfUDA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44nkpf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 12:54:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SCcpM9019202;
 Tue, 28 Apr 2026 12:54:40 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5g9jtc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 12:54:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63SCsdwL34275866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2026 12:54:39 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 268CA58055;
 Tue, 28 Apr 2026 12:54:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E20A358043;
 Tue, 28 Apr 2026 12:54:37 +0000 (GMT)
Received: from [9.43.64.210] (unknown [9.43.64.210])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2026 12:54:37 +0000 (GMT)
Message-ID: <dd3502b7-670b-473c-b607-672695c06f4c@linux.ibm.com>
Date: Tue, 28 Apr 2026 18:24:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>
References: <69f05e59.7b0a0220.32d441.7979@mx.google.com>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <69f05e59.7b0a0220.32d441.7979@mx.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SkOq_SGMind-fcoz-Wvl6dyz16-6Iayy
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f0ae11 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=7ykl0th9h5gsoFEAXRAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SkOq_SGMind-fcoz-Wvl6dyz16-6Iayy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExOCBTYWx0ZWRfXx+CZP5IyoqY7
 zTbMWlUKnFKkklime95ck8O8V1RUyda3LorulpSLdeFnDj1sqb5B5qtzXlVk/C52RtoXf5+SM3b
 qbw3W8L5zrPjTK1OWze1zilnZy7Cm7tG5umsZleADh6XlSaWV3/4rOPb+v2FtNg405bcf6LpRO0
 KFS397vQjfH85IuyUtl9hnxzKTK0GRt7dOwDAbR+cWW8dOB8o7OfS3v/QH1bPiW55o4aHX4bpko
 N0l1int4xCxq7qP5O5dFycvgYOt9DGnlBTXNtVsmTJXFWM0NineSpAkGSfuntVLZyI73EqcFwui
 FON82g0Fs1OoZoT4UGKEzR31x9UfV0ejB9zpcQLcoxzjmq9U57GKrs7xB3KSiwzQUg5Dcfa2Ris
 D2i3l/V32xIR3gAGsp/ehjcH9MH4t80QDLo0Gn38V5qcpIiCGbKn27qbvVwDN7e1DLjkok41NHY
 U95AJJzeG/12D6PZFnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280118
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



>> Add a Sphinx builder hook to parse runtest/cve and generate a
>> comprehensive CVE catalog in a single documentation file.
>>
>> The implementation:
>> - Parses runtest/cve to extract CVE IDs, test names, and options
>> - Generates a single CVE catalog file (_static/cves.rst) containing:
> Please use just 'cve.rst' instead of 'cves.rst'. The plural is not
> providing any info here.
Sure, will change the name.
>> +def generate_cve_catalog(_):
>> +    """
>> +    Generate CVE catalog in a single file. Parse runtest/cve file and
>> +    generate documentation with links to CVE databases and test sources.
>> +    Similar to test_catalog, creates a single _static/cves.rst file with
>> +    all CVE information.
>> +    """
>> +    output = '_static/cves.rst'
>> +    runtest_cve = '../runtest/cve'
>> +
>> +    # Parse runtest/cve file
>> +    cve_data = {}
>> +    cve_pattern = re.compile(r'^(cve-(\d{4})-\d+)\s+(\S+)(?:\s+(.*))?$')
> Do we need a regexp for this? The runtest file is well defining the
> following structure:
Yeah, we may not need a regexp here.
>
>    <cve-id> <binary> <arg0> <arg1> ..
>
> We only need to split lines which are not starting with # char,
> considering space as separator.
got it. Will include this change in the next version.
>> +
>> +        text.extend([
>> +            f'This test reproduces the vulnerability described in {cve_id}.',
>> +            'The test verifies that the system is properly patched against',
>> +            'this known security vulnerability.',
>> +            '',
>> +            f'* **CVE Year:** {cve_info["year"]}',
>> +            f'* **Test Command:** {test_cmd}',
>> +            '',
>> +            '.. raw:: html',
>> +            '',
>> +            '    <hr>',
>> +            '',
>> +        ])
> All this text is redundant and occupying space for no reason.
> Also I'm not sure about this approach, now we have tests list duplication
> inside the documentation.
>
> What about generating only a simple reference table? There are only 3
> information we need: CVE ID, test binary, year.
>
> | ID | Test name | Year |
> -------------------------
> | .. |    ..     |  ..  |
>
> etc..
Okay. Do we need year in the column since the CVE name also has year.
For cve.rst, I implemented the same logic as tests.rst.

A separate entry for CVE catalog.
Once a user clicks on this option it will expand with a list of 
individual CVE pages
in the left pane. Each entry follows the following format

<CVE ID> ( <Test Name> )

Based on review comments how should the page look like?

A separate entry for CVE catalog.
Once a user clicks on this option it will display the CVE list in 
tabular format
sorted by year. The table will follow (assuming Year to be retained)

| ID | Test name | Year |
-------------------------
| .. |    ..     |  ..  |


Test name will point to an entry in Test catalog.
No individual pages required for each CVE.

Can you confirm?
> There's no need to have a direct link to the CVE, since we already pointing
Okay. I can make this change. I followed the earlier

Thanks for the review.

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
