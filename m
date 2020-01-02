From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 2 Jan 2020 14:46:05 +0800
Subject: [LTP] [PATCH COMMITTED] tst_device: do sync() before reading
 test block device stat file
In-Reply-To: <CAEemH2cPJnbNeLRNmHPoGDjh5y_i6YicYPOyM7Vu+AM9t09Kyg@mail.gmail.com>
References: <20200102015236.7400-1-liwang@redhat.com>
 <b2b1b91e-4813-a281-6f56-0924d21bb103@cn.fujitsu.com>
 <CAEemH2cPJnbNeLRNmHPoGDjh5y_i6YicYPOyM7Vu+AM9t09Kyg@mail.gmail.com>
Message-ID: <94af8423-337a-8e96-8ab2-b818afb43a76@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



on 2020/01/02 14:31, Li Wang wrote:
> 
> 
> On Thu, Jan 2, 2020 at 10:10 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com 
> <mailto:xuyang2018.jy@cn.fujitsu.com>> wrote:
> 
> 
> 
>     Hi Li
>      > To avoid FS deferred IO metadata/cache interferes test result, so we
>      > do sync simply before the tst_dev_bytes_written invocation.
>      >
>     Looks good, acked. Also, I think we can mention it in
>     doc/test-writing-guidelines.txt when using this api.
> 
> 
> Ok, I will append one line as:
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1072,7 +1072,9 @@ unsigned long tst_dev_bytes_written(const char *dev);
>  ?-------------------------------------------------------------------------------
> 
>  ?This function reads test block device stat file 
> (/sys/block/<device>/stat) and
> -returns the bytes written since the last invocation of this function.
> +returns the bytes written since the last invocation of this function. 
> To avoid
> +FS deferred IO metadata/cache interferes the test result, we suggest 
> doing sync()
> +before the tst_dev_bytes_written first invocation.
OK.

I also meet another problem when using this api on old kernel.

tst_device.c:395: CONF: Test device stat file: /sys/block/loop0/stat broken

/sys/block/loop0/stat is all 0 and case reports TCONF. on new kernel,
this value is normal. This is a block layer or loop device driver 
modifition several yeas ago?

ps:I know ltp used LOOP_SET_FD to make loop device simulate other 
filesystems. I am trying to find a generic way about this api.

Best Regards
Yang Xu
> 
> -- 
> Regards,
> Li Wang


