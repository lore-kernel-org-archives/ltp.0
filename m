From: Punit Agrawal <punit.agrawal@arm.com>
Date: Fri, 01 Dec 2017 15:30:51 +0000
Subject: [LTP] [PATCH v2 10/13] getdtablesize01: Handle ENFILE errno
In-Reply-To: <20171201133857.GB30225@rei> (Cyril Hrubis's message of "Fri, 1
 Dec 2017 14:38:57 +0100")
References: <20171114155929.24237-1-punit.agrawal@arm.com>
 <20171114155929.24237-11-punit.agrawal@arm.com>
 <20171130131259.GB2924@rei>
 <87k1y7zr7a.fsf@e105922-lin.cambridge.arm.com>
 <20171130162048.GA18365@rei>
 <a41c16d3-54e2-5e03-4c62-574ccd92bebb@arm.com>
 <20171201133857.GB30225@rei>
Message-ID: <874lpazcr8.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > When process has exhausted the maximal number of file descriptors it can
>> > open we are supposted to fail with EMFILE, when that happened to the
>> > whole system before we hit the per process limit we get ENFILE. So I was
>> > suggesting that we may as well check that we were able to open expected
>> > number of file descriptors and that the last open() failed with EMFILE.
>> 
>> But isn't that we check already ? I mean, the test already gets the limit
>> on number of open files for this process and tries to open one less fd.
>
> As far as I can tell it tries to open as much fds as is the limit, the
> loop is kind of silly since it starts at 1 and the condition is <= but
> that should call open the open number of limit times.
>
>> So I don't think we should check that error. If we get that error, something
>> else is wrong in the accounting and should be treated as an error.
>
> But the loop never finishes and the open() always fails with EMFILE
> because process has at least three fds opened when it starts (the
> stdin/stdout/stderr are inherited from the parent). Hence the loop is
> always broken on fd == -1.
>
> I guess that we may as well change the loop to infinite one, which would
> be less confusing in this case.

Ok, I've changed the for loop to start from 0 and dropped the stopping
condition.

Thanks,
Punit
