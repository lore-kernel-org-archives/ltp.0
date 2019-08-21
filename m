From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 21 Aug 2019 13:43:34 +0200
Subject: [LTP] [RFC PATCH 1/1] capability: Introduce capability API
In-Reply-To: <20190809122741.GC32115@rei.lan>
References: <20190808153825.18363-1-rpalethorpe@suse.com>
 <20190808153825.18363-2-rpalethorpe@suse.com>
 <20190809122741.GC32115@rei.lan>
Message-ID: <87wof6vj4p.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

>> +
>> +struct tst_cap_user_header {
>> +	uint32_t version;
>> +	int pid;
>> +};
>> +
>> +struct tst_cap_user_data {
>> +	uint32_t effective;
>> +	uint32_t permitted;
>> +	uint32_t inheritable;
>> +};
>
> This two should probably go to lapi as well.

Ah, but the naming of the original structures is so bad.

typedef struct __user_cap_header_struct {
        ...
} __user *cap_user_header_t.

Well not necessarily bad, but against current naming guidelines. I would
rather just use our own definitions and keep them separate from any
fallback definitions for test writers.

>
>> +struct tst_cap {
>> +	uint32_t action;
>> +	uint32_t id;
>> +	char *name;
>> +};
>
> I wonder if we should build a table of capability names for translation
> just as we do errnos and signals instead of storing the name here. But I
> guess that unless we will need a function to translate capabilitities
> into strings on runtime this approach is simpler.

I suppose if we want to print all the current capabilities then we need
this. Which I can imagine would be useful, but I would rather wait until
someone actually needs it.


--
Thank you,
Richard.
