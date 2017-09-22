From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 22 Sep 2017 13:43:30 +0200
Subject: [LTP] [PATCH v3 4/7] fzsync: Add functionality test for library
In-Reply-To: <20170912140859.GC29720@rei>
References: <20170901130121.22821-1-rpalethorpe@suse.com>
 <20170901130121.22821-4-rpalethorpe@suse.com> <20170912140859.GC29720@rei>
Message-ID: <87k20ryn4t.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Cyril Hrubis writes:

> Hi!
>> +/*
>> + * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
>> + *
>> + * This program is free software: you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation, either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +/* Basic functionality test for tst_fuzzy_sync.h similar to the atomic tests
>> + * (test15.c). One thread writes to the odd indexes of an array while the
>> + * other writes to the even. If the threads are not synchronised then they
>> + * will probably write to the wrong indexes as they share an index variable
>> + * which they should take it in turns to update.
>> + */
>
> I'm just wondering, wouldn't be a better test for the sync library if
> one of the threads does short usleep(); and we would check if the delay
> more or less corresponds to this value after some iterations?
>
> --
> Cyril Hrubis
> chrubis@suse.cz

This test is currently an OK test for checking race conditions and what
happens during a counter overflow. Sleeping pretty much ruins that, so I
would add another test. Such a test would go well with the sliding
window feature I want to add at some later point. I quickly tried adding
a usleep(tv_nsec = 500) and the deviation was way over 500, so I'm not
sure usleep is actually accurate enough to test this algorithm, but it
needs some analysis. It could be the algorithm is getting a bit chaotic
and the averages are smoothing it over (although I don't think so). I
atleast need to start collecting and plotting the results.

--
Thank you,
Richard.
