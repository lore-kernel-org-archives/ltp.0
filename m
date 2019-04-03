From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Apr 2019 14:06:53 +0200
Subject: [LTP] [RFC PATCH 1/4] syscalls/abort01: convert to new library
In-Reply-To: <20190328040730.GE5826@google.com>
References: <20190325232012.67123-1-sspatil@android.com>
 <20190325232012.67123-2-sspatil@android.com>
 <20190326115825.GA32549@rei.lan> <20190326124743.GC5826@google.com>
 <20190326125132.GA11086@rei.lan> <20190328040730.GE5826@google.com>
Message-ID: <20190403120653.GC13658@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > I am surprised that didn't throw a warning + build error for me.
> > > other than that, thanks for doing this
> > 
> > That depends on gcc version and mix of warning flags...
> 
> clang actually throws a lot of warnings for us when we build it natively for
> Android. In this case however, I just used my laptop "gcc (Debian 7.3.0-5)"
> and default flags for LTP builds.
> 
> Do you have plans of enabling -Werror?

We cannot do that with the amount of legacy code we have the build would
fail pretty much every time. So no, no plans for the foreseeable future.

-- 
Cyril Hrubis
chrubis@suse.cz
