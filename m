From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 14 Jul 2021 14:06:51 +0100
Subject: [LTP] [PATCH v2 1/8] Add Sparse based checker and TST_RET/ERR
 check
In-Reply-To: <36430750-17c9-06e4-0f49-efc744116154@jv-coder.de>
References: <20210714071158.15868-1-rpalethorpe@suse.com>
 <20210714071158.15868-2-rpalethorpe@suse.com>
 <36430750-17c9-06e4-0f49-efc744116154@jv-coder.de>
Message-ID: <87y2a9nixg.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Joerg,

Joerg Vehlow <lkml@jv-coder.de> writes:

> Hi,
>
>
> On 7/14/2021 9:11 AM, Richard Palethorpe via ltp wrote:
>> Vendors in Sparse as a git module. Then uses it to check for stores to
>> TST_RET/ERR within the library.
>>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> ---
>>   .gitmodules             |   3 +
>>   tools/Makefile          |   2 +
>>   tools/sparse/.gitignore |   1 +
>>   tools/sparse/Makefile   |  27 ++++++++
>>   tools/sparse/README.md  |  38 +++++++++++
>>   tools/sparse/main.c     | 148 ++++++++++++++++++++++++++++++++++++++++
> I think the name could be a bit better... sparse_main or ltp_checker
> or something, because a binary just called main could be confusing.

Sure or maybe sparse-ltp?

That would fit with upstream IMO.

>
> Otherwise good basis for additional checks and fixing the warnings
> emitted by sparse will allow use to raise the overall warning level.
> Hopefully at some point at least "-Wall -Werror" is possible.
>
> Joerg

Yes, I would really like to see -Wall enabled by default. Also Sparse
can maybe help highlight wierd crap only GCC and Clang accept.

-- 
Thank you,
Richard.
