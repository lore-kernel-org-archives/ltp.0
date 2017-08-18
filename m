From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 18 Aug 2017 06:00:54 -0400 (EDT)
Subject: [LTP] [PATCH 2/2] [RFC] syscalls/mmap12: Do not fail on
 non-present	pages
In-Reply-To: <20170817143310.11634-2-chrubis@suse.cz>
References: <20170817143310.11634-1-chrubis@suse.cz>
 <20170817143310.11634-2-chrubis@suse.cz>
Message-ID: <1932775025.3810596.1503050454745.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> There are two problems with the testcase:
> 
> 1. MAP_POPULATE is best effort operation.
> 
>    To quote Michal Hocko:
> 
>    "The semantic of MAP_POPULATE is rather vague and allows for nuances
>    in future."
> 
> 2. There is no guarantee that the pages will be present even if
>    MAP_POPULATE caused read-ahead.
> 
>    To quote Michal again:
> 
>    "Ptes can be made !present, reclaimed or who knows what else in
>    future yet that won't qualify as a regression. I find such a test
>    questionable at best."

Hi,

I agree with points 1 and 2, the test relies on likely
scenario that pages were present. We are in similar
situation when it comes to readahead test.

@Michal: Can you think of alternative way to differentiate between:
"MAP_POPULATE did its best" vs. "MAP_POPULATE is broken"?

> 
> I still think that calling mmap() with MAP_POPULATE and checking that
> the mapping is OK is a valid testcase itself, so instead of passing the
> test on present pages we simply check that the mapping is zero-filled
> (since we mapped empty file). I kept the page-present check still there
> but it now produces only INFO messages, it could be removed though if
> everyone agrees that it has no real value.

Agreed, we should have at least test that uses the flag - so we can
tell it didn't have negative impact (Oops/non-zero values mapped/etc).

Regards,
Jan
