From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Wed, 3 Oct 2018 01:23:30 +0200
Subject: [LTP] [PATCH v2 2/5] tst_safe_macros: add SAFE_GETGRGID()
In-Reply-To: <20181002142047.GK24796@rei>
References: <20180910141901.20541-1-cfamullaconrad@suse.de>
 <20180910141901.20541-2-cfamullaconrad@suse.de> <20181002142047.GK24796@rei>
Message-ID: <43441f97-3b86-e646-2693-4f396fa40ff6@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 10/2/18 4:20 PM, Cyril Hrubis wrote:
> Hi!
>> +struct group *safe_getgrgid(const char *file, const int lineno, gid_t gid);
>> +#define SAFE_GETGRGID(gid) \
>> +	safe_getgrgid(__FILE__, __LINE__, (gid))
>> +
>>  int safe_setxattr(const char *file, const int lineno, const char *path,
>>              const char *name, const void *value, size_t size, int flags);
>>  #define SAFE_SETXATTR(path, name, value, size, flags) \
>> diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
>> index 17384f32c..2e041c460 100644
>> --- a/lib/tst_safe_macros.c
>> +++ b/lib/tst_safe_macros.c
>> @@ -153,6 +153,19 @@ struct group *safe_getgrnam(const char *file, const int lineno,
>>  	return rval;
>>  }
>>  
>> +struct group *safe_getgrgid(const char *file, const int lineno, gid_t gid)
>> +{
>> +	struct group *rval;
> 
> Looking at manual pages we should zero the errno here, since we print it
> in the tst_brk_() in a case of NULL.

Thanks for pointing that. I'm going to change it here and in getgrnam().

> 
>> +	rval = getgrgid(gid);
>> +	if (rval == NULL) {
>> +		tst_brk_(file, lineno, TBROK | TERRNO,
>> +			"getgrgid(%li) failed", (long)gid);
>> +	}
> 
> I also wonder if it's okay to break the test in case that the entry
> wasn't found (the return value would be NULL and errno would be
> untouched) but I guess that it's OK for most of the cases.

I think so too. Also I thought these safe_* functions are more for
setting up the test, where it is more likely requesting existing groups.

Maybe for the fallback approach it could be handy. But if we really need
more then two options, I think passing a array would do it.
Or should we go with an array now?

> 
>> +	return rval;
>> +}
>> +
>>  int safe_chroot(const char *file, const int lineno, const char *path)
>>  {
>>  	int rval;
>> -- 
>> 2.16.4
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
