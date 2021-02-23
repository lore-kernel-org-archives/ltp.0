From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 23 Feb 2021 13:00:12 +0100
Subject: [LTP] [PATCH v2] Add test for possible writev() issues with
 NULL buffer in iovec
In-Reply-To: <YDTrAVVmOXB98Xjt@pevik>
References: <20210222172043.24294-1-mdoucha@suse.cz> <YDTrAVVmOXB98Xjt@pevik>
Message-ID: <d95f8ec9-9d0b-4178-c735-80cdbd313932@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 23. 02. 21 12:46, Petr Vorel wrote:
> It takes some time to run due .all_filesystems, but I guess there is a reason to
> test it on all available fs.

Yes, test results depend on FS-specific backend implementation bugs.
ext2, ext3 and vfat fail; ext4, xfs and btrfs pass on unpatched kernels.

> ...
>> diff --git a/testcases/kernel/syscalls/writev/writev03.c b/testcases/kernel/syscalls/writev/writev03.c
>> new file mode 100644
>> index 000000000..58d6931d2
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/writev/writev03.c
>> @@ -0,0 +1,145 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2021 SUSE LLC <mdoucha@suse.cz>
>> + *
>> + * Check for potential issues in writev() if the first iovec entry is NULL
>> + * and the next one is not present in RAM. This can result in a brief window
>> + * where writev() first writes uninitialized data into the file (possibly
>> + * exposing internal kernel structures) and then overwrites it with the real
>> + * iovec contents later. Bugs fixed in:
> Maybe this doc part should be in * [DESCRIPTION] to get into docparse.

Yes, please add it before pushing the patch.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
