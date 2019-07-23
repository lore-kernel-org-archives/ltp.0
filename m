From: Steve Muckle <smuckle@google.com>
Date: Tue, 23 Jul 2019 10:32:45 -0700
Subject: [LTP] [PATCH] syscalls/statx01: loosen the stx_blocks check
In-Reply-To: <20190723110306.GB22630@rei.lan>
References: <20190722194439.161904-1-smuckle@google.com>
 <20190723110306.GB22630@rei.lan>
Message-ID: <1be1f0b8-170a-ac92-b86f-924e2d7f2295@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 7/23/19 4:03 AM, Cyril Hrubis wrote:
> Hi!
>> A filesystem may preallocate blocks (ext4 does this), so even though the
>> contents of the file may fit into a single block, statx may report more
>> than one block. Loosen the test to accommodate this.
>>
>> Signed-off-by: Steve Muckle <smuckle@google.com>
>> ---
>>   testcases/kernel/syscalls/statx/statx01.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
>> index 23ea99b4a..5e705dc7d 100644
>> --- a/testcases/kernel/syscalls/statx/statx01.c
>> +++ b/testcases/kernel/syscalls/statx/statx01.c
>> @@ -92,7 +92,7 @@ static void test_normal_file(void)
>>   			buff.stx_mode, MODE);
>>   
>>   
>> -	if (buff.stx_blocks <= buff.stx_blksize/512)
>> +	if (buff.stx_blocks <= 128)
> 
> Why 128?

Was just restoring it to what it was previously.

> Can't we rather multiply the buff.stx_blksize/512 by 16?

That would work for ext4, but should this be loosened further to give 
some headroom in case some FS preallocates more? Or is it preferable to 
keep the test as strict as possible and loosen it when/if failures happen?
