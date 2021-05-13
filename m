From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 13 May 2021 02:27:40 +0000
Subject: [LTP] syscalls/mallinfo01 test is broken
In-Reply-To: <YJvftrFCueG3TXPf@yuki>
References: <9d5d4dc9-ab51-7218-23f3-2ec835210fcf@suse.cz>
 <YJvftrFCueG3TXPf@yuki>
Message-ID: <609C8EBC.80409@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Martin
> Hi!
>> the mallinfo01 test is failing on some of our test machines because it
>> makes wrong assumptions about how malloc() and free() will change the
>> number of free chunks (ordblks). I recommend we remove the test from
>> runfiles before the upcoming release and fix it later because part of
>> the test scenario needs major redesign.
>
> I've started some pre-release testruns and I've seen some failures as
> well. I guess that removing it from runtest file and fixing it after
> release sounds sane at this point.
This case fails because malloc uses fastbin blocks.
So the fix has two ways
1) disable fastbin by using mallopt(M_MXFAST, 0)
2) use another mallinfo struct info3 to get free chunks, so compare 
info3 and info2 ordblks member.

Best Regards
Yang Xu

>
