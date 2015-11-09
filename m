From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 09 Nov 2015 12:53:43 +0300
Subject: [LTP] How about set IPsec with ip xfrm?
In-Reply-To: <CAPwn2JQuugWMkpywVrqYKi9PAcvT+wZqBkhp5uzqNjNnW4c-+A@mail.gmail.com>
References: <CAPwn2JRO0Dx20LzBHrLhMb85EoU9+_WRnRTS5UO2sQ9Ej3y+Cw@mail.gmail.com>	<562F7947.30501@oracle.com>	<CAPwn2JS9pB39amE4azR9OP8W18SCC8X=8brxdRLv5swEr5kCLg@mail.gmail.com>	<5638BE99.4010600@oracle.com>
 <CAPwn2JQuugWMkpywVrqYKi9PAcvT+wZqBkhp5uzqNjNnW4c-+A@mail.gmail.com>
Message-ID: <56406D27.9010001@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 09.11.2015 5:42, Hangbin Liu wrote:
> Hi Alexey,
>
> Thanks for reviewing the patch. Please see the comments below.
>
> 2015-11-03 22:03 GMT+08:00 Alexey Kodanev <alexey.kodanev@oracle.com>:
>> Hi Hangbin,
>>
>> OK, I've reviewed the icmp tests draft, here are the comments:
>>
>> * I wouldn't add tst_ipsec() to test_net.sh because this function will only
>> be run in IPsec related tests, the rest network tests will include it with
>> no good reason. We can move all ipsec related tests to one directory under
>> network/stress/ipsec and create common library script there.
> OK, I can put it under stress/ns-tools/set_ipsec

Why set_ipsec? I thought it should be a library with common functions, 
vars, etc. for ipsec tests? Something like ipsec_lib.sh.
I'm not sure that ns-tools is the right place for it.

>
>> * c2x() function can be added to test.sh because it is more or less generic,
>> but it should be fixed to print the message in LTP style format.
> I'd prefer to keep c2x() with set_ipsec at present. We can move it to
> test_net.sh
> when someone want to use it.

Nonetheless, it should use LTP style to print test information.

>> * icmp_check_connectivity (ping) can be merged to test_net.sh, other network
>> test could run it too.
> I tried to merge it to test_net.sh. But I found we need to check icmp
> connectivity
> from remove sometimes. Then I'm not sure how to call a function in
> test_net.sh from
> remove except source test_net.sh in remote. Or we need to add another parameter
> in icmp_check_connectivity() like rhost to run cmd from remote. like
>
> tst_icmp_connectivity/tst_ping rhost IFACE ADDR [SIZE]
>
> or just use it as the old way
>
> tst_rhost_run check_icmpv4_connectivity  IFACE ADDR [SIZE]
>
> Which style do you prefer?

I guess we can always ping from the other way, as a consequence you 
don't have to run some
script that sources test_net.sh or make a separate command for it.

Thanks,
Alexey

