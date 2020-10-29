From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 29 Oct 2020 17:05:34 +0100
Subject: [LTP] [PATCH 04/19] Unify error handling in lib/safe_file_ops.c
In-Reply-To: <20201029160222.GD8378@yuki.lan>
References: <20201026164756.30556-1-mdoucha@suse.cz>
 <20201026164756.30556-5-mdoucha@suse.cz> <20201029155907.GC8378@yuki.lan>
 <20201029160222.GD8378@yuki.lan>
Message-ID: <af6cdfdd-23e8-1593-9509-43685e4706c3@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 29. 10. 20 17:02, Cyril Hrubis wrote:
> Hi!
>>> diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
>>> index e06d399fa..a63368875 100644
>>> --- a/lib/safe_file_ops.c
>>> +++ b/lib/safe_file_ops.c
>>> @@ -84,9 +84,8 @@ int file_scanf(const char *file, const int lineno,
>>>  	f = fopen(path, "r");
>>>  
>>>  	if (f == NULL) {
>>> -		tst_resm(TWARN,
>>> -			"Failed to open FILE '%s' at %s:%d",
>>> -			 path, file, lineno);
>>> +		tst_resm_(file, lineno, TWARN, "Failed to open FILE '%s'",
>>> +			path);
>>>  		return 1;
>>
>> scanf() returns negative value on error, I guess it would make more
>> sense to return -1 here and in many cases below.
> 
> That's true for printf() scanf returns EOF instead. But I guess that
> anything < 0 would work better than 1 which means that one input item
> was matched successfuly...

These safe file functions could use some additional improvements but
changing the return value is out of scope of my patchset. That would
probably require reviewing and modifying some test code as well. The
patchset is over 4000 lines long as is.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
