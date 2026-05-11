Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286D2CD37AC
	for <ltp@archiver.kernel.org>; Mon, 11 May 2026 08:41:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB79B3C94A0
	for <ltp@archiver.kernel.org>; Mon, 11 May 2026 10:41:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 755833C72B5
 for <ltp@lists.linux.it>; Mon, 11 May 2026 10:41:28 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3F50D20092C
 for <ltp@lists.linux.it>; Mon, 11 May 2026 10:41:26 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64ABQHig3268997; Mon, 11 May 2026 08:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uf0WLp
 Fmkrl50BlYEbhsanvd+AtPHuz5ZK9ZTg4kzd4=; b=qx+RQc1L3JAwczPYke+S5u
 +d/pkRYORhKim5OTVi87/9aQQXaixFD4m2OVBrsM2JPm4gh3hNBM/Z0uKTan2AAU
 G92jiI+Dghl9e2YWk7o907tJt06tioXih3uJlx1HBBMtuFt0+F0xxNGDfFt2BHFi
 Wu8w7qUIZjv1ItgqrHO4Frv1ZtubkAHfzFxAa4TvtxxNlLxuVYD8EoarCpLM8e5d
 qtq7NRueAa+QmEmomw2vWU9lMKuJHjBLiGrhVvA1w6to2NHYSXpQQIbvhZcwcplG
 kKOIpEMxWAvoFKKkJqwt07TP90ieH8u6CuHxIeOOIgHxv6a+0DaWx028tgzBh8mQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ve6ydjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 08:41:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B8dQMo028821;
 Mon, 11 May 2026 08:41:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2fmvvhs4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 08:41:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64B8fMWq27132658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 08:41:23 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A73C458061;
 Mon, 11 May 2026 08:41:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A9065805D;
 Mon, 11 May 2026 08:41:21 +0000 (GMT)
Received: from [9.43.85.184] (unknown [9.43.85.184])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 08:41:21 +0000 (GMT)
Message-ID: <dbf74dbf-b326-4c70-b12c-371a51cec232@linux.ibm.com>
Date: Mon, 11 May 2026 14:11:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20260511070852.90379-1-pvorel@suse.cz>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <20260511070852.90379-1-pvorel@suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA5NCBTYWx0ZWRfX2XuYXBwSmyTM
 PfNrDN7RVSLK53O+gJzIaJLkh9dBwpR8LbQHV9oRdn1nGEahY+13YNakcuEMd9G77zXJJisMCvR
 jjED40DQnYE5n3HHzcwNsn6Lm2RtBA4lSFkJBSASTqiltY99wEA5VdYHk6+A715HagHB2vPjWKs
 tEaX3e5dzwkUyHw0bVGTz9gL9nt3C8Tv/wjbd2x78awet45nFX7QyEoqb4IGIK1BRXif5h/IqBP
 Ul4EPEwyEhJRkf7lmFIAdH78jw3hbcMrqBwvnz/n7w404onQEEeGMNUtm6FPdTjc4Xiop/s9UwE
 29L5kec4aIAVBDuY3YGHJq2w1NiHFnmKUDGw1m7C4s6+KUvoYLi86p/JERhL3cCpNCRziX9hUFj
 zk9F8hHHXCXySliV4uvlh8AX4S9r5Hyivyb6GBNfvrtTmH0/TGUfWQCt3ZtzFyeWrKzHoXbEFmk
 vP45q/7Vrpq88VQOqGQ==
X-Proofpoint-GUID: CdRIfIPzdN2IXj8u7ttOlWRnE0LBQYt4
X-Proofpoint-ORIG-GUID: CdRIfIPzdN2IXj8u7ttOlWRnE0LBQYt4
X-Authority-Analysis: v=2.4 cv=CeQ4Irrl c=1 sm=1 tr=0 ts=6a019634 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=8r2qhXULAAAA:8
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=vEI_lbc5AAAA:8 a=VwQbUJbxAAAA:8 a=CCpqsmhAAAAA:8 a=5KEJ3k9QAAAA:8
 a=BquUM75wbReE0kUCSmgA:9 a=QEXdDO2ut3YA:10 a=8gvLZcY7Nlvl4CGD_6nf:22
 a=YUII-3zZ2UlQWlJ17VRX:22 a=ul9cdbp4aOFLsgKbc677:22 a=olg2BfGzmf2haRflzj8J:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 adultscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110094
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/cve_catalog: Link CVE to www.cve.org
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



On 11/05/26 12:38 pm, Petr Vorel wrote:
> Although test_catalog page links to www.cve.org, it's more convenient for
> readers to have that link also on page dedicated to CVEs.
>
> While at it, change warning to note (it's really an info, nothing to
> warn about).
>
> Follow-up: 79396c7b71 ("doc: Add CVE catalog to documentation")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Sachin, Andrea,
>
> thanks a lot for implementing the CVE list page. Very simple change to
> it but I prefer not to modify the page without your ack.
I am okay with this change. In-fact I had this change included in one of the
intermediate versions of the CVE catalog patch.

Based on review comments (The CVE link is present in corresponding test 
catalog
page) it was later removed

> Kind regards,
> Petr
>
>   doc/conf.py | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/doc/conf.py b/doc/conf.py
> index 668cb4d980..591c1534df 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -19,6 +19,7 @@ author = 'Linux Test Project'
>   release = '1.0'
>   ltp_repo = 'https://github.com/linux-test-project/ltp'
>   ltp_repo_base_url = f"{ltp_repo}/tree/master"
> +cve_url = "https://www.cve.org/CVERecord?id="
>   
>   # -- General configuration ---------------------------------------------------
>   # https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration
> @@ -293,7 +294,7 @@ def _generate_tags_table(tags):
>           "linux-stable-git": "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=",
>           "glibc-git": "https://sourceware.org/git/?p=glibc.git;a=commit;h=",
>           "musl-git": "https://git.musl-libc.org/cgit/musl/commit/src/linux/clone.c?id=",
> -        "CVE": "https://www.cve.org/CVERecord?id=CVE-",
> +        "CVE": cve_url + 'CVE-',
>       }
>   
>       table = [
> @@ -586,7 +587,7 @@ def generate_cve_catalog(_):
>       # Generate single CVE catalog file
>       total_cves = len(cve_data)
>       text = [
> -        '.. warning::',
> +        '.. note::',
>           '    The following CVE catalog has been generated from test',
>           '    metadata and includes all CVE reproducers in LTP.',
>           '',
> @@ -614,8 +615,10 @@ def generate_cve_catalog(_):
>           # Join multiple tests with commas
>           tests_str = ', '.join(test_links)
>   
> +        cve_link = f'`{cve_id} <{cve_url}{cve_id}>`_'
> +
>           text.extend([
> -            f'   * - {cve_id}',
> +            f'   * - {cve_link}',
>               f'     - {tests_str}',
>           ])
>   

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
