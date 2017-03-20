From: Maxin B. John <maxin.john@gmail.com>
Date: Mon, 20 Mar 2017 17:41:55 +0200
Subject: [LTP] [PATCH] setxattr: prefer not to run tests in tmpfs
In-Reply-To: <20170320153051.GC6102@rei.lan>
References: <1490020357-8073-1-git-send-email-maxin.john@gmail.com>
 <20170320151104.GB6102@rei.lan>
 <CAMhs6YznbBmsoY5B1zTA8Dg5+h9sD3GmhKdhgKoxSasraKYtGQ@mail.gmail.com>
 <20170320153051.GC6102@rei.lan>
Message-ID: <CAMhs6Ywe4-7Dmx+Xii=1y2ZkHPyUsjxoFORf8VmHumbp3ELGRw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Mon, Mar 20, 2017 at 5:30 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> > We can either exit the test with TCONF if /tmp is on tmpfs or format and
>> > mount a device and run these testcases on a file created there in that
>> > case.
>>
>> Thanks for sharing your thoughts. It is clear now.
>>
>> However, what about tests which fails by default on tmpfs like "fcntl" tests?
>> Should we default to the "/tmp" directory rather than mounting another device
>> and run the tests again ?
>
> Have a look at ftruncate04.c testcase, that falls back to mounting a
> device over the directory the test uses if needed.

That helps.  Thank you!

> --
> Cyril Hrubis
> chrubis@suse.cz

Warm Regards,
Maxin
