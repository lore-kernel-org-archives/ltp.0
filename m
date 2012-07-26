Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SuGLW-0001lm-Al
	for ltp-list@lists.sourceforge.net; Thu, 26 Jul 2012 05:10:46 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SuGLV-0005XT-4T
	for ltp-list@lists.sourceforge.net; Thu, 26 Jul 2012 05:10:46 +0000
Received: by pbbrq2 with SMTP id rq2so2462940pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 25 Jul 2012 22:10:39 -0700 (PDT)
Message-ID: <5010D13F.6020006@casparzhang.com>
Date: Thu, 26 Jul 2012 13:10:23 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1343270673-8363-1-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1343270673-8363-1-git-send-email-gaowanlong@cn.fujitsu.com>
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

On 07/26/2012 10:44 AM, Wanlong Gao wrote:
> New output format of file command for C program file is like below,
> $ file src/guestfs.c
> src/guestfs.c: C source, ASCII text
>
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

Reviewed-by: Caspar Zhang <caspar@casparzhang.com>

> ---
>   testcases/commands/ade/file/file_test.sh | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/commands/ade/file/file_test.sh b/testcases/commands/ade/file/file_test.sh
> index 70420e3..8a4e9b5 100755
> --- a/testcases/commands/ade/file/file_test.sh
> +++ b/testcases/commands/ade/file/file_test.sh
> @@ -314,10 +314,16 @@ then
>           $LTPBIN/tst_resm TPASS "file: Recognised C program text correctly"
>           rm -f $LTPTMP/cprog.c
>       else
> -        $LTPBIN/tst_res TFAIL $LTPTMP/file.out \
> -             "file: Failed to Recognize C program text correctly. Reason:"
> -        TFAILCNT=$(( $TFAILCNT+1 ))
> -
> +        grep "C source, ASCII text" $LTPTMP/file.out > /dev/null 2>&1
> +        if [ $? -eq 0 ]
> +        then
> +            $LTPBIN/tst_resm TPASS "file: Recognised C program text correctly"
> +            rm -f $LTPTMP/cprog.c
> +        else
> +            $LTPBIN/tst_res TFAIL $LTPTMP/file.out \
> +                 "file: Failed to Recognize C program text correctly. Reason:"
> +            TFAILCNT=$(( $TFAILCNT+1 ))
> +        fi
>       fi
>   else
>       $LTPBIN/tst_resm TFAIL "file: Failed to recognize C programi text"
>



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
