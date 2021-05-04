From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 4 May 2021 15:08:59 +0200
Subject: [LTP] [PATCH 1/1] docparse: Make tags in table clickable
In-Reply-To: <YJE4J0gMjhTfsNCO@yuki>
References: <20210503150415.18835-1-pvorel@suse.cz>
 <YJE4J0gMjhTfsNCO@yuki>
Message-ID: <YJFHa4o/aXGvmZE0@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > linked to the section.

> Looks good, acked.


> Btw, when I was looking at the page today I noticed that in the tags
> table the tag points to the git/CVE page and not the actuall hash or ID.
> I would expect that linux-git would be normal text and the commit id
> would link to the kernel.org repo, and same for the CVE...

Well, no problem, but I'd prefer for commits to move the hash to the text, e.g.

from:
|linux-git-fbe0e839d1e2 | futex: Prevent overflow by strengthen input validation|
to:
|linux-git | fbe0e839d1e2 ("futex: Prevent overflow by strengthen input validation")|

I'll send v2 where I'll implement it and as a second commit I'll change "CVE"
and "linux-git" (and others) pointing to tags metadata.html#tags.

And as TODO I should divide .tags into subsections containing list of actual tag
values (e.g. list of CVE, linux-git (and others)) and point these links to these
sections.

Thanks for your time!

Kind regards,
Petr
