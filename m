From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 4 May 2017 14:09:46 +0300
Subject: [LTP] [RFC PATCH v5 0/3] Simplify network setup
In-Reply-To: <20170503160751.1634-1-pvorel@suse.cz>
References: <20170503160751.1634-1-pvorel@suse.cz>
Message-ID: <8a43347a-716f-7ce6-2758-e5eda838e265@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03.05.2017 19:07, Petr Vorel wrote:
> Hi,
>
> another version of tst_net_vars network setup helper.
> v4->v5:
> * Clenup unneded variables (reverse IP related).
> * Don't require to have mask in IP address. Use netlink to detect prefix when
>   address is presented on some of the NIC on the system or fallback to default
>   ones (24 for IPv4, 64 for IPv6).
> * Fix detecting wrong subnet with network not round up by 8 (IPv4 resp 16
>   (IPv6). E.g.: problem IP addressed like 10.2.0.1/22 10.2.1.1/22.
> * Add more environment variables (e.g. prefix, whole IP address)
> * Rewritten (again) unused network generation to fix overlap with used IP addresses.
> * Simplify tst_ipaddr() (in testcases/lib/test_net.sh).
> * Use tst_brk() to exit on error.
> * Cleanup warnings and formatting.
>
> There is still requirement network prefix to be < 8 (IPv4) resp. 16 (IPv6) as
> then IPV{4,6}_NETWORK variables would be empty, which is not expected by tests
> (they join it with address separators with {L,R}HOST_IPV{4,6}_HOST. Even we got
> rid of reverse related variables we still need IPV{4,6}_NETWORK variables for
> some tests.

Hi Petr,

But you removed such dependency on the prefix from test_net.sh  in
the third patch... so we could just print the warning that configuration
is not appropriate for the old tests, that is for stress/multicast,
stress/route groups only.

Thanks,
Alexey

