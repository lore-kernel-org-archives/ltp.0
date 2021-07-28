From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Wed, 28 Jul 2021 14:38:12 +0300
Subject: [LTP] [PATCH v1] lib/tst_test.sh: skip test if ip returns
 "Error: Unknown device type"
In-Reply-To: <YP/ZxhYSZb/NusUs@pevik>
References: <20210722063422.18059-1-radoslav.kolev@suse.com>
 <YPkjE3KHHnhYklp/@pevik> <8b564e10-d87e-aaf0-03a4-1af347f02d4b@suse.com>
 <8cc8d5bc-b651-8e15-6389-69f36cf6bb49@bell-sw.com> <YP/ZxhYSZb/NusUs@pevik>
Message-ID: <c94e1459-07d5-ceb0-f113-9d3f57343983@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 27.07.2021 13:02, Petr Vorel wrote:
> Hi Alexey, Radoslav,
> 
>> Hi Radoslav,
> 
>> On 27.07.2021 11:20, Radoslav Kolev wrote:
>>> On 7/22/21 10:49 AM, Petr Vorel wrote:
>>>> Hi Radoslav,
> 
>>>>> In network stress test groups there are tests expecting
>>>>> CONFIG_NET_IPVTI to be enabled in the kernel, and if it's not they
>>>>> fail. There is a check for VTI support in the ip utility, but not
>>>>> for the kernel. Skip these tests if vti device type is not known by
>>>>> the kernel.
>>>> LGTM.
>>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
>>> Thanks for the review, Petr!
> 
>>> Alexey, please let me know if you have any comments.
> 
> 
> 
>> What about checking vti drivers in stress/ipsec/ipsec_lib.sh:tst_ipsec_setup_vti()
>> Similar to the checks for xfrm_user driver there...
> 
>> For example:
> 
>> tst_net_run -q "tst_check_drivers ip_vti ip6_vti" || \
>>     tst_brk TCONF "vti driver not available on lhost or rhost"
> 
> 
>> I think this should work for wireguard02 test as well.
> 
> The above LGTM, Radoslav, do you have time to look into it?
> Alexey, do we also accept this patch? IMHO this error should be mostly TCONF and
> it'd work for other possible drivers.
> 

Not sure if we really want to add the new patterns every time the
error message from ip changes. For example depending on the ip/libc
the error can be "Error: Unknown device type." or "RTNETLINK answers:
Not supported".

We could also save the error message in setup by passing the wrong
type and then compare it during the test:

no_dev_msg="$(ip link add ltp0 type ltp0 2>&1)"
