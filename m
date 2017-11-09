From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Nov 2017 11:19:15 +0100
Subject: [LTP] [PATCH v3 15/16] fs/fs_fill: Add a test to fill a FS in a
 few threads
In-Reply-To: <CAEemH2f8Dya2XUvZZ2t9XMbbVFo_tM5B=LuzjZqyB8ZCA6qvVA@mail.gmail.com>
References: <20171011144130.29728-1-chrubis@suse.cz>
 <20171011144130.29728-15-chrubis@suse.cz>
 <CAEemH2f8Dya2XUvZZ2t9XMbbVFo_tM5B=LuzjZqyB8ZCA6qvVA@mail.gmail.com>
Message-ID: <20171109101915.GA7738@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This case always broken in SAFE_* operations, seems the reason is no
> space left on the device,
> so I wonder if is it necessary to create so many thread "CPUs + 2" to
> run the test?
> 
> What about just creating half of CPU number thread (nthreads =
> tst_ncpus_conf()/2 + 1) there?
> 
> $ git diff
> diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c
> b/testcases/kernel/fs/fs_fill/fs_fill.c
> index a50a22f..13207c4 100644
> --- a/testcases/kernel/fs/fs_fill/fs_fill.c
> +++ b/testcases/kernel/fs/fs_fill/fs_fill.c
> @@ -106,7 +106,7 @@ static void testrun(void)
> 
>  static void setup(void)
>  {
> -       nthreads = tst_ncpus_conf() + 2;
> +       nthreads = tst_ncpus_conf()/2 + 1;
> 
>         tst_res(TINFO, "Running %i writer threads", nthreads);
>  }

This does not fix the problem, only makes it less likely.

The correct fix is to use open() instead of SAFE_OPEN() in the
tst_fill_fs() and just return from the function when we get ENOSPC. I
can fix that, or you can send the patch. Either way thanks for pointing
out the mistake.

-- 
Cyril Hrubis
chrubis@suse.cz
