From: Punit Agrawal <punit.agrawal@arm.com>
Date: Tue, 14 Nov 2017 13:10:47 +0000
Subject: [LTP] [PATCH 07/18] vma03: accept ENOMEM return value from
	mremap
In-Reply-To: <20171031111144.GG14550@rei.lan> (Cyril Hrubis's message of "Tue, 
 31 Oct 2017 12:11:44 +0100")
References: <20171026141447.26749-1-punit.agrawal@arm.com>
 <20171026141447.26749-8-punit.agrawal@arm.com>
 <20171031111144.GG14550@rei.lan>
Message-ID: <87wp2tt38o.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Picking up where I'd left off after the previous posting.

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> Attempting to map a wrapping region with mremap should fail (that's the
>> whole point of this test). Accept ENOMEM as well as EINVAL.
>
> I'm missing any background info here about the specific conditions where
> this happens. The test is supposed to run only on 32bit kernel, so I
> suppose that there is some older board with 32bit ARM that is able to
> execute this test and that we get a different errno there, but that is
> only speculation. Can you, pretty please, elaborate more on that?

After digging into the patch history I've failed to find an explanation
for why we are carrying the patch. Looks like the details of the issue
it was fixing have been lost.

The unpatched version of the test passes on TC2 (a 32bit big.LITTLE ARM
Platform).

I'll drop this patch from the next version.

Thanks,
Punit

>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> ---
>>  testcases/kernel/mem/vma/vma03.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/testcases/kernel/mem/vma/vma03.c b/testcases/kernel/mem/vma/vma03.c
>> index 4b34ab0a0..5f231e5bb 100644
>> --- a/testcases/kernel/mem/vma/vma03.c
>> +++ b/testcases/kernel/mem/vma/vma03.c
>> @@ -100,7 +100,7 @@ int main(int argc, char *argv[])
>>  
>>  		remap = mremap(map, pgsz, 2 * pgsz, 0);
>>  		if (remap == MAP_FAILED) {
>> -			if (errno == EINVAL)
>> +			if (errno == EINVAL || errno == ENOMEM)
>>  				tst_resm(TPASS, "mremap failed as expected.");
>>  			else
>>  				tst_resm(TFAIL | TERRNO, "mremap");
>> -- 
>> 2.14.2
>> 
>> 
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
