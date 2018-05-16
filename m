From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 May 2018 11:26:31 +0200
Subject: [LTP] Want to contribute
In-Reply-To: <CAMZxAxfkgSZqVeCrXbCHbuqKYvqwaMbiDuFmNNJAaHWzf9JY=g@mail.gmail.com>
References: <CAMZxAxcE7deAzonfmhX9YMWSy7sRgHCn3=oC_zaEi6KVBYMd=w@mail.gmail.com>
 <20180503081520.GA29568@rei>
 <CAMZxAxfkgSZqVeCrXbCHbuqKYvqwaMbiDuFmNNJAaHWzf9JY=g@mail.gmail.com>
Message-ID: <20180516092631.GA17817@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Also what kind of contribution do you have in mind? Do you plan to work
> > on some specific area, or are you looking for a LTP TODO list?
> >
> I am interested in POSIX Test Suite for NetBSD.

The Open Posix Testsuite should, in theory, work on any POSIX system,
however I doubt that anyone is actively using it on anything else than
Linux, at least I do not remeber any activity on mailing list that would
suggets so.

So it would be nice if you tried to run it on NetBSD, looked into
failures and send patches so that it works fine on BSD too.

> Also, I am open to any suggestion and will be working on LTP TODO
> list.

As you may noticed I've started to fill in the GitHub Issue tracker with
our todo items, feel free to pick from there :-).

-- 
Cyril Hrubis
chrubis@suse.cz
