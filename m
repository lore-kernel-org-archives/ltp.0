From: Li Wang <liwang@redhat.com>
Date: Thu, 15 Jun 2017 17:38:42 +0800
Subject: [LTP] [PATCH] dio: reduce the number of cycles
In-Reply-To: <20170615092307.GA27932@rei.lan>
References: <20170614033830.12736-1-liwang@redhat.com>
 <20170614111610.GC17436@eguan.usersys.redhat.com>
 <20170614134939.GB7604@rei.suse.de>
 <20170615065430.GE17436@eguan.usersys.redhat.com>
 <20170615092307.GA27932@rei.lan>
Message-ID: <CAEemH2ebRhRDST+HMUB=LUge_w5TvEC7PaYDwCYxaP+hGjpiyQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jun 15, 2017 at 5:23 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> > What's the reliability after the patch btw? What is the actual
>> > percentage of undetected failures for at least 10 runs of the test?
>>
>> I ran diotest30 10 times with "-i 100" and 8 of them failed. IIRC, it
>> was not 100% reproduced either when I first saw the test failure in
>> 4.10-rc kernel testing. So I think ~80% probability to reproduce is
>> fine.
>
> Fair enough I've added this paragraph to the commit message and pushed,
> thanks.

Hmm, it does not takes about 100 minutes, without this change, it
takes almost 9mins. After applying, only 50secs.

That's probably my description misleading you, sorry about that. Since
you have already submitted this patch, so, let it go.


=============
commit b246897a5a8e31b47442d15d7854a0eb8e64e949
Author: Li Wang <liwang@redhat.com>
Date:   Wed Jun 14 11:38:30 2017 +0800

    dio: reduce the number of cycles

    These two cases (dio29/30) takes about 100 minutes, but they're not
    stress test, so I suggest reducing the number of cycles.

    After the change on my RHEL-7.3 (23G RAM, 24 CPU(s), x86_64) box, it
    still takes almost 9 mins.

      diotest06    1  TPASS  :  Read with Direct IO, Write without
      diotest06    2  TPASS  :  Write with Direct IO, Read without
      diotest06    3  TPASS  :  Read, Write with Direct IO
      diotest06    0  TINFO  :  3 testblocks 1000 iterations with 100
children completed

      real  8m4.805s
      user  71m36.722s
      sys   8m51.649s

==============




-- 
Li Wang
liwang@redhat.com
