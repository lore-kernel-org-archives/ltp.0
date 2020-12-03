From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 3 Dec 2020 15:27:59 +0100
Subject: [LTP] [PATCH 3/3] af_alg07: add dynamic bias for ARM
In-Reply-To: <878saf6pe1.fsf@suse.de>
References: <20201203110616.28302-1-liwang@redhat.com>
 <20201203110616.28302-3-liwang@redhat.com> <878saf6pe1.fsf@suse.de>
Message-ID: <30b58fc3-ac3d-8bbc-345a-1384dfe52a65@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03. 12. 20 13:32, Richard Palethorpe wrote:
> Hello,
> 
> Li Wang <liwang@redhat.com> writes:
> 
>> We observed that af_alg07 sporadically failed on hpe-moonshot(aarch64) with
>> fixed kernel, but after trying manually we can NOT reproduce it again, one
>> possibility is that the FAIL is caused by an unaligned race window between
>> two threads, so here add dynamic bias adjustment to see if it helps.
>>
>> Point of view from Martin Doucha:
>> 1) fchownat() returns 0 => fchownat() was called too early or the kernel is vulnerable
>> 2) fchwonat() fails with ENOENT => kernel is fixed, print TPASS and exit
>> 3) fchownat() fails with EBADF => fchownat() was called too late
> 
> Just FYI, what really prevents fzsync from working is if the temporal
> behaviour (time to execute) of a syscall changes dramatically depending
> on the outcome of a race[1].
> 
> For example if fchownat returns very quickly after EBADF, but takes a
> long time otherwise, then the delay will be too small. I guess most
> syscalls will check the FD very early so this is likely to be the
> problem.
> 
>>
>> Signed-off-by: Li Wang <liwang@redhat.com>
>> CC: Richard Palethorpe <rpalethorpe@suse.com>
>> CC: Martin Doucha <mdoucha@suse.cz>
>> CC: Joerg Vehlow <lkml@jv-coder.de>
>> CC: Chunyu Hu <chuhu@redhat.com>
>> CC: Cyril Hrubis <chrubis@suse.cz>
>> ---
>>  testcases/kernel/crypto/af_alg07.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/testcases/kernel/crypto/af_alg07.c b/testcases/kernel/crypto/af_alg07.c
>> index 539ebee11..ee48c2edb 100644
>> --- a/testcases/kernel/crypto/af_alg07.c
>> +++ b/testcases/kernel/crypto/af_alg07.c
>> @@ -76,6 +76,16 @@ static void run(void)
>>  			return;
>>  		}
>>  
>> +		if (TST_RET == 0) {
>> +			tst_fzsync_pair_add_bias(&fzsync_pair, -1);
>> +			continue;
>> +		}
> 
> It may actually be better to remove this and only increase the delay if
> EBADF?

Agreed. Adjusting delay in both directions would be acceptable if the
test takes too much time or doesn't work at all without it. Otherwise
it's preferable to adjust delay only when syscalls return an error state
that clearly falls outside the race window.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
