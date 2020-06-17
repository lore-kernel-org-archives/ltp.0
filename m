From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 17 Jun 2020 17:28:27 +0300
Subject: [LTP] [PATCH] network/nfs_lib.sh: Use double quotes for grep
 pattern
In-Reply-To: <20200608145831.GA2746544@x230>
References: <20200608142744.274287-1-yangx.jy@cn.fujitsu.com>
 <20200608145831.GA2746544@x230>
Message-ID: <423c55db-a393-d1d9-6de6-28f65f76557a@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08.06.2020 17:58, Petr Vorel wrote:
> Hi Xiao,
> 
> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Applied the patch, thanks!

> 
>> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
>> @@ -58,7 +58,7 @@ nfs_server_udp_enabled()
>>  	tst_rhost_run -c "[ -f /etc/nfs.conf ]" || return 0
>>  	config=$(tst_rhost_run -c 'for f in $(grep ^include.*= '/etc/nfs.conf' | cut -d = -f2); do [ -f $f ] && printf "$f "; done')
> 
>> -	tst_rhost_run -c "grep -q '^[# ]*udp *= *y' /etc/nfs.conf $config"
>> +	tst_rhost_run -c "grep -q \"^[# ]*udp *= *y\" /etc/nfs.conf $config"
> Good catch. But I wonder if we shouldn't fix tst_rhost_run instead, to avoid
> this error in the future. How about replacing ' with \" in $cmd?
> 

Perhaps this:

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 59b373e..9c8f163 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -172,8 +172,7 @@ tst_rhost_run()
        local output=
        local ret=0
        if [ -n "${TST_USE_SSH:-}" ]; then
-               output=`ssh -n -q $user@$RHOST "sh -c \
-                       '$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
+               output=$(ssh -n -q $user@$RHOST "$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR')
        elif [ -n "$TST_USE_NETNS" ]; then
                output=`$LTP_NETNS sh -c \
                        "$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR'`

