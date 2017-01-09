From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 09 Jan 2017 15:09:46 +0300
Subject: [LTP] [PATCH 2/3] test_net.sh: delete netns before testing
In-Reply-To: <20161223110434.a2qs3qlofj5l7bkd@dell5510>
References: <20161221230422.26696-1-pvorel@suse.cz>
 <20161221230422.26696-2-pvorel@suse.cz>
 <7d5f577f-1484-6655-8401-1a2c76b2c56e@oracle.com>
 <20161223110434.a2qs3qlofj5l7bkd@dell5510>
Message-ID: <58737D8A.8000705@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 23.12.2016 14:04, Petr Vorel wrote:
> Hi Alexey,
>> Hmm, could you describe the error you are getting?
>> I cannot reproduce it in my environment.
>> ...or is it about setting IPv6 address for the second time on the interface,
>> because network.sh and test_net.sh are both using the same '-6' option?
>> network_settings 1 TINFO : set local addr fd00:1:1:1::2/64
>> RTNETLINK answers: File exists
> I don't know why (probably bad setup or something on my side), but sometimes it even it's
> ltp_ns setup (/var/run/netns/ltp_ns exists), ltp_ns_veth2 device is not available
> (directory /sys/class/net/ltp_ns_veth2/ doesn't exist):

Have you tried upstream kernels?

> /opt/ltp/testscripts/network.sh -6
> ...
> cmdline="ping01.sh -6"
> contacts=""
> analysis=exit
> <<<test_output>>>
> cat: /sys/class/net/ltp_ns_veth2/address: No such file or directory
> ...
> ping01 1 TINFO : ping6 with 8 16 32 64 128 256 512 1024 2048 4064 ICMP packets
> ping01 1 TFAIL : ping6 -c 3 -s 8 fd00:1:1:1::1 >/dev/null failed unexpectedly
>
>> Moreover, it's not needed to set TST_USE_NETNS.
> OK, do I understand that for netns I don't need to setup any variable?

This configuration allows us to omit setting IP addresses, interface 
names and RHOST variables.

Best regards,
Alexey

