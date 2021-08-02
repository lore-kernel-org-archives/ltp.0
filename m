From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Aug 2021 15:23:00 +0200
Subject: [LTP] [PATCH] lib: tst_device: Allow more control over the
 device size
In-Reply-To: <d02ab79b-b52a-d4c6-33a4-c836c30a7523@jv-coder.de>
References: <20210730133155.31284-1-chrubis@suse.cz>
 <d99456d3-c3d3-a180-7d0c-55bc3042e63c@jv-coder.de>
 <YQfZLXZznHjvlGJW@yuki> <YQfaZsdzHbPrhCV0@yuki>
 <e51c9469-73e5-69db-f5ff-c2abfd72dc95@jv-coder.de>
 <YQfhszoCgVv1mGjf@yuki>
 <d02ab79b-b52a-d4c6-33a4-c836c30a7523@jv-coder.de>
Message-ID: <YQfxtOSlEK/NwCl4@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> The usage of foo foo_ and foo__ does not really help in reading the code :)
> >> There could also be some logic errors hiding, e.g.
> >> tst_acquire_loop_device should probably not default to DEV_SIZE_MB at all.
> >> The caller should be responsible for finding a correct size and the two
> >> users of this function (tst_device [the binary] and
> >> tst_acquire_device__) do pass a concrete value for size.
> > Actually the tst_device binary does not pass a concrete size unless the
> > shell code that calls it passes an optional parameter, so the fallback
> > to DEV_SIZE_MB if size == 0 has to stay in the double underscore
> > function. I will send a v2 that just replaces the second occurence of
> > MAX() in tst_device.c for now as it looks to me that any singificant
> > cleanup would require complete redesing of the interface and quite
> > possibly rewrite of the last 16 tests that use the old API as a
> > pre-requisite.
> I think we maximized confusion.
> I was not arguing about the defaulting to DEV_SIZE_MB in the double 
> underscore function, but about the defaulting in the 
> tst_acquire_loop_device function. This function is never called with 
> size=0, because the call is either from the double underscore function, 
> that defaults to DEV_SIZE_MB or from the tst_device binary, that only 
> calls tst_acquire_loop_device if the 3 argument version (tst_device 
> acquire [size [filename]]) is used and size is not allowed to be 0 in 
> that case.

Well it's true that at the moment all callers pass non-zero size to the
tst_device binary but any shell test can pass down 0 to the call in
order to get the default size which is large enough for all possible
filesystems.

-- 
Cyril Hrubis
chrubis@suse.cz
