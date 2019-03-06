From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Mar 2019 09:54:18 +0100
Subject: [LTP] [PATCH v2 1/2] syscalls/sync_file_range: add partial file
 sync test-case
In-Reply-To: <CAFA6WYOPW0mkmGFbcZRmvhXsOJouUi1d-rcV_-sgKVKpkqSMSA@mail.gmail.com>
References: <1551770065-20444-1-git-send-email-sumit.garg@linaro.org>
 <20190305141903.GD13703@rei>
 <CAFA6WYOPW0mkmGFbcZRmvhXsOJouUi1d-rcV_-sgKVKpkqSMSA@mail.gmail.com>
Message-ID: <20190306085418.GA14290@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Looking at this the function is nearly the same as the other one, I
> > guess that we may as well define the function as:
> >
> > static void verify_sync_file_range(off64_t off, off64_t size, char byte)
> > {
> >         ...
> > }
> >
> 
> Yeah it could be made common. But we may not be able to reuse it for
> third case you mentioned below.

We may as well add offset and size for the write as well.

> > Also I'm not sure I was clear enough, but I was suggesting to check for
> > upper bound for the synced size as well, which is why I suggested to do
> > full write, sync only part of it, then check that the size was within
> > bounds, i.e. >= size and  <= size + epsilon.
> >
> 
> Do you see any value add of upper bound check? AFAIK, device writes
> continue in back-end and we might not be sure about appropriate value
> for "epsilon".

AFAIK this makes sense as far the file written fits into RAM buffers.
We do write followed by a sync that asks particular range to be written
to the device, so unless we manage to write significant portion of the
file while we are calling the write syscall in a loop we will get quite
close to the expectations. I guess that we can also check how much data
was written right after we finished writing to the file and if that
number is neglectible it would be fairly safe to check for upper bound.
Does that sound reasonable to you?

> > I guess that we can even extend this to call the sync over a range that
> > has been only partially written, but for that we would have to be
> > careful and make sure all the data has been either synced at the end of
> > the test function or use a different file for each test.
> >
> 
> I think using different file for each case looks more appropriate.

Agreed.

-- 
Cyril Hrubis
chrubis@suse.cz
