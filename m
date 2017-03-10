From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 10 Mar 2017 12:02:35 +0100
Subject: [LTP] [PATCH 1/1] gitignore: add gitignore for posix and
 realtime test suites
In-Reply-To: <20170310090835.lbjdaafryt5zoti5@dell5510>
References: <20170308165105.3981-1-pvorel@suse.cz>
 <20170309160313.GA17980@rei.lan>
 <20170310090835.lbjdaafryt5zoti5@dell5510>
Message-ID: <20170310110235.GA24807@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > There a few empty files added there, can you fix that? Otherwise it
> > looks fine.
> I'm blind, I cannot see any empty .gitignore file in the patch. Which one, please?

Looks like I was blind yesterday evening. I cannot find it now, sorry.

> I need to create v2 anyway, as I'd like to add tags into .gitignore (I suppose, we all use
> ctags).

I use 'git grep' most of the time as I'm too lazy to configure that :-).

I guess that ctags could be easily added just to the top level
.gitignore and we can do that in a separate patch. Then I could just
apply the patch you have send as it is.

-- 
Cyril Hrubis
chrubis@suse.cz
