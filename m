From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 11 Sep 2018 11:14:16 +0200
Subject: [LTP] [PATCH v2 4/4] Add delay bias for difficult races
In-Reply-To: <20180910223806.GA9189@dell5510>
References: <20180910084442.17720-1-rpalethorpe@suse.com>
 <20180910084442.17720-5-rpalethorpe@suse.com>
 <20180910223806.GA9189@dell5510>
Message-ID: <87h8iw5rbr.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richard,
>
>> Races with short exploitation windows and nonlinear timings, given varying
>> chronological order, appear to require an offset to the synchronisation to
>> achieve the correct order so that the average timings are valid for the race
>> condition.
>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> ---
>
>> +static void tst_fzsync_pair_add_bias(struct tst_fzsync_pair *pair, int change)
>> +{
>> +	if (pair->sampling > 0) {
>> +		pair->delay_bias += change;
>> +		pair->discard_flag = 1;
>> +	}
>> +}
>
> Minor warning due being in header and not in C file:
> ../../../include/tst_fuzzy_sync.h:753:13: warning: ‘tst_fzsync_pair_add_bias’ defined but not used [-Wunused-function]
>  static void tst_fzsync_pair_add_bias(struct tst_fzsync_pair *pair, int change)
>
>
> Kind regards,
> Petr

OK, I have added unused attribute to this function for the next version

-- 
Thank you,
Richard.
