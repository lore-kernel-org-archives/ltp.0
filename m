From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 7 Jul 2021 10:48:01 +0200
Subject: [LTP] [PATCH] kill13, CVE-2018-10124: Reproduce INT_MIN negation
In-Reply-To: <43e8b66b-04df-9c4f-c47b-aba13347b6d8@jv-coder.de>
References: <20210707071838.27834-1-rpalethorpe@suse.com>
 <43e8b66b-04df-9c4f-c47b-aba13347b6d8@jv-coder.de>
Message-ID: <6c665478-d831-9e3f-470c-8538a399e4f7@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 7/7/2021 10:35 AM, Joerg Vehlow wrote:
> Hi Richard,
>
> On 7/7/2021 9:18 AM, Richard Palethorpe via ltp wrote:
>>
> Results in INT_MIN? What does this mean or did you meant to write 
> results in ESRCH?
> Default negating int min in two's complement yields 0 (INT_MIN = 
> b1000... and negating means inverting the first bit -> thus 0).
Nevermind... Just checked. Looks like somehow x86 keeps -INT_MIN.
Now I know what you mean with "results in INT_MIN"

Joerg



