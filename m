From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 26 Jul 2017 18:00:40 +0300
Subject: [LTP] [RFC PATCH v7 07/11] lib/test_net.sh: Add function
 reset_ltp_netspace()
In-Reply-To: <20170726145528.neqjma47ebrhyjyh@dell5510>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-8-pvorel@suse.cz>
 <46f0e647-8683-88b5-1ead-5287be4ae05d@oracle.com>
 <20170726145528.neqjma47ebrhyjyh@dell5510>
Message-ID: <34b699bf-ce68-8d1a-fd20-d58cc7793a77@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 26.07.2017 17:55, Petr Vorel wrote:
> Hi Alexey,
>
>>>  	pid="$(echo $(readlink /var/run/netns/ltp_ns) | cut -f3 -d'/')"
>>> -	export LTP_NETNS="${LTP_NETNS:-ns_exec $pid net,mnt}"
>>> +	export LTP_NETNS="ns_exec $pid net,mnt"
>> It is better to reset LTP_NETNS variable before calling
>> init_ltp_netspace in reset_ltp_netspace().
> OK, I'll do it :-). I wonder what is a real usage for LTP_NETNS configured by user...

e.g. to use 'ip' command instead.

Thanks,
Alexey

>
> Thanks for your review!
>
> Kind regards,
> Petr


