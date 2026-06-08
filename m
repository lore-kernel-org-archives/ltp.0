Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919CACD8C9D
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 13:41:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 073B43E6F96
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 15:41:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 284E63E4E74
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 15:40:59 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1B6331A01091
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 15:40:58 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586c5tO2323666; Mon, 8 Jun 2026 13:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PvtPbR
 0VKroTFIaVeWbZ5cBtMzs8lNtqi2iQHegm06M=; b=VCykzDgXuuAaAySCJpRaCm
 QRaJ7iWZLtP+6K5l/DoftEezT1jvygFnp2+0jANLWMCxO4g5SYbWt8xd1uXEXwFz
 cCXMLtib2rkNaaxyDWCNfvu63Qj588trmXGzF/pDzZ0shk502m05tQoUYPxuSH4W
 LelCyi4AoaYowluEPUJtHGjbYYR7ZCLNxysM/8wvj1lYUFG2T/j1WoqVGrCZlY0B
 50dbOroCLVu8wpejN+g1bs2Yr+h4IXo9UmxOwUThCy8H7U7Dk5JyCaWMaWkA5Z//
 0asWuqZc4DCTV8oTelTRyOhHUalbE63yD7aYzd24vbDNCKBWO5jRBDpSDOkXf/rw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhqny9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 13:40:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658DYgvk003501;
 Mon, 8 Jun 2026 13:40:56 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycgwef2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 13:40:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 658DePMo26411642
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 13:40:25 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D52CA58057;
 Mon,  8 Jun 2026 13:40:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03A6958059;
 Mon,  8 Jun 2026 13:40:55 +0000 (GMT)
Received: from [9.43.109.84] (unknown [9.43.109.84])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 13:40:54 +0000 (GMT)
Message-ID: <8a4a075d-0440-4f16-b88c-f09b1961e030@linux.ibm.com>
Date: Mon, 8 Jun 2026 19:10:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260608092200.92827-1-sachinp@linux.ibm.com>
 <20260608092200.92827-2-sachinp@linux.ibm.com> <aiauHurwBjafsd4R@yuki.lan>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <aiauHurwBjafsd4R@yuki.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyOSBTYWx0ZWRfX5I5U0sTtT3lv
 dsyDu4PNDNUc/26gmhJwmHo5HVx6kdwfryr1Sm78ADaOIAmYQTAExCuo8FXNnjnEbaMfXP6fyMg
 v7uCxzUVG2VRaw4tYoSuJVdyiydUt8/t3kBzgQ010E7CPiwLhpVCKwS/cAOOltg6MXjRfp2MiwF
 awjc3h3oIivBWuVusBXvaPAhekzJ8HdldZIsX5B2IziCRHwfnZatmoqBZEE+vHZy5eopAdHtpeJ
 jNjtzI0uIQXCGR9OZbtn06SVMuWJ8zJ4BxSoNq+dWLcvKCl8i6mLNitjfmw8doGV+nFxQd8c5rk
 b1uGWtY3HDbza0NKrEbAwxS22Um2UCFSpbhbW9zJHI8Lpjcd1vR0A+JXag+BqvhEEGY0Gjku9A3
 B/lLeuSchiylGVJVjPj0h/XaNn2oCO+vQd80bJ7gp7dnM1bHEWI/ErOHqaWvkVzDSRTH+LuYqNj
 rUdWv80ROyqvjLgCHiA==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a26c669 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Vj7jC-xpH-o7r-cHIioA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OyPGV4wLjZ21a242TNUeIPY5-llhFVBk
X-Proofpoint-GUID: OyPGV4wLjZ21a242TNUeIPY5-llhFVBk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080129
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/8] fs/acl: Add ACL_USER_OBJ permission test
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



On 08/06/26 5:27 pm, Cyril Hrubis wrote:
>> +
>> +	if (type == ACL_TYPE_ACCESS)
>> +		xattr_name = XATTR_NAME_POSIX_ACL_ACCESS;
>> +	else if (type == ACL_TYPE_DEFAULT)
>> +		xattr_name = XATTR_NAME_POSIX_ACL_DEFAULT;
>> +	else {
>> +		errno = EINVAL;
>> +		return NULL;
>> +	}
> We are using this in two places, maybe it's worth having an
> acl_type_to_name() functions and use that instead.
Makes sense. Will make the change.
>> +	header = (struct posix_acl_xattr_header *)buf;
>> +	if (le32_to_cpu(header->a_version) != POSIX_ACL_XATTR_VERSION) {
>> +		free(buf);
>> +		errno = EINVAL;
>> +		return NULL;
>> +	}
>> +
>> +	count = (size - sizeof(*header)) / sizeof(struct posix_acl_xattr_entry);
>> +	entries = (struct posix_acl_xattr_entry *)(buf + sizeof(*header));
> Maybe we can define a structure with both header and entries in order to
> avoid some of the casts here. Maybe this would work:
>
> struct acl_xattr {
> 	struct posix_acl_xattr_header header;
> 	struct posix_acl_xattr_entry entries[];
> };
>
> And then we could do:
>
> 	struct acl_xattr *ax = (void*)buf;
>
> 	if (le32_to_cpu(ax->header.a_version) == ACL_TYPE_ACCESS) {
> 		...
> 	}
>
> 	...
>
> 	for (i = 0; i < conut; i++) {
> 		uint16_t tag = le16_to_cpu(ax->entries[i].e_tag);
> 		...
>
> 	}
Okay, will check.
>> +	acl = acl_init();
>> +	if (!acl) {
>> +		free(buf);
>> +		return NULL;
>> +	}
>> +
>> +	for (i = 0; i < count; i++) {
>> +		uint16_t tag = le16_to_cpu(entries[i].e_tag);
>> +		uint16_t perm = le16_to_cpu(entries[i].e_perm);
>> +		uint32_t id = le32_to_cpu(entries[i].e_id);
>> +
>> +		if (acl_add_entry(acl, tag, perm, id) < 0) {
>> +			acl_free(acl);
>> +			free(buf);
>> +			return NULL;
>> +		}
>> +	}
>> +
>> +	free(buf);
>> +	return acl;
>> +}
>> +
>> +/*
>> + * Check if an ACL entry has a specific permission
>> + */
>> +static inline int acl_entry_has_perm(struct acl_entry *entry, uint16_t perm)
>> +{
>> +	return (entry->perm & perm) == perm;
>> +}
>> +
>> +/*
>> + * Check if an ACL entry has all rwx permissions
>> + */
>> +static inline int acl_entry_has_rwx(struct acl_entry *entry)
>> +{
>> +	return acl_entry_has_perm(entry, ACL_READ) &&
>> +	       acl_entry_has_perm(entry, ACL_WRITE) &&
>> +	       acl_entry_has_perm(entry, ACL_EXECUTE);
> Can't we pass all the bits to a single call of the function like
> acl_entry_has_perm(entry, ACL_READ | ACL_WRITE | ACL_EXECUTE) ?
Yes, will change.
>> +}
>> +
>> +/*
>> + * Find an ACL entry by tag type
>> + */
>> +static inline struct acl_entry *acl_find_entry(struct acl *acl, uint16_t tag,
>> +					       uint32_t id)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < acl->count; i++) {
>> +		if (acl->entries[i].tag == tag) {
>> +			if (tag == ACL_USER || tag == ACL_GROUP) {
>> +				if (acl->entries[i].id == id)
>> +					return &acl->entries[i];
>> +			} else {
>> +				return &acl->entries[i];
>> +			}
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +/*
>> + * Update ACL mask permissions
>> + */
>> +static inline int acl_set_mask_perms(struct acl *acl, uint16_t perm)
>> +{
>> +	struct acl_entry *mask_entry = acl_find_entry(acl, ACL_MASK, 0);
>> +
>> +	if (!mask_entry) {
>> +		errno = ENOENT;
>> +		return -1;
>> +	}
>> +
>> +	mask_entry->perm = perm;
>> +	return 0;
>> +}
>> +
>> +static inline int create_file_as(uid_t uid, gid_t gid, mode_t mode,
>> +				 int use_umask, mode_t mask)
>> +{
>> +	pid_t pid;
>> +	int status;
>> +
>> +	pid = SAFE_FORK();
>> +	if (!pid) {
>> +		int fd, err;
>> +
>> +		if (setgroups(0, NULL) == -1) {
>> +			err = errno;
>> +			_exit(err);
>> +		}
>> +
>> +		if (setgid(gid) == -1) {
>> +			err = errno;
>> +			_exit(err);
>> +		}
>> +
>> +		if (setuid(uid) == -1) {
>> +			err = errno;
>> +			_exit(err);
>> +		}
> These should be SAFE_MACROS().
Can you elaborate on this?
This code runs in a forked child process that intentionally tests 
permission scenarios.
The function expects these calls to potentially fail as part of testing 
ACL behavior.

The current pattern of capturing errno and exiting with it is correct for
communicating failure back to the parent.
SAFE_* macros would call tst_brk(TBROK) on failure, which is 
inappropriate in
a child process testing permissions.

The parent process checks the exit status to determine if the operation
succeeded or failed (line 442: return WEXITSTATUS(status))

>
>> +		if (use_umask)
>> +			umask(mask);
>> +
>> +		fd = open(TESTFILE, O_CREAT | O_WRONLY, mode);
>> +		if (fd >= 0) {
>> +			close(fd);
>> +			_exit(0);
>> +		}
> Generally in LTP we want to check the test conditions right after they
> happen. So this function should get expected errno as last parameter and
> we should check for the result right here with something as:
>
> 	if (errno)
> 		ST_EXP_FAIL()
> 	else
> 		TST_EXP_FD()
>
> With that we do need to propagate the return value manually, which is
> prone to errors, and do not need to process the child exit value
> manually, we can just let the library collect the children with
> tst_reap_children().
>
>> +		err = errno;
>> +		_exit(err);
>> +	}
>> +
>> +	SAFE_WAITPID(pid, &status, 0);
>> +
>> +	if (!WIFEXITED(status))
>> +		tst_brk(TBROK, "Child terminated abnormally");
>> +
>> +	return WEXITSTATUS(status);
>
>> +}
>> +
>> +static inline int try_create_as(uid_t uid, gid_t gid, mode_t mode)
>> +{
>> +	return create_file_as(uid, gid, mode, 0, 0);
>> +}
>> +
>> +static inline int create_with_umask_as(uid_t uid, gid_t gid, mode_t mode,
>> +					mode_t mask)
>> +{
>> +	return create_file_as(uid, gid, mode, 1, mask);
>> +}
>> +
>> +static inline void cleanup_test_paths(void)
>> +{
>> +	if (unlink(TESTSYMLINK) == -1 && errno != ENOENT)
>> +		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTSYMLINK);
>> +
>> +	if (unlink(TESTFILE) == -1 && errno != ENOENT)
>> +		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTFILE);
>> +
>> +	if (rmdir(TESTDIR) == -1 && errno != ENOENT)
>> +		tst_res(TWARN | TERRNO, "rmdir(%s) failed", TESTDIR);
> Maybe we need SAFE_TRY_UNLINK() and SAFE_TRY_RMDIR() that wouldn't TBROK
> on ENOENT and then we could use it here.
Good point. Let me check on this.
>> +}
>> +
>> +#endif /* ACL_LIB_H */
>> diff --git a/testcases/kernel/fs/acl/acl_user_obj01.c b/testcases/kernel/fs/acl/acl_user_obj01.c
>> new file mode 100644
>> index 000000000..01abfbf4e
>> --- /dev/null
>> +++ b/testcases/kernel/fs/acl/acl_user_obj01.c
>> @@ -0,0 +1,154 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2026 IBM
>> + *
>> + * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
>> + * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
>> + */
>> +
>> +/*\
>> + * Test ACL_USER_OBJ permissions using direct xattr manipulation.
>> + *
>> + * Verify that owner permissions (ACL_USER_OBJ) correctly control access
>> + * to files and directories. The test validates that:
>> + * - ACL_USER_OBJ permissions are applied directly as the owner bits
>> + * - Setting ACL_USER_OBJ=rwx via setxattr() overrides a previous
>> + *   chmod restriction
>> + * - Owner permissions work independently of group and other permissions
>> + *
>> + * This test uses arbitrary UIDs without creating actual users, testing
>> + * only the kernel ACL implementation.
>> + */
>> +
>> +#include "acl_lib.h"
>> +
>> +#define TEST_UID 1000
>> +#define TEST_GID 1000
>> +
>> +/*
>> + * Test permission bits deny access.
>> + * Owner should be denied write access when mode is 0500.
>> + */
>> +static void test_deny_by_mode(void)
>> +{
>> +	int err;
>> +
>> +	tst_res(TINFO, "Testing permission bits deny access");
>> +	reset_test_path();
>> +
>> +	SAFE_CHOWN(TESTDIR, TEST_UID, TEST_GID);
>> +	SAFE_CHMOD(TESTDIR, 0500);
>> +
>> +	err = try_create_as(TEST_UID, TEST_GID, 0644);
>> +	if (!err) {
>> +		cleanup_testfile();
>> +		tst_res(TFAIL, "Created file without write permission");
>> +		return;
>> +	}
>> +
>> +	if (err != EACCES) {
>> +		errno = err;
>> +		tst_res(TFAIL | TERRNO, "Expected EACCES from owner create");
>> +		return;
>> +	}
>> +
>> +	tst_res(TPASS, "File creation denied by permission bits");
>> +}
>> +
>> +/*
>> + * Test ACL_USER_OBJ grants access.
>> + * Setting ACL_USER_OBJ=rwx should override previous chmod restriction.
>> + */
>> +static void test_grant_by_acl(void)
>> +{
>> +	struct acl *acl = NULL;
>> +	int err;
>> +
>> +	tst_res(TINFO, "Testing ACL_USER_OBJ grants access");
>> +	reset_test_path();
>> +
>> +	SAFE_CHOWN(TESTDIR, TEST_UID, TEST_GID);
>> +	SAFE_CHMOD(TESTDIR, 0500);
>> +
>> +	acl = acl_init();
>> +	if (!acl)
>> +		tst_brk(TBROK | TERRNO, "acl_init failed");
>> +
>> +	if (acl_add_entry(acl, ACL_USER_OBJ,
>> +			  ACL_READ | ACL_WRITE | ACL_EXECUTE, 0) < 0)
>> +		goto cleanup_acl;
>> +
>> +	if (acl_add_entry(acl, ACL_GROUP_OBJ, 0, 0) < 0)
>> +		goto cleanup_acl;
>> +
>> +	if (acl_add_entry(acl, ACL_OTHER, 0, 0) < 0)
>> +		goto cleanup_acl;
> Maybe we can just call SAFE_MALLOC() and tst_brk() internally in these
> functions so that we don't have to complicate the code here. We do call
> tst_brk() in cleanup_acl: anyways.
Thanks, yes make sense. Similar code pattern is used in multiple tests.
This should help simplify. Will check on this.

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
