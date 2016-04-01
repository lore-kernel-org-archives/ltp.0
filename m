From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Apr 2016 13:11:17 +0800
Subject: [LTP] [PATCH V2] madvice: new case for madvise(WILLNEED)
In-Reply-To: <CAEemH2dyZGngeFBn41a2D_iZObQpYw2xMh94NGgq7YeYTB49_A@mail.gmail.com>
References: <1459245344-5983-1-git-send-email-liwang@redhat.com>
 <20160331115547.GA21298@rei.lan>
 <CAEemH2dyZGngeFBn41a2D_iZObQpYw2xMh94NGgq7YeYTB49_A@mail.gmail.com>
Message-ID: <CAEemH2f01fg8rogeYQpE1-Y_N0ii80_4O7ByLtQv9ZUn0wMW3w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

> +     if (tst_kvercmp(3, 9, 0) < 0)
>> > +             tst_brkm(TCONF, NULL, "madvise(MADV_WILLNEED) swap file"
>> > +                     "prefetch available only since 3.9");
>> > +
>>
>
I take use of these lines since I misunderstood that 'MASV_WILLNEED' is
involved since 3.9 kernel when I took a look at madvise05.c. But after
reading the MADVISE(2) in Linux Programmer's Manual, I realized that I was
wrong.

Then I tried this madvise06 testcase on both 2.6.18 and 2.6.32 kernel, it
also works well. So I decide to remove the lines in Patch V3.

-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160401/4d72b77b/attachment.html>
