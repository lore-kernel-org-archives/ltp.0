From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 17 Nov 2020 08:55:04 +0000
Subject: [LTP] [PATCH] madvise06: Do no set swap limit
In-Reply-To: <CAEemH2frY_yJhm1sh6YQFH84J6CzTr0z2UzW-Ofz4fnod1O3fA@mail.gmail.com>
References: <20201116085844.29499-1-rpalethorpe@suse.com>
 <CAEemH2frY_yJhm1sh6YQFH84J6CzTr0z2UzW-Ofz4fnod1O3fA@mail.gmail.com>
Message-ID: <878sb0pdlj.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>
> On Mon, Nov 16, 2020 at 4:59 PM Richard Palethorpe <rpalethorpe@suse.com>
> wrote:
>
>> Setting the swap limit is unnecessary for this test. By default it
>> appears to be set to some large value which is OK. Setting it may fail
>> for reasons unrelated to the test's purpose making the test less
>> reliable.
>>
>
> Generally, this is right. And if the 'memory.limit_in_bytes' has been set
> successfully, that means the default value of 'memory.memsw.limit_in_bytes'
> is bigger than or equal to it.
> (an invalid argument error will occur if not like this)
>
> But in this madvise06, set 'memory.memsw.limit_in_bytes' will safer to test.
>
> The reason is to make sure memsw.limit_in_bytes' is bigger(twifold) than
> 'memory.limit_in_bytes' otherwise it can't be finished as we expected.
> (madvise06 will be stuck when memsw.limit_in_bytes < 2 *
> memory.limit_in_bytes)

OK.

>
>
>>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> ---
>>
>> I should not have included this in the first update to the test. It
>> appears that it fails with EACCES on at least one configuration, where
>> the test ran previously. Also it could fail with EBUSY in theory.
>>
>> I don't know why limit_in_bytes can be set, but memsw.limit_in_bytes
>> results in EACCES. This is interesting, however should be the focus of
>> a different test IMO.
>>
>
> This sounds like a cgroup issue or related configuration caused.

Yes, it is probably due to the memsw counter being disabled. So I will
send a V2 of the other madvise06 patch.

-- 
Thank you,
Richard.
