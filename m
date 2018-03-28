From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 28 Mar 2018 17:35:57 +0300
Subject: [LTP] [PATCH v2 1/2] include/lapi: add sctp.h
In-Reply-To: <20180326105555.GA7242@x230>
References: <1521819449-27489-1-git-send-email-alexey.kodanev@oracle.com>
 <1521819449-27489-2-git-send-email-alexey.kodanev@oracle.com>
 <20180326105555.GA7242@x230>
Message-ID: <210efb77-c661-5fdd-abd3-16e419103461@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 26.03.2018 13:55, Petr Vorel wrote:
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
>> ---
>> v2: include linux/sctp.h header and check it in the configure

Applied the patch-set.

> BTW SCTP_SOCKOPT_BINDX_ADD is defined in both <linux/sctp.h> and <netinet/sctp.h>, so if we
> ever in future want to have some definitions from netinet/sctp.h, I'd be to create special
> file include/lapi/netinet_sctp.h (the same like include/lapi/netinet_in.h - taking that
> default is for "kernel/").
>

I think if we have netinet/sctp.h it should take precedences
over linux/sctp.h. In OL7 it is provided by optional
lksctp-tools-devel package.

Thanks,
Alexey
 
> And we have included netinet/sctp.h in sources (utils/sctp/include/netinet/sctp.h), IMHO
> not good idea to have common headers in our sources.
> 


> 
> Kind regards,
> Petr
> 
