From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 29 Nov 2017 13:11:25 +0300
Subject: [LTP] [PATCH] ipsec: fix vti ipcomp test-cases
In-Reply-To: <20171128223615.4u5tl6icpmzz6byc@dell5510>
References: <1511881504-13160-1-git-send-email-alexey.kodanev@oracle.com>
 <20171128223615.4u5tl6icpmzz6byc@dell5510>
Message-ID: <250f5dc3-2cb4-19ea-e2d2-4e87c63f1ec6@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/29/2017 01:36 AM, Petr Vorel wrote:
> Hi Alexey,
>> VTI is not designed to handle ipcomp when packets sent without
>> transformation, see also: https://patchwork.ozlabs.org/patch/840445/
>> Adjust test-cases so that ipcomp header always used.
>                                           ^ Do you mean never?

No, vti only works with ipcomp, esp or ah packets.

Thanks,
Alexey


>
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Acked-by: Petr Vorel <pvorel@suse.cz>
>
> Thanks for taking care of it!
>
> Kind regards,
> Petr

