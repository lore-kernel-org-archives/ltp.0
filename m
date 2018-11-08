From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Nov 2018 11:13:45 +0100
Subject: [LTP] [PATCH ltp v2 1/2] Add Intel umip(User Mode Instruction
 Prevention) basic function tests
In-Reply-To: <20181107132004.6dc7t36pxznb4xyb@xpf-desktop>
References: <20181101014928.23628-1-pengfei.xu@intel.com>
 <20181107101520.GB8603@rei>
 <20181107132004.6dc7t36pxznb4xyb@xpf-desktop>
Message-ID: <20181108101345.GA29767@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Is there any other way how to find out UMIP has been enabled in kernel?
> > 
> > I would like to avoid maitaing code that tries to look for all possible
> > config locations if possible.
> > 
>   Could find "Activated the Intel User Mode Instruction Prevention (UMIP)
>   CPU feature" info in the head of dmesg, but afraid boot long time dmesg
>   head is covered... And no sysfs file for umip to check.
>   So could I add the info when cases failed???"possible due to
>   kconfig not set CONFIG_X86_INTEL_UMIP=y"?

I was looking into this yesterday and even talked to our kernel devs and
it seems that there is no other option than checking the .config to be
sure it was enabled.

So we may end up adding support for parsing the kernel config, it would
be probably useful in differents parts of LTP. But to make this happen
we should make it a library function and make sure it's accesible for C
testcases as well.

I can look into that and try to post a RFC patch later on, but it would
probably take more than week to get sorted out.

-- 
Cyril Hrubis
chrubis@suse.cz
