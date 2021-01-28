From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 28 Jan 2021 06:33:21 +0100
Subject: [LTP] [PATCH] memcg/functional: Convert to newlib
In-Reply-To: <YBG49Ge71bTx5LZF@pevik>
References: <20210125131746.74630-1-lkml@jv-coder.de> <YBG49Ge71bTx5LZF@pevik>
Message-ID: <c01f4728-f8aa-7836-88c7-951ba506f8c3@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 1/27/2021 8:03 PM, Petr Vorel wrote:
> Hi,
>
> FYI there is bug related to these tests:
> https://github.com/linux-test-project/ltp/issues/780
Additionally there is
https://github.com/linux-test-project/ltp/issues/698
https://github.com/linux-test-project/ltp/issues/326
https://github.com/linux-test-project/ltp/issues/93

I guess the last one is invalid.
326 and 698 are basically duplicates due to inaccurate memory accounting 
in cgroups. The same as 780.
I did not fix these failures for now. I haven't checked the kernel sources.
There is a hint in the documentation for memory.usage_in_bytes "Of 
course, when necessary, it's synchronized.".
Maybe it is possible to force synchronization somehow.

I will look into this, after this is merged.
>
> Kind regards,
> Petr

