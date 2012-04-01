Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SEHsk-0007r7-Je
	for ltp-list@lists.sourceforge.net; Sun, 01 Apr 2012 10:19:34 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SEHsj-0007BE-GK
	for ltp-list@lists.sourceforge.net; Sun, 01 Apr 2012 10:19:34 +0000
Received: by pbcum15 with SMTP id um15so3571950pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 01 Apr 2012 03:19:27 -0700 (PDT)
Message-ID: <4F782B3E.105@casparzhang.com>
Date: Sun, 01 Apr 2012 18:17:34 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4F6E04A0.10305@gmail.com>
In-Reply-To: <4F6E04A0.10305@gmail.com>
Subject: Re: [LTP] [PATCH] testcases/kernel/mem/vma/vma01.c: fix the right
 start/end memory address
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
To: Wang Sheng-Hui <shhuiw@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 03/25/2012 01:30 AM, Wang Sheng-Hui wrote:
> For a VMA with memory range 6*ps, regardless of it's two 3*ps or
> one single 6*ps, t is the start addr of the vma, u = t + 3*ps, and
> the end addr is t + 6*ps.
> 
> For the check process, x should start from t, not u, and later check
> for the second 3*ps should resume from u.

Hi Shenghui, thanks for the patch.

However, your patch doesn't work in some situation, e.g.: when t mmapped
at highest addr (it is the most common situation), which makes t+3*ps
over boundary, so mmap will map to another addr near t+3*ps. So I
propose for the following increment fix:

 static void check_vma(void)
 {
        int status;
-       void *t, *u, *x, *y;
+       void *t, *u, *v, *x, *y;

-       t = mmap(NULL, 3*ps, PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, 0, 0);
+       v = mmap(NULL, ps, PROT_READ, MAP_ANONYMOUS|MAP_PRIVATE, 0, 0);
+       if (v == MAP_FAILED)
+               tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+       t = mmap(v - 6*ps, 3*ps, PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE,
0, 0);
        if (t == MAP_FAILED)
                tst_brkm(TBROK|TERRNO, cleanup, "mmap");
        memset(t, 1, ps);

A new addr v introduced before other mappings, used to locate the
highest addr. And in order not to be merged with other mappings, v is
mapped with READ-only prot.

result using your patch w/o my increment patch:

# ./vma01
parent: t = 0x7f82dd437000
child : u = 0x7f82dd434000
vma01       0  TINFO  :  s = 0x7f82dd437000, t = 0x7f82dd43a000
vma01       1  TBROK  :  unexpected VMA found.
vma01       2  TBROK  :  Remaining cases broken

result using your patch w/ my increment patch:

# ./vma01
parent: t = 0x7f418066f000
child : u = 0x7f4180672000
vma01       0  TINFO  :  s = 0x7f418066f000, t = 0x7f4180672000
vma01       0  TINFO  :  s = 0x7f4180672000, t = 0x7f4180675000
vma01       1  TPASS  :  two 3*ps VMAs found.

Thoughts?

Thanks,
Caspar

> 
> Signed-off-by: Wang Sheng-Hui <shhuiw@gmail.com>
> ---
>  testcases/kernel/mem/vma/vma01.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/mem/vma/vma01.c b/testcases/kernel/mem/vma/vma01.c
> index 398d7a1..4b66121 100644
> --- a/testcases/kernel/mem/vma/vma01.c
> +++ b/testcases/kernel/mem/vma/vma01.c
> @@ -112,12 +112,12 @@ static void check_vma(void)
>  		printf("child : u = %p\n", u);
>  		memset(u, 2, ps);
>  
> -		x = get_end_addr(u, MAPS_FILE);
> -		if (x == u + 6*ps)
> +		x = get_end_addr(t, MAPS_FILE);
> +		if (x == t + 6*ps)
>  			exit(1);
> -		if (x == u + 3*ps) {
> -			y = get_end_addr(x, MAPS_FILE);
> -			if (y == x + 3*ps)
> +		if (x == u) {
> +			y = get_end_addr(u, MAPS_FILE);
> +			if (y == u + 3*ps)
>  				exit(0);
>  		}
>  		exit(255);


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
