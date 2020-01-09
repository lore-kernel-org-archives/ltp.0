From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 9 Jan 2020 15:37:19 +0800
Subject: [LTP] [PATCH] tst_device: add new tst_dev_sync
In-Reply-To: <20200108114545.GA28867@dell5510>
References: <20200107071324.29492-1-liwang@redhat.com>
 <20200107101119.GA22967@rei.lan>
 <CAEemH2fmmQ2a0EVHoqkMwMOjy5EZoiNT+02yYRz-TnWpTQ__0A@mail.gmail.com>
 <20200108112537.GA22954@dell5510> <20200108113535.GA17272@rei.lan>
 <CAEemH2dZ0pVqpaecjO06stw8RiK-hmSUWwo=kndm3EsvoXCW2w@mail.gmail.com>
 <20200108114141.GB17272@rei.lan> <20200108114545.GA28867@dell5510>
Message-ID: <5518d8cd-7d35-8c65-e881-5f49c73dc379@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr
> Hi Li, Cyril,
> 
>> Hi
>>> Btw I just pushed a simple fix to include unistd.h, it seems not works.
> 
>> You would need to define _GNU_SOURCE at the top of each test that uses
>> it otherwise the definition is not exposed.
> Yep :(. I join to Cyril's vote for raw syscall.
> BTW please test it with travis or locally build.sh script (which adds
> -Werror=implicit-function-declaration).
> 
> I guess we should work on travis CI integration so we don't have to push it to
> travis manually [1].
Do we have a tool or a function that
when this pushing patch complie succeeded, then merge successfully or 
reject auto because of fail. Like gerrit.
Or, pushing patch compiler on travis CI first, then merged into ltp master.

If not, it seems that we can only try on our own ltp fork(Usually, I do 
it when I write a new case or cleanup)

Best Regards
Yang Xu
> 
> Kind regards,
> Petr
> 
> [1] https://github.com/linux-test-project/ltp/issues/599
> 


