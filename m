Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A24F33806
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 07:10:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4796F3E1CAF
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 08:10:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFBB73D0320
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 08:09:48 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 27F5A600AB4
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 08:09:47 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H2VfHd3918913; Tue, 17 Mar 2026 07:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0QBagg
 0jlfmK0cTEn9oTMs5Mf/ObIhoWcGBeGYLeX4s=; b=EN5KRf7sGTOB6bhu9M/QN5
 1scA1DPCwMxXGpRUJ6XgH3tG3/x+1LMPwSPgGd33dRASmqb+gVeRNPkj+5w4X49p
 ZB8Ou7Js69yntAF36GrA8ap7n30o7/9obe7uHyZ2zAMLiu1BNu4i8HKSbQVZ6J9V
 YOb0r249w75KEP4PIm+Q3LOQt+CtEABYdEoP55w0h/7Lj+7HCmtJRl7Xg8CPFdJu
 jrGd166LO/7Qth+vsJkgm/VyMu9PZX9iDASrAlA6NGmVXC2iNOSglEv0vUkZjtPh
 jHUIioGeqDiAOCQkcPOeA/K7uBZjYRw590fSKGfOFK44/ym9SPp1XOn0UdPqdBGA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hu7qj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 07:09:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H26b62032343;
 Tue, 17 Mar 2026 07:09:45 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jqvs9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 07:09:45 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62H79iHf62652762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 07:09:44 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 580125805F;
 Tue, 17 Mar 2026 07:09:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA0CB5805A;
 Tue, 17 Mar 2026 07:09:42 +0000 (GMT)
Received: from [9.61.245.84] (unknown [9.61.245.84])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2026 07:09:42 +0000 (GMT)
Message-ID: <42d9a0a4-b4d4-4c92-9031-dfc0d17d8c4c@linux.ibm.com>
Date: Tue, 17 Mar 2026 12:39:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Li Wang <liwang@redhat.com>
References: <20260315125934.1291918-1-samir@linux.ibm.com>
 <abd-gW8X6XU0BWbe@redhat.com> <20260316115800.GA311158@pevik>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <20260316115800.GA311158@pevik>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zXFNsB9QoEj6beCdwakhn1jWdNMIiCuL
X-Proofpoint-ORIG-GUID: zXFNsB9QoEj6beCdwakhn1jWdNMIiCuL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA1NyBTYWx0ZWRfX8Qq1aylWZKWv
 OI4QsbyrUZzoABm7ng0JHRU6zZHrJ3pODj3awmTUpNL3b/YKpOq3zIWOvL335FjCgKKAjMvIahn
 kodC4a3gr/hqIlDfo3w2yhFOp4JYTo1bWSy1ZwNi5V7HQN5W7dHZ0jVbDvQas4ixBlbC6xlGVAT
 vnRRRUte78JqTbG1KDQsQO4IBDrSVXyv8C7txVRwGNL1wPl2ksYs3aalRYig6y+thbz1tXUkAT0
 el6ye4csxSAz/AUAFuVjCBemxZ7dafz+dMphiLhkpyHNFLzIdYh+4LV7NKgFC6I5pRw/2/nDpWj
 ZYTwGs0hplXamsk8Qt4zHAk80vIwtYfaLv7pYnnUsvGpk5xP/ejh/2KVv2bvMrwvPelCOkrNPk0
 qbhJ3R3R2ZlMqQcWSUeV5dCjkUKFwWVSIAnL0o+yPMiEtVrfx+PXI1S9p2u3gseSUZ9amZFrGHR
 P/mjMV5r6CotrRf75Dg==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b8fe3a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=bWwH7DZQkkZK1NEMHnEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170057
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] controllers/cgroup: Skip regression test on
 cgroup v2 systems
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


On 16/03/26 5:28 pm, Petr Vorel wrote:
> Hi Li, Samir,
>
> ...
>>> +	# This test is specific to cgroup v1
>>> +	# Check if system is using cgroup v2
>>> +	if [ -f /sys/fs/cgroup/cgroup.controllers ]; then
>> This is typically right as the '/sys/fs/cgroup' is Cgroup default mount path,
>> but if a tested system does not mount there, this won't work.
>> Maybe we can go with the cgroup_lib.sh standard way for version check?
>>    cgroup_require "memory"
>>    cgroup_version=$(cgroup_get_version "memory")
>>    if [ "$cgroup_version" = "2" ]; then
>>            tst_res TCONF "memory controller mounted on cgroup v2 hierarchy, skipping test."
>>            return
>>    fi
> +1
>
> Kind regards,
> Petr
>
Hi Li, Petr,

I agree with the suggested changes. Thank you for review comments will 
sent a new patch version with the suggested changes.

Regards,
Samir

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
