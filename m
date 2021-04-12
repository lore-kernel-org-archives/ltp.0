From: Li Wang <liwang@redhat.com>
Date: Mon, 12 Apr 2021 21:57:03 +0800
Subject: [LTP] [PATCH v3 1/7] fzsync: Add self tests
In-Reply-To: <20210319091837.27319-2-rpalethorpe@suse.com>
References: <20210319091837.27319-1-rpalethorpe@suse.com>
 <20210319091837.27319-2-rpalethorpe@suse.com>
Message-ID: <CAEemH2f1OtzmP+Vh+afVHuZvHNZSq0kwG0HrK79z7THEu1smmQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> +/* The time signatures of threads A and B */
> +struct race {
> +       const struct window a;
> +       const struct window b;
> +};
> +
> +static int c;
>

Maybe define a volatile 'c' here will be better?



> +
> +       tst_res(critical > 50 ? TPASS : TFAIL,
> +               "cs:%-2d ct:%-2d rt:%-2d | =:%-4d -:%-4d +:%-4d",
> +               a.critical_s, a.critical_t, a.return_t,
>

A tiny issue on output is, 'a.critical_s' abbreviate to 'cs' which
has duplicated name with above variable, a bit confused for me
a while:).

Anyway, the patches look quite good to me.
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210412/6d91fb31/attachment.htm>
