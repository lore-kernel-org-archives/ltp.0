From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 15 Dec 2016 15:12:49 +0300
Subject: [LTP] [PATCH 1/1] network/echoes: fix endless loop on error
In-Reply-To: <20161215115111.srk5fmrehsllbhuw@x230>
References: <20161129160259.31058-1-pvorel@suse.cz>
 <5846989A.2020104@oracle.com> <20161214170604.nycf5yipmdvcyss7@dell5510>
 <5852831E.6070608@oracle.com> <20161215115111.srk5fmrehsllbhuw@x230>
Message-ID: <585288C1.9070000@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 15.12.2016 14:51, Petr Vorel wrote:
> Hi Alexey,
>
>> OK,  but if we want a quick fix here we can just add a single "break" after
>> the loop where
>> it is killing all the left child processes. No need to proceed anyway. If
>> you agree I'll push
>> the patch with the break version:
> Sure, push this version. Thanks!

Applied the patch, thank you.

Best regards,
Alexey
