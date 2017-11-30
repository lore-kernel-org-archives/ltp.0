From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Date: Thu, 30 Nov 2017 16:41:23 +0000
Subject: [LTP] [PATCH v2 10/13] getdtablesize01: Handle ENFILE errno
In-Reply-To: <20171130162048.GA18365@rei>
References: <20171114155929.24237-1-punit.agrawal@arm.com>
 <20171114155929.24237-11-punit.agrawal@arm.com> <20171130131259.GB2924@rei>
 <87k1y7zr7a.fsf@e105922-lin.cambridge.arm.com> <20171130162048.GA18365@rei>
Message-ID: <a41c16d3-54e2-5e03-4c62-574ccd92bebb@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 30/11/17 16:20, Cyril Hrubis wrote:
> Hi!
>>>>   //Now the max files opened should be RLIMIT_NOFILE - 1 , why ? read getdtablesize man page
>>>>   
>>>> -	if (count > 0)
>>>> -		close(count);
>>>>   	if (count == (max_val_opfiles - 1))
>>>>   		tst_resm(TPASS, "%d = %d", count, (max_val_opfiles - 1));
>>>
>>> We may also check for EMFILE here.
>>
>> I don't understand what you're suggesting here.
> 
> When process has exhausted the maximal number of file descriptors it can
> open we are supposted to fail with EMFILE, when that happened to the
> whole system before we hit the per process limit we get ENFILE. So I was
> suggesting that we may as well check that we were able to open expected
> number of file descriptors and that the last open() failed with EMFILE.

But isn't that we check already ? I mean, the test already gets the limit
on number of open files for this process and tries to open one less fd.
So I don't think we should check that error. If we get that error, something
else is wrong in the accounting and should be treated as an error.

Suzuki



> 


