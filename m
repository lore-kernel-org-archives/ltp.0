From: Christian Amann <camann@suse.de>
Date: Fri, 7 Jun 2019 08:21:50 +0200
Subject: [LTP] TST_GET_UNUSED_PORT returns ports < 1024
In-Reply-To: <20190606144549.GA14501@dell5510>
References: <7b0b763f-0b6b-fb18-7916-d25afdcb5c68@suse.com>
 <20190606134321.GA30964@rei.lan> <20190606144549.GA14501@dell5510>
Message-ID: <31bcbd67-6afe-e88f-f3dd-3f464051fa57@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 06/06/2019 16:45, Petr Vorel wrote:
> Hi Cyril,
>
>>> when using the TST_GET_UNUSED_PORT macro you sometimes get ports lower
>>> than 1024 which would require a testcase to have the
>>> CAP_NET_BIND_SERVICE capability (or simply run as root).
>> Looking at the code as far as I can tell the function returns the port
>> in the network endianity, which is big endian. Intel CPUs are little
>> endian, so if you want to print the port you actually have to use
>> ntohs() function to convert it to the host endianity. And if you are
>> passing that value in the sockaddr_in structure you must not use the
>> htons() since the value is already in the correct byte order. And yes
>> this is horribly confusing, but that's how it is.
> Thanks for debugging the problem.
>
Yes, and also thanks for the clarification.
>> I guess that we should write down this piece of information in the
>> documentation, because it looks like the tst_get_unused_port shell
>> helper does this incorrectly and prints the raw value instead of
>> converting it with ntohs().
> Correct, I've sent a patch fixing it for shell tests [1].
> As I noted there, this problem was even on version for old API.
>
> Not sure about docs as there is no docs for network API shell/C functions yet
> But even the problem for shell was fixed by that patch it'd be worth to add note
> about byte order to C code tst_get_unused_port() and/or header defining
> TST_GET_UNUSED_PORT() developers using it in C.

I agree. From what I can tell there is no easy way to quickly determine
the endianness. A little hint would be nice to cut down development time
(and possibly time spent debugging later on).

> Kind regards,
> Petr
>
> [1] https://patchwork.ozlabs.org/patch/1111167/

Kind regards,

Christian


