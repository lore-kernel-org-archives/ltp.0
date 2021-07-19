From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Mon, 19 Jul 2021 06:20:47 +0000
Subject: [LTP] [PATCH v3,
 1/2] lib/tst_test.sh: Make tst_umount work with argument that has
 trailing slash
In-Reply-To: <YPUUaOMUjRMy43ZH@pevik>
References: <20210716140142.GA7113@andestech.com>
 <60F50B67.4000807@fujitsu.com> <YPUS+/YZgAxUAlDn@pevik>
 <YPUUaOMUjRMy43ZH@pevik>
Message-ID: <60F519D1.9040508@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr
> Hi all,
>
>>> Hi Leo
>
>>>> /proc/mounts shows the mount point without trailing slashes, e.g.
>>>> ~ $ cat /proc/mounts
>>>> xxx /root/cgroup cgroup rw,relatime,cpu 0 0
>
>>>> So current tst_umount would not work with argument that has trailing slash, e.g.
>>>> tst_umount cgroup/ would give "The device is not mounted".
>
>>>> Fix this by filtering out the trailing slash before grepping /proc/mounts.
>
>>>> Signed-off-by: Leo Yu-Chi Liang<ycliang@andestech.com>
>>>> ---
>>>>    testcases/lib/tst_test.sh | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>
>>>> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
>>>> index c6aa2c487..f132512e7 100644
>>>> --- a/testcases/lib/tst_test.sh
>>>> +++ b/testcases/lib/tst_test.sh
>>>> @@ -282,13 +282,14 @@ tst_umount()
>
>>>>    	[ -z "$device" ]&&   return
>
>>>> +	device=${device%/}
>>>>    	if ! grep -q "$device" /proc/mounts; then
>>>>    		tst_res TINFO "The $device is not mounted, skipping umount"
>>>>    		return
>>>>    	fi
>
>>>>    	while [ "$i" -lt 50 ]; do
>>>> -		if umount "$device">   /dev/null; then
>>>> +		if umount "$device"/>   /dev/null; then
>>> With removing this(we don't need add "/" here), this patch looks good to me
>> +1
> Actually we need to keep / for next patch, right? (cgroup/)
I guess our ltp tst_umount api should support  to umount cgroup or 
cgroup/ like umount command does.

>
> Thus why not just changing argument for grep?
> -       if ! grep -q "$device" /proc/mounts; then
> +       if ! grep -q "${device%/}" /proc/mounts; then
Yes, it is more easier. But I think it still existed the problme when 
we only use "/" parameters. I guess we should reject this situation.

code maybe as below:
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -282,7 +282,12 @@ tst_umount()

         [ -z "$device" ] && return

-       if ! grep -q "$device" /proc/mounts; then
+       if [ "$device" = "/" ]; then
+               tst_res TINFO "We can not umount / directory"
+               return
+       fi
+
+       if ! grep -q "${device%/}" /proc/mounts; then
                 tst_res TINFO "The $device is not mounted, skipping umount"
                 return
         fi



>
> Kind regards,
> Petr
>
>> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
>> Kind regards,
>> Petr
>
>>> Reviewed-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>>>>    			return
>>>>    		fi
>
