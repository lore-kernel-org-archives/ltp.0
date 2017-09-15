From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 15 Sep 2017 12:05:44 +0200
Subject: [LTP] [PATCH v3 3/7] fzsync: Add long running thread support
	and deviation stats
In-Reply-To: <20170912144325.GE29720@rei>
References: <20170901130121.22821-1-rpalethorpe@suse.com>
 <20170901130121.22821-3-rpalethorpe@suse.com> <20170912144325.GE29720@rei>
Message-ID: <87o9qcz37r.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis writes:

> Hi!
>> +/**
>> + * tst_fzsync_pair_wait - Wait for the other thread
>> + * @our_cntr: The counter for the thread we are on
>> + * @other_cntr: The counter for the thread we are synchronising with
>> + *
>> + * Use this (through tst_fzsync_pair_wait_a() and tst_fzsync_pair_wait_b()) if
>> + * you need an additional synchronisation point in a thread or you do not want
>> + * to use the delay facility (not recommended). See
>> + * tst_fzsync_pair_wait_update().
>> + *
>> + * Returns a non-zero value if the thread should continue otherwise the
>> + * calling thread should exit.
>> + */
>> +static inline int tst_fzsync_pair_wait(struct tst_fzsync_pair *pair,
>> +				       int *our_cntr, int *other_cntr)
>> +{
>> +	tst_atomic_inc(other_cntr);
>> +	while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)
>> +	       && !tst_atomic_load(&pair->exit))
>> +		;
>> +
>> +	return !tst_atomic_load(&pair->exit);
>> +}
>
> Also what happens if the counters overflow?
>
> I guess that this will happen if we call the test with large enough -i
> paramter, right?

Bad things will happen :-). It can probably be fixed with the following
though:

 static inline int tst_fzsync_pair_wait(struct tst_fzsync_pair *pair,
 				       int *our_cntr, int *other_cntr)
 {
-	tst_atomic_inc(other_cntr);
+	if (tst_atomic_inc(other_cntr) < 0) {
+		tst_atomic_store(0, other_cntr);
+		while (tst_atomic_load(our_cntr) > tst_atomic_load(other_cntr)
+		       && !tst_atomic_load(&pair->exit))
+			;
+	}
+
 	while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)
 	       && !tst_atomic_load(&pair->exit))

Seems to work and any perf penality is insignificant; with or without
branch prediction.

-- 
Thank you,
Richard.
