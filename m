From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 6 Jul 2021 11:57:13 +0200
Subject: [LTP] [PATCH] fs_bind: Convert to ltp tests
In-Reply-To: <87zguz7par.fsf@suse.de>
References: <20210705135014.679200-1-lkml@jv-coder.de>
 <20210705135014.679200-2-lkml@jv-coder.de> <87zguz7par.fsf@suse.de>
Message-ID: <54b89a5f-17fd-cc48-b0f7-a247abadd0fb@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

On 7/6/2021 11:41 AM, Richard Palethorpe wrote:
> Hello Joerg,
>
> Joerg Vehlow <lkml@jv-coder.de> writes:
>
>> diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh
>> new file mode 100755
>> index 000000000..9e0f5fe05
>> --- /dev/null
>> +++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh
>> @@ -0,0 +1,53 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (c) International Business Machines  Corp., 2005
>> +# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
>> +# Author: Avantika Mathur (mathurav@us.ibm.com)
>> +
>> +FS_BIND_TESTFUNC=test
>> +
>> +. fs_bind_lib.sh
>> +
>> +test()
>> +{
>> +    tst_res TINFO "cloneNS: namespaces with parent-slave"
>> +
>> +	fs_bind_makedir rshared dir1
>> +	EXPECT_PASS mount --bind "$FS_BIND_DISK1" dir1
>> +
>> +	mkdir dir2
>> +	EXPECT_PASS mount --bind dir1 dir2
> There seems to be a section of tabs instead of spaces here. Also in
> other places.
Hmm strange. But I'd say rather spaces instead of tabs in some places. 
As far as I see ltp mostly uses tabs and not spaces.
I guess mixed tab/spaces is an artifact from the way I worked on the 
tests. fs_bind was mixed spaces/tabs to begin with and I did not check.
I will fix this for a v2.
> I wonder how you converted these?
It was a mixed approach:
1. Try to understand the building blocks and reimplement them as a shell 
code library instead of several binaries.
I also realized, that nothing implemented in test_fs_bind.sh was really 
required (except for creating the "sandbox").
I replaced the mount and /proc/mount checks with just a /proc/mount 
check, because I don't see a reason to do
two checks, that should be based on the same data (mount and /proc/mount).
2. Convert some tests manually and adapt library.
I did multiple rewrites of some functions and especially of the 
unmounting code.
At first I was trying to collect all mounts in the library, to know what 
has to be unmounted,
but due to the nature of bind and move mounts, this is not really 
possible without extensive logic.
3. Convert lots of tests automatically using a python script. The 
structure of most tests was them same
(there are hints that the test boilerplate was automatically generated 
from some other source.)
This only required minor manual changes
4. Understand convert and fix the cloneNS tests. This was one of the 
bigger challenges, because
these tests were not executed since they were committed 13 years ago and 
had some bugs.
I am not even sure if the boilerplate for these tests was correct, but 
it was good enough, to understand
what it was supposed to do.

>
> Looks promising.
>

