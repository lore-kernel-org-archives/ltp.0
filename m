Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WhfGj-0006Rw-UH
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 13:18:49 +0000
Date: Tue, 6 May 2014 15:17:50 +0200
From: chrubis@suse.cz
Message-ID: <20140506131750.GA8814@rei>
References: <1395930175-3138-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1395930175-3138-4-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20140429152859.GD12523@rei> <5368C827.1020007@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5368C827.1020007@oracle.com>
Subject: Re: [LTP] [PATCH V3 3/4] testscripts/isofs.sh: removed some
 "unnecessary" steps
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > Giving it a second though it may. Because if you just mount and unmout
> > the device the kernel code coverage is likely much smaller.
> >
> > What about we list all files on the device and redirect the output to
> > /dev/null and check for the ls exit value?
> 
> In this case most of the changes introduced by this patch are not needed 
> at all:)
> 
> So the final one would be something like this:
> 
> diff --git a/testscripts/isofs.sh b/testscripts/isofs.sh
> index 2bb2555..1f69928 100755
> --- a/testscripts/isofs.sh
> +++ b/testscripts/isofs.sh
> @@ -98,7 +98,7 @@ for mkisofs_opt in \
>          "-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -L -R"
>   do
>          rm -f isofs.iso
> -       mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR
> +       mkisofs -o isofs.iso -quiet $mkisofs_opt $MAKE_FILE_SYS_DIR 2> 
> /dev/null
>          if [ $? -eq 0 ]; then
>                  tst_resm TPASS \
>                          "mkisofs -o isofs.iso -quiet $mkisofs_opt 
> $MAKE_FILE_SYS_DIR"
> @@ -128,9 +128,11 @@ do
>                          continue
>                  fi
> 
> -               ls -lR $MNT_POINT
> -               exportfs -i -o no_root_squash,rw *:$MNT_POINT
> -               exportfs -u :$MNT_POINT
> +               ls -lR $MNT_POINT > /dev/null
> +               if [ $? -ne 0 ]; then
> +                       tst_resm TFAIL "ls -lR $MNT_POINT"
> +                       continue
> +               fi
> 
>                  umount $MNT_POINT
>                  if [ $? -ne 0 ]; then
> 
> Correct?

I think that we should try to umount it if the ls has failed too.

In reality when ls fails the system would be in inconstistent state and
the umount will likely fail too but it would not harm.

> exportfs always returns 0, so there is no point to execute it at all.

Right.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
