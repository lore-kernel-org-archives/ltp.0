From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 13 Apr 2021 07:42:59 +0100
Subject: [LTP] [PATCH v3 1/7] fzsync: Add self tests
In-Reply-To: <CAEemH2f1OtzmP+Vh+afVHuZvHNZSq0kwG0HrK79z7THEu1smmQ@mail.gmail.com>
References: <20210319091837.27319-1-rpalethorpe@suse.com>
 <20210319091837.27319-2-rpalethorpe@suse.com>
 <CAEemH2f1OtzmP+Vh+afVHuZvHNZSq0kwG0HrK79z7THEu1smmQ@mail.gmail.com>
Message-ID: <87o8ei3css.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

>> +/* The time signatures of threads A and B */
>> +struct race {
>> +       const struct window a;
>> +       const struct window b;
>> +};
>> +
>> +static int c;
>>
>
> Maybe define a volatile 'c' here will be better?

We always access it with the atomic functions so it is not necessary.

>
>
>
>> +
>> +       tst_res(critical > 50 ? TPASS : TFAIL,
>> +               "cs:%-2d ct:%-2d rt:%-2d | =:%-4d -:%-4d +:%-4d",
>> +               a.critical_s, a.critical_t, a.return_t,
>>
>
> A tiny issue on output is, 'a.critical_s' abbreviate to 'cs' which
> has duplicated name with above variable, a bit confused for me
> a while:).
>
> Anyway, the patches look quite good to me.
> Reviewed-by: Li Wang <liwang@redhat.com>

Thanks for the review! I will modify the printed variable name.


-- 
Thank you,
Richard.
