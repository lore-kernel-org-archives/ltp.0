From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Jun 2018 16:56:53 +0800
Subject: [LTP] [RFC PATCH 3/9] syscalls/ipc: Rewrite msgctl01 + merge
	msgctl06
In-Reply-To: <20180620105728.GB23700@rei>
References: <20180612154631.435-1-chrubis@suse.cz>
 <20180612154631.435-4-chrubis@suse.cz>
 <CAEemH2fmszUp0TMC24+kJuGYrBbwyrwe67B28AoWB16-MCj89A@mail.gmail.com>
 <20180620105728.GB23700@rei>
Message-ID: <CAEemH2d3GsE_zMDqA4=ek0iEZ_yO6OO_0PdGkSC_djCODuc-KA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Wed, Jun 20, 2018 at 6:57 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> ???
>> ???I'm thinking that whether 1 second is enough for system shaking. ???If this
>> program is running on an overload system, this maybe delay more than 1
>> second and test fails, is that a test defect????
>
> Since we are calling just two subsequent syscalls here it's very
> unlikely that the difference in times will be greater than 1s even on
> loaded system, but for sure we can increase that to two or three that
> wouldn't do any harm.

Ok, fine.

>
>> Maybe gives more flexible as:
>>     if (buf.msg_ctime <= creat_time && buf.msg_ctime >= creat_time - 3)
>>
>>
>> > +               tst_res(TPASS, "msg_ctime = %lu, expected %lu",
>> > +                       (unsigned long)buf.msg_ctime, (unsigned
>> > long)creat_time);
>> > +       } else {
>> > +               tst_res(TPASS, "msg_ctime = %lu, expected %lu",
>> >
>>
>> ???seems typo here?  TFAIL
>
> Right, thanks for pointing it out!
>
>> > +                       (unsigned long)buf.msg_ctime, (unsigned
>> > long)creat_time);
>> > +       }
>>
>>
>> >
>> ???Beside that, I got this follow errors occasionally:
>>
>> ???# ./msgctl01
>> tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
>> tst_safe_sysv_ipc.c:51: BROK: msgctl01.c:137: msgget(1627794347, 7b0)
>> failed: EEXIST???
>
> That means that there is some leftover message queue on the system,
> there may be a problem in how the IDs are allocated in the IPC test
> library.
>
> Do you have any steps to reproduce the issue?

No, but I will look it closely then.

BTW, this failure is not caused by your patch. I'm sure that I can
reproduce it without your patch apply at that moment.

And, for the patch set, LGTM.


-- 
Regards,
Li Wang
