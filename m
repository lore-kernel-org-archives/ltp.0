From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 25 Jun 2021 12:39:22 +0100
Subject: [LTP] [RFC] fs_bind rework
In-Reply-To: <YNRZKs9cHbGxzg4Q@pevik>
References: <fc235ab1-4796-c1d4-d5b0-f1f112c9ce54@jv-coder.de>
 <YNRZKs9cHbGxzg4Q@pevik>
Message-ID: <878s2y41hx.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello all,

>> This would make every single fs_bind test a single ltp test (~100).
>> I do not think that runtime increases significantly, because as far as I see
>> it from first glance, test_fs_bind.sh resets the "sandbox" used for the
>> tests before every test anyway.
> Yep, I wouldn't be worry about increased runtime, this is actually the preferred
> approach. Also, various tests can be probably grouped into single shell test,
> with $TST_CNT (looking into tests in fs_bind/cloneNS).

I guess there is no performance difference in this case. What really
matters is if the tests are all just slight variations on each other. So
having them in one file looks nice and shows exactly what the
differences between tests are.

>
>> If there is no objection, I would give converting the tests a shot.
> +1
>
>> J?rg
>
> Kind regards,
> Petr


-- 
Thank you,
Richard.
