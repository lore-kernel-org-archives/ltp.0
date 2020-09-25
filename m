From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 25 Sep 2020 13:26:20 +0100
Subject: [LTP] [PATCH] tst_cgroup: Don't try to use V2 if V1 controllers
 are mounted
In-Reply-To: <CAEemH2e26TD5A2V8va6aBk1AaOiS65Qg9LK9YCr4gc+HPct4nA@mail.gmail.com>
References: <20200924111124.5666-1-rpalethorpe@suse.com>
 <CAEemH2eDPzfdUR78d_mSuaDgi=v1RuboDotNwAGrLHCCg1Q41A@mail.gmail.com>
 <877dsjxoak.fsf@suse.de>
 <CAEemH2f_PdJABqTYF6JUH-BVAPO+1kH1AOK0b+x9gpvbELzVKA@mail.gmail.com>
 <874knmxq2y.fsf@suse.de>
 <CAEemH2e26TD5A2V8va6aBk1AaOiS65Qg9LK9YCr4gc+HPct4nA@mail.gmail.com>
Message-ID: <871riqxcsz.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
> ...
>> >> I wonder if it would be better to simply try mounting/using V2 and if
>> >> that fails try V1?
>> >>
>> >
>> > That will be work but not good, because if cgroup mount fails, how do we
>> > know it is a bug or not support?
>>
>> I think this is a valid point if you are writing a test for mounting
>> cgroups. However if we are testing something else then trying to guess
>> if cgroups should be available before using them, makes the test
>> fragile. I suppose we could check *after* trying to use the cgroups so
>> we can report some diagnostic info.
>>
>
> This sounds practicable, please feel free to work out the patch.

OK, I just sent a new patch. However there is no diagnostic info yet,
I'm not sure if actually it would be better to make a test specifically
checking if cgroups can be mounted and checking what is in filesystems
and mounts.

-- 
Thank you,
Richard.
