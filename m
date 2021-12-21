Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B718DC433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 10:37:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B2E13C9226
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 11:37:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A2FC3C8E4D
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 10:21:13 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1251D1A0064E
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 10:21:11 +0100 (CET)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BL7I9jx002881; 
 Tue, 21 Dec 2021 09:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=H1zYJIY9bsHIK4C/u1CW3jP/ZM+ixwX7opsXZVwhD9k=;
 b=jl3gggbkEQSUV5pHZ7/G1smK81HK1eZPp7nUUZmM99WkESTGZsB8RZVm/2pY/szQ8vLa
 kS4vINH0xWDuJEPkQW6rwO9umWxkGbhjm52l258TYw1xoXBlcerASWn/40Iatc91fKIe
 2hOn3BliFn+LVyByXRgclWpuCEPe+cdUIEkZuVKx/7tua2278enmrmmdUyKOrg9A1J69
 uthhWsOvpZDKfGgkYhvuHteX+WPEu7DviseGxEWiIAAkfuwgvmRMC07oBFrDYLEL7e8p
 VV6pVKPC7WCjd3UwplPENkeqtt0U70hjZKMVJK6/tsR+3g7w7Qaj+PVQeGpWA89KBpdI Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3d1s7qrhf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Dec 2021 09:21:09 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BL98gWM017285;
 Tue, 21 Dec 2021 09:21:09 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3d1s7qrhe7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Dec 2021 09:21:09 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BL9Gqbg003489;
 Tue, 21 Dec 2021 09:21:06 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma03fra.de.ibm.com with ESMTP id 3d1799trk8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Dec 2021 09:21:06 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1BL9L4S57602636
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Dec 2021 09:21:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32C8911C054;
 Tue, 21 Dec 2021 09:21:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDCE711C06F;
 Tue, 21 Dec 2021 09:21:02 +0000 (GMT)
Received: from [9.43.19.198] (unknown [9.43.19.198])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 21 Dec 2021 09:21:02 +0000 (GMT)
Message-ID: <aafb5351-a73a-dac3-b0fa-3faad707bafa@linux.ibm.com>
Date: Tue, 21 Dec 2021 14:51:01 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
To: Yael Tiomkin <yaelt@google.com>, ltp@lists.linux.it
References: <20211221023721.129689-1-yaelt@google.com>
From: Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20211221023721.129689-1-yaelt@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XrH1xARohmUtxsn_ih5_dWTSYXd87HRW
X-Proofpoint-ORIG-GUID: lQsQLo_xM1Wpfd4Co24fzaXM-6ClnLwF
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_03,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210039
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 21 Dec 2021 11:37:27 +0100
Subject: Re: [LTP] [PATCH v2] syscalls/keyctl09: test encrypted keys.
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
Cc: linux-integrity@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 21/12/21 8:07 am, Yael Tiomkin wrote:
> Test that encrypted keys can be instantiated using
> both user-provided decrypted data
> (https://lore.kernel.org/linux-integrity/20211213192030.125091-1-yaelt@google.com/),
> or kernel-generated numbers.
> 
> Signed-off-by: Yael Tiomkin <yaelt@google.com>

Tested on ppc64le platform

Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>

...
<<<test_start>>>
tag=keyctl09 stime=1640078325
cmdline="keyctl09"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1425: TINFO: Timeout per run is 0h 05m 00s
keyctl09.c:49: TPASS: Encrypted keys were successfully instantiated and read

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
...


> ---
> 
> Notes:
>      v -> v2: added key revocation and made styling changes.
> 
>   runtest/syscalls                            |  1 +
>   testcases/kernel/syscalls/keyctl/.gitignore |  1 +
>   testcases/kernel/syscalls/keyctl/keyctl09.c | 58 +++++++++++++++++++++
>   3 files changed, 60 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/keyctl/keyctl09.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index bcf3d56c9..ccea1ddbd 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -643,6 +643,7 @@ keyctl05 keyctl05
>   keyctl06 keyctl06
>   keyctl07 keyctl07
>   keyctl08 keyctl08
> +keyctl09 keyctl09
>   
>   kcmp01 kcmp01
>   kcmp02 kcmp02
> diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
> index 3544ac79c..f9948c176 100644
> --- a/testcases/kernel/syscalls/keyctl/.gitignore
> +++ b/testcases/kernel/syscalls/keyctl/.gitignore
> @@ -6,3 +6,4 @@
>   /keyctl06
>   /keyctl07
>   /keyctl08
> +/keyctl09
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl09.c b/testcases/kernel/syscalls/keyctl/keyctl09.c
> new file mode 100644
> index 000000000..507cd5628
> --- /dev/null
> +++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Google, Inc.
> + */
> +
> +/*\
> + * [Description]
> + * Test that encrypted keys can be instantiated using user-provided decrypted
> + * data (plaintext), and separately, using kernel-generated key material.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/keyctl.h"
> +
> +#define ENCRYPTED_KEY_1_PAYLOAD	"new enc32 user:masterkey 32 plaintext12345678901234567890123"
> +#define ENCRYPTED_KEY_2_PAYLOAD	"new enc32 user:masterkey 32"
> +
> +static void do_test(void)
> +{
> +	key_serial_t masterkey;
> +	key_serial_t encryptedkey1;
> +	key_serial_t encryptedkey2;
> +	char buffer[128];
> +
> +	masterkey = add_key("user", "user:masterkey", "foo", 3,
> +			    KEY_SPEC_PROCESS_KEYRING);
> +	if (masterkey == -1)
> +		tst_brk(TBROK | TERRNO, "Failed to add user key");
> +
> +	encryptedkey1 = add_key("encrypted", "ltptestkey1", ENCRYPTED_KEY_1_PAYLOAD,
> +				60, KEY_SPEC_PROCESS_KEYRING);
> +	if (encryptedkey1 == -1)
> +		tst_brk(TFAIL, "Failed to instantiate encrypted key using payload decrypted data");
> +
> +	TEST(keyctl(KEYCTL_READ, encryptedkey1, buffer, sizeof(buffer)));
> +	if (TST_RET < 0)
> +		tst_brk(TFAIL, "KEYCTL_READ failed for encryptedkey1");
> +
> +	encryptedkey2 = add_key("encrypted", "ltptestkey2", ENCRYPTED_KEY_2_PAYLOAD,
> +				27, KEY_SPEC_PROCESS_KEYRING);
> +	if (encryptedkey2 == -1)
> +		tst_brk(TFAIL,
> +			"Failed to instantiate encrypted key using kernel-generated key material");
> +
> +	TEST(keyctl(KEYCTL_READ, encryptedkey2, buffer, sizeof(buffer)));
> +	if (TST_RET < 0)
> +		tst_brk(TFAIL, "KEYCTL_READ failed for encryptedkey2");
> +
> +	tst_res(TPASS, "Encrypted keys were successfully instantiated and read");
> +
> +	keyctl(KEYCTL_REVOKE, encryptedkey1);
> +	keyctl(KEYCTL_REVOKE, encryptedkey2);
> +	keyctl(KEYCTL_REVOKE, masterkey);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +};

-- 
Thanks and Regards
R.Nageswara Sastry

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
