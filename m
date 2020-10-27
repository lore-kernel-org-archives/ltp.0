From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 27 Oct 2020 11:51:00 +0100
Subject: [LTP] [PATCH 05/19] Unify error handling in lib/safe_macros.c
In-Reply-To: <5F97F205.8020602@cn.fujitsu.com>
References: <20201026164756.30556-1-mdoucha@suse.cz>
 <20201026164756.30556-6-mdoucha@suse.cz> <5F97F205.8020602@cn.fujitsu.com>
Message-ID: <2c5270b6-bff3-fac6-4d3f-f83c608a6d8b@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 27. 10. 20 11:10, Yang Xu wrote:
> Hi Martin
>> - Properly format caller file:line location
>> - Pedantically check invalid syscall return values
>>
>> Signed-off-by: Martin Doucha<mdoucha@suse.cz>
>> ---
>> ? lib/safe_macros.c | 602 +++++++++++++++++++++++++++++-----------------
>> ? 1 file changed, 384 insertions(+), 218 deletions(-)
>>
>> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
>> index 4f48d7529..f5e80fc48 100644
>> --- a/lib/safe_macros.c
>> +++ b/lib/safe_macros.c
> 
>>
>>
>> ????? return rval;
>> @@ -255,10 +288,16 @@ ssize_t safe_read(const char *file, const int
>> lineno, void (*cleanup_fn) (void),
>> ????? ssize_t rval;
>>
>> ????? rval = read(fildes, buf, nbyte);
>> +
>> ????? if (rval == -1 || (len_strict&&? (size_t)rval != nbyte)) {
>> -??????? tst_brkm(TBROK | TERRNO, cleanup_fn,
>> -???????????? "%s:%d: read(%d,%p,%zu) failed, returned %zd",
>> -???????????? file, lineno, fildes, buf, nbyte, rval);
>> +??????? tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
>> +??????????? "read(%d,%p,%zu) failed, returned %zd", fildes, buf,
>> +??????????? nbyte, rval);
>> +??? }
>> +??? if (rval<? 0) {
>> +??????? tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
>> +??????????? "Invalid read(%d,%p,%zu) return value %zd", fildes,
>> +??????????? buf, nbyte, rval);
>> ????? }
> Here has problem.. Maybe we can? use simple
> if (rval < 0 || (len_strict&&? (size_t)rval != nbyte)) to replace.

No, this is correct except for the missing "else" again. rval < -1 is
invalid and rval == -1 will be covered by the first if() branch.

>>
>> ????? return rval;
> 
>> ????? return rval;
>> @@ -452,10 +530,14 @@ ssize_t safe_write(const char *file, const int
>> lineno, void (cleanup_fn) (void),
>> ????? ssize_t rval;
>>
>> ????? rval = write(fildes, buf, nbyte);
>> +
>> ????? if (rval == -1 || (len_strict&&? (size_t)rval != nbyte)) {
>> -??????? tst_brkm(TBROK | TERRNO, cleanup_fn,
>> -???????????? "%s:%d: write(%d,%p,%zu) failed",
>> -???????????????? file, lineno, fildes, buf, rval);
>> +??????? tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
>> +??????????? "write(%d,%p,%zu) failed", fildes, buf, nbyte);
>> +??? } else if (rval<? 0) {
>> +??????? tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
>> +??????????? "Invalid write(%d,%p,%zu) return value %zd", fildes,
>> +??????????? buf, nbyte, rval);
>> ????? }
> I prefer to use "if (rval < 0 || (len_strict&&? (size_t)rval != nbyte)"

This is correct as is. rval < -1 is invalid.

>>
> 
>> ????? }
>>
>> @@ -530,20 +612,19 @@ long safe_sysconf(const char *file, const int
>> lineno,
>> ??????????? void (cleanup_fn) (void), int name)
>> ? {
>> ????? long rval;
>> -??? errno = 0;
>>
>> +??? errno = 0;
> It looks no change.

There's whitespace change because checkpatch.pl was complaining.

I'll resubmit v2 for patches 2, 3 and 5 after the rest of this patchset
gets pushed. These three patches are not blocking anything else.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
