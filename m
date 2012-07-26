Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SuFdF-0003l8-N0
	for ltp-list@lists.sourceforge.net; Thu, 26 Jul 2012 04:25:01 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SuFdD-0000sP-DW
	for ltp-list@lists.sourceforge.net; Thu, 26 Jul 2012 04:25:01 +0000
Date: Thu, 26 Jul 2012 00:24:49 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <1169487867.3185873.1343276689455.JavaMail.root@redhat.com>
In-Reply-To: <1343270673-8363-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] file: add the new output format of C program file
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "LTP" <ltp-list@lists.sourceforge.net>
> Sent: Thursday, July 26, 2012 10:44:33 AM
> Subject: [LTP] [PATCH] file: add the new output format of C program file
> 
> New output format of file command for C program file is like below,
> $ file src/guestfs.c
> src/guestfs.c: C source, ASCII text
> 

Looks good for me.
Reviewed-by: Zhouping Liu <zliu@redhat.com>

> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  testcases/commands/ade/file/file_test.sh | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/commands/ade/file/file_test.sh
> b/testcases/commands/ade/file/file_test.sh
> index 70420e3..8a4e9b5 100755
> --- a/testcases/commands/ade/file/file_test.sh
> +++ b/testcases/commands/ade/file/file_test.sh
> @@ -314,10 +314,16 @@ then
>          $LTPBIN/tst_resm TPASS "file: Recognised C program text
>          correctly"
>          rm -f $LTPTMP/cprog.c
>      else
> -        $LTPBIN/tst_res TFAIL $LTPTMP/file.out \
> -             "file: Failed to Recognize C program text correctly.
> Reason:"
> -        TFAILCNT=$(( $TFAILCNT+1 ))
> -
> +        grep "C source, ASCII text" $LTPTMP/file.out > /dev/null
> 2>&1
> +        if [ $? -eq 0 ]
> +        then
> +            $LTPBIN/tst_resm TPASS "file: Recognised C program text
> correctly"
> +            rm -f $LTPTMP/cprog.c
> +        else
> +            $LTPBIN/tst_res TFAIL $LTPTMP/file.out \
> +                 "file: Failed to Recognize C program text
> correctly. Reason:"
> +            TFAILCNT=$(( $TFAILCNT+1 ))
> +        fi
>      fi
>  else
>      $LTPBIN/tst_resm TFAIL "file: Failed to recognize C programi
>      text"
> --
> 1.7.12.rc0
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond.
> Discussions
> will include endpoint security, mobile security and the latest in
> malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

-- 
Thanks,
Zhouping

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
