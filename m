From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 06 Mar 2020 14:45:03 +0100
Subject: [LTP] [PATCH v3] pty: Test data transmission with SLIP line
 discipline
In-Reply-To: <20200306132011.GA25572@dell5510>
References: <20200306120021.19997-1-rpalethorpe@suse.com>
 <20200306132011.GA25572@dell5510>
Message-ID: <87lfodfvhc.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richard,
>
> ...
>> +static int set_ldisc(int tty, struct ldisc_info *ldisc)
>> +{
>> +	TEST(ioctl(tty, TIOCSETD, &ldisc->n));
>> +
>> +	if (!TST_RET)
>> +		return 0;
>> +
>> +	if (TST_ERR == EINVAL) {
>> +		tst_res(TCONF | TTERRNO,
>> +			"You don't appear to have the %s TTY line discipline",
>> +			ldisc->name);
>> +	} else {
>> +		tst_res(TBROK | TTERRNO,
> This must be TFAIL now.
> This can be done by person who merges this patch.
>
> BTW as the same function (with corrected TBROK) is
> already in pty03.c (although struct ldisc_info is different).

HHmm, I suppose this also means I should also either check the return
value in open_pty or use tst_brk.


>
> Kind regards,
> Petr


-- 
Thank you,
Richard.
