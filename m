From: Sandeep Patil <sspatil@google.com>
Date: Mon, 6 Nov 2017 10:37:10 -0800
Subject: [LTP] [PATCH] android: io/diotest4: remove dependency on
	<sys/shm.h>
In-Reply-To: <20171026081654.GA3873@rei>
References: <20170919232713.57314-1-sspatil@google.com>
 <20171011121505.GA12177@rei>
 <20171018054923.GJ21774@sspatil-macbookpro.roam.corp.google.com>
 <20171026081654.GA3873@rei>
Message-ID: <CAJNQT8EjAL+Su+MSAy1a9_sBUmEKDqOQg2CBh6N15nim_4ABJw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Oct 26, 2017 at 1:16 AM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Thank you very much for the history. I guess I can make this change under
> > __BIONIC__ check (like some of the other tests) and that should work
> fine ..
>
> Or we may as well fix this in a clean way and once for all. What about
> adding a constant to include/lapi/mmap.h something as MMAP_GRANULARITY
> and defining it to SHMLBA if the shm headers are present and to
> getpagesize() if they are not?
>
>
Ah, that sounds even better. Amending my patch to make it that
way now.

- ssp



> --
> Cyril Hrubis
> chrubis@suse.cz
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20171106/71bf63dd/attachment.html>
