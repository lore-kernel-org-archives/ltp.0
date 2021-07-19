From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 19 Jul 2021 08:45:58 +0200
Subject: [LTP] [PATCH v3,
 1/2] lib/tst_test.sh: Make tst_umount work with argument that has
 trailing slash
In-Reply-To: <60F519D1.9040508@fujitsu.com>
References: <20210716140142.GA7113@andestech.com>
 <60F50B67.4000807@fujitsu.com> <YPUS+/YZgAxUAlDn@pevik>
 <YPUUaOMUjRMy43ZH@pevik> <60F519D1.9040508@fujitsu.com>
Message-ID: <YPUfpkJlrWTCH4p4@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu, all,

> Hi Petr
> > Hi all,

> >>> Hi Leo

> >>>> /proc/mounts shows the mount point without trailing slashes, e.g.
> >>>> ~ $ cat /proc/mounts
> >>>> xxx /root/cgroup cgroup rw,relatime,cpu 0 0

> >>>> So current tst_umount would not work with argument that has trailing slash, e.g.
> >>>> tst_umount cgroup/ would give "The device is not mounted".

> >>>> Fix this by filtering out the trailing slash before grepping /proc/mounts.

> >>>> Signed-off-by: Leo Yu-Chi Liang<ycliang@andestech.com>
> >>>> ---
> >>>>    testcases/lib/tst_test.sh | 3 ++-
> >>>>    1 file changed, 2 insertions(+), 1 deletion(-)

> >>>> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> >>>> index c6aa2c487..f132512e7 100644
> >>>> --- a/testcases/lib/tst_test.sh
> >>>> +++ b/testcases/lib/tst_test.sh
> >>>> @@ -282,13 +282,14 @@ tst_umount()

> >>>>    	[ -z "$device" ]&&   return

> >>>> +	device=${device%/}
> >>>>    	if ! grep -q "$device" /proc/mounts; then
> >>>>    		tst_res TINFO "The $device is not mounted, skipping umount"
> >>>>    		return
> >>>>    	fi

> >>>>    	while [ "$i" -lt 50 ]; do
> >>>> -		if umount "$device">   /dev/null; then
> >>>> +		if umount "$device"/>   /dev/null; then
> >>> With removing this(we don't need add "/" here), this patch looks good to me
> >> +1
> > Actually we need to keep / for next patch, right? (cgroup/)
> I guess our ltp tst_umount api should support  to umount cgroup or 
> cgroup/ like umount command does.

Also the patch always added trailing /:
+		if umount "$device"/ > /dev/null; then

if we keep that, the second patch wouldn't have to add it to "tst_umount
cgroup/" call ("tst_umount cgroup" would be enough).
I'm not sure if we want it. @Cyril?

> > Thus why not just changing argument for grep?
> > -       if ! grep -q "$device" /proc/mounts; then
> > +       if ! grep -q "${device%/}" /proc/mounts; then
> Yes, it is more easier. But I think it still existed the problme when 
> we only use "/" parameters. I guess we should reject this situation.

I would not care about it. 1) no test does 'tst_umount /' 2) error reporting
would be correct: umount: /: target is busy.

Kind regards,
Petr

> code maybe as below:
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -282,7 +282,12 @@ tst_umount()

>          [ -z "$device" ] && return

> -       if ! grep -q "$device" /proc/mounts; then
> +       if [ "$device" = "/" ]; then
> +               tst_res TINFO "We can not umount / directory"
> +               return
> +       fi
> +
> +       if ! grep -q "${device%/}" /proc/mounts; then
>                  tst_res TINFO "The $device is not mounted, skipping umount"
>                  return
>          fi
