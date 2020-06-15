From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 15 Jun 2020 09:55:14 +0100
Subject: [LTP] [PATCH v4] Wrapper for Syzkaller reproducers
In-Reply-To: <CAEemH2fyJKyKwKzF4W35tM_sjbYQAf-Gx7-Vrhv6r+QdLE8+Bw@mail.gmail.com>
References: <20200610072928.1331-1-rpalethorpe@suse.com>
 <CAEemH2fyJKyKwKzF4W35tM_sjbYQAf-Gx7-Vrhv6r+QdLE8+Bw@mail.gmail.com>
Message-ID: <87r1ugwvwt.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Li,

Li Wang <liwang@redhat.com> writes:

> On Wed, Jun 10, 2020 at 3:29 PM Richard Palethorpe <rpalethorpe@suse.com>
> wrote:
>
>> Allows one to run the Syzkaller reproducers as part of the LTP.
>>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> Reviewed-by: Pter Vorel <pvorel@suse.com>
>>
> Reviewed-by: Li Wang <liwang@redhat.com>

Thanks!

>
> +
>> +static void setup(void)
>> +{
>> +       tst_taint_init(TST_TAINT_W | TST_TAINT_D | TST_TAINT_L);
>>
>
> My only concern is that the limitation is too strict for syzkaller.
>
> Because if one of the tests (near the top of the name rankings)
> trigger a WARNING in SUT kernel, the syzwrap.c will be
> skipping all remaining test cases.
>
> Maybe we can just use 'TST_TAINT_D' here, and I wish to
> hear more opinions from others.
>
> -- 
> Regards,
> Li Wang

You should restart/reset the SUT if the kernel is tainted. Please see
the README section on test runner requirements.

It might even be best to panic on warn instead of relying on syzwrap or
the test runner detecting the taint.

So far I have found enough warnings are caused by bugs that you can't
reliably continue testing afterwards.

OTOH the LTP library should maybe provide some args to override taints,
but that is not specific to syzwrap.
-- 
Thank you,
Richard.
