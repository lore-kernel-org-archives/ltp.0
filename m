From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 1 Dec 2017 14:30:40 +0300
Subject: [LTP] [PATCH] ipsec: fix vti ipcomp test-cases
In-Reply-To: <20171128223615.4u5tl6icpmzz6byc@dell5510>
References: <1511881504-13160-1-git-send-email-alexey.kodanev@oracle.com>
 <20171128223615.4u5tl6icpmzz6byc@dell5510>
Message-ID: <47596972-30ae-0ad6-70f3-9f1a14f51c95@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/29/2017 01:36 AM, Petr Vorel wrote:
> Hi Alexey,
>> VTI is not designed to handle ipcomp when packets sent without
>> transformation, see also: https://patchwork.ozlabs.org/patch/840445/
>

> Acked-by: Petr Vorel <pvorel@suse.cz>
>
> Thanks for taking care of it!

Applied.

Thanks,
Alexey

