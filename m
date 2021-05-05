From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 05 May 2021 11:27:34 +0100
Subject: [LTP] [PATCH v2 2/5] bpf: Add map_array helper functions
In-Reply-To: <YIvAVaPNyunDHxaF@yuki>
References: <20210429150510.21585-1-rpalethorpe@suse.com>
 <20210429150510.21585-3-rpalethorpe@suse.com> <YIvAVaPNyunDHxaF@yuki>
Message-ID: <87wnsdlbl5.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> +long bpf_map_array_get(const int map_fd,
>> +		       const uint32_t *const array_indx,
>> +		       uint64_t *const array_val)
>
> Wouldn't the API be nicer if we passed just index value and returned the
> map value? We do TBROK if something goes wrong anyways, so there is no
> point in passing the return value from the bpf() syscall.

It would be nicer, but the existing tests put the key and value in
guarded buffers. I guess there are other types of memory we might want
to pass a pointer to as well.

-- 
Thank you,
Richard.
