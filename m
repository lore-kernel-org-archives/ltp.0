From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 9 Jun 2020 14:14:54 +0800
Subject: [LTP] [PATCH] network/nfs_lib.sh: Use double quotes for grep
 pattern
In-Reply-To: <20200608145831.GA2746544@x230>
References: <20200608142744.274287-1-yangx.jy@cn.fujitsu.com>
 <20200608145831.GA2746544@x230>
Message-ID: <5EDF28DE.7070202@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/6/8 22:58, Petr Vorel wrote:
> Hi Xiao,
>
> Reviewed-by: Petr Vorel<petr.vorel@gmail.com>
>
>> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
>> @@ -58,7 +58,7 @@ nfs_server_udp_enabled()
>>   	tst_rhost_run -c "[ -f /etc/nfs.conf ]" || return 0
>>   	config=$(tst_rhost_run -c 'for f in $(grep ^include.*= '/etc/nfs.conf' | cut -d = -f2); do [ -f $f ]&&  printf "$f "; done')
>
>> -	tst_rhost_run -c "grep -q '^[# ]*udp *= *y' /etc/nfs.conf $config"
>> +	tst_rhost_run -c "grep -q \"^[# ]*udp *= *y\" /etc/nfs.conf $config"
> Good catch. But I wonder if we shouldn't fix tst_rhost_run instead, to avoid
> this error in the future. How about replacing ' with \" in $cmd?
Hi Petr,

It is fine for me to fix the issue in tst_rhost_run() but I didn't find 
a better fix, could you provide an example about your idea?

Best Regards,
Xiao Yang
>
> Kind regards,
> Petr
>
>
> .
>



