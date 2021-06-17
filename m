From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 17 Jun 2021 09:40:39 +0100
Subject: [LTP] [PATCH v4 3/3] API: Remove TST_ERR usage from
 rtnetlink/netdevice
In-Reply-To: <YMirQoiYRYsDP7Sb@yuki>
References: <20210615074045.23974-1-rpalethorpe@suse.com>
 <20210615074045.23974-3-rpalethorpe@suse.com> <YMirQoiYRYsDP7Sb@yuki>
Message-ID: <87czsk51fc.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> The test author is guaranteed that the library will not set TST_ERR
>> except via the TEST macro and similar.
>> 
>> Currently the rtnetlink & netdevice API returns 0 on fail and 1 on
>> success. Either TST_ERR or errno is used to store the error
>> number. The commit stays with this scheme except that we only use
>> errno. This means that we have to temporarily save errno when it would
>> be overwritten by a less important operation.
>
> I do not like this fix. If nothing else it's fragile and would make any
> patch review for these libraries much harder.
>
> I would prefer having these functions modified to return the errors
> instead even if I have to do the work.

I think there are some other issues here as well. Like the macros are
not prefixed with SAFE_. A lot of the functions are not used or they are
just used internally, but are not marked as static.

I guess there are more tests on the way that use these
functions. However it is difficult to update the API, if you don't know
how it will be used. I like to have a concrete usecase for what I am
working on, especially if it's not code I have a lot of vision for.

I'd prefer to remove the stuff which is unused before making significant
changes to the library. Also mark internal functions as static and
remove the headers.

Also, it seems the problem functions are actually internal and not used
by the test. If they are marked static, then I don't see any problem
with them being inconsistent with the public API.

This may create more work for Martin, but any sweeping changes made by
myself or Cyril will probably break any WIP tests and need to be
changed.

-- 
Thank you,
Richard.
