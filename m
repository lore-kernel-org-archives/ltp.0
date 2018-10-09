From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Tue, 9 Oct 2018 11:25:23 -0300
Subject: [LTP] [PATCH] syscalls/fsetxattr02.c: Fix missing ramdisk
	module error
In-Reply-To: <20181009141725.GD16630@rei>
References: <CABdQkv-px744Mc-RVH=Tpa+TPqhs3tYn-D8=JgzBdjmwMtpDVA@mail.gmail.com>
 <20181008154620.25237-1-rafael.tinoco@linaro.org>
 <20181009141725.GD16630@rei>
Message-ID: <b9d064ce-6ff2-16ba-013b-b9c0b14f6d84@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/9/18 11:17 AM, Cyril Hrubis wrote:
> Hi!
>> +#define DRVRAMDISK "brd"
> 
> I find it a bit silly to define a macro for a string that is used
> exactly once. Why can't we just write "brd", in the needed_drivers?

I got it from from an existing test Cyril. I confess I thought the same 
=), was afraid of being an etiquette or something. Feel free to drop it, 
no hard feelings!
