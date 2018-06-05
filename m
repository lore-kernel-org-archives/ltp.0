From: Yang Shi <yang.shi@linux.alibaba.com>
Date: Tue, 5 Jun 2018 09:33:41 -0700
Subject: [LTP] [Resend PATCH] zram03: drop obsolete sysfs interfaces
In-Reply-To: <CAEemH2cYODCdBR7uz_8X33CW3x5kEBfmT9QGn=Kw1OipvOORYA@mail.gmail.com>
References: <1527793665-39150-1-git-send-email-yang.shi@linux.alibaba.com>
 <CAEemH2cYODCdBR7uz_8X33CW3x5kEBfmT9QGn=Kw1OipvOORYA@mail.gmail.com>
Message-ID: <6d599a72-9fad-caef-70a4-5a609e228370@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



On 6/4/18 8:55 PM, Li Wang wrote:
>
>
> On Fri, Jun 1, 2018 at 3:07 AM, Yang Shi <yang.shi@linux.alibaba.com 
> <mailto:yang.shi@linux.alibaba.com>> wrote:
>
>     Due to upstream linux commit c87d1655c29500b459fb135258a93f8309ada9c7
>     ("zram: remove obsolete sysfs attrs"), some sysfs interfaces are not
>     available anymore. Remove dumping them to avoid test case failure.
>
>     Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com
>     <mailto:yang.shi@linux.alibaba.com>>
>
>
> ​Since the commit is merged from kernel-v4.10, how about changing like 
> this:
>
> --- a/testcases/kernel/device-drivers/zram/zram03.c
> +++ b/testcases/kernel/device-drivers/zram/zram03.c
> @@ -184,12 +184,17 @@ static void print(char *string)
>
>  static void dump_info(void)
>  {
> -       print("initstate");
> -       print("compr_data_size");
> -       print("orig_data_size");
> -       print("disksize");
> -       print("mem_used_total");
> -       print("num_reads");
> -       print("num_writes");
> -       print("zero_pages");
> +       if ((tst_kvercmp(4, 10, 0)) >= 0) {
> +               print("initstate");
> +               print("disksize");
> +       } else {
> +               print("initstate");
> +               print("compr_data_size");
> +               print("orig_data_size");
> +               print("disksize");
> +               print("mem_used_total");
> +               print("num_reads");
> +               print("num_writes");
> +               print("zero_pages");
> +       }

Yes, sure. Will fix in v2. Thanks for your suggestion.

Yang

>  }
> ​
>
>     ---
>     Subscribed LTP mailing list to resend the patch, so that all
>     subscribers
>     can see it and get reviewed.
>
>      testcases/kernel/device-drivers/zram/zram03.c | 6 ------
>      1 file changed, 6 deletions(-)
>
>     diff --git a/testcases/kernel/device-drivers/zram/zram03.c
>     b/testcases/kernel/device-drivers/zram/zram03.c
>     index 3f7ab4e..f2c166c 100644
>     --- a/testcases/kernel/device-drivers/zram/zram03.c
>     +++ b/testcases/kernel/device-drivers/zram/zram03.c
>     @@ -185,11 +185,5 @@ static void print(char *string)
>      static void dump_info(void)
>      {
>             print("initstate");
>     -       print("compr_data_size");
>     -       print("orig_data_size");
>             print("disksize");
>     -       print("mem_used_total");
>     -       print("num_reads");
>     -       print("num_writes");
>     -       print("zero_pages");
>      }
>     -- 
>     1.8.3.1
>
>
>     -- 
>     Mailing list info: https://lists.linux.it/listinfo/ltp
>     <https://lists.linux.it/listinfo/ltp>
>
>
>
>
> -- 
> Regards,
> Li Wang

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180605/c62d8341/attachment.html>
