From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Apr 2021 16:39:42 +0800
Subject: [LTP] [PATCH] mkfs: print more info for debugging
In-Reply-To: <YH6PT2HKt6t1xZxR@pevik>
References: <20210420075351.16059-1-liwang@redhat.com> <YH6PT2HKt6t1xZxR@pevik>
Message-ID: <CAEemH2eaPx86DWfoMPcvrzLrNz8+Aw3cOhBvPxiZ2J6LxEQQEg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > --- a/testcases/commands/mkfs/mkfs01.sh
> > +++ b/testcases/commands/mkfs/mkfs01.sh
> > @@ -128,7 +128,8 @@ mkfs_test()
> >       if [ -n "$device" ]; then
> >               mkfs_verify_type "$fs_type" "$device"
> >               if [ $? -ne 0 ]; then
> > -                     tst_res TFAIL "'${mkfs_cmd}' failed, not expected."
> > +                     tst_res TFAIL "'${mkfs_cmd}' failed, not expected type."
> Maybe "unexpected type"?
>
> I'd also change ${mkfs_cmd} to $mkfs_cmd (more readable).

Sounds good, I modified it with your suggestions and pushed it.

-- 
Regards,
Li Wang

