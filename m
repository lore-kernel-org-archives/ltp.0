From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 15 Jun 2021 11:59:35 +0200
Subject: [LTP] [PATCH] ssh-stress: Convert to new api
In-Reply-To: <YMdgXPeTNHMtna/M@pevik>
References: <20210610101917.1251564-1-lkml@jv-coder.de>
 <YMcB3Wcu0J9C3Z/Q@pevik> <5db0624b-a6ce-2c02-d1d4-52034c85b2f1@jv-coder.de>
 <YMdgXPeTNHMtna/M@pevik>
Message-ID: <0324b896-0ef7-66d3-3d2c-9b9817721500@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 6/14/2021 3:57 PM, Petr Vorel wrote:
>
>>> Out of curiosity, did you test this on Two Host Configuration [2] (i.e. ssh)?
>>> Or just netns?
>> No, but should have...
>> I found two major problems with the test (will send a v2). But apart from
>> that, either I was not able to find the documentation or it is not clear
>> enough to me, how to run the two host setup.
>> I found network/README.md, but it only mentions to set RHOST, but for my
>> setup (with ips different from the default ones, IPV{4,6}_{L,R}HOST is also
> Yes we should be more verbose at Two Host Configuration [1] as there is nothing
> more. At least to mention IPV{4,6}_{L,R}HOST.
+1
>> required) and ltp must already be in the PATH on rhost, which was not
>> possible for my rhost setup, where the filesystem is read-only and I had to
>> hack setting the path into tst_rhost_run. It is not totally clear, that ltp
> What exactly was your problem? Having to modify PATH on shell config on read
> only system? I'll send a proposal to set PATH in tst_test.sh.
The simplest way to set the path would be in .profile on the rhost, but 
since the whole fs was readonly, this was not possible.
I somehow thought ltp would take care of setting the path and also 
exporting LTPROOT automatically, because according to the documentation, 
it expects to find ltp at the same path as on the LHOST.
Maybe this restriction could even be lifted, if the LHOST sets the paths 
on the RHOST (something like RHOST_LTPROOT, which defaults to LTPROOT). 
This could then be used to set PATH on RHOST as you suggested.
For my tests I just added "export PATH=$PATH;" to the rhost ssh command. 
It wanted to use just "PATH=$PATH", but that did not work because I used 
command grouping in the ssh-stress test.
"X=1 ( echo $X )" fails with a syntax error. With export it works and I 
guess it should be implemented cleaner than just forcing the whole PATH 
from the LHOST onto the RHOST as I did.

J?rg
