Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF62CD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:14:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 276483C1BE3
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 12:14:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CAB93C1BE3
 for <ltp@lists.linux.it>; Thu,  7 May 2026 12:14:09 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8D31E1400767
 for <ltp@lists.linux.it>; Thu,  7 May 2026 12:14:08 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6470iHtu3267730; Thu, 7 May 2026 10:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Xe0n4n
 /xzokTbcyjaSoczjaqCDn7nr6RH1nGHhgtUUw=; b=auxJL4IgidL0ehTpTPcEeu
 YGqENypjkT5Td5yZG9wjqxrOuRori/yEPA47U65r+5Y48MKe5M1l82EWyFoOd9d+
 3emhBjKGKznPPvTZOA7BgEgOOMEYTGTPVs7yz2kwwF5dFwUxLoXT9cyqUh9SV7Wi
 iHCPiUz8UPGm+r3nVqnkNlQyYXp9EmM9nwCit5yp6xWiew8/96HU5vvg2IX03LoB
 ixhgiE5G3Pc4bT879DAPa726Chru3a+tTSLoreQQdfh4KBXvtPNkeYsXd9NKwXk3
 f5bQhR56YlrcsyF9fNtb9GG/fFGUEhujvVQlY+tf21jKT/8B3icDlaqoLrQ7ILGA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxvhne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2026 10:14:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647A9S4Q005990;
 Thu, 7 May 2026 10:14:05 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgjej7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2026 10:14:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 647AE4dH26542752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 May 2026 10:14:05 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4C0458061;
 Thu,  7 May 2026 10:14:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2E1058053;
 Thu,  7 May 2026 10:14:03 +0000 (GMT)
Received: from [9.43.101.71] (unknown [9.43.101.71])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  7 May 2026 10:14:03 +0000 (GMT)
Message-ID: <f5cb3a8d-8feb-45e7-b02b-2871808ac38e@linux.ibm.com>
Date: Thu, 7 May 2026 15:44:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260428143614.69724-1-sachinp@linux.ibm.com>
 <aftwmBUir04jaik4@yuki.lan>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <aftwmBUir04jaik4@yuki.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEwMCBTYWx0ZWRfX+PRDoLInoIEJ
 nzsUZqa5ngEm7QIUyloXOW8E/XW1lHzH1N8/lT6m9G28JFJrIx0vYyExZ0hj/xQThwRO+LB2wxe
 7Gj6+F17kGrV1YdWYjkBGdiIY8E4OINrOjwNhYIsTeXa4g8UAZ+qvt0o6HwdYtqzpJGl9Lxu+Fn
 BOX0kEW99Ax9Fs+k2zub3obAHpPHnlwjKywgLIrsCz+K8tZDh5wsOd/ExPdrhuf+xEMiqfdONni
 +lhTmy9TDKByRmKc89lRYTJA+dA4QWc6AZPIcI70lFwamsXnyVqiwQmrGSVBDwTYUe1+c37Gug0
 /+Euqo+5L40SQD7agR0pqu3h1kROkL8oaCiuToOi0OkHRIfbmbnQ6BfqIrpf1QpbM1xsLaf2H5Q
 coaZfy0hgrQDmpgJ5u4/GPxLKUk7YT0dK1hvmOY6Qe8hRsxatFs8jjkp9NcAoaIbz1ocktXLXcK
 8pno/xKPdcRIgiqi6aQ==
X-Proofpoint-ORIG-GUID: dSq3S4PV597AWvAcBBq0XFe9cFUIGVAK
X-Proofpoint-GUID: dSq3S4PV597AWvAcBBq0XFe9cFUIGVAK
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fc65ee cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=CeWuCehucv1G0DyljMEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070100
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] doc: generate CVE catalog documentation
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



On 06/05/26 10:17 pm, Cyril Hrubis wrote:
> Hi!
>> -	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl \
>> +	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst _static/cve.rst syscalls.tbl \
>>   		${abs_top_builddir}/metadata/ltp.json
> This shouldn't be added here. the ltp.json is cleaned up by the
> metadata/Makefile.
My bad, probably an oversight on my part. Will remove.
>> +    Generate CVE catalog in a single file. Parse runtest/cve file and
>> +    generate documentation with links to CVE databases and test sources.
>> +    Similar to test_catalog, creates a single _static/cve.rst file with
>> +    all CVE information.
>> +    """
>> +    output = '_static/cve.rst'
>> +    runtest_cve = '../runtest/cve'
> I do not like much that we depend on the cve runtest file, we want to
> get rid of runtest files eventually and depend only on the ltp.json.
Ah I see. Thanks for the review. Will remove the dependency on runtest/cve.
>> +        text.extend([
>> +            f'   * - {cve_id}',
>> +            f'     - {test_link}',
>> +        ])
> Can we please instead iterate over the "tests" in the metadata here and
> collect all tests that have "CVE" key in "tags"?
>
> That should be more straightforward since we do not need to parse two
> files.
Sure, will rewrite the logic based on ltp.json metadata.
Will send an updated version of the patch.

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
