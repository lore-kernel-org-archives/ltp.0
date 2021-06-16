From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Jun 2021 15:22:22 +0200
Subject: [LTP] [PATCH] typo: Add necessary spaces in the outputs
In-Reply-To: <147203f7-eccc-09fb-4dd5-7083881fe84b@huawei.com>
References: <20210518064506.203781-1-xieziyao@huawei.com>
 <CAEemH2en6C3dUzspuVwNVmRiUeBQWK38bLPT7+ZwErVFQG+i-w@mail.gmail.com>
 <YKXtvaeckoJ2HJzJ@pevik>
 <730f190e-4baa-f854-2c5e-8c6b9d4267df@huawei.com>
 <YMniMEyDjhCLcx8g@pevik>
 <147203f7-eccc-09fb-4dd5-7083881fe84b@huawei.com>
Message-ID: <YMn7Doe2ApgjET5r@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ziyao,

...
> > But I'm ok to merge it without.

> Thanks, by the way, would you mind fixing this while you merge?

> It's also fine that I send v2 patch later to fix the problem.
I fixed the most obvious lines, concentrating on tests which use new API and
merged.

open posix tests produce a lot of checkpatch.pl warnings anyway => do not waste
time on details. And some fanotify / inotify tests which are up to date use
traditional formatting which splits lines => replacing it now.

> Thanks for your review.
Thanks for your time.

Kind regards,
Petr

> Kind Regards,
> Ziyao
