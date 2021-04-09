From: Li Wang <liwang@redhat.com>
Date: Fri, 9 Apr 2021 15:18:15 +0800
Subject: [LTP] [PATCH v3 7/7] fzsync: Check processor affinity
In-Reply-To: <20210319091837.27319-8-rpalethorpe@suse.com>
References: <20210319091837.27319-1-rpalethorpe@suse.com>
 <20210319091837.27319-8-rpalethorpe@suse.com>
Message-ID: <CAEemH2dgC4qTYMTXfvf7vKXJKG539BgvhM1-V4u0q8JDvmeKXA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

 static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
>  {
> +       long ncpus = tst_ncpus_available();
> +
>         CHK(avg_alpha, 0, 1, 0.25);
>         CHK(min_samples, 20, INT_MAX, 1024);
>         CHK(max_dev_ratio, 0, 1, 0.1);
>         CHK(exec_time_p, 0, 1, 0.5);
>         CHK(exec_loops, 20, INT_MAX, 3000000);
> -       CHK(yield_in_wait, 0, 1, (tst_ncpus() <= 1));
> +
> +       if (ncpus <= 1)
> +               pair->yield_in_wait = 1;
>

I'm wondering here why not using the CHK macro as before but additionally
involved a variable 'ncpus'.

Isn't that CHK(yield_in_wait, 0, 1, (tst_ncpus_available() <= 1)) better?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210409/2ed79358/attachment.htm>
