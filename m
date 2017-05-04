From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 4 May 2017 17:52:13 +0300
Subject: [LTP] [RFC PATCH v5 0/3] Simplify network setup
In-Reply-To: <20170504134613.tyinrlvw4iagn2lh@dell5510>
References: <20170503160751.1634-1-pvorel@suse.cz>
 <8a43347a-716f-7ce6-2758-e5eda838e265@oracle.com>
 <20170504134613.tyinrlvw4iagn2lh@dell5510>
Message-ID: <7643d4a3-2aa5-7713-a634-4344f0d64233@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04.05.2017 16:46, Petr Vorel wrote:
> Hi Alexey,
>
>>> There is still requirement network prefix to be < 8 (IPv4) resp. 16 (IPv6) as
>>> then IPV{4,6}_NETWORK variables would be empty, which is not expected by tests
>>> (they join it with address separators with {L,R}HOST_IPV{4,6}_HOST. Even we got
>>> rid of reverse related variables we still need IPV{4,6}_NETWORK variables for
>>> some tests.
>> Hi Petr,
>> But you removed such dependency on the prefix from test_net.sh  in
>> the third patch... so we could just print the warning that configuration
>> is not appropriate for the old tests, that is for stress/multicast,
>> stress/route groups only.
> Right, I'll remove requirement network prefix to be < 8 (IPv4) resp. 16 (IPv6).
> There are other restrictions you probably don't like:
> * Don't use 32 (IPv4) and 128 (IPv6): I'd keep this restriction. What do you think?
> * Require to use the same prefix: I'd keep it for now.

I'm for a warning message that some network/stress tests not supporting
such config.

Thanks,
Alexey
