From: $rik@nth  <srikanth007m@gmail.com>
Date: Fri, 16 Oct 2015 18:01:18 +0530
Subject: [LTP] getpwnam(nobody) failed
In-Reply-To: <CANKSX+FGmzOL=YaaY6ahwvFL2Tg=zgDCUonfO+w5OJkYmpnjUg@mail.gmail.com>
References: <CANKSX+GTDu9Ce9UUmfWo4E4+uxNi9Dh8Ek=a9J2YM1=4sAZ9Pw@mail.gmail.com>
 <20151015141101.GB20237@rei.suse.cz>
 <CANKSX+FGmzOL=YaaY6ahwvFL2Tg=zgDCUonfO+w5OJkYmpnjUg@mail.gmail.com>
Message-ID: <CANKSX+FccadtFf6N5VsmG0VjiH7tC8+XpRPyNB7BeoPv5XvUhQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril,

I came across the implementation of getpwnam in bionic. But i am not
getting on how to overcome to apply bionic changes to existing LTP for
checking.

https://github.com/android/platform_bionic/blob/master/libc/bionic/stubs.cpp

On Thu, Oct 15, 2015 at 10:04 PM, $rik@nth <srikanth007m@gmail.com> wrote:
> Thanks Cyril for chiming into the issue. But still it is creating
> these nodes and users with permissions. There might be a use for some
> operations  which needs to be running by nobody. Its just a guess, as
> i didn't dive into bionic libc as you did it.
>
> Does anyone in this group running LTP on android and observed similar
> issue. Any pointers to fix this issue would really helps to lot of
> users running LTP on android platform.
>
>
>
> On Thu, Oct 15, 2015 at 7:41 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
>> Hi!
>>> Need some help in understanding the behavior of failure cases though
>>> user 'nobody' is present. I am unable to figure it out as i am running
>>> them on android kernel.
>>
>> I glanced over the bionic libc for android and it looks like /etc/passwd
>> is not used at all. The calls are emualted using some android_id_info
>> database there. I'm afraid that you have to look deeper into the bionic
>> libc to figure out how exactly this works.
>>
>> --
>> Cyril Hrubis
>> chrubis@suse.cz
>
>
>
> --
> Thanks & Regards,
> M.Srikanth Kumar.



-- 
Thanks & Regards,
M.Srikanth Kumar.
