From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 22 Dec 2016 00:43:58 +0300
Subject: [LTP] [PATCH] network: fix telnet test for running on single
 machine
In-Reply-To: <20161221162748.suos5o54trzjrj2h@dell5510>
References: <20161219154433.19861-1-pvorel@suse.cz>
 <e6ef2253-fff1-2114-1def-d88cf82df809@oracle.com>
 <20161221162748.suos5o54trzjrj2h@dell5510>
Message-ID: <585AF79E.7010708@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 21.12.2016 19:27, Petr Vorel wrote:
> Hi,
>
>> It seems there are several solutions:
>> 1. we could do something similar to ssh/dns/http tests,
>>     i.e. start the client side from remote host;
> What means "remote host" in this context?

Inside network namespace (ltp_ns)

>
>> 2. add $(tst_ipaddr rservice), and in case of netns, it will return
>> 127.0.0.1/::1 addresses;
>> 3. start those services inside ltp_ns;
> No idea, what is the easiest solution. Maybe 2.?

Yeah, that one seems the easiest.

Best regards,
Alexey

>
>
> Kind regards,
> Petr

