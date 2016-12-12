From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 12 Dec 2016 14:52:20 +0300
Subject: [LTP] Invoking networking tests
In-Reply-To: <20161208173228.jixqv2xd6jqptz5i@dell5510>
References: <20161207141855.lvyrqs4cxhy4wr2c@dell5510>
 <58494350.80404@oracle.com> <20161208173228.jixqv2xd6jqptz5i@dell5510>
Message-ID: <584E8F74.80308@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 12/08/2016 08:32 PM, Petr Vorel wrote:
> Hi Alexey,
>
> thanks for info!
>
>> Please also see the recent patch:
>> 5f8ca6c ("network: test_net.sh: allow to run network tests on a single
>> machine")
> Noticed, I was waiting for pushing it to master :-). Looks interesting, I'll give it a try.
>
> Can it be "dangerous" to run tests "natively", i.e. without ltp-pan? It'd be run by
> automation (no cancel ctrl+c), so cleanup children is unlike.

I think it depends on automation and how far it controls started process.

Besides, converted to latest LTP API tests much safer in terms of per 
test lockups because
they have a test timeout there. As far as I know there is no such 
feature in new shell library
yet (tst_test.sh). It seems that it would be a good thing to have a 
timeout option in tst_rod() too.

Thanks,
Alexey

> Or is it also for cleanup
> when some test misbehave and it's being killed by kernel?
>
>
> Kind regards,
> Petr

