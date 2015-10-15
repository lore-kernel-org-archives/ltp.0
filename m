From: $rik@nth  <srikanth007m@gmail.com>
Date: Thu, 15 Oct 2015 22:04:57 +0530
Subject: [LTP] getpwnam(nobody) failed
In-Reply-To: <20151015141101.GB20237@rei.suse.cz>
References: <CANKSX+GTDu9Ce9UUmfWo4E4+uxNi9Dh8Ek=a9J2YM1=4sAZ9Pw@mail.gmail.com>
 <20151015141101.GB20237@rei.suse.cz>
Message-ID: <CANKSX+FGmzOL=YaaY6ahwvFL2Tg=zgDCUonfO+w5OJkYmpnjUg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thanks Cyril for chiming into the issue. But still it is creating
these nodes and users with permissions. There might be a use for some
operations  which needs to be running by nobody. Its just a guess, as
i didn't dive into bionic libc as you did it.

Does anyone in this group running LTP on android and observed similar
issue. Any pointers to fix this issue would really helps to lot of
users running LTP on android platform.



On Thu, Oct 15, 2015 at 7:41 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> Need some help in understanding the behavior of failure cases though
>> user 'nobody' is present. I am unable to figure it out as i am running
>> them on android kernel.
>
> I glanced over the bionic libc for android and it looks like /etc/passwd
> is not used at all. The calls are emualted using some android_id_info
> database there. I'm afraid that you have to look deeper into the bionic
> libc to figure out how exactly this works.
>
> --
> Cyril Hrubis
> chrubis@suse.cz



-- 
Thanks & Regards,
M.Srikanth Kumar.
