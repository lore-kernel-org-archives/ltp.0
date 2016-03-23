From: Cui Bixuan <cuibixuan@gmail.com>
Date: Wed, 23 Mar 2016 19:59:27 +0800
Subject: [LTP] [PATCH] max_map_count: fix error by using runtime check
In-Reply-To: <1242994016.13404335.1458728559657.JavaMail.zimbra@redhat.com>
References: <56DD6138.9060109@huawei.com> <20160322102943.GA10195@rei.suse.cz>
 <56F14D59.1040701@huawei.com> <20160322142842.GE10905@rei.suse.cz>
 <56F259A7.1080908@huawei.com>
 <1242994016.13404335.1458728559657.JavaMail.zimbra@redhat.com>
Message-ID: <56F2851F.8080103@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



在 2016/3/23 18:22, Jan Stancek 写道:


>> -	if (!strcmp(buf, "[vsyscall]"))
>> -		return true;
>> -#elif defined(__ia64__)
>> -	/* On ia64, the vdso is not a proper mapping */
>> -	if (!strcmp(buf, "[vdso]"))
>> -		return true;
>> -#elif defined(__arm__)
>> -	/* Older arm kernels didn't label their vdso maps */
>> -	if (!strncmp(line, "ffff0000-ffff1000", 17))
>> -		return true;
>> -#endif
>> +	if (strstr(un.machine, "x86") != NULL)
>
> What if uname contains i386?
Yes, you are right, I have a mistake.

>
> Can we relax the pass condition to allow map_count to be
> within some tolerance? Then we wouldn't have to worry so much about
> all arch specifics.
Does it influence the case if we relax the pass condition?  I think we 
shuold think about it.

Thanks
Cui Bixuan
>
>

>>   	return false;
>>   }
>> --
>> 1.8.3.4
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>>
>
